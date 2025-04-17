Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A305DC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 12:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 812FF8303B;
	Thu, 17 Apr 2025 14:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="fLZ4+nQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB16B83010; Thu, 17 Apr 2025 11:10:09 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCEFC8300B
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso3585635e9.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 02:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1744881007; x=1745485807;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VAoMUYFdt4O8u+neLjxWJ2j+Qq0zDbF23eOAD+N5Zpc=;
 b=fLZ4+nQrmeDQb8jWOMJ4tHssMV4p9o8smu2p0eqbDyo+OS8eadwhXtPFnpxJJHsO3j
 sQeOPBthzwJFkwhiqwmwnGc3J4ridEWYxcmln0DlFrpkp0JnJv/hpjKt7Jw3asKF3J4p
 4N7gpKf3arnNvdSwchrrYJLinJAZcb7QDNPUO13F96Xd5jGrFTayfnwHEN4XGsenH7MW
 nCM83aQqnpXag1TWV06mJ8qEeUaMy59wasby40Z+NPoHgty8c30Ptk/B/IC8bHKTgvbG
 dWDB2rgyOAM1UUPowIvQk1TY446Q5FeeYj5f3b6/31k0vVgNkXrMkUSiuqEPYdtYTXVD
 JweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744881007; x=1745485807;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAoMUYFdt4O8u+neLjxWJ2j+Qq0zDbF23eOAD+N5Zpc=;
 b=xT7pI1wTMjEf7tYcUqXM2ERz5+r1Dt7u+Tnc/RfVN0YrLooGFzMDuQQEJhMAfWn/LA
 SjXamy33BUzSlgqCx+e1g+hzlDQvUCnEOZxJn04zt3vGx4zH2BMhtF9ydz3nmVwgkEAC
 CgjOTUoFlJq6DmPU7jEPT3U5b5beTlKGbL/bAQU93bc0kKl+fu4uoy8QWR9dU6l/DOax
 x8AfAhE2WVxRQyMGkXUA+1OvJe6u8r3DdewR9a8ULdeO3IYa+b85u57Rx0V1JfkgiQPM
 KAHKl2Ta8Lyj1G8MCXn4pSTHm0JPd64tP1qdv5bEM6ScBcEeogChcPpcAjprYxXXh6Ga
 ckCw==
X-Gm-Message-State: AOJu0YynsGdbmbBLUkT3HUkAtPGl1+VZlWhydQG12+N2q2AjiogtKuK3
 GBi1KMR+J3BBv1fFW9CalpxwZjyCTKVLOR8ZEtYomvUUK3W0E9ZbnauOmwiVy8k2lmhPIVWK2aM
 D
X-Gm-Gg: ASbGnctq3SBioOljrR1A4bGPD6Lovqj+X0stp06uyoCWzEGsXV1Ty4jClC1XyreEzs4
 9Vbp/jw6/gb3j1kIfhfp2MnekYNGDl7nG9EGxl1Is6z8b/smFhtAvRX6wvkq3tmdI34UV6DNu34
 0wQ29EKkGoEoZYU7DApArocFdwJsVKvIegpNBIGKf3IySWuuUcRYmTvPW/500ZUp1nvRNnfaQgG
 TTSpDds72LLZsRw82vEmQQ3FW5fKE/gLLPKtt4bJEp84UjjdlRvDXis+i3VXSjBMbTTylnS7O14
 QK+zreTmP02kKLR4UNyd/KsL5N986owxQGKj+B8=
X-Google-Smtp-Source: AGHT+IHMueqvXEWCGYpPw1eNmOkBg17X8alQqMRLymffsPllcGk8+rgGQDPwBSlKnClClSCxFEAAQg==
X-Received: by 2002:a5d:584e:0:b0:39c:1404:42df with SMTP id
 ffacd0b85a97d-39ee5b37bccmr4239534f8f.30.1744881006705; 
 Thu, 17 Apr 2025 02:10:06 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4405b58cc0csm46028945e9.32.2025.04.17.02.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 02:10:04 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Thu, 17 Apr 2025 11:09:49 +0200
Subject: [PATCH v2 2/8] arm: at91: wdt: Remove unused at91_wdt struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-wdt-v2-2-49939de473e1@hifiphile.com>
References: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
In-Reply-To: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Thu, 17 Apr 2025 14:34:54 +0200
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

at91_wdt struct is not used by anyone, let's remove it.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/mach-at91/include/mach/at91_wdt.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
index 8ef8e007d7767308a5b46be46b02c51073723a41..78ad0453fd9eb3e42674d10cb11ce3da820cdc6a 100644
--- a/arch/arm/mach-at91/include/mach/at91_wdt.h
+++ b/arch/arm/mach-at91/include/mach/at91_wdt.h
@@ -19,12 +19,6 @@
 
 #else
 
-typedef struct at91_wdt {
-	u32	cr;
-	u32	mr;
-	u32	sr;
-} at91_wdt_t;
-
 struct at91_wdt_priv {
 	void __iomem *regs;
 	u32 regval;

-- 
2.49.0

