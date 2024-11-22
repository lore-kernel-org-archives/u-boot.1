Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1E4D75E37
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 12:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 755CF885F5;
	Fri, 22 Nov 2024 13:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NYKK75fM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC2EC89703; Fri, 22 Nov 2024 13:38:51 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7328489392
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 13:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2fb5be4381dso24958591fa.2
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 04:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732279129; x=1732883929; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVqAOmde2Lk/MfA2LNLcxbgLnOSCxBr+hXq8MRusCHQ=;
 b=NYKK75fMMWEO+gB/12rJ8RlEhXGf+c2E89ww06CsDyzD+vkEbzk3X2bXUgBn1nxFBz
 1872uhi7uFzYGVjR+GIe/FAEKSVjMmk5PZLBsn0JpJJoPkknSE+IK2T96HdbFYr2apdP
 pXreQ8wbQYqENmC9KsrBQZjD1mw5fPXkkV/wC/w5uWjdABJeAzPXuYisGe5CApNwVawW
 yCDczRNPJpF9bsb2TrMuakL7RdlE5749w3GltesfKVeu3b4+28o/OA0u5xtP5bFTPbb7
 jwtjYn2pU1lyNpRO3tEnl5ZgX2b7q43xFLuPuaoPTmx+v1cUlnSR0EjuHbmuqO7IvhQN
 ZEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732279129; x=1732883929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVqAOmde2Lk/MfA2LNLcxbgLnOSCxBr+hXq8MRusCHQ=;
 b=sbvdoKY5f2V5NHr4ltGNJULYW2l6kBsqDWlvagwlwwruRYPnXtgMJM0dPaGOMnICuj
 ASYtaIGA1+zrdQhoKUvtzHq7HNZf7zDyI+U8dowPcsw5t7RGOq3Vvt8btZO0JJIYvdLN
 +NaLmqOZIjNd4JI1GrcZL0AC/fg5HDHcop5oVJpfPtng9WOOb1IBSGP6oXhnPfjeQkQB
 vbBCGSiUpgd0erslUA9aCtXb4jl+MBktRNatfu4STmYM8oErP6xLCeXWhdQPT6VNKGLR
 3buWRABmLk4W7328z7k3BFy7EhC6MwcOz+b4oAebKpOGiVZiNE4dvaBsIkd2TwIAmIQC
 /LWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMY6INtKzXD/d5sBh4bjGPZG0rcKT/Pj2Pu/42Z6PQwkPuB0NU3ei3Nwvd+dzSoveZtYDcoTY=@lists.denx.de
X-Gm-Message-State: AOJu0YxM3qo4+Tsjd/+zpbBuxh07f8XEHW4reMnK3IT+QZ8usHTOYgDt
 I3uRRdCKl/e8hg6AiB2Mx1y6K0WzEE4T+gaTntUDnLHAbuBZ6g7xizF8ZPP77MJr6Yk5idi3ijH
 6V4dZ53CZ7AmZDn8ITnijuzq/xSM=
X-Gm-Gg: ASbGncvRYuF/HnIvpv2gDFiTyIDIOuYEYkqOJVN6Ttp05o/HZgxE01vQaRdLNh6pXjI
 s+EUijAvh2wdkR7bOZUTc+NWm3jtCjdWa0d8nGtwOdSUqVECpZWZu8JXifWo=
X-Google-Smtp-Source: AGHT+IHkZQZGybecwTDXy0/uZaMn6BLI3KykEsiCeB1bZ+EAJvvYwqwvHDSgwXXw3pFbY38yzamWKTOPlDS2/TtnZ1U=
X-Received: by 2002:a2e:be04:0:b0:2ff:58e5:2adc with SMTP id
 38308e7fff4ca-2ffa70f711bmr12006341fa.1.1732279128448; Fri, 22 Nov 2024
 04:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20240707082001.20746-1-michael@amarulasolutions.com>
 <20240707082001.20746-2-michael@amarulasolutions.com>
 <CAHCN7xK4YgEt7xaA6Ln3Q3GzvOP-iZM+YtZwP1Hg402VstBcOg@mail.gmail.com>
 <CAOf5uwn4T573-BDegO8giorZXeePbYszuo3dk1TEmdPvY0+dQw@mail.gmail.com>
 <CAHCN7xLgLwSv_EySui38ePeDqOfetWPi5R7dHJs+exVdZYnjHg@mail.gmail.com>
 <CAOf5uw=r=FsRRmD3tgONbxzCnv-rd2DS3d1bvt4zBHgQn1zomg@mail.gmail.com>
 <CAHCN7xLc0hzXmDaES9961jQ6fXtqof093Tga6d6748gxGYA+Jg@mail.gmail.com>
 <CAOf5uwnZeWTM=doUQ1P+OAoq3pnMPt060LtwaXt_Rnj+GBwjhg@mail.gmail.com>
 <CAHCN7xKg2jBJVfhvz2gCeTBgvMVR-mm0b-L_wEQsZBX4z0UHVw@mail.gmail.com>
 <CAHCN7xKCEjwyhfnCi3un94ssONdJjApMVo3FCRAydGd8Co34Uw@mail.gmail.com>
In-Reply-To: <CAHCN7xKCEjwyhfnCi3un94ssONdJjApMVo3FCRAydGd8Co34Uw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 22 Nov 2024 09:38:37 -0300
Message-ID: <CAOMZO5B7Yedk3G022s_Uoqu=8v9Ds5qD+pg+UNjnObcWNWUv7g@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: imx: clk-imx8mn Fix nand and spi clock parent
To: Adam Ford <aford173@gmail.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
 linux-amarula@amarulasolutions.com, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Adam,

On Sat, Nov 9, 2024 at 8:23=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:

> I did some more investigating, and  with the device tree debugging
> turned on, I get the following:
...
> clk_set_defaults(clock-controller@30380000)
> clk_set_default_parents: could not read assigned-clock-parents for 970ab8
> clk_get_by_name_nodev(node=3D92a30c, name=3Dosc_24m, clk=3D96fd38)
> clk_get_by_index_tail: Node 'clock-controller@30380000', property
> 'clocks', failed to request CLK index 1: -22
> Failed to find clock node. Check device tree
> Trying to boot from BOOTROM
> Boot Stage: Recovery boot

Could you please test Marek's patch?

https://patchwork.ozlabs.org/project/uboot/patch/20241122015858.557561-1-ma=
rex@denx.de/

I plan to apply it for 2025.01 to fix this regression.
