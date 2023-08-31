Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0780C83F2B
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B023E86596;
	Thu, 31 Aug 2023 05:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EVp4r+KK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E2A686595; Thu, 31 Aug 2023 05:53:39 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96F4A8654A
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-34ccedcc584so909005ab.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454015; x=1694058815; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XVoOiZIz3uvycfRLzN9IRIW5hmXHwiQ6NSJJJPBBRmU=;
 b=EVp4r+KKali9z2DuUKC7Fy86cKeP7GEIdhCiQGr46U0TRUCLTDGawR7QAniel0tUXd
 7ZMw8CQS8UnjDdrZ5P4tdxzxWpDcPAOJabwtJB6vv9VelOecBiTjgGW72puydANm72Oa
 J+mftdAbcuD6AmDj5nkonjnSWYkQgyHYdIBmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454015; x=1694058815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XVoOiZIz3uvycfRLzN9IRIW5hmXHwiQ6NSJJJPBBRmU=;
 b=f/JsurnGb/Ma9ff18PdsklfPcuxc3WTGVUfdFqsiHTPMN0gTsVoaX3VX/js8cUK0EP
 LLYF2ThTrxibz1yJBEwXRZVN730wU72aEzjM60hi9f7GVplIZHAmGK5+fECSB9LmFv/K
 8osUUEucKVGztASu7QdKfS6MVenLo8Qo+iyyR4YQk1I9mjLMxjaZ3dm604OfE9BHZaQC
 02Q0mEmBwMKayIXMUbRKUB21cyJXU8aU4Io2PCobkWK8LB3nHx4goM8x8kCoRcXs2tUh
 bkk60fnOZKsIjNREfeQHKb+q8NL1c8I7HCubT0898HkIbLLRXn2tJuuUdp9fOZHkd6cX
 wKrw==
X-Gm-Message-State: AOJu0Yxp0bPBjfJ1IoX+bZERIagRCYh4/ANS7sBGTJeCUz0nVBvV7DVf
 RXzzuvGkr5+4E1AwSjXidec67vSWujaPUq/nlGA=
X-Google-Smtp-Source: AGHT+IEfA4dLh9ky2TlTe4KJLSNq+IhNx2tt+qUta+1/714buQc0YKiSQRYwBQsE9bLbRTL/IHFGbg==
X-Received: by 2002:a05:6e02:1b86:b0:348:d683:36bf with SMTP id
 h6-20020a056e021b8600b00348d68336bfmr1295388ili.12.1693454015202; 
 Wed, 30 Aug 2023 20:53:35 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 06/19] FWU: Avoid showing an unselectable menu option
Date: Wed, 30 Aug 2023 21:53:00 -0600
Message-ID: <20230831035319.2316665-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831035319.2316665-1-sjg@chromium.org>
References: <20230831035319.2316665-1-sjg@chromium.org>
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

This option should really go with the other 'Update support'.

Perhaps we should even consider a top-level update/ directory?

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

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
2.42.0.rc2.253.gd59a3bf2b4-goog

