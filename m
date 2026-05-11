Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90279CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB5928464D;
	Mon, 11 May 2026 14:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UakZicbx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 066258485A; Mon, 11 May 2026 12:28:11 +0200 (CEST)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59ED483A91
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 12:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-5751136c561so3686712e0c.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 03:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778495287; cv=none;
 d=google.com; s=arc-20240605;
 b=WHeiXuzqEQjLA603wC1IWA80DWMsBjX5WN9DSktboO/6VxwiiDHbiRstD5/6N+PeXw
 IgTaiVwiUO0Xm90gKBi5rKr0n64rJLEKzgvnwabK/8NLcHymTVOHHaeKFdnmS8DEdaho
 K97C6BSXhqZ2LkpRa2479dg5RW3VxJyiLHkgdcMOQPNq9CXc7hECK1MC/keoWR1+C7tP
 69cZg7sUQD/4WV98Y13sGxTkVxT9X9hkBMKizZaDekSqP04TlqZTHbAnaYwyTH2/VhtX
 2erCmAz+Gq/SB8mnkrsmcfcL8Gh/mnlOxYQVpo1/+eITvLQGjzMFkYZM1Py8nJLCvPUM
 h2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K/iMlUzOuH0N9xah4POxalefnPucKTZ0LNj+dUscvlg=;
 fh=zeDNGmt08FfIJSdkZAXc8RjJrX7mJ4Bl5kRiiaiRAO4=;
 b=OMi0Yk9ey8J/ZRUwRIwI/Aie2OLjpAa0/1cI252/Wnr5N06oNq7Z4eE1lH8aU2rus3
 m0eMR9YPh2/9InsqIYSbANmluW6rtV8Zqdq9b3sVzXpUkfjBNQ8x25gQAC4KP3ZrIJfn
 5HyVgjpgJ3zASs5QejHqGvuvoIi53mBQQjWV02yWOpaXQy/+xdaWiGtzPXNPrGcLf1pf
 KHvLOD+noGwXjubYD5ti4FGXKBo9CMsPgPSChq2Hz7Yyp3OvmyVzGc4OW0h62jJe3Tpo
 30nwTl3NaAxJNSUpAwFBwxjxbOhoyhw7MCXaMurS0O1Z243/RyeQWrtscNEwykikwlQJ
 35OQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778495287; x=1779100087; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K/iMlUzOuH0N9xah4POxalefnPucKTZ0LNj+dUscvlg=;
 b=UakZicbxNI6R3E8WJnCJQyoDM1Dag1swt3qhsU97TNIdZdlTlZe1Uvia6mcFtvbRXn
 oQITG4whDZzR2Lt37O2/3JXEPfG3jnHw94OXURn3SODDCMskxQ1XYOMq4bWmZJ1wP9jb
 g9Oa5T0rV/dBe1uakKaRxy+4wfyMgCuy2zJ6NMVZYmnBeadNJ8+M5gaQdwTavePa8eUe
 CudUst6eVBmlPw2wlyWe+51NdlOxaQ/ylsXo8W9ML7cX8MPpDRApnTq+a5vbyfr07Wf0
 bE4caO9LDr/XVOexUUpLgVCporaD6NgvbL6mxJ0x0TMomwFpjp4/FMmpxIT53K6jdDnu
 qYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778495287; x=1779100087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K/iMlUzOuH0N9xah4POxalefnPucKTZ0LNj+dUscvlg=;
 b=M9zV4ejYvSCrqr8tdHoxViQ74/fhL2LxEMUmGIJ9yzUBzkrRgWcAec8Mi24lokr/kZ
 fOQlUY5ijvMKb6F3pwFudSUs7Q5vSYMdbM5GyJQ5Q7PKShqAzKj0CuWD0uDQelvFcyA8
 PEvhaANH5BYSrihHXQWidwp/PvoGcvaQQs/zgRuh01ziMTARvoDYhHi84Xe8ffuaq2p4
 8KQATQYeH/dvnvn4uXGRtiT8qltS0XXTHLOWg72hR3q7IdKqCX+3GuxjiuSYyasAy2vB
 p1snNtmwAnRGaMKpDvrTTOtEFFcPmyL7B7U/PHO/aHv58/uOq47/Ua9ZHNFpyoFKt2o/
 lJnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xUo68aFfngTGIT4bKmv4GscoutKZzKCUxqt4RWSdANRK3LabhG5HNzLfs5ca9/ys7gdNNYQQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5Ix4htOHo77CGTxhHfWiT+wpqO2ttERGFbT751wf9fwBD1/MU
 EKyLZIx786L7l/X5SE9oSU0R8GgrcgqR1da9+yUoFWf+UhMNjkzpX0ejERq+gsf41vjTsTsg1/i
 v6JIjJ1C91fKLlZH109/doXsmNqVS5PI=
X-Gm-Gg: Acq92OHkGtkx+KNxaa8WJCWVadm4Xb2bb/2ipIcDnzbX6eXbRlhOQgW3iYBXH+IwMLv
 HijDqG5MCY6UasOe6zcpfhrdjdITOJEOa0NF1RJwHH0uNi/5ltAHOPmZWZEQ9vD5ZoODM93XUdT
 4fWP5TCYc64b00OKSScFRh3NdRlK14I6Clda1zgQ/gdNrJTmSfoTy84fJlZRyjI1h68AkPyFN1v
 4DVZxM6742R582oqlaPOIVhxgiueSBxeZIx+NEhboXoued8VY1vverU6wk+S0hSm0KHHZ10RNw2
 1ukOPX+wGvcpdqOqt+k=
X-Received: by 2002:ac5:c806:0:b0:575:a69a:a3c0 with SMTP id
 71dfb90a1353d-575a69aab76mr1350526e0c.7.1778495286698; Mon, 11 May 2026
 03:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250924113733.uz6hozszbuynemtc@giddy>
 <20250924114317.742ae4ntrb4mvuyq@expert>
 <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
 <CAJwFiGLHDEPMsFyBhX=ogQxX_C+8ac-_9_jeiZYyo=3o0M8ZHA@mail.gmail.com>
 <CAJwFiGLXgsnb75HT45L5Xo-N4LmCBeLGwPi8Yr5zZzNo7mrVNg@mail.gmail.com>
 <873d73f0-34fe-4445-8745-f98734637b0c@freeshell.de>
 <CAJwFiGJsnK3CRhYBYmE0fGpds0AOvVhRv___JaBNPjGhiYRCNA@mail.gmail.com>
 <CAJwFiGKVqRsNjvhd4Qjo8S8AxVMTpTvxu51tCaJA6j6a+7-RAw@mail.gmail.com>
 <20260309130826.xz7m33vj672hthz2@bryanbrattlof.com>
In-Reply-To: <20260309130826.xz7m33vj672hthz2@bryanbrattlof.com>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Mon, 11 May 2026 12:27:29 +0200
X-Gm-Features: AVHnY4IP3IT30OTuySZo556ZuK_eJ8jE-Wo_d3c1rj7fSpJ4fu1D63F5lk-kSYc
Message-ID: <CAJwFiGL1OyX=MOWor-BkZsSmiVOH23wG_Y-kSZinFseXygUD8A@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
To: Bryan Brattlof <bb@ti.com>
Cc: E Shattow <e@freeshell.de>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de, trini@konsulko.com, 
 sjg@chromium.org, alpernebiyasak@gmail.com, al.kochet@gmail.com, 
 paul.henrys_ext@softathome.com, y.moog@phytec.de, w.egorov@phytec.de, 
 francesco.dolcini@toradex.com, ggiordano@phytec.com, n-francis@ti.com, 
 afd@ti.com, d.schultz@phytec.de, d-gole@ti.com, ravi@prevas.dk, 
 carlos.lopezr4096@gmail.com, quentin.schulz@cherry.de, alice.guo@nxp.com, 
 Aristo Chen <aristo.chen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 11 May 2026 14:51:08 +0200
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

Hi TI folks,

I guess things have been busy on your end, so I went ahead and secured
an SK-AM62 board (GP variant) to verify the patch[1] myself. I've
tested it against the latest U-Boot master, and as far as I can tell,
it boots without issues[2].

Could you please take a look when you have a moment? If you=E2=80=99re happ=
y
with the changes, would you prefer I open a PR on the TI GitHub
repo[3], or should I submit this directly to the U-Boot upstream
mailing list?

[1] https://github.com/open-source-firmware/flat-image-tree/issues/32#issue=
comment-3948419217
[2] https://github.com/open-source-firmware/flat-image-tree/issues/32#issue=
comment-4344362533
[3] https://github.com/TexasInstruments/ti-u-boot

Best regards,
Aristo

Bryan Brattlof <bb@ti.com> =E6=96=BC 2026=E5=B9=B43=E6=9C=889=E6=97=A5=E9=
=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=882:08=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On March  9, 2026 thus sayeth Aristo Chen:
> > Hi TI folks,
> >
> > I have put some thoughts in the github issue[1] that we are discussing
> > FIT image spec, could you please take a look when you have time?
> >
>
> Absolutely. Sorry for the delay. I think I have a github filter set long
> ago which probably needs adjusting.
>
> ~Bryan
>
> > Best regards,
> > Aristo
> >
> > [1] https://github.com/open-source-firmware/flat-image-tree/issues/32
> >
> > Aristo Chen <jj251510319013@gmail.com> =E6=96=BC 2026=E5=B9=B42=E6=9C=
=8810=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:16=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > >
> > > Hi E Shattow and all,
> > >
> > > E Shattow <e@freeshell.de> =E6=96=BC 2026=E5=B9=B41=E6=9C=8814=E6=97=
=A5=E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=881:29=E5=AF=AB=E9=81=93=EF=BC=9A
> > > >
> > > > Hi Aristo,
> > > >
> > > > On 1/13/26 07:09, Aristo Chen wrote:
> > > > > Hi E Shattow,
> > > > >
> > > > > Aristo Chen <jj251510319013@gmail.com> =E6=96=BC 2025=E5=B9=B411=
=E6=9C=885=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:21=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > > > >>
> > > > >> Hi E Shattow,
> > > > >>
> > > > >> E Shattow <e@freeshell.de> =E6=96=BC 2025=E5=B9=B49=E6=9C=8824=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:31=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > > >>>
> > > > >>> Hi Aristo,
> > > > >>>
> > > > >>> On 9/24/25 04:43, Nishanth Menon wrote:
> > > > >>>> On 06:37-20250924, Nishanth Menon wrote:
> > > > >>>>> On 10:59-20250914, Aristo Chen wrote:
> > > > >>>>>> This patch series enhances FIT image robustness by adding **=
memory
> > > > >>>>>> region overlap detection** to `mkimage` and fixing existing =
overlaps
> > > > >>>>>> in DTS files and `binman` tests.
> > > > >>>>
> > > > >>>> [...]
> > > > >>>>>>
> > > > >>>>>
> > > > >>>>> Looks like i see a build regression in linux-next after this =
series.
> > > > >>>>
> > > > >>>> I fat fingered that one.. sorry, I meant u-boot next.
> > > > >>>>
> > > > >>>>
> > > > >>>> Fails at commit 4d84fa1261eb, last pass was on commit d81c1118=
580f
> > > > >>>>
> > > > >>>>>
> > > > >>>>> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105f=
76
> > > > >>>>
> > > > >>>> I  believe there are outstanding comments on V1 that have'nt b=
een
> > > > >>>> addressed either. Can we revert/drop this series for now while=
 the
> > > > >>>> comments are addressed?
> > > > >>>>
> > > > >>>
> > > > >>> Similar to Nishanth, I am seeing a build regression, itb.map:
> > > > >>>
> > > > >>> ImagePos    Offset      Size  Name
> > > > >>> <none>      00000000  <none>    itb
> > > > >>> <none>      00000000  <none>    fit
> > > > >>> <none>      00000000  000c1698  uboot
> > > > >>> <none>      00000000  000c1698  u-boot-nodtb
> > > > >>> <none>      000c1698  00202128  opensbi
> > > > >>> <none>      00000000  00202128  opensbi
> > > > >>>
> > > > >>> Yields this error:
> > > > >>> ...
> > > > >>>  MKIMAGE fit-dtb.blob
> > > > >>> Warning: not able to get `load` of node 'fdt-1'
> > > > >>> Warning: not able to get `load` of node 'fdt-2'
> > > > >>> Warning: not able to get `load` of node 'fdt-3'
> > > > >>> Warning: not able to get `load` of node 'fdt-4'
> > > > >>> Warning: not able to get `load` of node 'fdt-5'
> > > > >>> Warning: not able to get `load` of node 'fdt-6'
> > > > >>> Warning: not able to get `load` of node 'fdt-7'
> > > > >>>   CAT     u-boot-fit-dtb.bin
> > > > >>> ...
> > > > >>>   MKIMAGE u-boot.img
> > > > >>> Warning: not able to get `load` of node 'fdt-1'
> > > > >>> Warning: not able to get `load` of node 'fdt-2'
> > > > >>> Warning: not able to get `load` of node 'fdt-3'
> > > > >>> Warning: not able to get `load` of node 'fdt-4'
> > > > >>> Warning: not able to get `load` of node 'fdt-5'
> > > > >>> Warning: not able to get `load` of node 'fdt-6'
> > > > >>> Warning: not able to get `load` of node 'fdt-7'
> > > > >>>   COPY    u-boot.dtb
> > > > >>>   MKIMAGE u-boot-dtb.img
> > > > >>> Warning: not able to get `load` of node 'fdt-1'
> > > > >>> Warning: not able to get `load` of node 'fdt-2'
> > > > >>> Warning: not able to get `load` of node 'fdt-3'
> > > > >>> Warning: not able to get `load` of node 'fdt-4'
> > > > >>> Warning: not able to get `load` of node 'fdt-5'
> > > > >>> Warning: not able to get `load` of node 'fdt-6'
> > > > >>> Warning: not able to get `load` of node 'fdt-7'
> > > > >>>   BINMAN  .binman_stamp
> > > > >>> Wrote map file './itb.map' to show errors
> > > > >>> binman: Error 1 running 'mkimage -t -F ./itb.fit.fit': Warning:=
 not able
> > > > >>> to get `load` of node 'fdt-1'
> > > > >>> [Config: conf-1] Error: Overlap detected:
> > > > >>>   - uboot: [0x40200000 - 0x402c1698]
> > > > >>>   - opensbi: [0x40000000 - 0x40202128]
> > > > >>>
> > > > >>> make[1]: *** [/tmp/u-boot.2.git/Makefile:1339: .binman_stamp] E=
rror 1
> > > > >>> make[1]: Leaving directory '/home/es/build/u-boot'
> > > > >>> make: *** [Makefile:198: sub-make] Error 2
> > > > >>> make: Leaving directory '/tmp/u-boot.2.git'
> > > > >>>
> > > > >>> If you would like to reproduce the issue, use config
> > > > >>> starfive_visionfive2_defconfig and pass to OPENSBI env variable=
 the path
> > > > >>> of opensbi object 'fw_dynamic.bin' built using PLATFORM=3Dgener=
ic, with
> > > > >>> the ordinary gcc riscv64 toolchain. The starfive visionfive2 bo=
ard
> > > > >>> target in U-Boot supports multiple vendors and boards selected =
at
> > > > >>> runtime and is an example of a more complex FIT usage that you =
may be
> > > > >>> interested in for comparison and testing.
> > > > >>>
> > > > >>> Best regards,
> > > > >>>
> > > > >>> -E
> > > > >>
> > > > >> Sorry that I didn't noticed that my previous email sent to you w=
as not
> > > > >> including other people
> > > > >>
> > > > >> Long story short, I am now able to reproduce the overlap issue t=
hat
> > > > >> you have encountered, and
> > > > >> I spent some time trying to understand what is opensbi, please c=
orrect
> > > > >> me if I am wrong
> > > > >>
> > > > >> AFAICT, there will be 2 types of firmware built, one is
> > > > >> `fw_payload.bin`, and the other is
> > > > >> `fw_dynamic.bin`
> > > > >> - fw_payload.bin: contains the next-stage binary, so the file si=
ze
> > > > >> will be bigger
> > > > >> - fw_dynamic.bin: provides information about the next boot stage=
 at
> > > > >> runtime, so the size is smaller
> > > > >>
> > > > >> and here are the size of these 2 files built in my environment
> > > > >> ```
> > > > >> -rw-rw-r-- 1 ubuntu ubuntu  273048 Oct 25 14:49 fw_dynamic.bin
> > > > >> -rw-rw-r-- 1 ubuntu ubuntu 2105656 Oct 25 14:49 fw_payload.bin
> > > > >> ```
> > > > >>
> > > > >> When using my overlap checking mechanism, and passing the
> > > > >> fw_dynamic.bin to build U-Boot,
> > > > >> there is no overlap issue. However, when using fw_payload.bin, t=
here
> > > > >> will be an overlap issue.
> > > > >>
> > > > >> AFAICT, the SPL will load the opensbi firmware(assuming fw_paylo=
ad.bin
> > > > >> here) first, then load
> > > > >> U-Boot into memory, and then jump to opensbi firmware, so I was =
a bit
> > > > >> confused why the
> > > > >> overlapped opensbi still works?
> > > > >>
> > > > >> I will find some time to figure out how the whole loading/bootin=
g
> > > > >> process looks like, but it would
> > > > >> be greatly appreciated if you can share some insight, thanks!
> > > > >
> > > > > I finally had some time to revisit this and managed to get a Visi=
onFive2
> > > > > board for local testing.
> > > > >
> > > > > While trying to make it bootable I noticed the following docs:
> > > > >   - https://docs.u-boot.org/en/latest/board/starfive/visionfive2.=
html#second-stage-bootloader-opensbi-fw-dynamic-bin-u-boot-main
> > > > >   - https://wiki.gentoo.org/wiki/StarFive_VisionFive_2#Building_O=
penSBI
> > > > >
> > > > > Both appear to recommend using OpenSBI=E2=80=99s fw_dynamic.bin w=
hen building
> > > > > U=E2=80=91Boot. I couldn=E2=80=99t find any guidance on using fw_=
payload.bin together
> > > > > with U=E2=80=91Boot, which made me wonder why fw_payload.bin was =
used in your
> > > > > earlier report.
> > > > >
> > > >
> > > > Likely I mixed up the filenames when writing in conversation, as I =
did
> > > > when writing on the opensbi mailing list about a dependency trackin=
g bug
> > > > in opensbi build system:
> > > >
> > > > https://lore.kernel.org/opensbi/0d6bf7c7-7605-4ad6-a35c-54efc5230fb=
8@sifive.com/
> > > >
> > > > and
> > > >
> > > > https://lore.kernel.org/opensbi/36cfe431-40fb-470d-b50e-00a139d480f=
8@freeshell.de/
> > > >
> > > > ...which is clearly a mistake to write "OPENSBI=3D/path/to/fw_paylo=
ad.bin"
> > > > when it should instead be "OPENSBI=3D/path/to/fw_dynamic.bin",
> > > > acknowledged in the follow-up message:
> > > >
> > > > https://lore.kernel.org/opensbi/32873fc7-2cc8-46d5-9f4e-3a16cf95f48=
a@freeshell.de/
> > > >
> > > > > Could you clarify whether there is documentation (or a specific
> > > > > requirement) that calls for fw_payload.bin in this flow? If the i=
ntended
> > > > > path is fw_dynamic.bin, then the overlap issue disappears for me
> > > > >
> > > >
> > > > For the VisionFive2 and derivative boards, I intended to refer to
> > > > fw_dynamic.bin only. If I mention otherwise it was in error or for =
not
> > > > knowing what I'm looking at and reporting more information than
> > > > required. There are RISC-V boards not related to VisionFive2 or its
> > > > StarFive JH-7110 SoC that do use the fw_payload.bin approach but I =
think
> > > > I just didn't notice the difference when transcribing to e-mail.
> > > >
> > > > > Thanks for your help and guidance.
> > > > >>
> > > > >> Best regards,
> > > > >> Aristo
> > > > >
> > > > > Best regards,
> > > > > Aristo
> > > >
> > > > Thanks very much for the follow-up,
> > > Thanks for letting me know that StarFive VisionFive2 is not affected
> > > by my patch!
> > >
> > > >
> > > > -E
> > >
> > > We=E2=80=99re currently discussing a new proposal[1] for handling TI =
platforms
> > > in the FIT image spec. Ahmad Fatoum has a few questions about
> > > TI-specific implementations=E2=80=94could the TI folks on this thread=
 please
> > > take a look when you have a moment?
> > >
> > > Best regards,
> > > Aristo
> > >
> > > [1] https://github.com/open-source-firmware/flat-image-tree/issues/32
