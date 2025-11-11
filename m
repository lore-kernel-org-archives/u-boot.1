Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE75CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 07:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B63AB83B27;
	Tue, 11 Nov 2025 08:18:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="FWw8LqHI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E622F83EF8; Tue, 11 Nov 2025 08:18:41 +0100 (CET)
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch
 [84.16.66.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5573683B32
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 08:18:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d5HvL6z5yzqJG;
 Tue, 11 Nov 2025 08:18:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1762845518;
 bh=g/cwimaf4gz7bmFsA2OxRHUWAZ7Dv3nYadcMdbuUZfY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FWw8LqHIUfPW0r7ohYqZpsz9dX/DUdEYVl1x4zDA7v2Zs71lS9zaV1Se5eIviamFW
 qPdBcLGT5ufzkU6p948GCr7A3fKyeX4S/9QSRDxCYT3USlrmLuGUl64b8DDMKamj3E
 IAIycvFYS9RGgtCOeJLq/XBB0BAAiiwQzaoOLJmw=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d5HvL29WRzsv; Tue, 11 Nov 2025 08:18:38 +0100 (CET)
From: Philippe Schenker <dev@pschenker.ch>
To: u-boot@lists.denx.de
Cc: stefan@embear.ch, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Andrew Davis <afd@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Judith Mendez <jm@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v3 2/6] remoteproc: k3-r5: cast size to size_t6dd
Date: Tue, 11 Nov 2025 08:16:26 +0100
Message-ID: <20251111071756.1257488-3-dev@pschenker.ch>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111071756.1257488-1-dev@pschenker.ch>
References: <20251111071756.1257488-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

From: Philippe Schenker <philippe.schenker@impulsing.ch>

When compiling for R5 core with CONFIG_REMOTEPROC_TI_K3_R5F,
passing 'size' (ulong) to ti_secure_image_post_process() caused
a type mismatch compiler error.

On platforms where ulong and size_t differ in size, directly
casting could lead to out-of-bounds memory access. Fix by
introducing a size_t temporary variable, passing it to the
function, and writing back the potentially modified value for
use in subsequent calls.

Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
Acked-by: Andrew Davis <afd@ti.com>

---

Changes in v3:
- Assign size to a variable of type size_t before casting to make sure
  no memory is accessed out-of-bounds on any circumstance.
- Change this commit title and message accordingly.

Changes in v2:
- Added Andrew's Acked-by

 drivers/remoteproc/ti_k3_r5f_rproc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index c738607c1092..48ebdaf06931 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -315,6 +315,7 @@ static int k3_r5f_load(struct udevice *dev, ulong addr, ulong size)
 	bool mem_auto_init;
 	void *image_addr = (void *)addr;
 	int ret;
+	size_t size_img;
 
 	dev_dbg(dev, "%s addr = 0x%lx, size = 0x%lx\n", __func__, addr, size);
 
@@ -341,7 +342,9 @@ static int k3_r5f_load(struct udevice *dev, ulong addr, ulong size)
 
 	k3_r5f_init_tcm_memories(core, mem_auto_init);
 
-	ti_secure_image_post_process(&image_addr, &size);
+	size_img = size;
+	ti_secure_image_post_process(&image_addr, &size_img);
+	size = size_img;
 
 	ret = rproc_elf_load_image(dev, addr, size);
 	if (ret < 0) {
-- 
2.51.2

