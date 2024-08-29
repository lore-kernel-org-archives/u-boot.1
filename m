Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6B2C83F26
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4B2088C70;
	Thu, 29 Aug 2024 16:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BsWLjvjL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E06C788C20; Thu, 29 Aug 2024 16:05:41 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 723E888C68
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7142e002aceso574627b3a.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724940338; x=1725545138; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jeht4A7g25i0DxjLUKjtVXIP0PjtrpWj47EkkgrCXCc=;
 b=BsWLjvjLDLvGLQ431AHJ/nEz2Zbb2BInxqZ38+kpnPybRQSoY2yzqtObSDlbUxAcSo
 r1WpJphvtcfZmugZc5XBhhhHmNweKcQ2T9oQO731liTeDYqM9wPIUWpPXkQ8zqFwv2OB
 X9Oq4W0W57JLGe1NObV3F+fjY4edebT6SBW7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724940338; x=1725545138;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jeht4A7g25i0DxjLUKjtVXIP0PjtrpWj47EkkgrCXCc=;
 b=nqEm4e0AN+1058IcFtxupfAG0zZqZALsWcL5amnRyEFixiVxa3EubgnZLYa5bCaOlr
 eRBso/CiuM7+phgdGynYlHALkEp9TY9Wm50lMHAjJkHymqfUoO9EX8dbLiB106bBIJxU
 H/vt5uRDDgQ+WTh1Rgug579AZXDTn+Lf/vLGTBuvYl7NVLFt/QuTq7obK4BQGZ8wlS3k
 JjSGx+wPVYbfrgShSFu5rPcGhDF20Xh8j/vFR+GK5PtkgMHLYUwJy5oOogtsrlp1GmZt
 1rUcWhibIEwvNNOqk/WlnqwPwmO+rZLJuFcjUXm1ABQhgufyiBYXNQXD+RrUHP3HHFIR
 wQbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/1nbR15wEEvJr3UsErUg4lrKmjXp63eBJDNuYs1xmcIJ/bh/kuNQmDa5iX42xh+k76IoMj48=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+Vp/hsogiy1rAKZ3iSIjldM9byOImTzoeb1cetr9fGP/JN+bw
 bdw+n7XBI+/qcZ/eAT7DTLoJAra2FdcMBJFBf3uI3xrIfP9E/CegR2be3tHaWEtUL24fGgGKlWF
 +7TILhqLP37zB8WDLZFCFyNWmyt4ThvkmbTLt
X-Google-Smtp-Source: AGHT+IEctqA8z9+aQe7xRrhvD5quUZU6FgCcHlBfogtQtVsDS9jYLBJL9xjBDmWJG2D1URAcPs3TpYaWUdPfe1smK+U=
X-Received: by 2002:a05:6a00:218e:b0:70d:265a:eec6 with SMTP id
 d2e1a72fcca58-715dfb6950amr3312544b3a.13.1724940336864; Thu, 29 Aug 2024
 07:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240521104834.11295-1-marex@denx.de>
 <CAOMZO5DsyuCu+fjpa8GjB6mbp9b5n=YOGxtjgMkdSstGFmEUuA@mail.gmail.com>
 <CAFLszTiwqcPe98gwbt1oVnWYJ0yFQ6rTpdcrB2kw=YRH-9=JJA@mail.gmail.com>
 <CAFLszTg8UHv7WbYKMii_8_6m3m3TR0BCAaEVNWnQJb2otQRScw@mail.gmail.com>
 <d46433c5-f4a6-418a-bc23-1ae5ce6ba63a@denx.de>
 <CAFLszTi9wozfMHVwM-tg5bJGSwSOpreR=D3jardm8z=N621bng@mail.gmail.com>
 <01cf8243-3476-41a8-9d56-bdd2817a4569@denx.de>
 <CAFLszTheX=pbcZZR6dnjgvpg_KzvPUKRk3nC8UeFc-868G9tUA@mail.gmail.com>
 <77bd148a-c80e-4d09-b8f0-93c2b8f963f9@denx.de>
In-Reply-To: <77bd148a-c80e-4d09-b8f0-93c2b8f963f9@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 08:05:08 -0600
Message-ID: <CAFLszTik7Tc86BhyuRj1=BX5vMh7r5X8D3Yjot2kDdjrDEdwpg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] binman: Add nxp_imx8mcst etype for i.MX8M
 flash.bin signing
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 anton.gres@ifm.com, ch@denx.de, Tim Harvey <tharvey@gateworks.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, 
 Tom Rini <trini@konsulko.com>, kernel@puri.sm, u-boot@dh-electronics.com
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

Hi Marek,

On Sun, 18 Aug 2024 at 14:51, Marek Vasut <marex@denx.de> wrote:
>
> On 7/9/24 11:24 AM, Simon Glass wrote:
> > Hi Marek,
>
> Hi,
>
> > On Sun, 7 Jul 2024 at 01:55, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 6/27/24 10:19 AM, Simon Glass wrote:
> >>> Hi Marek,
> >>
> >> Hi,
> >>
> >>>>>>>> Add new binman etype which allows signing both the SPL and fitImage sections
> >>>>>>>> of i.MX8M flash.bin using CST. There are multiple DT properties which govern
> >>>>>>>> the signing process, nxp,loader-address is the only mandatory one which sets
> >>>>>>>> the SPL signature start address without the imx8mimage header, this should be
> >>>>>>>> SPL text base. The key material can be configured using optional DT properties
> >>>>>>>> nxp,srk-table, nxp,csf-crt, nxp,img-crt, all of which default the key material
> >>>>>>>> names generated by CST tool scripts. The nxp,unlock property can be used to
> >>>>>>>> unlock CAAM access in SPL section.
> >>>>>>>>
> >>>>>>>> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> >>>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
> >>>>>>>
> >>>>>>> Applied the series, thanks.
> >>>>>>
> >>>>>> This lacks tests - can you please add sufficient tests in ftest.py to
> >>>>>> get the cover coverage back to 100%? Please try 'binman test -T' to
> >>>>>> see this.
> >>>>>
> >>>>> Any thoughts on this, please? At present -master is broken for one
> >>>>> file and -next has three problems.
> >>>>
> >>>> It is in the pipeline.
> >>>>
> >>>> What exactly is the error you observe ?
> >>>>
> >>>> When I run binman test -T , I get a lot of output, but no error reports?
> >>>
> >>> Sorry I somehow missed this email.
> >>>
> >>> The tests are in ftest.py - there are lots of examples, e.g.
> >>> testXilinxBootgenSigning() - commit d8a2d3b29
> >>
> >> This seems to be testing some out-of-tree tool , not binman ?
> >
> > It is testing the etype, which needs the tool to be present, yes, You
> > can use 'binman tool -f' to fetch tools if you want to try that one.
>
> I'm not getting anywhere with this, can you please draft some example
> patch how the fix should look like? Otherwise, this is not going to move
> anywhere I'm afraid.

Please see [1]

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240826191143.426387-16-sjg@chromium.org/
