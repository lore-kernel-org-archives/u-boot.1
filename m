Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E297CCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 23:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4EAD83C29;
	Fri,  7 Nov 2025 00:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wx/iR/nD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 317F883C65; Fri,  7 Nov 2025 00:28:43 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1410483C29
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 00:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3c96de7fe7eso100672fac.0
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 15:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762471720; x=1763076520; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+1S0rbd+LFE5sP8ph+py7cpLGJdzruBHNz590UE4S64=;
 b=Wx/iR/nDQsxTJJqNKXAyStM4WN20HkydyV2BpPiR31N3HxmJzjoeqwaIZ/NhMbj4Lh
 W609V1OiDfLqMBv9CF8A9qJ0LPVAoOrDI5u5uXY21zFTOJK0xUt1vhoj0BWH5UauTuI6
 u2TXgYZmTglFyGoyUyhuqAZt3LaAdqCjraSlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762471720; x=1763076520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1S0rbd+LFE5sP8ph+py7cpLGJdzruBHNz590UE4S64=;
 b=wi5KeMu4Ejb+uxywddhV1HNmGlNRy743aMEtV70YkDfPOvPi6n6YJhL+ONyuH7Dok2
 xLcJnSNhPo7PdqgVuBeiVsxOFgQk/eQa8zGba9BNOdmSgkYHhzFvsYj00zGvWZzZFc4s
 qVURczmRxH0nGbmj1NGJLDZTo6en+AWzZdvzmh4AlxCAFgKkd0j5w2ygU27fJFdkrHZh
 wPzCwwWh5w81uaRuZHTBwLRlP8Uv9X4eYrxDvoZ7Hqrz7YBHIY+6QnxtJWRVOBpEzBxa
 VS1cmNLxyjJgYaOcM0RJOhXjxWDVwnjMJs14tOzHGcN9H6A1W2PrGHbr4aylMgJsBWAz
 8Igw==
X-Gm-Message-State: AOJu0YzRhPS/cDwAlT+7tdcK+ddEpnAJ+rM75MZFuaHjMkfewG1HFRyG
 MfQZef3Y1wTgjK8nAU7x5F0nxGc3noEsroESk5w1RldXXGLYq3JIG4uK5RqKi1qy0e+neIz+EtV
 sXM3XaHXfQw==
X-Gm-Gg: ASbGncvz+0o+ck/HeRPlUA0nRB14nswkGBiB7+8WP+TZmSZDYejGW7+wZLSe/83nBzm
 9ymTVrYm5evDNMf//ZKFJCg06qdDGOnNjpOgBlQhe/DdEevEn2mFCNJAon2kW4G37afTxkdOCr6
 w2QC4rp+FCKzI09Twl7HWKc8VQ9j2m1MJOZ+eNXQfGMfxbVdUKKE9q588odMeRb7BGOYUlgMI7+
 rmTK92HPeE8vkxzb09fOZ/a80KCoCuo2WpSA5Ie+rAt4DpHHPx1XseeKTh4LEqyh0rDL1SE41CJ
 vKzlWLAeFK5jbRdoMlVpZxeIZw5Xkbj12Vv11ZbBqWRewI8bWIPoBUoRentK2Oku+CVKsexJxXF
 HJYf9OUDMg/dmoxHAu/uYIZaT2sTd49tUJiFAZVR89SZnPs9mSAOH4cPjiKF+B3TI09nls9BCn3
 WN60HpOjW5L6H5oKAd9rjYyF6mad2VP/PtQOtNLWwAFQ==
X-Google-Smtp-Source: AGHT+IFJHpTFBYD+0EbDmQ+58UcJ7WlgeeAOuFXXP5XbYz36qlsiecmMRgpYY1LK81pXMKV0UnC0YQ==
X-Received: by 2002:a05:6870:8a20:b0:3e1:2ea2:f703 with SMTP id
 586e51a60fabf-3e41e7b8e10mr962755fac.42.1762471719683; 
 Thu, 06 Nov 2025 15:28:39 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41eba8ce5sm536377fac.4.2025.11.06.15.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 15:28:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] smbios: Fix warning when building with clang
Date: Thu,  6 Nov 2025 17:28:38 -0600
Message-ID: <20251106232838.3243607-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

When building with clang, we see warnings such as:
error: field max_size within 'struct smbios_type7' is less aligned than
'union cache_size_word' and is usually due to 'struct smbios_type7'
being packed, which can lead to unaligned accesses
[-Werror,-Wunaligned-access]
when building drivers/sysinfo/smbios.c. Resolve this error by packing
the unions as well after verifying they are complete (16 or 32 bits).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymondmaoca@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 include/smbios.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/smbios.h b/include/smbios.h
index b5fed57aba21..f2f7483bce5a 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -204,7 +204,7 @@ struct __packed smbios_type4 {
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
-union cache_config {
+union __packed cache_config {
 	struct {
 		u16 level:3;
 		u16 bsocketed:1;
@@ -217,7 +217,7 @@ union cache_config {
 	u16 data;
 };
 
-union cache_size_word {
+union __packed cache_size_word {
 	struct {
 		u16 size:15;
 		u16 granu:1;
@@ -225,7 +225,7 @@ union cache_size_word {
 	u16 data;
 };
 
-union cache_size_dword {
+union __packed cache_size_dword {
 	struct {
 		u32 size:31;
 		u32 granu:1;
@@ -233,7 +233,7 @@ union cache_size_dword {
 	u32 data;
 };
 
-union cache_sram_type {
+union __packed cache_sram_type {
 	struct {
 		u16 other:1;
 		u16 unknown:1;
-- 
2.43.0

