Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D723BD2F333
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 15:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47D2A800AE;
	Tue, 13 Jan 2026 16:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gS39M7kG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2389D83015; Tue, 13 Jan 2026 16:09:56 +0100 (CET)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B4680050
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 16:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-56367a388e5so1193654e0c.2
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 07:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768316992; x=1768921792; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AxJC1S8rb3+qXyncUQIzfxOSDwqDd1aoazo7l+yYW14=;
 b=gS39M7kGcAMGpLp/LV2KaeBzvy/Jll5EeR1DOj635nQ56AcIh5E0+igvJkWkfVvmUP
 0qYPIJI9h+e2k/gpToaW/jLTr1URmJgtoIq28F7ev3fLuw7DKqyDaJeNk1nrxvwpdaW+
 Omz1vP6RvnhLF97HIqYwqqp/X/RI9pZjivyqporxl6z66qlduebOn5CABWFpcICW8SHS
 Cg2dtqM02Zfh0fsGiiHtLdnw08b4aiHtvY3YptaPhlCBqcZQO/0p7gtZcNYIDQ5NJ/qT
 NrnYg046q/Oi4IwAJOVYa/GvoK/koQcObWU0W1ZM3W5kTKvM1OXvesxEZXedXgQGnw6c
 7oHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768316992; x=1768921792;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AxJC1S8rb3+qXyncUQIzfxOSDwqDd1aoazo7l+yYW14=;
 b=KYzbEIwND9cU+Y15lrc0KmEW/09WkLknklhB7SgDCaaUIBE/dbXRCupjrGU10MJWS4
 93tFVbpIYNvBmB2hOzOPKRqZm6FBGVwRvsGN+K6vIgIoEMjDL4FXxKpjusXDlXNNDP63
 MKR/eB22mq1tEp25nPcfgMr68id36r17q8/Egdqh1l3l3+FLKGeOcI+XM5Mt++Mjak8h
 Gje+D51by2yPYya131KeHAFgylchklEfIWjGmc88VLJiXOugHVUOyp5QHY5s14e6gfKT
 LO25W2p1uIPtzyqhrnKYGOEJVvRTPdL3rhwwBZ/clWvJzINSh4Dba2514lGRn6SACBQs
 vLAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUpybIso2Ucy+OlO3cIOd9NpHxQHtSWUB4ZhYKZmsjKIxV8mYEU+FK9K9aWZ+BjnKnPk92Y2A=@lists.denx.de
X-Gm-Message-State: AOJu0YxdRPo5YBNz6xdLTtMd+sU1UdvygzYlMBuIYIIVuakHQQb4ObQo
 xwkInbTf3GbzJ53NJsVXbjMk98dlyEtjhUK/GiEzd34wRIW+BfILUFiqFOriFcAmUjkGX2wyV6p
 2p7WoByrMbCWorwQQH1HlhXtP6g79BR0=
X-Gm-Gg: AY/fxX4iq29Ti/KFtG4TZcDOKr8vES/W2SNsb5RDFZvzbS+F9xmDluKVQ2pEk9z0BYP
 qzCE21DtIDvE/KDZbbIJHNcKAqut2MUzcqFmyO7eQBXvJCrgSiAJvR3K3LVa0FfXYedU3xA41rH
 Kv/ec1Y9AOrUULL1dxvUfhRndCXN6U4CDBhLb4xnpbu94SCzN2qmnTvQdXLEvFoLeugxIZrLky1
 mJD6Put2479XfycVpM4ei7C2VSDT6R4kqXNy1pB6LOknrlxnL8nyuqcxBEzdwbY9i4yl6I=
X-Google-Smtp-Source: AGHT+IFRqvblT7bo8mn+nzo/PdQyI/dkcRtxJdF+JZBWtkA2y3dDELpmWELKfWWrB+8qcl7TPTsP5WN6P1hgm6edHYM=
X-Received: by 2002:a05:6122:1805:b0:559:5ef5:b196 with SMTP id
 71dfb90a1353d-56347fd5006mr6778154e0c.13.1768316992141; Tue, 13 Jan 2026
 07:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250924113733.uz6hozszbuynemtc@giddy>
 <20250924114317.742ae4ntrb4mvuyq@expert>
 <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
 <CAJwFiGLHDEPMsFyBhX=ogQxX_C+8ac-_9_jeiZYyo=3o0M8ZHA@mail.gmail.com>
In-Reply-To: <CAJwFiGLHDEPMsFyBhX=ogQxX_C+8ac-_9_jeiZYyo=3o0M8ZHA@mail.gmail.com>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Tue, 13 Jan 2026 23:09:16 +0800
X-Gm-Features: AZwV_Qhhr5C7jmSXrYVVvaDGCpu_My1ArB8K7jcZjlW_c5KOZeYgRg0lLWKAHRY
Message-ID: <CAJwFiGLXgsnb75HT45L5Xo-N4LmCBeLGwPi8Yr5zZzNo7mrVNg@mail.gmail.com>
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
X-Mailman-Approved-At: Tue, 13 Jan 2026 16:23:50 +0100
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

Hi E Shattow,

Aristo Chen <jj251510319013@gmail.com> =E6=96=BC 2025=E5=B9=B411=E6=9C=885=
=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:21=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi E Shattow,
>
> E Shattow <e@freeshell.de> =E6=96=BC 2025=E5=B9=B49=E6=9C=8824=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:31=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Hi Aristo,
> >
> > On 9/24/25 04:43, Nishanth Menon wrote:
> > > On 06:37-20250924, Nishanth Menon wrote:
> > >> On 10:59-20250914, Aristo Chen wrote:
> > >>> This patch series enhances FIT image robustness by adding **memory
> > >>> region overlap detection** to `mkimage` and fixing existing overlap=
s
> > >>> in DTS files and `binman` tests.
> > >
> > > [...]
> > >>>
> > >>
> > >> Looks like i see a build regression in linux-next after this series.
> > >
> > > I fat fingered that one.. sorry, I meant u-boot next.
> > >
> > >
> > > Fails at commit 4d84fa1261eb, last pass was on commit d81c1118580f
> > >
> > >>
> > >> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105f76
> > >
> > > I  believe there are outstanding comments on V1 that have'nt been
> > > addressed either. Can we revert/drop this series for now while the
> > > comments are addressed?
> > >
> >
> > Similar to Nishanth, I am seeing a build regression, itb.map:
> >
> > ImagePos    Offset      Size  Name
> > <none>      00000000  <none>    itb
> > <none>      00000000  <none>    fit
> > <none>      00000000  000c1698  uboot
> > <none>      00000000  000c1698  u-boot-nodtb
> > <none>      000c1698  00202128  opensbi
> > <none>      00000000  00202128  opensbi
> >
> > Yields this error:
> > ...
> >  MKIMAGE fit-dtb.blob
> > Warning: not able to get `load` of node 'fdt-1'
> > Warning: not able to get `load` of node 'fdt-2'
> > Warning: not able to get `load` of node 'fdt-3'
> > Warning: not able to get `load` of node 'fdt-4'
> > Warning: not able to get `load` of node 'fdt-5'
> > Warning: not able to get `load` of node 'fdt-6'
> > Warning: not able to get `load` of node 'fdt-7'
> >   CAT     u-boot-fit-dtb.bin
> > ...
> >   MKIMAGE u-boot.img
> > Warning: not able to get `load` of node 'fdt-1'
> > Warning: not able to get `load` of node 'fdt-2'
> > Warning: not able to get `load` of node 'fdt-3'
> > Warning: not able to get `load` of node 'fdt-4'
> > Warning: not able to get `load` of node 'fdt-5'
> > Warning: not able to get `load` of node 'fdt-6'
> > Warning: not able to get `load` of node 'fdt-7'
> >   COPY    u-boot.dtb
> >   MKIMAGE u-boot-dtb.img
> > Warning: not able to get `load` of node 'fdt-1'
> > Warning: not able to get `load` of node 'fdt-2'
> > Warning: not able to get `load` of node 'fdt-3'
> > Warning: not able to get `load` of node 'fdt-4'
> > Warning: not able to get `load` of node 'fdt-5'
> > Warning: not able to get `load` of node 'fdt-6'
> > Warning: not able to get `load` of node 'fdt-7'
> >   BINMAN  .binman_stamp
> > Wrote map file './itb.map' to show errors
> > binman: Error 1 running 'mkimage -t -F ./itb.fit.fit': Warning: not abl=
e
> > to get `load` of node 'fdt-1'
> > [Config: conf-1] Error: Overlap detected:
> >   - uboot: [0x40200000 - 0x402c1698]
> >   - opensbi: [0x40000000 - 0x40202128]
> >
> > make[1]: *** [/tmp/u-boot.2.git/Makefile:1339: .binman_stamp] Error 1
> > make[1]: Leaving directory '/home/es/build/u-boot'
> > make: *** [Makefile:198: sub-make] Error 2
> > make: Leaving directory '/tmp/u-boot.2.git'
> >
> > If you would like to reproduce the issue, use config
> > starfive_visionfive2_defconfig and pass to OPENSBI env variable the pat=
h
> > of opensbi object 'fw_dynamic.bin' built using PLATFORM=3Dgeneric, with
> > the ordinary gcc riscv64 toolchain. The starfive visionfive2 board
> > target in U-Boot supports multiple vendors and boards selected at
> > runtime and is an example of a more complex FIT usage that you may be
> > interested in for comparison and testing.
> >
> > Best regards,
> >
> > -E
>
> Sorry that I didn't noticed that my previous email sent to you was not
> including other people
>
> Long story short, I am now able to reproduce the overlap issue that
> you have encountered, and
> I spent some time trying to understand what is opensbi, please correct
> me if I am wrong
>
> AFAICT, there will be 2 types of firmware built, one is
> `fw_payload.bin`, and the other is
> `fw_dynamic.bin`
> - fw_payload.bin: contains the next-stage binary, so the file size
> will be bigger
> - fw_dynamic.bin: provides information about the next boot stage at
> runtime, so the size is smaller
>
> and here are the size of these 2 files built in my environment
> ```
> -rw-rw-r-- 1 ubuntu ubuntu  273048 Oct 25 14:49 fw_dynamic.bin
> -rw-rw-r-- 1 ubuntu ubuntu 2105656 Oct 25 14:49 fw_payload.bin
> ```
>
> When using my overlap checking mechanism, and passing the
> fw_dynamic.bin to build U-Boot,
> there is no overlap issue. However, when using fw_payload.bin, there
> will be an overlap issue.
>
> AFAICT, the SPL will load the opensbi firmware(assuming fw_payload.bin
> here) first, then load
> U-Boot into memory, and then jump to opensbi firmware, so I was a bit
> confused why the
> overlapped opensbi still works?
>
> I will find some time to figure out how the whole loading/booting
> process looks like, but it would
> be greatly appreciated if you can share some insight, thanks!

I finally had some time to revisit this and managed to get a VisionFive2
board for local testing.

While trying to make it bootable I noticed the following docs:
  - https://docs.u-boot.org/en/latest/board/starfive/visionfive2.html#secon=
d-stage-bootloader-opensbi-fw-dynamic-bin-u-boot-main
  - https://wiki.gentoo.org/wiki/StarFive_VisionFive_2#Building_OpenSBI

Both appear to recommend using OpenSBI=E2=80=99s fw_dynamic.bin when buildi=
ng
U=E2=80=91Boot. I couldn=E2=80=99t find any guidance on using fw_payload.bi=
n together
with U=E2=80=91Boot, which made me wonder why fw_payload.bin was used in yo=
ur
earlier report.

Could you clarify whether there is documentation (or a specific
requirement) that calls for fw_payload.bin in this flow? If the intended
path is fw_dynamic.bin, then the overlap issue disappears for me

Thanks for your help and guidance.
>
> Best regards,
> Aristo

Best regards,
Aristo
