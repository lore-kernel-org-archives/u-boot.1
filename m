Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0822C54E68
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 20:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0771187F88;
	Sun, 17 Mar 2024 21:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="SJwqvUNI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1494D87E87; Sun, 17 Mar 2024 21:49:51 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AFFB87F17
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 21:49:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2d81=KY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710708580; bh=XS72Y9syOhNwG6o+CwSm5ZTjHeEV2SvDaIFOAB12yds=;
 b=SJwqvUNIe85qJGlqW8sc3YQIoNVHmXMpbZP82oFlJRhdzCKeyQtmxuVKMb2+afRgZ7NddADn2
 pg5sze92BIrxWlSp+E5n7+4C0hFyl0QHZfLy+An6jZ8tPmJqmVFpy4DucAvyt4xOWMRetf3QHSG
 EK9IN7EjVe7kXOKT/s9vCmxJ+281yagJwWGWfuO3n5AmOatQnquYOxR8vst8PaxL7Tr5Go/afdv
 Y7mVOuFk7cMgNX+/KuyOGIzjspzLsEHCm5qw8qEpriohwUvXBsHUKA95SOTM/B335SKxWqC9Lh2
 mFZy6++V1oJ9bb7qLZnB+h2Ib6VpUWvUCLQVL+IN8ebQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/3] rockchip: rk3328: Enable ARMv8 crypto extensions
Date: Sun, 17 Mar 2024 20:49:16 +0000
Message-ID: <20240317204923.219908-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240317204923.219908-1-jonas@kwiboo.se>
References: <20240317204923.219908-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f7576231e1d1de6044096b
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

The RK3328 SoC support ARMv8 Cryptography Extensions and use of the
ARMv8 crypto extensions help speed up FIT checksum validation in SPL.

Imply ARMV8_SET_SMPEN and ARMV8_CRYPTO to take advantage of the crypto
extensions for SHA256 when validating checksum of FIT images.

Also imply OF_LIVE to help speed up init of U-Boot proper.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index b723c72f09c4..fee463e6d92f 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -191,8 +191,11 @@ config ROCKCHIP_RK3328
 	select SUPPORT_TPL
 	select TPL
 	select TPL_NEEDS_SEPARATE_STACK if TPL
+	imply ARMV8_CRYPTO
+	imply ARMV8_SET_SMPEN
 	imply MISC
 	imply MISC_INIT_R
+	imply OF_LIVE
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_EFUSE
 	imply ROCKCHIP_SDRAM_COMMON
-- 
2.43.2

