Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6624BD18157
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 598F4892B8;
	Tue, 15 Oct 2024 00:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SqlUgafj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE1048921B; Tue, 15 Oct 2024 00:32:37 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD9A889288
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-8377fd76112so169746239f.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945151; x=1729549951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/8iOh6iv/Mo9+lQt3g18GdsWjvEPCXBldWBGKf5KHY=;
 b=SqlUgafj0yFkWtK3lXSNgUSCsWR5wULHx1PPQgdcH8y9zG0lmTW8yJEo3PEl8wkA/5
 DoOcGUoQXSC+B3Xloa+14GlYHQ8pLxkMoPLq1CPjvzKXyfspEisJS0PNE4Y2nQwod8cQ
 nwUz8Ht7RAgs32zLIEuPMoulN/OTogjLwd1LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945151; x=1729549951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/8iOh6iv/Mo9+lQt3g18GdsWjvEPCXBldWBGKf5KHY=;
 b=At+BrR/zuVV8XmGzTgT1yF9W1kGvQeXzBRql9H9FNhgwGNrNAwlR3FRYh6vXV0ZjO+
 brLKD88bznu0H++3dwApIPpZ4UIbzV1wIIluD/9lOXE9Aeui7hpbIPFlkhlAYZ/Xh5fQ
 8VdR5DxIvLhyNGeMsiXa6U8Oh0v+MnV4Vsy9uR8hxnopo0F7+i+p8rthDlbvsRubMKcs
 2XcLvGU0dTsNWhi0IinpnDJkci9hB5OgyRuDNW8jBD5D1dKxY9SLHongPHRCQInNympK
 yNyWNz7Hc33uZoTMjnbhnvCw7I08H7WSaekcUZuUEh9+su1YCh0xY+LCWdVlokiIDx9b
 kptw==
X-Gm-Message-State: AOJu0Yw2Kzt7oC9p2Uca3fDtq0GfuPI5egcfk/hqijHFyh4WUzt2ZDh9
 4KJxoNj4cwYjqAvdplMXmc+pVG1oZv4++GQahWg1PamnKundbezvqof5CBmd0Ha4MomrIPuzRCA
 OxQ==
X-Google-Smtp-Source: AGHT+IEdECbcUhI4H/c4D8Fe9JktrBpr3MVkTDkYRsryxIsTZ1NQJ5vbNNeZCf9xxZmUDh+Ye2NdGQ==
X-Received: by 2002:a92:b743:0:b0:3a3:c036:e3ab with SMTP id
 e9e14a558f8ab-3a3c036e518mr55821955ab.18.1728945151537; 
 Mon, 14 Oct 2024 15:32:31 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 17/20] x86: coreboot: Enable support for the configuration
 editor
Date: Mon, 14 Oct 2024 16:32:09 -0600
Message-Id: <20241014223212.2212442-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014223212.2212442-1-sjg@chromium.org>
References: <20241014223212.2212442-1-sjg@chromium.org>
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
index da42ad0a20a..148c2494587 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -17,6 +17,7 @@ CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
 CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then cls; bootflow boot; fi"
+CONFIG_CEDIT=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
@@ -46,6 +47,7 @@ CONFIG_TFTP_TSIZE=y
 CONFIG_USE_ROOTPATH=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
+CONFIG_OFNODE_MULTI_TREE=y
 # CONFIG_ACPIGEN is not set
 CONFIG_SYS_IDE_MAXDEVICE=4
 CONFIG_SYS_ATA_DATA_OFFSET=0
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index fdf978a539a..ed3de2677d1 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -16,6 +16,7 @@ CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
 CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then cls; bootflow boot; fi"
+CONFIG_CEDIT=y
 CONFIG_CONSOLE_RECORD=y
 CONFIG_CONSOLE_RECORD_OUT_SIZE=0x1000
 CONFIG_PRE_CONSOLE_BUFFER=y
@@ -43,6 +44,7 @@ CONFIG_TFTP_TSIZE=y
 CONFIG_USE_ROOTPATH=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
+CONFIG_OFNODE_MULTI_TREE=y
 # CONFIG_ACPIGEN is not set
 CONFIG_SYS_IDE_MAXDEVICE=4
 CONFIG_SYS_ATA_DATA_OFFSET=0
-- 
2.34.1

