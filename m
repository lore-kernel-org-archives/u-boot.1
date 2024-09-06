Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEEECE7AA6
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 01:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49C4888BD6;
	Fri,  6 Sep 2024 03:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZWsW4g5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E8CD88CDA; Fri,  6 Sep 2024 03:09:31 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EE2588CC5
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 03:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6c159150ff4so8531366d6.2
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 18:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725584968; x=1726189768; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tuNsHp4TjuhaxtAOwupzauvH56//vKj9Gn75pMiP2fU=;
 b=ZWsW4g5kM9zVcvNCrh84z6/FhsHtG/tUpL0FuEZXXOztHeP/KG0oO1lfvvsOaUhC8T
 1mTFP1v+SoQXm8w7X+nXAgVlgn8BnV5JBHbSejkz4H+ZzYB+lEYOIFs5e6AHsDg9jTkN
 PAjh/MEqc7RhZcxtgVUEw68GDLo1B6M/lIgCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725584968; x=1726189768;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tuNsHp4TjuhaxtAOwupzauvH56//vKj9Gn75pMiP2fU=;
 b=ASWNR2vzrM8pSqdozhQpSwuby7ELneo2PlmQCiA6SW0Hq2E+8L4c8apjhGnAW0PRJa
 2maEoAzSNvUKfCfReUxeNQoSusiy7S9TTk+9jZ5py/9qwo7EBZ48NDjc7XI5EV6cUTtd
 Fhm7IO9OtvO498YQtYHyH7wSYwJSC0lNE1ouFF19iIKyij+o5bFCYNcA49W3hOOfq7NA
 rpKLHwkWOqwpImOTue6vIegQGU5hWCku+10WrLybn1aLHMPgfNnJCKuF/6DwZH6A5rgl
 MXAz0Lk/ZcpVpI3xo5CRT2BDYV8Pk2NqFc/4R+tzTVZ1oiPIDaeq7qM1YZz42GClWrKH
 T79Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVC9rNqHbIcneZxGD2PgawXnjEgD4b5kujQHKXWMpugvlLl5+KM0ErilZi5DIOI5W1JxtuHU0=@lists.denx.de
X-Gm-Message-State: AOJu0YzuoHFjHxx0fACRvpDYFGsApne5XCtPETtjI+Sn7nN+ACxA2km4
 olmi9pdN76mwABqey7ONY/8nPN9HQtSLIlO3Rf/JBtuUdvDfFGhO9U/yWV32ViE=
X-Google-Smtp-Source: AGHT+IFM3iOtTLjjLgp3KxuEJxbZYOY6Hxt9GPMqsntSpx4HYqkY67pwy3LBfiRy3eBvOMekHXpSow==
X-Received: by 2002:a05:6214:570e:b0:6c3:6799:ddef with SMTP id
 6a1803df08f44-6c5283f6d21mr13194746d6.3.1725584967922; 
 Thu, 05 Sep 2024 18:09:27 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c52041803bsm12145516d6.105.2024.09.05.18.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 18:09:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Minda Chen <minda.chen@starfivetech.com>, uboot-snps-arc@synopsys.com, 
 u-boot@lists.denx.de
In-Reply-To: <20240721065907.7518-1-heinrich.schuchardt@canonical.com>
References: <20240721065907.7518-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 1/1] mmc: consider cd-gpios in Synopsys DesignWare
 driver
Message-Id: <172558496623.1864439.9838811663120441423.b4-ty@konsulko.com>
Date: Thu, 05 Sep 2024 19:09:26 -0600
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

On Sun, 21 Jul 2024 08:59:07 +0200, Heinrich Schuchardt wrote:

> The JH7110 SoC uses a GPIO for card detect.
> 
> * In the of_to_plat function check if a cd-gpios definition exists and
>   request the GPIO.
> * In the getcd function return the GPIO value in this case.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


