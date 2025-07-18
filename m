Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B02EC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 14:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF6638365E;
	Fri, 18 Jul 2025 16:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vbdg0Ds/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5938B8366F; Fri, 18 Jul 2025 16:08:26 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D3B835B0
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 16:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so340359566b.1
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 07:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752847703; x=1753452503; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y8hMgtcC5EHsJU0gXOu4HM8yRFGIVhuwPz/GQmzru0U=;
 b=Vbdg0Ds/sRDwMX2PKBtZAZ8TTQ/N2oD9liJAQ2oUboRM9QDvnP2HtF/va46vP/LuTi
 RcVOp7fmOFy3SS+ttOUk6orbF03GiROEJIwbB97+RYaVthddsyCg55MZSvJZUQNKZu9c
 3n5/NkrJskuH0o5OPHLc1u41gflqvHJQFIb6EKnif2OdiQApHGJ8pw/YSaTmCaYGenlD
 tsmLTRoHGHEXXrAVoJHZLZZB2CRM5NUfwPerysxVZVu5z0Ts8Leu90cKpnhjrBdyJFrG
 ucvFHEuEevIjE/uLUyyI9BTvK591OC7ramkfXNPKojyWr0/ocrFsqdqnVv7pZ8x90uQ6
 HNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752847703; x=1753452503;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8hMgtcC5EHsJU0gXOu4HM8yRFGIVhuwPz/GQmzru0U=;
 b=DAw00pgn+gzvP0ekqRLcr9eYArYJBycKgS/BhZ+k5lqzIok0uZlMOlDgk+jvU5UfNa
 cgwGNnNF4NvW+KNnJHr7YzHlBc85wiR2D1THLpJXNptheoHR+cqC4hrQidhLvEhRmwBR
 i/Mq1IWly9lw54fFxi1dlb1onqiGYhaqu31SNaF5ROQu/KK4QDmNTLk58l1YeISUJypj
 sQIAtE+wZT9+imJFeGJ5kYKLGFiTbLireixQjs2XBhHf0MtLA7L3bwnQDGUSIdQnF8dG
 qemKn8ncaiMlGyFkbbJx1d6cW9hSpbThwmMJgFMU4XWjchgSuoa54A/aAhN9gYIlWsIR
 pHxw==
X-Gm-Message-State: AOJu0YxwNakPLZ5mJhPHVtvMXWY6tz+IEzzpshEPxSiamkrVx4cFacqB
 lYKbU5yFRPCacTxUdqrYIDJepv9KImC1XTMZBNEgWx4aNz+Au60jLkc22w22XagOhPo=
X-Gm-Gg: ASbGncs6iyqW5fMOkNp9VSGT6bZQE79sC0GqT9DikO87PZf1M2MK/irjcvj2ciBGNOF
 xEjZAbqBZBSbs3YRuVcMMvzFf0F6iJhD4FEV7fmB5Lgq7Mbi0fzeszaVXxWgpVIUQtLaNQYZ/jb
 hEeoRZe1ivkJmOTz5EZngafcOKSS66+pkEQB+UVKGkXnpUi8CDk0LJbcz79bJFxAxurHyRY2rMU
 JiHsenLbgAOajKqth/KEy81jMzGIWGRxdrsN2fKKM6NUHUu9kXuC/rBu6wj0ItAr5Lwo8OFS4X9
 L3Xir/86qZ1DhvVA6agVxFqSqU1I2T6wuDd2oYgcUokzhUVLWXIX6VKl6PK6sQ6HjH8VdQTAPOH
 MVKgopsl6dF0mwn2W+Qm9L7ZiphfDuM15j5sVhuH0nqc9vUspvTfA3OWRvTxyHj7nIArFncawyh
 crrcdqo9DKoFvV
X-Google-Smtp-Source: AGHT+IFXilrVIgPNwN5kpusseEhqsFuLDqtIcpyMZggtJ1kzYF7+MJoNj4JN7R/3ZR4XxCi8F9Rj5w==
X-Received: by 2002:a17:906:9f88:b0:ad5:a121:6ebc with SMTP id
 a640c23a62f3a-ae9cdb103a5mr957625566b.0.1752847702552; 
 Fri, 18 Jul 2025 07:08:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:1f5a:7e34:d483:933c?
 ([2a01:e0a:3cb:7bb0:1f5a:7e34:d483:933c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aec6ca315d5sm129161566b.98.2025.07.18.07.08.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 07:08:21 -0700 (PDT)
Message-ID: <4843f58a-357c-400e-bccb-34810e779366@linaro.org>
Date: Fri, 18 Jul 2025 16:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] net: lwip: root certificates
To: Da Xue <da@lessconfused.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <CACdvmAjUwxAx2_r3Mvacn_4oG97uYUaKsTmTQ4F4KzaN7+aaQA@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CACdvmAjUwxAx2_r3Mvacn_4oG97uYUaKsTmTQ4F4KzaN7+aaQA@mail.gmail.com>
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

Hi Da,

On 7/15/25 06:45, Da Xue wrote:
> Hi Jerome,
> 
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
> 
> Is there a simple way to convert multi-certificate root trust pem to
> der? I tried packing it as a PKCS#7 and got "Could not parse
> certificates (-8576)"

AFAICT MBed TLS should be able to parse multiple root certificates as
long as they are in DER form. U-Boot doesn't enable the PEM format at the
moment, it is less space-efficient. Please try:

openssl x509 -in cert.pem -outform DER -out cert.der

Thanks,
-- 
Jerome


> 
> Best Regards,
> Da
