Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB91C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 11:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D41F386F53;
	Thu, 16 Nov 2023 12:19:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pIX94orK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4719874B6; Thu, 16 Nov 2023 12:19:52 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC6D487161
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 12:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahiroy@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 57758B81CD6
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 11:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B83C433A9
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700133587;
 bh=sVE1ZhzgF+azIDjaftC09+KcqFN6b/NyebhVcP3716U=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=pIX94orK0kXxh1o6FUN7miEOMvbCikG2L6fD47MqChba1soczCS4jplycsG0sIWn5
 wlxUJLoYG/LkBnX7yrwdGJIlbten+wPkUWGmKkVCxj6fyIaQBGyUNLRlIqEfiNENU9
 s/tkAHNDhhboJWuPPJa/rl9mjLnwCQ9InX1WA8udM6LQPeBC15vdECGAuGVMh1SVs6
 jR5B0xv2P9dP+So1iJUBCKZf8V/FlvWvS8v9zMnIZWENLOk96Df29YUGkNKIadYX5H
 +e58XhFLNinm99TLcZpnUMyw3tHYUFydHafmDHbqlqTTEYKFeuTvOpDs7VOg9sVEG1
 ISzA0zgGhWELw==
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-6cf65093780so342374a34.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 03:19:47 -0800 (PST)
X-Gm-Message-State: AOJu0YyMT/6VDa9z1U0jQV4ksdP6tpYbbp6PNY8jkCCepOxNbNBWzmty
 r3vvpAsIjV5ZtFSG+xUPc5P5uK880pQMKTvwEQY=
X-Google-Smtp-Source: AGHT+IG5EHn9aQcDgToPoaTjqqvcP1a1M4t+aOZpOsigb6MoTuHcsgwxABvfoX/iZim1ptpeZmWNZZ2Q2xY3URFCfWs=
X-Received: by 2002:a05:6871:a508:b0:1e9:9989:33a5 with SMTP id
 wc8-20020a056871a50800b001e9998933a5mr18170787oab.5.1700133586781; Thu, 16
 Nov 2023 03:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20231111002851.1293891-1-sjg@chromium.org>
 <20231111002851.1293891-3-sjg@chromium.org>
In-Reply-To: <20231111002851.1293891-3-sjg@chromium.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 16 Nov 2023 20:19:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQN_qGYztWGDmQyfg+eZ5P7RkM47mpgp0dQn_iuhvTSWg@mail.gmail.com>
Message-ID: <CAK7LNAQN_qGYztWGDmQyfg+eZ5P7RkM47mpgp0dQn_iuhvTSWg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] arm: boot: Move the single quotes for image name
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
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

On Sat, Nov 11, 2023 at 9:29=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Add quotes where UIMAGE_NAME is used, rather than where it is defined.
> This allows the UIMAGE_NAME variable to be set by the user.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---


I applied this to linux-kbuild/fixes.

I changed the subject to
"kbuild: Move the single quotes for image name"
because it is unrelated to arm.


Thanks.



> (no changes since v4)
>
> Changes in v4:
> - Add a patch to move the single quotes for image name
>
>  scripts/Makefile.lib | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 68d0134bdbf9..1a965fe68e01 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -487,14 +487,14 @@ UIMAGE_OPTS-y ?=3D
>  UIMAGE_TYPE ?=3D kernel
>  UIMAGE_LOADADDR ?=3D arch_must_set_this
>  UIMAGE_ENTRYADDR ?=3D $(UIMAGE_LOADADDR)
> -UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> +UIMAGE_NAME ?=3D Linux-$(KERNELRELEASE)
>
>  quiet_cmd_uimage =3D UIMAGE  $@
>        cmd_uimage =3D $(BASH) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
>                         -C $(UIMAGE_COMPRESSION) $(UIMAGE_OPTS-y) \
>                         -T $(UIMAGE_TYPE) \
>                         -a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
> -                       -n $(UIMAGE_NAME) -d $< $@
> +                       -n '$(UIMAGE_NAME)' -d $< $@
>
>  # XZ
>  # ----------------------------------------------------------------------=
-----
> --
> 2.42.0.869.gea05f2083d-goog
>


--
Best Regards

Masahiro Yamada
