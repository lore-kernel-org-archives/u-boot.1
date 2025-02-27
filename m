Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6980C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9152481428;
	Thu, 27 Feb 2025 17:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YvCjaW3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D55ED81113; Thu, 27 Feb 2025 17:28:20 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20E0A8120C
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso1944835a91.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740673697; x=1741278497; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WWgIUp3onK8VzKvaO/qFdbWxbofUhRoWoQ1HyXxF6F4=;
 b=YvCjaW3g9HyrS9U83FX5miKCh4TwZQw1NP3fW5a3hypMpD3S2AwaOvflKL2eSxCxyS
 QtIvHzartvRI56ta8b79XcX2uA1HMdPz6oTopHkJHcKP1sP1lwbMI6T4kz4HuPr2EXh5
 erV3Hx3OT53rQ+TUDlW6PtGFG60JcwOlP/JEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673697; x=1741278497;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WWgIUp3onK8VzKvaO/qFdbWxbofUhRoWoQ1HyXxF6F4=;
 b=KAKUgFaO2OB/ox3YuYcVqXWTjcWfg/EVpfS1NmqoEFBejA4yvgIXv6eY5BKaEt7MNf
 kFF3Oj0D70h3Md6UCMHIlabT8JqDgImfND4YjxMFMgiOBwhkNx+HLr76bmuxXWYIKfDs
 +kRmHEfumhh0A6KyvvM+b176Oto3o36YNaMhy/UCa0E5bHYa94Yg2uXvovBczI79w6cU
 +4KxNJ/dk1HqGbzyX3gSAItmCJFK8yua8xPZYAUDvf/7g20in+C3Fsq0I4gB02nxehgH
 roI2YRXBAtI5JJZprEiatqqBxUuTuB//qwQQxYf9l4KtPpoIpanpBu9MMmWWxRhoeZ4I
 qoJw==
X-Gm-Message-State: AOJu0Yx/hOmgi7PlDoX/QZb17LsxeE2Bd48U/epSdRu0Z8pBrcSaBZxE
 KeLTgzRPcWFyqgbFO1MECFhoOc4BuPulqGe1MyPeZ3vXbcgKAMjcgQOEXFqRaiNsgUX9YZWWN8p
 VxI0PB0GqFTrI30nWtvQT1g2ov3AbLF4YV8SQ
X-Gm-Gg: ASbGnct9muj5dARXATZ1eOZgTCDAcw4gyNB4TSz6KvrNLqRsssXpVwcQXAlsjIJg7BK
 mlFJCNinHGH5bGLjHxzJi3t2WXCNW/iRF4RuEbVl0j9XJ8RWmuwdsGs1BEVlD7vxV0D8K5NfaYC
 F6/CrGrthv
X-Google-Smtp-Source: AGHT+IE/AlyylpoqHxigumn4d6Px2G1pkZjHNzxkGrfvXaD139tJSlzZ7N5sNzosyA51rGQCZ0J9KLKkFdEF7PNZt94=
X-Received: by 2002:a17:90b:1dc4:b0:2fe:b5d1:dbf4 with SMTP id
 98e67ed59e1d1-2feb5d1dca0mr1686238a91.33.1740673696674; Thu, 27 Feb 2025
 08:28:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740672437.git.jerome.forissier@linaro.org>
In-Reply-To: <cover.1740672437.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Feb 2025 09:27:53 -0700
X-Gm-Features: AQ5f1Jr4LyMRepdmhWGPnmsazpfLIpCSObIRdfpUhh47kgMpA7QTAgDoh53KaK8
Message-ID: <CAFLszTiB8FBdOTYE+dn6ZTifZsdO0LU2jXKJZSRkPeKzf7ujPQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] net: lwip: root certificates
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Jerome,

On Thu, 27 Feb 2025 at 09:09, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> This series adds support for HTTP server authentication using root (CA)
> certificates.
>
> As a first step, the wget command is extended to support a sub-command:
> cacert <addr> <size>. The memory region shall contain the CA
> certificates. With this, it is possible to load the certificates from
> storage or get them from the network for example, which is convenient
> for testing at least. The Kconfig symbol for this feature is
> WGET_CACERT=y.
>
> Then new Kconfig symbols are added to support providing the certificates
> at build time, as a DER or PEM encoded X509 collection:
> WGET_BUILTIN_CACERT=y and WGET_BUILTIN_CACERT_PATH=<some path>.
> Note that PEM support requires MBEDTLS_LIB_X509_PEM=y (for the cacert
> command as well as for the builtin way).
>
> Here is a complete example (showing only the relevant output from the
> various commands):
>
>  make qemu_arm64_lwip_defconfig
>  wget https://curl.se/ca/cacert.pem
>  echo CONFIG_WGET_BUILTIN_CACERT=y >>.config
>  echo CONFIG_WGET_BUILTIN_CACERT_PATH=cacert.pem >>.config
>  make olddefconfig
>  make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
>  qemu-system-aarch64 -M virt -nographic -cpu max \
>         -object rng-random,id=rng0,filename=/dev/urandom \
>         -device virtio-rng-pci,rng=rng0 -bios u-boot.bin
>  => dhcp
>  # HTTPS transfer using the builtin CA certificates
>  => wget https://www.google.com/
>  18724 bytes transferred in 15 ms (1.2 MiB/s)
>  # Disable certificate validation
>  => wget cacert 0 0
>  # Unsafe HTTPS transfer
>  => wget https://www.google.com/
>  WARNING: no CA certificates, HTTPS connections not authenticated
>  16570 bytes transferred in 15 ms (1.1 MiB/s)
>  # Dowload and apply CA certificates from the net
>  => wget https://curl.se/ca/cacert.pem
>  WARNING: no CA certificates, HTTPS connections not authenticated
>  ##
>  233263 bytes transferred in 61 ms (3.6 MiB/s)
>  => wget cacert $fileaddr $filesize
>  # Now HTTPS is authenticated against the new CA
>  => wget https://www.google.com/
>  18743 bytes transferred in 14 ms (1.3 MiB/s)
>  # Drop the certificates again...
>  => wget cacert 0 0
>  # Check that transfer is not secure
>  => wget https://www.google.com/
>  WARNING: no CA certificates, HTTPS connections not authenticated
>  # Restore the builtin CA
>  => wget cacert builtin
>  # No more WARNING
>  => wget https://www.google.com/
>  18738 bytes transferred in 15 ms (1.2 MiB/s)
>
> Jerome Forissier (5):
>   net: lwip: extend wget to support CA (root) certificates
>   lwip: tls: enforce checking of server certificates based on CA
>     availability
>   lwip: tls: warn when no CA exists amd log certificate validation
>     errors
>   net: lwip: add support for built-in root certificates
>   configs: qemu_arm64_lwip_defconfig: enable WGET_CACERT and
>     MBEDTLS_LIB_X509_PEM
>
>  cmd/Kconfig                                   | 29 ++++++
>  cmd/net-lwip.c                                | 19 +++-
>  configs/qemu_arm64_lwip_defconfig             |  2 +
>  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    |  9 +-
>  .../lwip/apps/altcp_tls_mbedtls_opts.h        |  6 --
>  lib/mbedtls/Makefile                          |  3 +
>  lib/mbedtls/mbedtls_def_config.h              |  5 ++
>  net/lwip/Makefile                             |  6 ++
>  net/lwip/wget.c                               | 90 ++++++++++++++++++-
>  9 files changed, 158 insertions(+), 11 deletions(-)

Did you manage to add some sandbox tests for lwip?

Regards,
Simon
