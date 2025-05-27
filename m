Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D15C54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 16:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F8C8830F4;
	Tue, 27 May 2025 18:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="FJgLFQA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DAF983118; Tue, 27 May 2025 18:47:01 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 673A382E40
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 18:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e7c5d470a8bso2829456276.0
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1748364417; x=1748969217; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o1WcQKK9P+4mtSP3YBBDCJB5eXKD/nV9R0ViJn7KLro=;
 b=FJgLFQA/ACpQMqMwEtoavSl98lP8QpdtRUI3UGjUqLqkREnVMHXBtkhSo+/96Jbbf+
 O2jk9zVqiq7aNFlnQIPtN5EGISx1WsiVSXocn8hA7t8kmH8jHJ8uZfDUEq0K0U9F99zm
 d+r3HbDSydB4EWVcF6xF9IaCXkyBeIB5L5722sU3CoTz55Ogs48npexfJ0+kGTBYZ6IE
 hpIVbAkhdWwQYggi19CkSxODlfyQE+ijgkAAP7L6z9P+n9RhWZj5fErrxUmbMeb9GhN6
 QZVedFkNCFzRgBPt88nckVEGh11qi3NcDpjVe0zQ/YPxB5LPx+MhO8S5Oqvh202xvikU
 D+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748364417; x=1748969217;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1WcQKK9P+4mtSP3YBBDCJB5eXKD/nV9R0ViJn7KLro=;
 b=Kr+nNDJAqsxDJLys1+euZHqpizEwsc0+UC8XpSKGi1OJyYlpA0bBbVoRWptM93f1yT
 Mq4MWzVH/H1telpvKKBBgIcHBfbNmChtREDI8R7qUd7eT2rZEZ+rJkq23FjQkdLjFRyG
 MjRAi5OLUT9ZePDrbZfAS9ang5Dp08wG9JjKV0rDjp1YzGbMuNzMm2fKsy+xjgUigKdz
 YQIjzXwlxfSTbzKNOGCgcJDKSfZydJpfLkS2tR4GoYNDt/Ud/Nh5YlTDEYXjEiVPLa6o
 5cesXPyhgZXnKudOwfGM2Iht8xzy7L7pxgMSG9YUrm34qZI8PXz73z44apx39EnaOn7O
 Z9dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWke7cMqUkjp7vlzgkTI/99b0DEwuGB2Op/KiMNMphjm4pTP0ihH02oDJA2tHoHNR2KsfcaZNw=@lists.denx.de
X-Gm-Message-State: AOJu0YwT+SfAR33X64tVgO+j98GwA0hOaMlxyQ+EPIiu4xXbwpqg8uGC
 rwa77oBUlhuo9Oogh4shjE4GyLXBxBLuhsVA7VoBOMgvJBSAxylOWP5w3AGv0ixA5XCkoHWt5ac
 r838BtPvrDMP/r/I7Kh9eUFsmPAwpt5Ke+SNQBCYVbA==
X-Gm-Gg: ASbGncuz0DwlTTvuCeYVKNo7rrif7V1U32aWm/7vfY7A5LG258Y2l2L0/r94PfB7I3U
 XR+3Syx7gQgjZl/tZ8Ps61lv1tSXfIM7heHoxOwL8zNAVo6fftJuSQKVWd61uDLW0PIh8IUppTS
 M6p3jwvXPUL/pHPzApZGuB3dWtzJIgKRQ1ci4UmHH42Ho=
X-Google-Smtp-Source: AGHT+IEMANnUxrchDT0PrS+pnc1dBJRhSupSJRUyFVV/RXQo9TmzAd20QceerabUKnbQDP4iknvS5wdTVdHVHiAcmY0=
X-Received: by 2002:a05:6902:450d:b0:e7b:5578:e0a9 with SMTP id
 3f1490d57ef6-e7d918a8079mr10110891276.20.1748364416931; Tue, 27 May 2025
 09:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU3H1vjbvyZTycBQhufii5SqyTnk4AaMRk_ztGY10g9joQ@mail.gmail.com>
 <CALeDE9NNHm+qt8pPo_Hf64DvcWD6gh6qiC1g6mgidMRVJBpjWw@mail.gmail.com>
In-Reply-To: <CALeDE9NNHm+qt8pPo_Hf64DvcWD6gh6qiC1g6mgidMRVJBpjWw@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 27 May 2025 09:46:46 -0700
X-Gm-Features: AX0GCFvEKsRLgDNPUhdVKwe42XxGJClrWuUWgXxyccW_gDIrRbYZUz5dhWqTDyg
Message-ID: <CAJ+vNU2A84Cc7-uipe28wQdSmhc1jWfPZFS57n8dS-cKccmMkg@mail.gmail.com>
Subject: Re: lwip tftp not working on imx8mm
To: Peter Robinson <pbrobinson@gmail.com>
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

On Mon, May 26, 2025 at 6:25=E2=80=AFAM Peter Robinson <pbrobinson@gmail.co=
m> wrote:
>
> Hi Tim,
>
> > I've enabled LWIP on imx8mm_venice to see how it's doing and while
> > dhcp/dns/ping/wget appear to work great, tftp is broken.
> >
> > Enabling LWIP_DEBUG shows the following:
> > ip4_input: packet accepted on interface et
> > IP packet dropped since it was fragmented (0x2000) (while IP_REASSEMBLY=
 =3D=3D 0).
> >
> > I tried enabling IP_REASSEMBLY in lwip but that seems to change the iss=
ue to:
> > ip4_input: packet accepted on interface et
> > ip4_input:
> > IP header:
> > +-------------------------------+
> > | 4 | 5 |  0xc0 |       108     | (v, hl, tos, len)
> > +-------------------------------+
> > |    10568      |000|       0   | (id, flags, offset)
> > +-------------------------------+
> > |   64  |    1  |    0xe25b     | (ttl, proto, chksum)
> > +-------------------------------+
> > |  172  |   24  |    0  |    2  | (src)
> > +-------------------------------+
> > |  172  |   24  |   21  |  251  | (dest)
> > +-------------------------------+
> > ip4_input: p->len 108 p->tot_len 108
> > Unsupported transport protocol 1
> >
> > Any ideas what the issue is here?
>
> You reported the same issue some time ago [1] and while I could fine
> the original thread in my inbox, I thought we had got to the bottom of
> the issue and it had been fixed I couldn't find a follow up thread.
> Maybe Fabio can remember as I seem to recall he was the one that got
> to the bottom of the issue.
>
> Peter
>
> [1] https://lists.denx.de/pipermail/u-boot/2023-November/538832.html

Hi Peter,

At that time (before lwip was merged) none of the network apps worked
on imx fec and it was found that the root cause was that LwIP uses
malloc() to allocate the outgoing packets and didn't enforce any
alignment. This was later resolved. At one time lwip
dhcp/ping/tftp/wget worked fine for me on imx fec but its very likely
at the time I may have been using a default or smaller
CONFIG_TFTP_BLOCKSIZE.

Best Regards,

Tim
