Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46337C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 15:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0796B87846;
	Mon, 25 Dec 2023 16:42:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u1rvfe+T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1309E87846; Mon, 25 Dec 2023 16:42:24 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08A668784F
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 16:42:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50e78f1f41fso702264e87.2
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 07:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703518940; x=1704123740; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=St6T7N12zAnPhC+iJ9D85GlFLIcEFMxDRD31qwUyTgQ=;
 b=u1rvfe+T7HTkgSpdg2LI4t0VYutlnj82qECUXyEWG0fVaWb+dq6/oyYTeLcHGveQa/
 I0yWWP2h52xHJJcKyJSldCU+cEM9W9cnLSsNHnbXNnYEr42Vi/PmNQhekohMCBjh0T8C
 F8M9knZRFLYIdQ02OWv2CMCjdpURW4opANr3cc9sQBo3RaFgfsuo9jnhxNGFABDu3tNZ
 hGtnoMw1lNP2jURMOQI+wuv6zU1AkCJIUqpCIip0dqrcF7dAb8EN1ZbejHCkBUW6UOKt
 G3jjyyWQPhHby2GT+qTTXnO/5AdEPMu+qaeiB6SwReCeoZUSZKVW0GxH1txtaaFgsjuL
 wu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703518940; x=1704123740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=St6T7N12zAnPhC+iJ9D85GlFLIcEFMxDRD31qwUyTgQ=;
 b=Jmx5Bo3amPP7At3sDPBHy0OiiI3rfxz/QLqyc2DT1Le9I9kOZx1HzGs9QfhPyiL9KT
 WKJLrxAiK5R8ZT/MQFhp+0lqt8+4aNduBqRvMMJPsrbCeORPW4G8BFcDdjpcdKXGswAf
 34c7ZGl81Aw2J2nH0zNlQkodcIZ/UVwpWUutcDHjEV24OlL3PhjiK6Ru+MU5CzvimGZc
 KUwB04c4Vd8ysXCC47DeCzeIO/XkV/OHCscH6qVVjydNk4GxdE94vIU+4MbDkEGsjOTH
 EBqUGBs7goHyZrl6c9zWWVV42JVIIxOKcrDleAvvWvfQizD7Pn1IDf/oi7SWIgycTg9G
 KZ3w==
X-Gm-Message-State: AOJu0Yw7afM/oTOmhc58X/oirVae/HcjbKztyNXrs3rnLhUos4DLoa09
 2F0xH7ZmK2ZfYdCjr56jojjm931pUQl5Q4BPmXCrHvLELoI=
X-Google-Smtp-Source: AGHT+IGCc/Lhf5Ykhjh2TmqmXN6hmwyOCCJtFF7OTuyNgTbxO+vr4KR6CqX+xYNnUTNND9D9QzOL7w==
X-Received: by 2002:a05:651c:b12:b0:2cc:c723:9a12 with SMTP id
 b18-20020a05651c0b1200b002ccc7239a12mr532153ljr.68.1703518940704; 
 Mon, 25 Dec 2023 07:42:20 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a2ebe91000000b002cca6eafc44sm1425644ljr.113.2023.12.25.07.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 07:42:20 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv2 9/9] Makefile: add dtbs to clean
Date: Mon, 25 Dec 2023 21:39:29 +0600
Message-Id: <20231225153929.8284-10-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231225153929.8284-1-maxim.uvarov@linaro.org>
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
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

CI test checks that generated dtb has to be cleaned up.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 220411a293..ab603191ad 100644
--- a/Makefile
+++ b/Makefile
@@ -2165,7 +2165,8 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       mkimage-out.spl.mkimage mkimage.spl.mkimage imx-boot.map \
 	       itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
 	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
-	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb
+	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
+	       ./*/*.dtb *.dtb
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
-- 
2.30.2

