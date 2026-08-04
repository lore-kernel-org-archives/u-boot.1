Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F8DC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 18:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E670880CBF;
	Tue,  4 Aug 2026 18:13:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zi6VJ0YPoy6Y; Tue,  4 Aug 2026 18:13:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 341D180CB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785867207;
	bh=WrWUZWDmSk4C5DGJdi6z3LGoQ28ezDAI4wrpKnZLKgk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h8i1YlM1+BUSO3YkqHv+/UXwzOFevHEgkdNSd4/Nml6qxgWwXgYa7JwmBkL+6PnNT
	 qGGCpxAeO+t0osf4yqfTfimNnbrZAFF7j8i3+G8hopsVTBRRCNsr4OQITu6ZbEEP+y
	 1iyQa1SfV1lS8Y5B4kvoriLoQxMmlC+ogIgPZZgJYHwNm7h2KTY0k0OpUwpULAbzdg
	 dyHXRw1i3Oo7OVyVxEvNBetqlun2Mcyu36S70AKhCmcvkW1h5inpNtJp9td+l26aUx
	 LVMm4sWTITgzkFRjCV60Z9E2V9ydl9r97A9/HrJIdcIYSOO2rmUrEdMeGjWdqNJDH1
	 W0miTV85QlX8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 341D180CB9;
	Tue,  4 Aug 2026 18:13:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D0C8D23F
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C2F8640135
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:27:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f6qQbcfjJuR0 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 14:27:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 13C1D400DA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13C1D400DA
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13C1D400DA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:27:57 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso45574305ad.2
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 07:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785853677; cv=none;
 d=google.com; s=arc-20260327;
 b=PASyBC11OMoVtgW+GYGSQgjUygf/wzHg2s98VpDF9wBzu7aP4PPE/9VPDCCgJpyK06
 neLaqL4G9/g7b8FGntUAE/I57WybzaCe7kcOUmdKiTA8VOvZH7f8JIWFl8AH107/MnW0
 hksE3x0p3rPNemZnGljn6rKn4SVx3vvK/G710tUNkQdMQMbVIqeeLvcMDbiWej5j3Ivf
 1Ln5AFMGZHuJuQPJKq0pASccgNogwyHku9FnokGbZWTIDvStGVcwb3417GtaOZmc1md6
 oK+AUbbuo8w7yTLwXYr0bB8pK45+/4JnyfrSAt0RKx+AJ85SlsQxGSSwX82vzgOjFfsW
 xVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WrWUZWDmSk4C5DGJdi6z3LGoQ28ezDAI4wrpKnZLKgk=;
 fh=mVR9Y/rQZk34FU/ncVJcP5o4w0wahIppgQrEM7okHPo=;
 b=APUO8uivRKUuUe++pGCcceLW48Qf6Wb5Mry2uGhryildgwRFVkgRtW+YjZBtcQhzlv
 aammoDQX9N+aQ4xZPYXwuzRElJWitOizRyhKj6oQtUTeDvH6x7k6Xx2a11KQayIN0hk9
 AEKp2mr1TgJQIz0TyKXXUH2aFU61lXC5vGKsvGtT+k+A20sMMKU2JS+2zaOqgvGGVSG/
 dmN8OgVAEXOi18SyON4tewxwIaaQrSW+SZsyqJAsQINVlOw4l+UOGsAwyHNZEilcoO9X
 qlpE/kYYPGvbSt03Q7rJKdKuk6S/0U0CAVebU3eVd+TNHqHYfNMw6kn5Z2xqHxVFJn0i
 y6KA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785853677; x=1786458477;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WrWUZWDmSk4C5DGJdi6z3LGoQ28ezDAI4wrpKnZLKgk=;
 b=fkajawq/97j4dm/1JlafYlK9kHwzZoII/ulpSiVbDnPZfYhRmBZb9Uch0BNvghMCol
 eJCeaV4WflN85dxDee0TCRrqjEXPrqWR7Y3/aQybuK6Dof2jgI36EPEyRncfPD59Urfc
 zBCUAx22e814vbG2/d+evtrH0daF20sk3bwktO9E1aHZfj8SX5A1yXbF/T7m0SsiveeU
 90zJqZgLpo3oG16XUF3QItNRnFXPdWVTqlVXZM8iO7ZlAWw+QoT8LAEhCcIQjOlioNcm
 Kur3MEORtxlVyXh6em+OgCQpmIlGyVjAVujShvTizR45w/GNH2ISuc+L/XP1AmsSY4T5
 rYZw==
X-Gm-Message-State: AOJu0YzpD4gF4atA6/O8legBzKI6pQn/AVK7VvczmFrWTeoVqUk+EJkG
 IP1m8Ibc+j8RqUn/L80nrAsKB0p5BlQ+RcLhQB4BoDGwpUwAcp5+UAD80A0Z55Vb3PcHuXI3zG5
 cWNZE43bUeapb7GvKoR1dEIlo82Oz7WDzdLqiefmabA==
X-Gm-Gg: AR+sD129nSzYjGsIPJm5h+CC6H9n9M/aH1VMV+uQpFJgP7f/AXes6fOQhvP/i/VCFDU
 jPEDLDQTVa+sdttw0MHoep85rSnB2nn2e4LAFoS+2jtjbx+VEplxcf0p4FSHdckv0mWl/jqLnAj
 vYAifY5SHWywXOfbVrgvTus1GdGlxUleT0mb7U7jTcuH/kAlr7l8jGdOEzxcOBRSz86QaU2Daqt
 Vo3xiTr6wiNp4wlMnwlvg6B6IKSnL39nw2L7s+dxhIwCqGDEHS8sGC+N5nYOqCs4MavOPFC0yf5
 lp5qm+IRsIhPYMUhE3b85nvdr0W7CHIykBaaemXai9s+LMDPJqc/bGFd0MrCWwVJm1CplVInX8E
 Z
X-Received: by 2002:a17:903:2283:b0:2ca:b8fd:f31 with SMTP id
 d9443c01a7336-2d0521e37b5mr140358095ad.15.1785853677218; Tue, 04 Aug 2026
 07:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-8-acb97c172993@flipper.net>
 <CAFLszTg=G0Y-qNRP-smy6CGyXhm=fW7fkaiD60f4duMhBr3=bQ@mail.gmail.com>
In-Reply-To: <CAFLszTg=G0Y-qNRP-smy6CGyXhm=fW7fkaiD60f4duMhBr3=bQ@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 4 Aug 2026 18:27:46 +0400
X-Gm-Features: AUfX_mwmekoTDF3j9EWi1ZIKjOkGE6zgjIwSXgXtxOOJscJhEIMjOdMpL7GKE1E
Message-ID: <CAKTNdwHJLa47xA7GOuLL_dKW04GuqsoZZH-0Ma9C8Vre8AC6OQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] rockchip: spl: default to Falcon mode boot in
 SPL if enabled
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Aug 2026 18:13:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785853677; x=1786458477;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WrWUZWDmSk4C5DGJdi6z3LGoQ28ezDAI4wrpKnZLKgk=;
 b=EZMWmsgprj7nVIocQs7eaHUryApJ7WfwF1gb9PRaRiKkaLsuLZVncSfjuIXOWsZYll
 MMC70D21q4ATgauPRLhN2Ylnq4NVtOogSOLl05G5jrnRbGYBInRfrwmu4/mvzCTLjwEy
 Qy6dUL9gzUMvCKxnVOWtpz/ssTeeQfPcFuauxy/BluQvHbRf8NlZm4dvu3SSYiGcOy64
 2a9Rh+9kNK1HGjsdNx9vSuhZIJgIqxLTvMlgpum6x+Csgk0mdf2hfRPcqwvieSAfRaCp
 GCW/V1InobcBcOyNQSBmz3rIgaqBLxD5eluGY4NHZZyb4KpA6nD/FMls2iWgmG6SXxXi
 Wa6g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=EZMWmsgp
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, Aug 4, 2026 at 5:03=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Alexey,
>
> On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> > rockchip: spl: default to Falcon mode boot in SPL if enabled
> >
> > Common code calls into a platform specific function to determine whethe=
r
> > to attempt OS boot in Falcon mode.
> >
> > There is currently no platform logic to drive that decision on Rockchip=
,
> > so attempt Falcon mode boot whenever it is enabled in the configuration=
.
> >
> > This can be overridden by board code if needed with appropriate logic, =
such
> > as checking for a button state to skip Falcon mode boot when pressed.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >
> > arch/arm/mach-rockchip/spl.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
>
> > diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.=
c
> > @@ -153,6 +153,35 @@ void spl_board_prepare_for_boot(void)
> > +/*
> > + * This overrides the weak default in common/spl/spl.c, so it must not=
 itself
> > + * be weak: two weak definitions of the same symbol would leave the ch=
oice
> > + * between them up to archive link order.
> > + */
> > +int spl_start_uboot(void)
> > +{
> > +     return board_spl_start_uboot();
> > +}
> > +#endif
>
> You've already seen the vyasa-rk3288 problem here.

Yes, it's an odd one out, will fix up in the next iteration.

> > diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.=
c
> > @@ -153,6 +153,35 @@ void spl_board_prepare_for_boot(void)
> > +#if CONFIG_IS_ENABLED(OS_BOOT)
> > +/**
> > + * board_spl_start_uboot() - decides whether to boot the OS or U-Boot =
proper
> > + *
> > + * If Falcon mode (direct Linux boot via TF-A from SPL) is selected vi=
a config,
> > + * try booting to Linux first, with automatic fallback to U-Boot if it=
 fails to
> > + * load. Boards that want to implement conditional U-Boot/Linux select=
ion logic
> > + * override this, for instance to look at a button.
>
> Introducing a Rockchip-only board_spl_start_uboot() alongside the
> existing standard spl_start_uboot() hook is awkward - a board author
> has to know that on Rockchip the hook to override is the new one, not
> the documented one. Would it not be cleaner to leave spl_start_uboot()
> weak in the common code, drop this wrapper, and just have the
> mach-rockchip default live behind the existing weak symbol? The
> link-order concern applies equally to every other arch that provides a
> non-weak default (arm-k3, layerscape, zynqmp=E2=80=A6), and none of them =
add a
> second indirection.

It would be cleaner, but it foregoes the board-level override by
construction, which is a useful thing to support. Maybe I'll add a
Kconfig symbol which defaults y if CONFIG_ARM64 && CONFIG_SPL_OS_BOOT
&& MACH_ROCKCHIP and just let the boards disable it via defconfig when
they define a smarter version.

Best regards,
Alexey
