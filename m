Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B49CF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 460AA8900E;
	Wed,  9 Oct 2024 03:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xo3OEqkz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 264CE8901F; Wed,  9 Oct 2024 03:51:09 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A630A89013
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbc40d9fa0so8156116d6.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438665; x=1729043465; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qr0AakLBGCWEsaPCbYyExgtrOCJ907Oakni/ikVjpgY=;
 b=Xo3OEqkzL20UJwDQG/rYblcMVHZ6FyNxOIIqdXhcO9eadet9Pdh6EjwK54s7reXscZ
 PDbChrZ1c0kctNaUirkcXZZMGTxe8dtO8Vf/r60/ltN4pq8CGxCFwZBQLZnj74jVInAl
 K+rwxdjrXlt0pX3f6iFE0RLl2EQ+1cqHXP3LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438665; x=1729043465;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qr0AakLBGCWEsaPCbYyExgtrOCJ907Oakni/ikVjpgY=;
 b=AiYk1HeDT9sfVTj7P2DKGD14aukBUFR9I/tBHKuRQWf8hu9Hgpf5PrBz/5CCt/1Wnu
 HhaC8mLLlReRqcPLTAORrNEWl1zBd5dGofJDTgKYerhZ/k+MnjVlRBikeGEFpr+/RPZp
 NG34t0RR8yVOH/LB5LY2Oe67ZNAknoa7wcFOlOqWkb4CWWqe2VGdMdvK+NH/uKAnSbkr
 S5N43hXVCq+uRrfLzcKVCZ6UacStQcpWg2lF0d1jt3KDraUTvQ0v3uuJmDaBYrXbBlM5
 T0Pz5FG0piYWyJku94Bx/cY0rvWeBofPohmHRfcz9+JapbaVUazGzdVKR4x2GvTf8QNd
 ByBA==
X-Gm-Message-State: AOJu0Yzd/dCTU9rSktzaEQSOJ3pGoa28fgDBaSqC0Uyu5QkpisFzTl0q
 vsHC0zxmB/RJWvg25NGDB2IE+gR/53VOpGecAKE8DyEgLUd4ukEKYbiq2Ohnrb5XiQEKAO8J+FQ
 LhGDYm1hcOjUbrhouO8IblPoyMjbzgsnagrAb
X-Google-Smtp-Source: AGHT+IHApf8orcQntH9VQGtbxKkYk8FBrNOZaAbvtcgX9CDjZazvuOZGBd1HBtBI/5sceDZNzK339IKCiylM2Cp6iTE=
X-Received: by 2002:a05:6214:2f02:b0:6cb:c699:653c with SMTP id
 6a1803df08f44-6cbc942f091mr17329276d6.11.1728438665431; Tue, 08 Oct 2024
 18:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240916082446.32082-1-al.kochet@gmail.com>
In-Reply-To: <20240916082446.32082-1-al.kochet@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:50:54 -0600
Message-ID: <CAFLszTg+xm4qBOCkPhmYGJKCaB8SR502FMQ9YJoJ9SiHcX+j3Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Implement signing FIT images during image build
To: al.kochet@gmail.com
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 16 Sept 2024 at 02:24, <al.kochet@gmail.com> wrote:
>
> From: Alexander Kochetkov <al.kochet@gmail.com>
>
> Hello!
>
> I've done verified boot on Radxa Rock 3A. I've embedded public key in U-Boot
> SPL and signed FIT image configuration. All the work was done during U-Boot
> image build. For some use cases building and signing images in one go will be
> much simple, than building unsigned images and signing later. For example
> SPL-image for rk3568 called idbloader.img consist of TPL, U-boot SPL and
> U-boot SPL DTB with public key. So in order to assemble signed idbloader.img
> lately we have to keep all the intermediate files used during build.
>
> To embed public key, I've replaced u-boot-spl node with blob-ext and generated
> u-boot-spl-with-pubkey-dtb blob using u-boot-spl-pubkey-dtb entry.
>
> To sign FIT image I've used newly implemented fit property 'fit,sign'.
>
> I haven't sign FIT image nodes, because I had realized that signing
> configuration is safe and sufficient for verified boot. But I doubt.
> So I've left that signing scheme in the test.
>
> What do you think, is using signed configuration and signed images at the same
> time is much safer or doesn't provide any benefits?

So long as you have hashes on the images, then yes it is sufficient.

>
> Now I thinking about implementing configuration option, something like
> FIT_SIGNATURE_KEYDIR. The value of the option will be passed to binman
> using -I.

I suppose you saw entryargs - could that help?

>
> Alsi I want to embed another public key in the configuration DTB, so
> it will be used to verify kernel FIT. But I couldn't figure out how to
> do it using binman.

I'm not sure what you are trying to do here. The kernel image (or
really, its hash) would normally be verified using the same signature
as for everything else in the configuration.

>
> &binman {
>     u-boot-spl-with-pubkey-dtb {
>         filename = "u-boot-spl-with-pubkey-dtb.bin";
>
>         u-boot-spl-nodtb {
>         };
>
>         u-boot-spl-pubkey-dtb {
>             algo = "sha256,rsa2048";
>             required = "conf";
>             key-name-hint = "uboot-spl";
>         };
>     };
>
>     simple-bin {
>         ...
>         mkimage {
>             ...
>
> #ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
>             rockchip-tpl {
>             };
> #elif defined(CONFIG_TPL)
>             u-boot-tpl {
>             };
> #endif
>             blob-ext {
>                 filename = "u-boot-spl-with-pubkey-dtb.bin";
>             };
>         };
>
>         fit: fit {
>             ...
>             fit,sign;
>             ...
>
>             configurations {
>                 default = "@config-DEFAULT-SEQ";
>                 @config-SEQ {
>                     ...
> #ifdef CONFIG_SPL_FIT_SIGNATURE
>                     signature {
>                         algo = "sha256,rsa2048";
>                         key-name-hint = "uboot-spl";
>                         sign-images = "firmware", "loadables", "fdt";
>                     };
> #endif
>                 };
>             };
>         };
>     };
> }
>
>
> Alexander Kochetkov (3):
>   binman: fix passing loadables to mkimage on first run
>   image-host: fix 'unknown error' error message
>   binman: implement signing FIT images during image build
>
>  tools/binman/btool/mkimage.py           |  5 +-
>  tools/binman/entries.rst                |  7 ++
>  tools/binman/etype/fit.py               | 57 +++++++++++++-
>  tools/binman/ftest.py                   | 95 ++++++++++++++++++++++++
>  tools/binman/test/326_fit_signature.dts | 98 +++++++++++++++++++++++++
>  tools/binman/test/326_rsa2048.key       | 28 +++++++
>  tools/binman/test/327_fit_signature.dts | 98 +++++++++++++++++++++++++
>  tools/binman/test/328_fit_signature.dts | 61 +++++++++++++++
>  tools/image-host.c                      |  2 +-
>  9 files changed, 446 insertions(+), 5 deletions(-)
>  create mode 100644 tools/binman/test/326_fit_signature.dts
>  create mode 100644 tools/binman/test/326_rsa2048.key
>  create mode 100644 tools/binman/test/327_fit_signature.dts
>  create mode 100644 tools/binman/test/328_fit_signature.dts
>
> --
> 2.17.1
>

Regards,
Simon
