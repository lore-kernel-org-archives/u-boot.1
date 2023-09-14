Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0452BEEAA58
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 518CC8706E;
	Thu, 14 Sep 2023 18:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bv4yJ1Uf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9FFD87062; Thu, 14 Sep 2023 18:56:39 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BCF18706E
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-792707f78b5so40933939f.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710596; x=1695315396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qsl3BCsFfXILwzVuBXeyjS66TaVuYpGX+LLFJSFY+9k=;
 b=Bv4yJ1Uf2eCAA4jqBJqwZxzeaWItdJwO/acUcfpwvNukkeC8PJPO+BxgyaWLAfpyEu
 ZLFLF8w6usCTFaCBj3ASwX1HQrkGZE09m4ykN+4By+RGjU2fQB1Jd2ZP6au2nRu4JRAZ
 Q2IIS5WMRuA5UKJGO/TrXUSfFAASCCZvWUmgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710596; x=1695315396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qsl3BCsFfXILwzVuBXeyjS66TaVuYpGX+LLFJSFY+9k=;
 b=Jafwg3ZqSZSsBMqGUY8xH7KxfoqNqrR/lw1jGWw6zV2y7BNnUYWM2aig7QDP+aRZF+
 LUQGeqI32EAyEom3v91YcfXPFz5fAfGUFeERFSUetysVadCt04b2BaGVWEW8KUrbLmZ4
 rJUB1HMLSzPLT1uNrn6VbDdyH/RR7hXFunwTFtU7kCIdW9BkaElQOVCQqgo5mSvvYAHy
 TmjMA8x2Oy7fSpdlCr9G7oS0LwHmyOhRhTLJ98CudxCcWn/hU8sQVH6kegFJ0RT4RSQg
 n5umm1/ASy2VzeRIkDRhaJEXcpMaUhOM/JKlqb3l6NUdFPNz7NPWYxzhCkjCuHdMFpmG
 6suQ==
X-Gm-Message-State: AOJu0YwOEJCv/+DG0tXghVMx/+cMMs3KoAlaEP7MpV8UBvgccrY8wrnu
 XbGhYhal4V6HPg4WSLQ0AXov5YAacmIa0yFxDJA=
X-Google-Smtp-Source: AGHT+IGj9d7FybI3oTOJPj9igCEw6jAwpDZngmIQ3HGXrXNaW/tsbnU2YD2ruBTHXvyD+8ZUHA1UvA==
X-Received: by 2002:a5d:964d:0:b0:792:931e:a93a with SMTP id
 d13-20020a5d964d000000b00792931ea93amr6501517ios.4.1694710595836; 
 Thu, 14 Sep 2023 09:56:35 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Brandon Maier <brandon.maier@collins.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH v5 05/21] FWU: Avoid showing an unselectable menu option
Date: Thu, 14 Sep 2023 10:55:43 -0600
Message-ID: <20230914165615.1058529-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
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
index 9addcfab373..bfab2f3165a 100644
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
index 71f34793d92..d35247d0e5d 100644
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
2.42.0.459.ge4e396fd5e-goog

