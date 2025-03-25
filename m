Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98CEC35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 08:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1499D80EEF;
	Tue, 25 Mar 2025 09:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CA9380F70; Tue, 25 Mar 2025 09:09:13 +0100 (CET)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35F91808B6
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 09:09:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=geert.uytterhoeven@gmail.com
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-5242f137a1eso2323669e0c.1
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 01:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742890148; x=1743494948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mR+YrPvScOLsAuaE2eYn3BqnjN4++uRK64oEkjr9ROc=;
 b=oiPnEfywpYsnXd/z9syPMdJvn7Civw+4dWC7IOXFS8kEhBYwnZPy0XAJFMHn1WEg8x
 5qzPN6+Jvoy7uxqpQRcO6Z6QY7PW7hTI+Smcq7VO/14lpILsuiMroup8AO7CfID8PCae
 ZWW0bul3Z3odmCKUE86mcS9MaGwFUXtR+aytkiroT8/PjEos1+19V8BWG5BQIrA2xl9O
 WSAGb2RKzXZyTXpwmRalixYSPVfX5KBo6pX2R758HvUYq+m0I53VaxlnQ9RjtiYWzcZP
 ZZ8Wnu4Xb/Z2ZJKi9TkY638LsLoNgEaJZWQT1O4TZcRfuLY2IlSM/W92Lp2HPVRCNhfD
 VbJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/KaRSFGuAINAxv3RVCu6DpidKyjs66oSmqL4YRKv0mjMpgSv8Kq4hlFwSWz7gCHvtOQJeJ2Q=@lists.denx.de
X-Gm-Message-State: AOJu0YznOkOuTsGPkgLVnXnTNT3msGOom8RC1ibEIzbpRpQW8M4dJWIy
 52fXENBb+GOnPUplgxiju5H/3J+HuLacd1efxaCmdeCUHqAtLHHZKoGHVZ63
X-Gm-Gg: ASbGnctid0YCeY4ClcpNOzoKBVMTCl827KZK/E/TiX5aPdk0EVA8+wmx2TQGcBJXprM
 R/SYMfXm/YAsf0gqqwqpXNRTkCdn2H6NyMSenZGNjQw8LEpyNv2lhAWZufwP/yncljQTcIdtWPm
 MdJzh2/Ha+bDeGh8V4VBJwSH7pUs9KFBuyVi85dLMcYrpTh/+BOTct+AamCDuBP64/hXmQhHXGd
 IeLH/PP3mbYbMeQJv/O1Zcbm/tmxkhpsZGiaJbuClKUf7Rw/wKJLmsw42vt7bpUsON+Ld9yV9fg
 0VdKtwO/bJmcO7d/aJo4o+vzHeZOLTu24/2Pn7WjetSgrGqcj1QsXJZMxhMspO/fOLbmTGryYkV
 8FWdIdDo=
X-Google-Smtp-Source: AGHT+IE5ohKp6VOaknkQnUJdqWnWaRgFw/FmlR94Fz6vlleFPyS371SnC946UEBjijoP3Ckh5ozbxg==
X-Received: by 2002:a05:6122:2398:b0:520:60c2:3fd with SMTP id
 71dfb90a1353d-525a833acc5mr11165102e0c.3.1742890148326; 
 Tue, 25 Mar 2025 01:09:08 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com.
 [209.85.222.44]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-525a766fc5csm1781878e0c.45.2025.03.25.01.09.07
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 01:09:07 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id
 a1e0cc1a2514c-86fbc8717fcso987753241.2
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 01:09:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW6S+LUR5joud2NBsoEZmu+Spoo5YbcoP+LpowGa9y0eBBUlbdHDGBKjkFC6t5YEfEyh42oTeo=@lists.denx.de
X-Received: by 2002:a05:6102:26d0:b0:4bb:ecb9:b34d with SMTP id
 ada2fe7eead31-4c50d5c549fmr9825243137.18.1742890147199; Tue, 25 Mar 2025
 01:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250319120401.8297-1-paul.barker.ct@bp.renesas.com>
 <20250319120401.8297-4-paul.barker.ct@bp.renesas.com>
 <e075602c-3a08-424b-adbc-88dcafb6c1d6@mailbox.org>
 <b812bb48-8534-4164-a5ed-19764c38656c@bp.renesas.com>
 <64d123de-b1b3-4dcf-ba98-91ef5ecb6067@mailbox.org>
In-Reply-To: <64d123de-b1b3-4dcf-ba98-91ef5ecb6067@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Mar 2025 09:08:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUF7=Dv_dJzV84Xoom=5M5uxmOSryekkxWmotHuf8_3pg@mail.gmail.com>
X-Gm-Features: AQ5f1Jqy_QoYenhGigvQ9iiNoR_d7rX4o1jJtDi_fYFZzJgbKe02HAbDSaqqNlE
Message-ID: <CAMuHMdUF7=Dv_dJzV84Xoom=5M5uxmOSryekkxWmotHuf8_3pg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] net: ravb: Add RZ/G2L Support
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
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

CC Niklas

On Tue, 25 Mar 2025 at 00:05, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 3/24/25 11:12 AM, Paul Barker wrote:
> > On 24/03/2025 01:11, Marek Vasut wrote:
> >> On 3/19/25 1:03 PM, Paul Barker wrote:
> >>
> >> [...]
> >>
> >>> +++ b/drivers/net/Kconfig
> >>> @@ -864,7 +864,7 @@ config RENESAS_RAVB
> >>>     select PHY_ETHERNET_ID
> >>>     help
> >>>       This driver implements support for the Ethernet AVB block in
> >>> -     Renesas M3 and H3 SoCs.
> >>> +     several Renesas R-Car and RZ SoCs.
> >>
> >> RZ/G instead of RZ , right ?
> >
> > This will also be used for RZ/V2L.
>
> Ahh, thank you for clarifying.
>
> [...]
>
> >>> +static void ravb_mac_init_rzg2l(struct udevice *dev)
> >>> +{
> >>> +   struct ravb_priv *eth = dev_get_priv(dev);
> >>> +
> >>> +   setbits_32(eth->iobase + RAVB_REG_ECMR,
> >>> +              ECMR_PRM | ECMR_RXF | ECMR_TXF | ECMR_RCPT |
> >>> +              ECMR_TE | ECMR_RE | ECMR_RZPF |
> >>> +              (eth->phydev->duplex ? ECMR_DM : 0));
> >>
> >> Can you configure the ECMR extras in ravb_config() just before
> >> writel(mask, eth->iobase + RAVB_REG_ECMR); based on some private data
> >> flag, like '.is_rzg2l' , instead ?
> >
> > ravb_config() has been split into ravb_config_rcar() &
> > ravb_config_rzg2l() by this patch series. So there is no longer a common
> > write to RAVB_REG_ECMR.
> >
> >>
> >>> +}
> >>> +
> >>>    /* AVB-DMAC init function */
> >>>    static int ravb_dmac_init(struct udevice *dev)
> >>>    {
> >>> @@ -459,6 +481,14 @@ static void ravb_dmac_init_rcar(struct udevice *dev)
> >>>     writel(mode, eth->iobase + RAVB_REG_APSR);
> >>>    }
> >>>
> >>> +static void ravb_dmac_init_rzg2l(struct udevice *dev)
> >>> +{
> >>> +   struct ravb_priv *eth = dev_get_priv(dev);
> >>> +
> >>> +   /* Set Max Frame Length (RTC) */
> >>> +   writel(0x7ffc0000 | RFLR_RFL_MIN, eth->iobase + RAVB_REG_RTC);
> >>
> >> I assume this register is actually RZ/G2L specific ?
> >
> > This register also exists on RZ/G2{H,M,N,E}, but in the Linux kernel
> > ravb driver it is only modified for RZ/G2L.
>
> Is this deliberate or is that a bug ?
>
> +CC Geert.
>
> >>> +}
> >>> +
> >>>    static int ravb_config(struct udevice *dev)
> >>>    {
> >>>     struct ravb_device_ops *device_ops =
> >>> @@ -501,6 +531,22 @@ static void ravb_config_rcar(struct udevice *dev)
> >>>     writel(mask, eth->iobase + RAVB_REG_ECMR);
> >>>    }
> >>>
> >>> +static void ravb_config_rzg2l(struct udevice *dev)
> >>> +{
> >>> +   struct ravb_priv *eth = dev_get_priv(dev);
> >>> +   struct phy_device *phy = eth->phydev;
> >>> +
> >>> +   writel(CSR0_TPE | CSR0_RPE, eth->iobase + RAVB_REG_CSR0);
> >>> +
> >>> +   /* Set the transfer speed */
> >>> +   if (phy->speed == 10)
> >>> +           writel(GECMR_SPEED_10M, eth->iobase + RAVB_REG_GECMR);
> >>
> >> Since this patch adds .has_reset flag, wouldn't it be possible to add
> >> another flag called something like .has_10 flag and simply do:
> >>
> >> if (eth->has_10 && phy->speed == 10)
> >>     writel(GECMR_SPEED_10M, eth->iobase + RAVB_REG_GECMR);
> >>
> >> ?
> >
> > The layout of RAVB_REG_GECMR differs between RZ/G2L and RZ/G2{H,M,N,E},
> > so we can't use the same constants for all platforms. We also need the
> > additional write to RAVB_REG_CSR0 for RZ/G2L so it's worth having the
> > ravb_config_rzg2l() function instead of a couple of flags.
> Ah, thank you for clarifying. This register layout bit is what I was
> missing. The CSR0 part could have been isolated in some if (..), but the
> register layout is a bit more unpleasant to deal with.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
