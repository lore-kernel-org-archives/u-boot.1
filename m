Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E50C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 16:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46CB78879D;
	Mon, 29 Apr 2024 18:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OulvjZEi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E223F88783; Mon, 29 Apr 2024 18:22:15 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E5438879D
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 18:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-617d25b2bc4so50171787b3.2
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 09:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714407732; x=1715012532; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7eckP200a1evwQaGwC0z3W8tIQIFy+wrOxYkYRwdED0=;
 b=OulvjZEiedIBttEXWyFgJc23MHkDE6+TS4CudmcpIdCYlTAr/LgEaMFp+CUmMfOUIy
 RtQpqEt7vO7jI9WZQFoVtdc8DoatlFW9L6nTj9DsZc1HgXRCpE5Y1jzoQS3rHLQ2FITS
 /FpuhaEJXFlun34WXgygQ+Y5QBgGhMbWa1kalvuR5jpF+7bgq9Y+blvbRv/2h9pBHzTl
 PNMcsIWNwxXFGU3Kt94pAZsIufgpayNAGc3lInczKiDStm+VeZ655BfUM3ZLRXPwZjal
 dolu8BpZjOi7T97ImpH2T1wsNmkUopH6m4aITWrfop7Iy2qLPnEvy1vJ9M3O7+fgs3Qb
 SS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714407732; x=1715012532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7eckP200a1evwQaGwC0z3W8tIQIFy+wrOxYkYRwdED0=;
 b=kQWAf33+gpZSAn6ZkeHuiaWyRu4KJ8H79XYfo9J2uKN82n+9z6wkGTXbRXzNSiC5K2
 Fc0wGH4IPI2FuqsHwG0UroMcnkMhNEEuQ4VZo8Sjdv6VXJcE07i0HbiGZLc3iMDHU00v
 G0PCBvAkUNHFTLP/6PoZ1XHvolpEB6NSa0Q4C3rofKjNlrCWjkdvFaihaR/twLBTgYGI
 nZyY2u55qX6VW1vHwQEvOMVwXixlQVaput7r8OGO8pPqSFniKMAnAhqC6KR9HRSL06zg
 LYcKeEl7YOCPQlzmtPzLeGHd679OzCuCgcuOXNCzr4AbQfv4QD251StuCW8e9zLKqHPD
 ITyQ==
X-Gm-Message-State: AOJu0Yw4WSOK5aM779vTvDEvm9kvQAXskepf4skxm3ZtiqRk9guoMLsm
 oEYKlTT/jM3bvTqzixD61NuXTQoF000R9unp6GqZy2qhTPJNLNU1H29UboHz6Lijs2GYUyq8y+0
 p3RfI1eu/zzkSvqkszFhDp9ENoJg=
X-Google-Smtp-Source: AGHT+IHCodkYfINa5T2fvzQNxOnO/s2PhEErkEmpPBkOnG301VAYGUHhgYsStspOtQh5ba1EH9Je/ImTRl0nXKybuSA=
X-Received: by 2002:a05:690c:62c3:b0:61a:e4ef:51d with SMTP id
 hn3-20020a05690c62c300b0061ae4ef051dmr8670258ywb.9.1714407732003; Mon, 29 Apr
 2024 09:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <ea0422cd-a8e6-3c36-f551-a0142893301b@marvell.com>
In-Reply-To: <ea0422cd-a8e6-3c36-f551-a0142893301b@marvell.com>
From: Chris Packham <judge.packham@gmail.com>
Date: Tue, 30 Apr 2024 04:22:00 +1200
Message-ID: <CAFOYHZCAKtYiy=3X=u2+oqv3Wx8=W-vtV=+akbo+e479hPoX7A@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: pxa3xx: Incorrect bitflip return on page read
To: Ravi Minnikanti <rminnikanti@marvell.com>
Cc: u-boot@lists.denx.de, hs@denx.de, trini@konsulko.com, sr@denx.de
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

On Sun, Apr 28, 2024 at 4:15=E2=80=AFAM Ravi Minnikanti <rminnikanti@marvel=
l.com> wrote:
>
> Once a page is read with higher bitflips all subsequent reads
> are returning the same bitflip value even though they have none.
> max_bitflip variable is not being reset to 0 across page reads.
>
> This is causing problems like incorrectly
> marking erase blocks bad by UBI and causing read failures.
>
> Verified the change with both MTD reads and UBI.
> This change is inline with other NFC drivers.
>
> Sample error log where a block is marked bad incorrectly:
>
> ubi0: fixable bit-flip detected at PEB 125
> ubi0: run torture test for PEB 125
> ubi0: fixable bit-flip detected at PEB 125
> ubi0 error: torture_peb: read problems on freshly erased PEB 125,
> must be bad
> ubi0 error: erase_worker: failed to erase PEB 125, error -5
> ubi0: mark PEB 125 as bad
>
> Signed-off-by: rminnikanti <rminnikanti@marvell.com>

Looks good to me

Reviewed-by: Chris Packham <judge.packham@gmail.com>

> ---
>  drivers/mtd/nand/raw/pxa3xx_nand.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/px=
a3xx_nand.c
> index 1d9a6d107b..d2a4faad56 100644
> --- a/drivers/mtd/nand/raw/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
> @@ -800,6 +800,11 @@ static void prepare_start_command(struct pxa3xx_nand=
_info *info, int command)
>         info->ecc_err_cnt       =3D 0;
>         info->ndcb3             =3D 0;
>         info->need_wait         =3D 0;
> +       /*
> +        * Reset max_bitflips to zero. Once command is complete,
> +        * max_bitflips for this READ is returned in ecc.read_page()
> +        */
> +       info->max_bitflips      =3D 0;
>
>         switch (command) {
>         case NAND_CMD_READ0:
> --
> 2.17.1
