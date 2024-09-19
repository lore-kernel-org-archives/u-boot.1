Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4DBCF395D
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 16:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E17A89296;
	Thu, 19 Sep 2024 18:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jZsym5Go";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80E2B892A5; Thu, 19 Sep 2024 18:10:48 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90C8489291
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 18:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=al.kochet@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f75129b3a3so11392631fa.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 09:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726762246; x=1727367046; darn=lists.denx.de;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PdLMAi67HRfcWCA3cPpmeiAbSBht8YJFi8+8nMgmEO0=;
 b=jZsym5Go3XHmsPJ13FfM187kqwqzXBsTHcT4arBWhMNGN14gOybzor1LyxTmriv8FJ
 I8yA3/Uswx+J6YTGApo7J+LPH3njf6QdTu9Evcgi4uA23xft6To1kjpiYtA3JGsJdVkt
 rVp5NA5TjIexfC7eZ0y/pK3eEBOyhpvWeF7spQcEC9a1NMZEbiRkK0PX7POR0mKXzNIh
 jj3zBsZqnzdmukfZiqRM9+tG7WTscE7xMOGvs8A/n80JoMa1+0qvgfMDBRCxcYxez4gr
 XdsQrE6Uye0Qrst2m4yhqfXVDVRlxDJR/I+buiJqVrKaMG3fM1pvDFNczz+teamlxJ0T
 BfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726762246; x=1727367046;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PdLMAi67HRfcWCA3cPpmeiAbSBht8YJFi8+8nMgmEO0=;
 b=SpIKvKBxoRHuYXvLwYP2EXHcoO1qFvKz4VFfRLYtU8oGMvOLDLQFwVpfIbyoXyo/tU
 6gJAJ1oswgaUOGcFsXgRoj8m62X9RrEMioPtSXDd/U6rF6mri1nT2M+DKajysfc7ghqJ
 CpkNtZc+bN4p1uTKWYdE0+m7KrAo/GYTMrI7HBVmHVeICFTJAkdc6VsE3PXRjTzMItAQ
 pU+fisA5MWUyPEdgwIiGv0AO4Pjuu+uWfcQzMJriNC6VeqxFRnx+KDcAZ5IeJcFf818P
 +PtzV6w+wxewSsKPgChzkmc9r0BdjXvTANHkZWgbzlGSTtBWllW/UcSK92GkMoCr3MD3
 bzMg==
X-Gm-Message-State: AOJu0YwCWal67ixxot6XcKmVQDbyVsg0A4Lswwq/BiAQaiOLS6VKIwgB
 /nXFklY3QV6Ot3/9sKBcQ7pzQMsrrgB+FsBZ9ZrfKmftVstqyFvxu/KILA==
X-Google-Smtp-Source: AGHT+IGoyRgSLMv0AVsiksnLQJezaQTO6i12vlN88JJToZn7V5ivZjxmQW/cRxiyEYFc24rYhCZqxg==
X-Received: by 2002:a05:651c:1545:b0:2f7:6664:f295 with SMTP id
 38308e7fff4ca-2f7cb30cb17mr683681fa.27.1726762245324; 
 Thu, 19 Sep 2024 09:10:45 -0700 (PDT)
Received: from localhost.localdomain ([80.87.144.137])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f79d2e1c56sm16278361fa.20.2024.09.19.09.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 09:10:44 -0700 (PDT)
From: al.kochet@gmail.com
To: u-boot@lists.denx.de
Cc: Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCHv2 1/1] Makefile: pass external DTB provided by make variable
 EXT_DTB to binman
Date: Thu, 19 Sep 2024 19:10:42 +0300
Message-Id: <20240919161042.3423-2-al.kochet@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240919161042.3423-1-al.kochet@gmail.com>
References: <20240919161042.3423-1-al.kochet@gmail.com>
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

From: Alexander Kochetkov <al.kochet@gmail.com>

Yocto build is using EXT_DTB to repack U-Boot during signed
FIT kernel creation. First, it takes the DTB from U-Boot, then
it creates signed FIT kernel image and places kernel key into
the DTB. After that it executes:
    make EXT_DTB=/path/to/dtb/with/kernel/key

Despite the fact that in the documentation all examples with EXT_DTB
use only single DTB, the patch allows pass many DTB files separated
by spaces, e.g.:
    make EXT_DTB="/path1/to/1.dtb /path2/to/2.dtb"

The first DTB from the list become default configuration.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 Makefile | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1c754ceb595..6dea0345f50 100644
--- a/Makefile
+++ b/Makefile
@@ -1367,7 +1367,17 @@ u-boot.ldr:	u-boot
 # ---------------------------------------------------------------------------
 # Use 'make BINMAN_DEBUG=1' to enable debugging
 # Use 'make BINMAN_VERBOSE=3' to set vebosity level
+
+ifneq ($(EXT_DTB),)
+ext_dtb_list := $(basename $(notdir $(EXT_DTB)))
+default_dt := $(firstword $(ext_dtb_list))
+of_list := "$(ext_dtb_list)"
+of_list_dirs := $(dir $(EXT_DTB))
+else
+of_list := $(CONFIG_OF_LIST)
+of_list_dirs := $(dt_dir)
 default_dt := $(if $(DEVICE_TREE),$(DEVICE_TREE),$(CONFIG_DEFAULT_DEVICE_TREE))
+endif
 
 quiet_cmd_binman = BINMAN  $@
 cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
@@ -1377,7 +1387,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		build -u -d u-boot.dtb -O . -m \
 		--allow-missing $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
 		-I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
-		-I $(dt_dir) -a of-list=$(CONFIG_OF_LIST) \
+		$(foreach f,$(of_list_dirs),-I $(f)) -a of-list=$(of_list) \
 		$(foreach f,$(BINMAN_INDIRS),-I $(f)) \
 		-a atf-bl31-path=${BL31} \
 		-a tee-os-path=${TEE} \
-- 
2.17.1

