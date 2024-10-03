Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E8ACF34CC
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D1BC88DD0;
	Thu,  3 Oct 2024 23:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="esJkGkvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F22288D8F; Thu,  3 Oct 2024 23:59:51 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C0A188CC5
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7a99fd5beb6so215166985a.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 14:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727992788; x=1728597588; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/e2j0u/B7iH6/DqYIlHcDlDiTsuLPTEdGS3Id3K+nwU=;
 b=esJkGkvulyHdofzA3HlpMAFIs3Qzr3pa4wMBm022a1y9LBzEg1BwY7dGRKVAl6FPSu
 Ow1vinn7txrycoO1M7XpTwfzHOemfmrb8Dpx9x04L2HGJKGqafzCqja8T0kLpXYYBAl5
 HbPzFny/YXfuX2XQEkr2YvM93bT2FYmCbDuxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992788; x=1728597588;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/e2j0u/B7iH6/DqYIlHcDlDiTsuLPTEdGS3Id3K+nwU=;
 b=DCAC17rlwyaPoXc3tuVtm7oqw3PV2QYmA4LT3scQsHk7xO6CKxmzPW3z+J8gz5rlRi
 XA6N8c8e9TuPP8ETZPSDRYoI8gkZSAqMNqLw+rtAfinp55tALpxxAjafXXEPx4rq67QF
 gmq2HXq82GUPqgBpPhjHeUlosUVNUB5N4kYwfBqr8Algz0UNNQ8flbSmLlUPImn1zdQX
 sclXDt8yDeomOsed7oLgTrewFjI2iVtnpii8wlFhBMkvwwlQOOgTkXS+UNbwXieqPlSk
 +rmbwZVroT2SJW+pg9z/L2cgjLpWcvMx7B0/YzLpCojMCOscdyHv9RMPmbK0cce7aSqr
 /7TQ==
X-Gm-Message-State: AOJu0YwnXDSWxkQTVc3PK5d2Xuc/WlcdZU1hv1YGGl5xZcP16WkTiJTF
 2WGYzFaFBdneL0T7e895WlaLClF5fsbWvn8zSmbPciiiv+kx2EzyGe5AylkWsxI=
X-Google-Smtp-Source: AGHT+IHsTj9jgmOaM9KQMdaDzJQmUarxydBpc+M8En+if7gNKF+xM9M8Luy7hpwyii8SF3eohAlyNw==
X-Received: by 2002:a05:620a:4723:b0:7a9:db7d:11f4 with SMTP id
 af79cd13be357-7ae6f9d5a15mr153816885a.0.1727992787988; 
 Thu, 03 Oct 2024 14:59:47 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae6b39a72asm82652985a.28.2024.10.03.14.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 14:59:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <greg.malysa@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com, 
 Trevor Woerner <twoerner@gmail.com>
In-Reply-To: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
References: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
Subject: Re: [PATCH v2 00/20] arm: Initial support for Analog Devices SC5xx
 boards
Message-Id: <172799278569.2108277.4135982272259659786.b4-ty@konsulko.com>
Date: Thu, 03 Oct 2024 15:59:45 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Thu, 12 Sep 2024 16:50:41 +0100, Oliver Gaskell wrote:

> ADSP-SC5xx is a series of ARM-based DSPs.
> This comprises the armv7 based SC57x, SC58x and SC594 series, and the
> armv8 based SC598.
> 
> This patch series includes configurations, init code, and minimal DTs
> to enable Analog Devices' evaluation boards for these SoCs to boot
> through SPL and into U-Boot Proper, as well as devicetree schemas for
> the added DTs.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


