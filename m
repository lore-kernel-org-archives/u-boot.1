Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE8DC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B7ED88BA5;
	Fri,  9 Aug 2024 02:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wL4b+vkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54AFC88B63; Fri,  9 Aug 2024 02:56:34 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 669D288B8D
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7a8553db90so191651066b.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723164992; x=1723769792; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+/T4cIWM0dAhnhIjw/m7a+fn4ePAgXVQbnkmBMx8NVQ=;
 b=wL4b+vkdTu82GzwxfSnlkoGXDNdSxyFwvzY8rY8IwC7In6OEAwrwprzuAutapJJb8y
 6lzCi7xrxpx5CLbuvxNkTCyVKEs0ZHZA8WYTGs7makQZxqjKMUhiveafVXC++aVw58oH
 RQ2SBH8MNb87ghqmyai8lsK8O174c7qksYppzHIiXcfJQMLDV6FlcuMPDlMc8J6UhqW/
 OryIUad/IIPStIGEwSqhSKgxshfib4aglEqHsZGTu+9sPyA76J4ME6CTzTDsJSU7b167
 22py0zuVa3HSBH3aXgvFgJ/gsS1xLRq+0Uddm5xHvElpck3FYehGIT/sKR/SL3KlumBm
 bnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723164992; x=1723769792;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+/T4cIWM0dAhnhIjw/m7a+fn4ePAgXVQbnkmBMx8NVQ=;
 b=b5NRjtiH94jHQ2jOKLoB2egpcpuwNocbsA0N0XkSRFznIeyhKOUcXkJPaYcHlayM33
 gbGNWcqeRTIg4FhBpshTpK+OyFDFPR8AmQWSyl4GnIWA8sU1VWtvwtcGV99Z8a+kUTwv
 7LvhOh2AAUAgCYTnbvK5cUkCAtKVlflB83l2FQQDlGOAR+7uFl6RYO30fw0EAGfRt/Gl
 lGruwTtMQgWTDGIgf8wf87ME+0d/kNwet85ynK1ircufSzwrcJFYN5xbCyUHns3b1dCs
 dOQgqSuhuHmM7ybtsB3OHtwbSpQM6HiY5oIXLeLTO+sxPVlvZ0P7j1YX1vMPNmqU9P6p
 q5VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPeF8DGCVZxn/eVdExLVAn7ftn7MeNVghW4KB9aS1symV6/6yYepxAr0CGODWXrq3Or5Z3aJBFAIt8wJ8NQDyPRQi5zg==
X-Gm-Message-State: AOJu0YzKDAKjT4+z7DaVX8pPaHPNlX3pXwUYxsGQX5S1qFKx69Y+7Wqf
 raEuMvW0tyA60KGnNujMhLHN3yBPFTsQAtrmmwOVoEif9BCrN0NKOrHJTzM0Z+M=
X-Google-Smtp-Source: AGHT+IEfAWnMNvmtq7PJeGITIE1HrT3m9z2+ee6B2HbacckgWf/6Pd9KT9YgWZq+7bWnIFE57k/wxw==
X-Received: by 2002:a17:907:f19b:b0:a72:5967:b3a with SMTP id
 a640c23a62f3a-a80aa5a6576mr990266b.22.1723164991800; 
 Thu, 08 Aug 2024 17:56:31 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e80e54sm790680266b.167.2024.08.08.17.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:56:31 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 02:56:20 +0200
Subject: [PATCH v7 01/11] efi: define struct efi_guid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-dynamic-uuid-v7-1-8c44ab1f06a5@linaro.org>
References: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
In-Reply-To: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
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
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtWk8pOGX3nFfx4dlWuMTO2bWOKWjavHnbBc73
 P671xE0tvSJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVpPAAKCRAFgzErGV9k
 tjZ9D/9ywGNaqUlFsj0UTAoPeqEi9mMT5d3MsDKuHfVf52Yr0mcjfPVS9TlnNk2OhVaif4z+4at
 Y6IeAZVPBm4z2ZqWTfHMSbP9j4awrQzy1rIFsQIpoh5IocqENITD67CsAisDHNbkgCSNDJetBdG
 5T09GJ+fqtjNMYEJ8ACuIK0ruljdceC62VrwXVPATFd8N68Gdrt3pP3hoVZyC67HD9Wndtdn3f2
 64yyx/DnqiLKf808s7MypJLZfPKFwv6pLIdrURqjomhWM4S4W3aKxdNQOfC92EyfPy5ZHzDWio+
 d/8COPM8rpbtZjquC7+QhU6oG9EPC/6PceAtFo6DWwXwkVv3Q+G5icZn1elCFjJN+aQQNJCMx9r
 7GFm9lTs3fxPZCGBEWjoF8BQ1x5IA1jyq6qUNDfoM0pk5PmmtX3pwLHJFGHT0YTKJpvwcdyl6O2
 oI5Cnu8Astz886rVL6GHVZyH4gWCoT00b70wmUM5Df2Oe1e3a19PQIjLrFLLIVJjy4+kcX8SzJk
 yKA0qIMWhbTZC72FbqxfEp6fMxilI/VYvOonEXous82XaERZJAhM9gYDlIfai6QfT9tfC6RVszw
 CGFuI0jT0MjLf1I9+9WcifbExORQlayx7zMRkQ1PRZ/MAmeipXdMJUKsSqaZvxtdAlGzp+I3sDv
 898iunRN8g7r88w==
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

