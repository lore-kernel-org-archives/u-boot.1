Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B428BC48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 10:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E121687C35;
	Wed, 21 Feb 2024 11:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uPOSJTS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 481A587BC9; Wed, 21 Feb 2024 11:04:39 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A4087C35
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 11:04:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe57bbso2759162241.1
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 02:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708509874; x=1709114674; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=06VAMO1rYYKOgFwhtEG3hiQ+7jnrhos3yeTLC4F7NQ8=;
 b=uPOSJTS6AuEZj2sVasuEPPZNNytZLyT2bheD8iG+LDqunklOxhNR2rWz6upTdGQT/+
 P2qdkHkoBUfaieaaPogc0hkRMeS++MXxGb97DpRlsk4vqM2gae9jpDa1wR1OMbWwC/Sc
 ZDTBZIlXAsjBpbFh0Y/OxwtgMnz9pgWN0WK32VpzVjt1kkQklEk1BvUt1g3f3I1ogQBp
 UXQyeV9mMXcmJEMPiX80cvYh5ikk3Dn0k+DBm5hn9v/Mzz21XOAgY+2AS0v+EshMgc9q
 5mUkgd69qZ5zQB4Rm20WjmLV//dBwapNs0kuHaQiC0Gq6F5M1QdLlCnAvGxnQZAAhaRd
 mVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708509874; x=1709114674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=06VAMO1rYYKOgFwhtEG3hiQ+7jnrhos3yeTLC4F7NQ8=;
 b=hSuONMNz4Jcv9GBEv+NZr8UO+wB4zCMU9jCf60stt0k36+x9MZmhp0ed74L1xM9kMn
 CAHMU/oxIwVO+MQSuELtOjF7UMOXxkK/qlURRlBV6mjH8mbjoUY+aJ8CQOCIjb0aDg0M
 d4/3HYwmKbltmZ8kSRFju3GZuy5Yewvx9KamVwQmPGRT5a0YyH1jymi/fsdwUaskooSB
 yriRuP4ImaY2DkPNcdcfgskswrS3o3FkoNl1jv4YCpZi3xTzh8WNAQkP3Svw95FTaNMD
 xyH6B1PLg8ZbLjGBOgcKXrdNO0lzgQKGly5NjFspCLmlpNbVbUJ8NJfLbPn9yopC/YhJ
 MWtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTtKZq52aBsquclHrz6QBt7r6tJcrxgFOrqcdCf42l0+wSQ+XWw5FGv/q/AvU+7fKGS0m2Urjd4vz2G2BIPUJnx1+ifA==
X-Gm-Message-State: AOJu0YzyDdj1VUoxmRjOLIOU6VflivmWqsdN8l8OlDrzO6ld3MebxGz/
 Q9pc/N98MNNtbYHz83/iONsVimw9mnlMKqP2S8QhoWdm5Y0lhdMN59D1UpvdanVob0lPIuvaltv
 WRFMyP24n4pwu8RuFEtxY8fLGFNZs/E43Ea8Bxg==
X-Google-Smtp-Source: AGHT+IEBu4EbRWV7f41dYJ5Ozy5i3IKYCCmoluLjB6NYTUt2+TYigER6TPXTNkrVdcVaCoPGHTt2gPiaSIn5oBOIrsE=
X-Received: by 2002:a67:f414:0:b0:470:5b9b:8693 with SMTP id
 p20-20020a67f414000000b004705b9b8693mr6002081vsn.6.1708509873544; Wed, 21 Feb
 2024 02:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-8-sumit.garg@linaro.org>
 <20240221075516.GA5131@francesco-nb>
 <fba9ba00b218a9c0c9be4958b2f08f1dee3e7a15.camel@toradex.com>
 <CAGNsrLD-prexjvhje6JU-PEKAeB=8-Cr+EipZWt57YCcFNSQNg@mail.gmail.com>
In-Reply-To: <CAGNsrLD-prexjvhje6JU-PEKAeB=8-Cr+EipZWt57YCcFNSQNg@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 21 Feb 2024 15:34:22 +0530
Message-ID: <CAFA6WYNVO56sUKyJ1mPK05a2Pd1R8aYisq41FOH2Psc3J4n2Ng@mail.gmail.com>
Subject: Re: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
To: Fathi Boudra <fathi.boudra@linaro.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 "francesco@dolcini.it" <francesco@dolcini.it>
Cc: "jh80.chung@samsung.com" <jh80.chung@samsung.com>, 
 "sahaj.sarup@linaro.org" <sahaj.sarup@linaro.org>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>, 
 "remi.duraffort@linaro.org" <remi.duraffort@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "trini@konsulko.com" <trini@konsulko.com>, "marex@denx.de" <marex@denx.de>, 
 "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
 "lukma@denx.de" <lukma@denx.de>, 
 "aford173@gmail.com" <aford173@gmail.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>, 
 "festevam@denx.de" <festevam@denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>
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

On Wed, 21 Feb 2024 at 15:06, Fathi Boudra <fathi.boudra@linaro.org> wrote:
>
> Hi,
>
> On Wed, 21 Feb 2024 at 10:19, Marcel Ziswiler
> <marcel.ziswiler@toradex.com> wrote:
> >
> > Hi Sumit
> >
> > On Wed, 2024-02-21 at 08:55 +0100, Francesco Dolcini wrote:
> > > Hello Sumit,
> > >
> > > On Tue, Feb 20, 2024 at 06:40:56PM +0530, Sumit Garg wrote:
> > > > Also, enable reset driver which is a prerequisite for PCIe support.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >  configs/verdin-imx8mp_defconfig | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
> > > > index 22b8a334dfa..d8bd644322b 100644
> > > > --- a/configs/verdin-imx8mp_defconfig
> > > > +++ b/configs/verdin-imx8mp_defconfig
> > > > @@ -185,3 +185,12 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
> > > >  CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
> > > >  CONFIG_IMX_WATCHDOG=y
> > > >  CONFIG_HEXDUMP=y
> > > > +CONFIG_DM_RESET=y
> > > > +CONFIG_RESET_IMX=y
> > > > +CONFIG_PCI=y
> > > > +CONFIG_PCIE_DW_IMX8=y
> > > > +CONFIG_PHY_IMX8M_PCIE=y
> > > > +CONFIG_CMD_PCI=y
> > > > +CONFIG_NVME=y
> > > > +CONFIG_NVME_PCI=y
> > > > +CONFIG_CMD_NVME=y
> > >
> > > This will increase the u-boot proper size
> >
> > Yes, I checked and it is actually slightly more than 32 K.
> >
> > > and marginally increase the
> > > boot time (because of a bigger binary to be read from the eMMC).
> >
> > That was also my concern.
> >
> > > Apart of that do you expect any other impact on those changes? SPL
> > > binary size should not be affected, correct?
> > >
> > > Asking this out loudly to confirm that nothing unexpected is going to
> > > happen because of these changes.
> >
> > Other than that I actually gave it a quick try and PCIe/NVMe does indeed work and the regular boot is not
> > affected (other than the slight size and boot time increase, of course).

Thanks for taking the time to test it. I suppose I can take that as a
Tested-by tag.

> >
> > > For my curiosity, care to share what's the use case? Do you plan to have
> > > the OS stored into an NVME device?
> >
> > For us the question is basically whether that use case does mandate enforcing such changes for each and every
> > customer.

> > Plus the regular expected maintenance effort any such change brings with it, of course.

From a PCIe maintenance point of view, I can add myself as a
maintainer for drivers added by this patch-set.

>
> @Francesco that's correct, we have the OS stored on NVME SSD.
> @Marcel wrt enforcing it, we can always fallback to have a config
> fragment for our customers builds.
> That's already the case, we fine tune the config and don't use U-Boot
> defconfig out of the box for shipping to end users.
>

Marcel, Francesco,

If you folks still have worries about updating the defconfig then I
can make it as a config fragment for mainline too. I suppose that
should work for other boards too based on the iMX8MP SoC.

-Sumit

> > > Francesco
> >
> > Cheers
> >
> > Marcel
>
> Cheers,
> --
> Fathi Boudra
