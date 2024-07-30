Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71688C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2DF688607;
	Tue, 30 Jul 2024 16:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B8j8+rK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75F9588640; Tue, 30 Jul 2024 16:23:08 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10F9C87E30
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7ab76558a9so889893166b.1
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 07:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722349385; x=1722954185; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jjAZjNKb49Qi5oPN68cvhCvMIA8+tZkTfA/MR/kPZGw=;
 b=B8j8+rK4mhl2+fygfckuRiChA9z0xUkSrCGOe+WSZX64fwd+D4hNA46wVhVtv4nhOt
 AHYlxu1QyNLcPY01FtWKR7ZVGI6aYd4EcNyoBunrlRy6m43BBdnYTYmOuX5zp46ZgbV+
 ne48aXeipt/1Q3zQFkNSoq77EgjPT8z6IYE8j8UlQA1uSw5Jrc9QUJOWNNFD2r6oFUNh
 x9svW7NQVorliwtKyuR8dWm7FfIFFSb7E96O1FOA+o//kYJQzzIvI7nLpUns4qpDUyJP
 OmrzD5AlXFTl2+dYVuUvXRuJ1dzgY78FfJMhZUC81aLy8C8JELRjSiGsKfcdHbGiD66p
 uaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722349385; x=1722954185;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jjAZjNKb49Qi5oPN68cvhCvMIA8+tZkTfA/MR/kPZGw=;
 b=O/Y7eDKyzvniYWq0z48JCzB0VXHYIgVUNZzW9YzU/tb3iWoS1kq4yDJbQCM2B7FcO4
 86SEstin7Mv/C1Ofh7Mh8jWRXluKN1+8xDI5URT15s/h0VR7e82j2M8e/H/S3O2yXZ/A
 jX0ugbfbj84Bea3uPoZYIRXFBP7XA4gIPrMpPDadlqkfSqUINrgpPjf62wpoX94lNSTU
 oDz7+oap/XZlp3KTY2bg3sMSyOb7KX3Cdy4HciXJvOz6ZgwXNPjJrxX9yGmCDRz0p1zi
 wzdUoP31rABd2oKLEX5ax7LQ1kPgTg1Gl7yDsXg8RA9zzfgRz9T1VudbMxOYilHIvaXs
 bmvw==
X-Gm-Message-State: AOJu0Yy5yNt53/Slw3NJWzAvPy+VkRzobiGtlG7SX6I/KgjZ0yGPP3oj
 jz1XKrN+q0hhigaJDou59cEGvh1sSDJb/8flIDeSC2xI327IbEwakIw9qeK2uug=
X-Google-Smtp-Source: AGHT+IHN7HtOXPRS3nYTm8v87sBfVp2HRuZ5yXMQSpwJk5xm7hmllpj3++9xoxeQwTEt9LbwaAMjLA==
X-Received: by 2002:a17:907:c008:b0:a72:64f0:552e with SMTP id
 a640c23a62f3a-a7d859b3682mr221219066b.19.1722349385340; 
 Tue, 30 Jul 2024 07:23:05 -0700 (PDT)
Received: from [10.100.0.2] ([194.15.111.157])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7d9043ca41sm41976166b.72.2024.07.30.07.23.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 07:23:04 -0700 (PDT)
Message-ID: <497b2637-0fdd-485f-a85c-18e8aa479b82@linaro.org>
Date: Tue, 30 Jul 2024 16:23:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/20] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <20240725172220.GA989285@bill-the-cat>
 <db1d3c5c-918b-4aa5-b68a-020c168cf05c@linaro.org>
 <20240730140256.GT989285@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240730140256.GT989285@bill-the-cat>
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



On 7/30/24 16:02, Tom Rini wrote:
> On Tue, Jul 30, 2024 at 11:48:06AM +0200, Jerome Forissier wrote:
>>
>>
>> On 7/25/24 19:22, Tom Rini wrote:
>>> On Thu, Jul 25, 2024 at 02:57:21PM +0200, Jerome Forissier wrote:
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
>>> This is better than v4, and on the hardware platforms I could build and
>>> boot on (which was most of mine except the am62x_beagleplay), the tests
>>> ran and completed, including the tftp+boot a Linux kernel.
>>>
>>> The bad news is CI blows up, a lot:
>>> https://source.denx.de/u-boot/u-boot/-/pipelines/21764
>>
>> They're all failing with: undefined reference to `tftp_start'
>> The reason is I inadvertently removed the 'default y' on CMD_TFTPBOOT :/
>> Fixed in v6.
>>
>>> And:
>>> https://dev.azure.com/u-boot/a1096300-2999-4ec4-a21a-4c22075e3771/_apis/build/builds/9014/logs/106
>>> which is another Kconfig dependency problem. I don't _think_ I
>>> introduced that, but since this wasn't against top of tree, I had to
>>> apply the cmd/Kconfig patch manually.
>>
>> What's the build command? I can see:
>>
>> /bin/bash --noprofile --norc /Users/runner/work/_temp/9710a6d2-6670-4f76-81bc-990cc45b1898.sh
>>
>> ...but that's not super helpful ;)
> 
> make tools-only_defconfig or so, sorry.

Thanks. With this config on my build machine, v5 fails with
'CONFIG_SYS_RX_BUFFER undeclared here'. It is an issue that you mentioned
(and which I fixed for v6) but it is not the same error reported in the CI.
Anyways with the SYS_RX_BUFFER issue fixed the build is now successful:

$ make tools-only_defconfig && make -s -j$(nproc) && echo OK
#
# configuration written to .config
#
OK

Thanks,
-- 
Jerome
