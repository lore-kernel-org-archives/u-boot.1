Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D43CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 130AD87897;
	Mon, 23 Oct 2023 09:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DPRDww9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BFCE87854; Mon, 23 Oct 2023 09:02:52 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04A9587893
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ca72f8ff3aso17971785ad.0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698044568; x=1698649368; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GZc6pJ4YnA1h1bRd0RgH/WgsahRVAbI8GDK/ghnPEJo=;
 b=DPRDww9G3BztkQZvr2vJJBkEk13RDK4PruSKJnB16VGm4D/AnXVdWh4awyyY9WN9X1
 GwX1+6PbRwvbObrcILeJRaLKsLf7dWtYNET9xMRFgdexQQPfquqzs9KiE8hYRd/voPRz
 HO6SzEhLLQCIKzepZbZy41YD4+hlX33SN3iXd3Wf0EvJJU6HDZoP6lIjjsheBotoOzqI
 MAmt0ee0iDnDQ4qa+cfVQSu2Rcj1k8NTHEBanayBFSHsiiWEr/9ril2DM/7lPX/kSVBt
 IgYmQJo5eURuN8vXG+VI0bJo2Ow+Gkvu+VwZzOTP/nUclJtAcufvR/NzNnFl0ZQ5Iwm+
 Sqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698044568; x=1698649368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GZc6pJ4YnA1h1bRd0RgH/WgsahRVAbI8GDK/ghnPEJo=;
 b=oLPyHIAHhjFmGfOR3pUbnmmBK7hY2/Y+kkrmsAorMEo5xjqa513PM8wOT7yWwftoc4
 nzr/ysl7Yx2aWpnKuaxfal1FXg8149hX2W56PkU34ooysZfik4DAC343Q/a4gfS5PeCc
 MYAmmQMGQ1gcv6OjeZNTrf63wz57HVgTFckAyjpll827fhcLNyArnzjREJGP1iwCptmj
 DhObduVBFCvSHBPHpdAQWAFhVt0khXeYp+kTWvK0qXhYimZb8NqTkcqkAZAfg0EO9naz
 PAebbmmxkkeDI34reNkFgmBHXLqEcWteAFDeLo7uO6wIl1KTfJkuD7RJxJDcQmqhSPqB
 NASQ==
X-Gm-Message-State: AOJu0Yx7Fvge/uIE0dsLERxiwi6fGJ+2GWo5vGEICxWw+1/Cn7AoHECa
 2Anv+FUHhb/d+CzHYG2Oo6Q=
X-Google-Smtp-Source: AGHT+IHMtM12bet6I4ehYfgHLlQGgUJLo17XlYMmSMxCOD4yQysy5vFLC0h1Z0qOEQdql8ZksHSbEA==
X-Received: by 2002:a17:902:d510:b0:1ca:7af1:8a80 with SMTP id
 b16-20020a170902d51000b001ca7af18a80mr7060311plg.50.1698044568386; 
 Mon, 23 Oct 2023 00:02:48 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.144.223])
 by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001c74876f018sm5368432plg.18.2023.10.23.00.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 00:02:48 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 trini@konsulko.com, jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 1/4] pinctrl: npcm8xx: Add name for gpio function
Date: Mon, 23 Oct 2023 15:02:22 +0800
Message-Id: <20231023070225.3142578-2-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023070225.3142578-1-JJLIU0@nuvoton.com>
References: <20231023070225.3142578-1-JJLIU0@nuvoton.com>
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

GPIO function name is needed in the debug log

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Changes for v2:
   - add commit message
Changes for v3:
   - no change
Changes for v4:
   - no change
---
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index 7976e3b3ed..ff49819b58 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -329,6 +329,7 @@ struct group_info {
 
 static const struct group_info npcm8xx_groups[] = {
 	FUNC_LIST
+	{FN_gpio, "GPIO", NULL, 0, 0, 0}
 };
 
 /* Pin flags */
-- 
2.25.1

