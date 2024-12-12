Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699C2E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 23:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5023680219;
	Fri, 13 Dec 2024 00:58:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="cFfQ56tq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E71380219; Fri, 13 Dec 2024 00:58:31 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D62B801BA
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 00:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734047905; bh=as7xuOprTBtVDArPYh4dXDtf/zAsDsSTwKdxyCO374w=;
 b=cFfQ56tqwhLsfxOMC/DfHPmWAIGoY0GooS9xbenJ/zGcxGtbZtIhk7uohHO1Blt+/HSGDBKub
 tjAO2QvAph5KNhJ5qShqLi5GzbyNHkY1YmDf4xPMy5f5rPB/kLe0wO/LYQXGvI7Mf7GVQY9K9r0
 VBcM1mxHJmFUcejVEiAwOn2kC+YjYpIVJ2Iab1ZenoxMZRTKvldZeCZzMFOI9k5R25Js/rKBLwd
 8AvP41fbqTHRGDpOij047tsSKtfUu+05eylsNzF7qJDE3dLcdUBDsgHCkwwYxXWxBtOpysKmC9d
 hP456w+bECu7OWXhEFxeUmCllp4YnviuzY11c0OS1qfw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 10/12] rockchip: rk3399-gru: Use SDMA mode to read from eMMC
Date: Thu, 12 Dec 2024 23:57:17 +0000
Message-ID: <20241212235735.164272-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212235735.164272-1-jonas@kwiboo.se>
References: <20241212235735.164272-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675b78a0a511ed8f0b3fe36b
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

Enable use of SDMA mode when reading from eMMC to speed up boot.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/chromebook_bob_defconfig   | 1 +
 configs/chromebook_kevin_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index 9a0f7cf8236a..af9df4700e35 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -63,6 +63,7 @@ CONFIG_MMC_PWRSEQ=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index d70ec74f7f87..cc51722b521b 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -64,6 +64,7 @@ CONFIG_MMC_PWRSEQ=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
-- 
2.47.1

