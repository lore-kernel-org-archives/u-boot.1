Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECFAC021B0
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 00:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70E6680F68;
	Thu, 20 Feb 2025 01:02:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yjJK+2HD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB4C080F0A; Thu, 20 Feb 2025 01:02:45 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4038C801DE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 01:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-46fd4bf03cbso5346461cf.0
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 16:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740009762; x=1740614562; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDNWqfT3pAjRJRCX3gR2aFeed/O3sf47/gWbbA9mO3A=;
 b=yjJK+2HDHV/q2kL74e75KG4o2f4NwJ0NedkaBd+qE0xzRqsHMAUG49QNlO2t9rtXNK
 c/TgzBLcGbIkkUJZn2VESk5HVG5VeCSzHSBe59Ohq/R0Hl2ygmn/KgjQaJKfcX/rDrMf
 iqVasufRaXsmv0ctJH9hP5e+WofKTs0CUTl7tjafMsN0H34e1Z6qAVnEJND1jQMvsnvu
 DM4CGMFgJTwTYePR2NcyuI5oZzEZUcMMj+4Ot0QPgz1l80ftV7XFDrwkH+7tv6n8Q+ew
 fu22svfCD3nODr/5BZudr/4WnyAxcEmBa5eud8UrXc3ASZXgGsAazkpdTIZMcc54Liwt
 YZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740009762; x=1740614562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gDNWqfT3pAjRJRCX3gR2aFeed/O3sf47/gWbbA9mO3A=;
 b=Rwg4mbNQtvb/y2hZfcUZPCOGbHOTJIEHjkb3d8bc+lJsK1jhquj4GeKF38EKKnGorh
 GD2KEPLEFCSI5lbkAXbO21hN9e1xITUEpTSB06K0Cbsd1Fb0HPfWx9jUK6ej1FpWZmPd
 BgUU/NU2rtbj18L4px0+R5lbF7Q6rcgwX+TQIm14WvkxsNZ7BGG18KK8Em5cKQCFzC2C
 4ropMS5w0ZDpjkEBTRXCBJNhB375WrE7zwHbwQR06DSOGKPKO7cQGtOcmwE7QHgNwm2d
 c0J2JgEszYxo4wiyDV3pxl/IYZRI1wu4U5yCZrNUZEEU++TpGmBsHXzgo0QOKL89jBOB
 MbYw==
X-Gm-Message-State: AOJu0Yztj53o3WGKfuVz5p1BHtSlUWk74PQusq7e3EgnUE6s38PAu1sw
 PFoz2dMBv6DL23/SsUlfuV+2nGkq71HiU1LWsZEa2Hym5KtQq6POfuKOw++mkS1i0g40b/QkCiy
 pAeQ=
X-Gm-Gg: ASbGncu6mi2G2Fg3yihbQLI/LT8Snyd9gTRVGmj6ee/EHAUuJ+6KOMte7L748WQTvE1
 4Slp9T5+YZ4jiBNgDMOKTATsh/vnsFjU7uhnAvkj7pXkrnl9F1oljZP4LMitrhr/5Fa7MPC4cxn
 ue5PgQWdNEheoIuA17wmVmxqFHM4UDS4Z03RmsqPx+FqWW1IRd3BD97UabkHxhtiUjF8FJGNPa4
 MfC5ZSQMIPLkZmRoK5sWvTl1ksNLZ0qZJj2M/b/8GXIJfTIJB2SCUAxoDB5joTEoIBVPfnsFeYX
 qWMvlAIVwn2FHesj+KAg80vI4l9pIfV4HKjLwfBx
X-Google-Smtp-Source: AGHT+IHMF3WTBwh4xMcjZh0UBy/Ivwxp3ogLIi0Tfy5NVVVCY0+n9oI/sXfO6G4fhjVvlI/UoSmT0Q==
X-Received: by 2002:a05:622a:388:b0:471:f9e7:5042 with SMTP id
 d75a77b69052e-471f9e753f5mr176252471cf.14.1740009761789; 
 Wed, 19 Feb 2025 16:02:41 -0800 (PST)
Received: from ubuntu.localdomain ([209.227.153.148])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4720bc52905sm11510361cf.26.2025.02.19.16.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 16:02:41 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>, Stefan Roese <sr@denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alex Shumsky <alexthreed@gmail.com>, Joshua Watt <jpewhacker@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>, Jonas Karlman <jonas@kwiboo.se>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Richard Weinberger <richard@nod.at>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 2/2] bloblist: kconfig for mandatory incoming standard
 passage
Date: Wed, 19 Feb 2025 16:02:20 -0800
Message-Id: <20250220000223.1044376-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220000223.1044376-1-raymond.mao@linaro.org>
References: <20250220000223.1044376-1-raymond.mao@linaro.org>
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

In previous commit, incoming standard passage is used by default
when initializing the bloblist, so explicitly BLOBLIST_PASSAGE is
no more needed.
Rename it as BLOBLIST_PASSAGE_MANDATORY to determine the behaviors
when an incoming transfer list does not exist or is invalid.
When it is selected, incoming standard passage is mandatory and
U-Boot will report an error when a valid incoming transfer list is
missing.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2:
- None.

 common/Kconfig                          | 14 +++++++++-----
 common/bloblist.c                       |  7 +++++++
 configs/vexpress_fvp_bloblist_defconfig |  2 +-
 doc/board/armltd/vexpress64.rst         |  4 ++--
 include/bloblist.h                      |  5 ++---
 5 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 7b2db46ef06..1d6de8badf7 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1066,11 +1066,15 @@ config BLOBLIST_ALLOC
 	  specify a fixed address on systems where this is unknown or can
 	  change at runtime.
 
-config BLOBLIST_PASSAGE
-	bool "Use bloblist in-place"
+config BLOBLIST_PASSAGE_MANDATORY
+	bool "Use bloblist in-place mandatorily"
 	help
-	  Use a bloblist in the incoming standard passage. The size is detected
-	  automatically so CONFIG_BLOBLIST_SIZE can be 0.
+	  By default U-Boot will use a bloblist in the incoming standard passage.
+	  This option controls whether U-Boot tries to load a static bloblist or
+	  allocate one if a valid incoming bloblist does not exist.
+	  Select this option to mark incoming standard passage as mandatory and
+	  U-Boot will report an error when a valid incoming bloblist does not
+	  exist.
 
 endchoice
 
@@ -1086,7 +1090,7 @@ config BLOBLIST_ADDR
 
 config BLOBLIST_SIZE
 	hex "Size of bloblist"
-	default 0x0 if BLOBLIST_PASSAGE
+	default 0x0 if BLOBLIST_PASSAGE_MANDATORY
 	default 0x400
 	help
 	  Sets the size of the bloblist in bytes. This must include all
diff --git a/common/bloblist.c b/common/bloblist.c
index f1bbb4ab13e..6e4f020d7c4 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -526,6 +526,13 @@ int bloblist_init(void)
 		 */
 		bool from_addr = fixed && !xpl_is_first_phase();
 
+		/*
+		 * If Firmware Handoff is mandatory but no transfer list is
+		 * observed, report it as an error.
+		 */
+		if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
+			return -ENOENT;
+
 		ret = -ENOENT;
 
 		if (xpl_prev_phase() == PHASE_TPL &&
diff --git a/configs/vexpress_fvp_bloblist_defconfig b/configs/vexpress_fvp_bloblist_defconfig
index dcc87db8723..4d52b96202b 100644
--- a/configs/vexpress_fvp_bloblist_defconfig
+++ b/configs/vexpress_fvp_bloblist_defconfig
@@ -1,5 +1,5 @@
 #include <configs/vexpress_fvp_defconfig>
 
 CONFIG_BLOBLIST=y
-CONFIG_BLOBLIST_PASSAGE=y
+CONFIG_BLOBLIST_PASSAGE_MANDATORY=y
 CONFIG_BLOBLIST_SIZE_RELOC=0x10000
diff --git a/doc/board/armltd/vexpress64.rst b/doc/board/armltd/vexpress64.rst
index 4dadadb53dc..a732fac899d 100644
--- a/doc/board/armltd/vexpress64.rst
+++ b/doc/board/armltd/vexpress64.rst
@@ -53,8 +53,8 @@ predefined bloblist at a specified address, dynamically allocating memory for a
 bloblist, or utilizing a standard passage-provided bloblist with automatic size
 detection.
 
-By default, ``vexpress_fvp_bloblist_defconfig`` uses the standard passage method
-(CONFIG_BLOBLIST_PASSAGE) because TF-A provides a Transfer List in non-secure
+By default, ``vexpress_fvp_bloblist_defconfig`` uses the standard passage method mandatorily
+(CONFIG_BLOBLIST_PASSAGE_MANDATORY) because TF-A provides a Transfer List in non-secure
 memory that U-Boot can utilise. This Bloblist, which is referred to as a Transfer List in
 TF-A, contains all necessary data for the handoff process, including DT and ACPI
 tables.
diff --git a/include/bloblist.h b/include/bloblist.h
index 8156ef725d3..f32faf78560 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -467,9 +467,8 @@ int bloblist_reloc(void *to, uint to_size);
  * If CONFIG_BLOBLIST_ALLOC is selected, it allocates memory for a bloblist of
  * size CONFIG_BLOBLIST_SIZE.
  *
- * If CONFIG_BLOBLIST_PASSAGE is selected, it uses the bloblist in the incoming
- * standard passage. The size is detected automatically so CONFIG_BLOBLIST_SIZE
- * can be 0.
+ * If CONFIG_BLOBLIST_PASSAGE_MANDATORY is selected, bloblist in the incoming
+ * standard passage is mandatorily required.
  *
  * Sets GD_FLG_BLOBLIST_READY in global_data flags on success
  *
-- 
2.25.1

