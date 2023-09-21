Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03709E7D0AF
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 22:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB3F86410;
	Fri, 22 Sep 2023 00:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PXuDXw20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E48D8641B; Fri, 22 Sep 2023 00:00:04 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADD2486400
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 00:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-532784c8770so1778657a12.1
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 15:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695333602; x=1695938402; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6MrTitYGl8M+zZAeSZtP5lALx4uOzN0cdKYdzZA3UTg=;
 b=PXuDXw20/Vo+KLuFmMFuKLEBWiINlYnlZOpx3JpiZaOWXfDVY1caambP4yrxFRbRCc
 pin1lwcM8dn33s2DVjGxxbeI4E0S1XpcT0czv7znnGon4Izyb05lL31jQQbcC6If+Dyj
 6Zg9gWKWm14RFgCzj6OuuDLbdJk2Zypk0nPV3dbZAnzMPZBgXRRqXWcm8pesyymhevXC
 ispG7EN7oKGNDcIuz8ab0hw+yrlCppu2k3TD11dIiy+sfBTxpCA5wtbKOI/XeNgrqa1S
 N6SebpJCU0FNP8wAUFXuH2gK6yjk/fC4ZCEA9b8Iykg+XM8DsCDO1iyDy/aJXUgG4pWg
 AvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695333602; x=1695938402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6MrTitYGl8M+zZAeSZtP5lALx4uOzN0cdKYdzZA3UTg=;
 b=tBzGS4wzrTK+/LH23oI6Yct5CgLkLtHjKeydKvLpVPMxfSVLJdAGC8RsyOpKvFJd8r
 yUZZ4jCWNCSB2z5OVtI/H9cF4HZ2dWr0KM1f/VR3xLHrI+uib7VWDnBYLGYiX6nrarzT
 61CazvuyJJ9D43F/uvo1LGSMP8SpopsA2p4JtPbMcFhlTqyhPRZd69vhbiVHcNTGeV7q
 HvQY/Mr4xk3ZfR4wSWLhYmGUBiVMJVMr4vjKc2XafoPMHHl+lXGKzWv0J9tBOOOEOm6j
 2klJQEwUFw/TODmtBfYdlC6M31A+ig0mmUxfOpSgQplAzsl5Wc+3KK8AJGgKZGJ9BxHK
 YySw==
X-Gm-Message-State: AOJu0YzloLgiHjTDWOZDn4Bv0M/EUNoIf2dRYzzlZF6A5GlAefPdI4u2
 ix4nVCDa/ydPMqHhrbfusTAC5qsRy53Ex/HlKGI=
X-Google-Smtp-Source: AGHT+IG4jirPDzTndqdS24l+6kWEja0OaBYLoFDcx0+el2RcYJJTI7+ATROwrnAJgKIx8rqplTOA8utncIg5kUG7+eM=
X-Received: by 2002:a17:906:300e:b0:9a1:bebc:8282 with SMTP id
 14-20020a170906300e00b009a1bebc8282mr6014175ejz.32.1695333601916; Thu, 21 Sep
 2023 15:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230921133748.1543007-1-sjg@chromium.org>
 <20230921133748.1543007-3-sjg@chromium.org>
In-Reply-To: <20230921133748.1543007-3-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 22 Sep 2023 05:59:50 +0800
Message-ID: <CAEUhbmWsRtKceAU305KA+v+uMn_rgX++RF-7j_SPPj-fTuc3wA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] x86: coreboot: Drop USB init on startup
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, Sep 21, 2023 at 9:37=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> This is very annoying as it is quite slow on many machines. Also, U-Boot
> has an existing 'preboot' mechanism to enable this feature if desired.
>
> Drop this code so that it is possible to choose whether to init USB or
> not.
>
> Use the existing USE_PREBOOT mechanism instead.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v7:
> - Add docs about how USB keyboard works on coreboot
>
> Changes in v5:
> - Make use of the uSE_PREBOOT mechanism
>
>  arch/x86/cpu/coreboot/Kconfig    | 1 +
>  arch/x86/cpu/coreboot/coreboot.c | 4 ----
>  doc/board/coreboot/coreboot.rst  | 7 +++++++
>  3 files changed, 8 insertions(+), 4 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

series applied to u-boot-x86/next, thanks!
