Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50558EEAA58
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:56:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB5598708A;
	Thu, 14 Sep 2023 18:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lRtO7YZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 579FD87084; Thu, 14 Sep 2023 18:56:34 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D42869F1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34f6c725d94so3842995ab.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710591; x=1695315391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUuS/7ahjLfC0HWEV55Pn9MvG+Ttaf4XZk2Jq3dkpAE=;
 b=lRtO7YZTjjQd3O0hRymHuSXjfSVZcKBw+IZ4WGI52a9KPIM5Glt3Frhg54ohc3LAXP
 /ZfWpeFpiyU/PvgbrVO5kmQ20eEZuBwiara+PLJB/icNI6odAnwH1xEVHoiRjjzcL0R8
 WFxAeN308eR+cxHMCd8rP6ARG21puiSdBS+z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710591; x=1695315391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RUuS/7ahjLfC0HWEV55Pn9MvG+Ttaf4XZk2Jq3dkpAE=;
 b=wBq9wk4bFSOtvZ+i5CI/ddRh3jWHDpN8yi+LKkr3fMb11gNdgRWtJ8bQdvUh/6V26a
 KCA97iOkHPXnQ8PC1qFp5T+3cm1MhwDQmjduhZok3n3M7nVab9QNJ+Cb8Q6Rkft+FZ7s
 9qzGtfbfcN9Mgals+V42wMXXsq53znyuWpUas2SamydB5AyHNzWwXDYR3zFLVxRX8BpX
 Gy5mVR2Jzany37+e3QaiBDeEdK/LfzdNvL4wYxiT9kYLtQS5mVTyMPm+P0br42wUvsE2
 gHdFw9ksdnSyfOGct4aRKSwc3HPZTv9QzzVRtX+7l6qGX1cYmZst2o7+H5kzFDczrT3L
 62dQ==
X-Gm-Message-State: AOJu0Yw3op4Xxse8xiMPxTD4rPexQKlagQxIoC5n++m+qZHTbVsLPGtR
 i+d9ZNOZoF46Wcz6O0szLb2jg3RkfCxg6fQJfww=
X-Google-Smtp-Source: AGHT+IGnH38q78eSZVL1tqBCfRyKjRMWa1BVXArIL4FyiuXMuX13KMd9dwTH1/E4SDA65ykVQa4+WQ==
X-Received: by 2002:a05:6e02:13c8:b0:34f:4223:1447 with SMTP id
 v8-20020a056e0213c800b0034f42231447mr5745840ilj.22.1694710590950; 
 Thu, 14 Sep 2023 09:56:30 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tero Kristo <t-kristo@ti.com>
Subject: [PATCH v5 01/21] lib: rational: Move the Kconfigs into the correct
 place
Date: Thu, 14 Sep 2023 10:55:39 -0600
Message-ID: <20230914165615.1058529-2-sjg@chromium.org>
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

These should not be part of the 'system tables' menu. Move them outside
on their own.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 7d0f3fbb93c ("lib: rational: copy the rational fraction lib...")
---

(no changes since v1)

 lib/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 42e559ad0b5..9addcfab373 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -989,6 +989,8 @@ config GENERATE_SMBIOS_TABLE
 	  See also SMBIOS_SYSINFO which allows SMBIOS values to be provided in
 	  the devicetree.
 
+endmenu
+
 config LIB_RATIONAL
 	bool "enable continued fraction calculation routines"
 
@@ -996,8 +998,6 @@ config SPL_LIB_RATIONAL
 	bool "enable continued fraction calculation routines for SPL"
 	depends on SPL
 
-endmenu
-
 config ASN1_COMPILER
 	bool
 	help
-- 
2.42.0.459.ge4e396fd5e-goog

