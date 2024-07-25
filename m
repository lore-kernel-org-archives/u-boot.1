Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644FAC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 18:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA6B28789F;
	Thu, 25 Jul 2024 20:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XN0PvDTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97F3D88286; Thu, 25 Jul 2024 20:26:44 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2057A86D4C
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 20:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7b2dbd81e3so104963766b.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1721932001; x=1722536801;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fwLzfIe1a9q06efK/DwXKinuAGqaH88BGIVNFVfmBkg=;
 b=XN0PvDTxAFAzTBzxpjloSNzVbR3e1iK34XBaqkb5ThDShGrIDviygoj4QEvP+peVeO
 xpYqB5Ffk0ly3rIGIY9w5GpLApkTa5Hqxg+vSXTrsNWYw/EcBavoUhzb71iZPBc2MbV1
 4FgpnLsSTOTiPRaG9MwQnLXVFhFo7Fk5f26+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721932001; x=1722536801;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fwLzfIe1a9q06efK/DwXKinuAGqaH88BGIVNFVfmBkg=;
 b=YacoAWNUql6c6iMcxi4eP9oW5GNGdnOhY+ZFW53ZSu92XO+Xcqmq/eE8YlMMDkC1PJ
 XK8h2OA62tCGrSYiA2BWaUWMp0Nns9o2dWzDWMkLRTsJxcWzVeh56Wgry3N1HiJ0pFYm
 gSZT3/8x34KlS0lIGVcAU9wgW+ZCx698h/nwaQkxtgE/xXht1V0wpNhARGoedq/EHOs4
 8Sds7iBBtjQL29IUpW+hDwHIEaYM5grm0AHvAANO99xqrevmJRnrBynSRNtNYTep28lv
 8FbMTeVVfkMBQNNxchag8fL6DCUMV/YXAlt7TzBaW2bP2s3oGokqeQ4Rv6mpuuUOHHIq
 dDyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtSHpT2oQ3vlvoIdrDfajeSR8/vczbttFW0RyuIBakpfonPTLlEEmiizjQ/DpRW/t4haqiDZ4fJpx4Vvkvkgjrn88W1Q==
X-Gm-Message-State: AOJu0YwGWx1Ecr7HWhH386fzzVeKSNULroF72zzUse6rlxFDI8F8iN2j
 JYovjemG5nOzFNV+c5C03ABCn2GKZ4g1auidCqm0DvAKtaLsuzqTnxdSaZiGAZjq+H3fI5MFOFN
 e1bl3kwP9vamzPqRwoJQQzFGxbh3iTz1e+y/5lQ==
X-Google-Smtp-Source: AGHT+IHfjau2U1n+cyHJ6ojKVHgjheIObmUdM5LyAAXhDBHL6x6BHjxr2a1zH2GmuIeomw1Ky2E7wXWTM34pQXE7TwM=
X-Received: by 2002:a17:907:988:b0:a7a:bae8:f29d with SMTP id
 a640c23a62f3a-a7ac4d9ea62mr198264466b.6.1721932001418; Thu, 25 Jul 2024
 11:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240308000432.32369-1-semen.protsenko@linaro.org>
 <a135888e-0d97-1382-c1f9-5bf097a7ffe3@gmail.com>
 <CAPLW+4=f1AcZRde8e+rWWpCm9BtFAACqdWCfMryRBcSFn4OinA@mail.gmail.com>
 <CAPLW+4kBMcO8xOyHYeOqi+npCT651990Efyuanzq8jDgnaqX5Q@mail.gmail.com>
 <CAPLW+4kP_Y4YMtsYpK_uA4B4s-a36UA7ZPZNiV_KYBuDb_qJwg@mail.gmail.com>
 <20240613153310.GM68077@bill-the-cat>
 <CAOf5uwm8ez2MxirkxYQ=VXQOnV9z2s3zeKMPMJnhBa-QRXV9eA@mail.gmail.com>
 <CAPLW+4mN1iOC7nZ6pJttgp2UdO0RdW2yv69P5kPOf_2YE+TO5A@mail.gmail.com>
In-Reply-To: <CAPLW+4mN1iOC7nZ6pJttgp2UdO0RdW2yv69P5kPOf_2YE+TO5A@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 25 Jul 2024 20:26:29 +0200
Message-ID: <CAOf5uwm+LvC38EUough8RcPzyah01xuibP5rxnTYSam9dfNJUA@mail.gmail.com>
Subject: Re: [PATCH] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>,
 Yang Xiwen <forbidden405@outlook.com>, 
 Julien Masson <jmasson@baylibre.com>, U-Boot-Denx <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Sam

Il mar 23 lug 2024, 22:53 Sam Protsenko <semen.protsenko@linaro.org> ha
scritto:

> On Wed, Jul 3, 2024 at 10:00=E2=80=AFAM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi all
> >
> > Working on the clock now. I have done a different implementation
> >
> > clk-mux, clk-gate I have added a clk_generic_set_rate that is a stub
> > that propagate to the parent, I think that should work the same but
> > wihout this while and even on preparation on more
> > changes I need. Can be work on your case too?
> >
>
> Hi Michael,
>
> I've provided some thoughts on your gate/mux implementation here: [1].
> As you've submitted your (different) implementation of the same
> feature, but 4 months later, I guess my patch doesn't cover your
> cases, or perhaps it has some design flaws? Please let me know.
>
> If anything, that shows there is a rising need in this propagation
> feature. I'd like to encourage the maintainers to take a look at both
> implementations, and maybe at least comment on why there is hesitance
> to accept this patch. It's been almost 5 months that I'm trying to
> push that through, and my MMC work (DDR mode on E850-96 board to be
> precise) still very much depends on this.
>


My series is still not ready and I have no problem to go with your while
for now

Michael

>
>
>
> Thanks!
>
> [1] https://lists.denx.de/pipermail/u-boot/2024-July/559753.html
>
>
> > Michael
> >
> > On Thu, Jun 13, 2024 at 5:33=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Mon, Jun 10, 2024 at 02:43:17PM -0500, Sam Protsenko wrote:
> > > > On Tue, May 14, 2024 at 3:26=E2=80=AFPM Sam Protsenko
> > > > <semen.protsenko@linaro.org> wrote:
> > > > >
> > > > > On Wed, May 1, 2024 at 4:12=E2=80=AFPM Sam Protsenko <
> semen.protsenko@linaro.org> wrote:
> > > > > >
> > > > > > On Wed, Apr 10, 2024 at 9:53=E2=80=AFPM Sean Anderson <seanga2@=
gmail.com>
> wrote:
> > > > > > >
> > > > > > > On 3/7/24 19:04, Sam Protsenko wrote:
> > > > > > > > Sometimes clocks provided to a consumer might not have
> .set_rate
> > > > > > > > operation (like gate or mux clocks), but have
> CLK_SET_PARENT_RATE flag
> > > > > > > > set. In that case it's usually possible to find a parent up
> the tree
> > > > > > > > which is capable of setting the rate (div, pll, etc).
> Implement a simple
> > > > > > > > lookup procedure for such cases, to traverse the clock tree
> until
> > > > > > > > .set_rate capable parent is found, and use that parent to
> actually
> > > > > > > > change the rate. The search will stop once the first
> .set_rate capable
> > > > > > > > clock is found, which is usually enough to handle most case=
s.
> > > > > > > >
> > > > > > > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > > > > > > ---
> > > > > >
> > > > > > [snip]
> > > > > >
> > > > > > >
> > > > > > > Can you give an example of where this is needed?
> > > > > > >
> > > > > >
> > > > > > Sure. In my case it's needed for eMMC enablement on E850-96
> board.
> > > > > > eMMC node in the device tree [1] is a gate clock
> > > > > > (CLK_GOUT_MMC_EMBD_SDCLKIN), so the MMC driver won't be able to
> change
> > > > > > its rate. But that clock actually has CLK_SET_RATE_PARENT flag
> set in
> > > > > > the clock driver [2]. So the right thing to do in this case (an=
d
> > > > > > that's basically how it's done in Linux kernel too) is to
> traverse the
> > > > > > clock tree upwards, and try to find the parent capable to do
> .set_rate
> > > > > > (which is usually a divider clock), and use it to change the
> clock
> > > > > > rate. I'm working on exynos_dw_mmc driver [3] right now, making
> it use
> > > > > > CCF clocks, but I can't do that before this patch is applied.
> > > > > >
> > > > > > Grepping the U-Boot tree I can see the CLK_SET_RATE_PARENT flag
> is
> > > > > > also used in various IMX clock drivers and STM32MP13 clock
> driver. I
> > > > > > guess without this change those flags will be basically ignored=
.
> > > > > >
> > > > > > Thanks!
> > > > > >
> > > > >
> > > > > Hi Sean,
> > > > >
> > > > > Just wanted to check if you think my explanation above is ok and
> the
> > > > > patch can be applied? I'm finishing my new patch series for
> enabling
> > > > > MMC on E850-96, but this patch has to be applied first.
> > > > >
> > > > > Thanks!
> > > > >
> > > >
> > > > Hi Tom,
> > > >
> > > > Would it be reasonable to ask you to take care of this patch? It's
> > > > been ignored for 3 months now, but it's needed for eMMC enablement =
on
> > > > E850-96 board.
> > >
> > > Any comments at this point Sean?
> > >
> > > --
> > > Tom
> >
> >
> >
> > --
> > Michael Nazzareno Trimarchi
> > Co-Founder & Chief Executive Officer
> > M. +39 347 913 2170
> > michael@amarulasolutions.com
> > __________________________________
> >
> > Amarula Solutions BV
> > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > T. +31 (0)85 111 9172
> > info@amarulasolutions.com
> > www.amarulasolutions.com
>
