Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7C9C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 12:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 492B380FF7;
	Thu, 13 Mar 2025 13:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FM0GAX9h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E291F80540; Thu, 13 Mar 2025 13:51:55 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8DF780540
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 13:51:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac2a089fbbdso181573066b.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 05:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741870312; x=1742475112; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kSch8TZXX7ctGXrD74BSeEtfj7gTKiwVWkX8TwSzT3I=;
 b=FM0GAX9hxLiQVyN+uA4/WoS7rGninlAdHL8ypSkxh0VrLssPv1h1a46XtDQiV62K6R
 FgeDWKl7hDOdxuGKN+zmdxsHkJzs5UoyOT//fPQ5/kKCztok46KhnMIeyxXNqiJ9qQ0l
 Z3m6csD/NlxAR6nCU6RkfA0vlB7skR5z2sz4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741870312; x=1742475112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kSch8TZXX7ctGXrD74BSeEtfj7gTKiwVWkX8TwSzT3I=;
 b=b9IxoKFRj9DfMwTrWRAGUFldGC2yky/rfGSP7GdBKwL18Ugts7DkA9te51VFWH6wOr
 cL2oPgJPBlMVAzsc8Llo/1yCk/y/dK9FaWj7wE5dPJJDzFSsKp+RtTZjPpERAs8tS09B
 FFqmeOLOZN3hv7pN7gU0enOFZjrouXj3fxqqzjfpiFn4M0RukyGR40d7OrCip5uOM+uo
 7CgODgpFpHsj+ltKHVj7KqK35nU6Zydc66rGMi7I4sn4qWIfuvTRto1795ID8FyC7vMR
 Ep3nX4NKgdS6pHudZM36VKY5BIkp9F45COWIdNc/suRsTZ7lT5YFnQ3kYUXMAIonc0gk
 Eo+A==
X-Gm-Message-State: AOJu0YyI+j2LKguxOI/3dKq2GuAbdyx/CBsnQ+25NXXkP+ptY9wOADXh
 ita/2YPVoskJ3NnVPDVIOXphA3vfjmAgdvxFI5MMRiP1Ihh8pCiL/xVsO+PNUWQU70o9DzsTam3
 sSG2sTv23BLjvRXudHTMzhfWJ0DBhZa5un6RjxSFDWqvX8ZU=
X-Gm-Gg: ASbGncsPEUTgMxNsy7YiGD/ns77xIy5G/dq++0XKO6gFi662TOZ/EUcsJpADwbwluLA
 XQB3+MlhJcRJJ9gV5KSc3/YIVjueOgYBXgdsZH4gF3f1QutYYTewhooOJPqXR1fpp8tq7OnEJqr
 oXL+TuD3KRJ3JxB/22hi/kG2m66PEK
X-Google-Smtp-Source: AGHT+IEgpJUZfZzvup44k5PCYY3FlJDuO9Aj6x6bSsXl9Lxiw2+c59KwCUQlyqRrV8Um1qZ9SJ3xv2zL6bhVTbasRFA=
X-Received: by 2002:a17:907:9692:b0:ac1:f247:69f5 with SMTP id
 a640c23a62f3a-ac312420fdemr255007966b.28.1741870312195; Thu, 13 Mar 2025
 05:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <CAFLszTiB8FBdOTYE+dn6ZTifZsdO0LU2jXKJZSRkPeKzf7ujPQ@mail.gmail.com>
 <7432dd9e-72e3-4072-88a7-18b58da746b3@linaro.org>
 <CAFLszTiPgVLYKYsLgcZJUCJ=tAAfTD_4v_aejks-4YRy=k-XeA@mail.gmail.com>
 <37799f19-3b7e-47c7-8f79-c010fc9dbe5a@linaro.org>
In-Reply-To: <37799f19-3b7e-47c7-8f79-c010fc9dbe5a@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Mar 2025 12:51:39 +0000
X-Gm-Features: AQ5f1JrCQYwEvoaJDtepYnWy0Wnfh49of69xq_lUq3SP8lJO5Syt7ZRnYI09NE0
Message-ID: <CAFLszTi7536co5PeXNbsA=Dw628gdYiP1F1hf0T9wPs-G4gT0g@mail.gmail.com>
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

On Fri, 7 Mar 2025 at 10:49, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Simon,
>
> On 3/4/25 16:46, Simon Glass wrote:
> > Hi Jerome,
> >
> > On Thu, 27 Feb 2025 at 09:43, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >>
> >>
> >> On 2/27/25 17:27, Simon Glass wrote:
> >>> Hi Jerome,
> >>>
> >>> On Thu, 27 Feb 2025 at 09:09, Jerome Forissier
> >>> <jerome.forissier@linaro.org> wrote:
> >>>>
> >>>> This series adds support for HTTP server authentication using root (CA)
> >>>> certificates.
> >>>>
> >>>> As a first step, the wget command is extended to support a sub-command:
> >>>> cacert <addr> <size>. The memory region shall contain the CA
> >>>> certificates. With this, it is possible to load the certificates from
> >>>> storage or get them from the network for example, which is convenient
> >>>> for testing at least. The Kconfig symbol for this feature is
> >>>> WGET_CACERT=y.
> >>>>
> >>>> Then new Kconfig symbols are added to support providing the certificates
> >>>> at build time, as a DER or PEM encoded X509 collection:
> >>>> WGET_BUILTIN_CACERT=y and WGET_BUILTIN_CACERT_PATH=<some path>.
> >>>> Note that PEM support requires MBEDTLS_LIB_X509_PEM=y (for the cacert
> >>>> command as well as for the builtin way).
> >>>>
> >>>> Here is a complete example (showing only the relevant output from the
> >>>> various commands):
> >>>>
> >>>>  make qemu_arm64_lwip_defconfig
> >>>>  wget https://curl.se/ca/cacert.pem
> >>>>  echo CONFIG_WGET_BUILTIN_CACERT=y >>.config
> >>>>  echo CONFIG_WGET_BUILTIN_CACERT_PATH=cacert.pem >>.config
> >>>>  make olddefconfig
> >>>>  make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
> >>>>  qemu-system-aarch64 -M virt -nographic -cpu max \
> >>>>         -object rng-random,id=rng0,filename=/dev/urandom \
> >>>>         -device virtio-rng-pci,rng=rng0 -bios u-boot.bin
> >>>>  => dhcp
> >>>>  # HTTPS transfer using the builtin CA certificates
> >>>>  => wget https://www.google.com/
> >>>>  18724 bytes transferred in 15 ms (1.2 MiB/s)
> >>>>  # Disable certificate validation
> >>>>  => wget cacert 0 0
> >>>>  # Unsafe HTTPS transfer
> >>>>  => wget https://www.google.com/
> >>>>  WARNING: no CA certificates, HTTPS connections not authenticated
> >>>>  16570 bytes transferred in 15 ms (1.1 MiB/s)
> >>>>  # Dowload and apply CA certificates from the net
> >>>>  => wget https://curl.se/ca/cacert.pem
> >>>>  WARNING: no CA certificates, HTTPS connections not authenticated
> >>>>  ##
> >>>>  233263 bytes transferred in 61 ms (3.6 MiB/s)
> >>>>  => wget cacert $fileaddr $filesize
> >>>>  # Now HTTPS is authenticated against the new CA
> >>>>  => wget https://www.google.com/
> >>>>  18743 bytes transferred in 14 ms (1.3 MiB/s)
> >>>>  # Drop the certificates again...
> >>>>  => wget cacert 0 0
> >>>>  # Check that transfer is not secure
> >>>>  => wget https://www.google.com/
> >>>>  WARNING: no CA certificates, HTTPS connections not authenticated
> >>>>  # Restore the builtin CA
> >>>>  => wget cacert builtin
> >>>>  # No more WARNING
> >>>>  => wget https://www.google.com/
> >>>>  18738 bytes transferred in 15 ms (1.2 MiB/s)
> >>>>
> >>>> Jerome Forissier (5):
> >>>>   net: lwip: extend wget to support CA (root) certificates
> >>>>   lwip: tls: enforce checking of server certificates based on CA
> >>>>     availability
> >>>>   lwip: tls: warn when no CA exists amd log certificate validation
> >>>>     errors
> >>>>   net: lwip: add support for built-in root certificates
> >>>>   configs: qemu_arm64_lwip_defconfig: enable WGET_CACERT and
> >>>>     MBEDTLS_LIB_X509_PEM
> >>>>
> >>>>  cmd/Kconfig                                   | 29 ++++++
> >>>>  cmd/net-lwip.c                                | 19 +++-
> >>>>  configs/qemu_arm64_lwip_defconfig             |  2 +
> >>>>  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    |  9 +-
> >>>>  .../lwip/apps/altcp_tls_mbedtls_opts.h        |  6 --
> >>>>  lib/mbedtls/Makefile                          |  3 +
> >>>>  lib/mbedtls/mbedtls_def_config.h              |  5 ++
> >>>>  net/lwip/Makefile                             |  6 ++
> >>>>  net/lwip/wget.c                               | 90 ++++++++++++++++++-
> >>>>  9 files changed, 158 insertions(+), 11 deletions(-)
> >>>
> >>> Did you manage to add some sandbox tests for lwip?
> >>
> >> Unfortunately not. I am testing mostly with QEMU (qemu_arm64_lwip_defconfig)
> >> and sometimes with KV260 and i.MX93.
> >
> > My understanding was that someone was working on it [1] and I had
> > assumed it was you?
>
> Yes, it is on my TODO list. Higher priority things have kept coming in, but
> hopefully I can resume this work soon.

Until the tests are added, please stop sending new series for lwip. It
is just going to make it harder to add the tests later. It should not
take long to add a basic test, e.g. for ping.

Regards,
Simon
