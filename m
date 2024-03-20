Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152B4C54E71
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 01:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21CD287F13;
	Wed, 20 Mar 2024 02:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="ZhRRPzJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E59F688076; Wed, 20 Mar 2024 02:11:32 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D551287513
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 02:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-609f060cbafso74132497b3.0
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 18:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1710897088; x=1711501888;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ULB7ni1VXOd7terdK83M6yRrhxsVzX193+m43d+AQOA=;
 b=ZhRRPzJzigva5KiB4DNKnvlHdYr/SmpKqIAgsv0pYytXZVk4Ocm6u4Qsxcxkaq7HdP
 QP8Fb9d9tHTuG3IZLeU3LTVDYWpPuDREecpCVW5GPlaCzFI12OgwqCZvuz29p9NT/dPl
 aoGZCWij3TQEFuYSZaZT36Ehl9y86E7dgqtH4ygAJUrVuK5DYgrfu07MYwI6mJu3SwtK
 s0mDOPdNjipun2olFmfAaTuLaO1hvYWmvWaUyI0Q8HNSudqy627fTWzHTceGPB+WLnLo
 nl8IqZT574bNcDCN1LHGtgiEzPPLbzRdEgbh1oHbT62qy6SbM6agoUHGl33d+O8Dz/dW
 n7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710897088; x=1711501888;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ULB7ni1VXOd7terdK83M6yRrhxsVzX193+m43d+AQOA=;
 b=bQsH3yiJ3A8/Brh/3QlEx2OYWBcyGPHetRtaejVxHoMzwpRM1wCW8F3az19PnKVDC6
 0lyQScPxaJGctsY4uCxorqa3rVmypvgNc8X3JmXeLB07t6GsUEs0ju9fqvry3TapnXp4
 eUbWyJg6csM5TPntSAMxWHc+6N5Yxv8aPw3bnB1C5S2IQiBCanaf6iBU5r8lgCMPum8G
 dhQ9tMNcJEwexbIIGq9tW49N1rcBJP+gtTfoxc7nm90IWvegAJO2vCmPsRfW9cYzPlrG
 WaKtfFzkAYLujNL10/6Lf+vKT8O1pQuG3eD0O+Q1dfYGmKPI4NwXqDqhd//7L6Ez+Cly
 9COw==
X-Gm-Message-State: AOJu0YwdOTqJ4FoLZJtA2OHFDY9TzLQIVlIuxDYh3cP+ub3raOTUvtGx
 741gCuZJsuJYtm6mWJbfQA0HuuJUqIGKXpfSPMK5cCZ2ychS2HNXx7OeSiOMeqkoRnsORAA7rLg
 W9A==
X-Google-Smtp-Source: AGHT+IHvitO7STPyvIaEyuQXeaKJRfJuoZorlT9Fo2Xna7lp6BTlJyh6j89QTXkRbaZ1IVMuDsbg8w==
X-Received: by 2002:a0d:d58c:0:b0:609:f49f:5949 with SMTP id
 x134-20020a0dd58c000000b00609f49f5949mr4659421ywd.21.1710897088036; 
 Tue, 19 Mar 2024 18:11:28 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a81b643000000b00608d0a088e3sm2623874ywk.120.2024.03.19.18.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 18:11:27 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Greg Malysa <greg.malysa@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Shengyu Qu <wiagn233@outlook.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] build: Revive and update LDR format support
Date: Tue, 19 Mar 2024 21:09:22 -0400
Message-Id: <20240320010922.30856-1-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Mar 2024 02:17:12 +0100
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

LDR format files are used primarily by Analog Devices processors but may
be of interest to other vendors. Previously support existed for this
format as part of the U-Boot build, but it has been unmaintained and
unused for a long time. In preparation for adding support for modern ADI
processors that use LDR, modernize the LDR support:

- Introduce CONFIG_LDR_CPU as the CPU string recognized by the LDR tool
  may not be the same as CONFIG_CPU
- Add an SPL target that repackages u-boot-spl inside an LDR file

An almost identical target for packaging u-boot into an LDR file already
exists and did not need to be updated

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>

---

 Kconfig              | 9 ++++++++-
 Makefile             | 2 +-
 scripts/Makefile.spl | 5 +++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index 5710934000..3f3ce6054e 100644
--- a/Kconfig
+++ b/Kconfig
@@ -715,10 +715,17 @@ config SYS_CLK_FREQ
 	  A static value for the CPU frequency.  Note that if not required
 	  for a given SoC, this can be left at 0.
 
-source "api/Kconfig"
+config LDR_CPU
+	string "CPU name to be passed to LDR utility."
+	help
+	  Set the CPU name for the -T parameter in the LDR utility.  This is
+	  generally used on processors from Analog Devices, but may be also
+	  be useful for other vendors.
 
 endmenu		# General setup
 
+source "api/Kconfig"
+
 source "boot/Kconfig"
 
 source "common/Kconfig"
diff --git a/Makefile b/Makefile
index a2bc9d5903..db3272a439 100644
--- a/Makefile
+++ b/Makefile
@@ -1328,7 +1328,7 @@ u-boot-nodtb.bin: u-boot FORCE
 
 u-boot.ldr:	u-boot
 		$(CREATE_LDR_ENV)
-		$(LDR) -T $(CONFIG_CPU) -c $@ $< $(LDR_FLAGS)
+		$(LDR) -T $(CONFIG_LDR_CPU) -c $@ $< $(LDR_FLAGS)
 		$(BOARD_SIZE_CHECK)
 
 # binman
diff --git a/scripts/Makefile.spl b/scripts/Makefile.spl
index 407fc52376..58d6a452e5 100644
--- a/scripts/Makefile.spl
+++ b/scripts/Makefile.spl
@@ -381,6 +381,11 @@ $(obj)/$(BOARD)-spl.bin: $(obj)/u-boot-spl.bin
 	$(objtree)/tools/mkexynosspl) $(VAR_SIZE_PARAM) $< $@
 endif
 
+$(obj)/u-boot-spl.ldr: $(obj)/u-boot-spl
+	$(CREATE_LDR_ENV)
+	$(LDR) -T $(CONFIG_LDR_CPU) -c $@ $< $(LDR_FLAGS)
+	$(BOARD_SIZE_CHECK)
+
 quiet_cmd_objcopy = OBJCOPY $@
 cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
 
-- 
2.38.2

