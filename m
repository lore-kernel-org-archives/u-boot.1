Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984B1E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B76A80282;
	Wed, 11 Dec 2024 14:54:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KBqEPFnE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E75B80282; Wed, 11 Dec 2024 14:54:41 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 111B780282
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-8419f5baedcso210860939f.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925276; x=1734530076; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFnn1J6zYVC6t9VU+c6U+Fap2IH3A2s+q8ReKK220i8=;
 b=KBqEPFnEnGb8fXeDSp0J07zw616lEurZya57pA4W+bxPi5c1R3DmgPePEN3o6LTpDd
 aDcjdoI06sWMRyhBW/vxGK5wsVDpaJKGZ9Cxl6bJyGXxc78gJy8ke5PaDhRxyl1wSTGI
 aukH5oEGKHNi9OU53feWKZVqLtDlBaU7fB2As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925276; x=1734530076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lFnn1J6zYVC6t9VU+c6U+Fap2IH3A2s+q8ReKK220i8=;
 b=MBFMDDkgoTzWzw8YU9PctxCIPgcL/AQBQREuxF7ExRxZ8bxDjPjrVLoo+f2YDDPbwc
 jiG+w0OmBw0jUuNUpEJATHz9KDogX/LA08SiIfvSJz9Vxijl6kMW1JKwd46ojW3zKFzq
 ha+NRMWxwVZ43lQKDaw6lCvxtpF0pnHa/OQwYbZaxXYqD7vld1DtlJEwaWytdStik+0b
 5vI18TSUdbPZf1IUr/vY6whx8L7Z8JusTrXfxyYAX2E/GB9U6HK5ufGXZ4FkBOGy89MX
 WqN9hmit3oqeFc1cxiIcNVGG74ClFMcbxFNSxy3Y9ABWOdLnzo4YwFLo55h/Aki8Xxie
 lyvQ==
X-Gm-Message-State: AOJu0YxtPO715rLC5jkWZRA6nN/Nt1gAQ8eok0s+6pFqLflpopkrhxt5
 Ds1Ne0BJteMBcSMn/IiIs6zBK6oPkohd0pEZHtBzL6T3KNiBAIkKoryUsQx6k8mXBZAwuSD/ixI
 =
X-Gm-Gg: ASbGncvHWnap8TS/4tlDgF0cfLt/10t3vq+NDkDEjBfpyMCirqOcv8UQFeluFzNebb8
 Vt0nSPUyAEh6ysgnyhROgMbLmEJObvatI2btFhYLrrRIjd6UGH8zgDbAXnZh+Y+Lv/UZqswRZNp
 C3bl0iCbDw/voHNwfEnA8ksLAIQZHjggX1WUROTMjcc4e62qM2lJSNtOXZ+VGlD8A4uBTph6jeV
 R2ocxhukNQfQ1ufPpoYLHgxEWgulnVDiyVLSpgG0hX/kVG4W6rW/O5264CBJpn/sovwfyOvlkhQ
 wsmxg0KZxFQRz78=
X-Google-Smtp-Source: AGHT+IE8JrnG2q9dF3T1UW0vDUzPqDoFy/Q4ZCv3l3oslaXAChJiSavqBvqQX/y+PSGNLPxH0P2NTg==
X-Received: by 2002:a05:6e02:156a:b0:3a7:e592:55cd with SMTP id
 e9e14a558f8ab-3aa06538615mr28797095ab.14.1733925276612; 
 Wed, 11 Dec 2024 05:54:36 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v5 07/23] doc: efi: Add the EFI-loader API documentation
Date: Wed, 11 Dec 2024 06:54:01 -0700
Message-Id: <20241211135418.563803-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211135418.563803-1-sjg@chromium.org>
References: <20241211135418.563803-1-sjg@chromium.org>
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

Bring in the documentation from the efi_loader.h header file, so we can
see the API defined there.

Fix efi_alloc() to avoid a warning.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v3)

Changes in v3:
- Put the header-file in its own section

Changes in v2:
- Add new patch to add the EFI-loader API documentation

 doc/api/efi.rst      | 6 ++++++
 include/efi_loader.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/doc/api/efi.rst b/doc/api/efi.rst
index 43d6f936fb0..49814bcf5ea 100644
--- a/doc/api/efi.rst
+++ b/doc/api/efi.rst
@@ -54,6 +54,12 @@ drivers, handles, loaded images, and the memory map).
 .. kernel-doc:: cmd/efidebug.c
    :internal:
 
+Overall API
+-----------
+
+.. kernel-doc:: include/efi_loader.h
+   :internal:
+
 Initialization of the UEFI sub-system
 -------------------------------------
 
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 00a1259c006..3f75f2efcb6 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -764,7 +764,7 @@ efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
  *
  * Allocate memory from pool and zero it out.
  *
- * @size:	number of bytes to allocate
+ * @len:	number of bytes to allocate
  * Return:	pointer to allocated memory or NULL
  */
 void *efi_alloc(size_t len);
-- 
2.34.1

