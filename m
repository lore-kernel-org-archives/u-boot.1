Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C63C5516D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 17:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 914E280E3A;
	Thu, 30 Jul 2026 17:44:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hc3j2wUOdO-W; Thu, 30 Jul 2026 17:44:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B64A480E18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785433476;
	bh=FFET/1HInGna+MwQvoaV7wzQ4+UgeiHvHpGVqk2bm3w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DvGn/6QA7hFFMPV/LOGEuBo/uh6NIvuvHj0+LPKCJ4kDRfcKtS0AtriNsbcHD2AMD
	 Hn4HYPPtEM5yJgxwtws8AuJZTAVgghOSRsQn4+dQF33P2n5T8fDLsE/FM+JGsgmEHm
	 Vh7OLTZnhUVGRMJ4hIF/KKV9Apy2b5f+mGwkhmnedt5XAVTvWHgL+PMbrftzl0pEVr
	 xShTSROz+w5gynZCavMpoovGLABEKEn8AGa6dESaOTaE2WTIhMTko+8x7pmbz0VAbT
	 iRMe0XLbXNyZxH/BW+LB6ncx17+4DC+kNOK7QeiDUCbgWkO0WmSk0Mh0JlW2XTbsXP
	 X4seetYh4GJYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B64A480E18;
	Thu, 30 Jul 2026 17:44:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 54EF826C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:44:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 467B740C7D
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:44:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OHXZibfZgLR6 for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 17:44:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=malysagreg@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 205D440C7A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 205D440C7A
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 205D440C7A
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:44:34 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2794A84A0A; Thu, 30 Jul 2026 19:44:32 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6927849BC
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 19:44:29 +0200 (CEST)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-381216921aaso179137a91.1
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 10:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785433468; cv=none;
 d=google.com; s=arc-20260327;
 b=JynqJzRhAxYj9ZgZDZskARsk0BE+z8jfYonzuia+H38Kwvp8zYzHgcz2yUKIG64Z6x
 o/VFGz0l8PoI2JCpV4MXuHV5QWHwUiouvrLYHM1ssTiD7YZVYZqa0gSYbeNU6PFF4bj+
 MlchB0L/AWVEJjqjeR8Ckq8cSXiqWHdGznH+kimFQUyn1KKXBg3ThtLVhktOGUuUehHU
 kxddOB2m6TiqN7grq7Yz0wO+XSot0hLKpdGxl0pw00K9zd2njIgdvHSaPDbzokFu+kNx
 umZlMcvZqwZN0ElwOctMrPnw+XmTjAPlqEwfnOZzmBqO3HvxZvvhzcfPRTaBLN53EXyd
 CESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FFET/1HInGna+MwQvoaV7wzQ4+UgeiHvHpGVqk2bm3w=;
 fh=qO+PPVciHf72vzk81GxdCquP/WxCHt3oB7otApYQXlY=;
 b=HpXDL9vDSbLFaMsUhUfaRvA3rfaHymBOi1Vj0g1qmzjiiivbx34xwagVaMq9QhhEFP
 pCNDzjudrlDbDP6vwJKUoFcJx8D/M883l0GGInMhWO+j/XOROR+4NdxLLjQ4oOCWWECu
 3BpWqz5PZNkcXGT/4GPVk/uMCIKDI4FAhROVws3tbBBD/cSMx086ld/efJn9lLdgo/Xa
 BpsSfLbyCmISzjkhjaWNUadm2Yhh9DAx4uUYWFUTIpVL8bGZguEXoIis2oQWvnad7f2z
 PeDuphMVajIhixtzal3pDx1Cf3dpcdCRcwbCm6YvocizhPxz6nLAxLxFTE3QP5q4OiPg
 i81Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785433468; x=1786038268;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FFET/1HInGna+MwQvoaV7wzQ4+UgeiHvHpGVqk2bm3w=;
 b=pMg3eJzfgyiebkksBFSaKEjKCJdicIxBYE+o9snqeHvzcUormnoDrQcj+kXkeqr+eq
 jQLiwr2fEGFrvFv7WXxjFrRF9TouEQxK+pUibCHnoSwY8zDmVHohkfQEmV/qmHViXSFz
 kAhR/KX/u4LJJHca7g8nTBf893Jwvcasbybpv/dLka5gyTz+KwfqgGBJV38PM4tgzpzM
 RmMxrCCOSkiMvjlrswkU0ovEALyJTxvsm6jEPChNe6od5SmYFe/6QPEruoagWsGkFexM
 9X4Ot+IF0w6hB1Q9GxyaCRq+foQ2/+MKt2tUKXhE38mVuAhmaxBi7HLN3AhzsbM34Y3I
 wfMg==
X-Forwarded-Encrypted: i=1;
 AHgh+RonHRukB7yh16DIsVrFrZk9OF+7ccL1QwLDZShEX2nIyLmDwkWrBarsRPoss0SentcJWfrcAUE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5LDMhB2ygxaV6KJT0+33XLDmGQ5HI+acNmEahG0OXzVhUAF7I
 czMvPMYG0tyWw10s9oIRH0DNmPgT9WC3JpP+WUX7Xf1+x+hX7x89WEGu/gdffFS14hyz30yz8VT
 sRzM8MgQ3jJniGDfoojWMSwVNC4fuJw==
X-Gm-Gg: AR+sD12SmHbuQMdxishfmtIpeKB01NVWz9fsXLLAq20vyXbGrb7sPgvQ7l2MwQIXF1o
 KySQE/akT/tX5BngXZeDsv9nvI8fREDyrm7agkTb9b/8e+Ex5ZV8iZlyUotW+itKXncEznjmm0U
 iuue+LIeQdUjtygdRFwzyKd2gLka5jRO256Dp43cKsRrASZtP0UOKFibM9fILyX5GMY/Q8OvgMV
 cIMGJwiNYFUPd92SkHKqiOFg8sh//izC4PyABFVGKo/qrsroxA5iOVjBE6xO0FDf4Tz1IDHgYMZ
 Evvs9ycvMzVz4piSom7idaO4rFDFc2fX6lSnZaMVq43lk/VkzabjfKbk94YJQtq4+ayKgFnWrJV
 Z
X-Received: by 2002:a17:90b:2245:b0:38e:6a30:4bbc with SMTP id
 98e67ed59e1d1-38f9bef33fcmr3008524a91.21.1785433468013; Thu, 30 Jul 2026
 10:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260730163621.83050-1-ozndrgt@gmail.com>
In-Reply-To: <20260730163621.83050-1-ozndrgt@gmail.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Thu, 30 Jul 2026 13:43:48 -0400
X-Gm-Features: AUfX_mw8P7Sk7QjPZ8BduV2IqAWnirgJHMY5ZHcPxnWOqtH_uF7ZH9nvgHr877c
Message-ID: <CABdDSeXFiL-aw5BRdH6QSm85L13tCzOEQrri99HOTOpromQpzw@mail.gmail.com>
Subject: Re: [PATCH] watchdog: adi_wdt: get SEC fault source ID from DT
To: Ozan Durgut <ozndrgt@gmail.com>
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
 d=gmail.com; s=20251104; t=1785433468; x=1786038268; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FFET/1HInGna+MwQvoaV7wzQ4+UgeiHvHpGVqk2bm3w=;
 b=er/T6AgomoPx/iDu+WwPhoeoXqq1DuMj+7ruw4Z19t/X/6RDjFGVY1/JlbKtgGedNY
 J2QbDOMKR0om5LdoOFYIMMtRitKkxoJNOaLQpPxhUtvYj6bq+9BBSWyVBuYGYd39Vmjx
 W4Jjy7jreviZ0P96e5agCTy8zz5wo0t7ZpEZ1SvivQuXiD9VD8RAZWwzAo1IFrtGCwYW
 wcU3iTc5QGFvHE+HWl4/ePfTLNYmSUDgVqmFYNNd42GCYjnhAMfJWzmpTyktubwLD25M
 EQh7DRw5dfmq+tCdYk4PLpWOJfr/LKu8cOybvte6oMZzvhZE+cCKz00stYam28OOJGxP
 uagQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=er/T6Ago
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=malysagreg@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="er/T6Ago"; 
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

Hi Ozan,

On Thu, Jul 30, 2026 at 12:38=E2=80=AFPM Ozan Durgut <ozndrgt@gmail.com> wr=
ote:
>
> From: UtsavAgarwalADI <utsav.agarwal@analog.com>
>
> The ADI watchdog drives a reset through a Security (SEC) controller
> fault source. The source index was hardcoded to 3 in adi_wdt_start(),
> which is only correct for the SC5xx parts that happen to use that
> index.
>
> Read the index from a new "secid" device tree property so boards that
> route the watchdog fault to a different SEC source can configure it.
>
> Set secid =3D <3> in the SC57x, SC58x, SC594 and SC598 device trees to
> match the value they relied on before.
>
> Co-developed-by: Ozan Durgut <ozan.durgut@analog.com>
> Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
> Signed-off-by: UtsavAgarwalADI <utsav.agarwal@analog.com>
> ---
>  arch/arm/dts/sc57x.dtsi     | 1 +
>  arch/arm/dts/sc58x.dtsi     | 1 +
>  arch/arm/dts/sc594-som.dtsi | 1 +
>  arch/arm/dts/sc598-som.dtsi | 1 +
>  drivers/watchdog/adi_wdt.c  | 9 ++++++++-
>  5 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/sc57x.dtsi b/arch/arm/dts/sc57x.dtsi
> index e4cc612959f..794e80c3cf1 100644
> --- a/arch/arm/dts/sc57x.dtsi
> +++ b/arch/arm/dts/sc57x.dtsi
> @@ -113,6 +113,7 @@
>
>  &wdog {
>         clocks =3D <&clk ADSP_SC57X_CLK_CGU0_SCLK0>;
> +       secid =3D <3>;
>  };
>
>  &eth0 {
> diff --git a/arch/arm/dts/sc58x.dtsi b/arch/arm/dts/sc58x.dtsi
> index 7b07589de47..d4008ba7988 100644
> --- a/arch/arm/dts/sc58x.dtsi
> +++ b/arch/arm/dts/sc58x.dtsi
> @@ -158,6 +158,7 @@
>
>  &wdog {
>         clocks =3D <&clk ADSP_SC58X_CLK_CGU0_SCLK0>;
> +       secid =3D <3>;
>  };
>
>  &eth0 {
> diff --git a/arch/arm/dts/sc594-som.dtsi b/arch/arm/dts/sc594-som.dtsi
> index 1c2adc601dd..7a7167fbbba 100644
> --- a/arch/arm/dts/sc594-som.dtsi
> +++ b/arch/arm/dts/sc594-som.dtsi
> @@ -67,6 +67,7 @@
>
>  &wdog {
>         clocks =3D <&clk ADSP_SC594_CLK_CGU0_SCLK0>;
> +       secid =3D <3>;
>  };
>
>  &i2c0 {
> diff --git a/arch/arm/dts/sc598-som.dtsi b/arch/arm/dts/sc598-som.dtsi
> index bc212ef25cb..bca3ff765d6 100644
> --- a/arch/arm/dts/sc598-som.dtsi
> +++ b/arch/arm/dts/sc598-som.dtsi
> @@ -124,6 +124,7 @@
>
>  &wdog {
>         clocks =3D <&clk ADSP_SC598_CLK_CGU0_SCLK0>;
> +       secid =3D <3>;
>  };
>

We should use a vendor prefix for this property "adi,sec" so that it
will be the same as what the kernel will require. That way we will be
able to switch to OF_UPSTREAM without a driver change once support
lands in the kernel.

>  &i2c0 {
> diff --git a/drivers/watchdog/adi_wdt.c b/drivers/watchdog/adi_wdt.c
> index 7d7cf98b55e..8e7ff958121 100644
> --- a/drivers/watchdog/adi_wdt.c
> +++ b/drivers/watchdog/adi_wdt.c
> @@ -36,6 +36,7 @@ struct adi_wdt_priv {
>         void __iomem *rcu_base;
>         void __iomem *sec_base;
>         void __iomem *wdt_base;
> +       u32 secid;
>         struct clk clock;
>  };
>
> @@ -72,7 +73,7 @@ static int adi_wdt_start(struct udevice *dev, u64 timeo=
ut_ms, ulong flags)
>         iowrite32(0xc1, priv->sec_base + SEC_FCTL);
>
>         /* enable SEC fault source for watchdog0 */
> -       setbits_32(priv->sec_base + SEC_SCTL0 + (3*8), 0x6);
> +       setbits_32(priv->sec_base + SEC_SCTL0 + (priv->secid * 8), 0x6);
>
>         /* Enable SYSCD_RESETb input */
>         iowrite32(0x100, priv->rcu_base + RCU_CTL);
> @@ -95,6 +96,7 @@ static int adi_wdt_probe(struct udevice *dev)
>         struct adi_wdt_priv *priv =3D dev_get_priv(dev);
>         int ret;
>         struct resource res;
> +       u32 secid;
>
>         ret =3D dev_read_resource_byname(dev, "rcu", &res);
>         if (ret)
> @@ -111,6 +113,11 @@ static int adi_wdt_probe(struct udevice *dev)
>                 return ret;
>         priv->wdt_base =3D devm_ioremap(dev, res.start, resource_size(&re=
s));
>
> +       ret =3D dev_read_u32(dev, "secid", &secid);
> +       if (ret)
> +               return ret;
> +       priv->secid =3D secid;
> +

I think you should just read it directly into the priv struct without
a temporary, i.e. dev_read_u32(dev, "secid", &priv->secid).

Also, what do you think about using dev_read_u32_default() with a
default of 3 (appropriately documented) so that any users with
modified or custom board device trees will not be surprised by this if
they update to the latest?

>         ret =3D clk_get_by_name(dev, "sclk0", &priv->clock);
>         if (ret < 0) {
>                 printf("Can't get WDT clk: %d\n", ret);
> --
> 2.43.0
>

Thanks,
Greg
