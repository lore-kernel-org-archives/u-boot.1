Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D72CCA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 13:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E12582E34;
	Wed, 20 Aug 2025 15:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="EPv1JSsJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CD0482F03; Wed, 20 Aug 2025 15:09:09 +0200 (CEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::226])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C62E82B07
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 15:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremie.dautheribes@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 771F343972;
 Wed, 20 Aug 2025 13:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1755695341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LWH2GUXr6O9sxyhnErCcLDNKNBgFVnbAKeLaj8FTb/k=;
 b=EPv1JSsJJbOhDAq05J7ZWY011jk7ZzofXG8lD0L0MnMWuW6mlBlQk6qGqUyViweE3UylaR
 j8tdl5OXa7khxYnnjbfEW7HICqkb/3ALt4Q51qWZxwZXmOvoXgWPwAn3XAJsFCGdeHOo4P
 mCseZhr/eh8nvbB095pKvkEbGPrCOwnozNAQs2WY8QnD23DPUOe/RPRT8V9gmK5YAwfNn8
 lmeTfwQnV1AFpFhOfZCxeQS0yL7NQ3A8UrGODryXHDHSeYr+jE4Qd2RcNRUVrTYWVu5V9A
 QQ7k9K9M5UUTY3ggt9O66SXe6MALzaCn7jqBWBUM5+lp6VErmHfPOdYGUgGCww==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?=
 <jeremie.dautheribes@bootlin.com>
To: Stefano Babic <sbabic@nabladev.com>,
	Fabio Estevam <festevam@gmail.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
Subject: [PATCH v2] imx: imx93_{evk, frdm,
 qsb}: Fix conflict SPL early malloc address
Date: Wed, 20 Aug 2025 15:08:51 +0200
Message-ID: <20250820130851.1374226-1-jeremie.dautheribes@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekgeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomheplforrhormhhivgcuffgruhhthhgvrhhisggvshcuoehjvghrvghmihgvrdgurghuthhhvghrihgsvghssegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeetleektdfgheetfedtffegjeduuefgveelkeekueeffedvvdfhieettedtffehhfenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepgihpshdrrddpmhgrihhlfhhrohhmpehjvghrvghmihgvrdgurghuthhhvghrihgsvghssegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepshgsrggsihgtsehnrggslhgruggvvhdrtghomhdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehusghoohhtqdhimhigsehngihprdgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnr
 dgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehjvghrvghmihgvrdgurghuthhhvghrihgsvghssegsohhothhlihhnrdgtohhm
X-GND-Sasl: jeremie.dautheribes@bootlin.com
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

From: Ye Li <ye.li@nxp.com>

Because the early malloc pool size is set to 0x18000, so using this
start address may cause conflict with ATF, then corrupt the heap data.
So we delete the definition to use the default early malloc pool from
CONFIG_SPL_STACK to avoid any conflict

Signed-off-by: Ye Li <ye.li@nxp.com>

Cherry picked from nxp-imx/uboot-imx commit
1ba675df122627a19debe1d807877052705372c6

Jérémie Dautheribes: applied the same patch to the frdm and qsb
imx93-based boards
Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
---

Changes in v2:
	- applied the patch to the frdm and qsb imx93-based boards which
	can face the same issue as suggested by Fabio

 include/configs/imx93_evk.h  | 4 ----
 include/configs/imx93_frdm.h | 4 ----
 include/configs/imx93_qsb.h  | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/include/configs/imx93_evk.h b/include/configs/imx93_evk.h
index e7db0161126..ffd72a38bcb 100644
--- a/include/configs/imx93_evk.h
+++ b/include/configs/imx93_evk.h
@@ -11,10 +11,6 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_XPL_BUILD
-#define CFG_MALLOC_F_ADDR		0x204D0000
-#endif
-
 #ifdef CONFIG_ENV_MMC_DEVICE_INDEX
 #define IMX93_EVK_MMC_ENV_DEV CONFIG_ENV_MMC_DEVICE_INDEX
 #else
diff --git a/include/configs/imx93_frdm.h b/include/configs/imx93_frdm.h
index 987fcacb999..c98c10774cb 100644
--- a/include/configs/imx93_frdm.h
+++ b/include/configs/imx93_frdm.h
@@ -11,10 +11,6 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_XPL_BUILD
-#define CFG_MALLOC_F_ADDR		0x204D0000
-#endif
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR		0x80000000
diff --git a/include/configs/imx93_qsb.h b/include/configs/imx93_qsb.h
index 5ddc191d17c..a7b94f7ab57 100644
--- a/include/configs/imx93_qsb.h
+++ b/include/configs/imx93_qsb.h
@@ -9,10 +9,6 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
-#define CFG_MALLOC_F_ADDR	0x204D0000
-#endif
-
 #define CFG_SYS_INIT_RAM_ADDR	0x80000000
 #define CFG_SYS_INIT_RAM_SIZE	0x200000
 
-- 
2.43.0

