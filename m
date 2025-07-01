Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1421DC8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 09:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F211281E13;
	Tue,  1 Jul 2025 11:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SgWy9Amn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C9B582A76; Tue,  1 Jul 2025 10:56:57 +0200 (CEST)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07B0A8003E
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 10:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-5316a5e4c6cso1721420e0c.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 01:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751360214; x=1751965014; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OH1ci2r2a4/SPQHmui5em9uLjkg28IzaZ1M+lnG6rQ=;
 b=SgWy9Amnjm5+OQLzq7zDpEpyUPPZGFB/IE4qttGfbr4k/22fIXJszDy5O2gBtriEGa
 fXlbIAC1vtxtgtxv+ylU0CsS4KYk/xSDxSFphbXf9H6/pw5WopGpo0hEmsOTx7k+Y1Rv
 jxcvaVUfAhyKuAedI8NzKqmlIDJ6FuYrE7bufjVY5AY1Oragbc/p5722Nm5QTW0CSHbs
 eB6ytI6OCAenmqu/mVGG+fGtC0DRyoG5QJ0MfhXaF25AEj8RbFSQKuRFEsqSHo3z/BwP
 zz+aMobsw7wlorJyLgqITKW8VsaK+DyeimVoV0tKeX0tkDNYOU2Zmkjus6VgkgWo+eUf
 6i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751360214; x=1751965014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7OH1ci2r2a4/SPQHmui5em9uLjkg28IzaZ1M+lnG6rQ=;
 b=kfGWVc8/+lzEevlecE4afQR12qupe1DHhUSiSTUDEHR21TkeyszZjUdiP+tglfbuaL
 fdE9pj3p9BSWan0MtDQ52+joIYeLUW4BtRvPf5j/NVH09L1Bby1FaYiTOXS6UeFOvvKg
 62sl1N806cMfp4OMEXEi14LdJS/rEGb9P2FRQiSiGyKBg9K5fAGecVIPX6cYfBcd2kwp
 ndABbTfKORySEl6BAQltpXcb+mRSkO+kmMEUxapcueef+YgYpVm+zwsge3c9EDcjSUlG
 u3XVql0aPd7wiYWqTfr696ZUd18brXRy9nPdAOHWo70RaJ5503NBjiM0N4M7WLof0N+I
 im5g==
X-Gm-Message-State: AOJu0Yz3bSEWhZORTUJ4Txni0lUyBlLa+BbGn55d172W38UeAarTe7I+
 d3m97CfBmWh+2dEOy7Y8OXy4Y+GHgYSIGnNU0VOYGjWtE6sn1qD0V7cUUDyXzIPiKRATHcKQRf8
 5kVsUIuJ4vwCj5eyvyaUQWbpJRmw9Zt5Ubd//kC2dqG4r
X-Gm-Gg: ASbGncu84nAAvzCiJVAwtbQoUQpmxbMOkRL2wWPZESARpc8uX11Q5gHEZAn62lUY6eu
 yTcYZT48WYRMLklXNwR05TsKhNIp7+FUD3S8VFf0Bg5wlfmULSMO+F961gVCF/GNT4wiexpG4KO
 eTRTAop3wj/SpUrYnOTBkxYys52lsk2cXfq9+4XUQNj6KOE5IDv8wI1P4=
X-Google-Smtp-Source: AGHT+IGhx1Zxr1H7fL6YEPt2nnXELNodnfeF+0PMKQEZjIookn0Fvt8nF/G5YLpzLYxhhlTgFJLwdzqggCHY15lfYKw=
X-Received: by 2002:a05:6122:2526:b0:530:720b:abe9 with SMTP id
 71dfb90a1353d-5330bfbe262mr10318950e0c.7.1751360213672; Tue, 01 Jul 2025
 01:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250411011025.1434660-1-james.hilliard1@gmail.com>
In-Reply-To: <20250411011025.1434660-1-james.hilliard1@gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 1 Jul 2025 11:56:42 +0300
X-Gm-Features: Ac12FXxTlc5QWQCENKt9qXnyPtCm5_p06Vbz8zy60O2EOJn0Z98OGX0VjuTgToA
Message-ID: <CADvTj4qgNJNYCpQ=5vMq8fPT6M1VTe=a4A1w5_Bcwic77KQ4fg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Makefile: pass KEYDIR when set to sunxi-spl.bin
 mkimage
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 01 Jul 2025 11:14:13 +0200
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

On Fri, Apr 11, 2025 at 4:10=E2=80=AFAM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> Currently we pass this for u-boot-spl.kwb targets, however when
> building sunxi-spl.bin in the TOC0 format we may also need to
> specify a KEYDIR, as such we should also pass this when set
> to mkimage for the sunxi-spl.bin target.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  scripts/Makefile.xpl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> index abc49fbe6c9..d1c1cea876a 100644
> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -445,7 +445,8 @@ MKIMAGEFLAGS_sunxi-spl.bin =3D \
>         -A $(ARCH) \
>         -T $(CONFIG_SPL_IMAGE_TYPE) \
>         -a $(CONFIG_SPL_TEXT_BASE) \
> -       -n $(CONFIG_DEFAULT_DEVICE_TREE)
> +       -n $(CONFIG_DEFAULT_DEVICE_TREE) \
> +       $(if $(KEYDIR),-k $(KEYDIR))

Does this look good to merge?

>
>  OBJCOPYFLAGS_u-boot-spl-dtb.hex :=3D -I binary -O ihex --change-address=
=3D$(CONFIG_SPL_TEXT_BASE)
>
> --
> 2.34.1
>
