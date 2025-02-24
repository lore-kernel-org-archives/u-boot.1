Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC2BC021B5
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42FDE80FC2;
	Mon, 24 Feb 2025 06:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WA9t5M16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ADAA80F7B; Mon, 24 Feb 2025 06:56:10 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4578A80FAA
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2210d92292eso119079145ad.1
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376560; x=1740981360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6PzttbJltJAMa3ps2OJ/dUkcVtTtVxDOcKz2xhLqi7E=;
 b=WA9t5M16sQ1NqCpG63Bln2We91ja3pOZQTjLXdxUanlEdr5fWRtklawLPResswUXkF
 U74swwsnFFjJSSPCqxBURtqtdci+zpgXgZT90QqduIt8XkHcJm33nhPBES8PpDISTzmU
 Xuf2ZclCaOty7JkoWAUT4l/yowspNHZSNPYkH02+lPy8Wupo+3ErcSWjnj2qxIQGeotL
 optlbsvB3YcKDFG43OlDEhC8k0lEqAle+zPokNmX4eA2idpMtmXpHpq28HrgJiUxjd19
 gOTkFLKIsyQrMCyayiudWc9YmsrD/mQH0CmbdusE8f1ksaNvKafyhr/QC4gSyhQ0V8b4
 yPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376560; x=1740981360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6PzttbJltJAMa3ps2OJ/dUkcVtTtVxDOcKz2xhLqi7E=;
 b=F/QETM4V2xwgTTQZioMFuq8Rbb40tneNzXspmE4ZPfK530VkbzXhgZ+3uvYvzw31KK
 McsDqFZD1V/wvyPTwfeeSX4aewei/82lnPNWluC0js5OtDlP+jGFCpmyta+Tui8e82Rq
 R8ctlIRN0X2bH24P8HmUrAzSLCw7+t8ftJCclHbWplJuh++Q2/VQiOjhpa+h6THbJ4f9
 mMSgtlVK8HXVQgIOdWsTSSE5f3v9WulCZby9Cj4y2g8HuG6pDqvwTjckmeMjkYXo5gxK
 02OoLmj0DB0kf6s8DG5Pn66PsF3Ko+8ARNdEZ4UVfOYk4t1fdicrCFGB8OwF33nsNcl5
 pn7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvbYQI0zsfXzxLWngX44eEaPzGCFNmCHgMfqMZhatExr6wD77QK1eHoww3hYepKTyrJyFktq8=@lists.denx.de
X-Gm-Message-State: AOJu0YyZNo6ANZUgZPIegpG1VoifjKFhFRmwtIn2dv2x94m94wQrkTN4
 U2CNMbGK+Qc4ddMhU1+0bad9jKb7geRWHhrw2zRcqbq73zNpa+xf
X-Gm-Gg: ASbGnctICwuwdNq/V59fNvq8lIIV2U2IPMma5f7cHAgiKDYLulPlWML+mfeag9C7psT
 zoHPFERzS5TYuoxyIfAACFAx4sl4BJY85ZS9I7Qz/MwWvrEYSWeU9CYC1+cvnHHxDvRdM1U1fxx
 yZV83/oiylvDS7ti12sTsbzcDtdZB9uC7Iy2/2RxYHh8Hc0LEBjA2Ui6mKhQEBdv/hyNBO0tWmi
 04NPZDhwRTVROd0sqO8qODWxnuwFrcduUp6Alg1pIRNcygHAjWvcf0gau1e0/4A3WXr7t45XZa4
 5c+2qpPQLx0tQsclACcprsHQNUE+lnpitrg1kQ==
X-Google-Smtp-Source: AGHT+IGyhJSPj1Bkim/hzkESKVNQGG90sKf7DkLxqjPuNJ9tOAJ/TitoKP2+3KdXohlC7kf0qkOFFQ==
X-Received: by 2002:a05:6a00:2ea1:b0:730:95a6:3761 with SMTP id
 d2e1a72fcca58-73426c84357mr19464216b3a.3.1740376559613; 
 Sun, 23 Feb 2025 21:55:59 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:55:58 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 03/17] arm: Add __aeabi_memclr in eabi_compat
Date: Sun, 23 Feb 2025 21:55:10 -0800
Message-ID: <20250224055524.1334929-4-CFSworks@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224055524.1334929-1-CFSworks@gmail.com>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
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

LLVM's code generator will sometimes emit calls to __aeabi_memclr. Add an
implementation of this for LLVM compatibility.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm/lib/eabi_compat.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/lib/eabi_compat.c b/arch/arm/lib/eabi_compat.c
index 602efe04c04..e4190c049a3 100644
--- a/arch/arm/lib/eabi_compat.c
+++ b/arch/arm/lib/eabi_compat.c
@@ -37,3 +37,8 @@ void __aeabi_memset(void *dest, size_t n, int c)
 {
 	(void) memset(dest, c, n);
 }
+
+void __aeabi_memclr(void *dest, size_t n)
+{
+	(void) memset(dest, 0, n);
+}
-- 
2.45.2

