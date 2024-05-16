Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C5EC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 19:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AB0A870AB;
	Thu, 16 May 2024 21:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z05XN4tI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7742C883E6; Thu, 16 May 2024 21:20:31 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86CB38701E
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 21:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-572e48f91e9so4240244a12.0
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 12:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715887229; x=1716492029; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zTXjj6RvV3nsONmDLr/xg3cU39Ijje68fP+kf3cstY=;
 b=Z05XN4tI07SQAJ+elKyQye503ytt6JhFMBK4P+r3vFMtGnyFbtWC3zgRxf2IrdIy9O
 4pTbLnHtp0CoGlb7cFF69yp54Gy1+Tzbsi/FuCBEGbUGQ6Gz9peEZBTMRUblPAnSglDi
 JAWy1OGWmn2yqi1a+SIZKney6nHfTTjbExAwh/Qb7VR0WyDbjBvs/Pra7NddZtHTthsJ
 nFPPilhqdccM+I1A81Jke+KB/w2gJvbTuyHZmejLAzm6MKQHvSqaF7Mwod4sUYyNz0DP
 sAVdBCeqWfds0Z0V+qVAikV+fqxML+yo56fPHQRzr7sop7tQ2Sk7ZYC5u/ZFaZTiEZ5P
 145Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715887229; x=1716492029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4zTXjj6RvV3nsONmDLr/xg3cU39Ijje68fP+kf3cstY=;
 b=uJ8cACFffoWbiWWXM3UF7HbHbQQfA4zSImtxXGbMonVnS9kC3NmDTD+Jhqx6nA4/28
 wJzD9eTfhzVrVH4ZKBAKRKVOlnbp36Z2YF1DxScZ0VY5AwlxfpW5QVuteCcyKOQyxBK1
 RfUVI4SyM3GPsRZlZpEUmzGFomowNngKifAs8VA3tJ7HkRI6Scc/zVYTeH7Z+jZ+C4Rn
 DFx3pU/6RcmT3pWZIFtIJY9ZSNM7jgaeJRGVprQmH+GhYW5Qo//dSupin5g0UubF8z6u
 /bVo9k/UUlwZvinKMzL4WTyDzDNQ+U7GFWx3E6nMJfo8RZwvJTlhjm8y0v0CXQD9lO+4
 Ny6Q==
X-Gm-Message-State: AOJu0YwHrKiaSFyKmFHH1BYSU9DonLqk/iDEDH82u7hZfpZzU7Cs0af3
 T7kuEcJ0E2Iq59XgHpTd2tLzdy4OBNbKPRiw1eU/sM3LD8RcXuOGZqgC9yzq922Iv2Z0QIeXs9F
 BOpq7k00yioUvrh/QfSD5Mi4hp/s=
X-Google-Smtp-Source: AGHT+IHNLaRaw/StyDMWYUcLDJAh8kZ2zB7aBSAP4winakM5i1cSswy9NJo92DzLCL8STubj4UyubGHc0A1U2bjoshQ=
X-Received: by 2002:a50:cd82:0:b0:56e:22b6:d924 with SMTP id
 4fb4d7f45d1cf-5734d5cf8dcmr11993626a12.13.1715887228726; Thu, 16 May 2024
 12:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240516104245.2075748-1-fiona.klute@gmx.de>
 <20240516104245.2075748-2-fiona.klute@gmx.de>
In-Reply-To: <20240516104245.2075748-2-fiona.klute@gmx.de>
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 16 May 2024 12:20:17 -0700
Message-ID: <CAJaLiFxP91T9CvgjZxtrgqZWjvQLzAP7z4M1xbw6EwXyeRJnUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] doc: Update netconsole examples, mention stderr
To: Fiona Klute <fiona.klute@gmx.de>
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

Hi Fiona,

On Thu, May 16, 2024 at 3:43=E2=80=AFAM Fiona Klute <fiona.klute@gmx.de> wr=
ote:
>
> Stderr was missing from the initial description and example.
>
> As I understand the env command documentation the subcommand style is
> preferred, though the old format is still fully supported.
>
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> ---
> Changes in v2:
> * Mention stderr redirection
> * Use 4 spaces instead of tabs for code block to avoid overflowing
>   lines
>
>  doc/usage/netconsole.rst | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/doc/usage/netconsole.rst b/doc/usage/netconsole.rst
> index 647f0c220b..f745615d9a 100644
> --- a/doc/usage/netconsole.rst
> +++ b/doc/usage/netconsole.rst
> @@ -3,10 +3,10 @@ Network console
>
>  In U-Boot, we implemented the networked console via the standard
>  "devices" mechanism, which means that you can switch between the
> -serial and network input/output devices by adjusting the 'stdin' and
> -'stdout' environment variables. To switch to the networked console,
> -set either of these variables to "nc". Input and output can be
> -switched independently.
> +serial and network input/output devices by adjusting the 'stdin',
> +'stdout', and 'stderr' environment variables. To switch to the
> +networked console, set either of these variables to "nc". Input and
> +output can be switched independently.
>
>  The default buffer size can be overridden by setting
>  CFG_NETCONSOLE_BUFFER_SIZE.
> @@ -24,10 +24,10 @@ can be used for network console.
>
>  For example, if your server IP is 192.168.1.1, you could use::
>
> -       =3D> setenv nc 'setenv stdout nc;setenv stdin nc'
> -       =3D> setenv ncip 192.168.1.1
> -       =3D> saveenv
> -       =3D> run nc
> +    =3D> env set nc 'env set stdout nc; env set stderr nc; env set stdin=
 nc'
> +    =3D> env set ncip 192.168.1.1
> +    =3D> env save
> +    =3D> run nc
>
>  On the host side, please use this script to access the console
>
> --
> 2.43.0
>

Reviewed-by: Tony Dinh <mibodhi@gmail.com>

All the best,
Tony
