Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747F1EC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:02:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFD6D86AE9;
	Thu,  7 Sep 2023 17:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nZG8qq2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B8586A74; Thu,  7 Sep 2023 17:59:51 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD6C786A63
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79565370aa3so48894939f.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102384; x=1694707184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRzRUEk8sT3KjjWHLrFSnYroUmTzEPlpZJdnd65D78k=;
 b=nZG8qq2+bdOsT3CH8Q/HycKwJCTvHUS5V0kSd51qwHYYvnm4aTGXTeITUPkwRGdWfw
 AVnZJNdwMf0hFUUrGnMSsKZZK3LBZL2nb1cU8Sl5FZLW2v6D31557OdsIL/fH74mI4zt
 3YncAf+35iRYpYGzlwsOgFTLiauUHlYGSGnvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102384; x=1694707184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lRzRUEk8sT3KjjWHLrFSnYroUmTzEPlpZJdnd65D78k=;
 b=lWlXzs6Jlsy/O6ijGJKONrfcNgOicId8oWdQgiwuD/KqWeQjPdNKjzYgh1sn/r8g5u
 R55cBvzJMlI5xLmJt0v5RIMXI7MMT6Rgletqh4piIY+I0OSLIEzFebGuEFZorMUSNEpu
 wL7DvMmhx3nd8nS64hOsfbpU5WeooBXSR48qME8e391UE0w12Ggc81ekoEuXQi0LNL4Q
 fHvtM1a1qrU+v+YPLXooLc7mxCswKhQMnFk5y4WapGj9Ehg27JUYRMj3Zgp6hQIr9GuH
 b8dMTCfWj+yhMUIhnrjqh8QjBB8oLesAyX0CRWwe7+7PDR6HB7CgKfO5HX3fWRHVA2B7
 c2Mw==
X-Gm-Message-State: AOJu0YxLp80gIfH7l95G2x/aJDdNzALrAlsjvkYGl78sR8lF0vvs8DRP
 4vNm4M2J6S6x50LwpA2CEOXVZLqtwxZu+6hir3g=
X-Google-Smtp-Source: AGHT+IFhvKBpfgPp3Ynry4uBdZ+f6kfLwPLJqTGOsiOJApPZOIOa8vUE57W60e5NpwsGGhOR30Le/A==
X-Received: by 2002:a92:ca07:0:b0:348:ddcb:137 with SMTP id
 j7-20020a92ca07000000b00348ddcb0137mr131310ils.16.1694102384153; 
 Thu, 07 Sep 2023 08:59:44 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 06/22] FWU: Avoid showing an unselectable menu option
Date: Thu,  7 Sep 2023 09:59:11 -0600
Message-ID: <20230907155933.48511-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155933.48511-1-sjg@chromium.org>
References: <20230907155933.48511-1-sjg@chromium.org>
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

(no changes since v3)

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

