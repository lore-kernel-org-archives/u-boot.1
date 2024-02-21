Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5FAC48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 11:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81FF187E06;
	Wed, 21 Feb 2024 12:29:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Noil0mpy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCA72876F4; Wed, 21 Feb 2024 10:36:29 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A65C1879E0
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 10:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fathi.boudra@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a3e87b2de41so313565066b.2
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 01:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708508180; x=1709112980; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KItjb+zGjqfNZJBwP41vek2kJ71OSYWP0JMUR9K4j8c=;
 b=Noil0mpyxHFKyBvNoxu9XsuWv6sYD+gJQdT5F65EFDzMVv+j7L2qLvhiWiBshbLMkT
 fvCaL/picwPCrc+Fj3is97i09skFR7AX6rd/lmnfRaFlN1dLfOOIRagbpv4tqOr8oZTa
 796Fwg40ukZJm/2eqyjyErPzQ4+RoIAU2W+SzUvD8EDjwnePfZQJuOvkFchedhHoz8Cl
 3wc+bugXi67C0Jsh7HS5IfuURdU/e1UFGYSa7Ma6JhW4oYa5h3a1Icu8N7LbkhmAm9rP
 +pn2SuZhRZvlXpcL02y2r8mWRXCB1cZstJeKgYHeCKSd/vWZYWp3LvwdohvC4K2oaAgY
 PoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708508180; x=1709112980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KItjb+zGjqfNZJBwP41vek2kJ71OSYWP0JMUR9K4j8c=;
 b=fewLZLZDcq6EUuGs31lIjVZGU9Er6X7oInLk4WLAiTz3zBSIxFmd7CmpNv1Y7/03kS
 24EvzXu4IEL8aHjov6Z0iby16yvVgyU4oLnlvTL0h1IN0xxfYfqZkqS6QH27JZOP6qF6
 +bA0KJhqbXQiWL2DWnxqOr17CECEd/nf7CPSfqoEb5svVicBIhyfd3aF5ipyk/SulZq6
 agh4MWbWbMejO1JXg7Xi5YzsmSSr50CA+IcVi09NbJUjjpaNoTqvIkm9stkzWP5yz+vh
 1GGBpNnAEcwXjVoJOeB9uHMd/Q+8DVlR8rn6EnmI4nlu53JNlj1u0oUtBtrlbd5THM4t
 Fsdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8seNLfKarp60Y9TxKXwWlsNaY5IyU9FlqtAE8rJmL0l70LEd7eHLJkhEu22/ZAZB0XNjpFfOhFuSpAtvSGOWv9TB/Lw==
X-Gm-Message-State: AOJu0Yx0qUvc0inakF9by+xbb44U6U30iewIWD73e3PsGF58+9kkaw27
 NlG+mvYXVdpziAAd287KpZZtx2ePxgNObD6dLhW3zPRzSHr961+3FH2cBQWELBycN8GTQIwdXJs
 v3spYx09N78abD7r2hR6+WmRIRG4BwCADpk3djA==
X-Google-Smtp-Source: AGHT+IENzXKh4Dq/NWUmqJiYdH1GNbdarR1RyjMy8+2t8esBAFZEdsdOeRoGdvs+fWUIbnlLObjjyRbsfHw5QGnW4AU=
X-Received: by 2002:a17:906:69d0:b0:a3c:af7e:1660 with SMTP id
 g16-20020a17090669d000b00a3caf7e1660mr12493282ejs.22.1708508180053; Wed, 21
 Feb 2024 01:36:20 -0800 (PST)
MIME-Version: 1.0
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-8-sumit.garg@linaro.org>
 <20240221075516.GA5131@francesco-nb>
 <fba9ba00b218a9c0c9be4958b2f08f1dee3e7a15.camel@toradex.com>
In-Reply-To: <fba9ba00b218a9c0c9be4958b2f08f1dee3e7a15.camel@toradex.com>
From: Fathi Boudra <fathi.boudra@linaro.org>
Date: Wed, 21 Feb 2024 10:36:08 +0100
Message-ID: <CAGNsrLD-prexjvhje6JU-PEKAeB=8-Cr+EipZWt57YCcFNSQNg@mail.gmail.com>
Subject: Re: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "francesco@dolcini.it" <francesco@dolcini.it>,
 "sumit.garg@linaro.org" <sumit.garg@linaro.org>, 
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "sahaj.sarup@linaro.org" <sahaj.sarup@linaro.org>, 
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "remi.duraffort@linaro.org" <remi.duraffort@linaro.org>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 "marex@denx.de" <marex@denx.de>,
 "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>, 
 "lukma@denx.de" <lukma@denx.de>, "aford173@gmail.com" <aford173@gmail.com>, 
 "seanga2@gmail.com" <seanga2@gmail.com>, "festevam@denx.de" <festevam@denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 21 Feb 2024 12:29:45 +0100
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

Hi,

On Wed, 21 Feb 2024 at 10:19, Marcel Ziswiler
<marcel.ziswiler@toradex.com> wrote:
>
> Hi Sumit
>
> On Wed, 2024-02-21 at 08:55 +0100, Francesco Dolcini wrote:
> > Hello Sumit,
> >
> > On Tue, Feb 20, 2024 at 06:40:56PM +0530, Sumit Garg wrote:
> > > Also, enable reset driver which is a prerequisite for PCIe support.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  configs/verdin-imx8mp_defconfig | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
> > > index 22b8a334dfa..d8bd644322b 100644
> > > --- a/configs/verdin-imx8mp_defconfig
> > > +++ b/configs/verdin-imx8mp_defconfig
> > > @@ -185,3 +185,12 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
> > >  CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
> > >  CONFIG_IMX_WATCHDOG=y
> > >  CONFIG_HEXDUMP=y
> > > +CONFIG_DM_RESET=y
> > > +CONFIG_RESET_IMX=y
> > > +CONFIG_PCI=y
> > > +CONFIG_PCIE_DW_IMX8=y
> > > +CONFIG_PHY_IMX8M_PCIE=y
> > > +CONFIG_CMD_PCI=y
> > > +CONFIG_NVME=y
> > > +CONFIG_NVME_PCI=y
> > > +CONFIG_CMD_NVME=y
> >
> > This will increase the u-boot proper size
>
> Yes, I checked and it is actually slightly more than 32 K.
>
> > and marginally increase the
> > boot time (because of a bigger binary to be read from the eMMC).
>
> That was also my concern.
>
> > Apart of that do you expect any other impact on those changes? SPL
> > binary size should not be affected, correct?
> >
> > Asking this out loudly to confirm that nothing unexpected is going to
> > happen because of these changes.
>
> Other than that I actually gave it a quick try and PCIe/NVMe does indeed work and the regular boot is not
> affected (other than the slight size and boot time increase, of course).
>
> > For my curiosity, care to share what's the use case? Do you plan to have
> > the OS stored into an NVME device?
>
> For us the question is basically whether that use case does mandate enforcing such changes for each and every
> customer. Plus the regular expected maintenance effort any such change brings with it, of course.

@Francesco that's correct, we have the OS stored on NVME SSD.
@Marcel wrt enforcing it, we can always fallback to have a config
fragment for our customers builds.
That's already the case, we fine tune the config and don't use U-Boot
defconfig out of the box for shipping to end users.

> > Francesco
>
> Cheers
>
> Marcel

Cheers,
-- 
Fathi Boudra
