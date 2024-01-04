Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00418C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20AA287A01;
	Thu,  4 Jan 2024 16:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O90bz2a4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6495D879DC; Thu,  4 Jan 2024 16:12:50 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 017AA87A0A
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:12:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-35fe994dab5so1723455ab.0
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381132; x=1704985932; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TkbyoUp8Gy6N5VP3ntksUgjNHr7QG9xeS9eVphfT2mo=;
 b=O90bz2a4WM58xVOURvgf9OwAfgUDzOZipao2tAtX/rC0VlmzcqjMYEiVwzNwQqQRao
 nRVrYvh3q7U7UkW34jkm5sbiI9WXJJntNXu8VGOsiHv/IE2yHMeHo4PvXV0Pd+SwwgQp
 7lGh914d7VSxwcjd1v0YlVDr0XEzA9PkztCyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381132; x=1704985932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TkbyoUp8Gy6N5VP3ntksUgjNHr7QG9xeS9eVphfT2mo=;
 b=oFzUJfQxdnqHdci0h0PsfnyEUXbomH+L1NOa4nuuzLOI39ItyNazJV4tSFmFiE1lNQ
 S4t6G7/73US9i+HkRvfcGsIY6PpyJviLUeVCHkSWZCRAUg2wTjaJFItg4s0aBPsm5D+1
 5BQbPP3YVaZYy38gTJav+rfCTUjmb3jzEsMsx284lhWDNSHDKt59/apkxzL0/cXYVKLk
 Jz++bPn13P+mNA8MnVOWW4OaAW+05n0/hrTM0qZWWhEgVW3XivnrV7V/Jx6wdyvt+yIT
 ESddC/+4b4/oAAM0jUIfY0vTeRrhgp3WOylLW7Di4q9o6Pth93NBPVJJpjMOo5Lg/BOh
 O86g==
X-Gm-Message-State: AOJu0Yy4Q5jeS+IDmFf2HFy2oBA2dgD1DfxmHz0+F8OkJmnlavOsHSFH
 AIG2zZnQ7ooJdOlRqu0lbDvXfKYy/y0p5j4jZ9eEgdUgTDts
X-Google-Smtp-Source: AGHT+IEd2ucmd+WHMl4UeNIvaSPTQitPz6Y7az7w8cmYPTeZjSmhmFhxZmRojI5yITHYMt3ImeYKoA==
X-Received: by 2002:a92:cd89:0:b0:35f:b16d:cd75 with SMTP id
 r9-20020a92cd89000000b0035fb16dcd75mr815858ilb.14.1704381132579; 
 Thu, 04 Jan 2024 07:12:12 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cv4-20020a056e023b8400b0035fb79100cesm9260742ilb.59.2024.01.04.07.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:12:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 16/19] x86: coreboot: Enable support for the configuration
 editor
Date: Thu,  4 Jan 2024 08:11:49 -0700
Message-Id: <20240104151152.697855-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151152.697855-1-sjg@chromium.org>
References: <20240104151152.697855-1-sjg@chromium.org>
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

Enable cedit support along with required options and a simple style.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/dts/coreboot.dts    | 7 +++++++
 configs/coreboot64_defconfig | 2 ++
 configs/coreboot_defconfig   | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/dts/coreboot.dts b/arch/x86/dts/coreboot.dts
index b867468e16c..39d1d325db9 100644
--- a/arch/x86/dts/coreboot.dts
+++ b/arch/x86/dts/coreboot.dts
@@ -54,6 +54,13 @@
 			menu-inset = <3>;
 			menuitem-gap-y = <1>;
 		};
+
+		cedit-theme {
+			font-size = <30>;
+			menu-inset = <3>;
+			menuitem-gap-y = <1>;
+			menu-title-margin-x = <30>;
+		};
 	};
 
 	sysinfo {
diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 8f80e0271f7..49c982ef756 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -18,6 +18,7 @@ CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
 CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then cls; bootflow boot; fi"
+CONFIG_CEDIT=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
@@ -47,6 +48,7 @@ CONFIG_TFTP_TSIZE=y
 CONFIG_USE_ROOTPATH=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
+CONFIG_OFNODE_MULTI_TREE=y
 # CONFIG_ACPIGEN is not set
 CONFIG_SYS_IDE_MAXDEVICE=4
 CONFIG_SYS_ATA_DATA_OFFSET=0
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 5433a5ae0c2..d4e44e00dca 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -17,6 +17,7 @@ CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
 CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then cls; bootflow boot; fi"
+CONFIG_CEDIT=y
 CONFIG_CONSOLE_RECORD=y
 CONFIG_CONSOLE_RECORD_OUT_SIZE=0x1000
 CONFIG_PRE_CONSOLE_BUFFER=y
@@ -44,6 +45,7 @@ CONFIG_TFTP_TSIZE=y
 CONFIG_USE_ROOTPATH=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
+CONFIG_OFNODE_MULTI_TREE=y
 # CONFIG_ACPIGEN is not set
 CONFIG_SYS_IDE_MAXDEVICE=4
 CONFIG_SYS_ATA_DATA_OFFSET=0
-- 
2.34.1

