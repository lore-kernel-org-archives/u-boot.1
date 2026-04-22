Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3A4F94CA2
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 01:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E0B18352B;
	Wed, 22 Apr 2026 03:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FZw+f6n0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC7C83936; Wed, 22 Apr 2026 03:15:40 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DCA7805D7
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ba388bc0a9dso862242566b.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:15:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776820538; cv=none;
 d=google.com; s=arc-20240605;
 b=ctyWg6jSx5VqJVautKHnMr1VtoEaHHxjpMoc6undkra4qcik68BUN0uFpj8Thh7hLd
 rzrCf53xheYD5E1/kgGhMRVo5SJ85wk3J65t9mpx4Uvw43nz4Mcp/JCZko7sO/e/Fpbo
 eKHCsAiDqWwLIO3cyl6llZW3lnQ04U4OwO+J8WDaFEMH7Q9BYntseqLsfdqbJo2rdGXF
 BVrDTmtGHEGbZR3gDgetq4rzT9JoInTxj2vnVjPKpu6mTg/FWCQHcobZ3XGjEzwWEs71
 O1oXiv7yr+VmlTE/Em10utZX4OuiixrUHtkAgm0y1q+iO+4CZH+1OBNUsZt31kWWIjLc
 W5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aQSBj9GePW4m8+YtFnhGBu/oV78RowWKh7JSpztXOwU=;
 fh=ibZ1bkE1t7H2imJ5Lr5OXbwa3fw45+i+cdGXaLwSAQg=;
 b=CxOTCm0qWrVuDeqNYb1/vSjl7deNOkeO1jJYnhbDTOvt04rtB2fGbnFpCE9vGti0Gr
 pl2JhgKw8XJlyeB3zcKdPxIWA85d89I5NFo1dggs9WzlYuFlU6o6R9fl0Bi/mwIPXxK6
 Dn6aCrd8KsprAniNQA4zcM1EGim+Al5T9/DWIKTCS8e5SMKY2K5QsQS2BQMWKVUJr96p
 Jij2lI6shGBc39glD255AL9VL39oze20ZDbgdDx5ke5XMwQEDYCrYco1nXHWyMop3dcj
 sHyLZ8mNjbmchcP99v0sRzu58YZ7M4UqvuioZyWS6CoLi1FDggAxWRu9QFeaeUlqNqww
 p5Hw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776820538; x=1777425338; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aQSBj9GePW4m8+YtFnhGBu/oV78RowWKh7JSpztXOwU=;
 b=FZw+f6n0yCmoq93UtBc1+Q3C7HG9+61/EqZIPD5WyVVTm+5VXLpyBx1qBS9woej6mA
 +D06SHzmiqYsnikGbl4los3dJMw90xk2sYPKx0h6jqW4uEBhFqOshgd+7vGQioCH0E2T
 2D4+N13yKUf2LAEk4iA7uU/PDcmSGARF2MvYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776820538; x=1777425338;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQSBj9GePW4m8+YtFnhGBu/oV78RowWKh7JSpztXOwU=;
 b=J2qFDC5RQ34jCfoeGtT3lNFLAXXIN6Sc+17p9Ch3sa8L25u8k6NAu1PpTJEcblySRD
 i7Wm3Nb4ckOjlYOTilL7ohOq5IJlwCiXbSvwOgGkqYPdAoiJBDWGsHWSIEaouI16VpUp
 yskpP61d/JhfW3MJcj9GhCBHsImJQsnsUIoEAP88Nl2uKQMGUqJYbKMwUhcUtBFyr+Fh
 4jYN1+l4GNA+NWPGutvBVIWFfvQUYSfT5M91BtZKvP46858/kcfXjJ+E62/RaCNrm7PS
 z/fOn8hFZmrguCzfntrmFCsfvgikN7lJ4ZHwcTuIffWy4Q08OG2kKy+4cQ6uZmT8virP
 Dldg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8Uy3xph61uziD7XbUNa0A1SzVb8rgFDXsokBEiqasqgB6+TULbcFMfHpINd71bq7FySlxqV4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5+B0s+lCteqeego+bwEq/2ngsFv5v5ohYVfa4U3JfhJLlNsDx
 M+IWjqQ39VWojEMo6fyjgkL30c8KJDriGYMZiW93GeALciQhUXT55iJG7l/v6Af3NQA5BCa5vOg
 0U9/eGxlJLUnZwNn0u/Y0ibM7WQtm12fBoAepwjlv
X-Gm-Gg: AeBDiesXd+jCK/PMGOEHPuP0fs/ihdFqmq0/JbQUX4I2ix1fJoQXAcDTDaG7vXc7TUg
 spaM1jb9TZX4lMvx1gw3+uWgNDAeM1/HuptBL/z7FXCCPlv53LeDH6HQakffKNmyMNL5uAIvinT
 1YTNh+WuyBMXR8/L0kLtTApi5MW8N2JFV6zoxblrdgNCZMQGfaha4Oxau3paHohULPAZz8mTatZ
 ZHSTJaSBtoPxi/ZiFaaLPF4hWx9E1s1xsYE8Af/f8g/B97SD0+7VOVWfHW5LPyrQn9bHBJ1BjYF
 OMUkDhY/X5j0gTgvYjUSitRozTBOKCU=
X-Received: by 2002:a17:907:c9a2:b0:b9c:b475:90f4 with SMTP id
 a640c23a62f3a-ba41aa1373fmr738861666b.29.1776820537790; Tue, 21 Apr 2026
 18:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775121078.git.simona.toaca@nxp.com>
 <7edcce04b39aabc1f58e09814e7fadff226e2bb8.1775121078.git.simona.toaca@nxp.com>
 <CAFLszTgb5a3QtyviHc-MRTdDUoDUWnYksWXMeCUxagHmvfQK2g@mail.gmail.com>
 <mtfbgewm7kw4jzmxjkksdmq2ahb3mdrb6p5bi5qvpow2tydyl7@bejuojige3bw>
 <CAFLszThADHGE_8aAFExK8Kv_Ef9LG5Xcio=znkNwFH-eUESzsg@mail.gmail.com>
 <bele5ekkryruhwzvnnp3irwsapcsqawt4a4fy7g6cmdoifwh4y@37ov46b26o3t>
In-Reply-To: <bele5ekkryruhwzvnnp3irwsapcsqawt4a4fy7g6cmdoifwh4y@37ov46b26o3t>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 13:15:24 +1200
X-Gm-Features: AQROBzAXn0yY4U1yBk7z_X3sp9yBHcmz-zNXFRo6890WgjiVS0JZK_AcmV4keBI
Message-ID: <CAFLszTgwhL3KKS1Bi3uy1RXW+CBU910L_My-=0XFxzF_2gnYWQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] imx9: Add support for saving DDR training data to
 NVM
To: Simona Toaca <simona.toaca@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com, 
 alice.guo@nxp.com, viorel.suman@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com, 
 ping.bai@nxp.com, marex@nabladev.com, sebastien.szymanski@armadeus.com, 
 ravi@prevas.dk, joao.goncalves@toradex.com, ji.luo@nxp.com, 
 semen.protsenko@linaro.org, tharvey@gateworks.com, qijian.guo@nxp.com
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

Hi Simona,

On Tue, 21 Apr 2026 at 01:41, Simona Toaca <simona.toaca@oss.nxp.com> wrote:
>
> Hi,
>
> On Tue, Apr 07, 2026 at 12:13:51PM -0600, Simon Glass wrote:
> > Hi Simona,
> >
> > On Mon, 6 Apr 2026 at 02:28, Simona Toaca <simona.toaca@oss.nxp.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Sun, Apr 05, 2026 at 05:49:56AM -0600, Simon Glass wrote:
> > > > Hi,
> > > >
> > > > On Thu, 2 Apr 2026 at 03:29, Simona Toaca (OSS)
> > > > <simona.toaca@oss.nxp.com> wrote:
> > > > >
> > > > > From: Simona Toaca <simona.toaca@nxp.com>
> > > > >
> > > > > DDR training data can be saved to NVM and be available
> > > > > to OEI at boot time, which will trigger QuickBoot flow.
> > > > >
> > > > > U-Boot only checks for data integrity (CRC32), while
> > > > > OEI is in charge of authentication when it tries to
> > > > > load the data from NVM.
>
> [ ... ]
>
> > > > Note that this feature is present on x86 boards already.
> > > >
> > > > I wonder if we could make this more generic? E.g. it could be a
> > > > function of UCLASS_RAM ? I could do the x86 part to try it out if you
> > > > like.
> > > >
> > >
> > > Can you please point me to the implementation for x86? This Quickboot
> > > feature is specific to Synopsis DDR PHYs, and the location where we
> > > save this data is specific to iMX9 series (since it is needed by OEI).
> > > I need a bit more details about what you mean.
> >
> > Yes, if you look at mrccache_save() you will see how this works. It is
> > controlled by a flash layout within the SPI-flash node:
> >
> >  spi: spi {
> >     #address-cells = <1>;
> >     #size-cells = <0>;
> >     compatible = "intel,ich9-spi";
> >     spi-flash@0 {
> >        #address-cells = <1>;
> >        #size-cells = <1>;
> >        reg = <0>;
> >        m25p,fast-read;
> >        compatible = "winbond,w25q64dw",
> >           "jedec,spi-nor";
> >        memory-map = <0xff800000 0x00800000>;
> >        rw-mrc-cache {
> >           label = "rw-mrc-cache";
> >           reg = <0x005e0000 0x00010000>;
>
> [ ... ]
>
> Sorry for the late reply.
>
> By 'UCLASS_RAM' you mean having a SoC-specific RAM driver
> (e.g. 'imx9_dram') that implements 'get_info' and a set of
> methods for training data check/save/erase?
>
> mrccache does not have the checking/erasing option, but it
> has mrccache_reserve/mrccache_get_region public methods that
> do not have an equivalent in quickboot.
>
> In this context, it feels like the exposed methods for dealing
> with training data do not have a unified interface, so in reality
> the only common ground is the 'save' method, and that would also
> need parameters for specifying the boot device to save to (as this
> is an option in qb, but not in mrc).
>
> Also, because you mentioned the SPI flash node for specifying
> the saving location in SPI, this wouldn't work for the i.MX quickboot
> implementation. The saving location is a space in the bootloader
> that depends on the other components' sizes, so it is not a fixed addres.

Yes that's what I mean by uclass RAM. Yes, at the moment it does not
have methods for caching the parameters, but it could be added.

If you have the energy and interest to design something here, please
do. I could convert x86 over to use it.

But it's up to you.

Regards,
Simon
