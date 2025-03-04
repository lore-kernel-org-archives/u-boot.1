Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B71C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF8D800C1;
	Tue,  4 Mar 2025 16:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YdtdBkFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 665D380786; Tue,  4 Mar 2025 16:46:27 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8FA28004F
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac0cc83e9adso394682066b.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741103184; x=1741707984; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nK8XPphp3pRFKXyw9Zsf2JClG8+sFr8CMaNbtdrSms8=;
 b=YdtdBkFCAc2X6dIVgYIQoyNgBIWquhmocj/NhryKMf5l7m03wkCRFARbrkkETKoWW0
 PGzGvgIRTSyoiaxBZACox+trtNhbYQbrxxiLM5PBAYtcgIEWZcKREPkJ817Tz/6JlGH5
 I61TOMaTxIsf3yXfqlesHP9A1zcHUL2kCuQzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741103184; x=1741707984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nK8XPphp3pRFKXyw9Zsf2JClG8+sFr8CMaNbtdrSms8=;
 b=MBilSN7NY6YQSdUV7wUu+wXn6tFpfi+/vUu/BXH0E1BEFh1A2OPqKkIKQQ+djtlGmv
 /01J4tTHaCVnkUJ4n3rht/cCZK+Sd9xFpLKKP8OohY/CuAj2nvhnB3wRcduM8+5nbV/h
 3WTRDtq8uM2JVjXXMYM0Cj0TkYY9FP43j3H9uUNs0evAfS4fvqk08aPEYnX7L5M3W9S6
 X4J+SrDrIXYX5jgDrr0mJLwxn+Id1Ty/soqNRbumkHvzSFFK0yq8r2ALct2A5YWXaxue
 /mlMbQg1afJMNYyTSf6Ac6fgnzhNJuKjhVSIem21PbmS1vhVLrFRIWs8WQd5WLuHl/5n
 PPbg==
X-Gm-Message-State: AOJu0YxsBTHrQlHmyGPWYeumjtUqNCpfqIY0R3QxoL4/fLdPkEzPiMhX
 kFQN4fomIB4kQyt3J35SrzZLhH2p3IVspPpd/GEB2k+Dco615T9kba9NN3HY0r8zYD0BVN6zc/S
 aRVFjlcPKXXAbvpiOaXPDNIKMUrlCggk7k2Io4hgAiJSt9RZz7Q==
X-Gm-Gg: ASbGncviOY4ltheudOl55YR57Sp1M5yd95GBxjvp/6eyy0VR+8IzlwQmTGjsseWR3J7
 6jKAaGD0Pufmc1UeteazN4aReohki/Y0wtNXfY1CsN6YY8mPzMrXvPcasLtfxWZjfy+hXMWWsrw
 6b4pTR0+Kzqe5RpSmjKifr3pjQwhE=
X-Google-Smtp-Source: AGHT+IG+Du0485hD91IAm61z/Js3lLFz1qVst73J00/V1udOwO6Ho3gU8ue+aOj/6uCtAQnDeN2+hwOIxYb0TI4TR9w=
X-Received: by 2002:a17:907:3daa:b0:abf:641a:571e with SMTP id
 a640c23a62f3a-ac1f133a41emr396340166b.30.1741103184282; Tue, 04 Mar 2025
 07:46:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <CAFLszTiB8FBdOTYE+dn6ZTifZsdO0LU2jXKJZSRkPeKzf7ujPQ@mail.gmail.com>
 <7432dd9e-72e3-4072-88a7-18b58da746b3@linaro.org>
In-Reply-To: <7432dd9e-72e3-4072-88a7-18b58da746b3@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Mar 2025 08:46:12 -0700
X-Gm-Features: AQ5f1JqPXnSCj_CNQREH6wwsvK7aBu7GAUhS0ZJjh83wpageAYbEzh1zAzo_H0U
Message-ID: <CAFLszTiPgVLYKYsLgcZJUCJ=tAAfTD_4v_aejks-4YRy=k-XeA@mail.gmail.com>
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

On Thu, 27 Feb 2025 at 09:43, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 2/27/25 17:27, Simon Glass wrote:
> > Hi Jerome,
> >
> > On Thu, 27 Feb 2025 at 09:09, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >> This series adds support for HTTP server authentication using root (CA)
> >> certificates.
> >>
> >> As a first step, the wget command is extended to support a sub-command:
> >> cacert <addr> <size>. The memory region shall contain the CA
> >> certificates. With this, it is possible to load the certificates from
> >> storage or get them from the network for example, which is convenient
> >> for testing at least. The Kconfig symbol for this feature is
> >> WGET_CACERT=y.
> >>
> >> Then new Kconfig symbols are added to support providing the certificates
> >> at build time, as a DER or PEM encoded X509 collection:
> >> WGET_BUILTIN_CACERT=y and WGET_BUILTIN_CACERT_PATH=<some path>.
> >> Note that PEM support requires MBEDTLS_LIB_X509_PEM=y (for the cacert
> >> command as well as for the builtin way).
> >>
> >> Here is a complete example (showing only the relevant output from the
> >> various commands):
> >>
> >>  make qemu_arm64_lwip_defconfig
> >>  wget https://curl.se/ca/cacert.pem
> >>  echo CONFIG_WGET_BUILTIN_CACERT=y >>.config
> >>  echo CONFIG_WGET_BUILTIN_CACERT_PATH=cacert.pem >>.config
> >>  make olddefconfig
> >>  make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
> >>  qemu-system-aarch64 -M virt -nographic -cpu max \
> >>         -object rng-random,id=rng0,filename=/dev/urandom \
> >>         -device virtio-rng-pci,rng=rng0 -bios u-boot.bin
> >>  => dhcp
> >>  # HTTPS transfer using the builtin CA certificates
> >>  => wget https://www.google.com/
> >>  18724 bytes transferred in 15 ms (1.2 MiB/s)
> >>  # Disable certificate validation
> >>  => wget cacert 0 0
> >>  # Unsafe HTTPS transfer
> >>  => wget https://www.google.com/
> >>  WARNING: no CA certificates, HTTPS connections not authenticated
> >>  16570 bytes transferred in 15 ms (1.1 MiB/s)
> >>  # Dowload and apply CA certificates from the net
> >>  => wget https://curl.se/ca/cacert.pem
> >>  WARNING: no CA certificates, HTTPS connections not authenticated
> >>  ##
> >>  233263 bytes transferred in 61 ms (3.6 MiB/s)
> >>  => wget cacert $fileaddr $filesize
> >>  # Now HTTPS is authenticated against the new CA
> >>  => wget https://www.google.com/
> >>  18743 bytes transferred in 14 ms (1.3 MiB/s)
> >>  # Drop the certificates again...
> >>  => wget cacert 0 0
> >>  # Check that transfer is not secure
> >>  => wget https://www.google.com/
> >>  WARNING: no CA certificates, HTTPS connections not authenticated
> >>  # Restore the builtin CA
> >>  => wget cacert builtin
> >>  # No more WARNING
> >>  => wget https://www.google.com/
> >>  18738 bytes transferred in 15 ms (1.2 MiB/s)
> >>
> >> Jerome Forissier (5):
> >>   net: lwip: extend wget to support CA (root) certificates
> >>   lwip: tls: enforce checking of server certificates based on CA
> >>     availability
> >>   lwip: tls: warn when no CA exists amd log certificate validation
> >>     errors
> >>   net: lwip: add support for built-in root certificates
> >>   configs: qemu_arm64_lwip_defconfig: enable WGET_CACERT and
> >>     MBEDTLS_LIB_X509_PEM
> >>
> >>  cmd/Kconfig                                   | 29 ++++++
> >>  cmd/net-lwip.c                                | 19 +++-
> >>  configs/qemu_arm64_lwip_defconfig             |  2 +
> >>  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    |  9 +-
> >>  .../lwip/apps/altcp_tls_mbedtls_opts.h        |  6 --
> >>  lib/mbedtls/Makefile                          |  3 +
> >>  lib/mbedtls/mbedtls_def_config.h              |  5 ++
> >>  net/lwip/Makefile                             |  6 ++
> >>  net/lwip/wget.c                               | 90 ++++++++++++++++++-
> >>  9 files changed, 158 insertions(+), 11 deletions(-)
> >
> > Did you manage to add some sandbox tests for lwip?
>
> Unfortunately not. I am testing mostly with QEMU (qemu_arm64_lwip_defconfig)
> and sometimes with KV260 and i.MX93.

My understanding was that someone was working on it [1] and I had
assumed it was you?

Regards,
SImon

[1] https://lore.kernel.org/u-boot/CAC_iWjKMo7=RE3=1=y3MpgC95itO170ruJYk6omh-4NuAJ8SRA@mail.gmail.com/
