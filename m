Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B1BC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 16:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EC3082A8B;
	Wed, 14 May 2025 18:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="feGFbFM1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7470482A33; Wed, 14 May 2025 18:17:49 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A1DF82A36
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 18:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so45775e9.1
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747239466; x=1747844266; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lsPkVPCxZnzP5BUnYPC7FZIVkyi2chS2zosKx0p5Av4=;
 b=feGFbFM1ZuZgSadKVwaDUKkRL4WJX3+we3RguD6+fgO+xbg+5P0S3VdTYuMYqm+4ly
 4UD+Lx3NSrMFqPAzUY6wLJ5QfwjM7J0x/PHekcEFgtrAR64ap2C4ZF1j4xLtGBRBjNpW
 3/u/wo6AT3M3O8s8p8X3qkCtBVddEgT1qnZqK0tjr23yWhYblnaHQtB66icTsVH+SdEa
 kQz925wYeJl0arjpwlzdSrALYOAhIYc/22PukZqRhUyUtGRB5E1gdIfj26fTtzqIQZdN
 d28GbuF4jN9Zf8uEIxdqk3gH6FljrA88YEMW3bikGxuGbFHOpCoQWUpPHBz74PAG2FAX
 P0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747239466; x=1747844266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lsPkVPCxZnzP5BUnYPC7FZIVkyi2chS2zosKx0p5Av4=;
 b=IHhxhe2RO4iullAR7ImPKauK1xT37Bj0S7v7N4lypeLXKnZALacxyjD07tMkDf1MDO
 3q2wIhMc+CM1sCcCokFfP0WxKwRtwoAXRA9qky5MHGiJVgk3UWvszOnloUrjelxNdjCh
 wkDSyCxJVd32EofHMc5/WPC2+w8VXiX22H1d6rphrJAsfsg2Fv8b0RGkNWWEPgdHYLBt
 41UQCRJNSEhpM1/38NJfeRm9zF52VscalAj13G0i2w9IFShK+QDNh8IfTlq9r8rKqrW7
 HLMr+9/MmZynijkP17lU4Bz+Ui43RoYoUouch/lypi9GBVIm0BJRitOwWoow+QLp441p
 9tkA==
X-Gm-Message-State: AOJu0YxOxpPyZ+tJJolmkPsDNae+UhcJeAUPiyuKBWHBmzqnuOdD6VeJ
 FJ1fKHGRhjgW+mgQWnD2ij3n3xY2q1yX1ckrlX+rhKC/ws94gsYWvj1Wlko0ggw=
X-Gm-Gg: ASbGncs4eQiIdd0dbXw0Eaq85MCxfOR0MDXGdOb5DeONd6PQUsKjXdIcPqEzcTfaJz1
 NbmtznX/WY5nZWPtS+O1pw+5F4TQ8enU7M/lnZeSvgxveTlInNn/VHHb1rXX3efLmYx1fe37s82
 5y5SQ9baT/wNV2k9dFsdU27egf5cWg0BmpLKj/9YC050w9FyOwXA1/NuhT+CfhJlUbCYU+mrmaw
 9OjHmY09AOyzcBt4/c/LlX84Wmvpc+NRfKMf7NzP2+abE8Sv0C4/Vs0pwTDqK5qHbPzTMFVbENg
 r9YSccyMNZ+/sIz6hZnFQjebAIXbtzrfKA7yP/EQfBObuH5iQrbVSNjrmjzr
X-Google-Smtp-Source: AGHT+IED3KS+irUd6WoaOq+0eto9YZJehgVPSoaSI6tpojjaj4SzxHm0Xjw18VriNXVdAdX4R44Exg==
X-Received: by 2002:a05:600c:3b85:b0:442:eaa9:31c9 with SMTP id
 5b1f17b1804b1-442f2161077mr26014565e9.22.1747239465531; 
 Wed, 14 May 2025 09:17:45 -0700 (PDT)
Received: from adriano.. ([213.157.19.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f752f527sm10835555e9.19.2025.05.14.09.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 09:17:45 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v3 2/2] cmd/Kconfig: select CMD_WGET if ARCH_QEMU
Date: Wed, 14 May 2025 12:18:41 -0400
Message-ID: <20250514161841.3591411-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250514161841.3591411-1-adriano.cordova@canonical.com>
References: <20250514161841.3591411-1-adriano.cordova@canonical.com>
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

select CMD_WGET for ARCH_QEMU. This way HTTP can be tested
on the qemu platforms in CI.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---

(no changes since v1)

 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index f21d27cb27f..fa353c6fcac 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2153,7 +2153,7 @@ config CMD_TFTPBOOT
 
 config CMD_WGET
 	bool "wget"
-	default y if SANDBOX
+	default y if SANDBOX || ARCH_QEMU
 	select WGET
 	help
 	  wget is a simple command to download kernel, or other files,
-- 
2.48.1

