Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0DBC87FC9
	for <u-boot@archiver.kernel.org>; Sat,  2 Aug 2025 22:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B59083CC7;
	Sun,  3 Aug 2025 00:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="b9TdW3Sl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6619683CC7; Sun,  3 Aug 2025 00:08:15 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDDA883C9F
 for <u-boot@lists.denx.de>; Sun,  3 Aug 2025 00:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=7e69=2P=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1754172490; bh=hKxNMUp7Cu2r91kUXygRPFN4l+Hxja52swEcoRinZ68=;
 b=b9TdW3SlBLK6UUi6lbHs9tAN5SYm6JHwOFoXisit73sRvcim6W1FCF4kkeZTA3RpNG6VcvoCS
 +te/ALI7yzE7qVNt7KeN4ExGQEKzHAYmQ8ptxJuo6kpvjg9C483cVkTUa6Z5od5xEeLc9Q7iCC1
 V7kYZ6DJ9+bxI3ps2Dqf3fZoOTAMfxe424LaXUpG18+m9JneiFnJiDQ/NKwhRcjLQdoKs6B+Use
 aOwrVqrTyWePnKlasGtrABQOGiOhazt+BmLs+3mxWJRJQ1OF0a5yzCuRFhFMK2I5HrG0osz/vFx
 HFBJLwmicdaxDxDQbF2NzQ/BhR7NKpeXe6xGoMQEejtQ==
X-Forward-Email-ID: 688e8c46056e3a070faf3610
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.8
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
Subject: [PATCH v3 4/4] HACK: rockchip: Add miniall.ini files to simplify test
 of RAM boot
Date: Sat,  2 Aug 2025 22:07:25 +0000
Message-ID: <20250802220738.3018910-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802220738.3018910-1-jonas@kwiboo.se>
References: <20250802220738.3018910-1-jonas@kwiboo.se>
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

THIS PATCH IS NOT INTENDED TO BE MERGED and is only included to help
demonstrate how the RAM boot supported binman images can be used to
generate loader images with the proprietary rkbin boot_merger tool.

First use the config fragment rockchip-ramboot.config to enable building
of binman images with RAM boot support, e.g.:

  make generic-rk3588_defconfig rockchip-ramboot.config

The generated u-boot-rockchip-usb47x.bin images can then be used with
the proprietary rkbin boot_merger tool to create a loader image, e.g.:

  $ ../rkbin/tools/boot_merger ./RK3588MINIALL.ini

Finally the generated loader image can be used with tools such as
rkdeveloptool or rockusb tools when a device is in maskrom mode, e.g.:

  $ rkdeveloptool db u-boot-rockchip-rk3588-loader.bin
 or
  $ rockusb download-boot u-boot-rockchip-rk3588-loader.bin

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: New patch NOT intended to be merged
---
 RK3308MINIALL.ini | 22 ++++++++++++++++++++++
 RK3328MINIALL.ini | 20 ++++++++++++++++++++
 RK3399MINIALL.ini | 20 ++++++++++++++++++++
 RK3528MINIALL.ini | 25 +++++++++++++++++++++++++
 RK3566MINIALL.ini | 25 +++++++++++++++++++++++++
 RK3568MINIALL.ini | 25 +++++++++++++++++++++++++
 RK3576MINIALL.ini | 27 +++++++++++++++++++++++++++
 RK3588MINIALL.ini | 25 +++++++++++++++++++++++++
 8 files changed, 189 insertions(+)
 create mode 100644 RK3308MINIALL.ini
 create mode 100644 RK3328MINIALL.ini
 create mode 100644 RK3399MINIALL.ini
 create mode 100644 RK3528MINIALL.ini
 create mode 100644 RK3566MINIALL.ini
 create mode 100644 RK3568MINIALL.ini
 create mode 100644 RK3576MINIALL.ini
 create mode 100644 RK3588MINIALL.ini

diff --git a/RK3308MINIALL.ini b/RK3308MINIALL.ini
new file mode 100644
index 000000000000..4802757418e9
--- /dev/null
+++ b/RK3308MINIALL.ini
@@ -0,0 +1,22 @@
+[CHIP_NAME]
+NAME=RK3308
+[VERSION]
+MAJOR=1
+MINOR=05
+[CODE471_OPTION]
+NUM=1
+Path1=u-boot-rockchip-usb471.bin
+Sleep=1
+[CODE472_OPTION]
+NUM=1
+Path1=u-boot-rockchip-usb472.bin
+[LOADER_OPTION]
+NUM=2
+LOADER1=FlashData
+LOADER2=FlashBoot
+FlashData=u-boot-rockchip-usb471.bin
+FlashBoot=u-boot-rockchip-usb472.bin
+[OUTPUT]
+PATH=u-boot-rockchip-rk3308-loader.bin
+[FLAG]
+RC4_OFF=true
diff --git a/RK3328MINIALL.ini b/RK3328MINIALL.ini
new file mode 100644
index 000000000000..590744f7f893
--- /dev/null
+++ b/RK3328MINIALL.ini
@@ -0,0 +1,20 @@
+[CHIP_NAME]
+NAME=RK322H
+[VERSION]
+MAJOR=2
+MINOR=50
+[CODE471_OPTION]
+NUM=1
+Path1=u-boot-rockchip-usb471.bin
+Sleep=1
+[CODE472_OPTION]
+NUM=1
+Path1=u-boot-rockchip-usb472.bin
+[LOADER_OPTION]
+NUM=2
+LOADER1=FlashData
+LOADER2=FlashBoot
+FlashData=u-boot-rockchip-usb471.bin
+FlashBoot=u-boot-rockchip-usb472.bin
+[OUTPUT]
+PATH=u-boot-rockchip-rk3328-loader.bin
diff --git a/RK3399MINIALL.ini b/RK3399MINIALL.ini
new file mode 100644
index 000000000000..22517a7fb091
--- /dev/null
+++ b/RK3399MINIALL.ini
@@ -0,0 +1,20 @@
+[CHIP_NAME]
+NAME=RK330C
+[VERSION]
+MAJOR=1
+MINOR=30
+[CODE471_OPTION]
+NUM=1
+Path1=u-boot-rockchip-usb471.bin
+Sleep=1
+[CODE472_OPTION]
+NUM=1
+Path1=u-boot-rockchip-usb472.bin
+[LOADER_OPTION]
+NUM=2
+LOADER1=FlashData
+LOADER2=FlashBoot
+FlashData=u-boot-rockchip-usb471.bin
+FlashBoot=u-boot-rockchip-usb472.bin
+[OUTPUT]
+PATH=u-boot-rockchip-rk3399-loader.bin
diff --git a/RK3528MINIALL.ini b/RK3528MINIALL.ini
new file mode 100644
index 000000000000..483ea8ebff5f
--- /dev/null
+++ b/RK3528MINIALL.ini
@@ -0,0 +1,25 @@
+[CHIP_NAME]
+NAME=RK3528
+[VERSION]
+MAJOR=1
+MINOR=4
+[CODE471_OPTION]
+NUM=1
+Path1=u-boot-rockchip-usb471.bin
+Sleep=1
+[CODE472_OPTION]
+NUM=1
+Path1=u-boot-rockchip-usb472.bin
+[LOADER_OPTION]
+NUM=2
+LOADER1=FlashData
+LOADER2=FlashBoot
+FlashData=u-boot-rockchip-usb471.bin
+FlashBoot=u-boot-rockchip-usb472.bin
+[OUTPUT]
+PATH=u-boot-rockchip-rk3528-loader.bin
+[SYSTEM]
+NEWIDB=true
+[FLAG]
+471_RC4_OFF=true
+RC4_OFF=true
diff --git a/RK3566MINIALL.ini b/RK3566MINIALL.ini
new file mode 100644
index 000000000000..cedf9cb69dfb
--- /dev/null
+++ b/RK3566MINIALL.ini
@@ -0,0 +1,25 @@
+[CHIP_NAME]
+NAME=RK3568
+[VERSION]
+MAJOR=1
+MINOR=1
+[CODE471_OPTION]
+NUM=1
+Path1=u-boot-rockchip-usb471.bin
+Sleep=1
+[CODE472_OPTION]
+NUM=1
+Path1=u-boot-rockchip-usb472.bin
+[LOADER_OPTION]
+NUM=2
+LOADER1=FlashData
+LOADER2=FlashBoot
+FlashData=u-boot-rockchip-usb471.bin
+FlashBoot=u-boot-rockchip-usb472.bin
+[OUTPUT]
+PATH=u-boot-rockchip-rk3566-loader.bin
+[SYSTEM]
+NEWIDB=true
+[FLAG]
+471_RC4_OFF=true
+RC4_OFF=true
diff --git a/RK3568MINIALL.ini b/RK3568MINIALL.ini
new file mode 100644
index 000000000000..d871d74b5f93
--- /dev/null
+++ b/RK3568MINIALL.ini
@@ -0,0 +1,25 @@
+[CHIP_NAME]
+NAME=RK3568
+[VERSION]
+MAJOR=1
+MINOR=1
+[CODE471_OPTION]
+NUM=1
+Path1=u-boot-rockchip-usb471.bin
+Sleep=1
+[CODE472_OPTION]
+NUM=1
+Path1=u-boot-rockchip-usb472.bin
+[LOADER_OPTION]
+NUM=2
+LOADER1=FlashData
+LOADER2=FlashBoot
+FlashData=u-boot-rockchip-usb471.bin
+FlashBoot=u-boot-rockchip-usb472.bin
+[OUTPUT]
+PATH=u-boot-rockchip-rk3568-loader.bin
+[SYSTEM]
+NEWIDB=true
+[FLAG]
+471_RC4_OFF=true
+RC4_OFF=true
diff --git a/RK3576MINIALL.ini b/RK3576MINIALL.ini
new file mode 100644
index 000000000000..162513bb0183
--- /dev/null
+++ b/RK3576MINIALL.ini
@@ -0,0 +1,27 @@
+[CHIP_NAME]
+NAME=RK3576
+[VERSION]
+MAJOR=1
+MINOR=100
+[CODE471_OPTION]
+NUM=1
+Path1=u-boot-rockchip-usb471.bin
+Sleep=1
+[CODE472_OPTION]
+NUM=1
+Path1=u-boot-rockchip-usb472.bin
+[LOADER_OPTION]
+NUM=2
+LOADER1=FlashData
+LOADER2=FlashBoot
+FlashData=u-boot-rockchip-usb471.bin
+FlashBoot=u-boot-rockchip-usb472.bin
+[OUTPUT]
+PATH=u-boot-rockchip-rk3576-loader.bin
+[SYSTEM]
+NEWIDB=true
+ALIGN=8
+[FLAG]
+471_RC4_OFF=true
+RC4_OFF=true
+CRC_OFF=true
diff --git a/RK3588MINIALL.ini b/RK3588MINIALL.ini
new file mode 100644
index 000000000000..bbf40dbe16c3
--- /dev/null
+++ b/RK3588MINIALL.ini
@@ -0,0 +1,25 @@
+[CHIP_NAME]
+NAME=RK3588
+[VERSION]
+MAJOR=1
+MINOR=11
+[CODE471_OPTION]
+NUM=1
+Path1=u-boot-rockchip-usb471.bin
+Sleep=1
+[CODE472_OPTION]
+NUM=1
+Path1=u-boot-rockchip-usb472.bin
+[LOADER_OPTION]
+NUM=2
+LOADER1=FlashData
+LOADER2=FlashBoot
+FlashData=u-boot-rockchip-usb471.bin
+FlashBoot=u-boot-rockchip-usb472.bin
+[OUTPUT]
+PATH=u-boot-rockchip-rk3588-loader.bin
+[SYSTEM]
+NEWIDB=true
+[FLAG]
+471_RC4_OFF=true
+RC4_OFF=true
-- 
2.50.1

