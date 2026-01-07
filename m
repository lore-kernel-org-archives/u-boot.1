Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDACDD0D16D
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 20:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C969840F6;
	Wed,  7 Jan 2026 21:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V9D8s1rE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97193840B0; Wed,  7 Jan 2026 21:19:37 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DC4084082
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 21:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34c1d98ba11so2028565a91.3
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 12:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767817173; x=1768421973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=imZwrqM/7rQGdRRXMgICblIcq84Xp7iu7VZrZIyLX44=;
 b=V9D8s1rEj5VovM3NaNOSP8YLFeTzbizKUfBeJvXZ+NuayhQRTcHEhRtlXZrz+YPy+G
 WvQfDIa/b7gRlExrgOvs5unaebR3Le8bwLzcwwCoUIidHFwARFymSncpjZ97CT8Nrm/1
 94t6OtHPySzqTpoPdeivJeKzLCQT8p3hpE/FmFpo2KDPrVdyF3i75vyMsTEXMT0Y8hx+
 OAM6p14rXaqBuUoRqGGioht7yasD9H8ksSVFG2gA9ARkdtEs8bdrwMktUCvmJ60SZJU9
 euwc0l/kim5ZUgWNbyNTYnkbIYn5YGxJguGZCv76ahxRb1UWWqT+w4ej0ZUvQTLtOZ1P
 qgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767817173; x=1768421973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=imZwrqM/7rQGdRRXMgICblIcq84Xp7iu7VZrZIyLX44=;
 b=d/Q3UafSQNma6xoEOYsweA3UTNv36gkj4OxhfLCDjXlFMHOHGlfTvp/F/YpHteWTt0
 j8ueXNQnqSFVnmlShX+YHQIlRYzb3lij/mtWWQzk4twwbfRp4QIYb2ocN8UIuZr1brAF
 05RR4zJP2ysIG1Z46vEO3Oz48EudimfbiSLwWfzN5AkiWGzgMvCxA65Jib6oqIgnDviJ
 SoIeKJCFkCtjIh3yd3t/IzRzzgNYhswG8vEUtYKg+Qo2bYar3+ny24QuLhH+isnBeqd6
 zjgmtUHlooQaUH0onyNa3hiyr7f99OKWFNKiLysFlThGsML9/ECSLm5w3uTB9+axJJOS
 UgUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWebhv7R1v9gJIIaBJmd+SM1FYQDblx4kVXlJwkhZiyrUI24kTBSInhBOdqL1lsnF67NyQQxic=@lists.denx.de
X-Gm-Message-State: AOJu0Yzxt6Squ+ZC0I70EwNIdjpvbQaOHBbNrsz5g2HoDeI4zXnDN8DT
 S1hGwXv5MNIteCp5jSD0l7/xef8jpczHbGcHhZCocPirmdZqY/8rZEeA
X-Gm-Gg: AY/fxX7bGGFc9v9XDfknBnE+SBay32YxIsrAIBEYYMkKg+pkzGxZK3hL94sQC90OpWV
 MaCAEQKKazvaS7QMlTIFgBgG28xTi+m7pp1H4yAty/bQShsf5gqjNQnpiHsNEjBvZ2cQg0TeMyM
 RNQi3+sdglzONaTUlLHqRbtPBJF7oKoMIlRBLZ8k87JM/5geIp4Z2zxeUSEqmmxK03TOleRarUu
 Acw+/PoWBx2DxQg/IBxudRfle6PjW909l+/qAJIf33GQHfjpqRvG0BbkIsK2lgvfmcvCJGd0qzZ
 Roz89lH6gfyKOIz7yxvFEnPuuZKIwghycJlI3Yk5xeo099nTjnsmifMm7iMsDsZfoWwzolNGTi2
 fnbc7clmypj9Zqennw2GKiJNlWicqH6pH2KG+DR3hX2sbbd4xuXCgMR9xmfk4M4k32d3lRUk+s8
 0SmAFZFTmHZrNh7g9I7ZyeSpHDhpRxLA6VA/T+hUCVmz3da1Bs2TSN/jCFqwHxaORV1/9Hy+mfz
 q23NqtKHLMYdLEYp07KIedniV1nWVD4
X-Google-Smtp-Source: AGHT+IEJf+R1i9SadZeUNZdEtj+pkgaKUxxhxHL5sGHtZ/LywGnNAI4R9ikw04aS2YVBFKXt7IJDhQ==
X-Received: by 2002:a17:90b:4b0b:b0:330:6d5e:f174 with SMTP id
 98e67ed59e1d1-34f68d0bc5fmr3348169a91.20.1767817172847; 
 Wed, 07 Jan 2026 12:19:32 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa947ecsm5766077a91.6.2026.01.07.12.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 12:19:32 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 sjg@chromium.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v6 8/8] MAINTAINERS: Update m68k entry
Date: Wed,  7 Jan 2026 20:18:37 +0000
Message-ID: <20260107201838.3448806-9-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260107201838.3448806-1-visitorckw@gmail.com>
References: <20260107201838.3448806-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Jan 2026 21:19:48 +0100
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

Rename the "COLDFIRE" entry to "M68K" to reflect that the architecture
support now encompasses traditional m680x0 CPUs (e.g., M68040) in
addition to ColdFire platforms.

Remove Huan Wang from the maintainers list as she is no longer active,
as suggested by Angelo Dureghello.

Add myself as a co-maintainer to assist with reviewing and testing
m68k-related patches.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Acked-by: Angelo Dureghello <angelo@kernel-space.org>
---
Changes in v6:
- Remove Huan Wang from MAINTAINERS as suggested by Angelo Dureghello.

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9fff8989684..d6e03c21f20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1045,9 +1045,9 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-clk.git
 F:	drivers/clk/
 F:	drivers/clk/imx/
 
-COLDFIRE
-M:	Huan Wang <alison.wang@nxp.com>
+M68K
 M:	Angelo Dureghello <angelo@kernel-space.org>
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-coldfire.git
 F:	arch/m68k/
-- 
2.52.0.457.g6b5491de43-goog

