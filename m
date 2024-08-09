Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D94C52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 13:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ABC488859;
	Fri,  9 Aug 2024 15:19:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eA3typzK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A6788A0E; Fri,  9 Aug 2024 15:19:07 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 210B68883D
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 15:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ef7fef3ccfso21502891fa.3
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 06:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723209544; x=1723814344; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dKOp7+uMH8jSivqg1YfaYD7afKlqNjkPrrl3bxyR8xQ=;
 b=eA3typzK8r1LnJA2Oc6GyQ3oQJ2bPIC6S0q64Zfd+amFlmszvWFsAqUvldBFbuNwqG
 L5Jhocfsza3445cTyo0Qw4/yIg/5Xjr3FZDvZvdlcNf/t31zje0/SxYoQr2+By4aZRon
 7ljTy6TE0DZWynIrVOLh6R5bi8IEMT7sB3DtZEy8sZEebPIu7y9gdCLvg43DoNWzer7r
 DHuum+RBfDa1L7pEfRaXpb9M1W3C5WKZvlndxEzXN2M36sVsEcW/r1tJzOUKcE28bQ72
 MCZbDJxjFwh3hCdSFMavs1VOUhKz/I3GhIrtQmxH9FJpGMg589KxZWbnchx0/0PeyeWZ
 Vhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723209544; x=1723814344;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dKOp7+uMH8jSivqg1YfaYD7afKlqNjkPrrl3bxyR8xQ=;
 b=X+WIjiLdUUGBKW7LAZ4gZubGZE/JXN/tUWNIWTxl68YjWXVlyaRnigQNe2UImc37mj
 C8cavyrbmVzduJx3tnG17ScIfSkhcDBikSfMxQTK/jvGvJLNNtHq9Q2EOFwdXUGp6ZRa
 qhy5s1C3udki9fZaMMiT1ZXbKXOqWdU6JnxTT2xnQCcHReeMRiXZ5RSA9y6qKmONUXko
 dMWp4TeS03XPVKy6jeRCStNJqfTi1E4oT0+tbFcmdyudUAmoP69qme07qE6ExeyC83jq
 /mqO2GjvpabSwmOgaFDCD64DbIbBZapYlTQTV5cv/ZqqbI1mggPhkvdDHgOb/MFfbyeK
 msag==
X-Gm-Message-State: AOJu0YwW8ihvSyhHM1lEEZfLSqti3P/I//Kuy/FyB0wqBrClGVwHtqrO
 NA8/smAEOO2fYmaMlWCWVeIUxKvqqmzqQ6sUDCNmbq5Tnk7JyX5IDBkew1n0nsg=
X-Google-Smtp-Source: AGHT+IHzr7KSr078OqTRc186+AXKB2xrUR05NfB6F2Znc+2PwT+d4Hna6Eoz074dnGGzPwIG85fRjQ==
X-Received: by 2002:a05:6512:693:b0:52f:c0ee:3b5f with SMTP id
 2adb3069b0e04-530ee96bed0mr1273677e87.10.1723209543955; 
 Fri, 09 Aug 2024 06:19:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:f3b8:f3a:8a2b:6d6?
 ([2a01:e0a:3cb:7bb0:f3b8:f3a:8a2b:6d6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec6b25sm834469366b.198.2024.08.09.06.19.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 06:19:03 -0700 (PDT)
Message-ID: <44d9347a-974c-41b3-a6d8-00f4d1b86adb@linaro.org>
Date: Fri, 9 Aug 2024 15:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/23] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <20240807204400.GJ1626301@bill-the-cat>
 <2a23d370-82a0-446e-8ab5-00fa9005fdbf@linaro.org>
 <20240808172454.GQ1626301@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240808172454.GQ1626301@bill-the-cat>
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



On 8/8/24 19:24, Tom Rini wrote:
> On Thu, Aug 08, 2024 at 06:41:02PM +0200, Jerome Forissier wrote:
>>
>>
>> On 8/7/24 22:44, Tom Rini wrote:
>>> On Wed, Aug 07, 2024 at 07:11:44PM +0200, Jerome Forissier wrote:
>>>
>>>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>>>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>>>> stack [2] [3] as an alternative to the current implementation in net/,
>>>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>>>> reasons for doing so are:
>>>> - Make the support of HTTPS in the wget command easier. Javier T. and
>>>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
>>>> so. With that it becomes possible to fetch and launch a distro installer
>>>> such as Debian etc. using a secure, authenticated connection directly
>>>> from the U-Boot shell. Several use cases:
>>>>   * Authentication: prevent MITM attack (third party replacing the
>>>> binary with a different one)
>>>>   * Confidentiality: prevent third parties from grabbing a copy of the
>>>> image as it is being downloaded
>>>>   * Allow connection to servers that do not support plain HTTP anymore
>>>> (this is becoming more and more common on the Internet these days)
>>>> - Possibly benefit from additional features implemented in lwIP
>>>> - Less code to maintain in U-Boot
>>>>
>>>> Prior to applying this series, the lwIP stack needs to be added as a
>>>> Git subtree with the following command:
>>>>
>>>>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
>>>
>>> For v9, I think it would be good to do a CI run with NET_LWIP default
>>> and seeing what fails from that too. There's a few problems still
>>> leading to a lot of failures, in that case. Thanks.
>>
>> I pushed my branch to GitHub [1] and there's a failure in the
>> tools_only_macOS job [2]. Any idea what is going on? I tried twice and
>> it failed twice :-/
>> Om my Linux machine, "make tools-only_config tools-only" works
>> fine.
>>
>> [1] https://github.com/u-boot/u-boot/pull/635
>> [2] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=9105&view=results
> 
> Alright so from [2] going to the job and then downloading the raw log (it's
> huge, firefox gets mad for me), scrolling down until it's not the git clone we
> see:
> 2024-08-08T14:36:30.0865130Z   HOSTCC  scripts/basic/fixdep
> 2024-08-08T14:36:30.8641660Z   HOSTCC  scripts/kconfig/conf.o
> 2024-08-08T14:36:30.9645180Z   LEX     scripts/kconfig/zconf.lex.c
> 2024-08-08T14:36:31.0545650Z   YACC    scripts/kconfig/zconf.tab.c
> 2024-08-08T14:36:33.2374910Z   HOSTCC  scripts/kconfig/zconf.tab.o
> 2024-08-08T14:36:34.9997050Z   HOSTLD  scripts/kconfig/conf
> 2024-08-08T14:36:36.5552790Z generated_defconfig:7:warning: unexpected data:  # CONFIG_SANDBOX_
> SDL is not set
> 2024-08-08T14:36:36.5666380Z generated_defconfig:12:warning: unexpected data:  # CONFIG_BOOTSTD
> _FULL is not set
> 2024-08-08T14:36:36.5724560Z generated_defconfig:13:warning: unexpected data:  # CONFIG_BOOTMET
> H_CROS is not set
> 2024-08-08T14:36:36.5742720Z generated_defconfig:14:warning: unexpected data:  # CONFIG_BOOTMET
> H_VBE is not set
> 2024-08-08T14:36:36.5752700Z generated_defconfig:17:warning: unexpected data:  # CONFIG_CMD_BOO
> TD is not set
> 2024-08-08T14:36:36.5772400Z generated_defconfig:18:warning: unexpected data:  # CONFIG_CMD_BOO
> TM is not set
> 2024-08-08T14:36:36.5788060Z generated_defconfig:19:warning: unexpected data:  # CONFIG_CMD_BOO
> TI is not set
> 2024-08-08T14:36:36.5792360Z generated_defconfig:20:warning: unexpected data:  # CONFIG_CMD_ELF
>  is not set
> 2024-08-08T14:36:36.5828400Z generated_defconfig:21:warning: unexpected data:  # CONFIG_CMD_EXTENSION is not set
> 2024-08-08T14:36:36.5840470Z generated_defconfig:22:warning: unexpected data:  # CONFIG_CMD_DAT
> E is not set
> 2024-08-08T14:36:36.5938540Z generated_defconfig:26:warning: unexpected data:  # CONFIG_ACPIGEN
>  is not set
> 2024-08-08T14:36:36.5974000Z generated_defconfig:35:warning: unexpected data:  # CONFIG_VIRTIO_MMIO is not set
> 2024-08-08T14:36:36.5985430Z generated_defconfig:36:warning: unexpected data:  # CONFIG_VIRTIO_PCI is not set
> 2024-08-08T14:36:36.6045140Z generated_defconfig:37:warning: unexpected data:  # CONFIG_VIRTIO_SANDBOX is not set
> 2024-08-08T14:36:36.6053060Z generated_defconfig:38:warning: unexpected data:  # CONFIG_GENERATE_ACPI_TABLE is not set
> 2024-08-08T14:36:36.6068760Z generated_defconfig:39:warning: unexpected data:  # CONFIG_EFI_LOADER is not set
> 2024-08-08T14:36:36.6088140Z #
> 2024-08-08T14:36:36.6121560Z # configuration written to .config
> 2024-08-08T14:36:36.6130190Z #
> 2024-08-08T14:36:42.5830900Z scripts/kconfig/conf  --syncconfig Kconfig
> 2024-08-08T14:36:43.9105630Z .config:284:warning: symbol value '' invalid for AVB_BUF_ADDR
> 2024-08-08T14:36:43.9121120Z .config:285:warning: symbol value '' invalid for AVB_BUF_SIZE
> 2024-08-08T14:36:43.9142940Z *
> 2024-08-08T14:36:43.9172380Z * Restart config...
> 2024-08-08T14:36:43.9257450Z *
> 2024-08-08T14:36:43.9288610Z *
> 2024-08-08T14:36:43.9332910Z * Security support
> 2024-08-08T14:36:43.9366750Z *
> 2024-08-08T14:36:43.9399770Z Build Android Verified Boot operations (AVB_VERIFY) [Y/n/?] y
> 2024-08-08T15:35:07.9280210Z ##[error]The Operation will be canceled. The next steps may not contain expected logs.
> 
> And indeed, most of that is "normal" if we look at a current build for
> tools-only on macOS. We're being hit by the fact that the host CC isn't
> gcc and is llvm and https://github.com/llvm/llvm-project/issues/78778
> applies, I believe. Now how do we work around this? Hum...

That's an "interesting" bug...
 
> If you go an change "# CONFIG_FOO is not set" to CONFIG_FOO=n in
> configs/tools-only_defconfig, I assume your build moves on?

Yep, it does.

> This is
> valid syntax and fixing a more generic issue we have on macOS today.

I am adding a new patch to v9: "configs: use syntax CONFIG_FOO=n in
tools-only_defconfig". It means one extra step when syncing the
defconfigs though... It is just a simple sed command but perhaps you
have a better idea?

Thanks again for testing and for your help,
-- 
Jerome
