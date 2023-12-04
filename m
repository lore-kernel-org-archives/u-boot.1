Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C214BC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 12:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CAE887741;
	Mon,  4 Dec 2023 13:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cbytsYcN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F214787547; Mon,  4 Dec 2023 13:07:39 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BBB38773B
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 13:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50bef9b7a67so1691745e87.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 04:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701691656; x=1702296456; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wl54lXvvhuShnvPBbELeAGBAaSi8G1U8M+ylMkoezCQ=;
 b=cbytsYcN75VwuMQJOV1KNLJ5/Guxl5AbfIjDRyXpc6+qwOh4Q1P+pf3Rq4YyekoeMN
 4U4iOZEbo/4HRrWdPgXrXxv3vA4ptrQTGcVqpxapblojygWw9tCe5D+iv7Pn4kyUvf4K
 Snyl5EsKBOGyn7Uk9F00kDDmKx7HYT/eLCTAZ1h4M0cv33ODWR+EBpAsKBidE8CuU5Jx
 /ldlixgELGODOfijZgP52/+GPVI1tDQ/u3Krri83H+zwmZr0hH0oLRSulJFqnpYw1Sbv
 gyQAuQbSdLl8qeyfxi2kun9uPmC+B6BMM0wPrc+b005hsysLndih5IwMCjIVvrTcwBja
 30iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701691656; x=1702296456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wl54lXvvhuShnvPBbELeAGBAaSi8G1U8M+ylMkoezCQ=;
 b=WRVTYQOuG8jlXbMi+5A4EigA3MbmZpfEXWX6pgsONgMfw8ivvFkmYqdd3ADtakD/Uc
 9V0dS9bSUoZ35bSJaAWx9uUvSXeqJncExnGs9A6B5Zd6+VDKem09tiuAy5PkVeTZ+67O
 a3OYhaNsRJ0h8RPO6qDxXUMjSzPb2noMZ40CQ2tOfdwbJWoT/HrJksnRgQcn/1tzT1ge
 oe4+qd0+XggJ5JbPRL8yBM1gx7gtgimp8QQaSUV15M44ixXc1+C3oy4w3bj4Iry/eRek
 00ef+7PBkArBzDRA05rKT7vW03z+RogNKKZhInxrdor+K+IJkhBkJmBC2JT2G4017He3
 FYfw==
X-Gm-Message-State: AOJu0YzzAiJF/aVo9zX6y0y/myeBmk97N5qtqztIBKDCdwhvZQ25cafR
 Ld2YjGHoaldBRF1BQunOmkVCbX4e5pOdkccJ0ZPQbw==
X-Google-Smtp-Source: AGHT+IG6UQM904VEait5mkCPBeOl3bOpREKLOyrv/6TbOZaeVoaHJufphczLCqQtpdv+sfiDvkwHgA==
X-Received: by 2002:a05:6512:3b91:b0:50b:d763:fe4c with SMTP id
 g17-20020a0565123b9100b0050bd763fe4cmr3421955lfv.103.1701691656757; 
 Mon, 04 Dec 2023 04:07:36 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a0565123ba100b0050befebf0ccsm541675lfv.292.2023.12.04.04.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 04:07:36 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv1 9/9] Makefile: add dtbs to clean
Date: Mon,  4 Dec 2023 18:04:46 +0600
Message-Id: <20231204120446.3277-10-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231204120446.3277-1-maxim.uvarov@linaro.org>
References: <20231204120446.3277-1-maxim.uvarov@linaro.org>
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
index 08604ed3c7..8dd6990584 100644
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

