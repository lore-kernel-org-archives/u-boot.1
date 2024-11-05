Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060AFD2B944
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B33B891FA;
	Tue,  5 Nov 2024 17:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="scbzvLKm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B32891EB; Tue,  5 Nov 2024 17:01:38 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7561C891D0
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730822487; bh=Anf1nt5Zriz6s3ZoiQI0xzGjXCZmg7WjIFTynMEb/3A=;
 b=scbzvLKmroeHGx95xOB6t+MWx5ofbUIwFD0jo7CaE2rUvkUwN5P+YlMr0cVeBxasRmpAj/mTP
 3XxZlMX+H7cTHah6hkNTkbdsG+gb2btt95fJfvhYQKLYbxaxwuN5goAUlQsu34K7Y6Xa3Fwqg4F
 ECimuiIagCGB0IYh7BUtd2q67TJv/QNMukgsHQ5+iGq4TSBIWP6o1vndWILdNUHDqtgi6tfE1H2
 0ffYA5zIKBpxTIgag6qgJzy/EEPLk3ThLywUsk63SkSIKdhJ02dswvWZeXmNT30vtVlIXVX31sG
 JSGSD6QHIswrdtMhsYhtjEVYQdIuqB96KEAf6dk//pxA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 07/13] rockchip: rk3288-tinker: Sync defconfig options from
 rk3288-tinker-s
Date: Tue,  5 Nov 2024 16:00:30 +0000
Message-ID: <20241105160054.1373319-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241105160054.1373319-1-jonas@kwiboo.se>
References: <20241105160054.1373319-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 672a4156ff3e144e4725e112
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

Add missing Kconfig options used by the rk3288-tinker-s variant.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/tinker-rk3288_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index 851c312d4db5..0c2fd573b67b 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -41,6 +41,7 @@ CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_BMP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_PMIC=y
@@ -92,8 +93,10 @@ CONFIG_USB_ETHER_SMSC95XX=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_VIDEO=y
+# CONFIG_VIDEO_BPP8 is not set
 CONFIG_DISPLAY=y
 CONFIG_VIDEO_ROCKCHIP=y
 CONFIG_DISPLAY_ROCKCHIP_HDMI=y
+CONFIG_CONSOLE_SCROLL_LINES=10
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_ERRNO_STR=y
-- 
2.46.2

