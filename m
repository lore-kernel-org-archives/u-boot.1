Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52C2C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 05:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF7128215B;
	Mon, 28 Apr 2025 07:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745818154;
	bh=v1ES+qwoQ/kMbXyBGX3zX8ChrvZmPS3b+NcK+Hy47EA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L9gtcU2RsbvMFhqxO4Izk1PdebP5ojj5J5kPPXztltQ6uVEYYHb4TsdBpO3mU1GGJ
	 duX8UJlsg3LiCDkygA3X5Ubr9vuR5b7nJvFLbBI7t7CJkcxzOJZS92cu3Pxxu4Vdv3
	 gktt6aCSJf5IiXcSWDGWNaN7u1YMVGdMIiOh3OEBfDbAXBMJLBTm60L/ny2Qfewxp4
	 T10WuWMs21Xv+gIf8OBBA8FV/fbdUK+dWTS3hrKx3N/Oae2Q6e5uCnGv4Ld10mMPBR
	 QTrAAdY4ZGbzowCDHtKWLHQbs0ay8StR7bblhx0TDbfMS6KXIjB76etBuxrsyUjYc0
	 vPFXbnLGhXY1w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B3EB820F6; Mon, 28 Apr 2025 07:29:12 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B15180BAD
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 07:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="NTCEBqzp"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3EED010298342; 
 Mon, 28 Apr 2025 07:29:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745818148; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=v1ES+qwoQ/kMbXyBGX3zX8ChrvZmPS3b+NcK+Hy47EA=;
 b=NTCEBqzpo9DTYpaI5CmWE99oKYxRXIEX/4282M6Y8867PNpOOfsjFRTvbevNSZZCSijhuk
 GOYYOXqAQ40YCJ6Uvcb+bqe8vTEWCX9v7Uaq3y6bdc5uU8VR37YO0VmiA6xdt78NbArKob
 SJNjXi82dpiLJlS8kn0f1KF0u4UtzDQugx6EZcC3c49zCBmE70NsmtD5Kj3FMqR3f0Iqxo
 6ObFD28DRsmXZ3Hs0+xUqtUu5scWQMjFf/rE/1Nhiu5APv4Dgck3fB6F4wW2jzmHuNDQcl
 mvMJuMhZBR9ll525xSA03d5lDxGEv/V+bXTUMFE+mmrXV8xHS5nkChQAXtH+CA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Heiko Schocher <hs@denx.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tomas Peterka <atheiste@seznam.cz>
Subject: [PATCH v2 3/5] siemens: capricorn: defconfig updates
Date: Mon, 28 Apr 2025 07:28:55 +0200
Message-Id: <20250428052858.100083-4-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250428052858.100083-1-hs@denx.de>
References: <20250428052858.100083-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Walter Schweizer <walter.schweizer@siemens.com>

add ahab command as secure boot is used on this boards,
and enable watchdog, so U-Boot triggers it.

Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
for respelling commit subject and  message:
Signed-off-by: Heiko Schocher <hs@denx.de>

---

Changes in v2:
- respelled commit subject and message as suggested
  from Fabio

 configs/imx8qxp_capricorn.config | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/imx8qxp_capricorn.config b/configs/imx8qxp_capricorn.config
index f59f2129d56..032cab63af8 100644
--- a/configs/imx8qxp_capricorn.config
+++ b/configs/imx8qxp_capricorn.config
@@ -16,6 +16,7 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_PART=2
 
 CONFIG_DM_GPIO=y
+CONFIG_AHAB_BOOT=y
 
 CONFIG_TARGET_CAPRICORN=y
 CONFIG_SPL_MMC=y
@@ -129,7 +130,7 @@ CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_SCU_THERMAL=y
-# CONFIG_WATCHDOG is not set
+CONFIG_WATCHDOG=y
 CONFIG_WDT=y
 CONFIG_WDT_SIEMENS_PMIC=y
 CONFIG_SPL_TINY_MEMSET=y
-- 
2.20.1

