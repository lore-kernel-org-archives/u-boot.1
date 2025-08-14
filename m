Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5B4CA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 16:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21F26839D7;
	Thu, 14 Aug 2025 18:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="D9Vn/hVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC9E6839E2; Thu, 14 Aug 2025 18:40:26 +0200 (CEST)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81C95839C7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 18:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremie.dautheribes@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 91B6043191;
 Thu, 14 Aug 2025 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1755189623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3JMolT1Hsk3PbboIN817XRvk+wps7PBXcp+QH8B1I/I=;
 b=D9Vn/hVhruNijiuG/jhRB5A3ynFw1vaLF7F6Mi+1LOsavliwVmUe9Ew2AL8Qkicj2sQiW2
 Z61oZ+WHdAzaKjogfgmiFsu1rtDBZNZSJ2XexLKchUA6c0JDApbsHrL+y1exywxNmIC9vK
 mDfszsi4OH/Qv/CQD/egi8+/Oio/MRJJBf+ur8rorEItZkDUInxwHvBowiRMzRJV4khXrF
 ePKiDrbG2l0qmfxYni5YECTlj0LeHLD/msAANx12hPQeQk67EAUi5J8MIZbYYaUTPQrDgv
 8idooB+/+TKMngQp4TWSBD7po7kJgTqQoZOSMduIDNi4QS2N1xivQFtppt2/dA==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?=
 <jeremie.dautheribes@bootlin.com>
To: Stefano Babic <sbabic@nabladev.com>,
	Fabio Estevam <festevam@gmail.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
Subject: [PATCH] imx: imx93_evk: Fix conflict SPL early malloc address
Date: Thu, 14 Aug 2025 18:39:26 +0200
Message-ID: <20250814163926.1205901-1-jeremie.dautheribes@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeduheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomheplforrhormhhivgcuffgruhhthhgvrhhisggvshcuoehjvghrvghmihgvrdgurghuthhhvghrihgsvghssegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeetleektdfgheetfedtffegjeduuefgveelkeekueeffedvvdfhieettedtffehhfenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepgihpshdrrddpmhgrihhlfhhrohhmpehjvghrvghmihgvrdgurghuthhhvghrihgsvghssegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepshgsrggsihgtsehnrggslhgruggvvhdrtghomhdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehusghoohhtqdhimhigsehngihprdgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnr
 dgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehjvghrvghmihgvrdgurghuthhhvghrihgsvghssegsohhothhlihhnrdgtohhm
X-GND-Sasl: jeremie.dautheribes@bootlin.com
X-Mailman-Approved-At: Thu, 14 Aug 2025 18:46:17 +0200
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

Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
---
 include/configs/imx93_evk.h | 4 ----
 1 file changed, 4 deletions(-)

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
-- 
2.43.0

