Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE07C2D0CD
	for <u-boot@archiver.kernel.org>; Sat, 17 May 2025 20:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B594581FFC;
	Sat, 17 May 2025 22:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="B774622x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08AA48277D; Sat, 17 May 2025 22:52:59 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8A3C808AF
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 22:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3081fe5987eso2740803a91.3
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 13:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747515175; x=1748119975;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHLKB/7xXsgxezl21JdEOgebP5B3gXo/8iFPQw6i8o4=;
 b=B774622x6OGqzZyAI7hbprn6OKm2CD42UTGtTeG3kK2aOwFNzDVRpVQQ+RB4FWDKr7
 cJp9LzPu4mm7e3cy3bQ/CUYr8zehIXG89xrCzsYXmDNvOCa6GGoZEOvOQOSI1w/g5w8U
 D2Jm+wwlGR8+c3uNvqgpTGhKUt0F4G3wgq67k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747515175; x=1748119975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHLKB/7xXsgxezl21JdEOgebP5B3gXo/8iFPQw6i8o4=;
 b=bgmvZb2tg5PHxR7y1ZxDSc9tZzye/Yyh4X2M0VISA6exF+VREqKHKCkqJ1mr6wSeu6
 TE6VRxrYDpjSxQssbMKHo3f6FNjJJxjILSI+7iW6lCpjpJqghI1GBACU5d74pXNSs4xO
 eyyZYXb1f/zlskmqa8x5tT33Ox7evi9aCykhqWB/fw5y2NSzeM3sfwY+bIHyqgw74vPN
 DNQWS/oHfhXmN+LyhT0gmnw/dZlPO1vKZWWrBfEgwRwu7MqvXhBuf63ywtzRIpFKghCs
 PYj3pljqkKhHgOc5zaiDh8gNkIK9AQ0/AiItw55mrLF0mFeXx/OrHJGAovD2wywbMCi0
 FFKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/y0ZVi9voxFz9UVCshzU5bPCS3MMnhdGlnUmLvJ7Vmr0TUIIv6va74grXzg1dsY0C15XXcf4=@lists.denx.de
X-Gm-Message-State: AOJu0YxJKPxq+ZXSylABcRapBlMU1SdrS5ZA1u+jfEyWSaIM27YwWV+2
 e5O3P28h+QxyA+JefL/yK2n1m9Hluw+6nqtAGVsNy1oJdO6y9Jxz8J9wvO17n5ZHLo7QeAqyZF/
 mDuX/5zB+IGCIstdJY3GykBiGhMJd5Y2DANIe2dsknA==
X-Gm-Gg: ASbGncsBZYGi5AvNgtkKxEYeSNUEWqUw1M11xWRTncpWyRAFnElikIgDjJBGnTWZkCV
 rx8qJ3J6R+myTjrnPuHC7qC/P+Mz6i9wEmFEKtNXSEl1DJtO7FS7hyMi2BdbX9VzMfhO7uiVkDo
 xTp1T/Nm+2LnNn2RcVDdBeV7iSITao1Q==
X-Google-Smtp-Source: AGHT+IHRrrzifBgquL33ASmEE66qTjwDlTUYsY31qiEg6WYVEAyqvkT/u07IxpDry7Y/rYcykr4jJ/HIRh7tPaun1QM=
X-Received: by 2002:a17:903:46d0:b0:231:d16c:7f6c with SMTP id
 d9443c01a7336-231de2e95ebmr101754745ad.11.1747515175182; Sat, 17 May 2025
 13:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
 <20250515131246.784206-4-dario.binacchi@amarulasolutions.com>
 <CAOMZO5DdjRT=qGVd+qLXraud8xC=noioduLvDObd1B-n--7CdQ@mail.gmail.com>
 <CAOf5uw=iBNKu3Qvpa1WoYPy-RoKXM7PQtcdBaXupwrtWAKNAFw@mail.gmail.com>
 <CAOMZO5Ac3NdTu=rWJ4e=YR5t=ck+qbNbf9SH3zikUghqMineMQ@mail.gmail.com>
 <CAOf5uwnfC0nLBy1QhcDe_VpqE9LGh5fKV_Br4_=rZxMBNHw1ww@mail.gmail.com>
 <CAOMZO5AcUbYa0+40jZ=2a1dxO7D+tif82Arkguf_vVsP=CkzAA@mail.gmail.com>
 <CAOf5uw=cb2jQK1f-avqRvYxukYb-Sy-jWDvqEyM+nRLTnXcAwQ@mail.gmail.com>
 <CAOf5uw=099igk1=dEXH6dbUDMSH+bVo67mek_P=+G3Sw-f4B3A@mail.gmail.com>
 <CAOMZO5BM8y1ojYONMRBm+gBAgQ7ThWarzWZqfrEHwm3fM8_2Yw@mail.gmail.com>
In-Reply-To: <CAOMZO5BM8y1ojYONMRBm+gBAgQ7ThWarzWZqfrEHwm3fM8_2Yw@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 17 May 2025 22:52:43 +0200
X-Gm-Features: AX0GCFtYce3OeTFqbcwA5JtaB40mQTSFXXlu0gvvCGNz09q0QoP4_l7Xt-bfNNY
Message-ID: <CAOf5uwmU2--9+UpZL7uE6HvNUgo7w5H+boA0icw9WcRv=2GAOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] serial: mxc: restore booting for imx8mn_bsh_smm_s2
To: Fabio Estevam <festevam@gmail.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com, Adam Ford <aford173@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>
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

Hi

On Sat, May 17, 2025 at 10:50=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> On Sat, May 17, 2025 at 5:46=E2=80=AFPM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>
> > > I was on master except this commit
> > >
> > > commit 128d997a8772cc174f38d529d8b25f90b3aa8ad8
> > > Author: Jonas Karlman <jonas@kwiboo.se>
> > > Date:   Sat May 10 15:32:01 2025 +0000
> > >
> > >     clk: Fix clk_set_parent() regression
> > >
> > >     The commit ac30d90f3367 ("clk: Ensure the parent clocks are enabl=
ed
> > >     while reparenting") add a call to clk_enable() for the parent clo=
ck.
> > >
> > >     For clock drivers that do not implement the enable() ops, like mo=
st
> > >     Rockchip clock drivers, this now cause the set_parent() ops to ne=
ver
> > >     be called when CLK_CCF=3Dn (default for Rockchip).
>
> CLK_CCF=3Dy in your case, so this does not help for you.
> >
> > BTW is really needed now?
> >
> > git grep init_uart_clk board/freescale/imx8mn_evk/
> > board/freescale/imx8mn_evk/spl.c:       init_uart_clk(1);
>
> This can be removed. I tested without this line, and it boots fine.

Are you sending a patch? or I will send it

Michael


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
