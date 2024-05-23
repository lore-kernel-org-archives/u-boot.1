Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58E9C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 13:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F92288582;
	Thu, 23 May 2024 15:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IPMO/Gg/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EED2B884EA; Thu, 23 May 2024 15:51:11 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2235885A0
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 15:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4202959b060so53014865e9.2
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 06:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716472269; x=1717077069; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qMB3QAgFYaEoRZJymHt9j5i5togg7fCkoRI3InR273Q=;
 b=IPMO/Gg/DGC+d7K4Di/eQpwjDrIq9GK6sei/MZx7ciruLowjHOvUrVh9tkCNg9j4OY
 nNotgpnGSkjWvmX9l0f5BOu/Vrsn8tcN3OxYN6AN6e+xoErTjYiOVjQDW21+/pNaLRx/
 UBrFxuBusSqSS2q9HZESHdc5YRUY+119QEjSZIS6VCsCjVskwGlZl/WPET7kn6rYQZVI
 95OHWouHE87DxL8dfkRrVcU2+bB6aRO3lYdg3WPNUHAVt9OZyKK/kQGVFDpIryeCxT4z
 OoIcowBQOL4tYl/i/ftqU7piV9KdhFrZIWUAcywLc01FA7TkZmnyHIMcvQ3vRNcUsTyx
 eIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716472269; x=1717077069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qMB3QAgFYaEoRZJymHt9j5i5togg7fCkoRI3InR273Q=;
 b=tYRrNfAu3XlhUb+UKVOCJ2MgGE4gIHqC0suE1cBFbCa3U1l/v4pKYaO4kbcuGkFtR6
 BpJbUnE1rS6WOZ5Bfrjq3CcjwQJwaBq9OrIA8vXCIh09MSx5ScRe+ZJ089IyCbyL3RIa
 etIg+HEzi02j2Ndzxffua1tkJdqS0ZZfiZoDBEbVLiE6qyVojL+1M9WgzRdRW/RQzbRD
 UgfSAHzf+56iXEmVriH2kjXK8/Zc/QL7/51XqHjNgC7EcuKmlBca9WJyMWhlbK3FCf1L
 qcrbbYNhzekdBqECuPpU7EaNqsrvVvbRaOt3xvb4c7OFLlStyl8OrWr9VWkgGCwGpj8o
 h9dA==
X-Gm-Message-State: AOJu0Yw2pifIt2RFn6mMWEYhK7mtW98VBorY8E19rw9jFh0iWkTsWFyf
 RudCv+rmjYVyo39Jo87fR2idY+jxV20gDlByN1HIduFwwtMcCI9XOqQcJ7Pmfe8=
X-Google-Smtp-Source: AGHT+IHgPG4sDrPnl+Y7s2ThXy3nQxzj/utHojH//JQs3LhjKjnyaPXumx7f1LcbBhG4E1bMPaUf8w==
X-Received: by 2002:a5d:6487:0:b0:354:de3b:a3f4 with SMTP id
 ffacd0b85a97d-354de3ba50dmr5503065f8f.40.1716472269242; 
 Thu, 23 May 2024 06:51:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:4ddc:8210:4043:e30f?
 ([2a01:e0a:3cb:7bb0:4ddc:8210:4043:e30f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100ee7f1dsm26055655e9.7.2024.05.23.06.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 06:51:09 -0700 (PDT)
Message-ID: <8b654eca-b042-4df7-82a0-b76c4b46c076@linaro.org>
Date: Thu, 23 May 2024 15:51:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] net-lwip: add support for EFI_HTTP_BOOT
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <6c98b28ebe3d2371cc1c62c531ae6115bc93c09e.1716393035.git.jerome.forissier@linaro.org>
 <CAC_iWjK6=npC2_BdrAEbXWovqbdmcXm65Xs7avh8tq85dc3SRA@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjK6=npC2_BdrAEbXWovqbdmcXm65Xs7avh8tq85dc3SRA@mail.gmail.com>
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



On 5/22/24 20:19, Ilias Apalodimas wrote:
> Hi Jerome,
> 
> On Wed, 22 May 2024 at 19:04, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Implement the wget_with_dns() function which is needed by
>> CONFIG_EFI_HTTP_BOOT=y. Note that there is no dependency added on
>> CONFIG_CMD_DNS_LWIP because CONFIG_CMD_WGET_LWIP natively supports
>> hostname resolution.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  lib/efi_loader/Kconfig |  5 +++--
>>  net-lwip/wget.c        | 16 ++++++++++++++++
>>  2 files changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> index 430bb7f0f7..9d8dc8c756 100644
>> --- a/lib/efi_loader/Kconfig
>> +++ b/lib/efi_loader/Kconfig
>> @@ -505,8 +505,9 @@ config EFI_RISCV_BOOT_PROTOCOL
>>
>>  config EFI_HTTP_BOOT
>>         bool "EFI HTTP Boot support"
>> -       select CMD_DNS
>> -       select CMD_WGET
>> +       select CMD_DNS if NET
>> +       select CMD_WGET if NET
>> +       select CMD_WGET_LWIP if NET_LWIP
>>         select BLKMAP
>>         help
>>           Enabling this option adds EFI HTTP Boot support. It allows to
>> diff --git a/net-lwip/wget.c b/net-lwip/wget.c
>> index 0ed8b77c47..a3e65dc80e 100644
>> --- a/net-lwip/wget.c
>> +++ b/net-lwip/wget.c
>> @@ -166,3 +166,19 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
>>
>>         return CMD_RET_FAILURE;
>>  }
>> +
>> +#if defined(CONFIG_EFI_HTTP_BOOT)
>> +int wget_with_dns(ulong dst_addr, char *uri)
>> +{
>> +       char addr_str[11];
>> +       struct cmd_tbl cmdtp = {};
>> +       char *argv[] = { "wget", addr_str, uri };
>> +
>> +       snprintf(addr_str, sizeof(addr_str), "0x%lx", dst_addr);
>> +
>> +       if (do_wget(&cmdtp, 0, ARRAY_SIZE(argv), argv) == CMD_RET_SUCCESS)
>> +               return 0;
>> +
> 
> Calling a command directly feels a bit weird.
> Can we do this instead:
> - Split do_wget in patch #7 and carve out 2 functions. The first will
> prepare the arguments and the second will call httpc_get_file_dns()
> and run the loop
> - Once that's split you can use the newly split function here and
> avoid calling a command

Addressed in next version. I have implemented wget_with_dns() in patch #7
to that #9 doesn't need to add any code. And do_wget() simply calls
wget_with_dns().

Thanks.
-- 
Jerome

> 
> Thanks
> /Ilias
>> +       return -1;
>> +}
>> +#endif
>> --
>> 2.40.1
>>
