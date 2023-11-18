Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EC0C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC0087555;
	Sat, 18 Nov 2023 22:06:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="am4TC4Ij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 404F9870F9; Sat, 18 Nov 2023 22:06:33 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22A01874A3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7b006f7c473so108759039f.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341567; x=1700946367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAJ99tGmbChp3MuzFYlZxoRSKCEls7mEO/WGI/69pHQ=;
 b=am4TC4IjdvJAqpPiC2bmBvdgLRvf5qtRrYdJd8ytGbXxPj7O7DQ891jCfn/lwG9thb
 vm74fVVEU6FSl2WaJ2St5PAfxQ2YDooNjUpqR4J3oXNaT5UvduMh1cNoBOCtoFqSLv1W
 n1L0djgLXsycj1iF3a6Q9U04sFbkQXBmTrrkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341567; x=1700946367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lAJ99tGmbChp3MuzFYlZxoRSKCEls7mEO/WGI/69pHQ=;
 b=E7rYr4C0vrJVcjSSLrKlVMuyjSAInGTegHRtv93YhzMJO9Jw3Ny58v6+WQLZA3KQv5
 zOvX/L+G5dA8Banq/CmEVIuvO/SnRNQCBKDGehQod7sHdrkuX+GnaNmrb5L1RybTtKkl
 yl5NLusW1rRfQOHZFQCEpFvCPS44taChuvcuBXD3JqVs2I140kOyaeOr84RctE2soEnI
 sbHVR104b2QGzfnUzTKEC08jh6zkDf0jcaMI9f2vVySDBkSZS81oNlNQ9k/gRjdJW9/E
 NXZ4uP6ozfmZpVAHLrwO42vT+p3pBHV/b0kEE3Hg4J96CgWrGZ6vnW/6e48Z4BFmLWkH
 6atA==
X-Gm-Message-State: AOJu0Yzug6THUmmq1jRY3cHet/UalA/rM5t1sGIDBoT7wQ0SZuj76HEg
 eA5p9F/20RGNUvPiX997NvFUTOwtzDGj3JTPbsZG/g==
X-Google-Smtp-Source: AGHT+IGS73EZK8M0TjQl4F8NZUiDEY9W7iyJqz9m76YuB/oIgSdmj+7HQxIV++3aWLZ/aRB8zcCLyg==
X-Received: by 2002:a05:6602:6421:b0:792:9a3e:2dd with SMTP id
 gn33-20020a056602642100b007929a3e02ddmr5375288iob.3.1700341567301; 
 Sat, 18 Nov 2023 13:06:07 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 13/32] bootm: Adjust position of unmap_sysmem() in
 boot_get_kernel()
Date: Sat, 18 Nov 2023 14:05:01 -0700
Message-ID: <20231118210547.577026-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

These unmaps should happen regardless of the return value. Move them
before the 'return' statement.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Add new patch to adjust position of unmap_sysmem() in boot_get_kernel()

 boot/bootm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 1f3a01994cbe..6ed60bf05084 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -222,12 +222,12 @@ static int boot_get_kernel(const char *cmd_name, const char *addr_fit,
 		printf("## Booting Android Image at 0x%08lx ...\n", img_addr);
 		ret = android_image_get_kernel(boot_img, vendor_boot_img,
 					       images->verify, os_data, os_len);
-		if (ret)
-			return ret;
 		if (IS_ENABLED(CONFIG_CMD_ABOOTIMG)) {
 			unmap_sysmem(vendor_boot_img);
 			unmap_sysmem(boot_img);
 		}
+		if (ret)
+			return ret;
 		break;
 	}
 #endif
-- 
2.43.0.rc0.421.g78406f8d94-goog

