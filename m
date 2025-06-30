Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9596DC8302D
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 10:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD0181FEE;
	Mon, 30 Jun 2025 12:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XE9WEi7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03C3F8206E; Mon, 30 Jun 2025 12:23:44 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 094ED81D6A
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 12:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so1023692f8f.3
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 03:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751279021; x=1751883821; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wYRMckOKfj3VWm+U+GZwv1NVSzTwpuBFDmFFgP9sRjg=;
 b=XE9WEi7NiePpFgCEq7emq5UWJKGeelRLXcQ/3aBaHbPncUvAwMdJIpYu+dkgLEW8I3
 bKtMIHt1wjxw9q6nZYqFuvBpQsQrPMg1ZLTzTsOW3V44qobJo5OJAkKmWO1IkZ47zQZU
 FhfvFnPOskrEnhL62NtF3zk2SUBXTnUtvJDLE7Cg8oofLNvLGafEF1ssFErZ5dEGeS84
 1TrLL9MzOPWgV03Szf58H0oN0Me0O8AKe6Y4rC6UjSBbCq7snELPh2fVVPliocny7HfJ
 vVDLZr3/6nFbrRUut80dMsmNXzrS4cyLPw2FG+t0mZlh5Q9WtFLrc4CtTNhmNtBEp+gl
 vFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751279021; x=1751883821;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wYRMckOKfj3VWm+U+GZwv1NVSzTwpuBFDmFFgP9sRjg=;
 b=mvwFnsgoNkJiRcN7jjZvrxZsGNJtulroY/FerbutMp77JHlxNr7ryU5b5k0vGMEXgN
 /BlwsSmKStHPErIXrGF6r3ttvecpa2aJXP3XscwjkdKBe6EslXI9MIXS/Hq4ZMbnsELP
 xDNCVr2GGemga93iCiyDZpZVKWVCqVTJyDAoC1bhbKTxUpRJ2i/j4b3+8bgK6RAPVNaj
 vsDE63TXHqkKCnhwJIdd57fP3SzQjNSgEygCmcjD7RjQVFEpkEHoX5pgair7huJ6j77u
 LBD06c5UiM89wOdObtd8P+3SqE2d0d5UqxNgQlru3pYkgpWj0T1xwGlJ64WKXozqOf0+
 wqwA==
X-Gm-Message-State: AOJu0YzSfyRXCFzFZF0dtvum6Rj/np5OGMdOvbsCHI+DG8xRkqsd8vDR
 tTDzZZEmiYNsXxVq0/upUD8oORW3Hw36s/fDcxQ+Hitqv3RRnwO+x3bRVHTqEWiKMu8=
X-Gm-Gg: ASbGncvEseIQNPcJzQzpNTr4Yq5c0zonJ00OiUw3p414t1Mjzqy7JbKXivEpN1JZ99f
 Uh/rmo1YSVySoeIbSQ0NfzaOOMFF7/T91C0bdtFKhCkW3yA/ok8ZV1hLHejw2d1984LhYj/vzCV
 lCyVp5uBP1lKapD5O9Z8/0gg72WdzeGjCVlBNc2tyygWA471swH/6rJEbFErf9jteMYb0+uXx7K
 lpz1aSxj5qcihBzRdCSKIypYui39rXJZOY0y06dO8p6IK4JLj338YTIpKsgk9WoLGLEcFjU/Sel
 eUePP2be8MlJGIQWuEV+gPZBLc//yZoVpA7oJyx4WTkVqlAou7eQ22zBQA1zppPELZaWhzJJZ6g
 Vvpy8hEDMqbh63cSn0o+G0YQDuA==
X-Google-Smtp-Source: AGHT+IFd93UWLB2NiRXqtKi0x1ofFeE8p3G66FHFasIbytsfTcQOBcOYHmPjHaXjbsDUegSmIoMgvg==
X-Received: by 2002:adf:9c92:0:b0:3a4:f918:9db9 with SMTP id
 ffacd0b85a97d-3a8fe5b1dcdmr8306814f8f.32.1751279021408; 
 Mon, 30 Jun 2025 03:23:41 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:10fb:ba4d:cfb6:8c75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52a5asm10114085f8f.54.2025.06.30.03.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 03:23:40 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 30 Jun 2025 11:23:39 +0100
Subject: [PATCH v3 1/2] cmd: tpm: Fix attempt to return value not in enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-tpm_enum-v3-1-9ef117f6a7e4@linaro.org>
References: <20250625-tpm_enum-v3-0-9ef117f6a7e4@linaro.org>
In-Reply-To: <20250625-tpm_enum-v3-0-9ef117f6a7e4@linaro.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The function tpm2_name_to_algorithm is defined as returning an
enum for the algorithm specified but it also attempts to return
an error on failure, but that error is not included in the enum.
Add the error to the enum so that it can be returned.

This issue was reported by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 include/tpm-v2.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index ece422df0c7..f3eb2ef5643 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -20,6 +20,7 @@
 #define __TPM_V2_H
 
 #include <tpm-common.h>
+#include <linux/errno.h>
 
 struct udevice;
 
@@ -266,6 +267,7 @@ enum tpm2_return_codes {
  * TPM2 algorithms.
  */
 enum tpm2_algorithms {
+	TPM2_ALG_INVAL		= -EINVAL,
 	TPM2_ALG_SHA1		= 0x04,
 	TPM2_ALG_XOR		= 0x0A,
 	TPM2_ALG_SHA256		= 0x0B,

-- 
2.39.5

