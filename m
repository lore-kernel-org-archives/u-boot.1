Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FF01061B39
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 11:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5119983DA6;
	Tue, 31 Mar 2026 13:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UKJzP/oi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4654283DBF; Tue, 31 Mar 2026 13:50:31 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 309EA83A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 13:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-59e5aa4ca41so3809352e87.2
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 04:50:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774957828; cv=none;
 d=google.com; s=arc-20240605;
 b=Nn3jhdfpUR6/AIBWc6jDIn1ZnHHA3gIz1T2gcd5Uous5KkCDuwHK+tKyKaGzGmNpAk
 nzndB53K2xRSl4IdgygnDY7Up5aalrGIckblcdJ1MDFrck7BERjAmEaqVkfGsgmN7TNr
 Xme0a3DL/j0PGjZdXSBi2b0nmAVZGlDpM/YWppvdVFY6pbPyduInjHlXCM36HLR3/YHX
 LSz7S4Wlv4UpuhojjxGBm8TIveid1LwvY6YSUNMPR7ZkH6bx1pyZrZtxtaYa+BIW8pa4
 +oBmf9nfm30hhD+OmbATV9d3+Mnux3qTHFlz1s7mYCE9dIu2D7vT6Z1FTMLrCIMjkl9C
 OVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B/15gBUt/6HHGTv/ZscxGWtOHA3alFFoBR8IAVlX8YI=;
 fh=KwUyhSwMbuqJnq4eiLKUni0v+aYMSLZPgPUfMf11DU0=;
 b=Jg1Kn2IFHyVCYSJRdF5s/JAG8LzxassiJxSEMOrhPt20UaLOHThwm8QyAu1SpkqR8b
 tXljJ37tergCSMdj7MbBb0mw4j35sHMmc51ZZqvhXFhSeqJjRAI6AsKFsYbghKFmN9JR
 h7kNl0UqXMg82oROC1tMuHOLPb9wkDMLc6PPo7QNeLywI3q1eTGc/ORNTqlyf+ZHjWpy
 utWrjgw6VLdEOdqUt6ijkxrvjBp9ZdDidcAxWCroms4RIAZ+bkRPYn995meJR48Ds6st
 jOivNnm9JOtF3ZrvweiHXU/GTrBGFjO02DMKsgn4ewJUIgdJHgpxu+WQpp4T2SK70ffo
 wljQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774957828; x=1775562628; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/15gBUt/6HHGTv/ZscxGWtOHA3alFFoBR8IAVlX8YI=;
 b=UKJzP/oiZektfLZcTb++Jzu4BE1C/+4o+lFANZ03BMLNoyTO/Inq9Sj1m2zxQpAZB1
 JycfBfY/TXj070+GR7iGI8ox/12vz5j3f425J98rW0s6F1BOjCkrxBcs2kakLOaqJWXt
 cjuwS+i4L/buJ+XE7LFCvJ4+W/+3mNDh6ctMgHAzUvqeA/9Pc9dy4jC5NV3/PAMl6QAD
 lYc725/LBNKFRYfCkfu2b231WsdFScElIJhJ2NQeSY8ICdBLB48f5QRGLtuXgpODXooD
 td5OrGfCfTqWT2Wa0HsaKavG8qIUAymCVhexJBsE7fhZU8oQuljb1dQ7zW1fay86wGaf
 Z19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774957828; x=1775562628;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B/15gBUt/6HHGTv/ZscxGWtOHA3alFFoBR8IAVlX8YI=;
 b=LX44TnZkpQUg+ZPDRFFZ0M+RJWADxDqsnnxVR/pstwlHn+CHEP3/r/RJr18eyLSie1
 QY6VfMHaRPW8lgn9fQxsSkNKnbNDehKNnx+0cOViBtTV6zBKMEfJ4+vOJrInDqX7OYsn
 bJ+d1RP3mVicmCSTipH9W8Xm9L2XN09eIxUUXMPjU1R65B/NmWLPf5peGRiLidbJTJwh
 du1JQd6NKsqermOl1mPKGThQkkb8UMJTbxjiTpYrJcZ5E5dZxeh7fXwhTURURnf6qp/w
 pu6+ZQdbwqZRR49OqHRAV7WZh8ySxM2l5bqzMgcNFc88R3yOR0p5KcX/O4f4dmDvRdAK
 J2nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/kdIwx382mIYl9OlRiAdxtUOKkw688+jh3j+xciV8fmYGaigDp9JPoF7h1iTz6KCqk7HBo9w=@lists.denx.de
X-Gm-Message-State: AOJu0YwJmGk7wKYy/0skP4ZhzOCr82M/tB89OUuhS9ii6ENXkGO8LInf
 n/WccXwtjPfRsUsg7KpbD6iCxXhxV7mmSzFdFbXLBdxtWXh8rH7rIKT+5LOo02cWzpP9vmhMVM7
 AIS4SHwoSzn87WlOQPEXk7mxXTGwDobk=
X-Gm-Gg: ATEYQzzTM9rhtVddLzLvTvW8QqM5+9x28smyKbal/Ul+rp9daHKr6uypPUzJbhh4ztF
 xuxcwVGQyPe6ifm61sDCmSWT1CWnnCRzTqRD1XYsYr1D3dQw26HmJzWGBFQruAUqvMPypE5Dtz8
 i4cUsWYlrP5bu4TN+qijQ01mw1GpKdDBB21CJIT+PXZhAPHfPZetzjoH4BpKVPr44nKN4s/wfx+
 zWthg3zU05XfJST8m8B4h2WrGYJXa1g/aQqnGDrqr6RUR2EZN8cXQxRxwK5PKgBFR13B4MIhpP3
 I27sSNFQavWP2VihVZ6YU3jYH1d//u036uP29rxAjSMdCzFSP+8IS3p3elj8R+0RVvjLwds=
X-Received: by 2002:ac2:4e01:0:b0:5a2:bef4:5dfe with SMTP id
 2adb3069b0e04-5a2bef45e38mr614498e87.9.1774957828031; Tue, 31 Mar 2026
 04:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <fcc606350e96e03911f6c67537853de1ad51dc10.camel@initse.com>
 <861d61d6-3d35-47bf-9cea-21f7cfd13c1a@nabladev.com>
 <24e183b2fc5419b9ed1685f49a67fb9822b1ad73.camel@initse.com>
 <a5f735cc-e699-422a-b88d-e5fe33fc8b7b@nabladev.com>
 <ea2937eabb137e2c5845bc451f7c28a827496eb3.camel@initse.com>
 <CAOMZO5CsuTw92safK80f0v+0hPkOQvHVEfKZyqWvfdw7ghnxmg@mail.gmail.com>
In-Reply-To: <CAOMZO5CsuTw92safK80f0v+0hPkOQvHVEfKZyqWvfdw7ghnxmg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 31 Mar 2026 08:50:15 -0300
X-Gm-Features: AQROBzADjs6ALJEZTAaX2BoeANYssAe-wY8MwwpJQE69LF6js3vKXQhvqO2lzxo
Message-ID: <CAOMZO5AqeMmeWLXX3mPKceshw8T=fcFax7Ja=tfm0Qf6Mh_cOg@mail.gmail.com>
Subject: Re: [REGRESSION] imx8mm_evk: FSPI build broken by 37e50627e
To: Alexander Koch <akoch@initse.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Ye Li <ye.li@nxp.com>
Cc: "marex@nabladev.com" <marex@nabladev.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>
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

Fixing the U-Boot list address.

On Tue, Mar 31, 2026 at 8:47=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Adding Peng and Ye Li in case they could take a look.
>
> On Tue, Mar 31, 2026 at 6:24=E2=80=AFAM Alexander Koch <akoch@initse.com>=
 wrote:
> >
> > >
> > > Is it possible that binman patched some blob offset (maybe for the DR=
AM
> > > blobs) at the wrong offset due to the extra header ?
> >
> > I'm afraid it's not that easy. After a good amount of juggling around w=
ith hex
> > editors here are my findings:
> >
> > First of all, we can ignore the error message regarding 'fspi_header.bi=
n' for
> > now, that's definitely a different bug (the first `make` will generate =
a
> > 'flash.bin' without the header and the second one will add it in withou=
t
> > breaking anything else).
> >
> > Now I have compared the layout of 'flash.bin' from the last good commit
> > (6509e007) to the one from the first bad commit (37e50627) and unfortun=
ately
> > they both look structurally identical:
> >
> > Good:
> >  - FSPI header at offset 0x00
> >    (from 'fspi_header.bin', 448 Bytes)
> >  - SPL blob =3D SPL+DDR-FW at offset 0x1000
> >    (from 'spl.bin', 188288 Bytes)
> >  - FIT blob =3D U-Boot+ATF+DTB at offset 0x58c00
> >    (from 'u-boot.itb', 729528 Bytes)
> >
> > Bad:
> >  - FSPI header at offset 0x00
> >    (from 'fspi_header.bin', 448 Bytes)
> >  - SPL blob =3D SPL+DDR-FW at offset 0x1000
> >    (from 'u-boot-spl-mkimage.bin', 185216 Bytes)
> >  - FIT blob =3D U-Boot+ATF+DTB at offset 0x58c00
> >    (from 'section.fit.fit', 729320 Bytes)
> >
> > So it seems binman is still right regarding the top-level structure of =
the
> > image.
> >
> > As I am not even seeing output from the SPL with the bad build I then h=
ad a
> > deeper look at the SPL blobs.
> >
> > Both do have the DDR firmware at identical offsets:
> >
> >  - 0x1c5c0: lpddr4_pmu_train_1d_imem.bin
> >  - 0x243b4: lpddr4_pmu_train_1d_dmem.bin
> >  - 0x24a38: lpddr4_pmu_train_2d_imem.bin
> >  - 0x2a4f8: lpddr4_pmu_train_2d_dmem.bin
> >
> > Scrolling through the binary diff I'd say it's mostly build timestamps =
and
> > version strings that make up the difference. The 3072 Bytes that the wo=
rking SPL
> > blob is larger are all 0x00 again.
> >
> > My last idea was trying to inject the SPL blob from the working build i=
nto
> > 'flash.bin' from the broken build, to confirm it really is the SPL blob=
 itself
> > that is causing troubles.
> >
> > Lo and behold, that patched 'flash.bin' actually did boot and it did no=
t only
> > run the injected SPL part but also proper U-Boot as well as the ATF:
> >
> >
> > -----------------------------------------------------------------------=
-----
> > U-Boot SPL 2024.07-rc1-00155-gef8cc500d15 (Mar 30 2026 - 19:18:36 +0200=
)
> > No pmic
> > SEC0:  RNG instantiated
> > WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeo=
ut)
> > Trying to boot from NOR
> > NOTICE:  BL31: v2.6(release):lf-6.1.1-1.0.0-1-g874e9578a
> > NOTICE:  BL31: Built : 14:40:27, Jul 15 2024
> >
> >
> > U-Boot 2024.07-rc1-00156-gb550ac40df5 (Mar 30 2026 - 19:32:55 +0200)
> >
> > CPU:   Freescale i.MX8MMD rev1.0 at 1200 MHz
> > Reset cause: POR
> > Model: FSL i.MX8MM EVK board
> > DRAM:  2 GiB
> > Core:  78 devices, 22 uclasses, devicetree: separate
> > WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeo=
ut)
> > MMC:   FSL_SDHC: 1, FSL_SDHC: 2
> > Loading Environment from MMC... MMC: no card present
> > *** Warning - No block device, using default environment
> > -----------------------------------------------------------------------=
-----
> >
> > (please ignore the commit hashes, I had to cherry-pick a pylibfdt fix t=
o make
> > the build run on my host system)
> >
> >
> > So, any idea what might break the SPL blob itself in 37e50627e?
> >
> >
> > Best regards,
> >
> > Alex
