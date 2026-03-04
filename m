Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B9CEFCE44
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 20:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 419A5838BB;
	Wed,  4 Mar 2026 21:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SpHGFsY0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91CE183D8A; Wed,  4 Mar 2026 21:24:49 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C0283642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 21:24:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9359c0ec47so790701366b.0
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 12:24:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772655887; cv=none;
 d=google.com; s=arc-20240605;
 b=IWkPhFB2hzowjNX5eFLRYwJyLgyykrqaYkEc5pSzSIvgbj1uT6+mxYXRRNHWbVDHpA
 i0RsrqPMrMLge5KPttZWLP1xLWE0jiEX2Szb1meEZ7HY4HU1OtwBIXptVmae8U8vcs9x
 LSTHka8MhtyHV/YsM/BtwRhYHBmHEf9m/29neTlgRqj9ywZZBZx4jFm3rJBD1WXcItHO
 K47tTWCtaZ6OGJXEER2KxkNE0j7iAqUDsRfZSbDYJCWQ/Aqn17wyELD0xgUDFjgLkKRo
 3PEXk2s7LTbHJyF4QEaBRCp5tbiGW+vrvpKiYd05JaehDQnAAHAFJ9DXs9MdMiaHrxq5
 IjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6DuzNvm7YAiv3VaFliNJsnXwtVneNFL8xiYQI39XveA=;
 fh=QboySXJXsW0tZFJwNBjG2DvEsmNlfTgj+KDYRxkLN0w=;
 b=JgOxDQHwqeQu9/3Eb9GNzZO1riVEjxdPh99FIzSine/3BGd4UmB+dbitcFNHNqOAxe
 UbmI8GMZgSWFT4HqPY90tExQlrbsl0pyJq3U1NDW4mMVUHyrrCr/AqfLRJZX1HSdZi4i
 CCDxkXjkbIAP/0NPa7AJ6vbZEsTEmT3MgZROndxqrnID/jeouOEdI42tOgPdjYqFE6Nv
 w1f35N3CHf0YcAz5DqJQJFICcHphEzCj3UsEsMX/lmoOUsD6FL8gaZZwwJxF05osWy7+
 njyyQuJjnd2L+mPJJD9uzFU+ltU8+s1pjNKzPSWnwZfV8JCPGOTd9+GKAUm6Vrj3cHZM
 9DXg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772655887; x=1773260687; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6DuzNvm7YAiv3VaFliNJsnXwtVneNFL8xiYQI39XveA=;
 b=SpHGFsY09RlT1EKcwUlDTOxJ6uzrn5lZEDHxC2a51eSBWj1PRNPY/BuIA4HpkQ7Xll
 snbr1H8dzQqn7noH1+AcWZGvGnuiV6oDeeTods7uOAf/Z6noNDDf4D/pS40rvMrsvuv3
 W+FK3LZIhm7Px9Dz3O+6RYqifMxUy13fCaTD3Yr9kSOkA4kP6AWYIdx7Eyh0h00ntwv0
 +JQgo/xGxd53bn6QlE7PHFSCBgP4onCiWrDaCbGgJNlqqA67bL/D890OVNVqAWWdKmK2
 viErJm+v++p1rqXHgyMRWo+QlmF8CF9uFwiJsS4AV0qY6AKPfd5/Tpxv8rqv/sLhIbT1
 oGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772655887; x=1773260687;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6DuzNvm7YAiv3VaFliNJsnXwtVneNFL8xiYQI39XveA=;
 b=Mpt+Iah4K9HpmWuA1TOsvxVDj78iwquJR0B8uPtvCgY8qgLiCJrjB3ZbO29WwwLdpj
 sxCuHxbERHhJHKlznRbzf8sfbDf4hb6sXM2u3BSiV1D9Cdf6C1Ttb/OiKN/W/lhaPg3/
 cYwdPwEwtl/pPAGOUxbjAhpRkEqI8ubMnyDIwFTiSjm9kiOt15AU0Gh2X0zLWQnNucwd
 qxHck9M7p7lE8AAWLgaPSaULZz6JB1mp4uxGQF8PwpZoFAgq8/xk88kZmZeX6/5L33+E
 zgI2FmEg8vBbCMlOPCzzd0O7Ob4kZhT0uMvLekEe/tzgoTU9EHaVibOvD2SE2ctzpI5z
 gd9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQDBH1npURvb9TuTGkEka+/JsL4aYS+k/DyUG68QfEs0BgaOxjhuYzX1+JRIfiVYIqgCNn6i8=@lists.denx.de
X-Gm-Message-State: AOJu0YyjKBoWCm3rHRQaOqPmQy18vhvm2sDnUJfh3gyElgxDUnUcs9O+
 kYxqfODYeuiiMthY1U/ttZKVrKnwSq8PvnNPFqhsQkhOCktJDykK/7ai3v4OdNNHvLEzM8LIVRt
 0+0rbNokrIVYkJY2h2N3f3N9YOWRWhUk=
X-Gm-Gg: ATEYQzyk5lhzz2OFAcePIVEtW+UnhPV72Nt0UPV20d+AQ2DunHytDd0Wcu6gFuA652U
 EYBvtTEPVXRWfe3d1a9nVn2u95ULv02FcQXlY9EIghiTE/xSyz6VxrDnhrloyP+QiJzINJAK77x
 c5pQ8q5TDyKhZl7FKwQtEhk3dDVhzb4x2f0ysGgj5OKZYPfojmPm/Igcls/EB/IXRLYT/60t7tC
 L4emn9HYyElC6DmmGvpLudW9b2FPVWW3epp0fY0rZOf1pAyn4bggXgzxzf8mr7tyND0x5Imw+rG
 snPQQhiX6rQ1k0lxAlvwInJJq33EtPS8Ykt9FtGh3QvTR8BJMBRO2h+rNpnTMycD4zsnfYleFIc
 BckqAyOWYvbeaowNnX0gIkmfGqwfdbzBhMOkpcehMEhBYvPec
X-Received: by 2002:a17:906:dc92:b0:b8a:f61a:edf2 with SMTP id
 a640c23a62f3a-b93f1453438mr204818266b.50.1772655886472; Wed, 04 Mar 2026
 12:24:46 -0800 (PST)
MIME-Version: 1.0
References: <20260302135940.550e6051@rocky.lan>
 <20260302164256.29af9995@rocky.lan>
 <khr5tpfjql6l5ide644d7x6v2km6m3u4jnlbxq5zsbqefui65i@dlwpybwg3fym>
In-Reply-To: <khr5tpfjql6l5ide644d7x6v2km6m3u4jnlbxq5zsbqefui65i@dlwpybwg3fym>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 4 Mar 2026 20:24:35 +0000
X-Gm-Features: AaiRm50aIihkt1JfZ6mxe1IXYcnA9Ee7vAG3yn_CV6MNJRtq4RBW9HSAUDeIOQs
Message-ID: <CALeDE9NK_KvEitadfcYJQXe7bjoM7JRH3gAh0UzrjtLyUjJjpQ@mail.gmail.com>
Subject: Re: [hack] help U-Boot find the correct PCIe inbound offset for NVMe
 on Raspberry Pi 5
To: Pedro Falcato <pfalcato@suse.de>
Cc: Torsten Duwe <duwe@lst.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>, 
 Andrea della Porta <andrea.porta@suse.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Wed, 4 Mar 2026 at 19:43, Pedro Falcato <pfalcato@suse.de> wrote:
>
> Hi Torsten,
>
> On Mon, Mar 02, 2026 at 04:42:56PM +0100, Torsten Duwe wrote:
> > On Mon, 2 Mar 2026 13:59:40 +0100
> > Torsten Duwe <duwe@lst.de> wrote:
> >
> > > This proposed patch uses the already existent dev_phys_to_bus(),
> > > which can dig up the correct offset from associated DT nodes and
> > > subtract it.
> >
> > Just to make it clear, that patch is a necessary but not a sufficient
> > condition to boot the RPi5 from NVMe. The PCIe bus node above
> > the NVMe is generated dynamically has no DT node with dma-ranges and so
> > dev_phys_to_bus() still returns zero. In order to test NVMe on the
> > RPi5 you can either:
> >
>
> Say I wanted to test NVMe booting on the pi5 (which I actually do).
> I would need:
> 1) this patch
> 2) one of the two BUS_ADDR() related diffs
> 3) the fixes posted in https://lore.kernel.org/u-boot/20251105163553.15F2A227AAC@verein.lst.de/

I believe that series has been replaced with:
https://lore.kernel.org/u-boot/20260227152046.42DE068B05@verein.lst.de/T/#t

> 4) anything else?

Enable NVME support in the defconfig

> Thanks,
> Pedro
>
> > hard code the 64GiB value when building your private U-Boot binary:
> >
> > -#define BUS_ADDR(a)         dev_phys_to_bus(dev->udev, (a))
> > +#define BUS_ADDR(a)            ((a)+0x1000000000LL)
> >
> > OR use this tricky DT change Andrea has prepared:
> >
> > --- a/dts/upstream/src/arm64/broadcom/bcm2712.dtsi
> > +++ b/dts/upstream/src/arm64/broadcom/bcm2712.dtsi
> > @@ -571,6 +571,15 @@
> >                               <0x03000000 0xff 0xfffff000 0x10 0x00131000 0x00 0x00001000>;
> >                       status = "disabled";
> > +
> > +                     pci@0,0 {
> > +                             reg = <0x00 0x00 0x00 0x00 0x00>;
> > +                             device_type = "pci";
> > +                             #address-cells = <0x03>;
> > +                             #size-cells = <0x02>;
> > +                             ranges;
> > +                             dma-ranges;
> > +                     };
> >               };
> >
> >               pcie2: pcie@1000120000 {
> >
> > This pci@0,0 node needs to be below the pcie@1000110000 RC node so it
> > can "bridge" dev_phys_to_bus() to the RC node when it climbs up the
> > device tree and so helps it find the correct value.
> >
> > AFAICS the proper fix should be to add some dma-ranges property when
> > dynamic PCI devices are created during enumeration/scan or make
> > dev_phys_to_bus() skip those nodes for the lookup.
> >
> >       Torsten
