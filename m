Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D501D7497D
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 07:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13C6D8920B;
	Wed, 30 Oct 2024 08:44:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WSzfKa6/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C95D89212; Wed, 30 Oct 2024 08:44:27 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71B3A89207
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 08:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c903f5bd0eso12379559a12.3
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 00:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730274265; x=1730879065; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=edHJVWhnLP5Q9bTiFB7k+KgWeKAnpxFWTQXxl1ICds0=;
 b=WSzfKa6/IFE2Il3O41VAAgrQ+mFLVOej+RCPq+e+RHBhEuWo9K3muwhJgP91cuZnbS
 oCnG7TlUUnemXyERJjxcqFf3GAGfwRPL2MNtERycV/11ev5WHfAkPM9lZr4GUUT3IKYL
 K2aP2h574VT1OXX7lu+fbyuuJY9oNu+wcRW7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730274265; x=1730879065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=edHJVWhnLP5Q9bTiFB7k+KgWeKAnpxFWTQXxl1ICds0=;
 b=n4pDataxLP4nWNPCSxpdKQnEAK5WWMoxh6fcV7/KBrsUacFAFAVGOCStxJUnFHciRe
 oT6llKymfyeRymwnq4a+B/pPwf3FYysV2p9XK1AiCRq2jLzdUARBSvxQzIAMjzoGYBCp
 1wcz+46Adn47iZ9By4QIjIaPA0d0c/oQO9OGE8M3fNsjowlFdZCviuRV6v61Kowow1jE
 7aAbDepzHoAF9mxktM5r9E3yu5Nt7S/CTookw9YgkNOujT2opdwYivjRhkGW29itXaOd
 4jnaYEv0Yfx9z8CJeRXoScGlCmMTPuu/Vk5G4nZGCJk8Q7AXFkBwA+dhzEbch/UTHeft
 FTbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxeJd2iwGI24CbOaqovgTTrEpO+qbyoBAKTali9DCbtrWGhkiBqi1r+nVzM5YmWPvnRB25KvE=@lists.denx.de
X-Gm-Message-State: AOJu0YxnV5OJWwYUrtM0U/HTftL5h9clfiA2i6BAzxUFnQcOikUJZiMd
 vumZa2SyaB6Me8QQ4LPfmmHXUYyKcVo0J10xVMASoltkg5q+8eU8LMfLoYDc+LFYMlZbWsXPTj6
 p4k2l+4jQYVxtmZVyQ1yFDFqZE8nrovKya05a
X-Google-Smtp-Source: AGHT+IHA9LtpcLPLgJARQ6oPmCla6YqS/2zDifeKCsG4iiPKB+4KUi/6ExL6muvW6AtXB2XVpLHeAvbjqh6mkMIPmNM=
X-Received: by 2002:a17:907:e87:b0:a99:5cd5:5b9c with SMTP id
 a640c23a62f3a-a9de5ee1155mr1326015566b.36.1730274264937; Wed, 30 Oct 2024
 00:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20241018163423.1562287-1-jonas@kwiboo.se>
 <20241018163423.1562287-2-jonas@kwiboo.se>
 <CAFLszTig2pF8pMhUCjjcfcJ6K4KQK2oWahsO7L5Bn9cwq2LEPA@mail.gmail.com>
 <4484bfde-12f6-4b0d-9e91-d2ba58e551ca@kwiboo.se>
In-Reply-To: <4484bfde-12f6-4b0d-9e91-d2ba58e551ca@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Oct 2024 08:44:14 +0100
Message-ID: <CAFLszTgdvHQHf-KdsudWpGBpb5fEHvqqWNJ07GeVeo0YVzZa_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] rockchip: rk356x: Implement checkboard() to print SoC
 variant
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Tom Rini <trini@konsulko.com>, Dragan Simic <dsimic@manjaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Jonas,

On Sun, 20 Oct 2024 at 00:24, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2024-10-19 04:00, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Fri, 18 Oct 2024 at 10:34, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Implement checkboard() to print current SoC model, e.g. one of:
> >>
> >>   SoC:   RK3566 v1
> >>   SoC:   RK3566 v2
> >>   SoC:   RK3566T v2
> >>   SoC:   RK3568 v2
> >>   SoC:   RK3568B2 v2
> >>   SoC:   RK3568J v2
> >>
> >> when U-Boot proper is started.
> >>
> >> Information about what SoC model, variant and version is read from OTP.
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >> ---
> >>  arch/arm/dts/rk356x-u-boot.dtsi        |  4 ++
> >>  arch/arm/mach-rockchip/rk3568/rk3568.c | 65 ++++++++++++++++++++++++++
> >>  configs/generic-rk3568_defconfig       |  2 +-
> >>  3 files changed, 70 insertions(+), 1 deletion(-)
> >>
> >
> > Instead of this, can you use add a CPU driver? Then it should happen
> > automatically - see print_cpuinfo().
>
> Unfortunately the CPU driver seem to be more related to the /cpus nodes,
> e.g. the arm cores included in these SoCs and not really related to the
> overall SoC used by the board.
>
> This instead depend on the DISPLAY_BOARDINFO and its checkboard() as the
> type of SoC seem more related to the board soc target.

OK.

Can we get plumb it into try_sysinfo()  somehow? Perhaps add a sysinfo
driver which returns a new SYSINFO_ID_SOC option?

I'm just trying to handle things using driver model, etc. rather than
weak functions.

>
> Regards,
> Jonas
>
