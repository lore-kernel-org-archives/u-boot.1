Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE6FC36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 15:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D19E482ACC;
	Sat,  5 Apr 2025 17:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qwGPB4eM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9D0F82ABB; Sat,  5 Apr 2025 17:38:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 674AE8215B
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 17:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5bca=WY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743867530; bh=ucA9LBWmeX8zsIYV7145ULqPBFUrDCvhZ3Hpt9un/y0=;
 b=qwGPB4eMHZZo7TNM7lliuS+YjjeJP4uozXRafEpRgUjIXqDDdsjXGlyXyo47EwpDBW8vUBiYi
 GsgdgnJ/dlyeKbuz6ugL88+G/98SJeBFmSI9liIT/u3KPLr0zGUJMTsb23d4x/qEmJV4VKRIwR3
 2ZqYDblWfdgehwuZL0uovDZLkb0L41asbGXoupGT4pcy0BeJlEa9PQD8soEve0aPT6B5Kynu8W7
 oUTentjhtep0NKcFCOsUpYMxz37+3wyGsoyjBtQEuc/R1Chr5CEftWkzrocwY2XoFXMH4U590ED
 JEuuywrjGNfpfuRSN5WSUCAL1a/l1JhtwWSvM6juzyDw==
X-Forward-Email-ID: 67f14e883dc50e09d12388fc
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Arnaud Patard <arnaud.patard@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/4] rockchip: Enable RAM boot using ROCKCHIP_MASKROM_IMAGE
Date: Sat,  5 Apr 2025 15:38:23 +0000
Message-ID: <20250405153832.1427549-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250405153832.1427549-1-jonas@kwiboo.se>
References: <20250405153832.1427549-1-jonas@kwiboo.se>
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

Imply ROCKCHIP_MASKROM_IMAGE to build maskrom RAM boot images for
RK3308, RK3328, RK3399, RK356x and RK3588.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Arnaud Patard <arnaud.patard@collabora.com>
---
v2: Collect t-b tag

These are SoCs that have fully migrated to COMMON_STACK_ADDR and that
I have been able to runtime test maskrom RAM boot on.

An alternative approach could be to add a rockchip_ramboot.config that
enables the ROCKCHIP_MASKROM_IMAGE Kconfig symbol.
---
 arch/arm/mach-rockchip/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index e817bf46e565..f349431bb43c 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -180,6 +180,7 @@ config ROCKCHIP_RK3308
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_EXTERNAL_TPL
+	imply ROCKCHIP_MASKROM_IMAGE
 	imply ROCKCHIP_OTP
 	imply SPL_CLK
 	imply SPL_DM_SEQ_ALIAS
@@ -213,6 +214,7 @@ config ROCKCHIP_RK3328
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_EFUSE
+	imply ROCKCHIP_MASKROM_IMAGE
 	imply ROCKCHIP_SDRAM_COMMON
 	imply SPL_ROCKCHIP_COMMON_BOARD
 	imply SPL_SEPARATE_BSS
@@ -293,6 +295,7 @@ config ROCKCHIP_RK3399
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_EFUSE
+	imply ROCKCHIP_MASKROM_IMAGE
 	imply ROCKCHIP_SDRAM_COMMON
 	imply SPL_DM_SEQ_ALIAS
 	imply SPL_FIT_SIGNATURE
@@ -343,6 +346,7 @@ config ROCKCHIP_RK3568
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_EXTERNAL_TPL
+	imply ROCKCHIP_MASKROM_IMAGE
 	imply ROCKCHIP_OTP
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
 	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
@@ -378,6 +382,7 @@ config ROCKCHIP_RK3588
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_EXTERNAL_TPL
+	imply ROCKCHIP_MASKROM_IMAGE
 	imply ROCKCHIP_OTP
 	imply SCMI_FIRMWARE
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
-- 
2.49.0

