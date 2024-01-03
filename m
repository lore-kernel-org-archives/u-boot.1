Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6E7C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 16:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72C77876FF;
	Wed,  3 Jan 2024 17:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fqIBzD2u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18AF086EE2; Wed,  3 Jan 2024 17:20:03 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D4D687730;
 Wed,  3 Jan 2024 17:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robh+dt@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 93CB5CE16BA;
 Wed,  3 Jan 2024 16:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D3BC433CB;
 Wed,  3 Jan 2024 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704298795;
 bh=DCaFhJgle4/m0G19+ppuMD3zW79+uCyzpzSRkwdVRww=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=fqIBzD2uXvq7pHu6X6J0D4CdGopCqweLL4ZpnATFkisJSKXX2B3Gghb9qAmP0MWXC
 jNr5d+Cyd95pMCIi00COjBbaK04o9bBIoMzp/++Aq9hT9DwrJUa9Ywt8xqVF1Bkikr
 uMJot7RAmmoDxrM3UsaXG7r6KFsq33boQrkEHuLv1vH5NooYbw/GY7g6L7JGAZ7ann
 urI6uyLo6bfC89xXkJQbUzgvrpV3RM1fj4OioSyxbtw74UHTPV7V3KtZAZBYzaZnpX
 /f3IrrA98yp6Qaz0LOUk/LmWI0R15d7FccCWHAJLZHFfPubY8f/45PSp8qORfP5k83
 xpcgCY691qS2A==
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-2ccbf8cbf3aso100695681fa.3; 
 Wed, 03 Jan 2024 08:19:55 -0800 (PST)
X-Gm-Message-State: AOJu0YzoGcoPgqyudS0y3hPT2YiTkC7vjRw3h2Hf2eC6B0VjbblbUcbN
 fhPNXkmieWGwb7wsn8iuTtixKv9T5kE19FdX0g==
X-Google-Smtp-Source: AGHT+IEwozjtIEFQxMtHQ/2bodFL2B52VdQpxwR9TA1TLZFL5N/2Cz8EqBD5VjDZKbOSGrigghwiAMUR1ciKMqBDhW8=
X-Received: by 2002:a2e:a585:0:b0:2cc:da6a:6285 with SMTP id
 m5-20020a2ea585000000b002ccda6a6285mr7683560ljp.33.1704298793932; Wed, 03 Jan
 2024 08:19:53 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-6-sumit.garg@linaro.org>
In-Reply-To: <20231228115804.3626579-6-sumit.garg@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 3 Jan 2024 09:19:40 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
Message-ID: <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing
 subtree
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
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

On Thu, Dec 28, 2023 at 4:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> Encourage SoC/board maintainers to migrate to using devicetree-rebasing
> subtree and maintain a regular sync with Linux kernel devicetree files
> and bindings.
>
> Along with that add documentation regarding how to run DT bindings
> schema checks.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v3:
> --------------
> - Replace CONFIG_* with Kconfig options
>
> Changes in v2:
> --------------
> - s/U-boot/U-Boot/
>
>  doc/develop/devicetree/control.rst | 131 +++++++++++++++++++++--------
>  1 file changed, 96 insertions(+), 35 deletions(-)
>
> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/=
control.rst
> index cbb65c9b177..65180d33e8d 100644
> --- a/doc/develop/devicetree/control.rst
> +++ b/doc/develop/devicetree/control.rst
> @@ -1,5 +1,6 @@
>  .. SPDX-License-Identifier: GPL-2.0+
>  .. sectionauthor:: Copyright 2011 The Chromium OS Authors
> +.. Copyright 2023 Linaro Ltd.
>
>  Devicetree Control in U-Boot
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> @@ -22,14 +23,13 @@ for three reasons:
>    hierarchical format
>  - It is fairly efficient to read incrementally
>
> -The arch/<arch>/dts directories contains a Makefile for building the dev=
icetree
> -blob and embedding it in the U-Boot image. This is useful since it allow=
s
> -U-Boot to configure itself according to what it finds there. If you have
> -a number of similar boards with different peripherals, you can describe
> -the features of each board in the devicetree file, and have a single
> -generic source base.
> +The U-Boot Makefile infrastructure allows for building the devicetree bl=
ob
> +and embedding it in the U-Boot image. This is useful since it allows U-B=
oot
> +to configure itself according to what it finds there. If you have a numb=
er
> +of similar boards with different peripherals, you can describe the featu=
res
> +of each board in the devicetree file, and have a single generic source b=
ase.
>
> -To enable this feature, add CONFIG_OF_CONTROL to your board config file.
> +To enable this feature, select `OF_CONTROL` via Kconfig.
>
>
>  What is a Flattened Devicetree?
> @@ -68,8 +68,21 @@ a binary file. U-Boot adds its own `fdtgrep` for creat=
ing subsets of the file.
>  Where do I get a devicetree file for my board?
>  ----------------------------------------------
>
> -You may find that the Linux kernel has a suitable file. Look in the
> -kernel source in arch/<arch>/boot/dts.
> +Linux kernel Git repository has been the place where devicetree files al=
ong
> +with devicetree bindings are stored and maintained. There is devicetee-r=
ebasing
> +(dtrepo_) which maintains a forked copy of devicetree files along with b=
indings
> +at every Linux kernel major release or intermideate release candidates.

Typo.

> +
> +In order to maintain devicetree files sync, U-Boot maintains a Git subtr=
ee for
> +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It is re=
gularly
> +kept updated with every new kernel major release via subtree pull as fol=
lows::

I would suggest dropping "-rebasing" in the u-boot tree. (I wish we
had in the original repo). I don't think it's relevant.

We're not likely to regenerate the tree, but any clue what 'git
subtree pull' would do in this case? It could happen if we switched to
git-filter-repo.

> +
> +    git subtree pull --prefix devicetree-rebasing \
> +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicet=
ree-rebasing.git \
> +        <release-tag> --squash

I'd put this in a script to run. Documentation tends to be not quite
correct. A script could also be smarter and figure out <release-tag>.

> +
> +You may find that the `devicetee-rebasing/` sub-directory has a suitable
> +devicetree file for your board. Look in `devicetree-rebasing/src/<arch>/=
`.
