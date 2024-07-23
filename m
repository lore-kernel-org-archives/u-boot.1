Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5327CC3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 20:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D64787BF4;
	Tue, 23 Jul 2024 22:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uUqklVc7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B18F841BC; Tue, 23 Jul 2024 22:53:48 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A414687BF4
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 22:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-66493332ebfso53211467b3.3
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 13:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721768013; x=1722372813; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DewhSkU7LjnmRxrL5DyulxRJp1zistuFm4SYqYV4pPQ=;
 b=uUqklVc7OGvf5NMEtRPGqPp3FB2iuouDu/uvSls5JKFc71GUE0R3N/bJwOJFFMxKVN
 DLj2O8gb2WW2SoCeSyklNqMb8ZlkIzWMFenZ8N0yU4PyibNeczRYUgoUM3KjQdym3kSw
 IeaHtgJsDpgDp643UIS6k3p9xPaTBGpnEdpTvc04UtbNLUtU04RSRxdD46G4fPbr6VmY
 Khxws+sRshQ2xHWyTcNAYVuWiss8088GR1ZV/dVQqXtoeMP0Lvg7TdeloTeHrNuDm3Gr
 dUU9QwJv78VDGAGZUdk61hCIJjcdztVMOQphFjKfXrN1CLTEU9a1br3/sGlTVqyMgFsc
 o8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721768013; x=1722372813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DewhSkU7LjnmRxrL5DyulxRJp1zistuFm4SYqYV4pPQ=;
 b=m8vUBYGu3wxlGhjHQvkFphV7mlyOglSI6IAZePkGkc8oQR2AJLean5JppVcxoHo2cD
 h2KRqpeovj+cD6nk2PwN5IgbqmSBSXprc9Z2X+RZmCWP3M3A0ufydxv54LZ0vhJBacSE
 kBrG2CPHpHj/JhScJlan76+6v8n5o8EAj/ZhshGb7QNP0hxbC67GFy6tO9OBhMv97d6S
 9qGeDMXpUuAuLtxqgsoEI+Glnjrr/kX1JqeoLs6XObzsbC7iTFrQKx4E8oFxoO53RGQx
 dyF7ZHJ6ye2VvFz9MjUUNjCgBhEEvqsphlg+rynUkD5zIyZeCCWbE4nVBmyZ1x9sJmmd
 i/Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF9AYghc9VJiHIqTt5EwsyS7ka5i7uar/cGR+0xvz3aV7LDK4zHi5Ytoz2vZPa2fkU/p+VJmLS1C5sSdW7EPOjX947vg==
X-Gm-Message-State: AOJu0YyexwjbBKGMGwgjUaNjlBWMjyTmD3nEPAPjm83GuWKXMnSRnVB0
 Mpb4DcGq4fTfEPBAQLjig1gly65KPS7vjCzsS5bIuV0cri2Keq2dj1lBYzWLUVZeXjgcBykoCmO
 LLebVEnmMk8wAIne4CTFsgY1AtlDku6bP1tb4Fg==
X-Google-Smtp-Source: AGHT+IFZK4BhxDZMi9xHXf9Ny6QKYxTlCS/0oT13ZivyAdnsVhjAqsqSz7dX5RnWdXgbAiylaKd9TuBPa4N/j2njoFw=
X-Received: by 2002:a05:690c:dc2:b0:61b:e645:3e94 with SMTP id
 00721157ae682-66a684c2bb8mr187574557b3.5.1721768013316; Tue, 23 Jul 2024
 13:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240308000432.32369-1-semen.protsenko@linaro.org>
 <a135888e-0d97-1382-c1f9-5bf097a7ffe3@gmail.com>
 <CAPLW+4=f1AcZRde8e+rWWpCm9BtFAACqdWCfMryRBcSFn4OinA@mail.gmail.com>
 <CAPLW+4kBMcO8xOyHYeOqi+npCT651990Efyuanzq8jDgnaqX5Q@mail.gmail.com>
 <CAPLW+4kP_Y4YMtsYpK_uA4B4s-a36UA7ZPZNiV_KYBuDb_qJwg@mail.gmail.com>
 <20240613153310.GM68077@bill-the-cat>
 <CAOf5uwm8ez2MxirkxYQ=VXQOnV9z2s3zeKMPMJnhBa-QRXV9eA@mail.gmail.com>
In-Reply-To: <CAOf5uwm8ez2MxirkxYQ=VXQOnV9z2s3zeKMPMJnhBa-QRXV9eA@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jul 2024 15:53:21 -0500
Message-ID: <CAPLW+4mN1iOC7nZ6pJttgp2UdO0RdW2yv69P5kPOf_2YE+TO5A@mail.gmail.com>
Subject: Re: [PATCH] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>,
 Yang Xiwen <forbidden405@outlook.com>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
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

On Wed, Jul 3, 2024 at 10:00=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi all
>
> Working on the clock now. I have done a different implementation
>
> clk-mux, clk-gate I have added a clk_generic_set_rate that is a stub
> that propagate to the parent, I think that should work the same but
> wihout this while and even on preparation on more
> changes I need. Can be work on your case too?
>

Hi Michael,

I've provided some thoughts on your gate/mux implementation here: [1].
As you've submitted your (different) implementation of the same
feature, but 4 months later, I guess my patch doesn't cover your
cases, or perhaps it has some design flaws? Please let me know.

If anything, that shows there is a rising need in this propagation
feature. I'd like to encourage the maintainers to take a look at both
implementations, and maybe at least comment on why there is hesitance
to accept this patch. It's been almost 5 months that I'm trying to
push that through, and my MMC work (DDR mode on E850-96 board to be
precise) still very much depends on this.

Thanks!

[1] https://lists.denx.de/pipermail/u-boot/2024-July/559753.html


> Michael
>
> On Thu, Jun 13, 2024 at 5:33=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Mon, Jun 10, 2024 at 02:43:17PM -0500, Sam Protsenko wrote:
> > > On Tue, May 14, 2024 at 3:26=E2=80=AFPM Sam Protsenko
> > > <semen.protsenko@linaro.org> wrote:
> > > >
> > > > On Wed, May 1, 2024 at 4:12=E2=80=AFPM Sam Protsenko <semen.protsen=
ko@linaro.org> wrote:
> > > > >
> > > > > On Wed, Apr 10, 2024 at 9:53=E2=80=AFPM Sean Anderson <seanga2@gm=
ail.com> wrote:
> > > > > >
> > > > > > On 3/7/24 19:04, Sam Protsenko wrote:
> > > > > > > Sometimes clocks provided to a consumer might not have .set_r=
ate
> > > > > > > operation (like gate or mux clocks), but have CLK_SET_PARENT_=
RATE flag
> > > > > > > set. In that case it's usually possible to find a parent up t=
he tree
> > > > > > > which is capable of setting the rate (div, pll, etc). Impleme=
nt a simple
> > > > > > > lookup procedure for such cases, to traverse the clock tree u=
ntil
> > > > > > > .set_rate capable parent is found, and use that parent to act=
ually
> > > > > > > change the rate. The search will stop once the first .set_rat=
e capable
> > > > > > > clock is found, which is usually enough to handle most cases.
> > > > > > >
> > > > > > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > > > > > ---
> > > > >
> > > > > [snip]
> > > > >
> > > > > >
> > > > > > Can you give an example of where this is needed?
> > > > > >
> > > > >
> > > > > Sure. In my case it's needed for eMMC enablement on E850-96 board=
.
> > > > > eMMC node in the device tree [1] is a gate clock
> > > > > (CLK_GOUT_MMC_EMBD_SDCLKIN), so the MMC driver won't be able to c=
hange
> > > > > its rate. But that clock actually has CLK_SET_RATE_PARENT flag se=
t in
> > > > > the clock driver [2]. So the right thing to do in this case (and
> > > > > that's basically how it's done in Linux kernel too) is to travers=
e the
> > > > > clock tree upwards, and try to find the parent capable to do .set=
_rate
> > > > > (which is usually a divider clock), and use it to change the cloc=
k
> > > > > rate. I'm working on exynos_dw_mmc driver [3] right now, making i=
t use
> > > > > CCF clocks, but I can't do that before this patch is applied.
> > > > >
> > > > > Grepping the U-Boot tree I can see the CLK_SET_RATE_PARENT flag i=
s
> > > > > also used in various IMX clock drivers and STM32MP13 clock driver=
. I
> > > > > guess without this change those flags will be basically ignored.
> > > > >
> > > > > Thanks!
> > > > >
> > > >
> > > > Hi Sean,
> > > >
> > > > Just wanted to check if you think my explanation above is ok and th=
e
> > > > patch can be applied? I'm finishing my new patch series for enablin=
g
> > > > MMC on E850-96, but this patch has to be applied first.
> > > >
> > > > Thanks!
> > > >
> > >
> > > Hi Tom,
> > >
> > > Would it be reasonable to ask you to take care of this patch? It's
> > > been ignored for 3 months now, but it's needed for eMMC enablement on
> > > E850-96 board.
> >
> > Any comments at this point Sean?
> >
> > --
> > Tom
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com
