Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E3EC83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C04786996;
	Mon,  4 Sep 2023 16:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ibWSSnrk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C47086940; Mon,  4 Sep 2023 16:41:52 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55DB4869BC
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-792979d4cb5so74749039f.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838506; x=1694443306; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDX+yNkBObzzT5qeAWZ30M8SfG+IPVeBzfHRk+CUIz4=;
 b=ibWSSnrkZzJ51PmSwHh1JErf2kU7gRpP0T62G8o9F9jYFGWnXQ36/emjjHEWX7ukjx
 41wx+OVeWA1bBjmYO4CcJxrPuxYDQnImvKt9EjRFNhEX6raao4QyDt2UhVCyoGuZinY4
 KF6xF7QngPjOUVESFZVn3qrjErj2aDrfPhbnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838506; x=1694443306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gDX+yNkBObzzT5qeAWZ30M8SfG+IPVeBzfHRk+CUIz4=;
 b=BDWsYU3zyNELyaD6SLLpTNUSGYjDDZ7CcXs04Mf/SZOeAg/zogp3PXhBPlXOaK50K+
 dWLfXTA09u/AnQmVKfoBrvzCOjFuM2YmMv07dfYsODcY3riVXJsiecTjMnjX07iWETo+
 dIE9XFYXJli88rWV6P/DGVyxbtf713TMbRYWIhVFWt8MzvDycc4m0YfayYgp9odwHjmn
 vTWhfxiayrPJScGhspxfwnUqUs76R9qAnQgjbmiHvJ5pcRk22xFY3Kf3+fvajr3n7wJl
 9J5wO+EuhaQ5l0fv5397tp/RjfPbZPtEry+7dtHkvvXdvFSFilJ5MybS7b95cge8sZBK
 dv4A==
X-Gm-Message-State: AOJu0Yydw6rm+SFDMWIkEgcgscZMOuurCPHSSyxDSChzIFUuhlIsozsd
 IjeeVDFTjDsf/m1tqyna2eCPKe/0ZnFvDtsciFc=
X-Google-Smtp-Source: AGHT+IEJoygrnd7bCOa6bHosiMDDMVwoYY4oZGta+p4KiXHHQrJl+e72Yw8JAcItcMpsWTxOi171pg==
X-Received: by 2002:a05:6e02:1a44:b0:34c:e84b:4c5c with SMTP id
 u4-20020a056e021a4400b0034ce84b4c5cmr12366470ilv.27.1693838505949; 
 Mon, 04 Sep 2023 07:41:45 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 06/20] FWU: Avoid showing an unselectable menu option
Date: Mon,  4 Sep 2023 08:41:09 -0600
Message-ID: <20230904144131.2699824-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230904144131.2699824-1-sjg@chromium.org>
References: <20230904144131.2699824-1-sjg@chromium.org>
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

Use a menuconfig to avoid showing a menu which cannot be selected in many
cases.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

Changes in v3:
- Drop comment about an update/ directory

Changes in v2:
- Fix FMU typo in the subject
- Drop now-unnecessary depends on FWU_MULTI_BANK_UPDATE

 lib/Kconfig             | 4 ----
 lib/fwu_updates/Kconfig | 9 +++++----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 9addcfab3734..bfab2f3165a7 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1118,8 +1118,4 @@ config PHANDLE_CHECK_SEQ
 
 endmenu
 
-menu "FWU Multi Bank Updates"
-
 source lib/fwu_updates/Kconfig
-
-endmenu
diff --git a/lib/fwu_updates/Kconfig b/lib/fwu_updates/Kconfig
index 71f34793d926..d35247d0e5d4 100644
--- a/lib/fwu_updates/Kconfig
+++ b/lib/fwu_updates/Kconfig
@@ -1,4 +1,4 @@
-config FWU_MULTI_BANK_UPDATE
+menuconfig FWU_MULTI_BANK_UPDATE
 	bool "Enable FWU Multi Bank Update Feature"
 	depends on EFI_CAPSULE_ON_DISK
 	select PARTITION_TYPE_GUID
@@ -10,24 +10,25 @@ config FWU_MULTI_BANK_UPDATE
 	  multiple banks(copies) of the firmware images. One of the
 	  bank is selected for updating all the firmware components
 
+if FWU_MULTI_BANK_UPDATE
+
 config FWU_NUM_BANKS
 	int "Number of Banks defined by the platform"
-	depends on FWU_MULTI_BANK_UPDATE
 	help
 	  Define the number of banks of firmware images on a platform
 
 config FWU_NUM_IMAGES_PER_BANK
 	int "Number of firmware images per bank"
-	depends on FWU_MULTI_BANK_UPDATE
 	help
 	  Define the number of firmware images per bank. This value
 	  should be the same for all the banks.
 
 config FWU_TRIAL_STATE_CNT
 	int "Number of times system boots in Trial State"
-	depends on FWU_MULTI_BANK_UPDATE
 	default 3
 	help
 	  With FWU Multi Bank Update feature enabled, number of times
 	  the platform is allowed to boot in Trial State after an
 	  update.
+
+endif
-- 
2.42.0.283.g2d96d420d3-goog

