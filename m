Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44ACEC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 10:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5147087182;
	Tue,  7 Nov 2023 11:13:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E9qs8z8P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B415787184; Tue,  7 Nov 2023 11:13:17 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D63CF87116
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 11:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahiroy@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CD74F611BC
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 10:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B90C433A9
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 10:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699351988;
 bh=Cg4JwaJXW8aMk6Qj7g4lmGbdb7QNI/tQxPjTSIHA4cI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=E9qs8z8Pa11Gk/j3gjROyokcLYP+l4xLI1lHV3xWnhyg0LQ0U8uOpjOcn/hEW9OTF
 ZdITV/OhXcb232d0UChDa052Ps3y8qj4PT+8VNWdN9M8OwA2sY5SgYBDtzqaSR757a
 niCxWZIuS1kkh6zGlP/r5JSXxpOV1cESigRhT2FtbQKuZD1iyISYrl0qkBdvH8kypD
 +lef6brGjvFr9mwQj57If6qwaOmv8ijAUea4NVYowJuJNz96Mv7LK5Nm1k/dTYM0EV
 Sc1XTO0ARFS12pAdp2IREit7vc90+OWrW9T3NS7dE0p5Uxs/Jw7cfk4rEeQfQB6wWP
 B5f/fFoEcvtcg==
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-6d261cb07dcso3321348a34.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 02:13:08 -0800 (PST)
X-Gm-Message-State: AOJu0YzFQN7naLhmeb2Tq6/cuvOLQrgEx3rrNgI0N9wnI02PRmSmOqOp
 DnBzlw1TDXytUkJlfmgb9NlIzkF+6ek1Z433CLE=
X-Google-Smtp-Source: AGHT+IFwtR8QOdDBWrS1H5FNaUKUWfGRVbBjcpHDHqyziVmjexyzWBylcif12dO1O6q6SYxwYaTHrq9GWlK5eM+N8l0=
X-Received: by 2002:a05:6871:67c2:b0:1ea:131f:5fb1 with SMTP id
 yb2-20020a05687167c200b001ea131f5fb1mr2554285oab.34.1699351987327; Tue, 07
 Nov 2023 02:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20231104194207.3370542-1-sjg@chromium.org>
 <20231104194207.3370542-3-sjg@chromium.org>
In-Reply-To: <20231104194207.3370542-3-sjg@chromium.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 7 Nov 2023 12:12:30 +0200
X-Gmail-Original-Message-ID: <CAK7LNASVOdz2qdg5dwWN8HJwqJ1q_OgdeuapLhvmD6beavUqPg@mail.gmail.com>
Message-ID: <CAK7LNASVOdz2qdg5dwWN8HJwqJ1q_OgdeuapLhvmD6beavUqPg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm: boot: Use double quotes for image name
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

On Sat, Nov 4, 2023 at 9:42=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> The use of single quotes in the image name causes them to appear in
> the image description when the uImage is created. Use double quotes, to
> avoid this.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Split double-quote change out into its own patch
>
>  scripts/Makefile.lib | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 68d0134bdbf9..03e79e319293 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -487,7 +487,7 @@ UIMAGE_OPTS-y ?=3D
>  UIMAGE_TYPE ?=3D kernel
>  UIMAGE_LOADADDR ?=3D arch_must_set_this
>  UIMAGE_ENTRYADDR ?=3D $(UIMAGE_LOADADDR)
> -UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> +UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
>
>  quiet_cmd_uimage =3D UIMAGE  $@
>        cmd_uimage =3D $(BASH) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
> --
> 2.42.0.869.gea05f2083d-goog
>


NACK.


This is because you are doing *WRONG* in 3/3.

Look at your code closely.

https://lore.kernel.org/linux-kbuild/20231104194207.3370542-4-sjg@chromium.=
org/T/#me2fb68151d6f4f330808406f9a711fffee149529



In the mainline kernel, the quotation appears
only in the definition of UIMAGE_NAME.


masahiro@zoe:~/ref/linux(master)$ git grep UIMAGE_NAME
scripts/Makefile.lib:UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
scripts/Makefile.lib:                   -n $(UIMAGE_NAME) -d $< $@


The single quotes are consumed by shell.






This is mainline + your patch set.

masahiro@zoe:~/ref/linux(simon-v2)$ git grep UIMAGE_NAME
scripts/Makefile.lib:UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
scripts/Makefile.lib:                   -n "$(UIMAGE_NAME)" -d $< $@
scripts/Makefile.lib:                   --name "$(UIMAGE_NAME)" \


You quoted the definition of UIMAGE_NAME,
and also variable references.




See how it is expanded.


--name "$(UIMAGE_NAME)"


 =3D=3D>


--name ""Linux-$(KERNELRELEASE)""


 =3D=3D>


--name Linux-$(KERNELRELEASE)




You added double quotes in a row, just to cancel it.



--=20
Best Regards
Masahiro Yamada
