Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F94CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 09:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1047983253;
	Wed, 10 Sep 2025 11:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B49F183236; Wed, 10 Sep 2025 11:23:43 +0200 (CEST)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by phobos.denx.de (Postfix) with ESMTP id 09BF6831D5
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 11:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hayashi.kunihiko@socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 10 Sep 2025 18:23:35 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
 by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id A8BBC2069FC4;
 Wed, 10 Sep 2025 18:23:35 +0900 (JST)
Received: from kinkan3.css.socionext.com ([172.31.9.51]) by m-FILTER with
 ESMTP; Wed, 10 Sep 2025 18:23:35 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
 by kinkan3.css.socionext.com (Postfix) with ESMTP id 1EF341757;
 Wed, 10 Sep 2025 18:23:35 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: u-boot@lists.denx.de
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tom Rini <trini@konsulko.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/2] configs: qemu-sbsa: Define GIC register base address
Date: Wed, 10 Sep 2025 18:23:26 +0900
Message-Id: <20250910092327.279749-2-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910092327.279749-1-hayashi.kunihiko@socionext.com>
References: <20250910092327.279749-1-hayashi.kunihiko@socionext.com>
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

If GICV3 is enabled, GICD_BASE and GICR_BASE are needed at
arch/arm/cpu/armv8/start.S.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 include/configs/qemu-sbsa.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/configs/qemu-sbsa.h b/include/configs/qemu-sbsa.h
index aff78160e12a..669d0fe7c58b 100644
--- a/include/configs/qemu-sbsa.h
+++ b/include/configs/qemu-sbsa.h
@@ -86,4 +86,8 @@
 #define CFG_SYS_INIT_RAM_ADDR		SBSA_MEM_BASE_ADDR
 #define CFG_SYS_INIT_RAM_SIZE		0x1000000
 
+/* Generic Interrupt Controller Definitions */
+#define GICD_BASE			SBSA_GIC_DIST_BASE_ADDR
+#define GICR_BASE			SBSA_GIC_REDIST_BASE_ADDR
+
 #endif /* __CONFIG_H */
-- 
2.34.1

