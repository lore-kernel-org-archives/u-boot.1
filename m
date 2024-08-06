Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF78C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 22:28:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A48988AEA;
	Wed,  7 Aug 2024 00:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZBpsVkGm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E239188AF9; Wed,  7 Aug 2024 00:28:07 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79357889E1
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 00:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7b2dbd81e3so159757166b.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 15:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722983283; x=1723588083; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4XL3s/aeKadFU4erlEaidfNA5jkEPB4NPcTM5TOat2o=;
 b=ZBpsVkGmneDgd0ANXTtGoNvMT+c8PKwTJlPt8W/G4cz0ZOOYBEyiyGSLDCE+YlZT8F
 6YXIuSavt0cG+K1hUBqxXDb10Nrhf67isuPZrPZSQzYWc9Aq9FeX9ps7qrJVXd2lKKiQ
 cMUT+TpO//XeR5OCAoPZzmdyq0L60jGUOscJtIDp/iNzyyi9Zax7YyJHjgY0DIKJ8Nor
 Ac8vflYTg8JrJBUkIGrnu+P+hoxXY8HQW0NZa4IAV8PRSL518MMDiF/OiWP13HnfGWJ8
 ubHEfDOmCQz/y3xxcnTDgngXXJBiKwgKJOlmiQlpqbgWFAlEY5vzlKJIA9BBTO28T8vp
 W0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722983283; x=1723588083;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4XL3s/aeKadFU4erlEaidfNA5jkEPB4NPcTM5TOat2o=;
 b=mGvUeMiMAuKjlkYDdNLRn/GR8ZoQm9HcbF3zz7+04UdDZo60CJrM29xZhXDIq7Ovzk
 KSWFUtFnkoHCN3oB8yvtKWqRm7eu/oxumlzREJxn/yOt0bIcpDOa+ICVA7PRQfsJu8hs
 Sx67sNTT/K2vVmPeHlx3ewBbfmk2fYVMZ778SlCIC+CLVWYClohc1hieH5Lk6G/PvMGg
 jZicCV3EvmJD+iu+7Ej1m8gKzGd8vAuJtKkQLwqzAGQJf4MTnfGogOY3vbCXWX4eSYSX
 09QmyJhDkUZBwi35oFFyHJWkSfU+Lyq1hVDh4yZsyDXD2vFW6FRkeTgU20GgclaPddzk
 sFxw==
X-Gm-Message-State: AOJu0YxaYWnlMoXvkY434z2iJy+XcDr9DAbkCxRnjwllrJBycJpHa3/z
 2oslZgcqbm62Qu+iP1GuM0TXtS+4kd2WWP1IU10EYw28TX3NBwmwGEUJ+JYBEXM=
X-Google-Smtp-Source: AGHT+IFDlMQNxnxMD4qcYZ5yViQJfskAM/uN6u4TVVM+2AbiV83+Ti5iDJGYIWt5VF+Xz5tTeDlBuw==
X-Received: by 2002:a17:907:318e:b0:a7a:9fe9:99e7 with SMTP id
 a640c23a62f3a-a7dc5000630mr1043646366b.41.1722983282889; 
 Tue, 06 Aug 2024 15:28:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:3c20:d905:6027:2354?
 ([2a01:e0a:3cb:7bb0:3c20:d905:6027:2354])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7de4e7f336sm448333066b.131.2024.08.06.15.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 15:28:02 -0700 (PDT)
Message-ID: <1d6f2098-aed9-42f5-b7cc-b1575d1e4e83@linaro.org>
Date: Wed, 7 Aug 2024 00:28:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/20] Introduce the lwIP network stack
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
 <20240802183249.GO3794063@bill-the-cat>
 <CAFLszThqMXGifQakKdWDwOYv0WXymk1C_3YVDvkKMgEsgS3Eyg@mail.gmail.com>
 <20240806211902.GC1626301@bill-the-cat>
 <CAFLszThrSsdW4Tsjhe8YmoU74YoACSyqra-FhqiocZ2-eMjD0w@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszThrSsdW4Tsjhe8YmoU74YoACSyqra-FhqiocZ2-eMjD0w@mail.gmail.com>
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



On 8/6/24 23:51, Simon Glass wrote:
> Hi Tom,
> 
> On Tue, 6 Aug 2024 at 15:19, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Tue, Aug 06, 2024 at 03:12:47PM -0600, Simon Glass wrote:
>>> Hi Tom,
>>>
>>> On Fri, 2 Aug 2024 at 12:32, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Fri, Aug 02, 2024 at 06:26:27PM +0200, Jerome Forissier wrote:
>>>>
>>>>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>>>>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>>>>> stack [2] [3] as an alternative to the current implementation in net/,
>>>>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>>>>> reasons for doing so are:
>>>>> - Make the support of HTTPS in the wget command easier. Javier T. and
>>>>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
>>>>> so. With that it becomes possible to fetch and launch a distro installer
>>>>> such as Debian etc. using a secure, authenticated connection directly
>>>>> from the U-Boot shell. Several use cases:
>>>>>   * Authentication: prevent MITM attack (third party replacing the
>>>>> binary with a different one)
>>>>>   * Confidentiality: prevent third parties from grabbing a copy of the
>>>>> image as it is being downloaded
>>>>>   * Allow connection to servers that do not support plain HTTP anymore
>>>>> (this is becoming more and more common on the Internet these days)
>>>>> - Possibly benefit from additional features implemented in lwIP
>>>>> - Less code to maintain in U-Boot
>>>>>
>>>>> Prior to applying this series, the lwIP stack needs to be added as a
>>>>> Git subtree with the following command:
>>>>>
>>>>>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
>>>>
>>>> On Pi 3 I'm again / still seeing:
>>>> ========================================== FAILURES ===========================================
>>>> ___________________________________ test_efi_helloworld_net ___________________________________
>>>> test/py/tests/test_efi_loader.py:163: in test_efi_helloworld_net
>>>>     assert expected_text in output
>>>> E   AssertionError: assert 'Hello, world' in 'No UEFI binary known at 200000'
>>>> ------------------------------------ Captured stdout call -------------------------------------
>>>> U-Boot> tftpboot 200000 EFI/arm64/helloworld.efi
>>>> Using smsc95xx_eth device
>>>> TFTP from server 192.168.1.10; our IP address is 192.168.1.100
>>>> Filename 'EFI/arm64/helloworld.efi'.
>>>> Load address: 0x200000
>>>> Loading: #
>>>>          883.8 KiB/s
>>>> done
>>>> Bytes transferred = 4528 (11b0 hex)
>>>> U-Boot> U-Boot> crc32 200000 $filesize
>>>> crc32 for 00200000 ... 002011af ==> 2b466005
>>>> U-Boot> U-Boot> bootefi 200000
>>>> No UEFI binary known at 200000
>>>> U-Boot>
>>>> =================================== short test summary info ===================================
>>>>
>>>> On a configuration that works fine with the legacy network stack.
>>>
>>> BTW the "No UEFI binary known at 200000" is that hack that I would
>>> really like to improve on, by updating bootstd to keep track of which
>>> images are loaded.
>>
>> I don't know, if I think about this I get worried that "bootFOO
>> $address" needs to know something more than "look at $address and check
>> if it's valid".
> 
> Yes, that is the problem with EFI loader at the moment. But basically
> it just wants to know what device the file came from, which we can
> (over time) clean up so that it is part of bootstd and uses proper
> APIs. Random loads within scripts are perhaps another matter...

TBH I don't understand what this "No UEFI binary known" thing is trying
to achieve. Is it trying to prevent executing memory that doesn't
contain a EFI binary? There is no way it can know. tftpboot and wget
can both load random non-EFI payload so there is no guarantee we have a
valid image after load. It should be the job of the EFI loader to behave
properly and not crash in case the binary is invalid, but if it doesn't,
no simple check can change this.

Or did I miss something?

-- 
Jerome
