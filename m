Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7BBCA0FE1
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 12:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 146FD88B55;
	Fri, 30 Aug 2024 14:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p38RZgDq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D749C88B16; Fri, 30 Aug 2024 14:34:38 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8BD088BB8
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 14:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42bb72a5e0bso14635425e9.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725021276; x=1725626076; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+/T4cIWM0dAhnhIjw/m7a+fn4ePAgXVQbnkmBMx8NVQ=;
 b=p38RZgDqWuVlrKI9k0qDPw6IQlrZmFRRWZL6rfm0z+bFEbaivz5H2VY/NjMGeasP5r
 YArR31lEn04QAfOx2wjvxccyVgqyb8JNvZ8CW+CtYMOxAPqY29/AUY9CnJNWYBJz3aj4
 g1y/h3YrphdMGqboLlNDimn0DC7F+Nr5V09mEWPAGhwIAE8lr8rs5s5SmTtKgpYDwI1q
 faS78e0eL5YZD5+koTdsusXnz4B7cglFSk1OgQ2KeLV2lAfgU3yZr6/vt6wxRYPa+mT6
 bcszgQxuaWUfn3IuYnu1sW0KGfQkZb+uZag1YewCZOnGG68Tat+fbs3gK4ifbYrWkSaS
 wIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725021276; x=1725626076;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+/T4cIWM0dAhnhIjw/m7a+fn4ePAgXVQbnkmBMx8NVQ=;
 b=wSyWF39GQlqiVyHqiCLhvzFk1EFFzOAsuZzm38MmBRQuucn1ivVMsz/tO4flQEWa6P
 LC1KT6pVx1MoXgGpt5mzKfELt8qM/6YdECU5YsARgbHEmMjMN+v5pCygL2C7lYNLKYfE
 msYSctVzaamDhAmx7kLSdDC6T0kx+sV3ayNnFlcK8ocGAaf5HXttfJuBesS3+OC0k4/R
 wiqpz8ANA2Y90zXFIM+Gclv8UfJo2RHbcJkACJ+olwVZHA2gdZsv4TTuhQqLe/5brqAP
 pwrFk2MNfdMtmzOQnf45oqcBVeC7x7ERrWi+lr7C4aFYdNZlo2vLSjr5srJ1nCYDF3SS
 7efg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqJbEe8rEUTvKHI96maGfNV68x1JD8BiIK+PhFr/Li+bY/hOx8dkbvJ1bGbk4SH6MoojYrdVA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9OxqlVQx3oY7wCB4tWwnqVo2oKpqVH5JFI/mVe0toXYgvToyE
 /48JuPTjECY63huVKC7eNkH+mCntV6/RcmLsAfcaazyYrjFqxYLWRERewAUr9Ik=
X-Google-Smtp-Source: AGHT+IHb/qJx2Ms+pBXmBzU2LwaL5d506Mmv5xMu6/ZPu8XLi81qECc7u9BRlmzDNa0w1VA5KEv5cw==
X-Received: by 2002:a5d:4e50:0:b0:371:8bc4:49 with SMTP id
 ffacd0b85a97d-3749b4d8a38mr3904727f8f.0.1725021276296; 
 Fri, 30 Aug 2024 05:34:36 -0700 (PDT)
Received: from [192.168.1.17] (host-80-47-105-51.as13285.net. [80.47.105.51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b960ef94sm648207f8f.103.2024.08.30.05.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 05:34:35 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 30 Aug 2024 13:34:31 +0100
Subject: [PATCH v8 01/11] efi: define struct efi_guid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-b4-dynamic-uuid-v8-1-79b31b199bee@linaro.org>
References: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
In-Reply-To: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=wX5DcO369Pdn7hiHbsWotgMj71dTc9VuhjXdEd8GBUk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm0bxZbY/hHtTnqSlDwM3FXS2nWRH+m0CRDgDWJ
 2HCEaXf5yGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZtG8WQAKCRAFgzErGV9k
 tm0LD/4jMuQlmB7Bxri2/c0wO2+7nRtIty5RRd+miDAqqNa+BObl0DiB0b9LD18elUApP7TsXLW
 xsvWzhKs3zfvdzQ3iCiI2vL0orHTTpD4zULYEI7K/ZIV4YZDqvLowIv+jBulJBTixBgz9FWVKL4
 9IfR10PbmVVG4cxJKu5x93AD2sH5sqseOYeulzZYKuO2/W7M0PsLmCIw0yzUeO+LRTJqUKA0zwa
 c5n1MuwlKFr3hAq1iSzm0wqKTMMNpATAFFSLrCDEfrM/7rDf1zsKXWLz20jMiJC/kcbdhubRKEA
 nAd+lfjvbLUQLY6eQtuUpOg20CnKhSFtDyKEwicShijwErvWkRYpckELmQSl48FohXc+guBzWGV
 v3KjFjZRCyXl32nE/N/sdDMCyR7gIBVPyk0BaIFD06QJHQ/loAkJf64bzqkJS5zQuVQENN/o+jQ
 JxYtybQBoFulTvgUjy2nwdFqj7M31GaCYJPs9sgPV/Yw1YbjvfMg1musGiSxCxuOhqqtcbRk9F0
 pcKvpK0L0udIUoXCSRhxev/J+Z5/2f/CV57q1Zis2EDREJUI5EOnLE8dEL1aP6FU8wbzhm0QtzI
 9dA16gDUJHq3CH55TgCsSgKmZy9qHtBuRSUkfm27eawcTF4KeQTwGgplCV/Fu21luYRLkgAGDZ4
 DQTt+0nNsMiQBUA==
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

This let's us forward declare efi_guid_t in the UUID code without
pulling in efi.h

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/efi.h      | 2 +-
 tools/eficapsule.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/efi.h b/include/efi.h
index d5af21399468..84640cf7b252 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -73,9 +73,9 @@ struct efi_device_path {
  * EDK2 reference implementation both define EFI_GUID as
  * struct { u32 a; u16; b; u16 c; u8 d[8]; }; which is 4-byte
  * aligned.
  */
-typedef struct {
+typedef struct efi_guid {
 	u8 b[16];
 } efi_guid_t __attribute__((aligned(4)));
 
 static inline int guidcmp(const void *g1, const void *g2)
diff --git a/tools/eficapsule.h b/tools/eficapsule.h
index 6efd07d2eb6b..97d077536d5b 100644
--- a/tools/eficapsule.h
+++ b/tools/eficapsule.h
@@ -23,9 +23,9 @@
 #endif
 
 #define ARRAY_SIZE(x)		(sizeof(x) / sizeof((x)[0]))
 
-typedef struct {
+typedef struct efi_guid {
 	uint8_t b[16];
 } efi_guid_t __aligned(8);
 
 #define EFI_GUID(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7) \

-- 
2.46.0

