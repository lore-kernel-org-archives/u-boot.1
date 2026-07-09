Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE61EC44501
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DB1F84ADD;
	Thu,  9 Jul 2026 15:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ri9X+uOz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E50C184A51; Thu,  9 Jul 2026 06:21:58 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99213849BA
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 06:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=royzah@gmail.com
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-664c535f1a0so736162d50.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 21:21:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783570915; cv=none;
 d=google.com; s=arc-20260327;
 b=Q9eFTIKqt5YRlchRquxh7dPVeZoPeEeMW8whXo+JQSI29k6rHp/AKchq5I4Q4y/x+F
 cOHHpV3YP574hgpwt90BH8EL0eV3GsRXEuIonDvH9me1mEHreWdqlIyLfCfdN8DJSdeJ
 LI0LWOR0H7uFfpfHNVPdtPl4p26nBSF0BSuE6IznCH3l3W+kABmNa6l0qJ5OV1pz9PBz
 2lIePUumXVQEsMRLAkmeILvQfXVcj8eMo7nGg8TVXdHATAElhciX20Mjah5+XA6zKVI3
 jAviWPWxSQOmWmrWJkCrgfK6+DNXVxonQI8ZguUlupNyVxSgSJIU/V3IeZ955+Wz4s+f
 ofow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KBjWuWwRLUTsFJ45rIJwkcJ0nZB6AcoPxYqrfXDPWcA=;
 fh=FGYByrkKwCjP+a6qYoeOwM11ezFFIIDnX4hNCEQGMgY=;
 b=jrWR7RQKPpy9/CW2ki8fjEk134oLM9oKlvB7Va1r6JiJGVQCH87K+aMSfy8WKTKgbo
 vImOH/Gkw8QqWFChwElqEFoDDiWwMN3o8jk5+FKAQZCM32GvCjnPl8UNldbaVfXtqZGj
 ++aT9hzR+GnDmaTT9U4ZeWwFq+gc6aW7HCGTsVy0yLs528yKcUu9OdEjYAghNJ+izL72
 bTfiiH92mx4PcprQEi7g4qUGFCS/NGhIWo+3r7R5Np3wqcC61tY3632wCZ6o5u5MXZNt
 vj6NDU6ntzLJQMbiE2zKGfGBo7xClKjGsJl4smNtF4qtI0lTt9FLfZoHMMrADzfhoCMm
 vLrA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783570915; x=1784175715; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KBjWuWwRLUTsFJ45rIJwkcJ0nZB6AcoPxYqrfXDPWcA=;
 b=ri9X+uOzD6PLSCD5o6npQazI6PaaRhc6yfPkhKwF9AEjcYPP/v7iUXN5UFUFaLyNj6
 zJf+GHcM55JJ5WCJfFU17NXD1SfckbKDKsKv3LYcR3HnLWYyaZ79pMETwfB1t9JELD8P
 F7M5zIkAS2tdRxCc5vo3Cravdcl+j9L1txRzSQQYvVzZVUABz2azTbxY0P356dLjodxl
 aD12hA+aMC5KYn/5TPZZkqRFaxwlrG+CZA879VM3lHKU+JCLvAqaCaGbGVV341CZrCaL
 JuCvx+WEE9Q/4MOSAtlvJIJWGl6DIhJni52s1hZtpzy/4SDvLDxJKn+1nc00LOXqArWR
 xVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783570915; x=1784175715;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KBjWuWwRLUTsFJ45rIJwkcJ0nZB6AcoPxYqrfXDPWcA=;
 b=jNVBtfDbkpGzawL6Vk+wQByM2sY9aJlu9KbQF08CLTVXQls+eBJq0L9zLdeRGV7E8O
 mRpSE+vHHv4L9NXeT1whvNybGOH6GH7skgvq2+CUdduWF6qtDuRdmcsMYeKVmhuaoR64
 aiqdQ8FCFikvzkv1kH9DIwQM3X66Vy7kZ12Zy/pClu9622XWlu9qq4RY4NjduUg5aj3H
 owXUnXCoYpiKSvtk+Auwhr8onC8xTZGbXMlomI6Szy4qaoUNO++F7yexX7jNsGZcxwZ8
 dWH+Sctyxv1QvENU2cWret+dA9JC3wnV72ThvNBsvzOAm7rRmbK54jpYYNaubn8RF34b
 kaTg==
X-Gm-Message-State: AOJu0YwrwS8ioBkg8TWrZ1q+3VGnr44VvQ0b3Tx6ppTVpYfnr6IzNq9s
 XckcrUJ0hRHfRPh2WjsQYSipVW/UqzFAG0JmYaEpp0lW1oIMvYUxnYH8IlhiprnEUWxu5TdFRXH
 hn8t8CAmwLWsPoXGpDuM5aylQ1JocEfJ3ZmCJpgmHa3rdBBk=
X-Gm-Gg: AfdE7ckKa5Zb6aZpXSjL36EJr2Zk+LuAV6z3BsJwBCTwEkO92IRtGYWCNQSXUESMu/w
 45gkzsG6ifwHqP4hyHUYhyXsYPrgFylKB57golpcdWhZQiFUbhOyEo1mtzmivBW3QhUfuBhEydc
 9Viw2B7IG4gCHjCh9YsLMknG84qqUoAbGArcDXsmn1rJTVbfhDN2RBfKk7TGG2cZ/kIdAk7CKOZ
 dKGhUUIdabjyJGf7GSG7ibjhvwVfiB7ZagmhptTEWEmgcAs1r3aHrENIxRIt3cxpCSWfKnSsg++
 6oklE2Lcz2BJNo31BzwWlfdTtbEU
X-Received: by 2002:a05:690e:4083:b0:667:997e:7cfa with SMTP id
 956f58d0204a3-6679f2c8816mr3924189d50.94.1783570915263; Wed, 08 Jul 2026
 21:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260708170228.621618-1-royzah@gmail.com>
 <48cde03b-5032-4863-b44a-a401dc793cfe@linaro.org>
In-Reply-To: <48cde03b-5032-4863-b44a-a401dc793cfe@linaro.org>
From: Muhammad Royyan Zahir <royzah@gmail.com>
Date: Thu, 9 Jul 2026 08:21:44 +0400
X-Gm-Features: AVVi8CeE9o_qt1frCJX1JEEvDvDFi_qcKZFMk1CMybG6iEhzXEyhxm6-_CvYLbA
Message-ID: <CAO9oOQJMAuU=54CRSCk25CvsPqStJYUgVPPe_OtWKn_2=9yEPg@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: sa8775p: enable GPLL9 before SDCC1 high-speed
 rates
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de
X-Mailman-Approved-At: Thu, 09 Jul 2026 15:05:30 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Casey,

Thanks for the review!

I confirmed SDCC1 here is the board's single sdhc controller (mmc@87c4000,
GCC_SDCC1_APPS_CLK), and the EVK's sd-card overlay wires it to the SD slot,
so a card in high-speed mode exercises exactly the GPLL9-sourced 192 MHz
rate this patch enables.

I do not have the board on hand at the moment (i am travelling) my
mate does, so I will arrange the SD-card file-access test through him and
follow up with a Tested-by.
If Balaji, Varadarajan or Sumit get to it first on their boards, all the
better.

Thanks,
Royyan

On Thu, Jul 9, 2026 at 8:03=E2=80=AFAM Casey Connolly <casey.connolly@linar=
o.org>
wrote:

> Hi Royyan,
>
> On 7/8/26 19:02, Royyan Zahir wrote:
> > On lemans/sa8775p, the SDCC1 apps clock high-speed rates (192 and 384
> MHz)
> > source from GPLL9 (ftbl_gcc_sdcc1_apps_clk_src), but the driver never
> enables
> > GPLL9. When SDCC1 is set to such a rate the RCG switches its source to =
a
> PLL
> > that is off, so the CMD_RCGR update bit never self-clears and U-Boot
> warns:
> >
> >    WARNING: RCG @ 0x120014 stuck at off
> >
> > Vote GPLL9 on before selecting it as the SDCC1 source, mirroring how
> > clock-sm8250.c enables GPLL9 for SDCC2. GPLL9's mode/status register is
> at
> > 0x9000 (lock is bit 31) and its enable vote is bit 9 of the APCS GPLL
> vote
> > register 0x4b028, matching gcc-sa8775p.c in Linux.
>
> Nice find! Thanks for fixing this.
>
> >
> > Not hardware-validated for SDCC high speed: the board this was found on
> > (Qualcomm IQ-9075 / Lemans EVK) boots from UFS with no SD card
> populated, so
> > here it only clears the stuck-RCG warning. Build-tested on lemans.
>
> Can you test file access on an sdcard perhaps?
>
> Balaji, Varadarajan, Sumit: could you confirm this fix and maybe send a
> T-b?
>
> >
> > Signed-off-by: Royyan Zahir <royzah@gmail.com>
>
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
>
> Thanks,
> // Casey
>
> > ---
> >   drivers/clk/qcom/clock-sa8775p.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/clk/qcom/clock-sa8775p.c
> b/drivers/clk/qcom/clock-sa8775p.c
> > --- a/drivers/clk/qcom/clock-sa8775p.c
> > +++ b/drivers/clk/qcom/clock-sa8775p.c
> > @@ -26,6 +26,9 @@
> >
> >   #define SDCC1_APPS_CLK_CMD_RCGR                     0x20014
> >
> > +#define APCS_GPLL9_STATUS                    0x9000
> > +#define APCS_GPLLX_ENA_REG                   0x4b028
> > +
> >   #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
> >   #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
> >   #define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
> > @@ -90,6 +93,14 @@
> >       { }
> >   };
> >
> > +/* GPLL9 (SDCC1 high-speed source) is not enabled by earlier boot
> stages. */
> > +static const struct pll_vote_clk gpll9_vote_clk =3D {
> > +     .status =3D APCS_GPLL9_STATUS,
> > +     .status_bit =3D BIT(31),
> > +     .ena_vote =3D APCS_GPLLX_ENA_REG,
> > +     .vote_bit =3D BIT(9),
> > +};
> > +
> >   static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
> >   {
> >       struct msm_clk_priv *priv =3D dev_get_priv(clk->dev);
> > @@ -130,6 +141,9 @@
> >               return 19200000;
> >       case GCC_SDCC1_APPS_CLK:
> >               freq =3D qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate=
);
> > +             /* SDCC1 high-speed rates source from GPLL9; vote it on
> first. */
> > +             if (freq->src =3D=3D CFG_CLK_SRC_GPLL9)
> > +                     clk_enable_gpll0(priv->base, &gpll9_vote_clk);
> >               clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
> >                                    freq->pre_div, freq->m, freq->n,
> freq->src, 8);
> >               return freq->freq;
>
>
