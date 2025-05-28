Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7CCC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 17:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 323B683330;
	Wed, 28 May 2025 19:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fg/KU6ou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53AF683276; Wed, 28 May 2025 19:23:28 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB8C983330
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 19:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ad51ba0af48so201076066b.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748453005; x=1749057805; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=imLhpDBYwie6ovY2GQVq/mRywZ6STK8mLb9lAS9TGYo=;
 b=Fg/KU6ouIauuOE4kxbbR4hZFpaE2VUk4I1WoICqDRCMEaAfn32L14xUQIEvX+GH/3t
 PyNIq1sEN4zy18Fz8WWLrOS5VKRKf97Y2Z7mzLDMuMF6q4DhNisj14xkcjI0i9HHj8Bv
 WZKccIRuNoEk3G6QQRCkv2/LEsTDYq6q/upayGXWxLMilld69UTUCBOc0za5KMgQi6hp
 5fZg2TQD7ObocHBrT4UE3tU7+IU4yi0JcrQWlM90mSgaS+LRXWq0mVbhKyS1FRdxdVty
 36FJpgUxH7lZV+BiezmI2SzzUflYvh+vPF/W29Zl3oHc9vN6Lbx47vs8zaocADEZuhI7
 aaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748453005; x=1749057805;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=imLhpDBYwie6ovY2GQVq/mRywZ6STK8mLb9lAS9TGYo=;
 b=lwPoZcHrzVCLbU/tfwrjCt+RhiWdUi6syuXXu5FTemTNqhYlmbZv/ld4c0oYVs7mdS
 yjOjltwdTFEGVZagRnxULxesS0C+mi4Tch/a4Zta6PZ2rSZ1v5aDUKoWtl2K4GYXzTg3
 4JwXoMoBEpUiTeW1SMVHDHUE3hAyjW7kVslzM63deOtYSNHATHy/FWRAoP+kE5qnieGl
 i4YC9LVFoM53DVoa3J93qmp/TvdSHajJ87RpFppFIXi5znY4sQvnLGxshxMm08Au/wr4
 8u+XP1XnMIK6e02Nw5MZ6vcDpT391IsQBVI48yKpuhjs6BF3jF6glA6gl6qfMwNwfTnd
 Hmjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVamEWYBfeRmcWuQYyfBzrz5DvhtIf4CHbDWMfJP+ZiSRDKF1eCFaB60m2sVuFgQGdaNccl+ug=@lists.denx.de
X-Gm-Message-State: AOJu0YwqIgY67Xc0dM4S7K0FI+b+qZiqJOHg1zB7c9GsKqswT2D++4ll
 b8B9zLWfWhcdpZ+DSecMuOcNJcmYeRcnwd1hSEh3YwvBXzyXRATVCbZYFwmlBIZrA3m1byT1NCZ
 4hq6YdNCJHoHQuLH2Y8C7IlXT2MlKdXo=
X-Gm-Gg: ASbGncswcx27fdxJcJShSlAABpyFF6rJkb8hHaQIbsuWnK8TYtfrj61isFZ8DUP/VBg
 AUYvxXmETzQdzGsbcKOzAJY47wnHJOn8T8KM43curN/mOtPYUYryj/rHHCIZK90Dkb2IRWbGIfu
 40F/qGTdCCLHCBkEEmntunswPEDT65FyLz7s6RPdcOD5Ibywdsn9CgfZrNhFkWHXmMyQ==
X-Google-Smtp-Source: AGHT+IHMjQ1fOrgPeTZvgoIa5zy+DFf23PVT+QL0Jc9SMpr0LahRu+Z9um+tdQH73zgxhAqZVAl66x1qKA9ijYYiDsg=
X-Received: by 2002:a17:907:6d06:b0:ad5:4cde:fb97 with SMTP id
 a640c23a62f3a-ad8b0e940b9mr43407266b.29.1748453005149; Wed, 28 May 2025
 10:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU3H1vjbvyZTycBQhufii5SqyTnk4AaMRk_ztGY10g9joQ@mail.gmail.com>
 <6e667ef9-9fa0-441b-8520-46e7bdbc344a@linaro.org>
 <CAJ+vNU0kY=iNR6Q3PR6+x=wqv2932=1E+Ci0CwvURCPh6JD5-A@mail.gmail.com>
 <ebb48519-a02b-4b06-a801-f9c05fccd428@linaro.org>
 <CAJ+vNU2rOgp77+ML7LYuVu5hYFOwkbRytG8q2+NeXm7OgSL0vg@mail.gmail.com>
In-Reply-To: <CAJ+vNU2rOgp77+ML7LYuVu5hYFOwkbRytG8q2+NeXm7OgSL0vg@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 28 May 2025 18:23:13 +0100
X-Gm-Features: AX0GCFs8VLWBz_tXovlyJzfcrK2eOYk8D35t53oS6efDXIX-YHqL_l7Er0lI7h4
Message-ID: <CALeDE9Odhr5OOrcGj+3-fyj4XrxAN+QMnrHW_sjSjicD1HrB2w@mail.gmail.com>
Subject: Re: lwip tftp not working on imx8mm
To: Tim Harvey <tharvey@gateworks.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot <u-boot@lists.denx.de>, Fabio Estevam <festevam@gmail.com>
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

On Wed, 28 May 2025 at 17:59, Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Wed, May 28, 2025 at 5:24=E2=80=AFAM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> >
> >
> > On 5/27/25 18:35, Tim Harvey wrote:
> > > On Mon, May 26, 2025 at 5:17=E2=80=AFAM Jerome Forissier
> > > <jerome.forissier@linaro.org> wrote:
> > >>
> > >> Hi Tim,
> > >>
> > >> On 5/23/25 20:31, Tim Harvey wrote:
> > >>> Hi Jerome,
> > >>>
> > >>> I've enabled LWIP on imx8mm_venice to see how it's doing and while
> > >>> dhcp/dns/ping/wget appear to work great, tftp is broken.
> > >>>
> > >>> Enabling LWIP_DEBUG shows the following:
> > >>> ip4_input: packet accepted on interface et
> > >>> IP packet dropped since it was fragmented (0x2000) (while IP_REASSE=
MBLY =3D=3D 0).
> > >>
> > >> Hmmmmm IP_REASSEMBLY should probably default to 1.
> > >>>
> > >>> I tried enabling IP_REASSEMBLY in lwip but that seems to change the=
 issue to:
> > >>> ip4_input: packet accepted on interface et
> > >>> ip4_input:
> > >>> IP header:
> > >>> +-------------------------------+
> > >>> | 4 | 5 |  0xc0 |       108     | (v, hl, tos, len)
> > >>> +-------------------------------+
> > >>> |    10568      |000|       0   | (id, flags, offset)
> > >>> +-------------------------------+
> > >>> |   64  |    1  |    0xe25b     | (ttl, proto, chksum)
> > >>> +-------------------------------+
> > >>> |  172  |   24  |    0  |    2  | (src)
> > >>> +-------------------------------+
> > >>> |  172  |   24  |   21  |  251  | (dest)
> > >>> +-------------------------------+
> > >>> ip4_input: p->len 108 p->tot_len 108
> > >>> Unsupported transport protocol 1
> > >>>
> > >>> Any ideas what the issue is here?
> > >>
> > >> Not really :-/ Does the transfer work with a smaller block size?
> > >> (CONFIG_TFTP_BLOCKSIZE, default 1468, try 500 for instance). You cou=
ld
> > >> also enable CONFIG_LWIP_DEBUG_RXTX in order to get a full hex dump o=
f
> > >> the messages going into/out of the lwIP stack.
> > >
> > > Hi Jerome,
> > >
> > > My config was with 4096, setting it to 1468 works and anything above
> > > that seems to cause this failure.
> >
> > Good to know.
> >
> > > Some sort of fragmentation issue?
> >
> > Quite possibly, yes. In any case it does not make much sense to use a
> > clock size that causes the packet to be larger than the PMTU (it would
> > be sub-optimal) but it should definitely work, especially since I don't
> > believe PMTU discovery is implemented in lwIP. I add this to my to-do
> > list but feel free to investigate further :)
> >
>
> Hi Jerome,
>
> I'll take a look at it as larger than MTU packets are definitely not
> suboptimal for TFTP. A 4096B block size will ack once per 4K so 4x
> less ACK's and in my testing the 4K blocksize gives a 3x performance
> boost on large files.

Refreshing my memory on TFTP slightly, I think larger than MTU tftp
transfers need support for RFC 2348 [1], maybe that's something we
need to explicitly enable if the TFTP layer is part of LWIP (or maybe
LWIP doesn't support it), or if the tftp application is ours on top of
LWIP maybe we're missing some glue. I didn't look at the code, rather
this was from some of my own notes from a long time ago.

[1] https://www.rfc-editor.org/rfc/rfc2348
