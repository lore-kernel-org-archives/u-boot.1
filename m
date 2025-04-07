Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BBEC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 19:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19E2B82F85;
	Mon,  7 Apr 2025 21:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YEzj93rS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFF4483086; Mon,  7 Apr 2025 21:47:41 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4D8182EAA
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 21:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso4056215a12.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 12:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1744055257; x=1744660057;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CEs0J1h5zQEcW6+i7AkXUxh6mmuD0+xW/RlPjj122CQ=;
 b=YEzj93rSGrBxzOA94DXpE6eDQ6OkMaKpnHSGWxLaRKqCN2ju4Kh9GCvMKqkHWfCZJ+
 Arwo2a108oTarA3d0DMB8pn6VpA276JTXGwhzinv675iZZfZiVsoKQVSZ4VESzktLTE1
 s1Vbbe2WsD+tJ+ruwqBqMOqGn+Vg5241cFIE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744055257; x=1744660057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CEs0J1h5zQEcW6+i7AkXUxh6mmuD0+xW/RlPjj122CQ=;
 b=dXyLCyqB8PbOa072aKvNb+M5wJAyReyw3PmZDja9B9gAReziHjh9R/5inEQdUwtHjp
 c0Apgi3NgY62cb7hsgzxLuY6IBL+gxxffvNtin9k0i1qJ3ewGR21EAs3vHuR2R95gvkI
 mYPZ1vijeq9AyqFojo7HvmZPA/EHGFLrupMsAY88Rs3jIcSlQuhB/OhUxlon0rJ5BTmp
 kbZTlJH4aI7c8i4cbetd9uU/R4A1xh+Ato5kQ/W4zthkO4HT47IW4jRBStHayZP3FRlM
 e1YZmTzNgcCUzpmXQDodCzbbE3PllN/U7YKPT5LcZHhLVBmpchS3fBRRy0Ry82xV1KWX
 UgGg==
X-Gm-Message-State: AOJu0Yx5m6MKevjgy0qt6XofHFqPHv/NUsLDOHFqEqQzYuXmLph9heWD
 Jo+k75GMPzZBt6NyN/a/vV6sIost6ivc+KbtAZE/F2yQYLBqIgwRLAYwRBQWh38hc61vNtD7q+S
 Ki5N8qDHdw7FoFS4Hk2QY2AQqxB/fDbg5U/LQPw==
X-Gm-Gg: ASbGncvLGl0QYk69wm1PJH/r4aBr29JyL0dLb2y/C9mmakZiIjkA7OqPPo/Tj/W9Y1Q
 TMpYnVV100imwrpcuTClmr9qe+ojoLe6crPREnhAWOrm8VpQWzRF5UutjHdoAVJ4iJ/cS/dXl1B
 mFMkL2Er0jJt/mh0z8wmP1LTttECGv
X-Google-Smtp-Source: AGHT+IHy/QL3HRrNwM7xjf5QCCErrMVRMoeezIYdT5bmxMt5LjUOaBl+IB5YZw7YYLUh9OA4ZEnFPliy9QXcIz2VPnk=
X-Received: by 2002:a17:90b:524f:b0:2fa:17e4:b1cf with SMTP id
 98e67ed59e1d1-306d0be3b2cmr951923a91.2.1744055257164; Mon, 07 Apr 2025
 12:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.7e9dd5d7-9551-4b99-9b32-ca6f3cd315b5@emailsignatures365.codetwo.com>
 <20250325155310.456037-1-mike.looijmans@topic.nl>
 <2b2f97fe-ebeb-43ba-9751-c7b45a88a92f@topic.nl>
In-Reply-To: <2b2f97fe-ebeb-43ba-9751-c7b45a88a92f@topic.nl>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 7 Apr 2025 21:47:25 +0200
X-Gm-Features: ATxdqUFY5Qv5PbgJVbYJ7Nmf5fLyNRLl-7QudRhZuA7LIy3VetnNSmFqcB9jQ_M
Message-ID: <CAOf5uw=TiOucjaV14jy69nyRD-c-Yy8_Z_neCmkcA60+E7NkCg@mail.gmail.com>
Subject: Re: [PATCH] mtdpart: Support MTDPART_SIZ_FULL in fixed-partitions
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: u-boot@lists.denx.de, Alexey Romanov <avromanov@salutedevices.com>, 
 Tom Rini <trini@konsulko.com>, William Zhang <william.zhang@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi MIke

On Mon, Apr 7, 2025 at 3:42=E2=80=AFPM Mike Looijmans <mike.looijmans@topic=
.nl>
wrote:

> ping?
>
> Maybe I should have added to the description that the Linux kernel
> allows MTD partitions to specify a size "0" in the device-tree to mean
> "the remainder". This patch makes u-boot compatible with the kernel's
> MTD partitions. U-boot MTDPARTS also supported this, but it's missing in
> the device-tree parser.
>
>
Please expand your commit message . Add an example where is defined this
way in linux kernel and add your example. I found out that is used a lot in
omap3 platform
but please point me to some recent board if you know

Michael

M.
>
> On 25-03-2025 16:52, Mike Looijmans wrote:
> > Flash partitions may specify MTDPART_SIZ_FULL (=3D0) as the size of the
> > partition to indicate "the remainder of the flash". Make this work with
> > device-tree "fixed-partitions" as well.
> >
> > Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> > ---
> >
> >   drivers/mtd/mtdpart.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> > index 88094b81e7a..5284890bd88 100644
> > --- a/drivers/mtd/mtdpart.c
> > +++ b/drivers/mtd/mtdpart.c
> > @@ -910,11 +910,13 @@ int add_mtd_partitions_of(struct mtd_info *master=
)
> >                       continue;
> >
> >               offset =3D ofnode_get_addr_size_index_notrans(child, 0,
> &size);
> > -             if (offset =3D=3D FDT_ADDR_T_NONE || !size) {
> > -                     debug("Missing partition offset/size on \"%s\"
> partition\n",
> > +             if (offset =3D=3D FDT_ADDR_T_NONE) {
> > +                     debug("Missing partition offset on \"%s\"
> partition\n",
> >                             master->name);
> >                       continue;
> >               }
> > +             if (size =3D=3D MTDPART_SIZ_FULL)
> > +                     size =3D master->size - offset;
> >
> >               part.name =3D ofnode_read_string(child, "label");
> >               if (!part.name)
>
>
> --
> Mike Looijmans
> System Expert
>
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
>
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topic.nl
> W: www.topic.nl
>
>
>
>

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
