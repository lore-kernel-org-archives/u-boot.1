Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2FCC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 12:44:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3266E88BB3;
	Fri, 19 Jul 2024 14:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IoBhqVKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 998EF887CE; Fri, 19 Jul 2024 14:43:50 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A717388B94
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 14:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52e9a920e73so1817885e87.2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 05:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721393028; x=1721997828; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nScEoNskmv45Lt2tjO7j1jnaqGA5YnHfESShhKL5dEw=;
 b=IoBhqVKq6Lav8jILfWG1UuAxsDJI7Tapf5G0vIbjkNeLroaFN6r04I7eOiJLRQGSng
 xNzR6JZzGXJ17novaORAvAbr+KoIRPMmCq+owoNhJtip8aQ7FmpEUgllTyM6YBwkbVAA
 2X7wI/z8nhpw92hFWSOye2KZIsVc+QjV7R46Lg1G0X5YG3Nrb8g70Ikxmi8VVtAQ8cto
 jQa1yhM96cVikLo8wlpaQcxFduYIGIfaYmyn8gmFw49XLzS30PMK1pxDt1o+IXnnW7LT
 TmvWQH10d2tFr1TOBbh1PdtH+uYHerBq7BskjaFp2vFZRIWJFD84mvW/0t8vnge26g0h
 oAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721393028; x=1721997828;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nScEoNskmv45Lt2tjO7j1jnaqGA5YnHfESShhKL5dEw=;
 b=jLC6h21YJMw898rLYP2Y2lRZEtNs031sAjjABxDN8IocQaKhURDoBen6+dfQwCugF5
 HQTSWpqy5HPkg9dSdDeXFJp/DyzjMQdzfAIKsobRJ8dSNHzOj9pCAFdhSv3pdvRZISI8
 YpzBSaD+e8Woa/wKimHxkJn/jhZVYEl5WOTbxSQ71eg8PfnRUVreeL7aFvke+poIJupu
 DEJcAtw/3g+ReOoTEn5OB4oW1YN13l5edOJ/QeNJq8iLenPykbJKPzwJdcbVR+2ETzC5
 aOQKW/hOn0GDSrMz7kRP6VegUqcsSS6k9NMaE+yNWhNerEBecV3ZxRLi20G79+mxGwHD
 IioA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVscia4CMR/TY2h9Ad6Nce4LZIN/u9knL4wgxQ8hOcJGTc7I2GYow19FREUgjdk1KqU46iqtadDLHik20QFqhB/IBvpew==
X-Gm-Message-State: AOJu0YxwguSf088VPdMrc21HjJ6BmXP5g0Z8yQXoXAKpmHFnM0xuo3f9
 s9FtcxHMhm9HKHHNARKJg29cJZwAaPRwWvVJfJjb3DgGSCBn+NDTtwrUKokWOMM=
X-Google-Smtp-Source: AGHT+IG5tRzPHnaU9tTYcQSq1Xpq1te7PtG/jbMGgbog63564F4QR1E++TdN9IK5/7cGIoYejcseNg==
X-Received: by 2002:a05:6512:2211:b0:52c:d085:9978 with SMTP id
 2adb3069b0e04-52ee543f3eemr5062935e87.62.1721393027918; 
 Fri, 19 Jul 2024 05:43:47 -0700 (PDT)
Received: from [192.168.2.172] ([90.187.152.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785e97sm28577466b.39.2024.07.19.05.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 05:43:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 19 Jul 2024 14:43:41 +0200
Subject: [PATCH v5 01/11] efi: define struct efi_guid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-b4-dynamic-uuid-v5-1-8a83de3fe3dc@linaro.org>
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
In-Reply-To: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=b3W8BuVY9KVN80vqbSH3Ez6m6ALhP6/nGoPftuCgZMA=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmml+AENfu72Cw5/lmy7c3mHdO6I+6h2dYknnRM
 aR8uMVx9TuJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZppfgAAKCRAFgzErGV9k
 tij6D/oCJu+VOIVx+ms8ZQt/QU2455ezOverRmUUj+d3rSnDgSB9I9aamQOXsx9NKK2cyhf08Be
 y94qCcVCeu1Tg3j6G4NETYBNFSLCWSf0OyaRagbbxAjBknPBkWYBYs7kpiFk7UrJXvadeF07X5x
 KXbBbLjUtDLry5tTwbMvyt0T3l5swci7lHtzqGPFhxB/SeEgMIcjBzRofoOQnOg+IE+jZC5XDpz
 K6u0f2OTDQSL3WRQgWl9452JsSxJu/SbIYeA5vh1CTiFASTWJgAPbJm3lyY6/51dS3UGPX0uF2g
 C6u9akS8Cef/cpv3NHGUJpYKbtS4uOabuBTpQAvg2/dMbRZtltUNbHErq8YrRrI+gtS5xq57zsc
 O6h0qgOJw9aiXd8R0wC1z4KUzU9r5EYLFWXTCmqfo+Ejdzb9jsxO5nGVVJvua35+V7BFGHYxX8f
 GX/ZfeWB3+qB64RPxd6Wtpn9bSSTvpbBWma9XNAxiuxIY+E+bJTAM0atL+oSyrYsL2kwBmZXLcq
 epTSGcB6et8x8WjRNfdU2D0Hkt8UUd6+2veRg+Z/beCEA5R2UY3G5UKj6+h4fsCuRrHdA1o/Ao3
 m69gIL/k8JY+RsdNzuaLUMeTW4+DLQy+vq53fzizYIS/otxorwYzoKSJIXFmZ+5LssmEFmo+lnf
 IjxKziDwTQZLVYg==
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/efi.h      | 2 +-
 tools/eficapsule.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/efi.h b/include/efi.h
index c3c4b93f860a..b92c961a2afd 100644
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
 
 #define EFI_BITS_PER_LONG	(sizeof(long) * 8)
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
2.45.2

