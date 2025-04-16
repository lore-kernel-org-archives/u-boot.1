Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A89FC369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 09:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88AAE82D6C;
	Wed, 16 Apr 2025 11:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744794273;
	bh=0oS15pvv2REx9R3NkDRw45mk5N6IA1HQhUZmpsoJ2Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KI0I4If0uNWGoXeyo4KB5DOmOSXJtJoLEsXsD39pojJji6X42G1iGhFX3Tq83E3V9
	 Kf/TUyc644tSFWl6UHEygzber5/SEfheFL2inGLGkO+FMyrIvmvuuJeO4pIZnZu68L
	 jCjd3tG3JB1XEPGC06OEIN8K2bQKtL9i/cwCEY/hlLVCeE2VYiKnvZtmn1+JzeFgQL
	 j4HtaMA7bXqxUCbXoxtLxwy+RULcmvbNQSDHLDpMmCU0YB8l3I8KoNiZJsBpvhawUT
	 nHwX/7/X3i9x9oRKzU7KvG98umKfnlYpPqVzm7bAlJI9RhM7OKEz20MS7is5mLBVOG
	 5eOURbJ9ncTtg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F7F981F45; Wed, 16 Apr 2025 11:04:32 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0515482D43
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 11:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="RXwqDH7Y"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E56311039EF2F; 
 Wed, 16 Apr 2025 11:04:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744794269; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=0oS15pvv2REx9R3NkDRw45mk5N6IA1HQhUZmpsoJ2Lw=;
 b=RXwqDH7Yf4iSBFeDLDhvbMrnouu8gaqVzCjCajj4XG4uXdOGAayz+CVECQmdDMGY4vE2Z2
 JapA6HYxCa7dIkrtHXg57NL/55Bg61JDWXDdKj4aCsFNQZRRan+aPpYcMpYTI3a+kCgHMe
 aTMJogJOBPRNczaL7G9KN4vX1uyTs9/jWRGIP5MPBAWUTzZVZzsUeNj9PL64Gw+YQBx4J7
 JERHp0ynLbqxtlV9LLy0r1Z7R5HkzTmOCs7n1WLuCQhFCnTTKf61jBIl15qdYfTIgn2+mu
 dVCBtUFJOoo/2CA+jpQBQJdXEZ17UQrLdizWAwpSP6Mbg9n4WNi1aDBMDga6eA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Heiko Schocher <hs@denx.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 3/3] siemens: capricorn: add ahab command and enable
 watchdog
Date: Wed, 16 Apr 2025 11:04:19 +0200
Message-Id: <20250416090419.54781-4-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250416090419.54781-1-hs@denx.de>
References: <20250416090419.54781-1-hs@denx.de>
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

Handle watchdog in U-Boot to fix CI.

Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
Signed-off-by: Heiko Schocher <hs@denx.de>
---

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

