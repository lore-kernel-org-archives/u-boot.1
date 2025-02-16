Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D51C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B4680104;
	Sun, 16 Feb 2025 21:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U014sJ57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E21A80F57; Sun, 16 Feb 2025 21:45:02 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 538F580F7A
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d1988be53dso8800495ab.3
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738698; x=1740343498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkUisr++RVCj0iT98bJ+JIPBV1uE2F7bmbEsJn6hXDg=;
 b=U014sJ57IhGUZ6VSQ35tJnRgSPnWNbJFa6SJSI3qBc2k2I0AjTP0pijUjrGpQQ5VRe
 p0y0NIUpB+WjUJJO5dq0s/icoxxq74LVISrv5p4zC9H6oSNRXnHyw2SEz5Of6ZoJhWTk
 FHrCv4DvXgu1vQPj0RrUpmzS570gae9/OAzlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738698; x=1740343498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkUisr++RVCj0iT98bJ+JIPBV1uE2F7bmbEsJn6hXDg=;
 b=BLsGxpjaCVeonCsTKWKzg4gmTwXav8mbW6CHLUc4oCHaxGO+8gVbzghB7rA99/WMdS
 +6vrI1pv+PlotlWUBAHFrxkzH+PWXNorgM5tpUGuDvWAKhobQEN2DHSGb8LdL1MrdMD7
 UM8ZsufWAZpF16oV3ApkCUHOK6AxMQYc4KmytmcBIqf38nW8BiGmeqYFfBjwZmoQqpOt
 8jSqF/nnmZumrXDmckqsb/2ejpLkxEzRSo3JyNbC7FhRI/245fJJKe3mbsY/8+S2zTnS
 CLEqMmzmAfjKWv1BbCQbtx/1cMZ3s6+ROwqdmn1HnvXVGN3iXilnmqhWHOpwmaupX5Ui
 0ypw==
X-Gm-Message-State: AOJu0YxpSgLw43IzhJlNZAeRQzLuIGb3niEzoksOeXgYND4N98J70Ndt
 lTkbTH6gpqMss3lFTjIK7ZLAbSvtogndboniFDkfY1wrUiIoxb8P4Bq0a/DWkthp/LrEWUmzWG4
 =
X-Gm-Gg: ASbGnct7SudfRM0cYcsHwho6jcOINTpubL6DZeWhzo7MWHzLOnrtUTDmy1i5sGYpg19
 jS5pY/xMNYbYODP2gLevCB23FYAr5SKqpy1XGPrYqfk21YtWNr/VRRnQdN9z2k55dmfjQq4wpj9
 Be4N4S0Jv1wA3tBv8eSIbtr/aGKAp+atJsEIL+U74xFuLdHI28bu9BQDKp7tbIm5EtCMW2coHA+
 EJOZm5MsndTk01mmj0XPMZScojDInQ1pSZ9GGrwtmySatFn8o3mAIfvh1PAoIHsEA3MtFZ9aL8f
 Gxn3n/Lsah36tstvmddrYAHvwXlntZ+RTSyIRyKZLjlNKd5pjd+m
X-Google-Smtp-Source: AGHT+IF1Ruuu48vbX4a+uzCuLTcyHvC4SuWLGSAViao2XXubnTWoD8rDyJg64KBfuC8d1NxmapEdGA==
X-Received: by 2002:a05:6e02:20cf:b0:3d0:4700:db18 with SMTP id
 e9e14a558f8ab-3d28091909fmr62805745ab.20.1739738698538; 
 Sun, 16 Feb 2025 12:44:58 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:44:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Angelo Dureghello <angelo@kernel-space.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/28] x86: Drop mpspec from the SPL build
Date: Sun, 16 Feb 2025 13:43:50 -0700
Message-ID: <20250216204421.3560012-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

This is not needed in SPL, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 43e6a1de77d..a908356e8a6 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -26,7 +26,9 @@ obj-y	+= e820.o
 obj-y	+= init_helpers.o
 obj-y	+= interrupts.o
 obj-y	+= lpc-uclass.o
+ifndef CONFIG_XPL_BUILD
 obj-y	+= mpspec.o
+endif
 obj-$(CONFIG_$(PHASE_)ACPIGEN) += acpi_nhlt.o
 obj-y	+= northbridge-uclass.o
 obj-$(CONFIG_I8259_PIC) += i8259.o
-- 
2.43.0

