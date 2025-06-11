Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAA1C71136
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 20:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 390E382C67;
	Wed, 11 Jun 2025 22:25:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dMB1YyAC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A751182C65; Wed, 11 Jun 2025 22:25:00 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFCF8828A2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 22:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4fea34e07so195243f8f.1
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749673498; x=1750278298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDGt2nD5x3bvz9tRUmRFGWsevxvW3EZZ6SRpWHTeQZ8=;
 b=dMB1YyACJd6EVXCkR5wxTa/2YU3c/eihM+XUWF4s3N2bZnxsVEuNh9JwomLQw4z9nC
 EU7poRigULw4ks8Eh4fB72Z93FWdKknm72/iOJQ9jF7TmrggYOPj4Ja/6hcjH1VbwJ1P
 D0jpqX+tF1UTgOoliEllnH+7Pivg2mmgLc9LopCojD9xgdiwv1pWbcuIYdIfQsnl7Cq6
 I9ZVPz5cvQavZhVDHcSS0+kgwl9HDY1MmmStIT+CgrXbXm4ThYMM0Ooix01VhJ3xiajh
 Bw6u0Us837U2GX2CYkyOHfJyLV3uBqh60Bnaf1MYFzXr9QFwriJHSSfPysODg6ml2ogU
 9HHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749673498; x=1750278298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jDGt2nD5x3bvz9tRUmRFGWsevxvW3EZZ6SRpWHTeQZ8=;
 b=oU4nzVtOqyopwu2jf+aVnt48PdqYaMxBo7tf3rOiX64LzlGx2fpHQX/ZyWgZMuOAQO
 XgT2HPS9CpwhmWZNrJ3elHhwHZsKExhl6SXfhhv3Dn7OJeHLHTaNk2o8V+/Z8X9xnesB
 79BXoTwDMfGQo2qkk5AyXzM9xHTMBaKHi+B8Nc8ET22bI547D7gonrKPQC5hlYj9fz2k
 KoT/lY0ZeUM7wSiaf/aaRPJbcwv+awwu3ZCuJZM4x3w9ecS0azzN5LoB/ehKYEtCVsKC
 8TVQfGirkD+bD7CtvUP5aQuL5g3oS69lYNZ6eaA1GsUv63bpAKOQh99BAMjQ5KUv8oby
 DNag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbP9YWw3rqugj5DZPaeScPbuFUWFnlA6QEcNeN0tQ23+c4EaYdMmV07S5DH9kZR+ycS9NpMRI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6xxm+6/49hJvhGRtsfJZqtKOcXsFun7dRNJRL0algsZo8K5J0
 rc1Va01KAqJM7cHPopWEbdJF9X5X49RVOl1iSsTWpfqGEOZCq3iW/Z5qG/PM2YxjM6A=
X-Gm-Gg: ASbGncuM1sw79R4QJ7vttUsY0g1aDGGml/QXfAURWo5PRLYQMJN8gNpDGexbiKHx642
 Irq2sddyNcq45cLFXom0IBVePSSr6ixi5L3i+p73eEoKNBRaHoGQMFZFLOmzcnFyYKncm/lT0/m
 thKG6gb6Cz8Z2uuVmb+FZuw3Die/YuknCj3lZfak7a4lV0VaP4hlwmAcNK2wR2Zi4vCCR2pOBGh
 wHATEOkO23w6Cdejnfg/LOyQchf06kLBAFREUOnU5RXKn0DulfISR71MECqQ3nc+Ryv0s06ms6z
 vc9HfGniIfF7tIKIaU756zrPYxfwY3f8BFSFs5MAtGw0QPaHhxqLuCFJ0Ls93O34SQa0TSvj4ML
 vryD/HZsMbBlcGS/afy/9+CGSv7EeW8RWoOd0+lvj
X-Google-Smtp-Source: AGHT+IE4PYoL3xb3WtC/3hgYB7W+UGFNYMZGe0yCm/iE3xUXvWAUpGNDepxttp3TWkBKQNBGePk9uw==
X-Received: by 2002:a05:6000:4304:b0:3a4:f7ae:77e8 with SMTP id
 ffacd0b85a97d-3a55869b507mr3805341f8f.15.1749673498176; 
 Wed, 11 Jun 2025 13:24:58 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561a3c538sm12071f8f.50.2025.06.11.13.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 13:24:57 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 02/13] kbuild: add -Werror=implicit-int flag unconditionally
Date: Wed, 11 Jun 2025 23:24:29 +0300
Message-ID: <20250611202449.2317279-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
References: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
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
commit 61a0902a06d6a ("kbuild: add -Werror=implicit-int flag unconditionally")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6c01ccfcb97d..7e1b36e78b93 100644
--- a/Makefile
+++ b/Makefile
@@ -436,7 +436,8 @@ KBUILD_CPPFLAGS := -D__KERNEL__ -D__UBOOT__
 KBUILD_CFLAGS   := -Wall -Werror=strict-prototypes -Wno-trigraphs \
 		   -Wno-format-security \
 		   -fno-builtin -ffreestanding $(CSTD_FLAG) \
-		   -fno-PIE
+		   -fno-PIE \
+		   -Werror-implicit-function-declaration -Werror=implicit-int
 KBUILD_CFLAGS	+= -fshort-wchar -fno-strict-aliasing
 KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
 KBUILD_LDFLAGS  :=
-- 
2.49.0

