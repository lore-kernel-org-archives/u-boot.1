Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86117C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 19:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6457A833F6;
	Wed, 28 May 2025 21:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="b043aLli";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A530B833FC; Wed, 28 May 2025 21:48:28 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1C61833D0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 21:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e733a6ff491so155284276.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 12:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1748461704; x=1749066504; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/vB7T/e524b1hDgawdpJRyiaHyBm0nY/dnOC5GDvNY=;
 b=b043aLlibUEUCNj8QKrf0qYP7kDJkfh4Sc2K0NH+AiqqWibi1tsCVvRrBZeSMFhHay
 yjoONm+guuJnygndipgp8ewilu+9EbENfD2QaoG2gSyTP7FlP2PHs2H13qtOYxVQeVUg
 LxgbVc3TRon30iR8Lj9iUAehw/yXLMnbdZgIjOaakwYBcK2eaP0Lk73kwYvJi1dm/l+8
 neO0CBIbRlvrCv7iK9/cWjax3WwsFYcMJpTTs6MhC9+BAFzYTP/kQKXr/RoUvh71HZCW
 I7Qde0sQbT3ZLHCZpEwNlwS7uq3DANwOzv6Iqb/oKXzGqjTswv/eKtKQZVQ4B/gIqbch
 sMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748461704; x=1749066504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o/vB7T/e524b1hDgawdpJRyiaHyBm0nY/dnOC5GDvNY=;
 b=toWsX2LFR+zYXPVNzw1c33bvPTohLF+o8IZihdcZMu8tMVAMhXMF7gI5vbnHqtjgPu
 baQ0VEhIFDjYgKoTJFEX8lB5WHlNmRlTcoYftbZW8xWKmSZzwVjrFPvyBT53YqtRe6Qo
 MyeCeBk6N2K2taR3hjTORB3kovT6EPHRuppFVd2t3bZo3qewL3SnbPCSethQmgP1kd6U
 nQW3FCUygmyalKhaAzA01m3u8NNUhLoFwuX9Te8MBwX1k8OdJmOh6ydv3I0BZvwFpESV
 nC+IfeVy//2bKShGQvIvjHVVOl0SdHXwrWYFcurAlcWBjgRTCltDKMmDjISoYkcSuncm
 8dxA==
X-Gm-Message-State: AOJu0YwRWnzvmAqQmmmXdsSUNGyEVvJ1Q0uu/fItGxH+QM1iEB/niu0K
 2IHpBhqLKWnlbaNTcZJ/F9RIWi8aAhO5A449LyX8ITTBzh8BDGlBiUZrAts+ZPWmeCfTtPL6Yl9
 uqcnBv6oEwMSmmpgYiTIv1Ezy9Mk3rkd3WmfVAA+ASA==
X-Gm-Gg: ASbGncvPHKnHmKgX9KR9cpPmTMcBd4KhfGcicEsMlG6MlSk18YonY1NAVe99SkcJBtq
 uq2Eg7cKT6qGZGHYWRWLPYHW3xl4jLGVNXe//GFr8mS6Wtr+19j2Evwdf/OGXyQVPevT+pz+44J
 FF1TjF5mrIrB6jEkEh9kW/EazX/Ol2gJMr
X-Google-Smtp-Source: AGHT+IG0LHgX542qna4MqA6zYGyeBMrRpwesXruL9Gz2q9wwawzc3zEQaik/nIB/enb+mmSDnt4f6CHw9y1t+/fEJj4=
X-Received: by 2002:a05:6902:1501:b0:e7d:b655:8c0 with SMTP id
 3f1490d57ef6-e7db655136cmr13420413276.8.1748461704437; Wed, 28 May 2025
 12:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU3H1vjbvyZTycBQhufii5SqyTnk4AaMRk_ztGY10g9joQ@mail.gmail.com>
 <6e667ef9-9fa0-441b-8520-46e7bdbc344a@linaro.org>
 <CAJ+vNU0kY=iNR6Q3PR6+x=wqv2932=1E+Ci0CwvURCPh6JD5-A@mail.gmail.com>
 <ebb48519-a02b-4b06-a801-f9c05fccd428@linaro.org>
 <CAJ+vNU2rOgp77+ML7LYuVu5hYFOwkbRytG8q2+NeXm7OgSL0vg@mail.gmail.com>
 <CALeDE9Odhr5OOrcGj+3-fyj4XrxAN+QMnrHW_sjSjicD1HrB2w@mail.gmail.com>
In-Reply-To: <CALeDE9Odhr5OOrcGj+3-fyj4XrxAN+QMnrHW_sjSjicD1HrB2w@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 28 May 2025 12:48:12 -0700
X-Gm-Features: AX0GCFurq2OOGimmwJ4tHQFD2c99LowcN9YQybFCkKcO8Gb-RL1yn84F09tK2o8
Message-ID: <CAJ+vNU2yBvT49XkZDoHPQM2nd3qfe3WhSK8azFa9ZR2pSmaXPg@mail.gmail.com>
Subject: Re: lwip tftp not working on imx8mm
To: Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot <u-boot@lists.denx.de>, Fabio Estevam <festevam@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
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

On Wed, May 28, 2025 at 10:23=E2=80=AFAM Peter Robinson <pbrobinson@gmail.c=
om> wrote:
>
> On Wed, 28 May 2025 at 17:59, Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > On Wed, May 28, 2025 at 5:24=E2=80=AFAM Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> > >
> > >
> > >
> > > On 5/27/25 18:35, Tim Harvey wrote:
> > > > On Mon, May 26, 2025 at 5:17=E2=80=AFAM Jerome Forissier
> > > > <jerome.forissier@linaro.org> wrote:
> > > >>
> > > >> Hi Tim,
> > > >>
> > > >> On 5/23/25 20:31, Tim Harvey wrote:
> > > >>> Hi Jerome,
> > > >>>
> > > >>> I've enabled LWIP on imx8mm_venice to see how it's doing and whil=
e
> > > >>> dhcp/dns/ping/wget appear to work great, tftp is broken.
> > > >>>
> > > >>> Enabling LWIP_DEBUG shows the following:
> > > >>> ip4_input: packet accepted on interface et
> > > >>> IP packet dropped since it was fragmented (0x2000) (while IP_REAS=
SEMBLY =3D=3D 0).
> > > >>
> > > >> Hmmmmm IP_REASSEMBLY should probably default to 1.
> > > >>>
> > > >>> I tried enabling IP_REASSEMBLY in lwip but that seems to change t=
he issue to:
> > > >>> ip4_input: packet accepted on interface et
> > > >>> ip4_input:
> > > >>> IP header:
> > > >>> +-------------------------------+
> > > >>> | 4 | 5 |  0xc0 |       108     | (v, hl, tos, len)
> > > >>> +-------------------------------+
> > > >>> |    10568      |000|       0   | (id, flags, offset)
> > > >>> +-------------------------------+
> > > >>> |   64  |    1  |    0xe25b     | (ttl, proto, chksum)
> > > >>> +-------------------------------+
> > > >>> |  172  |   24  |    0  |    2  | (src)
> > > >>> +-------------------------------+
> > > >>> |  172  |   24  |   21  |  251  | (dest)
> > > >>> +-------------------------------+
> > > >>> ip4_input: p->len 108 p->tot_len 108
> > > >>> Unsupported transport protocol 1
> > > >>>
> > > >>> Any ideas what the issue is here?
> > > >>
> > > >> Not really :-/ Does the transfer work with a smaller block size?
> > > >> (CONFIG_TFTP_BLOCKSIZE, default 1468, try 500 for instance). You c=
ould
> > > >> also enable CONFIG_LWIP_DEBUG_RXTX in order to get a full hex dump=
 of
> > > >> the messages going into/out of the lwIP stack.
> > > >
> > > > Hi Jerome,
> > > >
> > > > My config was with 4096, setting it to 1468 works and anything abov=
e
> > > > that seems to cause this failure.
> > >
> > > Good to know.
> > >
> > > > Some sort of fragmentation issue?
> > >
> > > Quite possibly, yes. In any case it does not make much sense to use a
> > > clock size that causes the packet to be larger than the PMTU (it woul=
d
> > > be sub-optimal) but it should definitely work, especially since I don=
't
> > > believe PMTU discovery is implemented in lwIP. I add this to my to-do
> > > list but feel free to investigate further :)
> > >
> >
> > Hi Jerome,
> >
> > I'll take a look at it as larger than MTU packets are definitely not
> > suboptimal for TFTP. A 4096B block size will ack once per 4K so 4x
> > less ACK's and in my testing the 4K blocksize gives a 3x performance
> > boost on large files.
>
> Refreshing my memory on TFTP slightly, I think larger than MTU tftp
> transfers need support for RFC 2348 [1], maybe that's something we
> need to explicitly enable if the TFTP layer is part of LWIP (or maybe
> LWIP doesn't support it), or if the tftp application is ours on top of
> LWIP maybe we're missing some glue. I didn't look at the code, rather
> this was from some of my own notes from a long time ago.
>
> [1] https://www.rfc-editor.org/rfc/rfc2348

The issue was simply that IP_REASSEMBLY was not enabled for U-Boot
lwIP - I thought I tried that originally but must have done it wrong
(probably picked the wrong header vs lib/lwip/u-boot/lwipopts.h).

(+cc Joe and Ramon network maintainers)

I can submit a patch but it seems to me we should enable both
IP_REASSEMBLY (reassemble incoming fragmented IP packets) as well as
IP_FRAG (fragment outgoing IP packets if their size exceeds MTU) for
lwIP as both are currently disabled.

Would you all agree with enabling both? I don't think we have anything
that needs to sends fraemented packets via lwIP yet.

Is there value in adding support for the 'tftpblocksize' env var
supported in legacy tftp?

Best Regards,

Tim
