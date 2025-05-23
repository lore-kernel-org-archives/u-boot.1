Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C419C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A539D836A8;
	Sat, 24 May 2025 01:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lqi1j18T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D6C83340; Sat, 24 May 2025 00:59:33 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56F778334D
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so430444b3a.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041170; x=1748645970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6xjzUa0EXVUH1/gKs3XM8Ygb0+CPj0k9d5MTPSfHfko=;
 b=lqi1j18TjUpjLGWsi1Z0990uDLMCSpJyvuRFCz3ufnDhhMSTNmDeAa8FwmA7FgLOy3
 tvMXLhh7Z+IshsZD1K7BvF8qAITZvp05wM+e4Bi6xZ+fsWYXryTTLSVl1F6QZvC1OADX
 HnaVW92uKSf3BV1tYOZfNj9U7d3Pvz7eSuVVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041170; x=1748645970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6xjzUa0EXVUH1/gKs3XM8Ygb0+CPj0k9d5MTPSfHfko=;
 b=IsuDWIcQWiD5JuqcQogyYb7CLRws9W+OioZW5zn0BCO0Qsp3BSbcW3ZpvTsxjWglBb
 n1d5TNbsMXN6V77Cv4Eqd8eGRYpI6lsmFL/T5oqkJ4mYeyMcsGi4CTBGW7XsvM4LSmF9
 S+usSRHiPnH4raQwHN2bAXDlYGWU2ZNG0yXtvB+UNNA+gIjmJX6XoWpO+MRnHEVb+KP8
 uL2eAVhIflV5GvaEm9BIgBA/PSZdaVY8lx1DwO34MSUJuQZywjyDLve0StkcwUKDPhdJ
 P0LltazwhKd+gAGJSLKrkBbA7jq+l/YNRcp1dp2sTUsicD9iYfw24Pf7SbNruU3zSw2i
 62oA==
X-Gm-Message-State: AOJu0Yyo4sGNWxuIWWE4fwtXRMTx455WTHAJq9bk0ugkRkaPkM3XZO5l
 b+b/8Li1JCgMgEXVfGryB0rCUB9xEvoFQKmVZ9mYkGgQLFKSxejUGye5l9zt5AdKiup4S2HSI6A
 J6aE=
X-Gm-Gg: ASbGnctILKjJ11rGXdyBjtMdpBW1gOqFHVZgnlxNnzzSYTzCPeNXV8GQrpDPWqTD48G
 vXE/PllP7xiUbRVT95Z4Q+b/Ek1CNVuXkGty+aeZe3/gxonAHIRa2kXZsZEg5TAa4YXBgIoYZD+
 sad2GN1xbMlVTX2cwtj+yWqbOfFCVgDR/ZTA8YgStm9NTDeMogWLbBezFyOBpZKt64MxhGT3j0m
 rfoJ2JyCklOAm3b+fCxV6ML4ygNfbdIFx/3sYXxa9EfmntkIKJN4w5pRo3yDffUrjztFlSW0YIs
 zWdadOgT9+XiA7bwFMbJZP9H0/yPjz9Y0UUZ1gvtUbE2rBweouck1IAIgMtOHB1J5+MKaBHacse
 ATW+3G3P1QHVijmA=
X-Google-Smtp-Source: AGHT+IE1mnA+6axpXbLpC/aJHgxqFAxxDViWPWDjTyq4fuVtHypJOPKSwDEC00NKfEbWGyP0+60msA==
X-Received: by 2002:a05:6a00:84c:b0:742:39fa:13df with SMTP id
 d2e1a72fcca58-745fe067af5mr1881752b3a.19.1748041169713; 
 Fri, 23 May 2025 15:59:29 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-742a987677dsm13740937b3a.132.2025.05.23.15.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:29 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 28/28] doc: chromebook_trogdor: Add document detailing
 installation steps
Date: Fri, 23 May 2025 15:58:43 -0700
Message-ID: <20250523225845.2311989-29-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

Make it a little more ergonomic than navigating to the chromium.org docs
by just documenting the steps needed to install U-Boot on a Trogdor
chromebook. I've been using the Depthcharge 'altfw' flow to do this
which is nice because you get to keep ChromeOS installed for any future
firmware updates.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 doc/board/google/chromebook_trogdor.rst | 69 +++++++++++++++++++++++++
 doc/board/google/index.rst              |  1 +
 2 files changed, 70 insertions(+)
 create mode 100644 doc/board/google/chromebook_trogdor.rst

diff --git a/doc/board/google/chromebook_trogdor.rst b/doc/board/google/chromebook_trogdor.rst
new file mode 100644
index 000000000000..dc40b9072bd5
--- /dev/null
+++ b/doc/board/google/chromebook_trogdor.rst
@@ -0,0 +1,69 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Stephen Boyd <swboyd@chromium.org>
+
+Chromebook Trogdor/Strongbad
+============================
+
+Trogdor and Strongbad are Chromebooks that are either clamshells or
+detachables. U-Boot can be installed into the alternate firmware (altfw) slot
+in the SPI-NOR flash chip and selected in the developer mode boot screen. This
+chain loads U-Boot from Depthcharge and avoids disabling the write protect
+screw.
+
+Enable Alternate Firmware
+=========================
+
+First, you need to enable developer mode on the Chromebook. On a clamshell
+that's done by pressing power + ESC + refresh. On a detachable you press the
+power button + volume up + volume down. Once you get to the recovery screen,
+press Ctrl+d to enter developer mode.
+
+In developer mode, switch to VT2 (use Ctrl+Alt+refresh) and log in as 'root'
+(the default has no password). Configure Depthcharge to load U-Boot::
+
+  cd /tmp
+  flashrom -r bios.bin
+  cat > ubootfw.txt <<EOF
+  0;uboot;uboot;u-boot for coreboot on ARM
+  1;uboot;uboot;u-boot for coreboot on ARM
+  EOF
+  cbfstool /tmp/bios.bin remove -r RW_LEGACY -n altfw/list
+  cbfstool bios.bin add -r RW_LEGACY -n altfw/list -f ubootfw.txt -t raw
+
+You can also prevent future ChromeOS firmware updates from replacing the
+alternate firmware::
+
+  cbfstool bios.bin remove -r RW_LEGACY -n cros_allow_auto_update
+
+And finally enable the alternate firmware feature::
+
+  crossystem dev_boot_altfw=1
+
+It's a good idea to flash the RW_LEGACY section now with this alternate
+firwmare list even though we haven't installed U-Boot yet::
+
+  flashrom -w bios.bin -i RW_LEGACY
+
+Installation
+------------
+
+Build U-Boot and obtain u-boot.elf::
+
+   $ make chromebook_trogdor_defconfig
+   $ make
+
+Copy the 'u-boot.elf' file to the Chromebook. On the Chromebook, add the u-boot
+payload::
+
+  cd /tmp
+  flashrom -r bios.bin
+  cbfstool bios.bin add-payload -r RW_LEGACY -c lzma -n uboot -f u-boot.elf
+  flashrom -w bios.bin -i RW_LEGACY
+
+Now you can reboot and select the "Select alternate bootloader" option. Select
+'uboot' to boot U-Boot. If you would like this to be the default boot option,
+you can boot into ChromeOS and switch to VT2 (use Ctrl+Alt+refresh) to use
+crossystem::
+
+  crossystem dev_default_boot=altfw
+
diff --git a/doc/board/google/index.rst b/doc/board/google/index.rst
index 061c79771875..1144b164162c 100644
--- a/doc/board/google/index.rst
+++ b/doc/board/google/index.rst
@@ -9,3 +9,4 @@ Google
    chromebook_coral
    chromebook_link
    chromebook_samus
+   chromebook_trogdor
-- 
Sent by a computer, using git, on the internet

