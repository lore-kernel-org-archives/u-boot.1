Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF209C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 14:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC6582F50;
	Wed, 16 Apr 2025 16:11:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WQiGu3sW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEDF082F49; Wed, 16 Apr 2025 16:10:59 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF21F82F28
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 16:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2c7b2c14455so4397122fac.2
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 07:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744812656; x=1745417456; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lijlz2tiPd2WzWA1b3WyAkyy1aeV6BYAtMYGveTGMqQ=;
 b=WQiGu3sWTO481AGsBl8+Kmg0h4AegzOcsA+K0nyAH8xzf9JkPSAB/I6c+VRM0oMZ+R
 vSFYGBulMy29jiELEM2gud0pQ4+sebofSacpl8ZLPpjCv/IGFtPnUUATiKSAfnQFp9wS
 tEQ15bKgS0wQXG5BEucP5JWjKBBPst4VkCdTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744812656; x=1745417456;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lijlz2tiPd2WzWA1b3WyAkyy1aeV6BYAtMYGveTGMqQ=;
 b=c58yR3RQHV90xcZAnr5P/sAKvi4Fynf3dKzWhN8BN7DYJ6CCtPBWsPom7olA1LjZee
 RZDV3ATJLyyaS/caj9coytTSSSir5liRCwHKOm4qYT4J6/LObYcYGFfcOSBD3riQ3i5V
 xLV2wIECRQilwADPohXiRGiQsx3cEqGdYYima+gD33OLwYoD+VC7BULN6KqZDgio9I9j
 i0AgBoYXWcweaVa72KWmUgVdHrBbrhm0JpSyAIvNUIWtnYUqXqEsH2k5jv9yt+Y6K4PF
 mmTlcgFT6tq/yTpDK/L5+p+gJl8M2tukNA6VLUvlD91AoiuWHjd5lvcneKAAzl2cc6P9
 X+SA==
X-Gm-Message-State: AOJu0YzIa+uyMgcZEypn15lyfKLbXki4RJbq2+Jht9n2+M8CWSrsN8tS
 7g600lsT/uW3lFok/L6qYFZPBG+akWWFFgJxAhNbuymyVfM5SxZIHM39t346PK4=
X-Gm-Gg: ASbGncvacdHW9RFIvrIJAr6gajWOMiNf/86yWCyKe8KeDKL2QhBejcNvahqSW7RdPBm
 5wP6WTgg7fh8SR5+dayKRe9dwJwKj5rjvu7JyINFptxTgCip40SXt11q6sJ1t1ZjrOsObvMZjF/
 F7uEEj0V6lvdtmWqVUZlNPJTYQPevYq9GWEi5VrAqxQ5yAqgEdeFbAZNMOA3uAfOy0AwmVIbTv8
 gAO2I5OwBrfdECa1PzsnAJ9WlY+PoOIwB9zu77B82MxIijgsRu8PQ9e+WyxvgJtC/4irj+9QpVk
 p5LUDrUI1jb134NyfLsN9Kq8AYTwworVzjXhBjk66e+rFiUT3qVd4qVGi+SRy+Y0YoPDTdu3IHc
 I
X-Google-Smtp-Source: AGHT+IGVWUkV7wLPO1Gr+6rgSUzN0tDZEzmqw51l784tSn1FK4FEth4Rbet68jvnnMiIBIFmnrckpw==
X-Received: by 2002:a05:6870:3e0d:b0:2c2:5639:3a4d with SMTP id
 586e51a60fabf-2d4d2d58f3bmr1076592fac.38.1744812656485; 
 Wed, 16 Apr 2025 07:10:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d09695a14csm3314722fac.15.2025.04.16.07.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 07:10:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jesse Taube <mr.bossman075@gmail.com>
Cc: Paul Kocialkowski <contact@paulk.fr>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Trevor Woerner <twoerner@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>, 
 Jesse Taube <Mr.Bossman075@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Richard Weinberger <richard@nod.at>, 
 Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250409180833.3812679-1-Mr.Bossman075@gmail.com>
References: <20250409180833.3812679-1-Mr.Bossman075@gmail.com>
Subject: Re: [PATCH v2] common: Add CONFIG_SKIP_RELOCATE
Message-Id: <174481265526.2150978.12494035866825764527.b4-ty@konsulko.com>
Date: Wed, 16 Apr 2025 08:10:55 -0600
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

On Wed, 09 Apr 2025 14:08:33 -0400, Jesse Taube wrote:

> Add a check for CONFIG_SKIP_RELOCATE in reserve_uboot to skip the
> relocation of the U-Boot image.
> CONFIG_SKIP_RELOCATE skips relocation of U-Boot to the end of RAM
> allowing for systems that have extremely limited RAM to run U-Boot.
> 
> 

Applied to u-boot/master, thanks!

[1/1] common: Add CONFIG_SKIP_RELOCATE
      commit: f9d788d925574109ecf239a16def9450cd4c3ecd
-- 
Tom


