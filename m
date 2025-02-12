Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37C4C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 08:45:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E7BD80824;
	Wed, 12 Feb 2025 09:45:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EzVt/Pqq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E73B809D0; Wed, 12 Feb 2025 09:45:45 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D334807C0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 09:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fa8ac56891so4324762a91.2
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 00:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1739349940; x=1739954740;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnIJyBsoeB/mK/1b53D+GSI8peUeF83XUwbJ9jkFq2s=;
 b=EzVt/PqqYxVZN+xjA0RG9jW1yeGahu7gPMJ/05moyaQXHTKAQjBmUWyWCCL4gug/Bt
 CW430rP+UB7iHTfVGPAYGJFBsNfebOvKCe6ACKnm/XFTfE89/V+F/qW5zUT1jQvl7XCU
 F+cr4eKcl0HdTC7Jz6XWH/AS4ab/oqY6yObEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739349940; x=1739954740;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jnIJyBsoeB/mK/1b53D+GSI8peUeF83XUwbJ9jkFq2s=;
 b=Xhk7FbzdB9VkWs5XvYy4wLbFE/0JrwT/yMzLnD6HKcWsrIeIH0GgjOz567oJT6LDxN
 cNQsq2I42iKN2J3zjxPDZ2bo4m8CqhQKRTKuqs8WgRrkrB12rBu6nkD1caVaY70jiMXE
 DZOBQAW8VSDXm4AjR0N8X0PfbdI1rOchu0bQHYliTb6RPbXsv0j62pG+z4AvMeOYaDiz
 nrLL9cjgAOMXrZUz5mYRGFFwV/Mc/fjesJ3n3JIkh9gpwX6bTbITX9Qb8xuCjrbOzvBv
 W5y8UK5ts5VxciVLZyYf0ROMyFG8YvZ1H/B0qOuOWjPHd/GXTwwvha6mugARRFtoTFZb
 DmHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4bzK82BoauHmDmehQtHbWq3rTXwVUaiku3o+wu1rofBCqIG6jbgeB0h0ClorScSDliqBVIZA=@lists.denx.de
X-Gm-Message-State: AOJu0YwNUZPqev/6XBhetc+hvGEvUXmYzfk9nRkZQnkNcRQkrs/wk1yw
 4zMO4WF+fD17+7Le2fOtdxciOChhjHmDklRlSWocJ15sSYLBKR+2BOwuHxDHfe9dZ8xJTcBmzqg
 A8T1bn4t8Lgv1/gr+M5QdxjsH5cVbqwn+vTw3bw==
X-Gm-Gg: ASbGncviKPN3fPNgJLPazudDRMXgH+E3bTKgUcIq9Anngnp+IeDDxZdqDP00tiPAgfG
 1dgCj7I0NdN/vKB9x8xqu6s0VMBNRud38viuFweRgiBj9wdee9w/Upg+gajl0i68XWzd4LxlK
X-Google-Smtp-Source: AGHT+IEjz0GqgY2EpTtcVaA6TbK/A5W3IGIPeAKNWBtlkUUnt8UilBFHOB3f+15YPzHalfYqiTdrL4tgSl/QQ7hGnQk=
X-Received: by 2002:a17:90b:2e41:b0:2f5:63a:449c with SMTP id
 98e67ed59e1d1-2fbf5c58329mr3616825a91.28.1739349939713; Wed, 12 Feb 2025
 00:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20240415074547.779264-1-ada@thorsis.com>
 <20240415075755.780653-1-ada@thorsis.com>
 <20240528-among-detective-e8ad4c9b5457@thorsis.com>
 <20240930-pamperer-prance-8b4566ba43a6@thorsis.com>
 <3a3cc57c-e696-408f-a050-39502081b6f3@microchip.com>
 <20250212-untidy-rockstar-373666ce4271@thorsis.com>
 <4702c602-0c81-4153-a7a5-eccf18b58b37@linaro.org>
In-Reply-To: <4702c602-0c81-4153-a7a5-eccf18b58b37@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 12 Feb 2025 09:45:27 +0100
X-Gm-Features: AWEUYZkONcHC7N8xchp29sGVb6FrozVrMx47n5u6Kf5Wzv9oQo3_x_cfbDO_CLs
Message-ID: <CAOf5uwnUn7QzABGqgKiBew8yAi-jZJJ9Ft8Ac3X7c8A3xrC4bw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mtd: nand: raw: atmel: Fix pulse read timing for
 certain NAND flashes
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Alexander Dahl <ada@thorsis.com>, dario.binacchi@amarulasolutions.com, 
 Bin.Li@microchip.com, Nicolas.Ferre@microchip.com, u-boot@lists.denx.de, 
 Mihai.Sain@microchip.com, Balamanikandan.Gunasundar@microchip.com
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

Hi Eugen

Please apply

Michael

On Wed, Feb 12, 2025 at 9:44=E2=80=AFAM Eugen Hristev <eugen.hristev@linaro=
.org> wrote:
>
>
>
> On 2/12/25 09:09, Alexander Dahl wrote:
> > Hello,
> >
> > Am Wed, Oct 09, 2024 at 04:45:02AM +0000 schrieb Balamanikandan.Gunasun=
dar@microchip.com:
> >> On 30/09/24 1:37 pm, Alexander Dahl wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w the content is safe
> >>>
> >>> Hello,
> >>>
> >>> Am Tue, May 28, 2024 at 12:32:44PM +0200 schrieb Alexander Dahl:
> >>>> Hei hei,
> >>>>
> >>>> Am Mon, Apr 15, 2024 at 09:57:55AM +0200 schrieb Alexander Dahl:
> >>>>>  From reading the S34ML02G1 and the SAM9X60 datasheets again, it se=
ems
> >>>>> like we have to wait tREA after rising RE# before sampling the data=
.
> >>>>> Thus pulse time must be at least tREA.
> >>>>>
> >>>>> Without this fix we got PMECC errors when reading, after switching =
to
> >>>>> ONFI timing mode 3 on SAM9X60 SoC with S34ML02G1 raw NAND flash chi=
p.
> >>>>>
> >>>>> The approach to set timings used before worked on sam9g20 and sama5=
d2
> >>>>> with the same flash (S34ML02G1), probably because those have a slow=
er
> >>>>> mck clock rate and thus the resolution of the timings setup is not =
as
> >>>>> tight as with sam9x60.
> >>>>>
> >>>>> The approach to fix the issue was carried over from at91bootstrap, =
and
> >>>>> has been successfully tested in at91bootstrap, U-Boot and Linux.
> >>>>>
> >>>>> Link: https://github.com/linux4sam/at91bootstrap/issues/174
> >>>>> Cc: Li Bin <bin.li@microchip.com>
> >>>>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> >>>>> ---
> >>>>>
> >>>>> Notes:
> >>>>>      v3:
> >>>>>      - initial patch version (not present in v1 and v2)
> >>>>
> >>>> This patch was send as part of a series, which you wanted to have so=
me
> >>>> more time to test.  Besides that, has anyone looked into this
> >>>> particular fix?  Maybe it can be applied separately?
> >>>
> >>> I'd kindly ask what the status of this patch series is from U-Boot
> >>> NAND subsystem maintainers POV?  Could you test it?  Should I rebase
> >>> and resend?
> >>>
> >>> Two of these three patches are specific to at91 family, what's the
> >>> opinion of at91 maintainers on this?
> >>>
> >>> Link to the series discussion for reference:
> >>>
> >>> https://lore.kernel.org/u-boot/20240415074547.779264-1-ada@thorsis.co=
m/T/#u
> >>>
> >>> Greets
> >>> Alex
> >>>
> >>
> >> Hi Alex,
> >>
> >> Apologies for the delay in response. I also faced the same kind of
> >> problem while testing our new sam7d65 board with MX30LF4G28AD nand
> >> flash. I just had a workaround to increase the pulse time by 5 nsecs
> >> just for testing. The issue has been reported to the validation team a=
nd
> >> an investigation is under progress.
> >>
> >> I would request a few more days for this patch alone.
> >
> > Why did the _same_ change I posted here last year in April appeared
> > in linux4sam now with different credits? o.O
> >
> > https://github.com/linux4sam/u-boot-at91/commit/4175c4c8535ea886e2c0fd9=
9e94ead6bc7a4df5f
> >
> > For reference: the issue was discussed in length here before I made
> > the patch for U-Boot last year:
> >
> > https://github.com/linux4sam/at91bootstrap/issues/174
> >
> > Besides: this patch series was still not reviewed and not merged.
> > Dear U-Boot NAND subsystem maintainer, what's the status?
> >
> > Greets
> > Alex
>
> Hello Alex,
>
> As this change appeared downstream, apparently it's validated.
>
> I can apply this as a fix through at91 tree.
>
> Dario do you mind if I do that ? Apparently the patch is now on your list=
.
>
> Eugen
> >
> >>
> >> Thanks,
> >> Bala.
> >>
> >>>>
> >>>> Greets
> >>>> Alex
> >>>>
> >>>>>
> >>>>>   drivers/mtd/nand/raw/atmel/nand-controller.c | 13 +++++++++----
> >>>>>   1 file changed, 9 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers=
/mtd/nand/raw/atmel/nand-controller.c
> >>>>> index bbafc88e44c..00ffeadd113 100644
> >>>>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> >>>>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> >>>>> @@ -1133,7 +1133,7 @@ static int atmel_smc_nand_prepare_smcconf(str=
uct atmel_nand *nand,
> >>>>>                                        const struct nand_data_inter=
face *conf,
> >>>>>                                        struct atmel_smc_cs_conf *sm=
cconf)
> >>>>>   {
> >>>>> -   u32 ncycles, totalcycles, timeps, mckperiodps;
> >>>>> +   u32 ncycles, totalcycles, timeps, mckperiodps, pulse;
> >>>>>      struct atmel_nand_controller *nc;
> >>>>>      int ret;
> >>>>>
> >>>>> @@ -1259,11 +1259,16 @@ static int atmel_smc_nand_prepare_smcconf(s=
truct atmel_nand *nand,
> >>>>>                       ATMEL_SMC_MODE_TDFMODE_OPTIMIZED;
> >>>>>
> >>>>>      /*
> >>>>> -    * Read pulse timing directly matches tRP:
> >>>>> +    * Read pulse timing would directly match tRP,
> >>>>> +    * but some NAND flash chips (S34ML01G2 and W29N02KVxxAF)
> >>>>> +    * do not work properly in timing mode 3.
> >>>>> +    * The workaround is to extend the SMC NRD pulse to meet tREA
> >>>>> +    * timing.
> >>>>>       *
> >>>>> -    * NRD_PULSE =3D tRP
> >>>>> +    * NRD_PULSE =3D max(tRP, tREA)
> >>>>>       */
> >>>>> -   ncycles =3D DIV_ROUND_UP(conf->timings.sdr.tRP_min, mckperiodps=
);
> >>>>> +   pulse =3D max(conf->timings.sdr.tRP_min, conf->timings.sdr.tREA=
_max);
> >>>>> +   ncycles =3D DIV_ROUND_UP(pulse, mckperiodps);
> >>>>>      totalcycles +=3D ncycles;
> >>>>>      ret =3D atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NRD_SHI=
FT,
> >>>>>                                        ncycles);
> >>>>> --
> >>>>> 2.39.2
> >>>>>
> >>>>
> >>
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
