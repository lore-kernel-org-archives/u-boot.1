Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8380C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 17:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ECE9881AD;
	Sun, 19 May 2024 19:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nqb8jIgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E73788093; Sun, 19 May 2024 19:57:58 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6364988232
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 19:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-572e8028e0cso6161928a12.3
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716141476; x=1716746276; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OTUPJTk3x6X9pLdYGamEfXr4UTsthBJbEOGK187wKLM=;
 b=nqb8jIgPowz+vDsY56LcUIoh365tDca9tdxZIYd+SSXQ76QoAkqMWPC1n5iX4Z6m/e
 nOOURYGsIYmntIljxAcU+4pdQr5EHFv1bpFHVLZIqgI7AprDBkrv1IRdfHFQuFSU9Mw1
 r16V/iCTkKfI0GnDWAwwTs2ZqkJhrm4Gdbmwqor4O/0rGRmLuvp9GqxWrngiCpN1RbSn
 6h3heI1ZnDFe/+vl/z7D7+vPoxyKOEBNE3ciLQ4O8q58sPEwk1akuwdFbgkOWAwVihqh
 cXgA85/KJKvAVuKHHuoUJ19QAbctlxvSCeHMT+dnUtbwhyn2uYIOr9Y8k+h3/Uv/srs1
 sIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716141476; x=1716746276;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OTUPJTk3x6X9pLdYGamEfXr4UTsthBJbEOGK187wKLM=;
 b=R+19XmGi6KOCBmFmB4FSKLyQwi53fWdIak+QlFCovY/Mnul/9pbywD065GSs0SbRMN
 2MZl2QSM8hIzA8eEzkDozcY9jiBsq9J4hI0xIQDl+3/kc9XcUnoVSg5LKkM2LCdXnJRU
 JdM9XklM1tsXqGbmK47kLfu/Cs/EcpJhCV/OmJKW+cezYMuNMZhTamkL0ettiVnmuvVm
 NFf2rC9m7eIXT16lHX2usjkbcSXLKDGzwot0ldLheqj6eDXB5tA6eVHqw44qFnWnf+Ib
 Oh6Yi/y96MpQ4LRfwLT09HIeK8KL6YFCXhh8KruGaYVm6jXDzPcdVGBOxswpbfaLovZX
 sYNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlQrfdsdTKwd5DD8sXmTdPcHnpVUUXI0Y/O3++nNsKDnMWZJVpvHEMAJScSOx510XxI5xP76zLntOMLtEh9345VJQwOw==
X-Gm-Message-State: AOJu0Yz3xDxYWRa3F7586JdM6THAvHMxovUuzyDb1s7Q0lmYM1V57kbS
 OD5D9jDvUoI84DCJGgTkiYz6399va3xqiJxYnjtkGnIVwlWg3QGj
X-Google-Smtp-Source: AGHT+IHHQJarZnZkEPN/i9DRoq/ZYbJba8CPfndWNnz9KMaTe2nW5F/8zVB6uzgSl7wWT1vjzR28mQ==
X-Received: by 2002:a50:aade:0:b0:56d:fbea:40ae with SMTP id
 4fb4d7f45d1cf-5734d5ceafamr18694557a12.23.1716141475793; 
 Sun, 19 May 2024 10:57:55 -0700 (PDT)
Received: from [192.168.10.30] (77-7-142-46.pool.kielnet.net. [46.142.7.77])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c34fed1sm14023631a12.96.2024.05.19.10.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 May 2024 10:57:54 -0700 (PDT)
Message-ID: <99ee82bd-d8b4-4c67-a074-29394d6a1ecf@gmail.com>
Date: Sun, 19 May 2024 19:57:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] pci: auto: Reduce bridge mem alignment boundary
 for boston
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
 <20240517-boston-v3-2-1ea7d23f4a1d@flygoat.com>
Content-Language: en-US
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <20240517-boston-v3-2-1ea7d23f4a1d@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 5/17/24 20:14, Jiaxun Yang wrote:
> Boston has a very limited memory range for PCI controllers, where
> 1MB can't easily fit into it.
> 
> Make alignment boundary of PCI memory resource allocation a Kconfig
> option and default to 0x10000 for boston.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   drivers/pci/Kconfig    |  9 +++++++++
>   drivers/pci/pci_auto.c | 16 ++++++++--------
>   2 files changed, 17 insertions(+), 8 deletions(-)
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
