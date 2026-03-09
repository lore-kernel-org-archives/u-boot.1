Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85524F3C24D
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 13:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2659283F6E;
	Mon,  9 Mar 2026 14:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mN3LQJaa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48A158063E; Mon,  9 Mar 2026 03:31:12 +0100 (CET)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6880C80517
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 03:31:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-56b1f4ddf83so677394e0c.2
 for <u-boot@lists.denx.de>; Sun, 08 Mar 2026 19:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773023468; cv=none;
 d=google.com; s=arc-20240605;
 b=ZKukcy46Qu6nU8lp5Cx2RoxtQfI4drpt34HPOL1iC35LFu1413wJmpCM6OCB3xla/y
 1OzlPdajVkQR5ywUnLlMHhDjxer1/nTS0UUku44CXpGg1OLZi1rljUBDr3FofFIRjAys
 vD3OnKwMJGw7rSdOpFkEzgIwXFRr2mkk/hiSYX07Bc799XArHgiYXSrfySwodUSkeZP2
 yqschBz1w6UoCtlEC6V7YYTRySZqk6juTF5wAdSCgFtbRgyw8bJ0j6TXLUmTkxgsBCBF
 alPK2m48tEl/FmVCT3stJfediPWjafp5tI5B2S61hEY5yU9tsmgfs8qFq2BBC1DhIqlU
 13uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gFnKjLXswqm/BCCYP+C7uR+jaC8kCuOrfsKjc4i8k9k=;
 fh=cLYCMo6A9BM5iRg1zMGXOS0+4qe/dAyZSTik0t9K+pg=;
 b=axZYmkWgbRJ+icSstKgeN3/AYL7Vom5B2qSLmUwkWEh2E5eo1KHuydPdWi0Ajin1Ts
 XxNDiHIbXO5CnXeTTnmhpwUPH7OcWoYdQ5iOdFcbFLvQR0udTMVbsHgr3nHjbf7dEvs8
 g/62nZKOLu3eEIoCsjti8KDX+8td8Bd72sslxk2kPJckmId5zHNChvjGsapa/KH/aDyW
 w7JD6HLAhkT+Lu0TfkNiDrkQ3/dImfJsXvdUrdhSDAj1Le8UKCDFNjhi+DzoAQQaRbvY
 BLxbjwrclc+jm1O9wqd3Iyjy/ITAC+bz/NIN7GYOgxnBOJPV0foZRxmvbr8u8upeye3k
 NLMw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773023468; x=1773628268; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gFnKjLXswqm/BCCYP+C7uR+jaC8kCuOrfsKjc4i8k9k=;
 b=mN3LQJaaJ6ngEtm5KovsCjBxxe2HvUtPRn+i8N2XxJrX9O/B7IGqHv/B/dP0weaYJV
 tp7blJIv15CG0aDT8t/0hd8oulheqjSGi6n4q+tL8du+mEqLuCqCPiTuyp4rhxygiQM/
 7Q19v3bir77K3lnJ5u8O5adNMnbBdBbAhDZK7ED6qX2wUa5peefKNRtsLz89IRvIw4Fq
 9McV1+0EhR3UQOd2ecvPRCed5fAqIj7e7DFcxnnbPFa+Gak836Kv4rYvHedQA5uu94yY
 cMfclu70StzT3JndLEA98lj86+vV2xBHf/W2shbop59OSauY9D6vIQQ/5UA5Mlo5kU+h
 P7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773023468; x=1773628268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gFnKjLXswqm/BCCYP+C7uR+jaC8kCuOrfsKjc4i8k9k=;
 b=vkvZS31p1eKpqVXCFryr2xNbyj8a9p2+xfoRGi9FBpg5m2hyET8mKvth1ExsQ62bh4
 6UajuYmKfCZZkZU3gXmaJxaQ3eV2ijhA9tst5Day4aYabjgURO5OJpAB8z25DdS77lF6
 DHirOMFf2+QIA47EiP7ZCVQ75jLjDM0LwIxC+PSSBd5HJvr17gdSvL/UN1yAT9xWA/f+
 gzQWsLIyZy0bMdHJISwLZwBOYd+kPqkL+bf2q1ZU7ZFagei1d4/gslrPsJ4oSorZhdgq
 iJ3s13dCve5uqpOKYovV+9QfFsc/jyxn/6m0hMIScH/QXllDCCVA8f+xLNdWkP3v/1Dw
 4zdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXccMaHAAii5SVwxRnA9NKUN1Z6KLgOLVVE8jsI7GQqr0keUVyuzFRttjbgeVagpqsKEP/FUcE=@lists.denx.de
X-Gm-Message-State: AOJu0YyPmnv0ZqekvO1Uzo3CWejUWfT3C+Al6lVLQEqaRoYpU4h2TkTs
 QCNTwG5g/ENF053OElHe0IT62h2ICaaiK+JYdEWwV8a4judhzuWeG58tmh8UEGcTRYyS/U0EQNH
 8W/54F7zHHCzN3ZyjKR8hbpyzq75OWD0=
X-Gm-Gg: ATEYQzyWpGxk0kFbYse4dQqbJKov4hc4YjcgRPFVu5Cy9+dSClPPj/s7re3LFlE8heQ
 K4TPHmI3Q16n39kfkgR6M4EgjSQEt4BhGUTGq3G3gQFjWWX65r5INeCZS7cz5Hadn0KY4OOqfWl
 pn1GhUuQNCUMJqIuXqI+hcZMkTJKI2FhdT7CKWNQIm0TdUzh3S+XIgiAMSr40JvScp8b7zP06Jr
 lMEY8s0bB3ql67v3Sa9AF8eopXgTSSR7yyzfCmp4FJvqbZ0x5hgKNV1SL4hFBuBJhSUD1BXcbwQ
 19d/i5mIrWw1R9BTbWs=
X-Received: by 2002:a05:6122:3114:b0:56a:899d:6869 with SMTP id
 71dfb90a1353d-56b07d9ccdamr3961357e0c.8.1773023467771; Sun, 08 Mar 2026
 19:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250924113733.uz6hozszbuynemtc@giddy>
 <20250924114317.742ae4ntrb4mvuyq@expert>
 <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
 <CAJwFiGLHDEPMsFyBhX=ogQxX_C+8ac-_9_jeiZYyo=3o0M8ZHA@mail.gmail.com>
 <CAJwFiGLXgsnb75HT45L5Xo-N4LmCBeLGwPi8Yr5zZzNo7mrVNg@mail.gmail.com>
 <873d73f0-34fe-4445-8745-f98734637b0c@freeshell.de>
 <CAJwFiGJsnK3CRhYBYmE0fGpds0AOvVhRv___JaBNPjGhiYRCNA@mail.gmail.com>
In-Reply-To: <CAJwFiGJsnK3CRhYBYmE0fGpds0AOvVhRv___JaBNPjGhiYRCNA@mail.gmail.com>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Mon, 9 Mar 2026 10:30:31 +0800
X-Gm-Features: AaiRm50o4ppOAWOk7DAQ-R7FiDHseTUK4uDiiY4we9r7dxEgthgu4-EgbpjMIZs
Message-ID: <CAJwFiGKVqRsNjvhd4Qjo8S8AxVMTpTvxu51tCaJA6j6a+7-RAw@mail.gmail.com>
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
X-Mailman-Approved-At: Mon, 09 Mar 2026 14:13:07 +0100
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

I have put some thoughts in the github issue[1] that we are discussing
FIT image spec, could you please take a look when you have time?

Best regards,
Aristo

[1] https://github.com/open-source-firmware/flat-image-tree/issues/32

Aristo Chen <jj251510319013@gmail.com> =E6=96=BC 2026=E5=B9=B42=E6=9C=8810=
=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:16=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi E Shattow and all,
>
> E Shattow <e@freeshell.de> =E6=96=BC 2026=E5=B9=B41=E6=9C=8814=E6=97=A5=
=E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=881:29=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Hi Aristo,
> >
> > On 1/13/26 07:09, Aristo Chen wrote:
> > > Hi E Shattow,
> > >
> > > Aristo Chen <jj251510319013@gmail.com> =E6=96=BC 2025=E5=B9=B411=E6=
=9C=885=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:21=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > >>
> > >> Hi E Shattow,
> > >>
> > >> E Shattow <e@freeshell.de> =E6=96=BC 2025=E5=B9=B49=E6=9C=8824=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:31=E5=AF=AB=E9=81=93=EF=BC=9A
> > >>>
> > >>> Hi Aristo,
> > >>>
> > >>> On 9/24/25 04:43, Nishanth Menon wrote:
> > >>>> On 06:37-20250924, Nishanth Menon wrote:
> > >>>>> On 10:59-20250914, Aristo Chen wrote:
> > >>>>>> This patch series enhances FIT image robustness by adding **memo=
ry
> > >>>>>> region overlap detection** to `mkimage` and fixing existing over=
laps
> > >>>>>> in DTS files and `binman` tests.
> > >>>>
> > >>>> [...]
> > >>>>>>
> > >>>>>
> > >>>>> Looks like i see a build regression in linux-next after this seri=
es.
> > >>>>
> > >>>> I fat fingered that one.. sorry, I meant u-boot next.
> > >>>>
> > >>>>
> > >>>> Fails at commit 4d84fa1261eb, last pass was on commit d81c1118580f
> > >>>>
> > >>>>>
> > >>>>> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105f76
> > >>>>
> > >>>> I  believe there are outstanding comments on V1 that have'nt been
> > >>>> addressed either. Can we revert/drop this series for now while the
> > >>>> comments are addressed?
> > >>>>
> > >>>
> > >>> Similar to Nishanth, I am seeing a build regression, itb.map:
> > >>>
> > >>> ImagePos    Offset      Size  Name
> > >>> <none>      00000000  <none>    itb
> > >>> <none>      00000000  <none>    fit
> > >>> <none>      00000000  000c1698  uboot
> > >>> <none>      00000000  000c1698  u-boot-nodtb
> > >>> <none>      000c1698  00202128  opensbi
> > >>> <none>      00000000  00202128  opensbi
> > >>>
> > >>> Yields this error:
> > >>> ...
> > >>>  MKIMAGE fit-dtb.blob
> > >>> Warning: not able to get `load` of node 'fdt-1'
> > >>> Warning: not able to get `load` of node 'fdt-2'
> > >>> Warning: not able to get `load` of node 'fdt-3'
> > >>> Warning: not able to get `load` of node 'fdt-4'
> > >>> Warning: not able to get `load` of node 'fdt-5'
> > >>> Warning: not able to get `load` of node 'fdt-6'
> > >>> Warning: not able to get `load` of node 'fdt-7'
> > >>>   CAT     u-boot-fit-dtb.bin
> > >>> ...
> > >>>   MKIMAGE u-boot.img
> > >>> Warning: not able to get `load` of node 'fdt-1'
> > >>> Warning: not able to get `load` of node 'fdt-2'
> > >>> Warning: not able to get `load` of node 'fdt-3'
> > >>> Warning: not able to get `load` of node 'fdt-4'
> > >>> Warning: not able to get `load` of node 'fdt-5'
> > >>> Warning: not able to get `load` of node 'fdt-6'
> > >>> Warning: not able to get `load` of node 'fdt-7'
> > >>>   COPY    u-boot.dtb
> > >>>   MKIMAGE u-boot-dtb.img
> > >>> Warning: not able to get `load` of node 'fdt-1'
> > >>> Warning: not able to get `load` of node 'fdt-2'
> > >>> Warning: not able to get `load` of node 'fdt-3'
> > >>> Warning: not able to get `load` of node 'fdt-4'
> > >>> Warning: not able to get `load` of node 'fdt-5'
> > >>> Warning: not able to get `load` of node 'fdt-6'
> > >>> Warning: not able to get `load` of node 'fdt-7'
> > >>>   BINMAN  .binman_stamp
> > >>> Wrote map file './itb.map' to show errors
> > >>> binman: Error 1 running 'mkimage -t -F ./itb.fit.fit': Warning: not=
 able
> > >>> to get `load` of node 'fdt-1'
> > >>> [Config: conf-1] Error: Overlap detected:
> > >>>   - uboot: [0x40200000 - 0x402c1698]
> > >>>   - opensbi: [0x40000000 - 0x40202128]
> > >>>
> > >>> make[1]: *** [/tmp/u-boot.2.git/Makefile:1339: .binman_stamp] Error=
 1
> > >>> make[1]: Leaving directory '/home/es/build/u-boot'
> > >>> make: *** [Makefile:198: sub-make] Error 2
> > >>> make: Leaving directory '/tmp/u-boot.2.git'
> > >>>
> > >>> If you would like to reproduce the issue, use config
> > >>> starfive_visionfive2_defconfig and pass to OPENSBI env variable the=
 path
> > >>> of opensbi object 'fw_dynamic.bin' built using PLATFORM=3Dgeneric, =
with
> > >>> the ordinary gcc riscv64 toolchain. The starfive visionfive2 board
> > >>> target in U-Boot supports multiple vendors and boards selected at
> > >>> runtime and is an example of a more complex FIT usage that you may =
be
> > >>> interested in for comparison and testing.
> > >>>
> > >>> Best regards,
> > >>>
> > >>> -E
> > >>
> > >> Sorry that I didn't noticed that my previous email sent to you was n=
ot
> > >> including other people
> > >>
> > >> Long story short, I am now able to reproduce the overlap issue that
> > >> you have encountered, and
> > >> I spent some time trying to understand what is opensbi, please corre=
ct
> > >> me if I am wrong
> > >>
> > >> AFAICT, there will be 2 types of firmware built, one is
> > >> `fw_payload.bin`, and the other is
> > >> `fw_dynamic.bin`
> > >> - fw_payload.bin: contains the next-stage binary, so the file size
> > >> will be bigger
> > >> - fw_dynamic.bin: provides information about the next boot stage at
> > >> runtime, so the size is smaller
> > >>
> > >> and here are the size of these 2 files built in my environment
> > >> ```
> > >> -rw-rw-r-- 1 ubuntu ubuntu  273048 Oct 25 14:49 fw_dynamic.bin
> > >> -rw-rw-r-- 1 ubuntu ubuntu 2105656 Oct 25 14:49 fw_payload.bin
> > >> ```
> > >>
> > >> When using my overlap checking mechanism, and passing the
> > >> fw_dynamic.bin to build U-Boot,
> > >> there is no overlap issue. However, when using fw_payload.bin, there
> > >> will be an overlap issue.
> > >>
> > >> AFAICT, the SPL will load the opensbi firmware(assuming fw_payload.b=
in
> > >> here) first, then load
> > >> U-Boot into memory, and then jump to opensbi firmware, so I was a bi=
t
> > >> confused why the
> > >> overlapped opensbi still works?
> > >>
> > >> I will find some time to figure out how the whole loading/booting
> > >> process looks like, but it would
> > >> be greatly appreciated if you can share some insight, thanks!
> > >
> > > I finally had some time to revisit this and managed to get a VisionFi=
ve2
> > > board for local testing.
> > >
> > > While trying to make it bootable I noticed the following docs:
> > >   - https://docs.u-boot.org/en/latest/board/starfive/visionfive2.html=
#second-stage-bootloader-opensbi-fw-dynamic-bin-u-boot-main
> > >   - https://wiki.gentoo.org/wiki/StarFive_VisionFive_2#Building_OpenS=
BI
> > >
> > > Both appear to recommend using OpenSBI=E2=80=99s fw_dynamic.bin when =
building
> > > U=E2=80=91Boot. I couldn=E2=80=99t find any guidance on using fw_payl=
oad.bin together
> > > with U=E2=80=91Boot, which made me wonder why fw_payload.bin was used=
 in your
> > > earlier report.
> > >
> >
> > Likely I mixed up the filenames when writing in conversation, as I did
> > when writing on the opensbi mailing list about a dependency tracking bu=
g
> > in opensbi build system:
> >
> > https://lore.kernel.org/opensbi/0d6bf7c7-7605-4ad6-a35c-54efc5230fb8@si=
five.com/
> >
> > and
> >
> > https://lore.kernel.org/opensbi/36cfe431-40fb-470d-b50e-00a139d480f8@fr=
eeshell.de/
> >
> > ...which is clearly a mistake to write "OPENSBI=3D/path/to/fw_payload.b=
in"
> > when it should instead be "OPENSBI=3D/path/to/fw_dynamic.bin",
> > acknowledged in the follow-up message:
> >
> > https://lore.kernel.org/opensbi/32873fc7-2cc8-46d5-9f4e-3a16cf95f48a@fr=
eeshell.de/
> >
> > > Could you clarify whether there is documentation (or a specific
> > > requirement) that calls for fw_payload.bin in this flow? If the inten=
ded
> > > path is fw_dynamic.bin, then the overlap issue disappears for me
> > >
> >
> > For the VisionFive2 and derivative boards, I intended to refer to
> > fw_dynamic.bin only. If I mention otherwise it was in error or for not
> > knowing what I'm looking at and reporting more information than
> > required. There are RISC-V boards not related to VisionFive2 or its
> > StarFive JH-7110 SoC that do use the fw_payload.bin approach but I thin=
k
> > I just didn't notice the difference when transcribing to e-mail.
> >
> > > Thanks for your help and guidance.
> > >>
> > >> Best regards,
> > >> Aristo
> > >
> > > Best regards,
> > > Aristo
> >
> > Thanks very much for the follow-up,
> Thanks for letting me know that StarFive VisionFive2 is not affected
> by my patch!
>
> >
> > -E
>
> We=E2=80=99re currently discussing a new proposal[1] for handling TI plat=
forms
> in the FIT image spec. Ahmad Fatoum has a few questions about
> TI-specific implementations=E2=80=94could the TI folks on this thread ple=
ase
> take a look when you have a moment?
>
> Best regards,
> Aristo
>
> [1] https://github.com/open-source-firmware/flat-image-tree/issues/32
