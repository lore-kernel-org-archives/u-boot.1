Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C1BCF58E2
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE3B893CC;
	Fri, 20 Sep 2024 09:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OTdA+Nrn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3599893BF; Fri, 20 Sep 2024 09:25:03 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEC41893AB
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso20398305e9.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817101; x=1727421901; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7V8MtCNfi1sqs2E0277b0DCcPf7rgxDJ9fxRTh1I1E=;
 b=OTdA+NrnfIA52KIxbQ2jA7dck0FK3QNe4ObpYEPw66QZi/IZvehFUSl3aS3bjl6XAv
 8Rj302hFqZ6cGMVGEt5yyGUSPRXdRbMDE5IRdWxGFaeelmDXOu9hZGMk0AuyLB/Xfpzd
 VIq6RfDSj9HxUZQb4KRWKPx2fyoZGbxn1KGlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817101; x=1727421901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7V8MtCNfi1sqs2E0277b0DCcPf7rgxDJ9fxRTh1I1E=;
 b=YTV/kUfG/0/xer+b23salYK9CIIf6E3ZX/mZlcDbFLzElKBAAi0I//xaIL6OMPw1j/
 0GluqRkFfiOOVQ+oVm95P5/8xTHq4t7+aOXx2/aEucket+upuZm9hdAXhlPC2IDkeUVO
 icOFdcIKVqYwAcA6PoOwpZtcpdRIllZcWIm2T9banyJOWF3ECpuqP7orwtyYbzRz48uW
 /1iY5G5uH9rlEcUhl2mDcPw0TN2ZeAjVFeyXU/f+mVj2ZjqrCqmpbdtHJkpSEQ7Orfgf
 fSka3I0IAWsrOmr8wbI8qUlRRFrWJWGx6h5jrkDwWEGLO7OKLuF/I+J/aH1ZpzyEVMOD
 NYFg==
X-Gm-Message-State: AOJu0YxASyaQ/+Of2YrhwDoTizQ+ogbUiuFw/KBF8U3Nfikhjxq3zAey
 2+c31Zh3cnfpHHA3UyGmr6f1D8p0QTXoVTH3B9sfKFU2rKuPtQVurjU50IAhBEYrfemeOdmT04R
 z06vX
X-Google-Smtp-Source: AGHT+IEYXt44Ql30qPHsZcB7LU6Xrff1e7J5saTob+ZQS2gCDACO0zagbiZWmVjnAyRHTUgjC3+/Vw==
X-Received: by 2002:a05:600c:c16:b0:42c:b802:47bc with SMTP id
 5b1f17b1804b1-42e7adf9486mr16232235e9.34.1726817100951; 
 Fri, 20 Sep 2024 00:25:00 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:24:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/18] gzip: Correct function comment for gunzip()
Date: Fri, 20 Sep 2024 09:24:27 +0200
Message-ID: <20240920072444.134997-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920072444.134997-1-sjg@chromium.org>
References: <20240920072444.134997-1-sjg@chromium.org>
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

This doesn't describe the length parameter correctly. Fix it and
zunzip() too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/gzip.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/gzip.h b/include/gzip.h
index 5e0d0ec07fb..304002ffc42 100644
--- a/include/gzip.h
+++ b/include/gzip.h
@@ -28,7 +28,8 @@ int gzip_parse_header(const unsigned char *src, unsigned long len);
  * @dst: Destination for uncompressed data
  * @dstlen: Size of destination buffer
  * @src: Source data to decompress
- * @lenp: Returns length of uncompressed data
+ * @lenp: On entry, length of data at @src. On exit, number of bytes used from
+ * @src
  * Return: 0 if OK, -1 on error
  */
 int gunzip(void *dst, int dstlen, unsigned char *src, unsigned long *lenp);
@@ -39,7 +40,8 @@ int gunzip(void *dst, int dstlen, unsigned char *src, unsigned long *lenp);
  * @dst: Destination for uncompressed data
  * @dstlen: Size of destination buffer
  * @src: Source data to decompress
- * @lenp: On entry, length data at @src. On exit, number of bytes used from @src
+ * @lenp: On entry, length of data at @src. On exit, number of bytes used from
+ * @src
  * @stoponerr: 0 to continue when a decode error is found, 1 to stop
  * @offset: start offset within the src buffer
  * Return: 0 if OK, -1 on error
-- 
2.43.0

