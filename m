Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C73BCD610D
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 16:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44DB886DC3;
	Mon,  9 Oct 2023 18:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2286A86DAF; Mon,  9 Oct 2023 18:47:31 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id B36CC86DE4
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 18:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,210,1694703600"; d="scan'208";a="182438624"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 10 Oct 2023 01:47:28 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.229])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id EE0D3402A8DA;
 Tue, 10 Oct 2023 01:47:25 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Simon Glass <sjg@chromium.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH v2 09/19] cmd: gpio: Skip output on -ENOENT
Date: Mon,  9 Oct 2023 17:46:35 +0100
Message-Id: <20231009164645.164464-10-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On the Renesas RZ/G2L SoC family, valid GPIO numbers are not contiguous.
This is determined by the device tree, where a fixed number of bits are
used for the 'pin' number within a 'port', even though not all ports
have the same number of pins. The device tree can't be changed here
without breaking backwards compatibility in Linux, which we don't want
to do.

To avoid printing a status for each of these invalid GPIO numbers when
a user executes `gpio status -a`, we allow gpio_get_function() to return
-ENOENT when the given offset does not refer to a valid GPIO pin and we
skip printing anything if this occurs.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
v1->v2:
  * New patch to simplify `gpio status -a` output.

 cmd/gpio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cmd/gpio.c b/cmd/gpio.c
index f4565982ecd9..a55d5970765b 100644
--- a/cmd/gpio.c
+++ b/cmd/gpio.c
@@ -17,6 +17,7 @@
 #endif
 #include <asm/gpio.h>
 #include <linux/err.h>
+#include <dm/device_compat.h>
 
 __weak int name_to_gpio(const char *name)
 {
@@ -69,6 +70,8 @@ static void gpio_get_description(struct udevice *dev, const char *bank_name,
 	printf("%s\n", buf);
 	return;
 err:
+	if (ret == -ENOENT)
+		return;
 	printf("Error %d\n", ret);
 }
 
-- 
2.39.2

