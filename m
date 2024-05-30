Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB10C25B7E
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 00:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED779882E6;
	Thu, 30 May 2024 02:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pRIQ8cY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E21888679; Thu, 30 May 2024 02:06:32 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1859487FBC
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 02:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-df771b6cf71so258464276.2
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 17:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717027589; x=1717632389; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6MEUBlWiAcBbBLzl7XHtk8f8A/Tbz1MmtMJbKpdM87k=;
 b=pRIQ8cY6O4C8Mm1B4uLmlT+UaTkcuuTyt7vR8sVoRKIeyr3PSE61bxwOQh965zzi4o
 /k8opTSiBaOlmiDj2rDgCKZy0mI7qxZirEMjjzbn8S4zc+mceZLVkOYNiuN6b0RdXfAB
 R3N/tmS+r6pquJpZmNuxkvp5u1UjzYqN+WpUaLt2zEB2cLPW/zEJDIVDcLNv6jcN+r4k
 ks8JKZX7b5mGv3rrVk69sb5cOsqY8/kSHBFMsI2GgWN3WlNR9Jj/9ZTJdPsRdrcsJppJ
 WfbFByOJEZO+r6pYgsvvnRIUwf8wCh3QgFmbkwQ5X4tX+raxoLEWrNvlPohK37Z/ItRz
 Vz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717027589; x=1717632389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6MEUBlWiAcBbBLzl7XHtk8f8A/Tbz1MmtMJbKpdM87k=;
 b=atPd/9thiNF54O7Htc8WdXE5Uxmxo8YF8RyJ+btk/5N5nTm81IP2rojFEmnBL+ByHw
 vDcM/NLI6ViN20OfFqUyJBe9+RDA1LQlM5nr9C3UL88AjLWtCMMMaTBJ5G00dcoKAQQr
 29zT2Xmgz4+0BcKiUuZQJyLspqeBpy7il0wJCsPgijHzMPaVVEa6m7J7NiSrlQGMvT1E
 Fm99bnUX/Y6Yj8alCJslSU9Bbkf4XikiZC30qaRSMotynYhvaTVst72k9sdVEVK2olky
 W11Q9yHlkGb0Bud3q+3jCah6DnP78NCbYTkrE4ohib3wkY54A4xSe0kgWeseRraZH4+G
 ejtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpDRp1MkvuOR6MrUM8rSXdP1N2zTzTaGixVzt94nCa6tBuP9JyhCVhT9R2v6GRzZC3piC+YUCm5a70keZ68+d1y6XDTg==
X-Gm-Message-State: AOJu0YzIaXLXuinTRtVO7vPlxvpr+XyxwCs+GK8eCQBwm1bHz40vfFv7
 XuFHvl+koZo7o9QICsReGB2aTEMn22hCYVmOh+JfQmLIBE9aGqc1be8d0D5a73u8e+Y8AqxBxKy
 SpRopVTYDKgL4aVx2SX/YTbjnpBDS0ZqBFV5Y7w==
X-Google-Smtp-Source: AGHT+IESZPnEjebwbzHSBG0rzd4fGYDwle11iBO9rdTbmmrx9Y5s0/RIwh4TNt9si7cnzd9fs18dOIMcsVGL86kDBpU=
X-Received: by 2002:a25:6852:0:b0:dfa:4a4e:a601 with SMTP id
 3f1490d57ef6-dfa5a7e0214mr872802276.41.1717027588697; Wed, 29 May 2024
 17:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
 <20240522233135.26835-7-semen.protsenko@linaro.org>
 <475aea46-a255-4a55-9e1f-29ee028996f5@cherry.de>
In-Reply-To: <475aea46-a255-4a55-9e1f-29ee028996f5@cherry.de>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 29 May 2024 19:06:17 -0500
Message-ID: <CAPLW+4kRnT0kHWtU+s9u2oUf6GYs+-BMyr8P3hGcqbPAst_=ww@mail.gmail.com>
Subject: Re: [PATCH 06/42] mmc: dw_mmc: Extract clock on/off code into a
 separate routine
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, 
 uboot-snps-arc@synopsys.com
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

On Thu, May 23, 2024 at 9:36=E2=80=AFAM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Sam,
>

Hi Quentin,

Thanks for reviewing this series! My answers are below (inline).

> On 5/23/24 1:30 AM, Sam Protsenko wrote:
> > Extract clock control code into a separate routine to avoid code
> > duplication in dwmci_setup_bus().
> >
> > No functional change.
> >
>
> There are some differences though.
>

With everything discussed below, I guess it still can be argued that
this patch doesn't change the functionality of the driver? Depends on
definition though. Please let me know if you don't like this bit and
I'll remove it in v2.

[snip]

> > @@ -439,35 +461,19 @@ static int dwmci_setup_bus(struct dwmci_host *hos=
t, u32 freq)
> >       else
> >               div =3D DIV_ROUND_UP(sclk, 2 * freq);
> >
> > -     dwmci_writel(host, DWMCI_CLKENA, 0);
> > +     /* Disable clock */
> >       dwmci_writel(host, DWMCI_CLKSRC, 0);
> > +     ret =3D dwmci_control_clken(host, false);
>
> Here, CLKENA and CLKSRC are swapped. The kernel still calls CLKENA
> before CLKSRC, is this really safe? (I have no documentation so cannot
> tell). E.g., we could have CLKSRC register be a way to select the clock
> parent/source, 0 could be 24MHz crystal for example, so switching to
> this new parent before disabling the clock output would likely result in
> glitches?
>

Yes, you are right. In fact, Exynos850 TRM specifically mentions this.
Here is how TRM describes the whole procedure for "CIU Update":

8<------------------------------------------------------------->8
To prevent a clock glitch, ensure that software stops the clock when
it updates the clock divider and clock source registers.

Software uses the following sequence to update the clock divider settings:
1. Disables the clock.
2. Updates the clock divider and/or the clock source registers.
3, Enables the clock.

Code Sample to Update CIU:

// Disable clock
while (rSTATUS & (1 << 9));
rCLKENA =3D 0x0;
rCMD =3D 0x80202000; // inform CIU
while (rCMD & 0x80000000);

// Update divider and source
rCLKDIV =3D clock_divider;
rCLKSRC =3D clock_source;

// Enable clock
while (rSTATUS & (1 << 9));
rCLKENA=3D 0x1;
rCMD =3D 0x80202000; // inform CIU
while (rCMD & 0x80000000);
8<------------------------------------------------------------->8

It's an overlook on my part. And although CLKSRC reset value is 0x0
and it's only being written with 0x0 in the driver, it still has to be
fixed. I'll move CLKSRC modification below CLKDIV to make it look like
TRM suggests.

Linux kernel implementation also doesn't follow the sequence
recommended in TRM as you can see, but it works fine because CLKSRC is
always written to 0 there (and it's also 0 at reset time).

> > +     if (ret)
> > +             return ret;
> >
> > +     /* Set clock to desired speed */
> >       dwmci_writel(host, DWMCI_CLKDIV, div);
>
> Same here, CLKDIV is set now after the CIU is informed, is this an
> issue? We may want to set the clock speed before we enable the clock
> again. Right now it's setting the desired speed while disabled, inform
> the CIU, enable the clock, inform the CIU. This now does, disable the
> clock, inform the CIU, set the desired speed, enable the clock, inform
> the CIU. We may need to wait for the clock to stabilize before enabling
> it? Again, just making guesses, no documentation for me here :/
>

In this case, my implementation is following TRM (as described above).
After CLKDIV modification my code informs CIU again, inside of the
dwmci_control_clken() call.

Just to be thorough, here is what TRM says about DWMCI_CMD_UPD_CLK (bit 21)=
:

8<------------------------------------------------------------->8
...Following are the register values transferred into the card clock domain=
:
* CLKDIV
* CLKSRC
* CLKENA
8<------------------------------------------------------------->8

So you are right that each time this bit is set all 3 values are being
transferred to CIU. But because that bit is set two times (before and
after updating CLKDIV/CLKSRC) -- it's ok. And also this way is
recommended in TRM, as stated above.

[snip]

Thanks!
