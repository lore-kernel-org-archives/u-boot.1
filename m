Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1566C021B5
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6592F80FA6;
	Mon, 24 Feb 2025 06:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cdh52HfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C77EF80FF4; Mon, 24 Feb 2025 06:56:16 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29362805C3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso114507435ad.0
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376573; x=1740981373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLihTFD8zTp/LZzaP2lCXYyfsV2kpgkUh0cTOU94HSk=;
 b=Cdh52HfNt4OKLi3jDXIJafOY0YSUciS4ZBoe13UWKHXMpjmMIvvHQUuL4Olwye+We9
 ke49jAmOxI0/7/2/LSxfSTsBr9Ipz87WdslP/vPsLn+IU5q3S1V858MEI8XVrny0oG4o
 iA55/wmx5mYUrl/D4BYEVBItZw7hdSQTqsTU9xjhCh4YWpOxdrEGJ3fU3m0B2WyEoIWk
 ezWFKgmIyhBKHzbizVZK5tRFmUhJbNqKZ5CUyZI+bwu4+tR+SgKDLF/S7voOdTPz2I4Y
 2ggwRIrLk8gnjmltlah1cka0kCcBHzn/jOTlkwP7qxCkinFNnddTjVQ79Q85/eoPhjLc
 pKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376573; x=1740981373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLihTFD8zTp/LZzaP2lCXYyfsV2kpgkUh0cTOU94HSk=;
 b=gjylWt1Zu6GMd3P1q4XktvdiQtQPBoSSz2c0tLRbX0ToZSKmSlKjcuW3yuh9s2U1P0
 dL1Fp+M1Zs/Q8eYjjsUl3+7RCebyrdwKVE/tMakm97BdRQxtz9xg9SPt6YhQCrpYVRrC
 TBSB9NIpBpSwx0V39lZA6gqrvuNOUyqps0QAe3hIacMm8fN4FEixlJME1lKFFBqFHe1P
 vw+QAz5ZYMH3AvEf9zZvjgZNL2QRNP853CUQOQSD0l8NBeimXUqHQiOWv8lT+aM6X/iC
 wN/DUoHhQC1PeA7Jt5j4I2Jl4tJ4YFisSXPjZ1xipC7KF4lv014+K6xV46QC8EuupjhE
 N8tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfz7qOlax70V/7TqTKpQgT14Yd8hGrvqDmabJmv7KjkUoxokGjw7nvPaD8mEx98mFqTg6sS5k=@lists.denx.de
X-Gm-Message-State: AOJu0YxhveJQqOvg4zpRTXcIoJN/SbeEZetDbxftW12ozrURfmEgXnVq
 estvKHrPuEr6l8tLXfsSyJjkEzUw7vzaPU7mh5F0btDQFByYeB24
X-Gm-Gg: ASbGncug/Ev0C6hSHxaSJDGgZxSYbkvyrJsN+/VGpQjhaznVAhn+jKSlDSUt/Xn5dvO
 HNq5GnYNP8xuL+UyuJCCeutbOvm3Z6KwQ3Fq0qqFDMPZ/pNSTkldg6rOuwzhH8m46Owtwsa8Ypw
 g9Qxka6CY46WnZBP05H48fPrbbpDSl9NsEEkn8CakM7L0GQJa0z0hQm2sMiveUp3WhwJmjfL+Im
 Slak4LBt7+QS/SjWwNzXc8uBxW2iernwZNf30bOVQSzJdu/JnWNQ9eP6NFv2DTwBDAoyGfLx6BW
 pHdBxWaANLxcKI0fqgv9DHoQEFbl8218MclcsA==
X-Google-Smtp-Source: AGHT+IE+eCP6PMV58WWu9Ks5yzfA48ltT3/zbnGNK0CXNXJ4YoIDqUkK37VP8Y1Wg6yS9+bSGsWcbQ==
X-Received: by 2002:a05:6a00:3c84:b0:730:f1b7:9bb2 with SMTP id
 d2e1a72fcca58-73426ce97d2mr18244796b3a.13.1740376572675; 
 Sun, 23 Feb 2025 21:56:12 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:56:11 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 11/17] makefile: Fix symbol typo in binary_size_check
Date: Sun, 23 Feb 2025 21:55:18 -0800
Message-ID: <20250224055524.1334929-12-CFSworks@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224055524.1334929-1-CFSworks@gmail.com>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
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

The start-of-image marker symbol is `__image_copy_start`; by searching
for `_image_copy_start` instead, this check can accidentally match
`_image_copy_start_ofs`.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b32606b69f5..a9194b46ae1 100644
--- a/Makefile
+++ b/Makefile
@@ -1314,7 +1314,7 @@ binary_size_check: u-boot-nodtb.bin FORCE
 	@file_size=$(shell wc -c u-boot-nodtb.bin | awk '{ print $$1 }') ; \
 	map_size=$(shell cat u-boot.map | \
 		awk ' \
-			/_image_copy_start/ { start = $$1 } \
+			/__image_copy_start/ { start = $$1 } \
 			/_image_binary_end/ { end = $$1 } \
 			END { \
 				if (start != "" && end != "") \
-- 
2.45.2

