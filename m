Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F687C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE3C885E4;
	Tue,  2 Jul 2024 15:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PLZ0TOlm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03AF1884FB; Tue,  2 Jul 2024 15:30:48 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CC4B880AE
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 15:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a72585032f1so458201166b.3
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 06:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719927045; x=1720531845; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nScEoNskmv45Lt2tjO7j1jnaqGA5YnHfESShhKL5dEw=;
 b=PLZ0TOlmlB7RD+Jiuo8SWlopyjPkmmJwDDNcjq9bp0ni46S43Ez2YJhquMfy9eDqR3
 FGnwS9GZW2BlkoMWJZNlpN7Mj1qB9qIcVkjQIa/rU1zyvia9En3O4klPrrN9J58ElMR+
 zde5oma/DzEh+4J4Tp0gCaVp5T0q8471SAezcrWmXEDGkBvW3cmeS70rSLEETHEJ8k2e
 iFk7syOElMXxNb5kxj9S1f8ao9LTFdBm9K4qAe9HXVHUC3/Yl0QAnK688YHLSRVo/9nZ
 zzUcl6B1sGwwEqPqdITlG33ZJPMgYI4JxQjOaEgxuEmeSEyjgjUvKQ2GejuyOOaEHDIB
 6ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719927045; x=1720531845;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nScEoNskmv45Lt2tjO7j1jnaqGA5YnHfESShhKL5dEw=;
 b=GCXQQQ4RFH2SSoLDRPrAvQrnuF31vnt6eaZwtUEAdzG9Dd6wsZeS/OkptSZ0o2pI5U
 OG+4VQIy9m2dO67DRUHW76dxWcQEIMHaOkqSNYA7rl/lGQqFTzkGA3EBtrhG643/+BJX
 YSI+dDVOfwd5/61eo80yJkQAS5sTE3bbos0OxpiiKbsXGcWT2j6dtWsX4+/UlrDaV/fd
 DOrG2S7yHnnIC3s5btIFbWH6tLFyW3tNYGtsAjiP0n+1a/qJ3JlYcVWSaWhMPrOm1oou
 20yhYWHzKs0lVczHcnseP/CdoFDPdsOsRab7b2hLKfhm+b69RpYfiBMJQs220Vc3yXiv
 Bzaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH4FQMwAfbhgjPsvagnLI43dtqNIRVCFRFki1g8+gI8ZWr/6PbhRB7PL2OfoGnq48tIO6TMjH1GgI7xdG7Ve9pZg481w==
X-Gm-Message-State: AOJu0YxGzY9Ksj7imCE2upnN/ZISJ5AX8Cntx4xuGWNa2+iQNd0Z4rfn
 H4IzUBVxi9uQpwj14yLQ0lyyhujSk2FB62joBVX8MTnBQ9qEGIDCtWBC+ZS6uok=
X-Google-Smtp-Source: AGHT+IFRog+gx74J/Of7INg7/8CAnJfUVWxqmZnXEMxZ/iTp8E5it12yGIqzgsFDC5xiCYC0PAW8Mw==
X-Received: by 2002:a17:907:d15:b0:a70:c031:3359 with SMTP id
 a640c23a62f3a-a7514438b44mr702738166b.34.1719927045505; 
 Tue, 02 Jul 2024 06:30:45 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7430367d55sm323796166b.87.2024.07.02.06.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 06:30:44 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 02 Jul 2024 15:30:41 +0200
Subject: [PATCH v4 01/10] efi: define struct efi_guid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-b4-dynamic-uuid-v4-1-a00c82d1f504@linaro.org>
References: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
In-Reply-To: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
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
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmhAEBRCW+jAWLpN23dnEkUJW0XfD4JSTmOxkQ3
 GvembpFktiJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZoQBAQAKCRAFgzErGV9k
 tiaWD/4vFykJJF9vTWtwsIsdIYtO6Cq082mbtqzzTs1EdTGtupxX0kqRTtIbVQ3HcO4y2no2cDh
 m822kS4sS5WSgoojHOtTIXtDIsWfZSMuXD2c235m1eBNr57McymYfxLJEmiMln0SMm4lqWlQa5p
 sccc55u/cWLap/xpHPPkz+5/jgjK3Ol5DagCMkxjTJQZQ66SgqQjHMTbMwD/swjhFeJDMESMIEV
 DX8hWtj0FWxpB9RgtkciXMY1+RoKsIl4XYgmZdJiagoxzozciHD+SA0lTwJ7ayqmPDJzUmy/Edz
 nUiBeSQFZBvbRQ0EEaGlO1RXQ5T0yXeCEX10kqD3jUVX8zoKWSNnIYWPkH6wNHTIIZ9F1FQ/VHx
 WO/WcQ/csgY+r264svSQaXPrUn4PG29wYQgteVvKSCJrir9ILlyZudXLUESVwMp3H3carry5oYV
 rAtyQGh75UjE7ALa/UDQuMGSiKQC8aa2QMUrJIswcHK2/NUcZagfx1DiRNAxyB3ZHq77voUhPPi
 k0skJDTOL93piWEVr44tJgSQn5BKqbmtq6KDYyAB9hzvgNmwsVgbYqCb2SOeUnVnZVI41nG7007
 lvM6e6FOZCLrStMu1pGKDk3BI9uaYKpGMY5fTRoWT6uwy2sR6OPlPC/7sYTetX6l1o6hz7P8S7/
 LnnsBWj8Jy3Nbkw==
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

