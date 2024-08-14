Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA916C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 01:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA227880A5;
	Wed, 14 Aug 2024 03:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UaWg9g8g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05E39883A4; Wed, 14 Aug 2024 03:04:14 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4299388056
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 03:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6b78c980981so34302426d6.2
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 18:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723597450; x=1724202250; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A7TaoNMzDCGlWRYLKz9wUCIyIbyAeYX6YsvrqFha+Vs=;
 b=UaWg9g8gGytGBz6hoM8NzMa69XflHGNQmIRwmPeeTx+ABqCuWMnMDQ3OGIfzj//nqA
 ruS0PGarRAWF2UwE1BSEcFpAaroZEKr4Op9v1D23Pd/pcTBnZcby384T2ykBEnfiGvGW
 cC1nkKLBZxy5GLONgkp7BXE/6rGy66rjR2728=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723597450; x=1724202250;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A7TaoNMzDCGlWRYLKz9wUCIyIbyAeYX6YsvrqFha+Vs=;
 b=VsxOBjphP8pCT4zlCa/yFhWurN9r/N5Q/K06ogt8SeKcNEkxnT3P1q69Ftn8H2WelS
 OFEId0cBk8T2T5CU+Iwx52s8p3/nB92zqabr3VmRNJyE4uVDpS1AuSFtYft7+2FnpbIs
 lWq+qWXUXMHnTvJyDdBIeM3n45J1qa5Xgub94kAVRUlpXNxgv7C9uH3uvSsj78ciz7GB
 wndydmNhJo9TEapcIa0MRTiYrRtgRi+aM/KgBhnl6H3Hn7RX4NeWGHPzn9z20W2ZU4WL
 cOA/H0nHe13y1KihQFVtoi39akL+2HZKO2/Vm6pxUKxIBMxkyrkym7O8Bb6Gigo+uowk
 jgjA==
X-Gm-Message-State: AOJu0YzdHZOyiO2Ty2tD0r2q9sPJeeYL32BNecNWNnEMMT0Rn+I62+JF
 mkCPlMpwhYfOSgP0H22R2WHz6WNZF1SMhicDWstEtF6JqggJWJyHLQktRuNDl0nOiewYsnHkbK0
 G15iD7d10ngnUcdbm1tf8lo/IsJN/3AEBeczD
X-Google-Smtp-Source: AGHT+IG7Fo2rn4HLuJ1nnLXekfyJZplHePFB7JzXr3TX4wrMqTY2gyKxZai5Gt8LrSsmDSLQGac8BWAYaPtpHwA4JeI=
X-Received: by 2002:a05:6214:5c02:b0:6bb:a0f6:8b32 with SMTP id
 6a1803df08f44-6bf5d1f9a64mr13217246d6.33.1723597450073; Tue, 13 Aug 2024
 18:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-7-sjg@chromium.org>
 <4d3f9b1c-5be6-454d-8cd4-28bd67ded364@cherry.de>
 <CAFLszTj-szBqxPVi8CiWb2jDnKdcx128C8Xk7XUL0a2QoccWbA@mail.gmail.com>
 <c7483e63-f51d-4b8c-9340-acf75e1f04b8@cherry.de>
 <CAFLszTjjKkJdTE90AYJN1S05xsf3Bso_fDiQN-4UcQuJNR4aYA@mail.gmail.com>
 <6ac92261-8515-4884-8cf6-357e8356bb4b@cherry.de>
 <CAFLszTgZFFv0iZs8GebLhjWtRzrh2=tGZi7KMDsBv=2bYNCq4A@mail.gmail.com>
 <f90b07be-c4a6-450a-aeda-02df396ec991@cherry.de>
In-Reply-To: <f90b07be-c4a6-450a-aeda-02df396ec991@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Aug 2024 19:03:59 -0600
Message-ID: <CAFLszThW7BeGS+-ZK4Tv23RLSKgQFiW_dX06qm9CXgBNYjD=sg@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] mmc: Use logging instead of pr_err()
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Quentin,

On Tue, 13 Aug 2024 at 07:09, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 8/13/24 3:02 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Tue, 13 Aug 2024 at 06:29, Quentin Schulz <quentin.schulz@cherry.de>
> > wrote:
> >>
> >> Hi Simon,
> >>
> >> On 8/13/24 2:16 PM, Simon Glass wrote:
> >>> Hi Quentin,
> >>>
> >>> On Mon, 12 Aug 2024 at 02:58, Quentin Schulz <quentin.schulz@cherry.de>
> > wrote:
> >>>>
> >>>> Hi Simon,
> >>>>
> >>>> On 8/11/24 4:50 PM, Simon Glass wrote:
> >>>>> Hi Quentin,
> >>>>>
> >>>>> On Tue, 6 Aug 2024 at 08:10, Quentin Schulz <quentin.schulz@cherry.de>
> > wrote:
> >>>>>>
> >>>>>> Hi Simon,
> >>>>>>
> >>>>>> On 7/21/24 5:25 PM, Simon Glass wrote:
> >>>>>>> Use the log subsystem instead of dev, to avoid including function
> > names
> >>>>>>> in the code.
> >>>>>>>
> >>>>>>> The CONFIG_LOGF_FUNC option can be used to enable the function name.
> >>>>>>>
> >>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>>>>> Reviewed-by: Sean Anderson <seanga2@gmail.com>
> >>>>>>> ---
> >>>>>>>
> >>>>>>> (no changes since v1)
> >>>>>>>
> >>>>>>>      drivers/mmc/mmc.c | 49
> > ++++++++++++++++++++++++-----------------------
> >>>>>>>      1 file changed, 25 insertions(+), 24 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> >>>>>>> index b18dc331f78..b0105afe5d6 100644
> >>>>>>> --- a/drivers/mmc/mmc.c
> >>>>>>> +++ b/drivers/mmc/mmc.c
> >>>>>>> @@ -294,7 +294,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int
> > timeout_ms)
> >>>>>>>
> >>>>>>>                  if (status & MMC_STATUS_MASK) {
> >>>>>>>      #if !defined(CONFIG_SPL_BUILD) ||
> > defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> >>>>>>> -                     pr_err("Status Error: 0x%08x\n", status);
> >>>>>>> +                     log_err("Status Error: %08x\n", status);
> >>>>>>
> >>>>>> Please don't remove the 0x prefix (will not comment on other patches
> > in
> >>>>>> this series if it happens again, please check :) ).
> >>>>>
> >>>>> OK...hex is the default though.
> >>>>>
> >>>>
> >>>> Can you please clarify what you meant by "it's the default though"?
> >>>
> >>> U-Boot uses hex by default, so anything printed out or entered is
> >>> normally in hex. There are a few exceptions, not all of them correct.
> >>
> >> Gotcha. This actually has been painful to me and I've made the mistake a
> >> few times already, e.g. writing 256 blocks instead of 100 (100 aka 0x100
> >> instead of base10 100). Are you aware whether this is made explicit in
> >> the docs somewhere? So I could refer to it if I ever need to explain
> > stuff?
> >
> > I believe it was in the old Denx manual. I found it in a Digi one [2]:
> >
> > Numbers used by U-Boot are always considered to be in hexadecimal format.
> >> For example, U-Boot
> >> understands number 30100000 as 0x30100000.
> >
> >
> > Perhaps we should add something like that to doc/usage?
> >
>
> Should have grepped in doc/ myself before asking others to do so for me :)
>
> https://docs.u-boot.org/en/latest/usage/cmdline.html#representing-numbers
> documents this.

Ah, good spotting!

> I would guess this is "good enough"? If not, not sure how to make this
> better? Hopefully, the commands that do not interpret as hex any string
> missing the 0x prefix have their help text specify this!

Yes, one hopes so. Tests can help with that too, so long as the
numbers are larger than 9.

Regards,
SImon
