Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13165C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 14:19:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 884D988BC7;
	Fri, 19 Jul 2024 16:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZEzs+K0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96F8288BCF; Fri, 19 Jul 2024 16:19:01 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC02688BC4
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 16:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ee92e3a4efso3300941fa.0
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721398739; x=1722003539; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aIdh4ReBi11nYsLT2R/wGIOuTdL/Rgm+jqOrDxui5GY=;
 b=ZEzs+K0eFOVyNLu+oMS7jhPUfYWBmZvQubXVsE6BJw/DoMBnr1FHZTScPktRPrhqrW
 FSWtPLhr4MxJX4ZbBJvCvy4CocKzkjB9ypup7Ncv4mHCTOr6/onXo+ZBlKJmztFtt7rM
 hK1ZaOdWVqM+K+6Iz+jj6FOnAStV4Q8ykMMSNxy5TMqKg8F7mOB0u5cwjPOiEjAveNfz
 GuNLJ1B9yS+Mck6gYaGiX5slcs2GnCcwUM0l9EcsmiGAs0r3+OOk18tuqXhdoRCHa7hw
 0WxR0lYM56P707FZC54JPxrDqdgFwhTo5T/26sRYVrReu7qeJTHG+nPeL5VR/G3tI9s1
 ExvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721398739; x=1722003539;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aIdh4ReBi11nYsLT2R/wGIOuTdL/Rgm+jqOrDxui5GY=;
 b=LoAwugwGgGBQ6LMCLxdGAr6KTnaDirt1sfW/E4wJYcRNx1QI30ROjA2UlfmJ7pLPIM
 C63GYc9GVv+BY1kq7s1AtOEJ0KXy3yxUUVvEEVbRevgKRM9Q7yrR02Aemiaz1HejcByt
 NdhFMuBUmVvES0m60bo4VHU78KRLWvaEvU1kkPVl2DmGy/PFOfvauYQ8m/BwzQwkD7+1
 1O5DjUSSu0XOesPnI4Ng2NHlpxQCfbRYV1Dt4VjLVTlLgtGUKwZ6wRrlszMko9q1iZyG
 yVEpVSb801QDrPdfh6odECr0KLt//6MzasH1cVMj3sIJyBINSqVch/PVvJTDXcYHM9vL
 7Odg==
X-Gm-Message-State: AOJu0YxN55hv0SM3rZozaprH2l0WPokC7TjGVVVtjD8v47jEt5AoOQVj
 4zmUxnagBX1ELagl+AzMrtBJPwhgvnevKMWkuu7ZKUc3+f6DI2hAsVaDV7ts1AOgmrkl3LRJwl7
 3glc1eoNcmAdZxLJpBsL7imWcDovz38QK
X-Google-Smtp-Source: AGHT+IF/6hP3oVTqejjdh3Ti6bF4gmam3u4RvuEWwCZsLHZeN7AMnKPOAW5MxW1+MQJQWMXfopEFmdgRxesuGqNCmew=
X-Received: by 2002:a05:651c:b2c:b0:2ee:8071:5f03 with SMTP id
 38308e7fff4ca-2ef0d8ca1c9mr11276601fa.5.1721398738775; Fri, 19 Jul 2024
 07:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240719100758.1917-1-Zhiqiang.Hou@nxp.com>
 <20240719100758.1917-2-Zhiqiang.Hou@nxp.com>
 <CAOMZO5BoEqV_h5RdLKZitt+GDwAMyV7T6jH3P=t_TnovYMEd2g@mail.gmail.com>
 <DB9PR04MB923670C9D250CCA833DA659A84AD2@DB9PR04MB9236.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB923670C9D250CCA833DA659A84AD2@DB9PR04MB9236.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 19 Jul 2024 11:18:47 -0300
Message-ID: <CAOMZO5DSq+VFCBbFLOvgmtHN_4DFsxvdKSLFP0oaF2sSAEOoOw@mail.gmail.com>
Subject: Re: [PATCHv1 1/2] mp: imx8m: add cpu command support
To: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "sbabic@denx.de" <sbabic@denx.de>, 
 dl-uboot-imx <uboot-imx@nxp.com>, "trini@konsulko.com" <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Yi Zhao <yi.zhao@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>
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

Hi Zhiqiang,

On Fri, Jul 19, 2024 at 11:01=E2=80=AFAM Z.Q. Hou <zhiqiang.hou@nxp.com> wr=
ote:

> This patch is to add the needed functions to enable cmd/mp.c, which is we=
ll known, so I don't think it's necessary to add an example to the commit l=
og.

I have never used cmd/mp.c. I see several other Layerscape boards use it.

How did you test this series?

Please share more information about it in the commit log, such as the
command line you tested, which OS was used, etc.

This is important information in the commit log as you introduce a new feat=
ure.




>
> >
> > > --- /dev/null
> > > +++ b/arch/arm/mach-imx/imx8m/mp.c
> >
> > What does mp mean?
>
> Short of 'multiprocessor', the same mean as cmd/mp.c.
>
> Thanks,
> Zhiqiang
