Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0E9C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 09:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B17187D33;
	Thu, 21 Mar 2024 10:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LWx5cb2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A512879F6; Thu, 21 Mar 2024 10:25:22 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 190F287D59
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 10:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41466e01965so5203675e9.3
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 02:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711013117; x=1711617917;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bhJGeurYHyioi9ymosn+Jq8sju6cUCclL1Jug0iJT/4=;
 b=LWx5cb2+PejZLIIv5Fra+bXkBC+ClFy+Z2pQBVm3B1a+8j2UGHrLboFVJIulCGIyx0
 TBsJT269xza1mLpqBWJfF4aXdjPyPjfqsu9m/c1DSSHp5oHgofcIVeHvkgo59ZabnRDs
 02HejgBbqF7T5U4bgDUzF/ECNxf8Iq1a10daLI1HZM5uyzylGaUoFc/G/+sKtTTXjizc
 VYMTNf67HkSyejphFGEd7PauIP/pEvN+aws80VyrIBEWSbtrOq/R8iRt3mrI35wEvDUm
 biB2tjDb8jvAncEAVElbf8E5vkBGzxTofFZFCM2xVGBJBgKzYBeY/EUosnq8tQwjF8RJ
 2TSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711013117; x=1711617917;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bhJGeurYHyioi9ymosn+Jq8sju6cUCclL1Jug0iJT/4=;
 b=XFfXaZZ+1+ciLYmx0juIHCa/6l7Yhf96dy1hiYe8ukVu6BM2e25dotdd0hhx2sOJ7/
 5uLJ7I36eaajk1Htw7JEdAVPM9IFsjcX7Mrb9dtJ9tDTaeN+laKPQTZb+R1eCMlZ3gYC
 liiRGa42Q5qqE2auxkGlayTcmkiUrJlSbeJBI+1PrSwHgm6D8fuO1Ce6rx/jHVPhynrX
 fp0CTaoY87mv6TF5gKAfkTRdITJOacxyBCZ4XyENWpiBiuU7WQZmk/D4Di20JWczx19b
 geo5lfl4AiG5yVlMUeL3dCYO9QwUZ1e1p98tNA4W8t1L3Q3lWwIeuVFH3jG+u/yvwxWU
 ctUw==
X-Gm-Message-State: AOJu0YwjQ97DsqrrRggqaOa/N3jalZFKDJS8uvGei+6SaoDq8ip/scbF
 L8t8/MSjKR9YWT4uNp2O9pY8RlfQhId/hMSnjc7PPNmSaYe54H7OhjW6WtVVzdA=
X-Google-Smtp-Source: AGHT+IHHTp0gk+31+wOtYI+8IImG01CK00Jeh9li0hk31Jye01OgpDcCH66n1Zyuj8/Kw+vWuNe2jw==
X-Received: by 2002:a05:600c:358a:b0:414:22b5:c33a with SMTP id
 p10-20020a05600c358a00b0041422b5c33amr6786196wmq.1.1711013117516; 
 Thu, 21 Mar 2024 02:25:17 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 s14-20020a05600c384e00b00413ee7921b4sm4902635wmr.15.2024.03.21.02.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 02:25:17 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Neil
 Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/5] usb: dwc3-generic: implement Qualcomm wrapper
In-Reply-To: <8221c539-51b9-4ead-8cce-834c93230282@denx.de>
References: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
 <20240131-b4-qcom-usb-v1-1-6438b2a2285e@linaro.org>
 <ee020a2c-4f84-4fae-97a0-f12f3157d3ad@denx.de>
 <975bfe22-58b3-46b9-899b-f212b49d8664@linaro.org>
 <8221c539-51b9-4ead-8cce-834c93230282@denx.de>
Date: Thu, 21 Mar 2024 10:25:16 +0100
Message-ID: <87frwkndhf.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Caleb, Marek,

On jeu., mars 21, 2024 at 06:34, Marek Vasut <marex@denx.de> wrote:

> On 3/13/24 7:22 PM, Caleb Connolly wrote:
>
> [...]
>
>>>> +static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset,
>>>> u32 val)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 u32 reg;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 reg =3D readl(base + offset);
>>>> +=C2=A0=C2=A0=C2=A0 reg |=3D val;
>>>> +=C2=A0=C2=A0=C2=A0 writel(reg, base + offset);
>>>
>>> Use setbits_le32() .
>>>
>>>> +=C2=A0=C2=A0=C2=A0 /* ensure that above write is through */
>>>> +=C2=A0=C2=A0=C2=A0 readl(base + offset);
>>>
>>> Is this needed ?
>>=20
>> I honestly don't know, this is copied from the Linux driver and it seems
>> to be very defensively written. I doubt it's strictly necessary.
>
> Does git log indicate anything ?
>
> I suspect this is some sort of barrier .
>
> [...]
>
>>>> +/* For controllers running without superspeed PHYs */
>>>> +static void dwc3_qcom_select_utmi_clk(void __iomem *qscratch_base)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 /* Configure dwc3 to use UTMI clock as PIPE clock =
not present */
>>>> +=C2=A0=C2=A0=C2=A0 dwc3_qcom_setbits(qscratch_base, QSCRATCH_GENERAL_=
CFG,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 PIPE_UTMI_CLK_DIS);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 udelay(500);
>>>
>>> Isn't there some possibility to poll for completion instead of fixed
>>> delay ? If so, use wait_for_bit or some such .
>>=20
>> Not that I'm aware of, no. I think this hardware just has a blanket
>> "writes take X bus cycles to complete" rule or something. It's totally
>> possible that this code was originally written this way to work around
>> some issues on an FPGA prototype or something. Everything seems to still
>> work if I remove the delays so I'll drop them...
>
> Could you possibly ask someone ?
>
> [...]
>
>>>>  =C2=A0 static int dwc3_rk_glue_get_ctrl_dev(struct udevice *dev, ofno=
de *node)
>>>>  =C2=A0 {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *node =3D dev_ofnode(dev);
>>>> @@ -506,6 +599,10 @@ static int dwc3_glue_reset_init(struct udevice *d=
ev,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (ret)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>  =C2=A0 +=C2=A0=C2=A0=C2=A0 if (device_is_compatible(dev, "qcom,dwc3")=
) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset_assert_bulk(&glue->r=
esets);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 udelay(500);
>>>
>>> Why this delay here ?
>>=20
>> According to the docs, the reset should be asserted for at least 6 sleep
>> clock cycles, that's ~200us on sdm845, but it can vary by platform.
>
> A comment in the code would be nice.
>
> Sorry for the abysmal delay in replies.
>
> btw. the new version of this series is still OK to go in, unless you=20
> want to fill in the comments. They can also go in in separate follow up=20
> patch.

I'm interested by the answers above as well. As I took in the series [1] (to
avoid delaying it too much), please consider a follow up patch to add a
comment.

[1] https://lore.kernel.org/r/all/171101299073.1017001.16411913317437946645=
.b4-ty@baylibre.com/

