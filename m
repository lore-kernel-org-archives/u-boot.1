Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1213CCD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBB87883CC;
	Wed,  3 Apr 2024 14:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LT22a5lb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C2E5883D2; Wed,  3 Apr 2024 14:08:11 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 725FC8839A
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56dfba6ae21so1405472a12.1
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 05:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712146086; x=1712750886; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2rIilUL3fPgdL00EeRjYvSoOr0+tfQS+h1cCC5JbimE=;
 b=LT22a5lb/5oD1bnMULOtUKfZzVZ0q01R83XjdDyJhkZc+H+OZ95qSlI9gALymrUFbU
 arWePJ9+My6TTWAGrPhAZkwPLNEvYWF5toF3AvxgZn1EYrt6mSjdXvpNFWOo+b2HamIm
 I/2iu7ScRV4/utc9eaKvPrPSonFeMg1BbAW7N7VTon7xHNiFoieu02l/JveuOlfiBU3C
 mUf1sAMXovy2SoZ+oM77uZ3EvFc9f24QsqbG/8zQnQq9BgMYCMnWOuFlgNV/jM5NzCJN
 LiThUl/A18bpSsuBiijDPskgJv9UUA7jnmPU5JwemEDYT5hAvPPnLDx0ONOuUkEon6PX
 9XtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712146086; x=1712750886;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2rIilUL3fPgdL00EeRjYvSoOr0+tfQS+h1cCC5JbimE=;
 b=q2cpvHI8ppukShdfdOMksXDojBX/5Nbrmf5TEgUhHI4RT2xBpB1o4ZuCslZGx/6PRP
 aLX5H/iO09u8Dx0K/N2pVy36ukdgkr/7uWIJkEXi0J3RbJS2gQJa+2y62HOrM7c8V8L9
 MNTd/yJGNNk7LwvnG+V+j8rEmnyouSsAVoE1DVFlsocetk955hq6ZD17NGVJOIheBcFl
 JsaSskTg14QvPYEnXGkqGYx0qd4n1w9nFtJZe6oMDDh8z5c/IebPk+7/VQnFCon1bA5K
 rxr69MXuOmvYVd4mdffkUg8KEzlSvjXhauLHGi4DfEQkKCycQYVdelPqMrXIb6wtqdDR
 1ZFg==
X-Gm-Message-State: AOJu0YwvkNaXswKf6WOyFYG9sS+GufK7vRhgSqiJiBCGZAIogDtdIVY0
 xp5DBYoXr60/0WgXiP362r09Fox7G0AW7pw9fWpHEMvqnJhHGxcybQ7YDsK2QeQ=
X-Google-Smtp-Source: AGHT+IH//nvGIx2NsypSiF5nucxlrb+Qj6aUoJrpi62ois6iJCdGk3iDhVV4bpjhAnDEImQljR871g==
X-Received: by 2002:a17:906:e086:b0:a4e:9a1a:e312 with SMTP id
 gh6-20020a170906e08600b00a4e9a1ae312mr1738155ejb.57.1712146086048; 
 Wed, 03 Apr 2024 05:08:06 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::38e6])
 by smtp.gmail.com with ESMTPSA id
 lr20-20020a170906fb9400b00a46a04d7dc4sm7654674ejb.61.2024.04.03.05.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 05:08:05 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 03 Apr 2024 14:07:51 +0200
Subject: [PATCH v6 16/16] usb: gadget: UMS: fix 64-bit division on ARM32
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-b4-qcom-livetree-v6-16-130f8f50b538@linaro.org>
References: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
In-Reply-To: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=2332;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=GILrVlJTLB7vGoUqwXYfiSFWeP5Fqv5LLGhQ18mVlh4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmDUaS/UZ3ATb1s4JU3qwNUdRjMg3ls3FbxVeRu
 oznn4aBsWmJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZg1GkgAKCRAFgzErGV9k
 tqHeD/9W1k82Ypg93K7ja/mXBrh31Lz9jFNXmGXQcMI/85VhfCyKcJD4d9poTWB3gKuEjcNk5uk
 sANbDuTJAbUIMrkVyF2j8vmpZHOTckDpyrBW/tu1RFtTGt/d03sW41kF0a7DLbmAMQf1v7iqYpt
 JiFsaURH3mCJn/7+fATHORobCVV7o2kQRU5vDGR5smGxGSjrCjnCRftsdL6aCFyGwcj46rD6Coy
 /Ag9WhR5+UQPeHEp7BMsA3LDLVm4eCCXZjeFCgL6dlQGujiJxuYm5tdxrJUF0WPS2OPgZzE3Mi4
 dYTz1WcOiw4+q5DTUH2kfDADIQ1ViKb/2eS2CxrzdL3+mnV65OiOKCObtEBw6tZ7MoLN/HqZx5+
 1p3gKmURENsAyvx7ndOmc5W9HyiEG1j0EzyErJnsobrVQxH1YMOrIKnQjj3l6xZ82JjsdaYaLbC
 +SxAwwdjwpoGNn+sajFhsS1b6xeyNSNErideNm5iX/5WrdOGS1rN2dFr54KmKrrvJ8PpQw0cVfj
 X7eJe755PZkrhLGTG/fuLn8rlksxwrfveq5bkE2Em1aPxB8Y40isL9QllOJ2rtG5ssF/o3S0IHn
 jNtbfVAiptQ6QOQUnyuwVwPwhIoIV2jqCxS0I+KsxK3sALZX5+vkDd/gmw83ymQKUB7gUS30zpD
 agJ5Bav7l0fmemg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The patch introducing support for dynamic sector sizes changed the types
used in some divisions, resulting in the compiler attempting to use
libgcc helpers (__aeabi_ldivmod). Replace these divisions with calls to
lldiv() to handle this correctly.

Fixes: 74e56e0c5065 ("usb: gadget: UMS: support multiple sector sizes")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/usb/gadget/f_mass_storage.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index d880928044f4..ef90c7ec7fb5 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -239,8 +239,9 @@
 /* #define VERBOSE_DEBUG */
 /* #define DUMP_MSGS */
 
 #include <config.h>
+#include <div64.h>
 #include <hexdump.h>
 #include <log.h>
 #include <malloc.h>
 #include <common.h>
@@ -768,10 +769,10 @@ static int do_read(struct fsg_common *common)
 		}
 
 		/* Perform the read */
 		rc = ums[common->lun].read_sector(&ums[common->lun],
-				      file_offset / curlun->blksize,
-				      amount / curlun->blksize,
+				      lldiv(file_offset, curlun->blksize),
+				      lldiv(amount, curlun->blksize),
 				      (char __user *)bh->buf);
 		if (!rc)
 			return -EIO;
 
@@ -942,10 +943,10 @@ static int do_write(struct fsg_common *common)
 			amount = bh->outreq->actual;
 
 			/* Perform the write */
 			rc = ums[common->lun].write_sector(&ums[common->lun],
-					       file_offset / curlun->blksize,
-					       amount / curlun->blksize,
+					       lldiv(file_offset, curlun->blksize),
+					       lldiv(amount, curlun->blksize),
 					       (char __user *)bh->buf);
 			if (!rc)
 				return -EIO;
 			nwritten = rc * curlun->blksize;
@@ -1058,10 +1059,10 @@ static int do_verify(struct fsg_common *common)
 		}
 
 		/* Perform the read */
 		rc = ums[common->lun].read_sector(&ums[common->lun],
-				      file_offset / curlun->blksize,
-				      amount / curlun->blksize,
+				      lldiv(file_offset, curlun->blksize),
+				      lldiv(amount, curlun->blksize),
 				      (char __user *)bh->buf);
 		if (!rc)
 			return -EIO;
 		nread = rc * curlun->blksize;

-- 
2.44.0

