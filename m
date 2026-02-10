Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18F5EA8109
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 12:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A884083CEE;
	Tue, 10 Feb 2026 13:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FhZoEiac";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 058A68341A; Tue, 10 Feb 2026 09:17:34 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AE3D8309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 09:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-94acb3d6cceso1218330241.2
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 00:17:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770711450; cv=none;
 d=google.com; s=arc-20240605;
 b=SIaJlYtkRjgnNCrsSg1gHKE1Ip5U1dydXepvxlSkrQrPsrVm3oBC/U791b1JS3m/0C
 bCUxgDiOEPpsNj7tPTtLEXDfjbeo42Q52auMau0OKvRVks8ue6DBS+rfv29lj79M6BM/
 UmAY+5fXHmPV7fSmgQwe8D3cM1tnfqmab8gxjXKVwQHOly7ZFyM4vrakMPs5fH35ayKT
 LXcvOUxTE1b4ucGj5iDZ/F9VBjT0OL6JYEZiHLNblSnp0kLN6w3QJNnTK4ggrORNCJhb
 5bkkSiSazt9c8IWgkRqIVoFaAX0hCA0DW8pLa55+fUwTUuI4uyNus9eVgt8Mcda0QvgU
 reWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PfGYqqrwGTEwGLd7r/boENmqojbmsVzv6DJ0Q7TVEv8=;
 fh=sr6lzM/oyTwMQa623T2VWxN6EbDwM+j63kC1Wlonrkw=;
 b=d9U0IuXeDBla9NZTn0St/oWBdFZX9mZx2tfu9diKCkSnKPwiwUF0J2S9M+HJx1R41E
 ao5oyQNUbMw0paRTIGb3ZjA06c9cReU3rc1DkBc2wnsvgfEh1Tnkxr1oyGzdqy89qCyh
 MUp1tAxHGjsTqMtLhbp87+5LMdkC110HaegGvCk3qeuJZkEYt/lL3FmFY0mSJu0X+L1n
 F2wdW7owRUpmC/ABfBvCEoxn0DLTlIsXb036r6q8lFENhOg5W04ylpH2a/LI+IEJZatu
 GDsg0bWMCktdnu3WGB1VVPSIx8NaKvlPjbkiqNFXkr1nnLFkam6WBa6sJpLVikyv073m
 6pnA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770711450; x=1771316250; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfGYqqrwGTEwGLd7r/boENmqojbmsVzv6DJ0Q7TVEv8=;
 b=FhZoEiac2kBB593onIta5OSIAOMVnWnlPHvyXWxWTQxZHO8JQu7oPS7bl4lmJT+bzo
 NKqpgp/wxF2wI1tE3VDmyO3ZSD+/pOTpdhLYAoIF6gswfMUz9BuZLJUwTn3oRRtiU+EK
 AswPDWErr3Ti3beRC6qyPbMJBC1sm9MVJFfJPNfJFdnYtw8ALN4LVQqRtzllwEvB9pGR
 3dMQiPopPhaeTzqlhogBYlTzohIJmHJ9J52cyJp4iHES7Jj5HZh4f1faUCKyL8pF1d4g
 aRFXd32eWrY+Y+UcIYiQ7qCQJ40zLiCekaR2FhXdggh6mAOsmCv69pdHxwhFe7lYpfzv
 ZtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770711450; x=1771316250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PfGYqqrwGTEwGLd7r/boENmqojbmsVzv6DJ0Q7TVEv8=;
 b=UR+Ye/MPBTYdlJIcY89eZfdGClQlASnR6at9RqvLX2b4I9AAPCHSaEbwGXmulYPfwV
 ZPWsWaeJ7MHeGGBXELuk2ShKrbse360tdLUqgourinqL6LY5H50AaWmAYj4PbrkTnoj7
 e2RovKpS/Ksnd5FazJbdido0AxZ/93eE5gv9+zCgEWEso7qLxUieS5f2jVBg190k8Ft0
 MeapBMxHOgjsNSrSmAT5Us2MY+bdS7y77dd524D4RSVuUemIPlb99iUb1qKWpfYRZuK5
 qL3noN0XsuIkKgLFAytUcuNp+KPMetZFB+cXqS3s1VroxmKZpt5jUSwkBhpwJA+tUT3u
 4OkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJy+0JzoFjcyHszQIEFc9BuwVqRSbhfmG52DMV6+9FGGcR6lC4edWM0PWX88VN+8yZ9jAyE/Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxfzCK/IGLP9fPgHEPc5vjYx68EkCye0Y5HUvMAWtF4bfpSZ/eF
 g9LOV86jfx5ruhJwHzRzGIeRZaXn0n2Dmu+kj7rCc7WZjshB8ud5WDX2IajNJjb61mqoRj62kLh
 sN26Rhi0cbCgtIkJhxl/UUT42XdOufos=
X-Gm-Gg: AZuq6aLU9M+hj9uoj7vyWoFoFj1R19Wg3b6SLphlzItz8tVIb4Tx1PaGdMp4HHvvtPn
 4Wq502MAQVqpXAfihCfyl6D5mU/99rv5KT0NB50uOOsooBHQivwoaySPu6l8e+iWaruQr5U+pqJ
 jLpdYrm1Gs/AAxUiEVZPyB3Z4Fd/6QUWRUSEiXfc3H26hiGGTOBkTDmf0R6Xhy3UcxD/xrDcMDm
 Y+Mq50K9CCZYNhtAzog3C3vUYhWjMnAxSJmRg8H7epjSpXTQIrmhi5imklxl3PRk8CBJZOFc7GB
 0LwfYb1rvjUcgwJrho0=
X-Received: by 2002:a05:6102:cd1:b0:5f5:4dac:f35f with SMTP id
 ada2fe7eead31-5fc48c12449mr324124137.3.1770711449801; Tue, 10 Feb 2026
 00:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250924113733.uz6hozszbuynemtc@giddy>
 <20250924114317.742ae4ntrb4mvuyq@expert>
 <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
 <CAJwFiGLHDEPMsFyBhX=ogQxX_C+8ac-_9_jeiZYyo=3o0M8ZHA@mail.gmail.com>
 <CAJwFiGLXgsnb75HT45L5Xo-N4LmCBeLGwPi8Yr5zZzNo7mrVNg@mail.gmail.com>
 <873d73f0-34fe-4445-8745-f98734637b0c@freeshell.de>
In-Reply-To: <873d73f0-34fe-4445-8745-f98734637b0c@freeshell.de>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Tue, 10 Feb 2026 16:16:53 +0800
X-Gm-Features: AZwV_Qh-fFnO8xY5Qgs7qcpeMK4ChaYfyjFst9JEY1H_t2uzBFBwo-lMTKz3NIo
Message-ID: <CAJwFiGJsnK3CRhYBYmE0fGpds0AOvVhRv___JaBNPjGhiYRCNA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
To: E Shattow <e@freeshell.de>
Cc: Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de, trini@konsulko.com,
 sjg@chromium.org, 
 alpernebiyasak@gmail.com, al.kochet@gmail.com, paul.henrys_ext@softathome.com, 
 bb@ti.com, y.moog@phytec.de, w.egorov@phytec.de, 
 francesco.dolcini@toradex.com, ggiordano@phytec.com, n-francis@ti.com, 
 afd@ti.com, d.schultz@phytec.de, d-gole@ti.com, ravi@prevas.dk, 
 carlos.lopezr4096@gmail.com, quentin.schulz@cherry.de, alice.guo@nxp.com, 
 Aristo Chen <aristo.chen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 10 Feb 2026 13:41:53 +0100
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

Hi E Shattow and all,

E Shattow <e@freeshell.de> =E6=96=BC 2026=E5=B9=B41=E6=9C=8814=E6=97=A5=E9=
=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=881:29=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Aristo,
>
> On 1/13/26 07:09, Aristo Chen wrote:
> > Hi E Shattow,
> >
> > Aristo Chen <jj251510319013@gmail.com> =E6=96=BC 2025=E5=B9=B411=E6=9C=
=885=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:21=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >>
> >> Hi E Shattow,
> >>
> >> E Shattow <e@freeshell.de> =E6=96=BC 2025=E5=B9=B49=E6=9C=8824=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:31=E5=AF=AB=E9=81=93=EF=BC=9A
> >>>
> >>> Hi Aristo,
> >>>
> >>> On 9/24/25 04:43, Nishanth Menon wrote:
> >>>> On 06:37-20250924, Nishanth Menon wrote:
> >>>>> On 10:59-20250914, Aristo Chen wrote:
> >>>>>> This patch series enhances FIT image robustness by adding **memory
> >>>>>> region overlap detection** to `mkimage` and fixing existing overla=
ps
> >>>>>> in DTS files and `binman` tests.
> >>>>
> >>>> [...]
> >>>>>>
> >>>>>
> >>>>> Looks like i see a build regression in linux-next after this series=
.
> >>>>
> >>>> I fat fingered that one.. sorry, I meant u-boot next.
> >>>>
> >>>>
> >>>> Fails at commit 4d84fa1261eb, last pass was on commit d81c1118580f
> >>>>
> >>>>>
> >>>>> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105f76
> >>>>
> >>>> I  believe there are outstanding comments on V1 that have'nt been
> >>>> addressed either. Can we revert/drop this series for now while the
> >>>> comments are addressed?
> >>>>
> >>>
> >>> Similar to Nishanth, I am seeing a build regression, itb.map:
> >>>
> >>> ImagePos    Offset      Size  Name
> >>> <none>      00000000  <none>    itb
> >>> <none>      00000000  <none>    fit
> >>> <none>      00000000  000c1698  uboot
> >>> <none>      00000000  000c1698  u-boot-nodtb
> >>> <none>      000c1698  00202128  opensbi
> >>> <none>      00000000  00202128  opensbi
> >>>
> >>> Yields this error:
> >>> ...
> >>>  MKIMAGE fit-dtb.blob
> >>> Warning: not able to get `load` of node 'fdt-1'
> >>> Warning: not able to get `load` of node 'fdt-2'
> >>> Warning: not able to get `load` of node 'fdt-3'
> >>> Warning: not able to get `load` of node 'fdt-4'
> >>> Warning: not able to get `load` of node 'fdt-5'
> >>> Warning: not able to get `load` of node 'fdt-6'
> >>> Warning: not able to get `load` of node 'fdt-7'
> >>>   CAT     u-boot-fit-dtb.bin
> >>> ...
> >>>   MKIMAGE u-boot.img
> >>> Warning: not able to get `load` of node 'fdt-1'
> >>> Warning: not able to get `load` of node 'fdt-2'
> >>> Warning: not able to get `load` of node 'fdt-3'
> >>> Warning: not able to get `load` of node 'fdt-4'
> >>> Warning: not able to get `load` of node 'fdt-5'
> >>> Warning: not able to get `load` of node 'fdt-6'
> >>> Warning: not able to get `load` of node 'fdt-7'
> >>>   COPY    u-boot.dtb
> >>>   MKIMAGE u-boot-dtb.img
> >>> Warning: not able to get `load` of node 'fdt-1'
> >>> Warning: not able to get `load` of node 'fdt-2'
> >>> Warning: not able to get `load` of node 'fdt-3'
> >>> Warning: not able to get `load` of node 'fdt-4'
> >>> Warning: not able to get `load` of node 'fdt-5'
> >>> Warning: not able to get `load` of node 'fdt-6'
> >>> Warning: not able to get `load` of node 'fdt-7'
> >>>   BINMAN  .binman_stamp
> >>> Wrote map file './itb.map' to show errors
> >>> binman: Error 1 running 'mkimage -t -F ./itb.fit.fit': Warning: not a=
ble
> >>> to get `load` of node 'fdt-1'
> >>> [Config: conf-1] Error: Overlap detected:
> >>>   - uboot: [0x40200000 - 0x402c1698]
> >>>   - opensbi: [0x40000000 - 0x40202128]
> >>>
> >>> make[1]: *** [/tmp/u-boot.2.git/Makefile:1339: .binman_stamp] Error 1
> >>> make[1]: Leaving directory '/home/es/build/u-boot'
> >>> make: *** [Makefile:198: sub-make] Error 2
> >>> make: Leaving directory '/tmp/u-boot.2.git'
> >>>
> >>> If you would like to reproduce the issue, use config
> >>> starfive_visionfive2_defconfig and pass to OPENSBI env variable the p=
ath
> >>> of opensbi object 'fw_dynamic.bin' built using PLATFORM=3Dgeneric, wi=
th
> >>> the ordinary gcc riscv64 toolchain. The starfive visionfive2 board
> >>> target in U-Boot supports multiple vendors and boards selected at
> >>> runtime and is an example of a more complex FIT usage that you may be
> >>> interested in for comparison and testing.
> >>>
> >>> Best regards,
> >>>
> >>> -E
> >>
> >> Sorry that I didn't noticed that my previous email sent to you was not
> >> including other people
> >>
> >> Long story short, I am now able to reproduce the overlap issue that
> >> you have encountered, and
> >> I spent some time trying to understand what is opensbi, please correct
> >> me if I am wrong
> >>
> >> AFAICT, there will be 2 types of firmware built, one is
> >> `fw_payload.bin`, and the other is
> >> `fw_dynamic.bin`
> >> - fw_payload.bin: contains the next-stage binary, so the file size
> >> will be bigger
> >> - fw_dynamic.bin: provides information about the next boot stage at
> >> runtime, so the size is smaller
> >>
> >> and here are the size of these 2 files built in my environment
> >> ```
> >> -rw-rw-r-- 1 ubuntu ubuntu  273048 Oct 25 14:49 fw_dynamic.bin
> >> -rw-rw-r-- 1 ubuntu ubuntu 2105656 Oct 25 14:49 fw_payload.bin
> >> ```
> >>
> >> When using my overlap checking mechanism, and passing the
> >> fw_dynamic.bin to build U-Boot,
> >> there is no overlap issue. However, when using fw_payload.bin, there
> >> will be an overlap issue.
> >>
> >> AFAICT, the SPL will load the opensbi firmware(assuming fw_payload.bin
> >> here) first, then load
> >> U-Boot into memory, and then jump to opensbi firmware, so I was a bit
> >> confused why the
> >> overlapped opensbi still works?
> >>
> >> I will find some time to figure out how the whole loading/booting
> >> process looks like, but it would
> >> be greatly appreciated if you can share some insight, thanks!
> >
> > I finally had some time to revisit this and managed to get a VisionFive=
2
> > board for local testing.
> >
> > While trying to make it bootable I noticed the following docs:
> >   - https://docs.u-boot.org/en/latest/board/starfive/visionfive2.html#s=
econd-stage-bootloader-opensbi-fw-dynamic-bin-u-boot-main
> >   - https://wiki.gentoo.org/wiki/StarFive_VisionFive_2#Building_OpenSBI
> >
> > Both appear to recommend using OpenSBI=E2=80=99s fw_dynamic.bin when bu=
ilding
> > U=E2=80=91Boot. I couldn=E2=80=99t find any guidance on using fw_payloa=
d.bin together
> > with U=E2=80=91Boot, which made me wonder why fw_payload.bin was used i=
n your
> > earlier report.
> >
>
> Likely I mixed up the filenames when writing in conversation, as I did
> when writing on the opensbi mailing list about a dependency tracking bug
> in opensbi build system:
>
> https://lore.kernel.org/opensbi/0d6bf7c7-7605-4ad6-a35c-54efc5230fb8@sifi=
ve.com/
>
> and
>
> https://lore.kernel.org/opensbi/36cfe431-40fb-470d-b50e-00a139d480f8@free=
shell.de/
>
> ...which is clearly a mistake to write "OPENSBI=3D/path/to/fw_payload.bin=
"
> when it should instead be "OPENSBI=3D/path/to/fw_dynamic.bin",
> acknowledged in the follow-up message:
>
> https://lore.kernel.org/opensbi/32873fc7-2cc8-46d5-9f4e-3a16cf95f48a@free=
shell.de/
>
> > Could you clarify whether there is documentation (or a specific
> > requirement) that calls for fw_payload.bin in this flow? If the intende=
d
> > path is fw_dynamic.bin, then the overlap issue disappears for me
> >
>
> For the VisionFive2 and derivative boards, I intended to refer to
> fw_dynamic.bin only. If I mention otherwise it was in error or for not
> knowing what I'm looking at and reporting more information than
> required. There are RISC-V boards not related to VisionFive2 or its
> StarFive JH-7110 SoC that do use the fw_payload.bin approach but I think
> I just didn't notice the difference when transcribing to e-mail.
>
> > Thanks for your help and guidance.
> >>
> >> Best regards,
> >> Aristo
> >
> > Best regards,
> > Aristo
>
> Thanks very much for the follow-up,
Thanks for letting me know that StarFive VisionFive2 is not affected
by my patch!

>
> -E

We=E2=80=99re currently discussing a new proposal[1] for handling TI platfo=
rms
in the FIT image spec. Ahmad Fatoum has a few questions about
TI-specific implementations=E2=80=94could the TI folks on this thread pleas=
e
take a look when you have a moment?

Best regards,
Aristo

[1] https://github.com/open-source-firmware/flat-image-tree/issues/32
