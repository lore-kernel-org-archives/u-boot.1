Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E6AC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F75683970;
	Wed, 28 May 2025 10:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Eu+/FWMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8928B83970; Wed, 28 May 2025 10:26:05 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B9783956
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3dca2473129so27468265ab.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420761; x=1749025561; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4f+kXg3DRbR/XLT0Y+2FEdQwtzIpzWdD1pVkCWoEus=;
 b=Eu+/FWMeilfIo9yz+EUK9N+pSWnwfY5YauZrGM+KMH3edc27+zrMqwBseFLMgJGWxj
 OgotjXxtkaLgGmEc5TViBPV/hjMeF1DBgHPGHL2lS24Br+x9QSKPbkUGosuk6D+syi88
 +2umQd2T7EI/VijYDl2d5U8Yh9k+td2MV2X44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420761; x=1749025561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B4f+kXg3DRbR/XLT0Y+2FEdQwtzIpzWdD1pVkCWoEus=;
 b=v8YV0ththpjfIBTc7m5Xyj1mv3iixCZo8gAzVMBmJHbv+ahy3/fOqpPk2/K2eTIv18
 lV3Zr4WDnM4Csl+YX/MA3nyJCAyhxopTVD+JvusT9K7x1kvYVerflipQV76AAq44e5op
 Ju7D3gt7zdCrR7asbK3qJ0A06dGXyfUv1adYMwOHECYn6+c/3cLmLuUxXewVs7w/tVdg
 BWSbE4soXsfQ/L4ZA69YIgPLWH254hZf0MbSzwUG4O+prSfUjbU/0V4LACveXzTAqLYq
 lZkrR1L2sGQtFqS11MHdB01qSxFSjHV50db+2DOGVwV6gqFj/l7MYFeV5d8QtQTXuwBZ
 ByTQ==
X-Gm-Message-State: AOJu0YwBqSbMMmFzhVCMK/1zYD6OPHriz38nIGs1nFmGSNVLDekiFSPb
 AQY3M0sTFUHjUPe+DzOmw73moulFuN1phryByOaUZXS4DRryjmQj2OI1dnyyjUcB3IshFDhtfGS
 2Q60Iws3n
X-Gm-Gg: ASbGncs2W6ZSZikIKn+OOD7d0A4Si6coWNl4psvqM/QVI+W3G0Fjb4dS6vy8fZHCFtb
 k38hGmMmATL6IqIClrWtkDtngPFWcJy9Zcx/ctw7OBXP0TwK/kmT2oifQul3YPq8eNIIivIp/KQ
 VNU2Ebm7hVygTynXXlxgIyy0SLOorImCb5u9f6hJu6Kvea/rUs8WNvKodSHb3rk0VA9cf472wFd
 gXmwxqE4PEuakw3VEfZopjinkzyMv/xdYN2e/OFxzHrc3P/+jB5A63E9vIkGp9nQeP0IA71D6Ac
 sazlzp6acUXdMenqX1yWMMZz7v1hixxlJU8dqQjM1y1K58ipun+BLe3aKv+DrZxeqAjGzA/jv1O
 P9vlzoLkcWHAQMpcPleFA9YE=
X-Google-Smtp-Source: AGHT+IHWEx6+XICrbZb8/pNP9YSuE1eeFzXAzjnedbG6XKaUpTaFXC8AZiy8/o4C9sxc5SXYao7ffQ==
X-Received: by 2002:a05:6e02:3305:b0:3dc:8b29:30a8 with SMTP id
 e9e14a558f8ab-3dc9b6a9fb3mr165953125ab.2.1748420761403; 
 Wed, 28 May 2025 01:26:01 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/27] bootstd: Tidy up help for boot flags
Date: Wed, 28 May 2025 02:24:35 -0600
Message-ID: <20250528082520.152391-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

The help for 'bootflow scan' is missing some flags. Tidy this up and
update the docs as well, keeping the flags in alpha order.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/bootflow.c             |  4 +++-
 doc/usage/cmd/bootflow.rst | 15 +++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 9d449f430c9..6063d9dfa7d 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -620,7 +620,9 @@ static int do_bootflow_cmdline(struct cmd_tbl *cmdtp, int flag, int argc,
 
 U_BOOT_LONGHELP(bootflow,
 #ifdef CONFIG_CMD_BOOTFLOW_FULL
-	"scan [-abeGl] [bdev]  - scan for valid bootflows (-l list, -a all, -e errors, -b boot, -G no global)\n"
+	"scan [-abeGHlmt] [bdev]  - scan for valid bootflows (-l list, -a all,\n"
+	"   -e errors, -b boot, -G no global, -H no hunters\n"
+	"   -m menu, -t text-only\n"
 	"bootflow list [-e]             - list scanned bootflows (-e errors)\n"
 	"bootflow select [<num>|<name>] - select a bootflow\n"
 	"bootflow info [-ds]            - show info on current bootflow (-d dump bootflow)\n"
diff --git a/doc/usage/cmd/bootflow.rst b/doc/usage/cmd/bootflow.rst
index 5d41fe37a7a..d57a6e36c3b 100644
--- a/doc/usage/cmd/bootflow.rst
+++ b/doc/usage/cmd/bootflow.rst
@@ -11,7 +11,7 @@ Synopsis
 
 ::
 
-    bootflow scan [-abelGH] [bootdev]
+    bootflow scan [-abeGHlmt] [bootdev]
     bootflow list [-e]
     bootflow select [<num|name>]
     bootflow info [-ds]
@@ -62,11 +62,6 @@ Flags are:
     Used with -l to also show errors for each bootflow. The shows detailed error
     information for each bootflow that failed to make it to the `loaded` state.
 
--l
-    List bootflows while scanning. This is helpful when you want to see what
-    is happening during scanning. Use it with the `-b` flag to see which
-    bootdev and bootflows are being tried.
-
 -G
     Skip global bootmeths when scanning. By default these are tried first, but
     this flag disables them.
@@ -76,10 +71,18 @@ Flags are:
     priority or label is tried, to see if more bootdevs can be discovered, but
     this flag disables that process.
 
+-l
+    List bootflows while scanning. This is helpful when you want to see what
+    is happening during scanning. Use it with the `-b` flag to see which
+    bootdev and bootflows are being tried.
+
 -m
     Show a menu of available bootflows for the user to select. When used with
     -b it then boots the one that was selected, if any.
 
+-t
+    If used with `-m`, show the menu in text mode.
+
 The optional argument specifies a particular bootdev to scan. This can either be
 the name of a bootdev or its sequence number (both shown with `bootdev list`).
 Alternatively a convenience label can be used, like `mmc0`, which is the type of
-- 
2.43.0

