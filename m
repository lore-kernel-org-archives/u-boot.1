Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7146C71130
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 20:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C350831E4;
	Mon,  7 Jul 2025 22:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O5Jq2VDc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CD93831C2; Mon,  7 Jul 2025 19:03:53 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16FAA8318E
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 19:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e7dc89108bfso2944704276.3
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751907830; x=1752512630; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqhvfK3Ne4vket1167fNWBwNJTq5WB04BU58VsOLG+Q=;
 b=O5Jq2VDcSSaXJdhgQwqa/xCmWxQBk0WUvL2w0AMxIPbaQWXRH56gqsgksxUAdY3bkr
 Y//udt8TTuliDHdThmaO6iWIyksAaNowmt6FNb8Ww6Ml4uBSKGQ0Hu9g1Lc7xwihQrVE
 HXgo6T1Bd0+BqS41t53vJHh9Q7eXEDJNQPZhcYYJtkP8TsB0r2oLiTyj5a9TmseSmH74
 ELaWe4HEWdDIZJEFIYYUwl9wjWVYEwVsxV+/2WUw5p3hlMDNWdgDl0mvNG0Ftg0KyONr
 4VoVvjI/gTfGowDlwAXeyj1Vg4fymprS5Z+mO33gsGMw+jcwMPyaJvN2kDf/MkJeF17K
 OyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751907830; x=1752512630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zqhvfK3Ne4vket1167fNWBwNJTq5WB04BU58VsOLG+Q=;
 b=FzqKfyjT60LK32LjFBidwm5sWuk5bFPKNBSgpWBTaIAX0RsOGPrVxf5vv0O9ACMKDl
 IgGr69VVt6azo+V7XsLnl5NlMoJHoc3wbgUDk7dgssNv1qLC1QiMaVvsDUdLKflzGuwD
 EY0xgWpfty16tTWjNaUj7ATz1iV/0NlN0ElulM2NAbYGcEEog3SQGUn/3wNemB3Z6fXd
 I1IXj8p8c6JgNGaPZYH3hpOhf+vrH1wMSNTzmrKr6itJhy0Dpht8oF94f3E63lPWQ+8W
 kWN6DElzpH+RgrlPjdWyRWWGGUyH17wGt5IP67dCJRBvTfmOjmY0crzSTbIs/120p3C7
 gTpw==
X-Gm-Message-State: AOJu0YzPcOWNr7ZdKz+iB1iD8lRMak7IEHZHrG/NbP6m2WwcS7x8wxGi
 uKTbt+oAu0KD+esX/4fm7nDETFPgaNzDlF1r446n6EezZe6gelQsBHQQ9P9kQhzT8y/kS9APGs0
 N+253rEb74vEMgkKV2HVNdIY7pRQG7mm8ub6c
X-Gm-Gg: ASbGncuHMm7tDlfsExzgoxCVmxiTweFrINlERtmEIetbLwNDNCB/MYCuyDzMtLq5Eiu
 ZcX9fnKb2NLC8EUvc3197/NbrzAOOY40cgfq3XkGcqIJxkbpZ5XSgtpdqHTE6s0dTPiBmSAmME8
 AbIEa5lXd6o6/whb4Q9kHru33g4skaaWkZp4JV3XwUhg==
X-Google-Smtp-Source: AGHT+IE3j1SjjJJ3MtwXGANMeXlRsAhnsnSG+NKDEPZwwh15geogFJyU3txJH3PVp0DrNDRP7TNHuCuWOrg90bH74FI=
X-Received: by 2002:a05:690c:62c5:b0:70c:bd93:452d with SMTP id
 00721157ae682-7179e398a62mr5009737b3.15.1751907829513; Mon, 07 Jul 2025
 10:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
 <175180136965.86839.10195243856147148306.sendpatchset@1.0.0.127.in-addr.arpa>
 <0e525790-79f7-4653-808d-137c1e55ed09@mailbox.org>
In-Reply-To: <0e525790-79f7-4653-808d-137c1e55ed09@mailbox.org>
From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 7 Jul 2025 19:03:38 +0200
X-Gm-Features: Ac12FXwd9U3lrYemWJRiyt4eqqLlEw8BzcX5NI-ILD4MMfd0Aj0bCbMUWgaJMsE
Message-ID: <CANqRtoQUCmwfYF80KqoBSSYbhzJmR0488R6+zJFxBTyGYXLcwg@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] net: sh_eth: Adjust RZ/A1, add RZ/A2 support
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org, 
 Chris.Brandt@renesas.com, geert+renesas@glider.be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 07 Jul 2025 22:10:31 +0200
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

Thanks for all the feedback.

On Mon, Jul 7, 2025 at 5:52=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.org=
> wrote:
>
> On 7/6/25 1:29 PM, Magnus Damm wrote:
>
> > +++ work/drivers/net/sh_eth.c 2025-07-05 17:45:07.333754799 +0900
> > @@ -144,10 +144,10 @@ static int sh_eth_reset(struct sh_eth_in
> >   {
> >   #if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
> >       int ret =3D 0, i;
> > -
>
> Does something like this ...
>
> if (!device_is_compatible(dev, "..."))
>
> ... work instead of the ifdef ?
>
> If yes, it might be even improved into dedicated function:
>
> static bool device_is_rza2(struct udevice *dev)
> {
>    if (!IS_ENABLED(CONFIG_RZA2))
>      return false;
>    else
>      return device_is_compatible(dev, "...");
> }
>
> That should be compile-time checked and then optimized out, and in case
> of non-RZA2, this should be optimized out entirely.

While I'm all for trying to clean up the code, unfortunately I don't
think only adding compat string handling to RZ is going to help that
much. My apologies for prodding with DT in the SCIF driver for RZA2
only. The same thing applies there in my opinion. =3D) But we have to
start somewhere, that's for sure.

By the way, did you see the #ifdeffery and the compile time constants
in sh_eth.h? Also there seems to be a lot of overlap between
TYPE_GETHER and TYPE_RZ.

My first take on cleaning up the sh_eth.c driver would probably be to
dive deeper into the offset tables (such as sh_eth_offset_rz in
sh_eth.h) and convert the code to during runtime use the offset table
to determine if a register exists or not. That would take care of a
bunch of TYPE_GETHER and TYPE_RZ differences and remove some #ifdefs
from the code as long as the offset tables are correct (which they
don't seem to be for RZ so those need to be validated as well). Then
perhaps add some feature flag to handle corner cases like
'device_needs_polled_reset' to clean up sh_eth_reset().

And during probe() or U-Boot equivalent then using the compat string
detection mechanism to select appropriate offset table would make
sense to me.

What do you think? This seems like incremental cleanups though, not
neccessarily related to RZ. I am happy to clean it up though, if you
think it would be helpful.

> > +#if !defined(CONFIG_RZA2)
> >       /* Start e-dmac transmitter and receiver */
> >       sh_eth_write(port_info, EDSR_ENALL, EDSR);
> > -
>
> [...]
>
> > @@ -722,8 +726,11 @@ static int sh_ether_probe(struct udevice
> >               goto err_mdio_register;
> >
> >       priv->bus =3D mdiodev;
> > -
> > +#ifdef BASE_IO_ADDR
> >       port_info->iobase =3D (void __iomem *)(uintptr_t)BASE_IO_ADDR;
> > +#else
> > +     port_info->iobase =3D (void __iomem *)pdata->iobase;
> > +#endif
>
> Can the base address be pulled from DT?

Actually pdata->iobase comes from DT. Currently BASE_IO_ADDR is not
set in sh_eth.h for RZ/A1 and RZ/A2. In such case the code above uses
DT to get the device base address. Other processor variants still rely
on the compile time constants. And good news, as I wrote in some cover
email, this driver is with this patch known to work in multi-port
configuration since RZ/A2 GR-Peach is using ch0 with MII and RZ/A2
RZA2MBTC is using ch1 RMII. The configuration all comes from DT.

Thanks,

Magnus
