Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF434C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 12:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7CB780F9C;
	Sat, 15 Mar 2025 13:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T+9uKu14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 203D080ECC; Sat, 15 Mar 2025 13:47:18 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D765808A2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 13:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e5e63162a0so4345954a12.3
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 05:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742042835; x=1742647635; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xzqV8OJArIXQGM2sC1zaU/Fdw1FNI1jMXMjboJjkcGY=;
 b=T+9uKu14G0WZ60YrcTysXjAabgQv3wAQVkWXLQUPafbzFRHQ0ZuonSd4MPHTn7u7h1
 kBghSeDqUTFtL4465l5fX/VUg09ra6ipKu804/IpAf6ZvzW8lfAwVJoX/OgerM/RRtGA
 aD0ZB7Mez53fudow69mebdCrmXad3Uz15id3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742042835; x=1742647635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xzqV8OJArIXQGM2sC1zaU/Fdw1FNI1jMXMjboJjkcGY=;
 b=rY3DIQixBZkjV60e2tbppTSuLDucVYRhoqay10ojhdEF9Z/v8UbJqJk11DMBV2yWWR
 hdDPa1Uq/bq1hha0BLKc7dWRWlGbpZV3H1uzZFfWF1vxQlpka10/0M83FWN5WnyrdjD5
 FmdlivpJvtk0rcQm2aH+X8WiTPThCdoGQFLTO/P1f2jpbkgt+YEw/aMvAGqLFfHiY2AQ
 E5aeZcFHQHPK0udbzzQ/5V1I67aA2lgCwgbU0SeXQ8GK+xw0VytUZhDkSKCpoIxJoHT5
 N0hJ4frsCS2y1saszG0BQxuEUaKGZy69x9uh71xjPwyHBiAjp38BYTzVQ3mIzKAQNuP9
 KylA==
X-Gm-Message-State: AOJu0Yxrn4GXz4636aJ3ME52/dPXW96njyY2G/8+pyRfhsCasX8m1c3s
 W4vQXf0iRKl4jdarkX2w8CtlbL8LTESNRTZcFAkXpc0S2uFD0mpFbXJp/UeLLBuMq17btwLWAfE
 31Jdc/LFdYOMfGIIbY8XfnPTTD2kLWVbTog8LmbktIJ/Ds8tfFw==
X-Gm-Gg: ASbGncs++82KVcjt+zeoRDXT6pCHjjXdkPngdH9NapLpl53EJmK4W0a4Mjyy6j8ATZg
 tH1tt1P2amklzpC047FfCzhoh/wW8pCTA48l895wBu9Qc1AXhyJRtLg9og7InnyjuSWsFs/AR3n
 YNQ/G43f+MauCOjGtT9ESeTdmRfxrqZLNhUa48hw==
X-Google-Smtp-Source: AGHT+IFg8sy6p7zQVIMmsb76dDoB+ufuzCy0O8rzL++2qRx1yVC4q+P1zIvOQlysqRqZch6WHO++G4Y87uyvNYx5pbE=
X-Received: by 2002:a05:6402:5108:b0:5e5:e836:71f3 with SMTP id
 4fb4d7f45d1cf-5e8a051bae9mr5679628a12.29.1742042835061; Sat, 15 Mar 2025
 05:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <CAFLszTiB8FBdOTYE+dn6ZTifZsdO0LU2jXKJZSRkPeKzf7ujPQ@mail.gmail.com>
 <7432dd9e-72e3-4072-88a7-18b58da746b3@linaro.org>
 <CAFLszTiPgVLYKYsLgcZJUCJ=tAAfTD_4v_aejks-4YRy=k-XeA@mail.gmail.com>
 <37799f19-3b7e-47c7-8f79-c010fc9dbe5a@linaro.org>
 <CAFLszTi7536co5PeXNbsA=Dw628gdYiP1F1hf0T9wPs-G4gT0g@mail.gmail.com>
 <661ee5c6-6b8e-4c6a-9c7c-9e0087d96c45@linaro.org>
 <4d9f3038-0f9b-456b-89bb-290b6c8c41fa@linaro.org>
In-Reply-To: <4d9f3038-0f9b-456b-89bb-290b6c8c41fa@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Mar 2025 12:47:03 +0000
X-Gm-Features: AQ5f1Jr-cJ18xMtWEALHxs35KZ1bIscsc3FGBgMunPsM-xJhnt_ZZq4k97cgwMg
Message-ID: <CAFLszTgg_=mH8YtMVjTSKhjDN0xCZSHVNpfPsJzT_6=cUEj4OQ@mail.gmail.com>
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

On Fri, 14 Mar 2025 at 22:01, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Simon,
>
> On 3/13/25 14:23, Jerome Forissier wrote:
> >
> >
> > On 3/13/25 13:51, Simon Glass wrote:
> >> Hi Jerome,
> >>
> >> On Fri, 7 Mar 2025 at 10:49, Jerome Forissier
> >> <jerome.forissier@linaro.org> wrote:
> >>>
> >>> Hi Simon,
> >>>
> >>> On 3/4/25 16:46, Simon Glass wrote:
> >>>> Hi Jerome,
> >>>>
> >>>> On Thu, 27 Feb 2025 at 09:43, Jerome Forissier
> >>>> <jerome.forissier@linaro.org> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2/27/25 17:27, Simon Glass wrote:
> >>>>>> Hi Jerome,
> >>>>>>
> >>>>>> On Thu, 27 Feb 2025 at 09:09, Jerome Forissier
> >>>>>> <jerome.forissier@linaro.org> wrote:
> >>>>>>>
> >>>>>>> This series adds support for HTTP server authentication using root (CA)
> >>>>>>> certificates.
> >>>>>>>
> >>>>>>> As a first step, the wget command is extended to support a sub-command:
> >>>>>>> cacert <addr> <size>. The memory region shall contain the CA
> >>>>>>> certificates. With this, it is possible to load the certificates from
> >>>>>>> storage or get them from the network for example, which is convenient
> >>>>>>> for testing at least. The Kconfig symbol for this feature is
> >>>>>>> WGET_CACERT=y.
> >>>>>>>
> >>>>>>> Then new Kconfig symbols are added to support providing the certificates
> >>>>>>> at build time, as a DER or PEM encoded X509 collection:
> >>>>>>> WGET_BUILTIN_CACERT=y and WGET_BUILTIN_CACERT_PATH=<some path>.
> >>>>>>> Note that PEM support requires MBEDTLS_LIB_X509_PEM=y (for the cacert
> >>>>>>> command as well as for the builtin way).
> >>>>>>>
> >>>>>>> Here is a complete example (showing only the relevant output from the
> >>>>>>> various commands):
> >>>>>>>
> >>>>>>>  make qemu_arm64_lwip_defconfig
> >>>>>>>  wget https://curl.se/ca/cacert.pem
> >>>>>>>  echo CONFIG_WGET_BUILTIN_CACERT=y >>.config
> >>>>>>>  echo CONFIG_WGET_BUILTIN_CACERT_PATH=cacert.pem >>.config
> >>>>>>>  make olddefconfig
> >>>>>>>  make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
> >>>>>>>  qemu-system-aarch64 -M virt -nographic -cpu max \
> >>>>>>>         -object rng-random,id=rng0,filename=/dev/urandom \
> >>>>>>>         -device virtio-rng-pci,rng=rng0 -bios u-boot.bin
> >>>>>>>  => dhcp
> >>>>>>>  # HTTPS transfer using the builtin CA certificates
> >>>>>>>  => wget https://www.google.com/
> >>>>>>>  18724 bytes transferred in 15 ms (1.2 MiB/s)
> >>>>>>>  # Disable certificate validation
> >>>>>>>  => wget cacert 0 0
> >>>>>>>  # Unsafe HTTPS transfer
> >>>>>>>  => wget https://www.google.com/
> >>>>>>>  WARNING: no CA certificates, HTTPS connections not authenticated
> >>>>>>>  16570 bytes transferred in 15 ms (1.1 MiB/s)
> >>>>>>>  # Dowload and apply CA certificates from the net
> >>>>>>>  => wget https://curl.se/ca/cacert.pem
> >>>>>>>  WARNING: no CA certificates, HTTPS connections not authenticated
> >>>>>>>  ##
> >>>>>>>  233263 bytes transferred in 61 ms (3.6 MiB/s)
> >>>>>>>  => wget cacert $fileaddr $filesize
> >>>>>>>  # Now HTTPS is authenticated against the new CA
> >>>>>>>  => wget https://www.google.com/
> >>>>>>>  18743 bytes transferred in 14 ms (1.3 MiB/s)
> >>>>>>>  # Drop the certificates again...
> >>>>>>>  => wget cacert 0 0
> >>>>>>>  # Check that transfer is not secure
> >>>>>>>  => wget https://www.google.com/
> >>>>>>>  WARNING: no CA certificates, HTTPS connections not authenticated
> >>>>>>>  # Restore the builtin CA
> >>>>>>>  => wget cacert builtin
> >>>>>>>  # No more WARNING
> >>>>>>>  => wget https://www.google.com/
> >>>>>>>  18738 bytes transferred in 15 ms (1.2 MiB/s)
> >>>>>>>
> >>>>>>> Jerome Forissier (5):
> >>>>>>>   net: lwip: extend wget to support CA (root) certificates
> >>>>>>>   lwip: tls: enforce checking of server certificates based on CA
> >>>>>>>     availability
> >>>>>>>   lwip: tls: warn when no CA exists amd log certificate validation
> >>>>>>>     errors
> >>>>>>>   net: lwip: add support for built-in root certificates
> >>>>>>>   configs: qemu_arm64_lwip_defconfig: enable WGET_CACERT and
> >>>>>>>     MBEDTLS_LIB_X509_PEM
> >>>>>>>
> >>>>>>>  cmd/Kconfig                                   | 29 ++++++
> >>>>>>>  cmd/net-lwip.c                                | 19 +++-
> >>>>>>>  configs/qemu_arm64_lwip_defconfig             |  2 +
> >>>>>>>  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    |  9 +-
> >>>>>>>  .../lwip/apps/altcp_tls_mbedtls_opts.h        |  6 --
> >>>>>>>  lib/mbedtls/Makefile                          |  3 +
> >>>>>>>  lib/mbedtls/mbedtls_def_config.h              |  5 ++
> >>>>>>>  net/lwip/Makefile                             |  6 ++
> >>>>>>>  net/lwip/wget.c                               | 90 ++++++++++++++++++-
> >>>>>>>  9 files changed, 158 insertions(+), 11 deletions(-)
> >>>>>>
> >>>>>> Did you manage to add some sandbox tests for lwip?
> >>>>>
> >>>>> Unfortunately not. I am testing mostly with QEMU (qemu_arm64_lwip_defconfig)
> >>>>> and sometimes with KV260 and i.MX93.
> >>>>
> >>>> My understanding was that someone was working on it [1] and I had
> >>>> assumed it was you?
> >>>
> >>> Yes, it is on my TODO list. Higher priority things have kept coming in, but
> >>> hopefully I can resume this work soon.
> >>
> >> Until the tests are added, please stop sending new series for lwip. It
> >> is just going to make it harder to add the tests later.
> >
> > I don't see how exactly it would make things harder, but...
> >
> >> It should not
> >> take long to add a basic test, e.g. for ping.
> >
> > ...I'm on it.
>
> Please see https://lists.denx.de/pipermail/u-boot/2025-March/583551.html.

Thank you for doing that!

Regards,
Simon
