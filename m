Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC04AC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 13:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1BC80F9C;
	Thu, 13 Mar 2025 14:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S89lxRS5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0134880FF7; Thu, 13 Mar 2025 14:23:39 +0100 (CET)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79CF480540
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 14:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-ac298c8fa50so184393766b.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 06:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741872214; x=1742477014; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gc43YnuTDQDHmjbmF3BmtVPdMvJqqCs0Ct/Y0yQtwSc=;
 b=S89lxRS5hNl8Fl7xfpm4SynDdFlz9k+pOCFbjEQrJHHo04tmNnARhyMUFYavP9Vmc5
 peRbucBa4xwgLO6R8NMLg3XZwuy1QUwmLSPVZk+BOediltj5qoEw6qaZ/U1iz8R+Q5/9
 /0QMn1q/QLhUD7viivxUs7WP5azkUB6/2N6IVJkq4JOEpe4FGbPt7LK5Y5JvSP/yesNm
 z9iVkVLKf9fN6LZMwBWo9cQtNY3tfVrCtKEBizl3MMODNnKWhse5wFC5Omadrv9Q08lr
 a4QO28vr3dl8NCD+OsHig92iZCbJEklZq7iYO7eQrQ0N/IbPdMRmNN04pb+FmyZP1ikM
 dL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741872214; x=1742477014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gc43YnuTDQDHmjbmF3BmtVPdMvJqqCs0Ct/Y0yQtwSc=;
 b=ma+yWxMDYZ1Gks+U4g8s4WOa2d7jThfMncDDFueXcSSAmFg5D/9AKuLLWBpE1g9nP5
 NGD/+5ogIh5KmiBZI3OEi+TxexrO9PgOvBcMfUl25bA+Eccmo+2liIXZInmWSkCdW2Ar
 RynaahTfpXGkTxGVqNc15bR8zDK86cnYyko0Wj1Yz5JNzAm57HBscdlr9KOtRdRe2xy1
 pJgeh7QldcT7H4haEgLgU2pNObulJnGZeRQRR5KKOLv9Mf31P4fh1Fu2i42zDL0roLdU
 jMy0eszcxu65w2Zm+xeDCNQIBaNg3fr4Xm7ay9GZCOEqC7dJsX1Ce3zt2fSK/aIDmVta
 bsYQ==
X-Gm-Message-State: AOJu0YzNmi5qb6/GQR41AstVTZikTfUondEVP3lAJkYIP99TAiy261yC
 cS9t5+vyoN14QM2yy9WU1YL5l71WEO5BDsSwbt/psr0nNHqXrYAfjpvTkLJloW8=
X-Gm-Gg: ASbGncsCpzZyBXLgA4ErXlqARozIKjs+Y6bBKEq5fR2E310K93BnH8SJeyqeSUiK9pp
 9layxdWCj4OQdkNvZky68R8OewkpBsY5nNRkso6jnaRFqLgQjUP6h67P/RrrEwRnjIqZuUxjqbf
 ele5kRIyVRVsu2AXUBtQPGy14uDaca1I6FeWHqBJDt62AqaSaRyUJXAYEl9KTrDnfDygT/vEJmf
 3+zJSBVU5iA3AnhUgI97oKkEMCpIbp4wyfJeuuNxFttGhhJN0iX1i+2jgy1PDgGjHrsPChjLQHf
 sIr86mwaIyg3eT440RYcgriz3w9QPj8S10pZ6gsVRLSNWhBuIij1QxZJ5MTOkuxFWG8SK0RAvET
 gQRFnySVtFBjmwBkqf+tVArjm
X-Google-Smtp-Source: AGHT+IGDlkulo9ns1o7OqmJjBU8+F2RY6eXyL2n95oBqiBFmP56DZPxcKol3ZqaXGs9kSGMTU8vLrA==
X-Received: by 2002:a17:907:1998:b0:ac2:a473:416c with SMTP id
 a640c23a62f3a-ac2a4734de1mr1043381366b.47.1741872213712; 
 Thu, 13 Mar 2025 06:23:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:73ef:8d9b:afeb:6d8e?
 ([2a01:e0a:3cb:7bb0:73ef:8d9b:afeb:6d8e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac31485bd4dsm80342666b.81.2025.03.13.06.23.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 06:23:33 -0700 (PDT)
Message-ID: <661ee5c6-6b8e-4c6a-9c7c-9e0087d96c45@linaro.org>
Date: Thu, 13 Mar 2025 14:23:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] net: lwip: root certificates
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <CAFLszTiB8FBdOTYE+dn6ZTifZsdO0LU2jXKJZSRkPeKzf7ujPQ@mail.gmail.com>
 <7432dd9e-72e3-4072-88a7-18b58da746b3@linaro.org>
 <CAFLszTiPgVLYKYsLgcZJUCJ=tAAfTD_4v_aejks-4YRy=k-XeA@mail.gmail.com>
 <37799f19-3b7e-47c7-8f79-c010fc9dbe5a@linaro.org>
 <CAFLszTi7536co5PeXNbsA=Dw628gdYiP1F1hf0T9wPs-G4gT0g@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTi7536co5PeXNbsA=Dw628gdYiP1F1hf0T9wPs-G4gT0g@mail.gmail.com>
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



On 3/13/25 13:51, Simon Glass wrote:
> Hi Jerome,
> 
> On Fri, 7 Mar 2025 at 10:49, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Hi Simon,
>>
>> On 3/4/25 16:46, Simon Glass wrote:
>>> Hi Jerome,
>>>
>>> On Thu, 27 Feb 2025 at 09:43, Jerome Forissier
>>> <jerome.forissier@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 2/27/25 17:27, Simon Glass wrote:
>>>>> Hi Jerome,
>>>>>
>>>>> On Thu, 27 Feb 2025 at 09:09, Jerome Forissier
>>>>> <jerome.forissier@linaro.org> wrote:
>>>>>>
>>>>>> This series adds support for HTTP server authentication using root (CA)
>>>>>> certificates.
>>>>>>
>>>>>> As a first step, the wget command is extended to support a sub-command:
>>>>>> cacert <addr> <size>. The memory region shall contain the CA
>>>>>> certificates. With this, it is possible to load the certificates from
>>>>>> storage or get them from the network for example, which is convenient
>>>>>> for testing at least. The Kconfig symbol for this feature is
>>>>>> WGET_CACERT=y.
>>>>>>
>>>>>> Then new Kconfig symbols are added to support providing the certificates
>>>>>> at build time, as a DER or PEM encoded X509 collection:
>>>>>> WGET_BUILTIN_CACERT=y and WGET_BUILTIN_CACERT_PATH=<some path>.
>>>>>> Note that PEM support requires MBEDTLS_LIB_X509_PEM=y (for the cacert
>>>>>> command as well as for the builtin way).
>>>>>>
>>>>>> Here is a complete example (showing only the relevant output from the
>>>>>> various commands):
>>>>>>
>>>>>>  make qemu_arm64_lwip_defconfig
>>>>>>  wget https://curl.se/ca/cacert.pem
>>>>>>  echo CONFIG_WGET_BUILTIN_CACERT=y >>.config
>>>>>>  echo CONFIG_WGET_BUILTIN_CACERT_PATH=cacert.pem >>.config
>>>>>>  make olddefconfig
>>>>>>  make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
>>>>>>  qemu-system-aarch64 -M virt -nographic -cpu max \
>>>>>>         -object rng-random,id=rng0,filename=/dev/urandom \
>>>>>>         -device virtio-rng-pci,rng=rng0 -bios u-boot.bin
>>>>>>  => dhcp
>>>>>>  # HTTPS transfer using the builtin CA certificates
>>>>>>  => wget https://www.google.com/
>>>>>>  18724 bytes transferred in 15 ms (1.2 MiB/s)
>>>>>>  # Disable certificate validation
>>>>>>  => wget cacert 0 0
>>>>>>  # Unsafe HTTPS transfer
>>>>>>  => wget https://www.google.com/
>>>>>>  WARNING: no CA certificates, HTTPS connections not authenticated
>>>>>>  16570 bytes transferred in 15 ms (1.1 MiB/s)
>>>>>>  # Dowload and apply CA certificates from the net
>>>>>>  => wget https://curl.se/ca/cacert.pem
>>>>>>  WARNING: no CA certificates, HTTPS connections not authenticated
>>>>>>  ##
>>>>>>  233263 bytes transferred in 61 ms (3.6 MiB/s)
>>>>>>  => wget cacert $fileaddr $filesize
>>>>>>  # Now HTTPS is authenticated against the new CA
>>>>>>  => wget https://www.google.com/
>>>>>>  18743 bytes transferred in 14 ms (1.3 MiB/s)
>>>>>>  # Drop the certificates again...
>>>>>>  => wget cacert 0 0
>>>>>>  # Check that transfer is not secure
>>>>>>  => wget https://www.google.com/
>>>>>>  WARNING: no CA certificates, HTTPS connections not authenticated
>>>>>>  # Restore the builtin CA
>>>>>>  => wget cacert builtin
>>>>>>  # No more WARNING
>>>>>>  => wget https://www.google.com/
>>>>>>  18738 bytes transferred in 15 ms (1.2 MiB/s)
>>>>>>
>>>>>> Jerome Forissier (5):
>>>>>>   net: lwip: extend wget to support CA (root) certificates
>>>>>>   lwip: tls: enforce checking of server certificates based on CA
>>>>>>     availability
>>>>>>   lwip: tls: warn when no CA exists amd log certificate validation
>>>>>>     errors
>>>>>>   net: lwip: add support for built-in root certificates
>>>>>>   configs: qemu_arm64_lwip_defconfig: enable WGET_CACERT and
>>>>>>     MBEDTLS_LIB_X509_PEM
>>>>>>
>>>>>>  cmd/Kconfig                                   | 29 ++++++
>>>>>>  cmd/net-lwip.c                                | 19 +++-
>>>>>>  configs/qemu_arm64_lwip_defconfig             |  2 +
>>>>>>  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    |  9 +-
>>>>>>  .../lwip/apps/altcp_tls_mbedtls_opts.h        |  6 --
>>>>>>  lib/mbedtls/Makefile                          |  3 +
>>>>>>  lib/mbedtls/mbedtls_def_config.h              |  5 ++
>>>>>>  net/lwip/Makefile                             |  6 ++
>>>>>>  net/lwip/wget.c                               | 90 ++++++++++++++++++-
>>>>>>  9 files changed, 158 insertions(+), 11 deletions(-)
>>>>>
>>>>> Did you manage to add some sandbox tests for lwip?
>>>>
>>>> Unfortunately not. I am testing mostly with QEMU (qemu_arm64_lwip_defconfig)
>>>> and sometimes with KV260 and i.MX93.
>>>
>>> My understanding was that someone was working on it [1] and I had
>>> assumed it was you?
>>
>> Yes, it is on my TODO list. Higher priority things have kept coming in, but
>> hopefully I can resume this work soon.
> 
> Until the tests are added, please stop sending new series for lwip. It
> is just going to make it harder to add the tests later.

I don't see how exactly it would make things harder, but...

> It should not
> take long to add a basic test, e.g. for ping.

...I'm on it.

> Regards,
> Simon

Thanks,
-- 
Jerome
