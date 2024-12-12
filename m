Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D39E77182
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 23:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A45FD80288;
	Fri, 13 Dec 2024 00:58:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hlXNwLyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F86480245; Fri, 13 Dec 2024 00:58:32 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ED4C8022B
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 00:58:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734047902; bh=Zd+rE3vpwJQZwcurhDRFeF4x2WJ4Wxakk04Nl7QcqfM=;
 b=hlXNwLyOgyPmRt2rr5DOE7hIbuFPI1MQKYWr3tv5kVoEpmlAkBQzFTyFVJC3+vp7DTgFV9dOK
 aIDJy7Yei0jBipXfqBkZa34KBh+f7eKoVjiO/+vxGHmCgUFN65Mq9Xltwq0MvJrchqZtG6rnuka
 c3wQd2TzPuma4GODmwBfz05YtcmHhRB01gkY3vrcJAF0GkAQCA0DR5wDmCpTKR0Qo5d1pXq1dU7
 hKIGUTW+uhd/hACtZbXxNs3b3wld4Hg4G6O/4sQAijBfq1mwzzRw3hKlSo1hkqpcP7nd8X9WS3l
 ZsOse3UsuqKO27YV8sxf+QZV33dt9hW3u6p5/ivtg9nA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 09/12] rockchip: rk3399-gru: Enable dcache and signature
 validation in SPL
Date: Thu, 12 Dec 2024 23:57:16 +0000
Message-ID: <20241212235735.164272-10-jonas@kwiboo.se>
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
 207.246.76.47
X-ForwardEmail-ID: 675b789ca511ed8f0b3fe346
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

With TPL being used to init DRAM, SPL being used to load FIT and the
adjusted FIT payload offset it is now possible to increase the size
limit of SPL to 256 KB and enable uses of dcache and FIT signature
validation.

Drop SPL_SYS_DCACHE_OFF=y to enable use of dcache in SPL.

Drop SPL_FIT_SIGNATURE=n to enable signature validation of FIT in SPL.

Change SPL_MAX_SIZE to 256 KB now that payload offset has moved in SPI
and TF-A may be loaded to 0x40000 in DRAM.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/chromebook_bob_defconfig   | 4 +---
 configs/chromebook_kevin_defconfig | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index f13c4c1e7d63..9a0f7cf8236a 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
-CONFIG_SPL_SYS_DCACHE_OFF=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SPL_GPIO=y
@@ -19,7 +18,6 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_DEBUG_UART=y
-# CONFIG_SPL_FIT_SIGNATURE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-bob.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
@@ -27,7 +25,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
-CONFIG_SPL_MAX_SIZE=0x1e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_HANDOFF=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 7a2b8e70fe69..d70ec74f7f87 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
-CONFIG_SPL_SYS_DCACHE_OFF=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SPL_GPIO=y
@@ -20,7 +19,6 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_DEBUG_UART=y
-# CONFIG_SPL_FIT_SIGNATURE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-kevin.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
@@ -28,7 +26,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
-CONFIG_SPL_MAX_SIZE=0x1e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_HANDOFF=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-- 
2.47.1

