Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E97C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F423B865FB;
	Thu, 31 Aug 2023 05:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U73+o+PO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C421586584; Thu, 31 Aug 2023 05:53:44 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B0F68657C
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34bae4fa2a8so1596105ab.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454020; x=1694058820; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNHqUF5ec/aFkKxQs6zEletqA01Zj7gmtLSKwqnyoec=;
 b=U73+o+POCqd4D3zfPN29dbtmi17IFJMG86DvhEDySYeT2txVlNEnQFLJSXnZPpndzY
 P/Mk6IKdA5JFinaAyqNh+2fK3x1CRebJv89MVVGTPKvtNPmXz/g1RvWLG67GqFn/1DOq
 7Vt/Vbjh30XWOd+Z7Pc4kq9DDcMgMfj/8iiCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454020; x=1694058820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UNHqUF5ec/aFkKxQs6zEletqA01Zj7gmtLSKwqnyoec=;
 b=TJZubk1laVnSwPK8lFUFS2ySPmfxfPMGKDJjew4c+L2DoJd17hyTaeI8uaBYBDm/vo
 v7AzBEXcSSRxWeFoRJGSebBUjLOBazCoivm79xosUPZ20eiPFjeWR0oMIIyfCe8hu5iE
 lOTGRIvgQs+NNVEv44iN6jc549pmsGEBGtLt83flw/w23Zob5UdoTMSfWjEmIHlvSHQF
 Q62Wc5cgc97bhugqLRNd8gSvYZsM/oHStxHnqv1wfPOZOlJIP0C7Rj5S/ihxwYbFi5P5
 ci0RDiBRlPNffxW/J9penhqu5jZhmOgM/q4JsoaBenX8yyr2mAVjB6HNXuAfB8Nh/gDc
 SwKQ==
X-Gm-Message-State: AOJu0YyrDC2hyV8frQ31A7UjyEYGKsf4Ww9DRzvERMRV+uJs3tmd60dC
 WX8bRixGHiSO6GiM5Egm+TDtBxSNEB0ua61p3QU=
X-Google-Smtp-Source: AGHT+IHw+f1yLbYCg6dcpKrpritWkRimmTj0gFbCs2ifqKPXqoe67Sniq24Fm+wEt/0OHfH+uU5VxA==
X-Received: by 2002:a05:6e02:de1:b0:34d:f14d:aee1 with SMTP id
 m1-20020a056e020de100b0034df14daee1mr4425408ilj.11.1693454020640; 
 Wed, 30 Aug 2023 20:53:40 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 13/19] Kconfig: Move SPL_FIT under FIT
Date: Wed, 30 Aug 2023 21:53:07 -0600
Message-ID: <20230831035319.2316665-14-sjg@chromium.org>
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

This option already depends on FIT, so put it under the same umbrella, so
that it appears in the FIT menu.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 467bca706782..c9b7d3f710b6 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -140,11 +140,9 @@ config FIT_PRINT
         help
           Support printing the content of the fitImage in a verbose manner.
 
-endif # FIT
-
 config SPL_FIT
 	bool "Support Flattened Image Tree within SPL"
-	depends on SPL && FIT
+	depends on SPL
 	select SPL_HASH
 	select SPL_OF_LIBFDT
 
@@ -195,7 +193,7 @@ config SPL_FIT_RSASSA_PSS
 
 config SPL_LOAD_FIT
 	bool "Enable SPL loading U-Boot as a FIT (basic fitImage features)"
-	depends on SPL && FIT
+	depends on SPL
 	select SPL_FIT
 	help
 	  Normally with the SPL framework a legacy image is generated as part
@@ -243,7 +241,6 @@ config SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ
 
 config SPL_LOAD_FIT_FULL
 	bool "Enable SPL loading U-Boot as a FIT (full fitImage features)"
-	depends on FIT
 	select SPL_FIT
 	help
 	  Normally with the SPL framework a legacy image is generated as part
@@ -341,6 +338,8 @@ config VPL_FIT_SIGNATURE_MAX_SIZE
 
 endif # VPL
 
+endif # FIT
+
 config PXE_UTILS
 	bool
 	select MENU
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

