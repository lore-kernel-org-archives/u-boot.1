Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F876C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 10:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B28E870B4;
	Sun, 12 Nov 2023 11:28:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="nFCoapmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BB9687015; Sun, 12 Nov 2023 11:27:59 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED6C8708B
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 11:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=face=GZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1699784869; bh=BeD44iRZbYphytRdg3YFbt4kv2iqaFg6TpPKdIuckAw=;
 b=nFCoapmTmBnpyVH9FDQy8FtPdXS/Ny2e5liXfXoxllpd0OYmdZuoxa9XAOYOrj68pX3pKnTJU
 E+3vsfQGLFg6EO8TNdDZmd1I9m+NzkQ0gAu4s6pYOek99GVYcABajrkLd2iheo7KgED+2EepRp9
 Irl5JD48v/mYLn4QYwFSA9+brD7vipFMc56NME2utWqt9HAcF9JJWrmNv5kIgjxQaiZH0CIv30m
 I73ySiayr8IB+y25eS+Z+z4hlsCsuYe6LKpC+pdo0mopwX1lPWKMhGORQO/ecSZ70Sam/vCfNPT
 GOfDTsgfKm0oisO6Sts4+Ex779muNew6BNvNbvYwrI8A==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>
Cc: John Clark <inindev@gmail.com>, Slawomir Stepien <sst@poczta.fm>,
 u-boot@lists.denx.de
Subject: [PATCH 4/4] rockchip: rk3588s-orangepi-5: Build SPI image
Date: Sun, 12 Nov 2023 10:27:00 +0000
Message-ID: <20231112102705.1180714-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112102705.1180714-1-jonas@kwiboo.se>
References: <20231112102705.1180714-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6550a8a4120265b21fb31bbe
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

Enable building of the SPI image, u-boot-rockchip-spi.bin, now that we
know what bootsource id values BootRom use for SPI flash on RK3588.

Fixes: 28c5f941edf7 ("board: rockchip: Add Xunlong Orange Pi 5")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/orangepi-5-rk3588s_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/orangepi-5-rk3588s_defconfig b/configs/orangepi-5-rk3588s_defconfig
index feb45a53853b..1e33c832ec67 100644
--- a/configs/orangepi-5-rk3588s_defconfig
+++ b/configs/orangepi-5-rk3588s_defconfig
@@ -13,6 +13,7 @@ CONFIG_SF_DEFAULT_MODE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="rk3588s-orangepi-5"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK_R_ADDR=0x600000
 CONFIG_TARGET_EVB_RK3588=y
-- 
2.42.0

