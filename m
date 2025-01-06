Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3F8E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E119780607;
	Mon,  6 Jan 2025 15:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WQVRxox8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08CF4805FC; Mon,  6 Jan 2025 15:32:51 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDED7801C3
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:32:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-844e7409f8aso611977139f.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736173966; x=1736778766; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PxtY79uP6dRGTWuVdY0/mEnfJsb0pDp2ZFDTwyO5Tgs=;
 b=WQVRxox8ifffcAXws8Dw38z6BZiTcGHN1W6i6r1ZaXCnbuU6jCenuzAcbuZpVlyO6D
 HVQjnMFra6G5T365w8Q5iq0cnR2qCOehexEgXaXFRDxt8B3/zQFJ41bHiZ0TzhBqLXIa
 0DfVnyOf1QASLl+ZUr0jrSN5abzXLzfhdyNB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736173966; x=1736778766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PxtY79uP6dRGTWuVdY0/mEnfJsb0pDp2ZFDTwyO5Tgs=;
 b=j0MEBjVlMfq4v8PZPeiydWXkXCSCPO1uV7jdL2quNvgLF30NOpMbCX68acfhVYy0zi
 HcIjbzz8WgMVHr7uYztTzoQCaP8jF+pk/74hSzKY7eEM8QOF9y73WJby7dwcpi30j/Wh
 6l+1sz4OiwB2wWEluQq1gfkTXWwLv5ViWG+GNDaLmx3T2Gw6/TFMoei3GEBvPLfMoMPw
 8GdkVO9kcsLYUVrB00jIh5Ifa9AvX3DrNh/DGEruXUcIk0+OYKjN+5tS0YIPFc3yPFXL
 /1nrLyVKLm7jUY8QO4rZIYCYluiTsSii9U5SkATI5phvxwYNY0SFPQaRy8QEH7Fm1OTt
 Ihfg==
X-Gm-Message-State: AOJu0YyYqypEp6uoguYu6J5owvXT0htTUX0zdwBW03ypa6f1OJD8TMcE
 8oDzY+d3vNaCa1oCClx/xUyrUWP7sMbwEpskcIniSVJ4b3xzBJm2e82LQIL6IDrFfhLVg+YQ5ac
 =
X-Gm-Gg: ASbGnctfH2gtweDF1Co6zmynIKIFODKaEA1Wy+cD2czGpOXS2AeU59J9id0n+FLbn3C
 8juyMp/A1dtegnGgPbcnxqaedy2JwAn6du30gln1w1CRU3RlRT8ln/7VN7nLJjJbkkk2y/X3cpr
 nrxJ6ImYbPusofYf5iNZ+qyfrZmzg1CuVrTwa5NGOnP0cHvVMiFicQC9FW6tl78AbXfIQ+PZTMB
 /4cBmTo5NsvUBO9XuX49ER+cCfNp3/bg4163w8k1LOsVH/57v72ZKa+gZikBDJr/z4si5vSoasf
 gr1jqh6IsYimpQoUUw==
X-Google-Smtp-Source: AGHT+IESPCG4pu22S6rvlt/c2iNyhbg3ParF7p/BrCr++9/2ujtNSEl/WRDtatCE1nwE+eCdTbxdBQ==
X-Received: by 2002:a05:6e02:20ca:b0:3a7:8270:4050 with SMTP id
 e9e14a558f8ab-3c2d514fafdmr505559785ab.18.1736173966542; 
 Mon, 06 Jan 2025 06:32:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:32:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alex Shumsky <alexthreed@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Dragan Simic <dsimic@manjaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Watt <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/33] bloblist: Make BLOBLIST_ALLOC the default
Date: Mon,  6 Jan 2025 07:31:59 -0700
Message-Id: <20250106143229.3023771-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

We want to encourage people to use an allocated bloblist since it is
more flexible than a fixed one. Make this the default, being sure not to
change existing users.

The unit tests require BLOBLIST_FIXED so add a dependency in the
Makefile to avoid build errors.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/Kconfig                         | 15 ++++++++-------
 configs/chromebook_bob_defconfig       |  1 +
 configs/chromebook_coral_defconfig     |  1 +
 configs/chromebook_kevin_defconfig     |  1 +
 configs/chromebook_samus_tpl_defconfig |  1 +
 configs/qemu-x86_64_defconfig          |  1 +
 test/common/Makefile                   |  4 ++++
 7 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index e8d89bf6eb9..a00387a4609 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1039,16 +1039,10 @@ if BLOBLIST
 
 choice
 	prompt "Bloblist location"
+	default BLOBLIST_FIXED if SANDBOX
 	help
 	  Select the location of the bloblist, via various means.
 
-config BLOBLIST_FIXED
-	bool "Place bloblist at a fixed address in memory"
-	help
-	  Select this to used a fixed memory address for the bloblist. If the
-	  bloblist exists at this address from a previous phase, it used as is.
-	  If not it is created at this address in U-Boot.
-
 config BLOBLIST_ALLOC
 	bool "Allocate bloblist"
 	help
@@ -1056,6 +1050,13 @@ config BLOBLIST_ALLOC
 	  specify a fixed address on systems where this is unknown or can
 	  change at runtime.
 
+config BLOBLIST_FIXED
+	bool "Place bloblist at a fixed address in memory"
+	help
+	  Select this to used a fixed memory address for the bloblist. If the
+	  bloblist exists at this address from a previous phase, it used as is.
+	  If not it is created at this address in U-Boot.
+
 endchoice
 
 config BLOBLIST_ADDR
diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index decac2e1935..072311465d9 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -36,6 +36,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-bob.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
 CONFIG_SPL_MAX_SIZE=0x1e000
diff --git a/configs/chromebook_coral_defconfig b/configs/chromebook_coral_defconfig
index 0fb73049738..b1999b4ef20 100644
--- a/configs/chromebook_coral_defconfig
+++ b/configs/chromebook_coral_defconfig
@@ -44,6 +44,7 @@ CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BLOBLIST=y
 # CONFIG_TPL_BLOBLIST is not set
+CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x30000
 CONFIG_SPL_NO_BSS_LIMIT=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 5bbea6c42a8..13c0998dbab 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -37,6 +37,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-kevin.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
 CONFIG_SPL_MAX_SIZE=0x1e000
diff --git a/configs/chromebook_samus_tpl_defconfig b/configs/chromebook_samus_tpl_defconfig
index fc524da5480..42337d7a11e 100644
--- a/configs/chromebook_samus_tpl_defconfig
+++ b/configs/chromebook_samus_tpl_defconfig
@@ -34,6 +34,7 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0xff7c0000
 CONFIG_BLOBLIST_SIZE=0x1000
 CONFIG_SPL_NO_BSS_LIMIT=y
diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 812b20687e5..f93721fceb8 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -34,6 +34,7 @@ CONFIG_SPL_LOG=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_PCI_INIT_R=y
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x10000
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_BOARD_INIT=y
diff --git a/test/common/Makefile b/test/common/Makefile
index 53c4f16164d..95bd00741a3 100644
--- a/test/common/Makefile
+++ b/test/common/Makefile
@@ -1,9 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0+
 obj-y += cmd_ut_common.o
 obj-$(CONFIG_AUTOBOOT) += test_autoboot.o
+
 ifneq ($(CONFIG_$(XPL_)BLOBLIST),)
+ifdef CONFIG_BLOBLIST_FIXED
 obj-$(CONFIG_$(XPL_)CMDLINE) += bloblist.o
 endif
+endif
+
 obj-$(CONFIG_CYCLIC) += cyclic.o
 obj-$(CONFIG_EVENT_DYNAMIC) += event.o
 obj-y += cread.o
-- 
2.34.1

