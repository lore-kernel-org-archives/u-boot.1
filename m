Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5F4C5B543
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 08:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1153A82B48;
	Sat, 31 May 2025 10:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O+5DR3j0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A54082C8A; Sat, 31 May 2025 10:45:04 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B0C78003E
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 10:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a37a243388so2313579f8f.1
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 01:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748681102; x=1749285902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1R6K36WahwQkSIvxShFaNASBZK3XHYMp42Krd9OGjrk=;
 b=O+5DR3j0Ez6DfxBd1GoWmAQBC/3y/xGxRs9/+6bLVKL/sarQlOOVh6kMehB1HTOZhT
 ZO9PdcYt/jvarnhviyLiYeujzJ8KPxt6NpYiU3t5vT07TOwE97PrWgwtdLJY3Fss+T7s
 Ax/XxH7b2JVg9AAkgwkm6RPIHYGfFTuuxBN+BJDIvG8YL96j5JAcc0vU5zv5x5SrRH/U
 jaq3Y0ZQN5RvGhzi4dSURW8PPZILPtWu+Er60nTSpQb8oUuaK2fqA25Zm1aK4mj9BIwn
 gQDmSuaCBbp/ZACxohzadLn4HUI143+ExHcKDBAimMP5XzKuEI5P7NkWMZqAIj/uzD1q
 aHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748681102; x=1749285902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1R6K36WahwQkSIvxShFaNASBZK3XHYMp42Krd9OGjrk=;
 b=sTG6xUUKjFfrc4IarmS9QAY592PB/BTFYNCVLAaB6/CTvct+6Aqnh9wd4LsPasZRRh
 tnMm8lO3K+0tbX0mAxT4yW8ZdAEs4+pIK44/geyC0ICThhVRYjTyaO0zcKvtVZRinnWU
 VIjITHQFZTV8q4jjZZugF+0SYBmE42W0/p7NzDc9Rl2j+3QOP4mu8AOvdCJM6RqHskdr
 M0mUkYuHvUo1C1crOHmpCjnhOPX/mt1JiGfyj0tVF5DdH8b1ETcbAr7WCpT/35yfEw7P
 Bc2PxSbIh1Ky8vGeQYh+05nJalyK0vEaOWX1A1a+0fZIskP3gBwRp7mYQqsLXk+9FySn
 xZLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUkjittIIrXGOHVPiSpZVItGrkjEKbWoiOGbn9T9Mo/8rEICYFQAOR5DbgnR7a5LKtawZ6QN8=@lists.denx.de
X-Gm-Message-State: AOJu0YzMbDpkm2YE1G65s9pC+U1+iqFwDzg23NN9xrhpLopfNYIkVB7x
 Y4Ic14otofiq3qomcPKKJYm19vwEEEsprYvY4g+3C2etD7EtD+8PCi2Q+DQxx4+rFxA=
X-Gm-Gg: ASbGnctr6jFfOi9ENG35ul1abDOv0f25HuP1ihNxQTn0us6kEBekj2goaK8WWjFQiL3
 XLNWvNGB3eEPVjEfVd+AVknAPx3jNaCkSrrz7RnTjNWynj5H2+P2VPz8o8uz5CzoT1pyGLLwwe5
 VphBwFtrLFh048FMBR1T8QJU23RDTQs4hZ7dleGXdz/0CeIbEgFfcPZ1RnPZ/7i5MJgqVn5ZRI3
 tjlTbFXkhyT7+TpIRlpNk23CgUBF+pUxWPwYi27NRuqIfBu/kI0IWCSuc7i1iLm9Vr4iwSq4Jwj
 59/hEtEpSYMteudOBrIoBDD9quxX5HYJ1wnmZQx06sXLmuAuB3hrjtMjfRK/4k9avortERfthWB
 mid3vtXMfDtaHVpEAx9XFcIytxbJsa6mGQnkGFMde
X-Google-Smtp-Source: AGHT+IF9PaaW04XDAbdYmFC3i/UVaKTpfkBkonW40lXWpDAhBdzhDYljtr9zi1eXMd9/bGKUzDoJiw==
X-Received: by 2002:a5d:5f84:0:b0:3a4:f430:2547 with SMTP id
 ffacd0b85a97d-3a4f7a3e50dmr4726426f8f.6.1748681101702; 
 Sat, 31 May 2025 01:45:01 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f3csm7153986f8f.42.2025.05.31.01.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 01:45:00 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH 05/13] kbuild: use -Werror=implicit-... instead of
 -Werror-implicit-...
Date: Sat, 31 May 2025 11:44:33 +0300
Message-ID: <20250531084449.4125187-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
References: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit b89f25ea7892 ("kbuild: use -Werror=implicit-... instead of -Werror-implicit-..."

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 82bcc097e493..48a0af51bdd6 100644
--- a/Makefile
+++ b/Makefile
@@ -437,7 +437,7 @@ KBUILD_CFLAGS   := -Wall -Werror=strict-prototypes -Wno-trigraphs \
 		   -Wno-format-security \
 		   -fno-builtin -ffreestanding $(CSTD_FLAG) \
 		   -fno-PIE \
-		   -Werror-implicit-function-declaration -Werror=implicit-int
+		   -Werror=implicit-function-declaration -Werror=implicit-int
 KBUILD_CFLAGS	+= -fshort-wchar -fno-strict-aliasing
 KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
 KBUILD_LDFLAGS  :=
-- 
2.49.0

