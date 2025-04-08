Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486E6C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 10:31:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 655DC833E1;
	Tue,  8 Apr 2025 12:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jLBSdNNb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DC6E833E8; Tue,  8 Apr 2025 12:31:30 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91776833D1
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 12:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-ae727e87c26so3536372a12.0
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 03:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1744108286; x=1744713086;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iWsOHKsTwNQ37e2xMK43ec9lYbTBmyvWqWyRTDwnQdc=;
 b=jLBSdNNbEU6RV2s6SyWQxBKcDUvzx9PsemB79nwGDDsXJwSht2Shft+Uswsnow6SkT
 PDcqiFINVmVHKVwEgbFErjXGiklFQnu4KBT4+7TCe3ct/Ea6jNBvWxWqUheY/1i012Y1
 nzYTXlynVbydqEuq8QUl/rS+PoaZD32DYRAZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744108286; x=1744713086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iWsOHKsTwNQ37e2xMK43ec9lYbTBmyvWqWyRTDwnQdc=;
 b=nVKtAQDYZ6hG+2nNox9W5l//2jauNPpduvKcqDyJKMqd+2eV2whoqehRpOG9Fw03Xz
 Bn2SvdOaikWd/nkwBKZhpmQmhTMvWjjvD97o9PNN5UFLRmau4XNGnV8dEySVAfcTgcwB
 5u0tNxDBy6lfYNmvPie2XSdQEfqbihormk+Xfr8j4NeJXHRGKh63ApiYf4mcEf/B/gTf
 aCeV91BrSCz+niW+FT4/3K9habK7KPrwYKknCvJBQHqnVoYeRHJnGBXFgWAbO2sc82Xj
 fcABADmekTMk68QLGRFP4hf8Wx7XV4wtXBOZ13kRBRAuQF7qwpieaw55XCY9RaEE/oQa
 rYng==
X-Gm-Message-State: AOJu0Yxj5aIKN6oMMbs3Qo3YJFUiKaoAUuXs2Q2KNn5G26yXAuLFZwtD
 dhANnKjLFZMi17AVjIIVfMc3zg+xlRf6g5sH9Ss2ga0siO7YhaXwwFifkeAHNYfgcykxJRM5ran
 TLTBNwYFUsmkRsYgPq4TuoYBdkc8ws/79WOgp1edQUoBtcpVV1ZM=
X-Gm-Gg: ASbGncuznJLmfhus3SL5zKuvpMywrR+On3R0ku9YLwd6gtyCcmxKrcvWy/FdF/FOLZK
 lZ0Vd/gQ8vNEbaX65iIrlSw2WnrQKPEtY3dhAzvP8oB/xt3auu05TQNPxKswoAFE+k7aUOEmUxx
 gNqzQWRrCUGrPRRpBSfgMo3Exx
X-Google-Smtp-Source: AGHT+IHolldBM6azqwYZFnvxgXTuA4O0XgidUC0/+rvfhJLKDOpAhaw3sYYcOrsl9sLgXFWiOVijW8Y8SPe5cWkBR/M=
X-Received: by 2002:a17:90a:d650:b0:305:2d27:7ba5 with SMTP id
 98e67ed59e1d1-306a4822f9cmr19929123a91.6.1744108285984; Tue, 08 Apr 2025
 03:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.bc83124b-b53b-4cfa-9911-d8ca2185a06f@emailsignatures365.codetwo.com>
 <20250408054642.6843-1-mike.looijmans@topic.nl>
In-Reply-To: <20250408054642.6843-1-mike.looijmans@topic.nl>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 8 Apr 2025 12:31:14 +0200
X-Gm-Features: ATxdqUG7PBS5KCr0LkKtVi3s87PEXMODPOZx5cf2UHsQBUuvATrwMW-TuuIoNSo
Message-ID: <CAOf5uwmy2kRw=cF0v_K+nhR+rKVQE6C9dZFv71CcGZCXuhb85Q@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: mtdpart: Support MTDPART_SIZ_FULL in
 fixed-partitions
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

Hi

On Tue, Apr 8, 2025 at 7:46=E2=80=AFAM Mike Looijmans <mike.looijmans@topic=
.nl>
wrote:

> Flash partitions may specify MTDPART_SIZ_FULL (=3D0) as the size of the
> partition to indicate "the remainder of the flash". Make this work with
> device-tree "fixed-partitions" as well.
>
> This makes MTD partitioning compatible with the Linux kernel, see:
>
> https://github.com/torvalds/linux/blob/master/include/linux/mtd/partition=
s.h#L29
>   https://github.com/torvalds/linux/blob/master/drivers/mtd/mtdpart.c#L12=
3
>
> Previously, this could only be done through MTDPARTS so this change allow=
s
> boards like topic_miami to migrate from `mtdparts`/`mtdids` to devicetree
> partitions.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>
> Changes in v2:
> Amend commit text to add links to Linux code and explain the rationale
>
>  drivers/mtd/mtdpart.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> index 88094b81e7a..5284890bd88 100644
> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -910,11 +910,13 @@ int add_mtd_partitions_of(struct mtd_info *master)
>                         continue;
>
>                 offset =3D ofnode_get_addr_size_index_notrans(child, 0,
> &size);
> -               if (offset =3D=3D FDT_ADDR_T_NONE || !size) {
> -                       debug("Missing partition offset/size on \"%s\"
> partition\n",
> +               if (offset =3D=3D FDT_ADDR_T_NONE) {
> +                       debug("Missing partition offset on \"%s\"
> partition\n",
>                               master->name);
>                         continue;
>                 }
> +               if (size =3D=3D MTDPART_SIZ_FULL)
> +                       size =3D master->size - offset;
>
>                 part.name =3D ofnode_read_string(child, "label");
>                 if (!part.name)
> --
> 2.43.0
>
>
>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>


> Met vriendelijke groet / kind regards,
>
> Mike Looijmans
> System Expert
>
>
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
>
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topic.nl
> W: www.topic.nl
>
> Please consider the environment before printing this e-mail
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
