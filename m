Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D0EC0218F
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 23:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8340F80FD1;
	Mon, 27 Jan 2025 00:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wfOwcLkP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8159D80FED; Mon, 27 Jan 2025 00:49:04 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13B0E80FEC
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 00:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ca7d=UT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1737935340; bh=HIE/tJYXMgkn2dPrxy+/VgBorywx2rAN7oB6/5s6WmA=;
 b=wfOwcLkPJNFgqp9QP6Bw0d+YfH+YYDBLXaSi0c1uF3SETrbtcpQg4GdpgRhhbFJcDvoOGTKlg
 G35w77SEtbSdAGBu38aRwkfw1FKxEDeESNanrJWS3xkgoRfVJWTUM++fHnO4T3ueNCT2Tn9wc11
 Q/4Shgff3sQ8VatSAflcH39tmddgOfhCSnqZyTG4s3y/3VJ9z2HV87+Ja3SGqvRITQPktdfkzqN
 VRSGjLghwFxd3hAybaXr/h7Wg8MP4aDhhTtaGnInLoNMQkQ9nxOj+U6sZN+T1fwMU2KRAceKKtx
 WeFJ1xmXNFBnQjSzs67DtLHFnIIQuXKP0HNtoIwEl6PQ==
X-Forward-Email-ID: 6796c9e84079df9fc6c0dd70
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Alex Bee <knaerzche@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 4/5] rockchip: Move imply ROCKCHIP_EXTERNAL_TPL under SoC
 Kconfig symbol
Date: Sun, 26 Jan 2025 23:48:29 +0000
Message-ID: <20250126234838.561065-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250126234838.561065-1-jonas@kwiboo.se>
References: <20250126234838.561065-1-jonas@kwiboo.se>
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

New Rockchip SoCs will typically require use or an external TPL when
support for the SoC is added to U-Boot.

Move imply ROCKCHIP_EXTERNAL_TPL under SoC Kconfig symbol to remove a
future likelihood of a long "default y if" line.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index a71988485825..ef5ad72dd089 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -178,6 +178,7 @@ config ROCKCHIP_RK3308
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
+	imply ROCKCHIP_EXTERNAL_TPL
 	imply ROCKCHIP_OTP
 	imply SPL_CLK
 	imply SPL_DM_SEQ_ALIAS
@@ -340,6 +341,7 @@ config ROCKCHIP_RK3568
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
+	imply ROCKCHIP_EXTERNAL_TPL
 	imply ROCKCHIP_OTP
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
 	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
@@ -374,6 +376,7 @@ config ROCKCHIP_RK3588
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
+	imply ROCKCHIP_EXTERNAL_TPL
 	imply ROCKCHIP_OTP
 	imply SCMI_FIRMWARE
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
@@ -500,7 +503,6 @@ config TPL_ROCKCHIP_COMMON_BOARD
 
 config ROCKCHIP_EXTERNAL_TPL
 	bool "Use external TPL binary"
-	default y if ROCKCHIP_RK3308 || ROCKCHIP_RK3568 || ROCKCHIP_RK3588
 	help
 	  Some Rockchip SoCs require an external TPL to initialize DRAM.
 	  Enable this option and build with ROCKCHIP_TPL=/path/to/ddr.bin to
-- 
2.48.1

