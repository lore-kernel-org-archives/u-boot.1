Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431A0D185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AF8C841D6;
	Thu,  8 Jan 2026 14:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="EV9zef2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A46284189; Thu,  8 Jan 2026 14:36:27 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5F6884172
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 14:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d19=7O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1767879383; bh=ZBDJaoli2hm7wTMgfYbG9GALkTIoMg8WXOSzZhb7qnQ=;
 b=EV9zef2P+h4GQC/gCV/LqwUQ1OHpJXMUK5LW6xWL4X4uKHlitV34meHWnXw0Fam0WB0x283PB
 XP5GnqXzt7sgI5AlTXlBd5iWtYS6QsOJI7Ynm61hPhiH/XpwPMo/LYPGb9yJmgol1LtCtsATO1I
 IDWhkAd1FlJ53pu836r2CKRAPXiiLVOpwOTLOGiNj/reU8sBiMdFnkdCbriqCNGnyVI85H8CelB
 L1PbP+bihj5uwwuRDnD5u/6lWcEhn4rwixRf7CLTlM2bu6LhBozPsjPacwczl3msO2LMWb1iXSi
 odH8BuNDp4RHWDTf3WM4qrs2kNgPGQ3h8/QnAkqtqbTA==
X-Forward-Email-ID: 695fb2d32b5f20405ba817ec
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.2.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Alexey Charkov <alchark@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/2] rockchip: rk3576: Use DMA when loading FIT images
Date: Thu,  8 Jan 2026 13:32:30 +0000
Message-ID: <20260108133234.4001390-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108133234.4001390-1-jonas@kwiboo.se>
References: <20260108133234.4001390-1-jonas@kwiboo.se>
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

Enable use of DMA when loading FIT images from eMMC, SD-card and SPI
flash now that access to PMU_SRAM for non-secure masters is allowed.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3576-u-boot.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
index dc3771b556a3..018c9cc8d696 100644
--- a/arch/arm/dts/rk3576-u-boot.dtsi
+++ b/arch/arm/dts/rk3576-u-boot.dtsi
@@ -118,13 +118,11 @@
 &sdhci {
 	bootph-pre-ram;
 	bootph-some-ram;
-	u-boot,spl-fifo-mode;
 };
 
 &sdmmc {
 	bootph-pre-ram;
 	bootph-some-ram;
-	u-boot,spl-fifo-mode;
 };
 
 &sdmmc0_bus4 {
@@ -154,12 +152,10 @@
 
 &sfc0 {
 	bootph-some-ram;
-	u-boot,spl-sfc-no-dma;
 };
 
 &sfc1 {
 	bootph-some-ram;
-	u-boot,spl-sfc-no-dma;
 };
 
 &sys_grf {
-- 
2.52.0

