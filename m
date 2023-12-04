Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042C7C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1529877E9;
	Mon,  4 Dec 2023 01:30:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T+l+xa6t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163FC87655; Mon,  4 Dec 2023 01:30:15 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 111CF87897
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b844e3e817so2118241b6e.0
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649808; x=1702254608; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpZC0aJfgyeyzGIzGGktSjfSmpTdB+3u4BsfOfRDXLo=;
 b=T+l+xa6tDQN6AE6IpHUNb9xwmq/+DT1+jLiKQFd5qhoLHooXa2v9rUXCrrppGr0S6J
 WsjYtyNUpmTmFWl8JQvD/wkAcjF3fgdWi+RYgU3KYLvP0HJvntC38ikIHOToPEBud9ny
 isihJ8e8oB4xHskupXyJIvPUlv13G5CGTe0q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649808; x=1702254608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpZC0aJfgyeyzGIzGGktSjfSmpTdB+3u4BsfOfRDXLo=;
 b=wqwCNQ1j4TfOm5zsSBKOgHSSvFbzy+zHpgzR5+EuLs8N5TsFwOBXvjfLAHWNXZGXmw
 sXwiY4QYbuG59dk4L3KQd0dlZOMQ7Gv3HpKy4sObQd8QmYjPhnUtHmXxo+hBGHSGMZ8B
 K43fpQJKUn8mJGD2La5P0EicWK66c1A1SVLfysqfqSPtemZeq+Kc6R5LL60dck6POV9P
 /IQWzuaEOWC8xYR/DBa95fTiJbZXf0GQ+bLAUT3iEQSl7OJM4XcOZBiljtpAjaTscV2T
 pQCmrMfsP02yH8nuOJMfBmxV+yGyM12DUOG6wGKswMRG68GPI7mHo2vDQrJDgC87zJmH
 DogQ==
X-Gm-Message-State: AOJu0YxeKNwYN5yPkjvdAsS04WMXUwuOO3ncw1h4i3x5OlrQCWGRgAW0
 yecq/75hGb8fQ6tAv9V9ygr/mMkVYAdHfpiHlfDw6g==
X-Google-Smtp-Source: AGHT+IHCdflV4bSqV0u4aLWVXY3cT4bzjYWqrcWV9KQRcn6SyTGT/OA3bhoxDmLFxvAByzWaGRa05g==
X-Received: by 2002:a05:6808:1795:b0:3b8:b2c0:e317 with SMTP id
 bg21-20020a056808179500b003b8b2c0e317mr3576838oib.77.1701649808104; 
 Sun, 03 Dec 2023 16:30:08 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a056a001b5800b006ce3a0b4bfasm2346433pfv.24.2023.12.03.16.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:30:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rick Chen <rick@andestech.com>, Roger Knecht <rknecht@pm.me>,
 Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Zong Li <zong.li@sifive.com>
Subject: [PATCH 03/13] x86: zboot: Create a separate ZBOOT option for zboot
 logic
Date: Sun,  3 Dec 2023 17:29:28 -0700
Message-ID: <20231204002944.897949-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002944.897949-1-sjg@chromium.org>
References: <20231204002944.897949-1-sjg@chromium.org>
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

Most of the functionality of zboot is contained in the logic which
handles a zimage. Create a separate Kconfig for the logic so that it can
(later) be used without the command itself being enabled.

Enable ZBOOT by default on x86, with the command depending on that. The
existing 'imply' can therefore be removed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/Kconfig          | 1 -
 arch/x86/Kconfig      | 8 ++++++++
 arch/x86/lib/Makefile | 2 +-
 cmd/Kconfig           | 2 ++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 2e0528d819c9..de91aac4b8d4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -246,7 +246,6 @@ config X86
 	imply CMD_PCI
 	imply CMD_SF
 	imply CMD_SF_TEST
-	imply CMD_ZBOOT
 	imply DM_GPIO
 	imply DM_KEYBOARD
 	imply DM_MMC
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 99e59d94c606..e5ee10af33c5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1053,4 +1053,12 @@ config SPL_COREBOOT_SYSINFO
 	  display, memory and build information. It is stored in
 	  struct sysinfo_t after parsing by get_coreboot_info().
 
+config ZBOOT
+	bool "Support the zImage format"
+	default y
+	help
+	  Enable this to support booting the x86-specific zImage format. This
+	  uses a special, binary format containing information about the Linux
+	  format to boot.
+
 endmenu
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 90a7618ecfde..8fc35e1b51ea 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -48,7 +48,7 @@ obj-$(CONFIG_$(SPL_TPL_)GENERATE_ACPI_TABLE) += acpi_table.o
 endif
 obj-y	+= tables.o
 ifndef CONFIG_SPL_BUILD
-obj-$(CONFIG_CMD_ZBOOT)	+= zimage.o
+obj-$(CONFIG_ZBOOT) += zimage.o
 endif
 obj-$(CONFIG_USE_HOB) += hob.o
 ifndef CONFIG_TPL_BUILD
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 9ebea76c2ce5..584ffd039686 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -538,6 +538,8 @@ config THOR_RESET_OFF
 
 config CMD_ZBOOT
 	bool "zboot - x86 boot command"
+	depends on ZBOOT
+	default y
 	help
 	  With x86 machines it is common to boot a bzImage file which
 	  contains both a kernel and a setup.bin file. The latter includes
-- 
2.43.0.rc2.451.g8631bc7472-goog

