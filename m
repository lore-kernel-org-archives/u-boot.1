Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9BAC27C78
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 14:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B5987D8E;
	Sat, 22 Jun 2024 16:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bR//7+e8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D8F48818B; Sat, 22 Jun 2024 16:36:35 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4B45878E2
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 16:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a689ad8d1f6so364120566b.2
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 07:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719066993; x=1719671793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZcGBMtH3K0r02Kucnml6DOJS3j4NbOQoJDdifTThoY=;
 b=bR//7+e82NY0DtO1R+WE/4c5i4piwo0dPwl5SSXGCZKwWkl0fEq4QkOvfjd8DR/bco
 /7DaioYkY8ysJLObRKjeho3Os9ViScNfBsfiprvm323UFUqNj52juTLCOIKJT7v4i0EY
 E2fpkls5pTgoHWV0fUUP8lz3bPG0A/YYcpmoEz8UExW28vUkDgBJUDS+2v8ys1FeAIuj
 +pdDZOmzYvcrL+6HMwIb3La1I0DkapXUgD3pBKWNspaddqEkoEa0YCp6LtGQh4KDBvkx
 2jzdzJim0SOzxmluFU7E1JRzAY6ISjZmN2RJae4p7EawoPMB94vQCIPBFg4vYu7Wecch
 OShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719066993; x=1719671793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZcGBMtH3K0r02Kucnml6DOJS3j4NbOQoJDdifTThoY=;
 b=fQuD8wzLrMoovjFpmHocu2VkddEP1sBD3c1pELfssuvyUAZ8tVqtk380L11P+aWQAx
 wg+NKekNl2ATMGv1k/BF4QJyg6GzgSF8+hI6vifFZ6aqid7ZVHRQ6fmqk2hTXqepTzcU
 MVMMK5ANnEMuiwRuuezF0WfdNUOAiv7P5L3qQcOEqIHIUT/Ke1Xv2rwxWF0hFbZ5fU8A
 iZ7UlUPlBuidr7dkAi39QZn6k6xW41bDXhnaQ4SMjD2Lzvh7cSqsiMcSq/OAYDkvVUN8
 3vP8h5jvReNzqD3NB0AAwRSD8xU2rK9nIRgSkIT8HG12iErfmHVf4B7aUXhXOWQHog2z
 yr4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe8qebXpEDShrx3ECVlbu4CWSeH5n2tQdalZaAMNnUBecf00sPr0gj13y2wafW0Eg4k4TblKJ3141VfZCr49wrPOrJ5A==
X-Gm-Message-State: AOJu0YxTm+C1knvpoUs+rH+Eyl6eJEIg3dd1PUT/t2QhOpL0B9rlhQr/
 FsMzSgcc0ilGPMhhisl9qW5rmoI39XX1atb6p6WVxYSnH/R2EUJeprNnfyrMvNw=
X-Google-Smtp-Source: AGHT+IHfKwyocf2fvqVT5yRrsw0uBdxzueq38ISg/i+4Wkt/Hxgxv9o49+INZYEmi96Z12x5FTPZSQ==
X-Received: by 2002:a17:907:8e93:b0:a6e:f62d:bd02 with SMTP id
 a640c23a62f3a-a7245c84f2emr590866b.7.1719066992851; 
 Sat, 22 Jun 2024 07:36:32 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf54a534sm204005366b.136.2024.06.22.07.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 07:36:32 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: sjg@chromium.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Michal Simek <michal.simek@amd.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH 3/7] efi_loader: remove duplicate TCG algo definitions
Date: Sat, 22 Jun 2024 17:35:39 +0300
Message-ID: <20240622143601.187723-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
References: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
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

commit 97707f12fdab ("tpm: Support boot measurements") moved some of the
EFI TCG code to the TPM subsystem. Those definitions are now in tpm-v2.h.
Let's remove the duplicate entries

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/efi_tcg2.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/efi_tcg2.h b/include/efi_tcg2.h
index a75b5a35b6e7..54490969b2d1 100644
--- a/include/efi_tcg2.h
+++ b/include/efi_tcg2.h
@@ -25,14 +25,6 @@
 #define PE_COFF_IMAGE 0x0000000000000010
 
 #define EFI_TCG2_MAX_PCR_INDEX 23
-
-/* Algorithm Registry */
-#define EFI_TCG2_BOOT_HASH_ALG_SHA1    0x00000001
-#define EFI_TCG2_BOOT_HASH_ALG_SHA256  0x00000002
-#define EFI_TCG2_BOOT_HASH_ALG_SHA384  0x00000004
-#define EFI_TCG2_BOOT_HASH_ALG_SHA512  0x00000008
-#define EFI_TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
-
 #define EFI_TCG2_FINAL_EVENTS_TABLE_VERSION 1
 
 #define TPM2_EVENT_LOG_SIZE CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE
-- 
2.45.2

