Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A14C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 10:49:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C3A8808A2;
	Fri,  7 Mar 2025 11:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a1XDg/uV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0D87810DC; Fri,  7 Mar 2025 11:49:39 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53E25803CC
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 11:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-390ec449556so1987172f8f.1
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 02:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741344577; x=1741949377; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bVg+h/71eZAdE1YcENLuDQRdVQgBUfn7limxbU7MK0I=;
 b=a1XDg/uV36YKuCm1U2Xqp9B6JU5sMtRiWlFpNcU9E5/ax5lHVUX/SvutFgxXQQcz7h
 2znDHOaPssMp00t/LmgMBPfZiFkFb+Ah/ePt1Bd1GBWgIj4yZPihKSYG584ukuiFKmQK
 D/6B5TNXSRrBnMqZj3NUJ0WAB/QUuys0xyZz54WQm/2Ltlb/EhxUp4PbqRSUADrIXDP6
 OntZhuxTopaS5VkxIp22S55qqVDSE/jAKeFPMN0zDOIU5eHMAdndZNdOFKX4hvI/yR4/
 1tpakaYBvY6xANuq22PgqDV6xcpC+S9AneyqquNk/xqmo8Lcj072qOW9KCzPC4g/xpJk
 7HSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741344577; x=1741949377;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bVg+h/71eZAdE1YcENLuDQRdVQgBUfn7limxbU7MK0I=;
 b=iwTJ8oBmJVTWRSCxn10Jpt+1pdv60yWQjLz+s1PGhDYtL/LgKjHP1gYidZYBQPpvlL
 t/ymWgRN4Z5MGAnU2rPRHUjjXg1H1vf1gmWjzMwEnsedV8FCXmDG7meqLo4TWJheZ4cd
 7Ff0lJlbGCOX7OMCAAhywo65lX+BfHiA+Dfi3pCJurhXs47FZsSMi+szueU/zc4EgxVa
 WqGxH+dtU/o813LBTA1hhj14I3CPpDmD87LEyel4EecwTI18zCrNUtMRbjDJodDb3+mp
 FwQ+uDE2LPpwkVZ2ujRwq0mMuooaITPqHVEKZVZKdw2QJON9lArYXC4AG1ydv4JQ5KGy
 Pulg==
X-Gm-Message-State: AOJu0YwM+ESEmmaFkeyCIUIoGluqA6PRsF2NiAVSiktuQKsOl1X/wGbC
 wdOUhfFMowa9i/JYoKkYDObTyaO77+92/WsigA0Q1Jf1rxUZwOt9x57/DYvlQf8=
X-Gm-Gg: ASbGncvRTNNjd5lGVi64tqJep6aXmL8xGcqIPAIMqiDaLSxtK4x339unxF+TN9D6j3a
 lKgJ/HO0duzb5gzuco6H60F6b+dqSZugskwQwcR1wO9nzFXBfP6ikmsyq1zaeT4ydEKUZzLwxjI
 X6c7wedXEp2TSksi571/pc8+QZrGxSPPLHIBV7ttZ+7DQpxJfdwoveLl0rbok72vJrD6bZeuCoP
 w5p17eRGC40Roa9vPpe6xmca8nkwYflNEuYHWpLNqwtJr2Ul+dhe1U35/QU06dQQbJ44mZ8yRgi
 LQZGiIMO/LuVvWUC46UW1XW7WUJNqoe+ga/DNcweirEpr7RZqlg91rGi0U2Sr2b7zXRzZ26JZv8
 7vTMplmq8PLHH6hB1+RdzDsZT
X-Google-Smtp-Source: AGHT+IEkkwyC3tWDR3Zz/FeUh58zJexh5IHVNdGq2EGL2b3LZLfLLanK5rKK9jvIe/qthrrTtq492w==
X-Received: by 2002:a5d:64c7:0:b0:391:11b:c7e9 with SMTP id
 ffacd0b85a97d-39132d6011emr2022904f8f.28.1741344576704; 
 Fri, 07 Mar 2025 02:49:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c102e01sm5037917f8f.93.2025.03.07.02.49.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 02:49:36 -0800 (PST)
Message-ID: <37799f19-3b7e-47c7-8f79-c010fc9dbe5a@linaro.org>
Date: Fri, 7 Mar 2025 11:49:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] net: lwip: root certificates
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <CAFLszTiB8FBdOTYE+dn6ZTifZsdO0LU2jXKJZSRkPeKzf7ujPQ@mail.gmail.com>
 <7432dd9e-72e3-4072-88a7-18b58da746b3@linaro.org>
 <CAFLszTiPgVLYKYsLgcZJUCJ=tAAfTD_4v_aejks-4YRy=k-XeA@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTiPgVLYKYsLgcZJUCJ=tAAfTD_4v_aejks-4YRy=k-XeA@mail.gmail.com>
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

On 3/4/25 16:46, Simon Glass wrote:
> Hi Jerome,
> 
> On Thu, 27 Feb 2025 at 09:43, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>>
>>
>> On 2/27/25 17:27, Simon Glass wrote:
>>> Hi Jerome,
>>>
>>> On Thu, 27 Feb 2025 at 09:09, Jerome Forissier
>>> <jerome.forissier@linaro.org> wrote:
>>>>
>>>> This series adds support for HTTP server authentication using root (CA)
>>>> certificates.
>>>>
>>>> As a first step, the wget command is extended to support a sub-command:
>>>> cacert <addr> <size>. The memory region shall contain the CA
>>>> certificates. With this, it is possible to load the certificates from
>>>> storage or get them from the network for example, which is convenient
>>>> for testing at least. The Kconfig symbol for this feature is
>>>> WGET_CACERT=y.
>>>>
>>>> Then new Kconfig symbols are added to support providing the certificates
>>>> at build time, as a DER or PEM encoded X509 collection:
>>>> WGET_BUILTIN_CACERT=y and WGET_BUILTIN_CACERT_PATH=<some path>.
>>>> Note that PEM support requires MBEDTLS_LIB_X509_PEM=y (for the cacert
>>>> command as well as for the builtin way).
>>>>
>>>> Here is a complete example (showing only the relevant output from the
>>>> various commands):
>>>>
>>>>  make qemu_arm64_lwip_defconfig
>>>>  wget https://curl.se/ca/cacert.pem
>>>>  echo CONFIG_WGET_BUILTIN_CACERT=y >>.config
>>>>  echo CONFIG_WGET_BUILTIN_CACERT_PATH=cacert.pem >>.config
>>>>  make olddefconfig
>>>>  make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
>>>>  qemu-system-aarch64 -M virt -nographic -cpu max \
>>>>         -object rng-random,id=rng0,filename=/dev/urandom \
>>>>         -device virtio-rng-pci,rng=rng0 -bios u-boot.bin
>>>>  => dhcp
>>>>  # HTTPS transfer using the builtin CA certificates
>>>>  => wget https://www.google.com/
>>>>  18724 bytes transferred in 15 ms (1.2 MiB/s)
>>>>  # Disable certificate validation
>>>>  => wget cacert 0 0
>>>>  # Unsafe HTTPS transfer
>>>>  => wget https://www.google.com/
>>>>  WARNING: no CA certificates, HTTPS connections not authenticated
>>>>  16570 bytes transferred in 15 ms (1.1 MiB/s)
>>>>  # Dowload and apply CA certificates from the net
>>>>  => wget https://curl.se/ca/cacert.pem
>>>>  WARNING: no CA certificates, HTTPS connections not authenticated
>>>>  ##
>>>>  233263 bytes transferred in 61 ms (3.6 MiB/s)
>>>>  => wget cacert $fileaddr $filesize
>>>>  # Now HTTPS is authenticated against the new CA
>>>>  => wget https://www.google.com/
>>>>  18743 bytes transferred in 14 ms (1.3 MiB/s)
>>>>  # Drop the certificates again...
>>>>  => wget cacert 0 0
>>>>  # Check that transfer is not secure
>>>>  => wget https://www.google.com/
>>>>  WARNING: no CA certificates, HTTPS connections not authenticated
>>>>  # Restore the builtin CA
>>>>  => wget cacert builtin
>>>>  # No more WARNING
>>>>  => wget https://www.google.com/
>>>>  18738 bytes transferred in 15 ms (1.2 MiB/s)
>>>>
>>>> Jerome Forissier (5):
>>>>   net: lwip: extend wget to support CA (root) certificates
>>>>   lwip: tls: enforce checking of server certificates based on CA
>>>>     availability
>>>>   lwip: tls: warn when no CA exists amd log certificate validation
>>>>     errors
>>>>   net: lwip: add support for built-in root certificates
>>>>   configs: qemu_arm64_lwip_defconfig: enable WGET_CACERT and
>>>>     MBEDTLS_LIB_X509_PEM
>>>>
>>>>  cmd/Kconfig                                   | 29 ++++++
>>>>  cmd/net-lwip.c                                | 19 +++-
>>>>  configs/qemu_arm64_lwip_defconfig             |  2 +
>>>>  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    |  9 +-
>>>>  .../lwip/apps/altcp_tls_mbedtls_opts.h        |  6 --
>>>>  lib/mbedtls/Makefile                          |  3 +
>>>>  lib/mbedtls/mbedtls_def_config.h              |  5 ++
>>>>  net/lwip/Makefile                             |  6 ++
>>>>  net/lwip/wget.c                               | 90 ++++++++++++++++++-
>>>>  9 files changed, 158 insertions(+), 11 deletions(-)
>>>
>>> Did you manage to add some sandbox tests for lwip?
>>
>> Unfortunately not. I am testing mostly with QEMU (qemu_arm64_lwip_defconfig)
>> and sometimes with KV260 and i.MX93.
> 
> My understanding was that someone was working on it [1] and I had
> assumed it was you?

Yes, it is on my TODO list. Higher priority things have kept coming in, but
hopefully I can resume this work soon.

Regards,
-- 
Jerome

> 
> Regards,
> SImon
> 
> [1] https://lore.kernel.org/u-boot/CAC_iWjKMo7=RE3=1=y3MpgC95itO170ruJYk6omh-4NuAJ8SRA@mail.gmail.com/
