Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22595C021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 14:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9299A80F0A;
	Thu, 13 Feb 2025 15:26:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JqJHv5Z3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A984F80F1A; Thu, 13 Feb 2025 15:26:04 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 830A380F42
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 15:26:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4717fe0735fso9568131cf.1
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 06:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739456759; x=1740061559; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9qwxqYvrVs5Ft074rAjDBdQblQsLSaqLDimNitKdjk=;
 b=JqJHv5Z3TU2kUt/6yXfrdxu9774sJbSJLy3z+59f9jlmL23q1zrk+3AwOo399dwowg
 lcdtpEUVyaMn/bhOHLTo9PoVO+uGaM9oYypFV3XaFPUTUYzbf8lgcMGOJSoxX1P0szxt
 L2Ne/fY+7EZg8lLPCSfo6lfEAEYBdm+sUj3v8q/jfALbffCvyLe4etyYbmORnzkNGdfc
 6NZiRf9Kw7qes3GS7ADqKxOSJrwtUUOSzBW2ueRFnC7NtSglsbkXrPlR9uYS+n5YXTjj
 Ud+bELi7c3ndABfJt8OPIo+TiQO69Nu79fBU10fqFGKPjqcS0ILqk5oPsuH5cvzFLD+k
 KUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739456759; x=1740061559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+9qwxqYvrVs5Ft074rAjDBdQblQsLSaqLDimNitKdjk=;
 b=UDaJ4QxZJF0Nf5UUhCkGvxoo5hkM3wRjVCV5G8PrZ4j7U6Vu8Ut/m5SMpFcUR0lt6a
 ou7p0y7p1RBxojXInVE+XgVExYo/17eocT5+0U9lHO7czlkYVttGTBraMrTsgKBiKEPn
 XvHlJNDj45TbfO8jN9ancMOwpK3LuCrlPbitybVwezLkG4PtrxYzcavR2+zbUGmRG8Gk
 UtWwZHn+niY+XSGXV6Dz8XD5DrXioS4/phT4KoqT6kvb7XBOryGODyubnRoKSn786c5m
 SzbQmC13d0pBLAiq9eUFGOqbB4Q8LngFip+irHvIM2W4WiWvay+CSNVUqt85xbBa4/2V
 2Neg==
X-Gm-Message-State: AOJu0Yx1jHDvcjyshj+VM563BosYtvcBcjNINJMJfFKKAzsfV3QfDFk2
 bYxlm490fJ7bU7YlEdjPxpQRmQUuLWsBECPJSnvbMv8vrwF+biM7E78YpDswzrBCX4WS59EAmh7
 xGPY=
X-Gm-Gg: ASbGnctvqGJiCoyOAXr4WK/eNHk3yJGcTiqXu6E4A7MrYTDwgz6R+SKbCjaYXM4WaLV
 /Hoe7OsR1iUq81JBpjpcf5SNtbBLXsoUN7BLslsdOqhIXjLtQLj/I91gIP+U/Os+YuuliW0zqS4
 n+nol1wX6zhz6D3fUtuoOvMTe46Vqky51X2BeSDhIKIckax3Eb/1mL5NHGdI5njCtu+8wOtU7zT
 cwfrhqBsyUrnfpKS934tCdQWOUxdmT7TiSOai2uXhWDbnPuSyqHVefzj7zZkh0RS7nDjRNnGOu6
 iCJIWybp3eCv/05TiHXjCBjx7QAXsSRxlaKkpw3z3iMoQi1DnxeEQ2QiV0wXIUr4WqQQC+vZmkZ
 8DNgHnK1bxzer6g==
X-Google-Smtp-Source: AGHT+IEUzT7MLGuX3TkCug+4K1pG3Lj6t2lnLVnFokTO9TTqrOD/C1M4JNgElvtJOhkTXbt3ncS8gQ==
X-Received: by 2002:a05:622a:5145:b0:471:c0e4:1977 with SMTP id
 d75a77b69052e-471c0e41cf7mr41982351cf.40.1739456759029; 
 Thu, 13 Feb 2025 06:25:59 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471c2a4c1b4sm8473801cf.48.2025.02.13.06.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 06:25:58 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Stefan Roese <sr@denx.de>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Alex Shumsky <alexthreed@gmail.com>, Joshua Watt <jpewhacker@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Richard Weinberger <richard@nod.at>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
Subject: [PATCH 2/2] bloblist: kconfig for mandatory incoming standard passage
Date: Thu, 13 Feb 2025 06:25:34 -0800
Message-Id: <20250213142538.928937-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213142538.928937-1-raymond.mao@linaro.org>
References: <20250213142538.928937-1-raymond.mao@linaro.org>
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
index 0a6ecf7277f..b0c04ec469f 100644
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
index 691bd2e8544..3c919acfb75 100644
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

