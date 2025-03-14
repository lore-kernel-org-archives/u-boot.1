Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A72C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 22:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 426AF82006;
	Fri, 14 Mar 2025 23:02:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a8y+sp8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17E2282027; Fri, 14 Mar 2025 23:02:02 +0100 (CET)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6070081F0B
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 23:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso379589466b.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741989719; x=1742594519; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hr2CJUw/LCzKXtFJ+maoJPPsfCPEG6sRpbifVOf7kjo=;
 b=a8y+sp8o4uci4KkBiXCVbXggqkHUK1J1UBT1HQyBwX5dO5qiIKl4vTrDN0OqoAWwui
 aTmvfzYmQ5lfSLf8bqklAJ/I5cxDbeoymO/+MqiaGz93WyuB/lISauW1f8oej27GuyZN
 deaivxj7o1qMaplHvtwv0z5LbiU47Sd2z9YqEMZugpipf1ZuUI3P+D8xdqje7wQyMIKK
 Jssrha+qPkTHXFSkDYVdgZJVwgRPYOQ7CSjBEMmtEZqO8AerfxJ0XL9alvT2So9UfBkk
 sAfJOn7lZfkqTD8pDnKer2zdx87cxZm5K2A7batxdSkh+Z37O6MMTPDrgj65PWLJfVda
 8SGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741989719; x=1742594519;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hr2CJUw/LCzKXtFJ+maoJPPsfCPEG6sRpbifVOf7kjo=;
 b=Mmgpzz+4P3+qdf65qkBAA6GR97dLGYQHNQExN6yAAbpLOrrmG4kmmT8DNMLr2u0Hru
 7C9SjPI694cbBknVgnjRJqoD5Vtnffd7PhiMaEstvs8bv3BPkxZUMUkUBGIH9N8YAaAt
 wgpn5G9+b7nY8HE0SL/xxzEbFfxxmeTxfvOozZVDp+E54tbEP24Y90g8HlWn9DjDc3xA
 lmIV6KPVpWTHL0RyxdvM0/mm7pWGy6u3RYtQwbrbJ2ZsoAdW0V3D4R3bPafe5y0Jz0+s
 WhKSC5wXu2Hiq86z5EjD95W9O5CUKvKQTKuUffiSPNHOh+nvZ8ws/xHp7FC2LKc7BwM2
 4DHQ==
X-Gm-Message-State: AOJu0YzQ72kgTplCTwsqkJadSJ4VLpalq6JK4F5ulN251FpFFmFixtRc
 S/xggnL3NPOlRUdJZELzBMHqiYrndX1JO/TLkw+EcLuG2jJpgszgX0bBQlWd3lU6CpaODs2aGVG
 DjcEmWw==
X-Gm-Gg: ASbGncvYVgZjteS7t3BluKVVUB9d1fwU+5Vxh4WLjCFBxB89ETyV55yqk4WxbdJIVzS
 Pvrsal+uDyN6j+eRz5wXXATeIltj1HFlZvpz/q2dGx9YLROWODdZIS91Yx0t6qmUED5PBEcOZfZ
 nBo0OQExCbU7DYaQXNKsgRRlQcWTIcv6OjnBrlP/EuPFZ/EI7R6lLPIyy0C1K0aGF4KAxX0sd2v
 XKBPRFtQP1Zz8DsvgTfgoWpaIj8bglC6VRPV9oaFps4uhFhWt7/QkODmNhQh+414xcYNjiPJCQv
 nrvhgCdnMoazb+h8QDVALGzk8TRdwjGIbdQUDckokWKGlxXDzkMDlG15xJnT/jSSH/ZIGkapQn/
 LIubWBGE6T2grHbhAwxtbaosr
X-Google-Smtp-Source: AGHT+IGgadcOJdCAxW8vBtgPcnEJLlJpXetSIfVTVk6vq+vABTSQMgWYTu6ZbRB3OanLULKdgucDjA==
X-Received: by 2002:a17:907:2d89:b0:ac2:7a6d:c927 with SMTP id
 a640c23a62f3a-ac3304d698cmr478872466b.50.1741989718667; 
 Fri, 14 Mar 2025 15:01:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:1b28:6813:ebd6:3349?
 ([2a01:e0a:3cb:7bb0:1b28:6813:ebd6:3349])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3146aeb5asm279160266b.36.2025.03.14.15.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 15:01:58 -0700 (PDT)
Message-ID: <4d9f3038-0f9b-456b-89bb-290b6c8c41fa@linaro.org>
Date: Fri, 14 Mar 2025 23:01:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] net: lwip: root certificates
From: Jerome Forissier <jerome.forissier@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <CAFLszTiB8FBdOTYE+dn6ZTifZsdO0LU2jXKJZSRkPeKzf7ujPQ@mail.gmail.com>
 <7432dd9e-72e3-4072-88a7-18b58da746b3@linaro.org>
 <CAFLszTiPgVLYKYsLgcZJUCJ=tAAfTD_4v_aejks-4YRy=k-XeA@mail.gmail.com>
 <37799f19-3b7e-47c7-8f79-c010fc9dbe5a@linaro.org>
 <CAFLszTi7536co5PeXNbsA=Dw628gdYiP1F1hf0T9wPs-G4gT0g@mail.gmail.com>
 <661ee5c6-6b8e-4c6a-9c7c-9e0087d96c45@linaro.org>
Content-Language: en-US
In-Reply-To: <661ee5c6-6b8e-4c6a-9c7c-9e0087d96c45@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Simon,

On 3/13/25 14:23, Jerome Forissier wrote:
> 
> 
> On 3/13/25 13:51, Simon Glass wrote:
>> Hi Jerome,
>>
>> On Fri, 7 Mar 2025 at 10:49, Jerome Forissier
>> <jerome.forissier@linaro.org> wrote:
>>>
>>> Hi Simon,
>>>
>>> On 3/4/25 16:46, Simon Glass wrote:
>>>> Hi Jerome,
>>>>
>>>> On Thu, 27 Feb 2025 at 09:43, Jerome Forissier
>>>> <jerome.forissier@linaro.org> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2/27/25 17:27, Simon Glass wrote:
>>>>>> Hi Jerome,
>>>>>>
>>>>>> On Thu, 27 Feb 2025 at 09:09, Jerome Forissier
>>>>>> <jerome.forissier@linaro.org> wrote:
>>>>>>>
>>>>>>> This series adds support for HTTP server authentication using root (CA)
>>>>>>> certificates.
>>>>>>>
>>>>>>> As a first step, the wget command is extended to support a sub-command:
>>>>>>> cacert <addr> <size>. The memory region shall contain the CA
>>>>>>> certificates. With this, it is possible to load the certificates from
>>>>>>> storage or get them from the network for example, which is convenient
>>>>>>> for testing at least. The Kconfig symbol for this feature is
>>>>>>> WGET_CACERT=y.
>>>>>>>
>>>>>>> Then new Kconfig symbols are added to support providing the certificates
>>>>>>> at build time, as a DER or PEM encoded X509 collection:
>>>>>>> WGET_BUILTIN_CACERT=y and WGET_BUILTIN_CACERT_PATH=<some path>.
>>>>>>> Note that PEM support requires MBEDTLS_LIB_X509_PEM=y (for the cacert
>>>>>>> command as well as for the builtin way).
>>>>>>>
>>>>>>> Here is a complete example (showing only the relevant output from the
>>>>>>> various commands):
>>>>>>>
>>>>>>>  make qemu_arm64_lwip_defconfig
>>>>>>>  wget https://curl.se/ca/cacert.pem
>>>>>>>  echo CONFIG_WGET_BUILTIN_CACERT=y >>.config
>>>>>>>  echo CONFIG_WGET_BUILTIN_CACERT_PATH=cacert.pem >>.config
>>>>>>>  make olddefconfig
>>>>>>>  make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
>>>>>>>  qemu-system-aarch64 -M virt -nographic -cpu max \
>>>>>>>         -object rng-random,id=rng0,filename=/dev/urandom \
>>>>>>>         -device virtio-rng-pci,rng=rng0 -bios u-boot.bin
>>>>>>>  => dhcp
>>>>>>>  # HTTPS transfer using the builtin CA certificates
>>>>>>>  => wget https://www.google.com/
>>>>>>>  18724 bytes transferred in 15 ms (1.2 MiB/s)
>>>>>>>  # Disable certificate validation
>>>>>>>  => wget cacert 0 0
>>>>>>>  # Unsafe HTTPS transfer
>>>>>>>  => wget https://www.google.com/
>>>>>>>  WARNING: no CA certificates, HTTPS connections not authenticated
>>>>>>>  16570 bytes transferred in 15 ms (1.1 MiB/s)
>>>>>>>  # Dowload and apply CA certificates from the net
>>>>>>>  => wget https://curl.se/ca/cacert.pem
>>>>>>>  WARNING: no CA certificates, HTTPS connections not authenticated
>>>>>>>  ##
>>>>>>>  233263 bytes transferred in 61 ms (3.6 MiB/s)
>>>>>>>  => wget cacert $fileaddr $filesize
>>>>>>>  # Now HTTPS is authenticated against the new CA
>>>>>>>  => wget https://www.google.com/
>>>>>>>  18743 bytes transferred in 14 ms (1.3 MiB/s)
>>>>>>>  # Drop the certificates again...
>>>>>>>  => wget cacert 0 0
>>>>>>>  # Check that transfer is not secure
>>>>>>>  => wget https://www.google.com/
>>>>>>>  WARNING: no CA certificates, HTTPS connections not authenticated
>>>>>>>  # Restore the builtin CA
>>>>>>>  => wget cacert builtin
>>>>>>>  # No more WARNING
>>>>>>>  => wget https://www.google.com/
>>>>>>>  18738 bytes transferred in 15 ms (1.2 MiB/s)
>>>>>>>
>>>>>>> Jerome Forissier (5):
>>>>>>>   net: lwip: extend wget to support CA (root) certificates
>>>>>>>   lwip: tls: enforce checking of server certificates based on CA
>>>>>>>     availability
>>>>>>>   lwip: tls: warn when no CA exists amd log certificate validation
>>>>>>>     errors
>>>>>>>   net: lwip: add support for built-in root certificates
>>>>>>>   configs: qemu_arm64_lwip_defconfig: enable WGET_CACERT and
>>>>>>>     MBEDTLS_LIB_X509_PEM
>>>>>>>
>>>>>>>  cmd/Kconfig                                   | 29 ++++++
>>>>>>>  cmd/net-lwip.c                                | 19 +++-
>>>>>>>  configs/qemu_arm64_lwip_defconfig             |  2 +
>>>>>>>  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    |  9 +-
>>>>>>>  .../lwip/apps/altcp_tls_mbedtls_opts.h        |  6 --
>>>>>>>  lib/mbedtls/Makefile                          |  3 +
>>>>>>>  lib/mbedtls/mbedtls_def_config.h              |  5 ++
>>>>>>>  net/lwip/Makefile                             |  6 ++
>>>>>>>  net/lwip/wget.c                               | 90 ++++++++++++++++++-
>>>>>>>  9 files changed, 158 insertions(+), 11 deletions(-)
>>>>>>
>>>>>> Did you manage to add some sandbox tests for lwip?
>>>>>
>>>>> Unfortunately not. I am testing mostly with QEMU (qemu_arm64_lwip_defconfig)
>>>>> and sometimes with KV260 and i.MX93.
>>>>
>>>> My understanding was that someone was working on it [1] and I had
>>>> assumed it was you?
>>>
>>> Yes, it is on my TODO list. Higher priority things have kept coming in, but
>>> hopefully I can resume this work soon.
>>
>> Until the tests are added, please stop sending new series for lwip. It
>> is just going to make it harder to add the tests later.
> 
> I don't see how exactly it would make things harder, but...
> 
>> It should not
>> take long to add a basic test, e.g. for ping.
> 
> ...I'm on it.

Please see https://lists.denx.de/pipermail/u-boot/2025-March/583551.html.

Thanks,
-- 
Jerome

> 
>> Regards,
>> Simon
> 
> Thanks,
