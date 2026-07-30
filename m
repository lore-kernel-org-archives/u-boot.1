Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B414C5516D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 18:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4CB2810E8;
	Thu, 30 Jul 2026 18:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RGK7GUakl3AY; Thu, 30 Jul 2026 18:13:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DEC33811AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785435202;
	bh=02tz6CbCt+sQQWYQ24jRUN2YeCicBxSmCvh6rXfEuwo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xBy6TH62MLRWQw5SWyXhxLB2naHjEi4gkjUbkmJH5N4DMP6pa0/wNnb+/pwuqSyqL
	 4vFE8WzTaq6G40c8LJ9W2q4W1o2jOOmrkicrejELyXb1gx23plEZjYNK4PDFKBPV2O
	 HbDHoPJtFurES3cSv9QZ2QjD4f6BXac1WTsf/I/vb6yepVYCL/2OdxdWhK4ttngHmt
	 4JXiVyHR/ePk6ab1ILwo34c7TOyFE4wvJkLTFsXzBSac56j68/wWKt3gNX5EO9E5OM
	 JV8085MQ1HO6CsO2sPe8cKLp+qnDbZRokNNIuNb8hbTQdMq22Qm/1HNyFSg/LF4UIM
	 nrRdaa0M/++3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEC33811AB;
	Thu, 30 Jul 2026 18:13:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A01C469
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 854D040CBA
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:13:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MZ3KgrJDGmO0 for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 18:13:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ozndrgt@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 693D940C96
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 693D940C96
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 693D940C96
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:13:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3DE684A0A; Thu, 30 Jul 2026 20:13:15 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E552849BC
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 20:13:13 +0200 (CEST)
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-51c16ac21acso620841cf.0
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 11:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785435192; cv=none;
 d=google.com; s=arc-20260327;
 b=N71H1dmgJhYs8SV7t+cP1DTNjgwretY44ROd30PmM8MhcPBQpSR7MOAZ1sHSO8lN3p
 wh8RmEpEpbQlkxFSSN6Y6rYE3CC208aQL/7nh9dt5Az9c346t+yhjN5wImSfAITnDY1p
 +Fcw7srdz6WSYvHzrqs5kw/+wioDvWZN2l6RH8AEavoBBcldNYhTlgmHJqZu0dih+S2B
 pdw+GBUB4igUyQxtY/TFpvUeYe/oUJJPsX1aGrmUCWguk4LT6kVcKbgeCsu0Nekas6pw
 DaMKdvk75QAgVFZyVHzIadxFNT0pyAAYh05eWpA28iAzl5EBR9bSJDgTVSm3cALUvHVp
 SdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=02tz6CbCt+sQQWYQ24jRUN2YeCicBxSmCvh6rXfEuwo=;
 fh=1Z4K3hPTDYYn+oG6G2nB4a7hyP/Sdd9knqv9PyMfwjY=;
 b=m1t3SKwFpybUMD7a/P8ruQ5AC+t2+UNl/JBjRrIUXrDuDaynw32rrRb1sXqYhh1vKF
 FTByvRBgTuvRUdaFX30LTzgBaNQRD66O8lY9aroCUxii0ZXRxU8D7PhTohcM1f+HPwfn
 LfFZZCWE1jY+3SQMFpLuqdzNqKZ+psOJje7dfqkXSVzBp1UfNRvNB81DkC4ZYDt903RX
 VT7s+p6t1ZesJ4YD4/7gz480pLWxtaoq8brnyRt45+a9vzTAPgLFb4Bo5IitbWMjI+Hq
 +iLWh2jKTLI8Kn3RefG+7M/B+G0ScpVZ/STgZilpECyqFAyMncpgGbO08mAbzD3IO6Nm
 NiRw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785435192; x=1786039992;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=02tz6CbCt+sQQWYQ24jRUN2YeCicBxSmCvh6rXfEuwo=;
 b=sMwWIztuITv3OPr2rOBJiD5bZPDADGKGcerNMHZBvWGqlAYuFPVwPm5kTpJiNh1CJB
 9jpCglPW0iSQfZBcOYBQObLhnfSXCWnYLav1VIdA6sKKT/VtykrWHPFSY/alSliKR1u0
 i7JZEKR5URbcciGO1Lk1vF8NPEu/TIh0npvWRWTr+yJnF237lE7EKpgZM4/9UOtDH/SA
 Wg1OIqpsg/0lTqV5T2OPx6iv2DmvE0iXAtNQfUMWr3SicqyTmP8ARwmkoTrw6y1LLBbT
 rDH1B25zvy68bcNyvOJ9GjVw9G8ixWXofWy+M4ELG8l5S66Vx4QzpmgWFp4cort41/bM
 gJ3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNzOpcesnLhNtCVG7OVyltCJG6YL+4COKcfVxCM1cL9T83d4Pn7oXq5EMsHf7Zy7tjkbwxkIY=@lists.denx.de
X-Gm-Message-State: AOJu0YzPUQv91kMgk7dgqhw2/vhXkqmA1jwDLJiBRJTDqoWaDS2Up2yd
 ud2ST4mQdMrQ0qTq7DWZDUTEGIHmKY1q5myO6ntw9NGQoM0Bxj0xnE4u2EhA+Hqrp8X083fYwTo
 EAfvpfFSdhb5FCiDMqYDMC4k3ID6GArA=
X-Gm-Gg: AR+sD114E/+POxBAX6nQrS+ev/USW37UHT1eBwJFrpY1QJK8uK3qn4ncyE14APtQ1WY
 YepmyFjHkJEcuGr078B2ReYG2SkVJL8Wx7cakqtYgJjYag857+B5U7AkHXa5LXJv6eoW43/2oN1
 h/dY5J/G/Jeq7ZSgt1Ev4DkAeT5rl6r3sJIlN3v3x8ICwKIcctfVtf+7IjS+kfaLzqw1qBieE0Z
 fzBnirmPFjtXhpVqrx9vgEurEI5a3SxIni0ylQye41ZwvLpBpXEHVO+PwstbKU4Yna4/DKbVHuS
 yAZXyOspYGzUYlRmh8gPrRoUaQSJ/yR/jKOmxd2XO1bLXRm5RSK0m3eezDvWWv68mwaR
X-Received: by 2002:ac8:5801:0:b0:51c:7b12:1209 with SMTP id
 d75a77b69052e-52b386e6bf6mr41178271cf.87.1785435191998; Thu, 30 Jul 2026
 11:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260730163621.83050-1-ozndrgt@gmail.com>
 <CABdDSeXFiL-aw5BRdH6QSm85L13tCzOEQrri99HOTOpromQpzw@mail.gmail.com>
In-Reply-To: <CABdDSeXFiL-aw5BRdH6QSm85L13tCzOEQrri99HOTOpromQpzw@mail.gmail.com>
From: Ozan Durgut <ozndrgt@gmail.com>
Date: Thu, 30 Jul 2026 20:10:46 +0200
X-Gm-Features: AUfX_mzAwqzGaD4WLBS3Lybwjh_pvKYjnBBSJO5M80ROIvO0GTPHyTJyAcugCcg
Message-ID: <CAB6uNiVu31Fq0muZg-3KmquNDJy3r7fUc_PNGY-YfgkN-66Ptg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: adi_wdt: get SEC fault source ID from DT
To: Greg Malysa <malysagreg@gmail.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, u-boot@lists.denx.de,
 linux@analog.com, 
 Tom Rini <trini@konsulko.com>, UtsavAgarwalADI <utsav.agarwal@analog.com>, 
 Ozan Durgut <ozan.durgut@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785435192; x=1786039992; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=02tz6CbCt+sQQWYQ24jRUN2YeCicBxSmCvh6rXfEuwo=;
 b=rzHZScLFC2xA71yhgmU/INe+ZxuG8jnxIdMozgAl+8MiRDloD2c3CJToxEf53Cang+
 oqy3NsB/sXAWTx17MnjYkveZuE5XyZSY6Ljpuv3cAWo8zjejt19hpn2oZWepssqUJFtm
 p3lrmUXC8PTUQpYggug4Z6QNkTUpvxaH0tRmfkeRQXPyDPfrIOdJh2Sk6aFndIztv5DL
 fS0Yjh5v5vHJ0uOjZE5M4u2RzO2+dr5I0mc/D8npbYgqz3242khZspn7qlNPLpozA/O4
 RsJekylLQyii1yE1uGrqwtLsea6xLMBEefJCaieIapS2fEVJyg1zFmazVrifWpuahEfF
 pxUw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rzHZScLF
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ozndrgt@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rzHZScLF"; 
 dkim-atps=neutral
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

Hi Greg,

Thanks for the review.

> We should use a vendor prefix for this property "adi,sec" so that it
> will be the same as what the kernel will require. That way we will be
> able to switch to OF_UPSTREAM without a driver change once support
> lands in the kernel.

Makes sense. I'll rename it to "adi,secid" (the prefixed form of the
current name) in v2 so it matches what the kernel binding will use.

> I think you should just read it directly into the priv struct without
> a temporary, i.e. dev_read_u32(dev, "secid", &priv->secid).

Agreed, will do that in v2.

> Also, what do you think about using dev_read_u32_default() with a
> default of 3 (appropriately documented) so that any users with
> modified or custom board device trees will not be surprised by this if
> they update to the latest?

Fair point on not surprising existing users. My only hesitation is that
the SEC ID isn't really a value with a sensible universal default. It's
a fixed per-SoC hardware constant. It's 3 on the current SC5xx parts, but
on the upcoming ADSP SoC the watchdog maps to different SEC ID, for example=
.

Defaulting to 3 keeps existing SC5xx device trees working (they all want
3 anyway), so it does address the custom-DT case you raise. The trade-off
is that a future SoC whose DT omits the property would then probe
"successfully" while programming the wrong SEC source and silently
breaking the watchdog->reset path, rather than failing at probe.

I'd lean slightly towards keeping it required so a misconfiguration is caug=
ht
early. But I don't feel strongly, if you'd prefer the default for the
custom-DT case,
I'm okay to use dev_read_u32_default() with a comment documenting that 3 is
the SC5xx value. Which would you prefer?

Thanks,
Ozan


On Thu, Jul 30, 2026 at 7:44=E2=80=AFPM Greg Malysa <malysagreg@gmail.com> =
wrote:
>
> Hi Ozan,
>
> On Thu, Jul 30, 2026 at 12:38=E2=80=AFPM Ozan Durgut <ozndrgt@gmail.com> =
wrote:
> >
> > From: UtsavAgarwalADI <utsav.agarwal@analog.com>
> >
> > The ADI watchdog drives a reset through a Security (SEC) controller
> > fault source. The source index was hardcoded to 3 in adi_wdt_start(),
> > which is only correct for the SC5xx parts that happen to use that
> > index.
> >
> > Read the index from a new "secid" device tree property so boards that
> > route the watchdog fault to a different SEC source can configure it.
> >
> > Set secid =3D <3> in the SC57x, SC58x, SC594 and SC598 device trees to
> > match the value they relied on before.
> >
> > Co-developed-by: Ozan Durgut <ozan.durgut@analog.com>
> > Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
> > Signed-off-by: UtsavAgarwalADI <utsav.agarwal@analog.com>
> > ---
> >  arch/arm/dts/sc57x.dtsi     | 1 +
> >  arch/arm/dts/sc58x.dtsi     | 1 +
> >  arch/arm/dts/sc594-som.dtsi | 1 +
> >  arch/arm/dts/sc598-som.dtsi | 1 +
> >  drivers/watchdog/adi_wdt.c  | 9 ++++++++-
> >  5 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/dts/sc57x.dtsi b/arch/arm/dts/sc57x.dtsi
> > index e4cc612959f..794e80c3cf1 100644
> > --- a/arch/arm/dts/sc57x.dtsi
> > +++ b/arch/arm/dts/sc57x.dtsi
> > @@ -113,6 +113,7 @@
> >
> >  &wdog {
> >         clocks =3D <&clk ADSP_SC57X_CLK_CGU0_SCLK0>;
> > +       secid =3D <3>;
> >  };
> >
> >  &eth0 {
> > diff --git a/arch/arm/dts/sc58x.dtsi b/arch/arm/dts/sc58x.dtsi
> > index 7b07589de47..d4008ba7988 100644
> > --- a/arch/arm/dts/sc58x.dtsi
> > +++ b/arch/arm/dts/sc58x.dtsi
> > @@ -158,6 +158,7 @@
> >
> >  &wdog {
> >         clocks =3D <&clk ADSP_SC58X_CLK_CGU0_SCLK0>;
> > +       secid =3D <3>;
> >  };
> >
> >  &eth0 {
> > diff --git a/arch/arm/dts/sc594-som.dtsi b/arch/arm/dts/sc594-som.dtsi
> > index 1c2adc601dd..7a7167fbbba 100644
> > --- a/arch/arm/dts/sc594-som.dtsi
> > +++ b/arch/arm/dts/sc594-som.dtsi
> > @@ -67,6 +67,7 @@
> >
> >  &wdog {
> >         clocks =3D <&clk ADSP_SC594_CLK_CGU0_SCLK0>;
> > +       secid =3D <3>;
> >  };
> >
> >  &i2c0 {
> > diff --git a/arch/arm/dts/sc598-som.dtsi b/arch/arm/dts/sc598-som.dtsi
> > index bc212ef25cb..bca3ff765d6 100644
> > --- a/arch/arm/dts/sc598-som.dtsi
> > +++ b/arch/arm/dts/sc598-som.dtsi
> > @@ -124,6 +124,7 @@
> >
> >  &wdog {
> >         clocks =3D <&clk ADSP_SC598_CLK_CGU0_SCLK0>;
> > +       secid =3D <3>;
> >  };
> >
>
> We should use a vendor prefix for this property "adi,sec" so that it
> will be the same as what the kernel will require. That way we will be
> able to switch to OF_UPSTREAM without a driver change once support
> lands in the kernel.
>
> >  &i2c0 {
> > diff --git a/drivers/watchdog/adi_wdt.c b/drivers/watchdog/adi_wdt.c
> > index 7d7cf98b55e..8e7ff958121 100644
> > --- a/drivers/watchdog/adi_wdt.c
> > +++ b/drivers/watchdog/adi_wdt.c
> > @@ -36,6 +36,7 @@ struct adi_wdt_priv {
> >         void __iomem *rcu_base;
> >         void __iomem *sec_base;
> >         void __iomem *wdt_base;
> > +       u32 secid;
> >         struct clk clock;
> >  };
> >
> > @@ -72,7 +73,7 @@ static int adi_wdt_start(struct udevice *dev, u64 tim=
eout_ms, ulong flags)
> >         iowrite32(0xc1, priv->sec_base + SEC_FCTL);
> >
> >         /* enable SEC fault source for watchdog0 */
> > -       setbits_32(priv->sec_base + SEC_SCTL0 + (3*8), 0x6);
> > +       setbits_32(priv->sec_base + SEC_SCTL0 + (priv->secid * 8), 0x6)=
;
> >
> >         /* Enable SYSCD_RESETb input */
> >         iowrite32(0x100, priv->rcu_base + RCU_CTL);
> > @@ -95,6 +96,7 @@ static int adi_wdt_probe(struct udevice *dev)
> >         struct adi_wdt_priv *priv =3D dev_get_priv(dev);
> >         int ret;
> >         struct resource res;
> > +       u32 secid;
> >
> >         ret =3D dev_read_resource_byname(dev, "rcu", &res);
> >         if (ret)
> > @@ -111,6 +113,11 @@ static int adi_wdt_probe(struct udevice *dev)
> >                 return ret;
> >         priv->wdt_base =3D devm_ioremap(dev, res.start, resource_size(&=
res));
> >
> > +       ret =3D dev_read_u32(dev, "secid", &secid);
> > +       if (ret)
> > +               return ret;
> > +       priv->secid =3D secid;
> > +
>
> I think you should just read it directly into the priv struct without
> a temporary, i.e. dev_read_u32(dev, "secid", &priv->secid).
>
> Also, what do you think about using dev_read_u32_default() with a
> default of 3 (appropriately documented) so that any users with
> modified or custom board device trees will not be surprised by this if
> they update to the latest?
>
> >         ret =3D clk_get_by_name(dev, "sclk0", &priv->clock);
> >         if (ret < 0) {
> >                 printf("Can't get WDT clk: %d\n", ret);
> > --
> > 2.43.0
> >
>
> Thanks,
> Greg
