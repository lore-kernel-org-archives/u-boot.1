Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC52AC4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 20:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42DA9882F5;
	Sun, 21 Apr 2024 22:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="KbwVXn38";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0654876D3; Sun, 21 Apr 2024 22:09:45 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16F2688313
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 22:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713730169; bh=ZzKbvFE7Fj2ZuFL0VWi8UCMIv2Hl8QFD/UHv5WKwoew=;
 b=KbwVXn38LtCnzOwhnTVoo90hNyFPwaw3Qeo7bLhFK7UW+mNPunfTERYoysecQHZ6L5aqEqgwz
 cgPAgq6j9Q5IYaZASfkjA07/+wWVV2xfJqK1EHsOII3XKHPydeCVVmt0hq7PamUWp1UJ/Qs78cN
 u8BExwhr3oPC0ZMQ3O7Y4udUBW6SqByiBEyKtxdCp8wBbDccMl1rtBZ9F98c1kuAwE08YxfepRc
 vFnGkZw8aY8YV9nwouEMIeIzZEgI6Nzz767i765PO7ayt6c3UiHYqNw7U0eR2aNUHR5Hr8Usjgq
 vGShKX1PeJewNIPCweU2zVde9/+VUtr8vizfdEvBA9WA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/3] rockchip: rk3328: Enable ARMv8 crypto extensions
Date: Sun, 21 Apr 2024 20:09:02 +0000
Message-ID: <20240421200908.518855-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240421200908.518855-1-jonas@kwiboo.se>
References: <20240421200908.518855-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 662572779034f686f09c1618
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
v2: No change, rebase on latest master bransh
---
 arch/arm/mach-rockchip/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index ee0f338995b9..651ecfe9b8fd 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -180,8 +180,11 @@ config ROCKCHIP_RK3328
 	select SUPPORT_TPL
 	select TPL
 	select TPL_NEEDS_SEPARATE_STACK if TPL
+	imply ARMV8_CRYPTO
+	imply ARMV8_SET_SMPEN
 	imply MISC
 	imply MISC_INIT_R
+	imply OF_LIVE
 	imply PRE_CONSOLE_BUFFER
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_EFUSE
-- 
2.43.2

