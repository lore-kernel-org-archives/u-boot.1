Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10494C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 06:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66C8287FE5;
	Wed, 21 Feb 2024 07:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W48UBYm1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0418D87CC1; Wed, 21 Feb 2024 07:29:31 +0100 (CET)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A118C87E26
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 07:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4705496ac55so679392137.3
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 22:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708496961; x=1709101761; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1Nr4HhnOaEXY3WZN0AXrn87Cr+Y6uBUUcRmGNQrmjo=;
 b=W48UBYm1qAqzUqc0g2+T0YeaOJ90u4AVwyLsOYpqOmRR85jiFl1w2lVlhwN437RF1o
 gonLbEERj9FHE0pcPJ2tl9bwGdcxwOcSKhbXDpLN07xLobzijQ8EFFj4Os4LjvVRyfiR
 XNVmi4Q/Q9fR+7zJQTspeJ88K+WLzVkfcyVlP5AgWVFQTFGHiLq89VS9LWhpn7F9DwbD
 hYamXoxKgVDVu4f46qR43nIPys3U+aozNokPQWLP9c6HhDw4ScBkoprF+tzyQWnTRCns
 SHtm2EsdSLgms1OSgL9NR4jBWOpf1H6Gy7YuEIDnGDuU9u88sCzD1E50gmpyrG1QAr0V
 29WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708496961; x=1709101761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1Nr4HhnOaEXY3WZN0AXrn87Cr+Y6uBUUcRmGNQrmjo=;
 b=Wtu7lc2h+DYX3BJlcyizWdpNQgPLlXO2sQ46QeK3uUYSn5bnnt14fmIFwM/0D6cf/V
 nMrHHjzuN10JJTFKw3VE+UZAFvJIGeuCjS3kVBo8elGgcqzPzOTkU0knMTsySJQM28an
 Iws3/zf/FPK3gHgOkCFGCu5VXPU9bPIZaqi+s/OZ804mBNRbZCb2HxLiFR/IuNzi0gVA
 mHA4Hm+Mfy6TuwBTJccBdPk9ijUchFrZ4Zk7PLVxNniIqomwETnRVH4rtCE1bvqqDO8n
 xkgORQaweFA/DNBiaortfwkNci2DO3SW8cSyW0WBiY5IfbHAe83mPgCyR16n6re3ayln
 kbFg==
X-Gm-Message-State: AOJu0Yzw82vmupiXW6hiMTj25M2SMgLgSQigJY1KF1hfsEQkAtNQud4/
 17z7ZnfWAEbQLusn01eLWKvaN+akaoJa8CnNBKMp2snw2jxDrfF5ROGuittkfF+xPjG+oE9HpDV
 EtlmE5+NN1sfhkRcuPAI/cJEhfDQsBNkt5I9AXA==
X-Google-Smtp-Source: AGHT+IFQrkzp50dEPdvxJnaCQY/vlf+HsesuLgtFt0lzlEhxek92YIE4bWzxqGHiFMCj/nlu1Kljil52jDRUoerSFFg=
X-Received: by 2002:a05:6102:5489:b0:470:6d54:5ef6 with SMTP id
 bk9-20020a056102548900b004706d545ef6mr4964178vsb.27.1708496961379; Tue, 20
 Feb 2024 22:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-8-sumit.garg@linaro.org>
 <CAOMZO5DXgO_etRG_FKJKwyEzUkKiFm=ZuiztxNcRQ4932N6CXA@mail.gmail.com>
In-Reply-To: <CAOMZO5DXgO_etRG_FKJKwyEzUkKiFm=ZuiztxNcRQ4932N6CXA@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 21 Feb 2024 11:59:10 +0530
Message-ID: <CAFA6WYNOb0HyTC3gC1FE+=A=foV4OdjXvRM25U_n5WO53rkV6Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, trini@konsulko.com, 
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com, 
 aford173@gmail.com, marex@denx.de, ilias.apalodimas@linaro.org, 
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
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

On Tue, 20 Feb 2024 at 21:34, Fabio Estevam <festevam@gmail.com> wrote:
>
> On Tue, Feb 20, 2024 at 10:51=E2=80=AFAM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> >
> > Also, enable reset driver which is a prerequisite for PCIe support.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  configs/verdin-imx8mp_defconfig | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_de=
fconfig
> > index 22b8a334dfa..d8bd644322b 100644
> > --- a/configs/verdin-imx8mp_defconfig
> > +++ b/configs/verdin-imx8mp_defconfig
> > @@ -185,3 +185,12 @@ CONFIG_USB_GADGET_VENDOR_NUM=3D0x1b67
> >  CONFIG_USB_GADGET_PRODUCT_NUM=3D0x4000
> >  CONFIG_IMX_WATCHDOG=3Dy
> >  CONFIG_HEXDUMP=3Dy
> > +CONFIG_DM_RESET=3Dy
> > +CONFIG_RESET_IMX=3Dy
> > +CONFIG_PCI=3Dy
> > +CONFIG_PCIE_DW_IMX8=3Dy
> > +CONFIG_PHY_IMX8M_PCIE=3Dy
> > +CONFIG_CMD_PCI=3Dy
> > +CONFIG_NVME=3Dy
> > +CONFIG_NVME_PCI=3Dy
> > +CONFIG_CMD_NVME=3Dy
>
> Please don't group all these new config options at the end of the file.
>
> Use 'make savedefconfig' and then 'cp defconfig
> configs/verdin-imx8mp_defconfig' to properly
> add these new config options.

That sounds better, I will do that for v2.

-Sumit
