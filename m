Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF36C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 00:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 912E182CFA;
	Tue, 29 Jul 2025 02:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mlybG0Z6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DBFE82D21; Tue, 29 Jul 2025 02:22:56 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4BCE8277D
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 02:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-73e82d2ec9eso2813008a34.3
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 17:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753748571; x=1754353371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4ke2WwLR1Q/fVVod79qHmXun5gVpse1SlIs+3AO5O0=;
 b=mlybG0Z6WoEVPIc7F5fcMATX8KRbpst/GqJT+Xr7y5H2iaD6+krcJM/2PyHsyJlc4B
 LVWxtBMi8V72GTI8CvRwm6ixwOUN3Qoc2XF3siCLyOGlbSUanYoZj33Dz6vo9eNsIXzo
 pzyiMXfW0OEhzYm7OP57Vvs47LJgD3RnkNCPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753748571; x=1754353371;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z4ke2WwLR1Q/fVVod79qHmXun5gVpse1SlIs+3AO5O0=;
 b=iysRGCzQtBlT+7e0MYB7wkLKxwEQpCZuDiZgJMBPDbyur01VAcorMm60heEreFR3d6
 3Hu8K6fb6CaZqGayLsyZOBnYV/cVKzFaMrKk5gryhGx3biwjvx525puMpBeHH8IS1sXf
 pvFzUxDGLE4jyk+ZrcSzId29fyNyuvkDp2VIgMjO3w1wUJhMh39WHAiOH4Aos3bAX/jD
 GXPxjBDcQmI/A9LGkHow1MsbPiNMRV4cGOsSo0zUpoql7/TkxrT37Zy7RGEDw3zTDWFR
 tgSusvchH1MFK4CVs44E+qCkmRS2skHZLpVRQFULOsCD7aNzHvxd5rjTOZobiwc602Mp
 KVTA==
X-Gm-Message-State: AOJu0YyyOnbTnA5V0DsU6GzxntzMJ/71FGKeXriXLPLOMiNRAXTqEYn3
 bT5hs8ql6A8gpOr7p/ueihhe4y9KFn+yKdn9JU70LCqheUmCsgK8B32V+BSooiS7u8k=
X-Gm-Gg: ASbGncuJ/kK5O3iMxqmccmMu0gvIDyqEERvQfmZJ0esd5i/ffyrwpimCmpZrB40B2dO
 KQl24YUle5ycwgX/7aPOT5ioRDKBEWh2vlukdcQMA+sNzGq6XyDZ2lICv3wGOtwEUr8t+QFCFvC
 cvIfQkGByQGp7N3fWO2u5JwQjY/awwxgiunDX2b1ZiJF0jq4knDwT+UyXBSTm7gRAwX3JpZ7xTc
 JxqMcDR/tU1mDbaJ0GlNBb2qBFXZBn5P4tppv0lIc97obEAHvhA8FFgWl90S3qJ/zoFyCfe3fev
 Lk911lKgpGd1t8coj12+DbV57+u8WvXaSkcB7GIT0guI925NVIsi/1L9pNOpLbZ0iDK198zkq1z
 iCfwZiuY0lCAX0z6jtlG0vF4/QrYCtPQhcNoHRb5+VKFOGwC/HlllRcI=
X-Google-Smtp-Source: AGHT+IGVu/oUfF3SLd4W9hTFr4KBPDOeCgPV1epxZm7fG4+THcqsHkG5DiLF1zaXzxRNg1XufVKIBQ==
X-Received: by 2002:a05:6830:44ac:b0:73c:d48f:6c6a with SMTP id
 46e09a7af769-7413dc39287mr10248052a34.8.1753748571621; 
 Mon, 28 Jul 2025 17:22:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74147f4afacsm1317900a34.10.2025.07.28.17.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 17:22:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250728191814.584260-1-afd@ti.com>
References: <20250728191814.584260-1-afd@ti.com>
Subject: Re: [PATCH] arm: mach-k3: Fix typo for TIFSSTUB_GP in IMAGE_ID
 enum
Message-Id: <175374857032.1768483.8641164939904879878.b4-ty@konsulko.com>
Date: Mon, 28 Jul 2025 18:22:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 28 Jul 2025 14:18:14 -0500, Andrew Davis wrote:

> 


Applied to u-boot/master, thanks!

[1/1] arm: mach-k3: Fix typo for TIFSSTUB_GP in IMAGE_ID enum
      commit: 0faf23611e103eb7bed705c2955e00bca8ec8857
-- 
Tom


