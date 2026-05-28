Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E27DCD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D08C0848B9;
	Thu, 28 May 2026 19:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N63vx4NF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DBB1848B0; Thu, 28 May 2026 19:11:36 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69A9384878
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso12563457a34.1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988293; x=1780593093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fgd32Z8mAOjhMyiw79E5c3BGMC1fSVpg93TqXfz0Tc=;
 b=N63vx4NFRxWSLb5HFGjtzaZYVHFvsGe6EufQzu2MCBRw3NDzXUkUSQBVxERtt68JVU
 z8N4uVHylEwQdtyPkhyK8sKrs5LIDUJvp3CZ8zMpZjpH+ZAOoIa5O4J63+n39bl002WL
 BqxCjyUtgtWH+OOBl9/Njjhd5Em9tIFM2al88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988293; x=1780593093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9fgd32Z8mAOjhMyiw79E5c3BGMC1fSVpg93TqXfz0Tc=;
 b=j7VeI9ioAV7f1gLvqkceysrrsZfT2/FyYIqHTOu2xOm8EHiWHLnermX/Y6/S0p3p+q
 W6wsgBAalLx8Mz377e4voMoKij8m/MtdqJxeokS8ZEUFuEmD41e4CPLnxeoK8Ql82MUP
 UH0C94JyPnszFeyb5x74BDQl1Q7AIfuR5N0YdnW8a8mgeZ4vZvVFnblnVOrqNwkerG+e
 0lA3CuDmvv52ir1G615C8KlKSNkWTzZU0T1fHSIMZUU4eD6V9RGGOT0vgg2bDDsdbnZk
 VEy1OUp3S0XxOSqr5LIEGkIw3Y+bRkk/EBcdPb6zHt4iRTKTsp0OOl952XGRz0MKoOcb
 fTwg==
X-Gm-Message-State: AOJu0YxJWhFwuiJ/Hjfgv4HbGJN0hVNPKzvojslUqwzfSJvn46/vmypq
 zneDghy3bueNEUYlOYhaA2K361tB4gLjVv35/iPwHWXdECqmGSTX0SQw0+46NQzIEHOmSUwMZ8L
 UKnFwxd4vOk0=
X-Gm-Gg: Acq92OFrLCKUN7pbNbJijNQ1Oa/iBjnWwn8SkxV7MK1aH/oDKAqQSzzh2ilClGF74Q9
 0CY8WNTEACSmoe5hX9CIZ/dUMLE5dWvleo0bHR9dSH68TkNC9Kgsj+jxqStlqPO9EykEAzuo9Yq
 139G2a9UGJR530yFzA+37RavotEX67oqSjTSXFbTVn35+gg2aIdJq1Elw+GVhLcc4CUnuDaMzvS
 e4NHTOapMaKE57mTODK3AEDVqtFHJ+zhl27GsFPdY0RaK33e4rdmw74uEIOlS7If4Z7JMXyWODz
 fKPPjNvjuQafNkVzBcXD90eOwwqupiWeXyhPxHMczTzSqnJZl2iexUwYJ5ylC5RQF4vRwPoKLft
 9uiFsz70ZFBA/xv17J/kUUE6pOpJmcSO1P0/yDBzWUeh1afenejud+yYLYNnnLLzuiMqQVVqmMG
 D1Fk4cFqrBLHtVTl0pVOL6dRhALIJH
X-Received: by 2002:a05:6830:310a:b0:7d7:45b7:ed8a with SMTP id
 46e09a7af769-7e68aafd81emr1257217a34.5.1779988293184; 
 Thu, 28 May 2026 10:11:33 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 16/22] rockchip: Allow SPL to set up SDRAM
Date: Thu, 28 May 2026 11:10:23 -0600
Message-ID: <20260528171043.910264-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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

The current logic assumes that if TPL exists then it must be setting up
the SDRAM. This is not true with VBE, so allow this to be controlled by
whether CONFIG_TPL_RAM is enabled, or not.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/mach-rockchip/tpl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
index a350ba56da7..a2d6079d1d6 100644
--- a/arch/arm/mach-rockchip/tpl.c
+++ b/arch/arm/mach-rockchip/tpl.c
@@ -60,10 +60,12 @@ void board_init_f(ulong dummy)
 
 	tpl_board_init();
 
-	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
-	if (ret) {
-		printf("DRAM init failed: %d\n", ret);
-		return;
+	if (CONFIG_IS_ENABLED(RAM)) {
+		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+		if (ret) {
+			printf("DRAM init failed: %d\n", ret);
+			return;
+		}
 	}
 }
 
-- 
2.43.0

