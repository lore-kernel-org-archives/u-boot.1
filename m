Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F0CEE0AE0
	for <u-boot@archiver.kernel.org>; Sat,  7 Feb 2026 15:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D79683693;
	Sat,  7 Feb 2026 16:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XxRevvye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C3C583B8F; Sat,  7 Feb 2026 16:36:21 +0100 (CET)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55E0D8341A
 for <u-boot@lists.denx.de>; Sat,  7 Feb 2026 16:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-45c9f47e1e8so1098151b6e.0
 for <u-boot@lists.denx.de>; Sat, 07 Feb 2026 07:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770478577; x=1771083377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OkjpbsleZbJnjwAoYrhkprKZF34SMUEMlgN8cbn0SI=;
 b=XxRevvyeoBvGgY7c9Xo5r81DfmpTX8m0KpFMPkynBRx705zDWHCwYbnKEORepBatG+
 uowe+sN4j7JXLS7p20+z6CQ9Vbgq4moruUA2Kz4WA8cqb28xZT6Q8wCiK25jYwO+WtEr
 ezwWfg9uXTKraegUb7ImGq/V2F8GkC/WQulG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770478577; x=1771083377;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9OkjpbsleZbJnjwAoYrhkprKZF34SMUEMlgN8cbn0SI=;
 b=SV7g1aTHYa7XtjRVERLmMYbyTj0ne/wMqEU+rzPuFpjoU+ypbVcdKs+snE52oly2i5
 6vJj8J+HQR+5GyCsRrktJKAQw34dUPxa2E40sIebn0h7HHF/bfy0zviahjNy7rro0tmO
 6W2jrhQCMLu7e0nZmQrM3ZusvwT+7EJ13zF5iwNwb0Dijx3BMsfyRznPIbJNMg1nfotw
 ZucM2Gud+z8mWbM0Dzi4Xa5ymqD0Syvd4lW22FW7xJk5bbP3kT9qrA3Gn7ZrKonvpqgM
 d1BqF2UMPxpGQ3mvt/rV8A/OWDelbcwzdcRDqVP8oTfF6OJumdZu87gYMcFDM9UK9g0z
 waPQ==
X-Gm-Message-State: AOJu0Yyopx5Kc2+nDAOywgP6jbS1vDBkNGQw8d+1klq1jd8233/Iukze
 R0uTPMOcT4W7b2g0LufYAj9h5o+eyhSax14WVDXmndm1Ex/9McsFw8RE29Qaf4q9JNY=
X-Gm-Gg: AZuq6aK4g+et9HqQGmON34jqbF77LsE+090sG1+jyELNpW9CskHrJmiH7NyfXNBoFq8
 FRiMR3wbOaJYVO64fzQy3oVCsiSQgFfFHEjUX1xE9P6vSiFlxPrUlQ1Co9PVvLaimrLsKLjZqR3
 AXtwRQMgnc6/aIwPKaGijFm0m7Bb5N8qzkLRbskQLjFLJHEezpggz991LP37J0u2XwwJcElyAOu
 npyQucqndld80OPX2Hii9f4i1FQa0+7r3Vkj87vAE7f416I6L72Kh4XL+qsDNu9OBntmbSpuKuO
 lpLlcaphvs1MPZ141/lZ2mnfdX4QlCNUKRUdLzal7kk7C8HuceSvXifgJ+bdV3NGfhV6akyz43T
 GpixWHRcTvBaJIUTDWMFaLXnzr2e5JjqLJb3DS1tJ2Xk3vssMX4sePrKlYlEjYb9c+79lnBLYYc
 vPLX/YS1+u/haH+jsotURUw5Pa27d2/qh1vwsCziKaeFPut/I7X2HEgnZeOt3C7+DeEjx4dBUdF
 xmFkUZU9rdVZ31To+xD2nAgvP97jezwacamMw==
X-Received: by 2002:a05:6820:3088:b0:66a:1886:e4c9 with SMTP id
 006d021491bc7-66d0a475eb0mr2581691eaf.20.1770478576964; 
 Sat, 07 Feb 2026 07:36:16 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d3b2a6c16sm2941332eaf.16.2026.02.07.07.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 07:36:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, niko.mauno@vaisala.com, fberder@outlook.fr, 
 peng.fan@nxp.com, hugo@hugovil.com
In-Reply-To: <20260207023905.2794478-1-festevam@gmail.com>
References: <20260207023905.2794478-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20260206
Message-Id: <177047857616.131189.15521636681826728988.b4-ty@konsulko.com>
Date: Sat, 07 Feb 2026 09:36:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 06 Feb 2026 23:39:05 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit e5e75ea8c7b8e6d9ce1ca8ec7a25fa8b3f6029a9:
> 
>   Merge tag 'efi-2026-04-rc2' of https://source.denx.de/u-boot/custodians/u-boot-efi (2026-02-06 12:35:44 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


