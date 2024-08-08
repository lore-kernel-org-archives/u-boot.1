Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5328C52D7B
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04E7088AF8;
	Thu,  8 Aug 2024 18:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LxFK8VI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B990388BBC; Thu,  8 Aug 2024 18:21:57 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E409E87903
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5a3b866ebc9so1332310a12.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723134114; x=1723738914; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+/T4cIWM0dAhnhIjw/m7a+fn4ePAgXVQbnkmBMx8NVQ=;
 b=LxFK8VI+O3ki9RemAvPoS2tsNhVpj2N78vW0NSlW1EFQu6oTunoR4ATWDmL/JBFTDn
 w+F+P7onD2tl+BXBT5/Y19bijJ/x5cadQ4+P5upoxF6m+sIb0cnqV8Z93Xp/yTU0e63V
 gkCkh64k4VWxrn8+6nZZTVotQVcgUk6mDnaFQT+HQ3KFmjFe50I7jRm0nZQDfV7btO1p
 J6Qou5fF+1Xcy+RQYKcKoVfsH4psrfiVu8HpCKXkGR+EzCdmgqaEa2qLasPl80dDGfrm
 Y/1x8ULbGUGIs2X3iDfFORbyyF+k27HLBxXrsTuyKb9A+Dt9SuriLzlFpa7qlUCBvVnP
 rzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723134114; x=1723738914;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+/T4cIWM0dAhnhIjw/m7a+fn4ePAgXVQbnkmBMx8NVQ=;
 b=E+EDa3uRVkM7BgLPmg3EVWFFOCNqid16d+YC1Y2oNhEzGGFX3lBvVydoQFV/y7GkaP
 VsfchbBg3Yb9f7PPDSpDaabAOMiI/3oCzMniujtXsEnFpzWx/a8xCTG9SLY+IKo36Onh
 Dyx3sSK51EKNTz0DtptEM7OVOrOUStS1cBIqX+BIycg/iZcM+Xn2dpl8ImHoq0BzteQg
 2zl573UQhSLdtNjImjSMJ21V+FpiaLc7YefF1go/dXW7hdZIiDTTbXzjCbgzoNOZnjiG
 iRHdGPHcMVAXzCSsFSyIAJ6xFqWDsT6Ih8RO0oWgK0smZDFfupqGZFnLglnHKFY25mqV
 3pbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWeYyNwXjMPA2XAlf59RVj70me7J1eKXIrGHxSxZo2/tXxqVGr98mUMd1xJRN/BG4QuVW2MGDWtN0B0cnxs5xbWE+zDA==
X-Gm-Message-State: AOJu0Yyr8s7mS4mVymzc3LezY4yKWwA7/RPd4mItEqXg2ITNnrNbgUZD
 dRsvHYCYiWd8Xddo6hLtom6cnXMWTKAdmwsJcxk38smopL+xY2bb6sHTqHMbT54=
X-Google-Smtp-Source: AGHT+IGC6gbGDM9s4l3ipCalmfyDyfNtkkppRf78YR736nWlAkcxxZ4131Py4ua4kgKsFNs8Pwnc3w==
X-Received: by 2002:a05:6402:2794:b0:5a3:64dc:33a5 with SMTP id
 4fb4d7f45d1cf-5bbb22311a0mr2108032a12.17.1723134114257; 
 Thu, 08 Aug 2024 09:21:54 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2e5c8fbsm812351a12.79.2024.08.08.09.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 09:21:53 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 08 Aug 2024 18:21:48 +0200
Subject: [PATCH v6 01/11] efi: define struct efi_guid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-b4-dynamic-uuid-v6-1-9332e7237119@linaro.org>
References: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
In-Reply-To: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
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
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtPCeSZVc9pbvEdu/qHZkPblxDD8xEAE1qOt+0
 Dd24WwY+zGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrTwngAKCRAFgzErGV9k
 tknaD/9z7WVxGqrjjDU94HuKAmZ68JxF7JydI+AJ9xvLVlA2sB0O6TtL+m+ACKbmkCFyeno9R7G
 x02Pr6clq2yOqJdGfhmHD0pGkoSdMj+BMXH5bOasegeHjwNJu2AUfFdERnOrEU5HVWZqEp1riYr
 EwQPQTjYdU3Cu/6dgqTmQioAJ8pEuaDLV7GZQw4kyY9Y+nEDLD5f2FYTShgxXrOyx/1b/JbeIw9
 oTHG3tq9Z29yLV6fxyjYX7pQ8SlWNnkKvbwIYM6I7s04Yf6DORxK4DY4R+1/V4RkE4DBidhfgax
 WKODfGER5daJP3Vu46ZG485583aWNFSrDK5ed+jhGx7Iq7ubCKxeM2CL4xiFRHbBz+ivPyri8Dn
 TV6CtumhCDCefqqiR/1HIiywnr5RsyxKrcy/UFP0BfiVH4NFZmkou1zdB8A1awJh/rNNkjPDamk
 78BcgyQhXIctphlgRKmoTk8XVHSWk97SRZ12qYVCsScYmNAl18PZL7Fbw4yqXIsc8Z5yyJ7m73s
 FCZq0iUF+7nimVxJrIJZ1mLB7McW6wy3+bR8Vr7jE37Q+yFmrozThd8RyuEy8fKZFL1TQ5F5nyr
 REOYLw5KgwVl5K3gsOkGlige3RS+PL1B80t6jOnQJ8xvUS7dpfSjRgWaSXfUHQWiDz/WBSPYjfn
 W8GWMi29i0Sjo4A==
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

