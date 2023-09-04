Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B40C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 09:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1BDE868D3;
	Mon,  4 Sep 2023 11:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zzu5so3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9F81868D3; Mon,  4 Sep 2023 11:20:29 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63E48868E8
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 11:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52a250aa012so1603558a12.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693819227; x=1694424027; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DDVfI8m4Ri1KfmUC9tgiczYg+qOnqkS+TkXjEOYURcc=;
 b=Zzu5so3NhF+Qv4AGE4a1Gd8szMAST0NwlsFDxp9WfyU7wUpv9drfpEAT1Xw02uYPBY
 bdns/zx4SrZeRDMCvQfZTEJw5MbhSgQgD+Jt58eLvUuYRWhMp10uGsu7XmdasC6K1gtu
 yToIxRzB195WyQ+OoEcbiI7xCe/+7ZLgGoVbxFMGS5xBMd3tjwJiwWYEZZsgjLILwRjH
 9UjMMfAc2fr0L2a4/UUdnAGch6Nh6kmGExa4QGZV40vAfQw7Lr29itFn9R2sn8c5Jz3R
 nw5qbVuINCwyyzxjm7Gm0DmiOT7xI9FHkgu6nxXVuQ6tYernzue95MhDy8AF8LMIOoV3
 AhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693819227; x=1694424027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DDVfI8m4Ri1KfmUC9tgiczYg+qOnqkS+TkXjEOYURcc=;
 b=SG5thszLWEV+yWPHDYgBNrPRX611CLo18ePHNEI8f2DkBXkzNVT2YbwB2sc4hiNwdu
 gk18AktPuFt1aKYacVlkgiis4vozizoc33pfJ17eCQnvJYLZkveAVn6xdn6pnsV5M5Iv
 rIP5t47TfvLIake6jI+2qcJ4aSQbnE25KegwTVsyJf7uCpvVxj5ZPgWxdTK/jAobfyK/
 DYBabir5cy7ZTbs5vUUmZK5SXYKJy+/pmVh4/d3SN7AVCzwTh6POu6PsIiuSad4NnHba
 /ZiHx2mLM0L6PVPpuZshtGn5M8o6+uKBTb9bL5jIBz95/dLJHuvxfQtpe53oneSFa0iE
 Pt+Q==
X-Gm-Message-State: AOJu0YyFZHjy50CwrrLpPiISyB/lHPvjcMY7k8ZnToJ9A7Qp9aGBov7g
 mJPbIqEfS84UiL71GTPR750K+UW3o1XCCLG9qbI=
X-Google-Smtp-Source: AGHT+IGup2ozU4m904ZiZ747w6RIZmZhv0at7C/vAwfkFmyRCqU3loasgU6/w3edIQMkSR3tArtykRWSfu2kn86gA9o=
X-Received: by 2002:a50:fe8e:0:b0:529:fa63:ef80 with SMTP id
 d14-20020a50fe8e000000b00529fa63ef80mr6555572edt.28.1693819226691; Mon, 04
 Sep 2023 02:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230823184746.842091-1-sjg@chromium.org>
 <20230823184746.842091-8-sjg@chromium.org>
 <6f1ea3e9-7284-22d3-e2ee-071523b7dbac@gmx.de>
 <CAPnjgZ3i9EDe3CyU64WRpE+oR0-xS2iffQR=2hVBZRzA2KkC6Q@mail.gmail.com>
 <2058DF5A-619E-4B47-A80E-4B5C56FC3573@gmx.de>
In-Reply-To: <2058DF5A-619E-4B47-A80E-4B5C56FC3573@gmx.de>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 4 Sep 2023 17:20:12 +0800
Message-ID: <CAEUhbmWvEXvB6UmtsvHe5M13dMqS2BQF6Q-fdapYDVh3ROG73A@mail.gmail.com>
Subject: Re: [PATCH 7/8] spl: x86: Avoid starting up PCI automatically in SPL
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Simon,

On Thu, Aug 24, 2023 at 10:11=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
>
>
> Am 24. August 2023 01:57:55 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi Heinrich,
> >
> >On Wed, 23 Aug 2023 at 14:19, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
> >>
> >> On 8/23/23 20:47, Simon Glass wrote:
> >> > For x86 platforms, PCI is core to their operation and is managed in
> >> > arch-specific code. Each platform has its own way of doing this. For=
 TPL
> >> > and some SPL implementations, the full driver model PCI is not used.
> >> >
> >> > A recent change enabled full PCI in TPL/SPL for all boards. This bre=
aks
> >> > some x86 boards, so adjust it to skip that for x86.
> >>
> >> Could you, please, give some more detail?
> >>
> >> * Which boards are broken?
> >
> >For example, chromebook_samus and chromebook_samus_tpl
> >
> >> * Don't these boards have a pci_init() function?
> >
> >Yes, the same one you are calling.
> >
> >> * In what way does calling pci_init() lead to a failure?
> >
> >It probes and sets up PCI devices and uses a lot of pre-alloc RAM.
> >
> >>
> >> It would be preferable to have all architectures and boards use the sa=
me
> >> high level API. Excluding x86 here looks more like a (necessary) hack
> >> than like a target state.
> >
> >Fair enough, but on x86 we access PCI long before driver model is up.
> >Generally we don't fully enumerate it in SPL as it is expensive. It is
> >also pointless, since U-Boot proper does it again later.
> >
> >Regards,
> >Simon
> >
>
> Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>

To address Heinrich's concern, how about you turn off CONFIG_SPL_PCI
in chromebook_samus and chromebook_samus_tpl?

Regards,
Bin
