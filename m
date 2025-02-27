Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ACFC197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 18:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA6F4812C0;
	Thu, 27 Feb 2025 19:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VJlM0ro9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08ADA81417; Thu, 27 Feb 2025 19:31:32 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C29F812BE
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 19:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e0373c7f55so1811778a12.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 10:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740681069; x=1741285869; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8JS9ghsmWx+BIfGr9H682xaqVmDPW9jOXXCigaZ0qkE=;
 b=VJlM0ro9ZFI5RHw2DLF1PDJEiN9LROIA9dKGp3S14/0alKXqO4Z6ZKz/xIac1RBn0t
 VaruSGv2cg4nvuuZYlnR4OEqYOd5YrqZzS6m0eKzWR41WH7t3GziWOi1sXYNsMZLsLPz
 YOGrR4JyLl/KYpmvN7bnPoUBDVSOW5l+9GCJAwKCLolS1BsWQ3rKTE02HkwCI9lbUVM4
 /TMLe5Bmp8wT3KyhJxPY0jRdo5ChHNi/J+Atu8VdYHFm9KfFpxgVeHqcmPkOmZDxYFBM
 f063wK22IYXe1v0NiC3XkjjzMBUIbLzVii/JFZ5Vvfx9uz3bknd337qM/F8HRCtrByEq
 NcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740681069; x=1741285869;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8JS9ghsmWx+BIfGr9H682xaqVmDPW9jOXXCigaZ0qkE=;
 b=vfyNxY8K25wylYG8dO4S3OH1wAYpW+va30nt8ISWZZP/MUp03KhcVvt0DZ+eGcXdFV
 Mzb2Z8WSpRRMeT6LkLrmzB79SIK+7E/00dEp/JhMb+uHqmCus7yw+VcwVRm78LbwDJTi
 Eixxh7bWCn3xq8DSx2Cjbp1Mc+czpKYZVTR71BpyaC0M3rrihCvbhzwgqCoSpTRbjlCx
 twxF7F5WdyeiUBWMpNtOeJFiuXQOOv+jqM6DHs032E5P2RNJCoH3xSVaGnJ2YH22Xz1v
 J8kwK4dY/o1BLAjy0k5mv40Dq9MhfqtR8uv8gletZh6LWOAZxVxZSg10tsF9uydviTk7
 W/sA==
X-Gm-Message-State: AOJu0Yxa+TODcwsnIPfKYbRZJbjy6I7JrsQV7j1UfA4+KVa4/V91wxOA
 VsFxWbjHaYooIhLbIgVL3xFo7+km+uTDRYRvAPjz8oIzeTRXoPJqIhSP7DopwOc=
X-Gm-Gg: ASbGnctlARiAuTVPxsLpeRq26UzkCyM+Ey+pwF/IfS+LfrqT3fMjQlhVFkU1AVSFrS2
 k6CAcrmM6e+sxw09rR366kzexjSqeBVKmWjUO2Eha1yNPQKP1sxbyMqSq8c8BDKFKcPTq4bUc6s
 9aZbCrqP4lDWHEkHmHD0IUWzCXMh4tcYJNeW2Msfq4kVYdVmc4HIXr0Zua50OcqmTJ8splM8blp
 XjkLLM9qOFiW99I4OxHF3LniTPA/3A1R8UfJzZ4N626EdFGhnQJS5Q583TMkIlYehsBWL9P9zPD
 HZ5d6mhhZ8/w5lxu/PjDgjJ/aT6L+ZXDhswE+DEyeRPPyGJ54A9lSbQPD2b1dH2DglfoJgaTTIL
 osXgDyw==
X-Google-Smtp-Source: AGHT+IEJWHEVHN6lealAyLpMtnVHhmAjTChLbGDTr/4ElreH6wHikRBgS9dwYxDQD0rux178eSKm8A==
X-Received: by 2002:a05:6402:35cf:b0:5d4:1ac2:277f with SMTP id
 4fb4d7f45d1cf-5e4d6ae82camr86029a12.9.1740681069395; 
 Thu, 27 Feb 2025 10:31:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:a4a3:25fd:919c:f316?
 ([2a01:e0a:3cb:7bb0:a4a3:25fd:919c:f316])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3b6cfd0sm1455005a12.28.2025.02.27.10.31.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 10:31:09 -0800 (PST)
Message-ID: <4a1222e8-ef18-4753-9870-b40ddf35145e@linaro.org>
Date: Thu, 27 Feb 2025 19:31:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] net: lwip: root certificates
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <20250227180623.GI2640854@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250227180623.GI2640854@bill-the-cat>
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



On 2/27/25 19:06, Tom Rini wrote:
> On Thu, Feb 27, 2025 at 05:09:00PM +0100, Jerome Forissier wrote:
> 
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
> 
> As part of v2, please update the documentation as well with some example
> like the above (perhaps as enable X/Y/Z then at run time ...), thanks!

Will do.

Thanks,
-- 
Jerome
