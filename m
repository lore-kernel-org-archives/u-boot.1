Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8577EC54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 14:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 990FB87EFA;
	Thu, 21 Mar 2024 15:14:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2KM3bfmL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F0A7880AF; Thu, 21 Mar 2024 15:14:53 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E5F887EFA
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 15:14:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4146562a839so7321755e9.1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711030490; x=1711635290;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wuQgcqBQYsmmHE5d4iRLuMPgbirdYcrNslLJrPpdreg=;
 b=2KM3bfmLi6Ndk6XitdmsChyFKjAi1oCcEzYfWdwHq8yiH5E505jE3aSKz4J292D+wy
 ObGBsCM92GpWriD/q+eONGpN6C63UPt5QR1rtdhjBIAwjiBRKBIJF1q1IUO7IwpQpAjF
 as+zCHpPcwvybPV6mhx11GM5YsPwZcpSFaLQYt9fyzQbc5HUKNUxTYYoZqyFB/KhCt6c
 5k+1E3tHE9ZW9Z+I6f0mJ2BQupz2Oa+LLCh0RQxoebGniNmun5eJBOz45gJd/1R5loyj
 u2x5XyB0Bc4jZGsvD/0gCMHwocB4b8oUM7pGbgVDYHGSfMglPLCaDtGTE+hwFDIcWHDM
 AVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711030490; x=1711635290;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wuQgcqBQYsmmHE5d4iRLuMPgbirdYcrNslLJrPpdreg=;
 b=e5FokNd8domUIq5hvvgom7+LnW89AWPyR0Ubnlu5TJ8jktFOjxhe75cJuvQTQDB4Xy
 Qaz7ggntXTJidwyHX3rJ7VWP/Q2lvFuh2Iiv2td3TLFx/U8DpY0ekk0wCZXGalAPVReD
 gzmMk5MTVzZeM9H4IJM0NRb56E9JXc5YkrsTv9HssqVpmVgAVUF0Sl2NC2oNQsvWZPP/
 qOfjjbZJ6NB0cqALZJf0D1Ehug5oPhYGFU//trMGPgX5NKuR1aM4phmTQ8zEnrw65N5X
 xEMZF0TpLjeZbRi+MVOgishFC08Ug81oBs38ymPbEEW4EhUKm581G9/dbCnqwboqcjY4
 QEhQ==
X-Gm-Message-State: AOJu0Yzs2jc00vldztPlPEisF7uNDTAuTWuRzr+2VPKVH+8+p81whNUC
 47AV8CCmSI7Tom1q7RxFvZPgfCbO6tqLzlUmfPam3tBgYqBzO8Ofoyc/y11bU4s=
X-Google-Smtp-Source: AGHT+IFQh/YdID67KY+miLvmm0QgFoAMNX/LaS4QVdaKZkXABNu32k5vB6pXQmAgpcvf9tjn+2P+2Q==
X-Received: by 2002:a05:6000:4c2:b0:33d:87e9:5900 with SMTP id
 h2-20020a05600004c200b0033d87e95900mr5998539wri.62.1711030490395; 
 Thu, 21 Mar 2024 07:14:50 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 u3-20020a5d6ac3000000b0033dd2c3131fsm17318901wrw.65.2024.03.21.07.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 07:14:49 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Neil
 Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/5] usb: dwc3-generic: implement Qualcomm wrapper
In-Reply-To: <f3940b9b-e5a0-447d-a6a8-447fdd21e17b@linaro.org>
References: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
 <20240131-b4-qcom-usb-v1-1-6438b2a2285e@linaro.org>
 <ee020a2c-4f84-4fae-97a0-f12f3157d3ad@denx.de>
 <975bfe22-58b3-46b9-899b-f212b49d8664@linaro.org>
 <8221c539-51b9-4ead-8cce-834c93230282@denx.de>
 <87frwkndhf.fsf@baylibre.com>
 <f3940b9b-e5a0-447d-a6a8-447fdd21e17b@linaro.org>
Date: Thu, 21 Mar 2024 15:14:48 +0100
Message-ID: <87edc3llif.fsf@baylibre.com>
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

On jeu., mars 21, 2024 at 11:34, Caleb Connolly <caleb.connolly@linaro.org>=
 wrote:

> Hi,
>
> On 21/03/2024 09:25, Mattijs Korpershoek wrote:
>> Hi Caleb, Marek,
>>=20
>> On jeu., mars 21, 2024 at 06:34, Marek Vasut <marex@denx.de> wrote:
>>=20
>>> On 3/13/24 7:22 PM, Caleb Connolly wrote:
>>>
>>> [...]
>>>
>>>>>> +static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset,
>>>>>> u32 val)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 u32 reg;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 reg =3D readl(base + offset);
>>>>>> +=C2=A0=C2=A0=C2=A0 reg |=3D val;
>>>>>> +=C2=A0=C2=A0=C2=A0 writel(reg, base + offset);
>>>>>
>>>>> Use setbits_le32() .
>>>>>
>>>>>> +=C2=A0=C2=A0=C2=A0 /* ensure that above write is through */
>>>>>> +=C2=A0=C2=A0=C2=A0 readl(base + offset);
>>>>>
>>>>> Is this needed ?
>>>>
>>>> I honestly don't know, this is copied from the Linux driver and it see=
ms
>>>> to be very defensively written. I doubt it's strictly necessary.
>>>
>>> Does git log indicate anything ?
>
> Nope :/ it's there from when the driver was first added.
>>>
>>> I suspect this is some sort of barrier .
>>>
>>> [...]
>>>
>>>>>> +/* For controllers running without superspeed PHYs */
>>>>>> +static void dwc3_qcom_select_utmi_clk(void __iomem *qscratch_base)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 /* Configure dwc3 to use UTMI clock as PIPE cloc=
k not present */
>>>>>> +=C2=A0=C2=A0=C2=A0 dwc3_qcom_setbits(qscratch_base, QSCRATCH_GENERA=
L_CFG,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 PIPE_UTMI_CLK_DIS);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 udelay(500);
>>>>>
>>>>> Isn't there some possibility to poll for completion instead of fixed
>>>>> delay ? If so, use wait_for_bit or some such .
>>>>
>>>> Not that I'm aware of, no. I think this hardware just has a blanket
>>>> "writes take X bus cycles to complete" rule or something. It's totally
>>>> possible that this code was originally written this way to work around
>>>> some issues on an FPGA prototype or something. Everything seems to sti=
ll
>>>> work if I remove the delays so I'll drop them...
>>>
>>> Could you possibly ask someone ?
>
> Yeah I'll ask around, I'm not confident I'll find an answer though.
>>>
>>> [...]
>>>
>>>>>>  =C2=A0 static int dwc3_rk_glue_get_ctrl_dev(struct udevice *dev, of=
node *node)
>>>>>>  =C2=A0 {
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *node =3D dev_ofnode(dev);
>>>>>> @@ -506,6 +599,10 @@ static int dwc3_glue_reset_init(struct udevice =
*dev,
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (ret)
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>>>  =C2=A0 +=C2=A0=C2=A0=C2=A0 if (device_is_compatible(dev, "qcom,dwc3=
")) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset_assert_bulk(&glue-=
>resets);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 udelay(500);
>>>>>
>>>>> Why this delay here ?
>>>>
>>>> According to the docs, the reset should be asserted for at least 6 sle=
ep
>>>> clock cycles, that's ~200us on sdm845, but it can vary by platform.
>>>
>>> A comment in the code would be nice.
>>>
>>> Sorry for the abysmal delay in replies.
>>>
>>> btw. the new version of this series is still OK to go in, unless you=20
>>> want to fill in the comments. They can also go in in separate follow up=
=20
>>> patch.
>>=20
>> I'm interested by the answers above as well. As I took in the series [1]=
 (to
>> avoid delaying it too much), please consider a follow up patch to add a
>> comment.
>
> The v4 you picked up has a comment explaining this.

Right, sorry I missed that. Thanks for pointing it out to me!

>>=20
>> [1] https://lore.kernel.org/r/all/171101299073.1017001.16411913317437946=
645.b4-ty@baylibre.com/
>>=20
>
> --=20
> // Caleb (they/them)
