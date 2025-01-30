Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C581C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 10:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E55282012;
	Thu, 30 Jan 2025 11:29:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PNDCZANg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 884138206E; Thu, 30 Jan 2025 11:29:43 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5352B81F69
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 11:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e39779a268bso867032276.1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 02:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738232980; x=1738837780; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W4A0pGaz3gfsZ+lSY7AQhWXlQPFNJzhuV76egPB+34I=;
 b=PNDCZANgqWa89Buz9smhEOYwVW44R7+reOgzRgzDe1Vu1by0GBmvLXB5kKC0l4B7Ws
 Ff6o25KQpR1Lep5fzwN/Ly0lc7vhkG5+wilIx8gu3BfS1flLK6jEYBA+opVm6m4KNb+m
 Ztz+Qu2Gq98LQehMRUNf68zvgfKgKsPgppgzr+15oGgKimopdWv5pfbdFJE5XXNkGGE7
 w6p4Hzt4PH15y4zGh23GA9QleDUK0V71akle01VIrt2GmqAeD8rSGxGGGL5qNMOc5Jg4
 V3EmZsr0IQHDyJsi34M0ZmMqxDBNmQQ7IBFtvwBBNMuFUoBCPF1Kc8wziMrH1GPFj7ha
 GS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738232980; x=1738837780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W4A0pGaz3gfsZ+lSY7AQhWXlQPFNJzhuV76egPB+34I=;
 b=HyVa0h2GbPn9u8vfyluWKQoFDmoVUbs7Rj1EHbPChae+56J1oMDgUE5ZNymbzOuxux
 uZ3GaV3PmdJ3HFyWZw3Bf3yQR9bXZrjh3pvPClrymdtOTEa0okmZukv7SvRpO8HD2qT7
 50Ea/JQ7Mzyw3Ypay0urKMXiRUsuKjJkru4fPV4Nr0bZVIxxQ0pCCN+yqx8r7gwR5+Ry
 HChp7AZ+JDEwFmYB+2ZApjQQJ4yMIzmJpUyHA+zWMRsUeR1SxQqDCY+iODJVuV3H1gwy
 WlA2eYMUZDmzKwz/N54ug5sirHsDRFFfmcrIjQvzHffwr/u1r5O9oS+KHUREjZFA0nWD
 Pxxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO4zdjlbVbsEtsuMiThnOV8Bq+ikfSlV0+jomQBaOkbemP7ds0PIEPsJnxjsIBuEGVMm5lgtE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1dH3WXUPFtAv5N8+MeUYbmHB15GcBMzbdCO2d3yh3Vx8ahiwk
 p3s9DAImoYWGLsP33W0QFgrnTs5oLXuz986dL0RQOMWfbuEvCNWUAhxjGsTrh5r/G4ASS+ymgMx
 mHgWEA1j6q3zCq67rNKeIwsJoWEwshPSl9IInxA==
X-Gm-Gg: ASbGncvWZdBU26Y3nKh6qYB66e0Vkeut2Xdaromskxx3Arj7kk8NTUl9ip2KaLmBC9N
 ZMDwIzIHRPp793DN7+zPxkMb6987ujTMhzmfTJSvLhTsvj3jlb2MtMdWENjdvNKvO1KW0g0og
X-Google-Smtp-Source: AGHT+IE6Rp78ukxqXhOcZCuCX2gMBmGZvYeOt8YtxbDsT53McBrJI56KPSokn7wE68NdVR37eFBEY837v7QaJVOXdkw=
X-Received: by 2002:a05:6902:dc9:b0:e58:a25c:2785 with SMTP id
 3f1490d57ef6-e5ac89546ecmr2035634276.22.1738232980209; Thu, 30 Jan 2025
 02:29:40 -0800 (PST)
MIME-Version: 1.0
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-5-ilias.apalodimas@linaro.org>
 <22898270-b5b6-4bcb-9c4a-f3d62dbf5c86@gmx.de>
In-Reply-To: <22898270-b5b6-4bcb-9c4a-f3d62dbf5c86@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 Jan 2025 12:29:04 +0200
X-Gm-Features: AWEUYZlbklP1RET8P7xSi7IMPONK70N9Yty1F4Ubd1lpCJ9H5Xv19ogvx0HY-SM
Message-ID: <CAC_iWjLc1KEeBze3CL9E7pd=--6KifGCprZ6r+uDGEoSTTPmMw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] arm64: Change mapping for data/rodata/text
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, 
 maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com
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

Hi Heinrich,

On Thu, 30 Jan 2025 at 12:24, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 1/30/25 07:20, Ilias Apalodimas wrote:
> > Now that we have everything in place switch the page permissions for
> > .rodata, .text and .data just after we relocate everything in top of the
> > RAM.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   common/board_r.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/common/board_r.c b/common/board_r.c
> > index 179259b00de8..38944f600fd6 100644
> > --- a/common/board_r.c
> > +++ b/common/board_r.c
> > @@ -170,6 +170,13 @@ static int initr_reloc_global_data(void)
> >       efi_save_gd();
> >
> >       efi_runtime_relocate(gd->relocaddr, NULL);
> > +
> > +#if (IS_ENABLED(CONFIG_ARM64))
>
> '#if' should be replaced by 'if (CONFIG_IS_ENABLED())'.
>
> Shall we make mmu_set_attrs() a weak function which each architecture
> can override?

In order to do the IS_ENABLED as you asked, we need to define a weak
function, otherwise the linker will complain.
I can add a generic mmu_set_attrs() in the next version. The right way
to do this in the future is to have a proper MMU API.

>
> > +     mmu_set_attrs((u64)(__start_rodata), (u64)(__end_rodata - __start_rodata), 1);
> > +     mmu_set_attrs((u64)(__start_data), (u64)(__end_data - __start_data), 3);
> > +     mmu_set_attrs((u64)(__text_start), (u64)(__text_end - __text_start), 2);
>
> Please, replace 1, 2, 3 by constants both here and in mmu_set_attrs, e.g.
>
> 1 -> MMU_ATTR_RO
> 2 -> MMU_ATTR_RX
> 3 -> MMU_ATTR_RW

Yea I am explaining the same thing in the cover letter

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> > +#endif
> > +
> >   #endif
> >
> >       return 0;
>
