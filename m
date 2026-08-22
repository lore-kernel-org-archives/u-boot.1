Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3C2C5DF94
	for <u-boot@archiver.kernel.org>; Sat, 22 Aug 2026 02:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F344B60AB1;
	Sat, 22 Aug 2026 02:43:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cMSEIkCWn0eL; Sat, 22 Aug 2026 02:43:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787366608;
	bh=WRvNi2a0IWOknfnmoCBnjLTN04Vy+SEyN5+mrEEmVZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M9dpwPffP0LX0LKp5jGBP3HoVMy26hn5NizAEO3sVv7ugf3pzfhfnjaAnx4E2YxE2
	 eqRXhNOVmELG3xDPTs9MsQiGXKXlwkTXzUfKTuVeIsyOvRkm0lBVX37omlF1JKw94l
	 x/y2Sr0T7Kt3upcpqzPBVnatSOHZHeRc1KF5m92ln9nLPjegQt//EfDWgMPase+Vep
	 t9V8XH+jkcBBsKU8j2qAwHvaRt4LcPg3qV4tyME+zci+2tknEvwaOCplVsiWImxnTK
	 GTm6fbs5IZHAtlC3NGzgvTjg4Tn050YDUegFmfAycGrMEEtqkkvXpsNn4IsJFPC6CI
	 QvY0Dkcv/eXGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08B3960870;
	Sat, 22 Aug 2026 02:43:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BD136386
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 01:29:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A69CE406EC
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 01:29:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NyMGP1wFxEKX for <u-boot@lists.u-boot-project.org>;
 Sat, 22 Aug 2026 01:29:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::134; helo=mail-lf1-x134.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=bKdasMX2
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE6D4406D9
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 01:29:26 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5b0148201fbso1679986e87.3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 18:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787362164; cv=none;
 d=google.com; s=arc-20260327;
 b=kF5hvmPddHcSoYVhWBSUddvdRChjlkLEEmDj/6H30ZRdRqNd3bBWamsyR2U/Hx3Om2
 GvEzWqp5zMoHI1Dyk5VEKqSVlXYMPNL3ExQkyg+Z+jRDe4Ync53kPu1Y66zHD9+oxT9+
 jR3yO8Rug9GlwHjtVnkjhYOR3ad9wBreH1qeZzPrbNF8XJY7baKf3wQCLm3EOubPWrlV
 +CrcwKiULXaV9b48gwMiVUEFoywSSxTE5ilpLjW0zbLXSyudZZP/Zv3bxsIry1ya5za7
 gpoRoNImBlUcBm+XDGV23tDItfcTUpagm5LFFZ1m5gIlVEXBSqbkvWeqExWEvx4cvCS9
 Kfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WRvNi2a0IWOknfnmoCBnjLTN04Vy+SEyN5+mrEEmVZk=;
 fh=Q3oPbH8/Tz+DCgBZeQdFra725ZUISeFhkfoncGQjM04=;
 b=N5kkxXJ8pB0nFL29X9tUR0eH6pKeF7kEVi2Ue5kFmAeBUlwnfh8MR8NkNGm2dxJvW7
 oWa3THXKoeCAKdo6LYUR8g7A2rcD6N9c78CzRnmg3a+xRI32nGnUJ61707DOtWRUFS39
 DuzbGasjdQ3TPSIdCtFWjmkGYnHcpbN1ckjR8Tl2EEc1omNDnSjXllpdWpsLjXEecSXT
 cshPPlA4N95DRNstlIEarZsET55HE1wZKLm8OmszyPs/GIZ4IdGxqqPaz3h/hmLsfJPH
 VVcIGLh1C0Nw5W3GsLywRYuzN+xcQe1cSpS4FlVoLw1f/X5nJBLa0HKKGGdyiUnim/QP
 xb4g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787362164; x=1787966964;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WRvNi2a0IWOknfnmoCBnjLTN04Vy+SEyN5+mrEEmVZk=;
 b=bKdasMX2TvBQ9znyRtMy56cslc/ImpTkLQq/DZFFzZSbpECU4N5KDI/ufEr62fY0d/
 fB9MS6825Un1bb9tAcwUBVok/uP2eGjsq7YuNTGVTEzxFTWHuXKVS0YdlXvrdM+kaitI
 vwOv2I8lssFYtm8D2z3aZSzdR7bSbPjymlnqzrpVyfGU0wj7GvY2HGGRwNSPHIl1YIhd
 OL8rvL2/VkeaKKax0kmPZaaeIz8w8uSzbeBdxMpW+EZrunSqlxVkhMx5WeQsr3TDz/5A
 IyPOnNbvELDfZjVSqeMKwmMQ0c5Cxjntg0PIHD43lcC/W0iyQ/W0gnOxDyRPN8J/3VxK
 mz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787362164; x=1787966964;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WRvNi2a0IWOknfnmoCBnjLTN04Vy+SEyN5+mrEEmVZk=;
 b=fzfHKC9fObDraf2jdEIzlyMzuPmHv14mr7IbN6CLLGsD3EoI1HBA0E/qJIMFgL2Cd7
 CngWE0rvYVmC3Vju5/u5isPNufiTsgN3JhSW6rj1qqWPfp5T4QhCejPvywtW8dfgPrNK
 GwmVOW9Oza5yKoWvQEPVZx743fLSldNpC6QvzkczWcZOhDSwpDJFgP6dDqNhKa3MqagQ
 6oXduF54tasI45t7HMydZyK5DMK6nNhYLFRGfqHjKe+TPEKJpS95HEnX2PzUUNreZIP5
 rOf9mgFrMX6jc45AMzSsBDtbudinJXuGHHA2DVINrzcSm7KkFeKdVBgxU8muBq3dOK5C
 HMTQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqdonwIdHXhZyZSsDT6Qwv1/nwBlMFSy6yQ2XzFuKxTaA7TckrStqgLZ1aKa//Cj2b/XuaPA3M=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n6emRBt5H37oB+Kaq1K0/PYJqlJrbtjmopa2muyjQ0/TrC2rrY
 GPxkcs2K0permkkBiPNiEGh8GxV9dpGGrh+LZVuUGBxHVvk1cBnNmIYlwZiaUQl9et4TyCQ2LX4
 c9QJcM1ABT/Yu5OizbOB7HI4a3iuIO1KY0MYLovUPMA==
X-Gm-Gg: AR+sD13Ev9nhio2Q/FE171gNfTP4HFkXYbsG8LAFLa3CDShSdx2XRxRf/KWGA5EpOmC
 cD67sn6swmpsH8ChP6Dch3vOLs9geZxUSl2DGXsV6qDPANU8icoDbTWTTduWL9XXjCE9gViIjdw
 UQNmG+QeAy+vhn5KM3rLwUUktqU+7D8LHQcXfQtwTe0rSLpTBeqECWqiLDlQpnnzqDV6o4NJ159
 cU5LSt5vI6/nnBNrKA73FS6OnR5oi26QdLNH5Y9w2sVP6TPcJeKI3rGizlVJBI53OZXKZfy4FoN
 7La4Vd0w8RCYkVe8Zd5w1+uKqo3xpQ9beu6A5GVE+4u2TDSAD2xV+f2wDvBsRsSWH2paySbXE+P
 elKRIjBSS+TLX4RLXJBVE0OnPisuOaw+runTF/bBlsCK+yL3BBV4m38SqQ866lJvd++RN4abbzQ
 OLPw==
X-Received: by 2002:ac2:5688:0:b0:5ae:ba8f:f9fd with SMTP id
 2adb3069b0e04-5b4841fd33emr3588179e87.9.1787362164242; Fri, 21 Aug 2026
 18:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
 <20260821164257-GKA579897@kernel.org>
 <CAH22mJzoRX6n=YgSRMukLOF6-ybPgHS2jmraoQLjB1LvG7jQVQ@mail.gmail.com>
In-Reply-To: <CAH22mJzoRX6n=YgSRMukLOF6-ybPgHS2jmraoQLjB1LvG7jQVQ@mail.gmail.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 22 Aug 2026 09:29:12 +0800
X-Gm-Features: AcwNN1U5_3dId_vK9EWX6-D9Ns9WKwKGOAi98c4N3wMi9AOpdjflmpKz6Q6Dm8Y
Message-ID: <CAH22mJzYjOuGAj5cNRO60eZ0o01koOuSYVkfKxXNCaeh3tUmdQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/19] spacemit mmc driver
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Yixun Lan <dlan@kenrel.org>,
 Alex Elder <elder@riscstar.com>, 
 Yixun Lan <dlan@gentoo.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Anand Moon <linux.amoon@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
 Vincent Legoll <legoll@online.fr>, Troy Mitchell <troy.mitchell@linux.dev>, 
 Margherita Milani <margherita.milani@amarulasolutions.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Andre Heider <a.heider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 22 Aug 2026 02:43:27 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sat, Aug 22, 2026 at 8:47=E2=80=AFAM Eric Chung <eric.chung@riscstar.com=
> wrote:
>
> On Sat, Aug 22, 2026 at 12:43=E2=80=AFAM Yixun Lan <dlan@kernel.org> wrot=
e:
> >
> > Hi Eric
> >
> > On 11:54 Wed 19 Aug     , Eric Chung wrote:
> > > This series adds MMC support for the SpacemiT K1: an SDHCI platform
> > > driver, the SD card device-tree overlay, defconfig options, and SPL
> > > boot-device selection from the SoC strap/config registers. The SDHCI
> > > driver is usable in both SPL and U-Boot proper.
> > >
> > > A flashing guide (doc/board/spacemit/k1-flash.rst) describes how to
> > > write images to eMMC.
> > >
> > > ---
> > > Changes in v9:
> > > - spl: Enhance detection on booting from SD.
> > > - dts: Synched upstream DTS files for K1.
> > > - doc: Create SD card image from scratch.
> > > - mmc: Avoid to use CMD18 on SD card in SPL.
> > ..
> > > - pinctrl: Drop "fix drive strength configuration".
> > Could you please explain why this patch is dropped?
> >
> > It looks valid to me, also it fix a problem that setting drive strength
> > actually clear out other pin conf bits which lead to serious bug
>
> Ah. I should drop "fix pull-up/pull-down configuration" instead. I
> picked the wrong patch.
>

And too many people are on the CC list automatically. I'll split out
all pinctrl patches.

> >
> > -               clrsetbits_le32(addr, PAD_DRIVE, ds);
> > +               clrsetbits_le32(addr, PAD_DRIVE, FIELD_PREP(PAD_DRIVE, =
ds));
> >
> > --
> > Yixun Lan (dlan)
