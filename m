Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FE7C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 14:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C8CC87848;
	Sun, 31 Dec 2023 15:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hfQW48SZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EB8B87842; Sun, 31 Dec 2023 15:22:33 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EDA2874CC
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 15:22:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-680a13af19bso11211466d6.0
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 06:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704032545; x=1704637345; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJ5CpRVlSg9QYI1R87Ai4ahZMF8gFpETpXTG7G6Ks1U=;
 b=hfQW48SZCulbR9iisBecf5QXaYqn4qLTqMdiyN2W/hqWr/OyHwVfpUEuNGggBzCJVc
 oD6MgHp+llCi36kihJWmcKsMvKYOE0OisUyUKLdLIkXDzLAS1Fby6uHUwhjPPbird9mh
 3JWpIqkYIJXXdRNS6LCN5jUAAZjEVnf9Rhrgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704032545; x=1704637345;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJ5CpRVlSg9QYI1R87Ai4ahZMF8gFpETpXTG7G6Ks1U=;
 b=D8vLJaDpGaw0T5LASEgWLOqfH+UKlSm7+Qq8y2qGTxPaHwL0/gz9YVah2Dfu6j4XEZ
 oxCHF4DvYkjx6Xxc6XTKD2TSMPRRYgmJTFBjzc5+fScH1AdYkcRmP5Z9iEFszkl10cpe
 GP0vOp0PSngnNsUV/KAvth8QoJ18UXVLYClMGDHjrFARuWMkRB/qY0CgVKuy7GKSWhkI
 J5kGDPe/tBicGrdjosXDsf6/oU2cpcOuPcJ2bRalrtFSXHujD11YnXl+p73HMx/u0ZVH
 LBhRXGzKKptkfSkV4n+UhxeeXC3EKC7YfKV7cfIaI5m8uBKyYlJUenJEqqKo8rSubi7L
 ms4w==
X-Gm-Message-State: AOJu0YzpTUwXM8ENkPwSrW3/EIczwkDDkV8BUZzH2OeTSxlQagdsnHPH
 bpEkya6xIdDpiU0VL3BFNxJPGQi4bqUpzBbn5CeVexp+j9XRdLRhJvheZho=
X-Google-Smtp-Source: AGHT+IGAE53lTXzIBbC845dpN69nXWTPX5uMyDcZzZ3mL2aVwT3pcEdFgNvPDljx70exhq+0JMA6GX8UtqMHIbcxFZQ=
X-Received: by 2002:a05:6214:e8c:b0:67f:288c:81d2 with SMTP id
 hf12-20020a0562140e8c00b0067f288c81d2mr21037599qvb.34.1704032545273; Sun, 31
 Dec 2023 06:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20231221000011.297145-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231221000011.297145-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Dec 2023 07:22:14 -0700
Message-ID: <CAFLszTjLOp8hJqPgCEVa+PDs-TGr6dtO+apMb0+WmopYZVpRbQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: fdt: check fdt address
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, Dec 20, 2023 at 5:00=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Trying to read a device-tree from an illegal address leads to a crash.
>
> Check that the parameter passed to 'fdt addr' is within the RAM area and
> non-zero.

What is the motivation for this patch? Is something crashing? We don't
do this with the 'md' command, for example.

Regards,
Simon


>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/fdt.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/cmd/fdt.c b/cmd/fdt.c
> index 331564c13b..dc954ea7d5 100644
> --- a/cmd/fdt.c
> +++ b/cmd/fdt.c
> @@ -193,6 +193,11 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, i=
nt argc, char *const argv[])
>                 }
>
>                 addr =3D hextoul(argv[0], NULL);
> +               if (!addr || addr < gd->ram_base || addr >=3D gd->ram_top=
) {
> +                       printf("Invalid address\n");
> +                       return CMD_RET_FAILURE;
> +               }
> +
>                 blob =3D map_sysmem(addr, 0);
>                 if ((quiet && fdt_check_header(blob)) ||
>                     (!quiet && !fdt_valid(&blob)))
> --
> 2.40.1
>
