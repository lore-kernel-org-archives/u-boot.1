Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC03D1BDE5
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 19:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D038088DFA;
	Mon,  4 Nov 2024 20:15:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l/nLtb37";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AB7F88E4B; Mon,  4 Nov 2024 20:15:15 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADF4888DFA
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 20:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3e5f835c024so2534692b6e.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 11:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730747711; x=1731352511; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkSFZecG4/H9RLskD1p0ofwKGfkd7AoR600DTRmIDRY=;
 b=l/nLtb37hKlBIBI4yEMe73fTs9hfqg/4zSmJXwv9ng20aMzigcLHcBhZMjBCv6I+8e
 y806RUpoHvzgXtAANiQHJNlI52lwISeyyLdf7wORUUB0RiPYvKfuFSYZeoGXXN9b+1VW
 e8BDAe5bufRzKY8BK+lmntRCSVXx5USgZbXGbpzQjUFbzgG3oif2EJJjSQZxs9y87kU5
 ImgoBfbYE+JVoP2qF489JwQ+sB2tQAWQXvK0koHySHtGWIZR5SM//2gPd6f1lzWfiUg9
 fqCdmjFCMILQSEMfeOIsCaYu3UXnSeFIrF+YsvUZWsDlufgrHNRY4AFWCcKGYOURnJnN
 qpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730747711; x=1731352511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tkSFZecG4/H9RLskD1p0ofwKGfkd7AoR600DTRmIDRY=;
 b=pFE2TP3UyTVmeu/Gt64EbA9arRjJCxwa0LeLvk8UpK+l+CywFexap8aVRvv0mW76tl
 7JSBseDvB05a89kvX7fV/ybA/57eTGDbm9eVsaJc2JneXNcXPzmZcoxK/8+b2K09TTmo
 kywWTzUUceGivHUCCvSl7JqTvWrILmEIODzoPwbKI+nmbx+d2dBaXdQUapCjCneK3tdg
 mgrCPUz1UxT6pkmB4vpF1ibqO4uVvIGTPjQ3rmz4PJkgCnQIH7EXtE83AV4IET61s3nE
 aCfq39C7ze355NnKjXdP46t6bKFlPEnxdVvpp+oWCt0iSnFDcqkk4TRrOhwZ1liWJh/O
 AFAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXckIbYVp2RCCPjvjyxzAPVEvcoom+joChLXQcgu+7fE8GA/QcFE9Mu8ekHBnC0nA9dI5XhCLs=@lists.denx.de
X-Gm-Message-State: AOJu0YxzLyIMqXVvPWYV4vP6UHQXQtQkqkqNHpTmwZu10KGR4SXZA2s8
 IhwfV/FDmblJ4quiZ71ZLJxb0xfG70dI3SdiLqf62sQPM455eJvoHSiWVJWTyLie1sGK8WY/EE2
 Lxs0Fz/SN1MKEInCusAF4ueb/zlUAv2EB3sY6iw==
X-Google-Smtp-Source: AGHT+IFyyECJSr+xtV9s6sTJ3WP5fbLDn7CP4t8PAB5DgfKBCmK7jb47r6xA5gf6C6uIJevPZJg2N9wbBIVo3dnG5rs=
X-Received: by 2002:a05:6358:7e01:b0:1bc:57ce:9992 with SMTP id
 e5c5f4694b2df-1c3f9edb224mr1613876955d.15.1730747711366; Mon, 04 Nov 2024
 11:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20240308000432.32369-1-semen.protsenko@linaro.org>
 <a135888e-0d97-1382-c1f9-5bf097a7ffe3@gmail.com>
 <CAPLW+4=f1AcZRde8e+rWWpCm9BtFAACqdWCfMryRBcSFn4OinA@mail.gmail.com>
 <CAPLW+4kBMcO8xOyHYeOqi+npCT651990Efyuanzq8jDgnaqX5Q@mail.gmail.com>
 <CAPLW+4kP_Y4YMtsYpK_uA4B4s-a36UA7ZPZNiV_KYBuDb_qJwg@mail.gmail.com>
 <20240613153310.GM68077@bill-the-cat>
 <CAOf5uwm8ez2MxirkxYQ=VXQOnV9z2s3zeKMPMJnhBa-QRXV9eA@mail.gmail.com>
 <CAPLW+4mN1iOC7nZ6pJttgp2UdO0RdW2yv69P5kPOf_2YE+TO5A@mail.gmail.com>
 <CAOf5uwm+LvC38EUough8RcPzyah01xuibP5rxnTYSam9dfNJUA@mail.gmail.com>
 <CAPLW+4kzPmy4zgjiuay=T2y2ciRRf1ejUNM=tGjj4JCA8AdVLA@mail.gmail.com>
 <CAPLW+4n-WxKM4Kz-uZA5XvBEHNBgwucjnxb5Dk-7TdG3UPFrqA@mail.gmail.com>
 <CAPLW+4mGGqgpnqSNEDEOT_DO5S3=eB8oHToKZDiEN6__JP36gQ@mail.gmail.com>
In-Reply-To: <CAPLW+4mGGqgpnqSNEDEOT_DO5S3=eB8oHToKZDiEN6__JP36gQ@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 4 Nov 2024 13:15:00 -0600
Message-ID: <CAPLW+4=Ot83VaZTaB+E1=HCfG5ujuhJ0UtFAn2zVHZO=A+gRdw@mail.gmail.com>
Subject: Re: [PATCH] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present
To: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Michal Simek <michal.simek@amd.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Yang Xiwen <forbidden405@outlook.com>, Julien Masson <jmasson@baylibre.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
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

Hi Tom, Sean,

Can we please apply this patch? I don't really understand why it's
been consistently ignored for so long, with no explanation even. eMMC
on E850-96 still doesn't work properly, this patch is really needed.

Thanks!

On Tue, Aug 13, 2024 at 8:17=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> Hi Sean,
>
> This series has been pending for 5 months now. If there are no
> objections, can you please apply it?
>
> Thanks!
>
> On Wed, Jul 31, 2024 at 3:05=E2=80=AFPM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> >
> > On Thu, Jul 25, 2024 at 3:57=E2=80=AFPM Sam Protsenko
> > <semen.protsenko@linaro.org> wrote:
> > >
> > > [snip]
> > >
> > > >>
> > > >> If anything, that shows there is a rising need in this propagation
> > > >> feature. I'd like to encourage the maintainers to take a look at b=
oth
> > > >> implementations, and maybe at least comment on why there is hesita=
nce
> > > >> to accept this patch. It's been almost 5 months that I'm trying to
> > > >> push that through, and my MMC work (DDR mode on E850-96 board to b=
e
> > > >> precise) still very much depends on this.
> > > >
> > > > My series is still not ready and I have no problem to go with your =
while for now
> > > >
> > >
> > > Hi Sean,
> > >
> > > Can you please apply this patch, if it's ok with you?
> > >
> >
> > Gentle reminder.
> >
> > > Thanks!
> > >
> > > [snip]
