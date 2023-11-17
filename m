Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DBCC54FB9
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 23:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6194874D5;
	Sat, 18 Nov 2023 00:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="oKVSiKPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F52E874D5; Sat, 18 Nov 2023 00:25:11 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8630386F1F
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 00:25:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9f74=G7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1700263494; bh=7lZTkRYWlmbZ4o4kHceuYVSZSVIdhG9voFkmY7nk5vE=;
 b=oKVSiKPdtGr9CNWk0V+EpuSWhTw/UiNMpQYEAJCFnwARvGXtM2WXHyUMy03ZcnPEoU4jjDDFI
 FpwleK+2wmnw3pyaXlQZa2NQ6ZWbtF+3X9L6f/try3AK4YvIhgyTX7XOc3aaUBW45iXYLfpZCId
 6af9uJj8EfFIVh3HRpBrS9q1JH3YzaVSAl6pZ8ycZNExs1Fny8sjN+tJ43vVBCc9YgcjzGDP+1f
 yqm4oXHsXud9J9hfWOEZoMTQM3cYcTktsrSCv8AlIccStbPvqqcCngAs2I9k0Y4bkO3J+OxcUAd
 18RugVF9l/GyEHTUs5lJAQTaUFTB87vVC6KFEQvPwT+g==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark
 <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Slawomir Stepien <sst@poczta.fm>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: [PATCH v2 2/4] rockchip: rk3588-nanopc-t6: Build SPI image
Date: Fri, 17 Nov 2023 23:24:35 +0000
Message-ID: <20231117232442.1430276-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117232442.1430276-1-jonas@kwiboo.se>
References: <20231117232442.1430276-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6557f645943be35dca803c25
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

From: John Clark <inindev@gmail.com>

Enable building of the SPI image, u-boot-rockchip-spi.bin, now that we
know what bootsource id values BootRom use for SPI flash on RK3588.

Fixes: b0b8086898f8 ("board: rockchip: add FriendlyElec NanoPC-T6 rk3588 board")
Signed-off-by: John Clark <inindev@gmail.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- No change

 configs/nanopc-t6-rk3588_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk3588_defconfig
index 070399ce2a86..daa13a4ffff8 100644
--- a/configs/nanopc-t6-rk3588_defconfig
+++ b/configs/nanopc-t6-rk3588_defconfig
@@ -14,6 +14,7 @@ CONFIG_SF_DEFAULT_MODE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="rk3588-nanopc-t6"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK_R_ADDR=0x600000
 CONFIG_TARGET_NANOPCT6_RK3588=y
-- 
2.42.0

