Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6C5CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 14:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B483183D2E;
	Fri,  7 Nov 2025 15:14:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="bHCb3CkD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8676C83D17; Fri,  7 Nov 2025 13:35:48 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E60283BA1
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 13:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-37a2d9cf22aso6255641fa.1
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 04:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1762518945; x=1763123745;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=er89jKYFTniXdACbPGI6kSuoh1Uo1h1L+fZM286HA0U=;
 b=bHCb3CkDDj+WgnIM6/3nOk/VG7RXm+nN+3NFTm2RUa3P4kFgt+o3rXTy7LgEb4X64w
 Yh1NWjMc761guU4R5e5MB0CwKbYhuzAyjS7OYWsfBrkMhz+tyaXT2ENjgaovJs2kff61
 Pbe2lQnmnXeKoBebToUgjm+V9/9EIFF5jwptSd+wBEs+vm965dxqH/UtTADOKastPDVG
 PeXYeYCZp4FPvfkSZc6pZ7dWdetSFLOI8d+uhqFXBNLApVKrfYOiaO4CDNgsPj9dPqAI
 S8nhc1tglBba2h1jrrcQmNP4FG0DNHtScq4n3b7uk8H7OQJD4RQzTMk7NeFDAfD34x7T
 12uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762518945; x=1763123745;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=er89jKYFTniXdACbPGI6kSuoh1Uo1h1L+fZM286HA0U=;
 b=iDDlEv+Xn7a9LjTKRHnEkmOjaTrjLjv72/IwfLy2saJ9Q7II5qg4f4sI950XqPNkQo
 +mDekgAZpc2qWgfD89pM0wEGRdKaCb515DXWGckFj3aVJFADWSqBj1GWdPJn7Z/ghkbO
 NluoZqI7oSfI59aUIq82gelx/2rt1vdhm7lCyL0F+4ID840yrktlGEOp2jmynQybiG+g
 oJLRCQ3sUlmhkZlEf4VAINVDYtPOJDvXb9LrNOZD7w/iVRd6Ktlv1AxTbNBpk0KBYtEC
 KFL3jq4wPxTI3VVZ2dYJ2y9Q/E6VkFWbdOzJgKJGvnQn03QhXafCl9SjSI97EUjJYOe3
 1aXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYi07P3Rt9Vqc1YMVdDJSz3LAGYBQ0N9RGNwIUEsYeMQLqPCfkaCHCOai0+O4/v7+ls0g7fw8=@lists.denx.de
X-Gm-Message-State: AOJu0YxQ+ZyiaybXUwC4Ef5dZn7kokEzTx+PpTdaz2f5SwikvdRlJznz
 LwdzQ+Z6uvqOS57nCmJaEFbzcQAzBJIQZRU/bc/gr+QmmEFPi1OhXrtqU5j3Vwwf142ZhgbbtVX
 ibMZKdZZSeQdQCu9VjdIzr4PghtV1OWQ/fXCk4ODtFw==
X-Gm-Gg: ASbGncsZqF0B1/FlHfcHonqq3GOrKxoUsvmR3JJEJhee2KBBvbxi4Xl+ubrokoCxutD
 mmg35gJ1l5c/+GWWgJz6LnVOuMQ+cClT3koA22as40tPG5iog3VtkPv1Oq8NEP4ERRCYAY8Dk+p
 8jehqhNLqVJibvJ985UWOjgsT9rKRdAUcdpfF3agMr0JdSlW/qe9X1YPkAbeV+xEJwsolb7HS5v
 KMXl+8mys2UNl5dtKEivB/XHLFPOfe3lG+iTuh7prmJ2bIbHZFefzCa3Q==
X-Google-Smtp-Source: AGHT+IFVGpFgUvb+AOCKfgBzblauYyjX50xckDlfAJx5mQsd2Zw7XuFh7KDGvUhSIVo78KieMUmgs35rnUQJUS5hSIA=
X-Received: by 2002:a2e:bcc6:0:b0:37a:182c:920e with SMTP id
 38308e7fff4ca-37a7658c9a1mr5344621fa.22.1762518944903; Fri, 07 Nov 2025
 04:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20251106170124.3992080-1-admin@hifiphile.com>
 <1116a46b-6261-487b-8418-1c638df56e15@linaro.org>
 <CAOf5uwnO_VtG5sajp-_fq4KvK+V3O8V-PnZmQz0d0MNDPEnn8A@mail.gmail.com>
In-Reply-To: <CAOf5uwnO_VtG5sajp-_fq4KvK+V3O8V-PnZmQz0d0MNDPEnn8A@mail.gmail.com>
From: Zixun LI <admin@hifiphile.com>
Date: Fri, 7 Nov 2025 13:35:34 +0100
X-Gm-Features: AWmQ_blIF9YD5VUSnHuDb-5Bfs46mRE-12T0pkbcj1S1jsSNOXGveofh8ytsflk
Message-ID: <CA+GyqeY6MEV68yXACCs_8oAbD66TeRN292u2CsFUr_m=kRuYHw@mail.gmail.com>
Subject: Re: [RFC PATCH] mtd: nand: raw: Add ONFI NAND unique id read support.
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 07 Nov 2025 15:14:23 +0100
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

Hi,

The intended use is to allow BSP to have a unique serial number,
in our case it's something like this:

int ft_board_setup(void *blob, struct bd_info *bd)
{
char strtemp[34];
uint8_t unique_id[16];
struct mtd_info *mtd;
struct nand_chip *chip;

mtd =3D get_nand_dev_by_index(0);
if (!mtd)
return -EINVAL;

chip =3D mtd_to_nand(mtd);

if (nand_onfi_read_unique_id(chip, unique_id, sizeof(unique_id)))
memset(unique_id, 0, sizeof(unique_id));

bin2hex(strtemp, unique_id, sizeof(unique_id));
strtemp[sizeof(unique_id) * 2] =3D '\0';

fdt_find_and_setprop(blob, "/board", "nand-unique-id",
                         strtemp, strlen(strtemp), 1);
}

Zixun

On Fri, Nov 7, 2025 at 11:45=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi all
>
> On Fri, Nov 7, 2025 at 11:41=E2=80=AFAM Eugen Hristev <eugen.hristev@lina=
ro.org> wrote:
> >
> >
> > Something appears to be missing. Where is this function called ?
> >
>
> I prefer to apply if we have a use case and a consumer of this patch.
>
> Michael
>
> > Eugen>  #endif /* __LINUX_MTD_RAWNAND_H */
> >
