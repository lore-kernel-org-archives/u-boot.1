Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD27C87FD2
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 05:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74466843E3;
	Thu,  7 Aug 2025 07:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zk4q6SrE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2FCE843E2; Thu,  7 Aug 2025 07:32:48 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB81583BD2
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 07:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-31f017262d9so597451a91.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 22:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754544765; x=1755149565; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oy9G+MWXnn1ko1VUZg0DE+CN4s4cmDBTloo0BmhtuU4=;
 b=Zk4q6SrEAXnIO0kiNlIZZHzG8afNGzvSU4CSMf45PN6W+uIkDDlbUkFOkinbf5Hkzz
 n8V5gVPZA+EEbIoly126m5dc9x+8erXdtzeOUXw7DzY3tG3c9V7qa0T5T7tPqC/niYmD
 vhyZEMZUqwALv1k5W0bLCTM1ogZPp1WrmepOmVjnTpzqnuuCO9c0n+D49s5IJIWpwA2N
 wLZ/c5RaJh3cnS6B94c5BWc+MLux206YyQeEmo8Wyn78WkQZeSNIri/ZoJPC3u8bDpWq
 lFb5KhKXqM14aMgdbe0/9VA6yan/U4ctRNkO4FBnoluaZVGqG1Emxv9NcF0fAv77jRKZ
 x6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754544765; x=1755149565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oy9G+MWXnn1ko1VUZg0DE+CN4s4cmDBTloo0BmhtuU4=;
 b=FRSnWJIVGPTZLYBJt2S4UeOjK+Fy5s+McWAcrlkuF4EZiWctCZjw1FOkf/nK8+nu83
 2MYz83wAgGumIdWXIvkL67k24iSNGaehiVST8yYsdg1bwQO5/gUpacA9FHcUzmZaR1kq
 XAnvkViWllZEeVAdgRjC+6Jd5rMWreyNM+exY0p0hfJpHtGVnQG3pFEmY80uBQdedtIW
 R67QTznkHh8RQjfkjbhytGT9cuxGPWlPqQ6UkXCuBk3SgvjreZFamGSb9x80ifzqUjjB
 86c0q7XKQ0MMmgSdcc1Jz77fYhf1djojtwBeKcjr/Uqy0p9In+2JUgBl2RfWK4Z5dHwY
 x85w==
X-Gm-Message-State: AOJu0YxYBpyijK/mJbZHaGrxYHkidJ92pxnyZyC5kHlBXcTKw+YanUOQ
 hA6qpk5aYOtBsF7uvnC+gscDrM+VLQdMDf+d6dY2pw5LWjAuycylEOlI
X-Gm-Gg: ASbGncsZwNCQywYF9fBdVSC0Q8yhtE0ZreeyHlo5xu4wjiVx9ty6fEjPFgxmF9+fGoA
 p7NXUtwhBqf6YOSmX3MXbHBWyfUVXEx8jGJCbfuo+iPOWz3Zntx0GZUSawN5CKzbCNuAvI+LNfF
 xK744yA4GqOsiDO0NReoYdJIywuEAQRO9CNKZq1OTd2Mg68I4QSFvqEqz2WQ1WYCVQa6KaIlwZD
 13a27FQlDZCUkLf+A16RzdL+jWOCxdF9pfS0WVQXfMtRmcMOPDzAzgZZ9PEICL74OCscFcpu9Ki
 NOzAqv67ziocn5fA1sRkEILZb2lH7GuqsvpJT/Shwe5KPJxdCkDkKryApZwk7CS8rcBbuMWYpQn
 ctdQ5G0sUjO8o0mVMX22Pgc4r+QaSQEpc1+vjO0+iWLXz
X-Google-Smtp-Source: AGHT+IHHA4KcIQFwWZJScEycFyb1i/9ayuwI+2PL+K4c5MrvI5d4Efiu7tzm0bSoLMsZ2wBHi5rr5g==
X-Received: by 2002:a17:90b:4fca:b0:31f:8723:d128 with SMTP id
 98e67ed59e1d1-32166cf1fccmr6441966a91.34.1754544765172; 
 Wed, 06 Aug 2025 22:32:45 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3216126c98fsm4384084a91.21.2025.08.06.22.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 22:32:44 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 YSCHU@nuvoton.com
Cc: u-boot@lists.denx.de,
	Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v2 2/7] pinctrl: npcm8xx: add support for setting VCD input
 source
Date: Thu,  7 Aug 2025 13:32:19 +0800
Message-Id: <20250807053224.2169557-3-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807053224.2169557-1-JJLIU0@nuvoton.com>
References: <20250807053224.2169557-1-JJLIU0@nuvoton.com>
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

From: Stanley Chu <yschu@nuvoton.com>

Add pinmux for the VCD input to use the HSYNC signal.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index 67e564f85c3..c960ca3393d 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -23,6 +23,7 @@
 #define TIPRSTC		0x50
 #define CORSTC		0x5c
 #define FLOCKR1		0x74
+#define INTCR		0x3c
 #define INTCR4		0xc0
 #define I2CSEGSEL	0xe0
 #define MFSEL1		0x260
@@ -280,6 +281,7 @@ struct npcm8xx_pinctrl_priv {
 	FUNC(lkgpo2, FLOCKR1, 8, 9) \
 	FUNC(nprd_smi, FLOCKR1, 20, 190) \
 	FUNC(mmcwp, FLOCKR1, 24, 153) \
+	FUNC(vcdhs, INTCR, 27) \
 	FUNC(rg2refck, INTCR4, 6) \
 	FUNC(r1en, INTCR4, 12) \
 	FUNC(r2en, INTCR4, 13) \
-- 
2.34.1

