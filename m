Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793DCC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 16:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D708839EC;
	Wed, 28 May 2025 18:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="Q6kEoCjD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 893CB83A1B; Wed, 28 May 2025 18:53:33 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4937839B7
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 18:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e733cd55f9eso3966301276.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 09:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1748451209; x=1749056009; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGv7yw0Fi6ffUGfn0myMbHlWEFMOrugVgeB53Nwgvsc=;
 b=Q6kEoCjDxiZ689P/N5ok0MXjqlNT+f1aDpUUwmZ1NOF9GjfitZFp5sGCWnDLUSmjpR
 XF7MPq0LslarSPPdU51OEXWB0xNd47I0fM0murgf1FRmIEEJYjBzZpwqbCg0oEJYXriS
 3He6ix1GVEfv+cxX29Bz38YZ0n0UYVvsLLWqTX1fWo4Yh00MXdAFB/pRGvSJdIiStRl+
 XuK+fnvyC3KLzYFIi8Nj6F1lK1mnHgzuaqCLF/X9SsoAytCB9l0XId7iI40lGrl8iSuG
 u8zeYyLg1QXfopA2Y+q8FzuIujFtVtihX2HjOTj8bqG1LzmMsWJ/35UhrY3byoS3xh+P
 dLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748451209; x=1749056009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGv7yw0Fi6ffUGfn0myMbHlWEFMOrugVgeB53Nwgvsc=;
 b=vRxc2jAa5D6iOeI8QsN46uZbi4J5oLq+k/I9bytD+ODBtF+vzR2VBbClHfgh9PPQKc
 LblrYtRzAv6hT63YOo8xLf9FG+75tc6HpYUKoJxS3HWP75wZUJlKbznuCawgNpKNzvm3
 FoerZndNpxW4/jNrK7ngJ/Giq0cIbnozithdfRWpgknBhwGUXqLyVt7JplWcNUy6mL0c
 UZciU2EuFRAGXPXdlg+vgJ1R9aEwQkq7GokfYFxOy+AXn8y27SFoN0CaPve+wDpJ9eFa
 zNPTMwxF+8vNtHBL9QO3LmJusr9wykija1DkCc6p8FbV8HcAJ7NHCmHLpTIbrajvspti
 tSZA==
X-Gm-Message-State: AOJu0Yz59My3prfuWn0kdix59SpuWC5IY2+lg8oUW+O6zH5UxbLzT4Tk
 zMUIUU0kpEHbMtB0F1m4zWGyMP2qj/OC14W0T2Mte8hHukebOQLzDQZIBliZee5B+iWyVFiPROT
 kLp8G/+cFc6O7UynMBWC4pBeAahO8x5m+kSO34A11CA==
X-Gm-Gg: ASbGncvbTeaIPcP/j2dhIk3IquLCpZQDdJQVJopYndtalN7+ZGkElZxPNs869cp4cl4
 rpEy6aZpUFrDKqFe+tNwJvFcsZFDpS/59cW1t9TQMPJjMidkIbBsD2ozu7CxP5rEebyJCu3cqWi
 5AXxe2QUvRNm7Nah453s/9MPJWnWTDJhOP93+cgfXNhzc=
X-Google-Smtp-Source: AGHT+IFPgHfQsmBqOpnuDrTLc6gcZn5/VNlGQBuDgHPPM0lGAAqzu542entn0PEWlAwGsuxtnThaSDAq4QYJQKxegEc=
X-Received: by 2002:a05:6902:1103:b0:e7d:9e38:b642 with SMTP id
 3f1490d57ef6-e7f6185b97cmr3721376276.43.1748451208861; Wed, 28 May 2025
 09:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU3H1vjbvyZTycBQhufii5SqyTnk4AaMRk_ztGY10g9joQ@mail.gmail.com>
 <6e667ef9-9fa0-441b-8520-46e7bdbc344a@linaro.org>
 <CAJ+vNU0kY=iNR6Q3PR6+x=wqv2932=1E+Ci0CwvURCPh6JD5-A@mail.gmail.com>
 <ebb48519-a02b-4b06-a801-f9c05fccd428@linaro.org>
In-Reply-To: <ebb48519-a02b-4b06-a801-f9c05fccd428@linaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 28 May 2025 09:53:17 -0700
X-Gm-Features: AX0GCFszaCcO1VdEpYoSZsBmvDPF_8y6lRSNtyA-mKqpSqV2hMKwQ_zfY3MGLNE
Message-ID: <CAJ+vNU2rOgp77+ML7LYuVu5hYFOwkbRytG8q2+NeXm7OgSL0vg@mail.gmail.com>
Subject: Re: lwip tftp not working on imx8mm
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot <u-boot@lists.denx.de>, Fabio Estevam <festevam@gmail.com>
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

On Wed, May 28, 2025 at 5:24=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 5/27/25 18:35, Tim Harvey wrote:
> > On Mon, May 26, 2025 at 5:17=E2=80=AFAM Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >> Hi Tim,
> >>
> >> On 5/23/25 20:31, Tim Harvey wrote:
> >>> Hi Jerome,
> >>>
> >>> I've enabled LWIP on imx8mm_venice to see how it's doing and while
> >>> dhcp/dns/ping/wget appear to work great, tftp is broken.
> >>>
> >>> Enabling LWIP_DEBUG shows the following:
> >>> ip4_input: packet accepted on interface et
> >>> IP packet dropped since it was fragmented (0x2000) (while IP_REASSEMB=
LY =3D=3D 0).
> >>
> >> Hmmmmm IP_REASSEMBLY should probably default to 1.
> >>>
> >>> I tried enabling IP_REASSEMBLY in lwip but that seems to change the i=
ssue to:
> >>> ip4_input: packet accepted on interface et
> >>> ip4_input:
> >>> IP header:
> >>> +-------------------------------+
> >>> | 4 | 5 |  0xc0 |       108     | (v, hl, tos, len)
> >>> +-------------------------------+
> >>> |    10568      |000|       0   | (id, flags, offset)
> >>> +-------------------------------+
> >>> |   64  |    1  |    0xe25b     | (ttl, proto, chksum)
> >>> +-------------------------------+
> >>> |  172  |   24  |    0  |    2  | (src)
> >>> +-------------------------------+
> >>> |  172  |   24  |   21  |  251  | (dest)
> >>> +-------------------------------+
> >>> ip4_input: p->len 108 p->tot_len 108
> >>> Unsupported transport protocol 1
> >>>
> >>> Any ideas what the issue is here?
> >>
> >> Not really :-/ Does the transfer work with a smaller block size?
> >> (CONFIG_TFTP_BLOCKSIZE, default 1468, try 500 for instance). You could
> >> also enable CONFIG_LWIP_DEBUG_RXTX in order to get a full hex dump of
> >> the messages going into/out of the lwIP stack.
> >
> > Hi Jerome,
> >
> > My config was with 4096, setting it to 1468 works and anything above
> > that seems to cause this failure.
>
> Good to know.
>
> > Some sort of fragmentation issue?
>
> Quite possibly, yes. In any case it does not make much sense to use a
> clock size that causes the packet to be larger than the PMTU (it would
> be sub-optimal) but it should definitely work, especially since I don't
> believe PMTU discovery is implemented in lwIP. I add this to my to-do
> list but feel free to investigate further :)
>

Hi Jerome,

I'll take a look at it as larger than MTU packets are definitely not
suboptimal for TFTP. A 4096B block size will ack once per 4K so 4x
less ACK's and in my testing the 4K blocksize gives a 3x performance
boost on large files.

Best Regards,

Tim
