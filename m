Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585E3C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:43:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEF81811D8;
	Thu, 27 Feb 2025 17:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VhovlP+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E68FA8121A; Thu, 27 Feb 2025 17:43:13 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC908118A
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-abec925a135so158607466b.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740674590; x=1741279390; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LipYmKgZUcKloJ4fozQiRKMIc9efClT4bShpwH9b6a4=;
 b=VhovlP+mpoNKf2Wlpr47SEet/tH0LRzyCd6WQ/wVxQiBcvFr4Ot7i4CV/qkrdUNaQQ
 Kwg5M5E9Ygm5NYABu8Kv+myri/1tppjjIq/ueX7qSbVj1zgdCzzH5q49VXjp5u7uBTIJ
 NETFgQwK1ajByeVY6OigtrJ53YLFeOlcZndACc3KgfyUvz5SG/TN4DM9OnJoX/pTp+Vs
 V5VC26/Kd4PzNm+nh7w1/uBqgeKB+P6nYpN1ZQz7AK5S+qV4VC0HLBhTqp6+/Xc0x+hp
 qAuPwrANYsxOwGJdgvabuv3BKeQc89PonyCfE/NMdkuScCH4NOBS9uhAnJB1Lx8V0K8k
 mgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740674590; x=1741279390;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LipYmKgZUcKloJ4fozQiRKMIc9efClT4bShpwH9b6a4=;
 b=NpQTsy9XCqpmvUVau3704Z/7Ndr8kKdtIl5fM9Mcsw/QLDQ78h54+SpJ8g6VtLKIqo
 F/vGBxQih4rfrOmF4hbc4Emh6iiBKbaDmrV18HMm7TrbSSTLdJmTX8Qflkg8BQeYVwXM
 mZ//5XzNBQ1gZrBuFsfkWj18gKvoFUpg92iwVWBf7R2jEcV1c01A/e9eOcW5YcWXXpxp
 O8JR1u4BPdukOIZSdfTkoUJs05SSVabAKe1mGGYA0fEU2NF0Vp5bsbFyCai+XWLa8/bL
 KS/BKjx8SQ2TulgQkFX4A8EFxN1qeFl/hJeYhUbbu6sitBXmdyTtoSLw6DVqUxDneJzb
 Um3g==
X-Gm-Message-State: AOJu0YzR6A5qEBdF9sB/RKTuGVpS4FObEI0jaMQna41PCH++E+Q3GQ3k
 z+M9UxaYQY0nEi5YLkRmVzrR27Yi2Eb2RPD6BImMQ0SY5+pkPEFzJAHJ2JeXaa4=
X-Gm-Gg: ASbGnctiiooFQmtiIRAH6+eWOPtHiK9OME7HFP1cJQqZvjTehqI1F1pGDRqiaCEOLPN
 z7QyWB9lFK0aEVsH8MWbgJ6ONSY/LI6U4TWQgZ6zm9B07Y0V6LPkKnEx9VPoW6Xvx3kz52JWLky
 MnX4O5zdlZzrqV+a0CSU6S4T0fIW3RsyIifp9J70ILH8BYK9Y+8JlGHk/MloL9EMO2a8Kt/Pmim
 N75G0dd1SJTvUxtSqnB79LXG/gdVrDjXOqQ9mlGUP/YDjkYEOqmrzRkOv5s14jW0H/xa4GUg2sd
 gQ8E0Vbzq0E8nyLCtkjFESnL4PNp9U5pXvCc29lbdrZ9or970OONXAhNhfOFD7f3s5Zvc/2z718
 KHaYxsw==
X-Google-Smtp-Source: AGHT+IHj+Bq2B49OvGiCoy7AYOSuhi3mQsw59HNIcfjS70mbfRUTVd8aM3/adIMLzbB7xcO6de7NJQ==
X-Received: by 2002:a17:906:7951:b0:abf:13cb:c412 with SMTP id
 a640c23a62f3a-abf25fa9fbfmr16298166b.18.1740674590409; 
 Thu, 27 Feb 2025 08:43:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:a4a3:25fd:919c:f316?
 ([2a01:e0a:3cb:7bb0:a4a3:25fd:919c:f316])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c755c98sm149171666b.142.2025.02.27.08.43.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 08:43:10 -0800 (PST)
Message-ID: <7432dd9e-72e3-4072-88a7-18b58da746b3@linaro.org>
Date: Thu, 27 Feb 2025 17:43:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] net: lwip: root certificates
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <CAFLszTiB8FBdOTYE+dn6ZTifZsdO0LU2jXKJZSRkPeKzf7ujPQ@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTiB8FBdOTYE+dn6ZTifZsdO0LU2jXKJZSRkPeKzf7ujPQ@mail.gmail.com>
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



On 2/27/25 17:27, Simon Glass wrote:
> Hi Jerome,
> 
> On Thu, 27 Feb 2025 at 09:09, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> This series adds support for HTTP server authentication using root (CA)
>> certificates.
>>
>> As a first step, the wget command is extended to support a sub-command:
>> cacert <addr> <size>. The memory region shall contain the CA
>> certificates. With this, it is possible to load the certificates from
>> storage or get them from the network for example, which is convenient
>> for testing at least. The Kconfig symbol for this feature is
>> WGET_CACERT=y.
>>
>> Then new Kconfig symbols are added to support providing the certificates
>> at build time, as a DER or PEM encoded X509 collection:
>> WGET_BUILTIN_CACERT=y and WGET_BUILTIN_CACERT_PATH=<some path>.
>> Note that PEM support requires MBEDTLS_LIB_X509_PEM=y (for the cacert
>> command as well as for the builtin way).
>>
>> Here is a complete example (showing only the relevant output from the
>> various commands):
>>
>>  make qemu_arm64_lwip_defconfig
>>  wget https://curl.se/ca/cacert.pem
>>  echo CONFIG_WGET_BUILTIN_CACERT=y >>.config
>>  echo CONFIG_WGET_BUILTIN_CACERT_PATH=cacert.pem >>.config
>>  make olddefconfig
>>  make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
>>  qemu-system-aarch64 -M virt -nographic -cpu max \
>>         -object rng-random,id=rng0,filename=/dev/urandom \
>>         -device virtio-rng-pci,rng=rng0 -bios u-boot.bin
>>  => dhcp
>>  # HTTPS transfer using the builtin CA certificates
>>  => wget https://www.google.com/
>>  18724 bytes transferred in 15 ms (1.2 MiB/s)
>>  # Disable certificate validation
>>  => wget cacert 0 0
>>  # Unsafe HTTPS transfer
>>  => wget https://www.google.com/
>>  WARNING: no CA certificates, HTTPS connections not authenticated
>>  16570 bytes transferred in 15 ms (1.1 MiB/s)
>>  # Dowload and apply CA certificates from the net
>>  => wget https://curl.se/ca/cacert.pem
>>  WARNING: no CA certificates, HTTPS connections not authenticated
>>  ##
>>  233263 bytes transferred in 61 ms (3.6 MiB/s)
>>  => wget cacert $fileaddr $filesize
>>  # Now HTTPS is authenticated against the new CA
>>  => wget https://www.google.com/
>>  18743 bytes transferred in 14 ms (1.3 MiB/s)
>>  # Drop the certificates again...
>>  => wget cacert 0 0
>>  # Check that transfer is not secure
>>  => wget https://www.google.com/
>>  WARNING: no CA certificates, HTTPS connections not authenticated
>>  # Restore the builtin CA
>>  => wget cacert builtin
>>  # No more WARNING
>>  => wget https://www.google.com/
>>  18738 bytes transferred in 15 ms (1.2 MiB/s)
>>
>> Jerome Forissier (5):
>>   net: lwip: extend wget to support CA (root) certificates
>>   lwip: tls: enforce checking of server certificates based on CA
>>     availability
>>   lwip: tls: warn when no CA exists amd log certificate validation
>>     errors
>>   net: lwip: add support for built-in root certificates
>>   configs: qemu_arm64_lwip_defconfig: enable WGET_CACERT and
>>     MBEDTLS_LIB_X509_PEM
>>
>>  cmd/Kconfig                                   | 29 ++++++
>>  cmd/net-lwip.c                                | 19 +++-
>>  configs/qemu_arm64_lwip_defconfig             |  2 +
>>  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    |  9 +-
>>  .../lwip/apps/altcp_tls_mbedtls_opts.h        |  6 --
>>  lib/mbedtls/Makefile                          |  3 +
>>  lib/mbedtls/mbedtls_def_config.h              |  5 ++
>>  net/lwip/Makefile                             |  6 ++
>>  net/lwip/wget.c                               | 90 ++++++++++++++++++-
>>  9 files changed, 158 insertions(+), 11 deletions(-)
> 
> Did you manage to add some sandbox tests for lwip?

Unfortunately not. I am testing mostly with QEMU (qemu_arm64_lwip_defconfig)
and sometimes with KV260 and i.MX93.

Regards,
-- 
Jerome
