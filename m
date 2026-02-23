Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EDFEC1116
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B39DF83E36;
	Mon, 23 Feb 2026 18:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DOFspvk1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 744128063E; Mon, 23 Feb 2026 18:53:19 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 851F083EA6
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-65b94e0a875so6568230a12.0
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:53:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869197; cv=none;
 d=google.com; s=arc-20240605;
 b=LY7vWioizzfBUWr4/SqkkRGWmHjXqNoGfrvBW085Ql7k+l65dhNHz7Wqt7CO11WcWm
 UXUaHU92gvOIqy+D7+DRDLxffK4SQEYhCVdUrCOvUp1f1K+7V9Gp+aqg9NrN3v+1gGUf
 E04aGMS6/CmI27L1IonU0/BMLVSlpDZ9hRfb3nYDxFapK2jH9Pr9CVcHdb2pYs03QL2/
 XygfunIr1K+8Xg/xSbcIbJd8tZrkDcmAH2F2ifKZXx/iDMwTh9A58QLy7ZQiJ5c+dy9G
 hGWkKGDfQ69WkPP1CeRcRRlvgZBH7GnXm1QvVyDr52LmYCMPJNRDrl2BfZnkszMVN8QH
 oYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LeH03k+rYygSyhe9YCjV9eBJvQoGfNzx/iHgnPukS5A=;
 fh=ygb6jlSkAF0Rqd4RmOz+L4ilHCFQZ+jNBAF0WUL/vKc=;
 b=ZwwDgtpMAHfT9+ae4rDu+kLzXvMjpEYgHwkTJZWkhcGf6bJzKchEXXCNtZhQpKdVds
 7XiS3O4vhmOcipJxkUUOLswPoNRHso0T2kr3K9IyTuIdI2XLV/RLE9HjdBq3cQUuMxtk
 SDwzbQ+6THZw83B1HLCrBFulC359mXPLTRvdNmtD/AIKQDPGjQ9O0RzgQ4dv2jgkREAT
 aWxGD+khiUPYnt+k1vMuDQMZhXP5HvzPhXidC2SmailRFt0TQzyzeQUEaS1SS3s8qW/H
 uQ10/4q1nlgAarANXHJZvwqOHC2VUPnfbbCEo05ORJo3C6GOCsPi6TTTJTXLW1cYBh2z
 gD3g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771869197; x=1772473997; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LeH03k+rYygSyhe9YCjV9eBJvQoGfNzx/iHgnPukS5A=;
 b=DOFspvk1aC3i1hfPb6v3sspXHU4mpsuISottAV7SRhHQKO7Tr8FzmkvrsJiU8XVdAq
 XKHTWCMOdGCG6H7ldrDOdA4LnLppy/kR+o40LOvBuos6GZL2Svi72ksVryDm348tVXQG
 SRXRBNb6k+oqSWt8ftunh4qfG3VhtZDFbYaP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771869197; x=1772473997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeH03k+rYygSyhe9YCjV9eBJvQoGfNzx/iHgnPukS5A=;
 b=QVtirUFekNk4/oU/L/cMYKn60hLURD6xdftX8yBVS0Ha/i3SgSJsDhAIvCc/vh6iBg
 5zC4TQ+2t5FOfsNxJIOzLIrIedE50NCDOFnR0DARN2oa80qePiCJO0D8+pacgLqd8YaB
 NbG9gvJ/u8YUK6jgLYm+gqHXVALmAzegsl6NqOjP9jPuBi0b9VUkUobjbgzMD9tUtaQX
 RQquxt1IoOcH2vQkPrFUQvdRljudCaSwbTvZ0wo/Xtor5IVtoMcQkPwP37odRHw+9U/j
 nsTuY2hr8EQpQ5mo/Ffgq54BabAesl1lixjcY2KdQpn1e8LxHa8+4xEKzkoJvNTzV9/O
 DN8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU98qdjLMR6yNiKX093WEk06ou/KgaGTTvNmQry0tH7Szhb+13C2y/WQyt1jLu7uQwtRph2y18=@lists.denx.de
X-Gm-Message-State: AOJu0YzB+CO7gbdn7x3dD+H7meqd7nXi/4mKvOC8o60Vxz0mCUkPuEdB
 yockWLz96yAhIVu8yp9Hftn9SKGiwZSKzBQ/gFTpX3Uwc2dexhugfD51CptDtGIoPoSh24oOEeB
 XIJKnq9ioJu/1JCaQzCwOzSElVp15Xh4RFaU6EGhq
X-Gm-Gg: ATEYQzzruv88Lpq3Bl83lcIn5tuNLfBHwyjKttnntKuMxT60+er2dkMmnrLMqrITqX6
 zA2bVRGLmbRvUq2c+UGqSA9OBx+fKXQG3UGQZNXqVQZKE2tmja6XZTSLmgqB7YpVOdvZ86NoiFv
 hl7fPAWUGH9Z61zt1T7rLr0DY3qqRAlGxJz8sCnT2zTsX92Bshvadb3ny085cwXQi78Wm3cl8q7
 zItLJqQMU1syVwm7Vjz13OQQJgEw2dRdCz19EpHl//+afNaAOxaqmESgG+J7W7CbxHo8QiPLv0c
 9sk+BA==
X-Received: by 2002:a05:6402:1e8e:b0:659:3671:137 with SMTP id
 4fb4d7f45d1cf-65ea4ec5bacmr5012827a12.1.1771869196871; Mon, 23 Feb 2026
 09:53:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <bc1fb5747051cd6462bf3158250a04ea8e83b14e.1771275704.git.daniel@makrotopia.org>
 <CAFLszTjt+F00+-x0yr7i8=MpxDVgrmaJQJqNpUVTA4cd55TRXQ@mail.gmail.com>
 <aZdA2ltaV_0chTPd@makrotopia.org>
In-Reply-To: <aZdA2ltaV_0chTPd@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Feb 2026 10:51:10 -0700
X-Gm-Features: AaiRm53SE1T_DHElDbmG_rUjSfiblp-tpTYsXNcZIcbXrRphnJTMFyFl1JSfe-M
Message-ID: <CAFLszTj1UTuwsFkHDFnd4Bcm4=0xxr88+SYzRamWodAWSpxJLw@mail.gmail.com>
Subject: Re: [RFC PATCH 17/20] boot: bootdev: add UBI boot device
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de, 
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
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

Hi Daniel,

On Thu, 19 Feb 2026 at 09:57, Daniel Golle <daniel@makrotopia.org> wrote:
>
> On Thu, Feb 19, 2026 at 06:09:31AM -0700, Simon Glass wrote:
> > On Mon, 16 Feb 2026 at 14:24, Daniel Golle <daniel@makrotopia.org> wrote:
> > > [...]
> > > +/**
> > > + * ubi_bootdev_hunt() - attach UBI and bind a bootdev for it
> > > + *
> > > + * Walk the DT for the first partition with compatible = "linux,ubi",
> > > + * find its MTD device, attach UBI via ubi_part_from_mtd(), then bind
> > > + * a ubi_bootdev as a child of the top-level MTD DM device.
> > > + */
> > > +static int ubi_bootdev_hunt(struct bootdev_hunter *info, bool show)
> > > +{
> > > +       struct udevice *bdev;
> > > +       struct mtd_info *mtd;
> > > +       ofnode node;
> > > +       int ret;
> > > +
> > > +       mtd_probe_devices();
> > > +
> > > +       if (!ubi_devices[0]) {
> > > +               ofnode_for_each_compatible_node(node, "linux,ubi") {
> > > +                       mtd_for_each_device(mtd) {
> > > +                               if (ofnode_equal(mtd->flash_node, node))
> > > +                                       goto found;
> > > +                       }
> > > +               }
> > > +               return -ENOENT;
> >
> > Eek no we need to find the device, not the node. There must surely be
> > a link between the UBI and MTD in the data structures somewhere.
>
> Yes, but only once UBI is already attached. We can move the responsibiltiy
> to auto-attach the first suitable UBI volume having the 'linux, ubi'
> compatible to the moment the MTD partition devices are created, so UBI
> will always already be attached. However, that will then waste time to
> do the UBI scanning even on devices not using UBI to boot from (but eg.
> only as auxilary storage while booting from NOR flash). Hence I kinda
> liked taking care of the UBI attachment in the hunter...

OK...well from your other email it seems that UBI is pretty old code.
So I suppose we do need this sort of conversion.

I could perhaps take a look at converting UBI to driver model, but
that would be separate from this series and would have to come
afterwards.

Regards,
Simon
