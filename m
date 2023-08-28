Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E04C83F10
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 04:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E1686412;
	Mon, 28 Aug 2023 06:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="m9gwAN33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C6486414; Mon, 28 Aug 2023 06:45:06 +0200 (CEST)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC0F586409
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 06:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=abbaraju.manojsai@amarulasolutions.com
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-791b8525b59so1006178241.1
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 21:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693197901; x=1693802701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpjuyeVeshzXeB3rHSnWL6KGPqvSUSRSeaI6SzKvzMI=;
 b=m9gwAN3313Hd9ah1I1T4a+KaEjuExQG1YkBi8B8A3/g8nToUxEqQcQq+ufuteO5/dU
 rBCXwQCZHCYXvGDKkhkyg973r/8fHfd9bgAWcu9fU6iMnPp47t8bxnoZi2wcVYBfPwXW
 htEbQ+EWTKXC3FtT2HXOsRBqHn8vG4r2mkrtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693197901; x=1693802701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpjuyeVeshzXeB3rHSnWL6KGPqvSUSRSeaI6SzKvzMI=;
 b=UndcJX8pmoshLCuY21cxxy3XwKWMkgEiBMLzD8iDjGxDNCQxTdQ5yhwVQdrtqdhp1D
 l8miXBrfXunV1l4HanTJ9Zzh+pn7KOFvI+NI1NJqXmRiKJ81GiV6wmTmh9TZntVb5f1X
 bB0revBafXM0mibT1IFZN0XCz4OTmfMS/IRTMIDG5NGnB0Pq2DGu4CXoBeRwvaRLdOJ1
 AnylpZNHFvfqZXmPswbVa90ekdv9J8Q7y/EMXVHKfYMYjw9eB6i3a87u2WvzQMDX0e2C
 QjWgoKmi0xgxoo2Zxuzeoou36VKRID445Xno6uZT6rJZ4+Q8+cNvroh4HnfMXm86icjX
 rETA==
X-Gm-Message-State: AOJu0YxOgF3a81X7LMYpRAgAj1pE5BXdDtQPklOD5TfeLCqYVRfbPIHM
 ++jUR1EraHOlsGFVt3ck1C/qt9/wwhzkz7KGSmFSRw==
X-Google-Smtp-Source: AGHT+IF3nRn+dl1X7Lm1EsIMmvjQBfF0xoYHM2a6W8igcD2H5ROONV+Y1fSdN08DoEHhXZQtidf9o25qrntrP71Z4CY=
X-Received: by 2002:a67:fdc8:0:b0:44d:5937:56f9 with SMTP id
 l8-20020a67fdc8000000b0044d593756f9mr16398136vsq.9.1693197901334; Sun, 27 Aug
 2023 21:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230630121146.513345-1-abbaraju.manojsai@amarulasolutions.com>
 <20230725035101.281325-1-abbaraju.manojsai@amarulasolutions.com>
 <2722b668-8114-1477-a6aa-4945c0f055ec@kwiboo.se>
In-Reply-To: <2722b668-8114-1477-a6aa-4945c0f055ec@kwiboo.se>
From: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Date: Mon, 28 Aug 2023 10:14:50 +0530
Message-ID: <CADXsG5Y6PqPmfLkQFP_YAoUP9h5y=aUHRcWnv=Y18MCOZEi_jw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] support for booting the compressed U-boot binary
 on Rockchip based ARM64 SOC's
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Da Xue <da.xue@libretech.co>, 
 dsx724 <da@lessconfused.com>, linux-amarula@amarulasolutions.com, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>, u-boot@lists.denx.de
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

On Thu, Jul 27, 2023 at 4:51=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> On 2023-07-25 05:50, Manoj Sai wrote:
> > This patchset adds the support on Rockchip based ARM64 SOC's that  comp=
ress the U-BOOT proper along with dtb
> > and ATF in FIT image format.Second stage bootloader(SPL) loads the comp=
ressed binaries, uncompress
> > them and  handover control to the next stage.
> >
> > Changes for V2 :-
> >
> > - Removed the need to create gzip and lzma compressed U-boot-nodtb file=
s using Makefile  and added a changeset
> > that "compress" field to u-boot-nodtb node and "compression" field to  =
u-boot Node in the FIT image, with the help
> > of this change binman will create the compressed Binaries.
> >
> > Size Comparision between compressed and uncompressed binaries :-
> >
> >       size of uncompressed binary :- 9.4 MB (94,26,432 bytes)
> >          manoj:u-boot$ ls -lb u-boot-rockchip.bin
> >         -rw-rw-r-- 1 manoj manoj 9426432 Jul 25 07:42 u-boot-rockchip.b=
in
> >
> >        size of GZIP compressed binary :- 9.0 MB (89,85,088 bytes)
> >          manoj:u-boot$ ls -lb u-boot-rockchip.bin
> >          -rw-rw-r-- 1 manoj manoj 8985088 Jul 25 07:42 u-boot-rockchip.=
bin
> >
> >        size of LZMA compressed binary :- 9.0 MB (90,06,080 bytes)
> >          manoj:u-boot$ ls -lb u-boot-rockchip.bin
> >          -rw-rw-r-- 1 manoj manoj 9006080 Jul 25 07:47 u-boot-rockchip.=
bin
> >
> > - modified to use the CONFIG_SYS_LOAD_ADDR as the source RAM address to=
 store the  compressed U-Boot binary which
> > will be defined in the machine defconfig file in place of creating a ne=
w RAM address for a specific board using Kconfig.
> > so patchset related to adding a new RAM address to store compressed bin=
ary has been removed in V2 patchset.
> >
> > - Removed the patchset related to adding  the u-boot-nodtb.bin.gz and u=
-boot-nodtb.bin.lzma as input binary to binman.
> >
> >
> > -- Test results of  Booting time using bootstage command in Uboot comma=
nd prompt on roc-rk3399-pc board :-
> >
> > 1) Uncompressed U-BOOT : Total boot time =E2=89=88 12.3 seconds
> > =3D> bootstage  report
> > Timer summary in microseconds (10 records):
> >        Mark    Elapsed  Stage
> >           0          0  reset
> >   1,824,330  1,824,330  board_init_f
> >   2,921,678  1,097,348  board_init_r
> >   5,179,369  2,257,691  eth_common_init
> >   5,478,307    298,938  eth_initialize
> >   5,478,484        177  main_loop
> >   5,478,641        157  usb_start
> >  12,017,936  6,539,295  cli_loop
> >
> > Accumulated time:
> >                 15,899  dm_r
> >                694,371  dm_f
> >
> > 2) GZIP Compressed U-BOOT : Total boot time =E2=89=88 13.5 seconds
> > =3D>  bootstage  report
> > Timer summary in microseconds (10 records):
> >        Mark    Elapsed  Stage
> >           0          0  reset
> >   2,591,355  2,591,355  board_init_f
> >   3,689,407  1,098,052  board_init_r
> >   5,947,314  2,257,907  eth_common_init
> >   6,246,250    298,936  eth_initialize
> >   6,246,427        177  main_loop
> >   6,246,585        158  usb_start
> >  12,785,936  6,539,351  cli_loop
> >
> > Accumulated time:
> >                 15,902  dm_r
> >                694,779  dm_f
> >
> > 2) LZMA Compressed U-BOOT : Total boot time =E2=89=88 23.5 seconds
> > =3D> bootstage report
> > Timer summary in microseconds (10 records):
> >        Mark    Elapsed  Stage
> >           0          0  reset
> >   6,376,405  6,376,405  board_init_f
> >   7,471,967  1,095,562  board_init_r
> >   9,726,257  2,254,290  eth_common_init
> >  10,024,873    298,616  eth_initialize
> >  10,025,049        176  main_loop
> >  10,025,208        159  usb_start
> >  16,564,906  6,539,698  cli_loop
> >
> > Accumulated time:
> >                 15,851  dm_r
> >                693,323  dm_f
> >
> >
> > Patch 1/4  generate a GZIP-compressed U-boot binary using binman if CON=
FIG_SPL_GZIP selected
> > Patch 2/4  generate a LZMA-compressed U-boot binary using binman if CON=
FIG_SPL_LZMA selected
> > Patch 3/4  uncompress the gzip U-BOOT binary and load the binaries if g=
zip compression supoort is enabled
> > Patch 4/4  uncompress the lzma U-BOOT binary and load the binaries if l=
zma compression supoort is enabled
>
> Boot times seem very slow with compression enabled, please try with
> caches enabled, see RFC patch at [1]. Enable caches have a huge impact
> for FIT checksum validation using CONFIG_SPL_FIT_SIGNATURE=3Dy.
>
> Possible to also include ZSTD support?
>

Hi Jonas ,
Enabled zstd support , facing build issues related to zstd . Had you
faced this build error , pasted below :

aarch64-linux-gnu-ld.bfd: lib/zstd/decompress/zstd_decompress.o: in
function `ZSTD_DDictHashSet_getIndex':
/media/manoj/7d4c36e9-ddbb-4e7a-bd1e-cb96766bde37/ssd-Workspace/libreCompTa=
sk/tasks/compression-Task/mainline-apply-Uboot-cmp-2023/testfldr/u-boot/lib=
/zstd/decompress/zstd_decompress.c:88:
undefined reference to `xxh64'
aarch64-linux-gnu-ld.bfd: lib/zstd/decompress/zstd_decompress.o: in
function `ZSTD_decodeFrameHeader':
/media/manoj/7d4c36e9-ddbb-4e7a-bd1e-cb96766bde37/ssd-Workspace/libreCompTa=
sk/tasks/compression-Task/mainline-apply-Uboot-cmp-2023/testfldr/u-boot/lib=
/zstd/decompress/zstd_decompress.c:666:
undefined reference to `xxh64_reset'
aarch64-linux-gnu-ld.bfd: lib/zstd/decompress/zstd_decompress.o: in
function `ZSTD_decompressFrame':
/media/manoj/7d4c36e9-ddbb-4e7a-bd1e-cb96766bde37/ssd-Workspace/libreCompTa=
sk/tasks/compression-Task/mainline-apply-Uboot-cmp-2023/testfldr/u-boot/lib=
/zstd/decompress/zstd_decompress.c:888:
undefined reference to `xxh64_update'
aarch64-linux-gnu-ld.bfd:
/media/manoj/7d4c36e9-ddbb-4e7a-bd1e-cb96766bde37/ssd-Workspace/libreCompTa=
sk/tasks/compression-Task/mainline-apply-Uboot-cmp-2023/testfldr/u-boot/lib=
/zstd/decompress/zstd_decompress.c:904:
undefined reference to `xxh64_digest'
make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
make: *** [Makefile:2059: spl/u-boot-spl] Error 2

I'm missing anything to enable in configs ? any suggestions to these build =
error

Thanks and Regards ,
A.manojsai

> nit: patch 1 and 2 should come after patch 3 and 4.
>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20230702110055.36864=
57-1-jonas@kwiboo.se/
>
> Regards,
> Jonas
>
> >
> > Manoj Sai (4):
> >   rockchip: Add support to generate GZIP compressed U-boot binary
> >   rockchip: Add support to generate LZMA compressed U-boot binary
> >   spl: fit: support for booting a GZIP-compressed U-boot binary
> >   spl: fit: support for booting a LZMA-compressed U-boot binary
> >
> >  arch/arm/dts/rockchip-u-boot.dtsi | 11 +++++++++++
> >  common/spl/spl_fit.c              | 21 +++++++++++++++++----
> >  include/spl.h                     | 10 ++++++++++
> >  3 files changed, 38 insertions(+), 4 deletions(-)
> >
>
