Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A58DC41513
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 12:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A8D8871E;
	Mon,  8 Jul 2024 14:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xqEp5EXU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C91C88702; Mon,  8 Jul 2024 14:20:30 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 121DB88712
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 14:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a77d85f7fa3so400901766b.0
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 05:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720441227; x=1721046027; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qvkoZcQ7OJD8CXSX3t0Cqg2dNoEjO5pN9QkaEuTXc8w=;
 b=xqEp5EXUkWB15Vv90Le0geBkU0t8UnaV62Pz+Y/sV1jC/gsmr9Qk8BhfGhD/WReEnt
 73aUlQYAq5cAMG191RQsu6WpVoErdf7RBxtmQcZ6rgkHKnLCErQXqCFA2OCW9iaM6BK2
 sc6wY29R5EYnouSZUIFNhzN3i+Gi46gqazOk0i+Qat0L3PzhF77WUGAKLaWnPTzLGwFP
 S9pqWkMKjumTo9GP6sVSePVBHaf9L0jrZcWG/GhgNoNgZ7JdZ3B3jxiY7r2wBG8s9BoV
 WryhL4U8gu3ld1WVYgxAbdhoChQ3mULRuXA0UNMJ2E+TmjVWHeRyMfhcepUrAqHCHTiN
 ztVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720441227; x=1721046027;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qvkoZcQ7OJD8CXSX3t0Cqg2dNoEjO5pN9QkaEuTXc8w=;
 b=B/l1TEKW6aKMXxv7hG6dJuvXLdcBU1g6+AzqRov3WnLN7/9laZideS2Z3sZ6IsDuF7
 DNnoqa09qf4WqYURSfUNWTLwvTRjx5nhxb+00vu77LD92ludZqZc1Jspyi2SHhxB4apC
 VHXdUDkuKNuhCXCQicMPcqLcpF5KL2ML66bBQxbdyTF3LB+gmn/WiIQDgNBPBGldHytx
 Eh0ruXPNqKj7fEsXTqtx/T58iOYjHoOKnFANMQgLQZPiou41HiikmslAAKCWnDQpl+pI
 AJKsJ2biNjprtj9egCUAU83DBwWVu66AKAUyTJct8xT8KumQVXjkWz+YXAq6YEEe94WD
 uVjw==
X-Gm-Message-State: AOJu0YxoqcKTjy3/02hlR44cSz1ZWEe2VApxrj1zGTpYJbsGPDJKZK/o
 LEs/huj3ta6dQ2MbCHpwDnuESdKwIvwbxkneinM6gkWx6bk4zK/ps8wnbY8W1ig=
X-Google-Smtp-Source: AGHT+IGGsfkN6Xg7VVopFjVc3sEx35jhMXg0InVSEDrcbVksvApo802MHFm4EYN4pihQpnkNtqybVA==
X-Received: by 2002:a17:906:3698:b0:a77:b7fe:66c8 with SMTP id
 a640c23a62f3a-a77bd9e46b4mr907971866b.15.1720441227565; 
 Mon, 08 Jul 2024 05:20:27 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77e8a7eeafsm188364766b.47.2024.07.08.05.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 05:20:27 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 08 Jul 2024 14:20:23 +0200
Subject: [PATCH v3 1/5] linux/bitmap.h: add bitmap_empty helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-b4-qcom-rpmh-v3-1-846cc6c5b728@linaro.org>
References: <20240708-b4-qcom-rpmh-v3-0-846cc6c5b728@linaro.org>
In-Reply-To: <20240708-b4-qcom-rpmh-v3-0-846cc6c5b728@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=882;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=z6XvfLGv5QyURxvw0REJ2jitM49N/Q7K6mgwTQZxddM=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmi9mJN9zIAYa0b2nAcE5/A0Exy6vV+TpntSHDn
 zrUz1EJKemJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZovZiQAKCRAFgzErGV9k
 tmJQEACRgEPMLLJxfO1g7XqUzdhoBezP4eIpC4zkiTMzd0FM3VhXNnncmDRStKyDIdDyQAZ2yaQ
 6ghipWlcOMiqP2I/acWpzWVZFGR3Eit47biaMtnkvOxlmxoWf72903ZDVj88CGW9cP3JvOIyxMF
 crpfJZN5qhtbk/EFtD0njq7gQdkSp3FjOYKooQ4+hzLGsW/B3egXdeMUOtWG7n0U5Efor3PCfbd
 RJcuvDeCu1ob7LXHSDv9w+nelBkF3o728cgVceqD6+Tg+i6n7tx1NGBL+x0dJW5oTY5OSwhlZCT
 8UyAZ7wl2rvX7kmEn5FrYtqn4cQgtCMF9BjiYYzN+0gaRxgvqIMEB0VZs326IJfONMZ81J3qvVe
 XwMfm6dQ0mF6bkplWNI6oLPzN2dSJU/i7IqYyOvEpmF9fyWhWJGD0Ycht7+wx12s0mBzy4vfild
 SJ4CcQEMe7Oz3EzswDXQ4GX1hjv1FKo7AnN7bMkUt0KYElVw14aqXQZz3/BmTzvpAWadcO3l47M
 xcpH7GaLS7NwABzxk1mTx1V+zwF3vz3g+SNqvWvZfOp9HjMZHzBmpgX5IjVRHY4CUl0Pwbvf6Uv
 fp2YAM//J3/LNp96Ekxcf8F3u8Soegs/Bv2WnKsFhTAvMlASrg/+jC0dF8ylrBG01U9wxFd4pWI
 JUi3qDFMq4jt/Pg==
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

Import this function from Linux.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/linux/bitmap.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 0a8503af9f14..40ca2212cb40 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -195,8 +195,16 @@ static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 		memset(dst, 0xff, len);
 	}
 }
 
+static inline bool bitmap_empty(const unsigned long *src, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return !(*src & BITMAP_LAST_WORD_MASK(nbits));
+
+	return find_first_bit(src, nbits) == nbits;
+}
+
 static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 			     const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))

-- 
2.45.2

