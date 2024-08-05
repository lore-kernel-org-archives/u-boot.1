Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABCEC3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 18:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5116A884CC;
	Mon,  5 Aug 2024 20:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gADO8XEr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43EB5884CC; Mon,  5 Aug 2024 20:18:14 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF90B87F5C
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 20:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6135eso65961a12.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 11:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722881891; x=1723486691; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VtNr2vk6lmkO0J1KhZaDdAcYmIU/YdrktFxjtnIXL6Q=;
 b=gADO8XErIiPdOjSb/TAtyn2BNgKVqn9TT3zvYjar5M09/0xHGTiyJkaSL1VlXKFtzz
 tTvsGRRJGU/7ZKiytpy7F/yZg8N7cp8/5uvXJ/eHx/ZBjA0/21npXjFliA00FNgnEQ8e
 qJigr5cgn+hgdzsbBl9eXErpv/2q3u2LQBp/kUHWt0eVsLH++4SgVOZlk8l0Dq9TEsq1
 4DBmGWSOw+RaNE4vEGkrbTI+YiMwhK6O4EX1eX5iln/scT+SrSfw6BTBHMDN1Iwrf26o
 Nvo8sA5QLwXRpHiZDurfNefe3Ge82DwGhnnqrDls7uWD5r80GiGD4Lxd+2395JzoqO8z
 /DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722881891; x=1723486691;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VtNr2vk6lmkO0J1KhZaDdAcYmIU/YdrktFxjtnIXL6Q=;
 b=pq37Mxen6KrCTQ9XXLsfnKoiSX+swebg/CjSBpTL2vN9FmSPsfUH/lrWUhx49iYsWv
 B3zUiaBlMl1P9uvlSz3DHpcsyssTIStFjxGVJ41nuYPfsZDSgrCDabPZh2AsIEgzvHI2
 ipza1+Uu6dx5leeAMxToK8LxXkvBxgTAAmyWrRYeYFvyhwfxKLBq2TcIIIqjLDLst4q2
 Dp7him0w7s6QdbXNWorJInb6/pAwBC3m7uZLsCj8lfNNS2S5ekX600yYxaLv9itmCWVu
 dw1vVxIqF0mtsapo5d1DFfT8WW9v+59q+tPhg2euTp614BnfZyVc9zP/MboQ1zR/GhmH
 f8EQ==
X-Gm-Message-State: AOJu0YwXNm/GluahAAM6djGyPvYfIzt7jkNuX0jN+/r6Sl8U5ElTSwGP
 FIcobqB7QX4q4cqszKXzUqiBXmId+2WxqP+F+aMDueEN2MY7YkWFYFuJXPR15lc=
X-Google-Smtp-Source: AGHT+IF3+SKNhSibmeIs4CcQoXThj5I63johCtuIhcOqYzz+fN1zkeTBfa3SUcX2+ZYNQs/J6YW2cQ==
X-Received: by 2002:a05:6402:75a:b0:5af:b1d8:f3d5 with SMTP id
 4fb4d7f45d1cf-5b80c8c556cmr11092000a12.12.1722881891077; 
 Mon, 05 Aug 2024 11:18:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:8dbd:af80:ee89:6ef9?
 ([2a01:e0a:3cb:7bb0:8dbd:af80:ee89:6ef9])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b83b931794sm5155834a12.64.2024.08.05.11.18.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 11:18:10 -0700 (PDT)
Message-ID: <adf03f1c-cdde-4d4f-8078-59a4bf58b10d@linaro.org>
Date: Mon, 5 Aug 2024 20:18:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/20] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
 <20240802183249.GO3794063@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240802183249.GO3794063@bill-the-cat>
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



On 8/2/24 20:32, Tom Rini wrote:
> On Fri, Aug 02, 2024 at 06:26:27PM +0200, Jerome Forissier wrote:
> 
>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>> stack [2] [3] as an alternative to the current implementation in net/,
>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>> reasons for doing so are:
>> - Make the support of HTTPS in the wget command easier. Javier T. and
>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
>> so. With that it becomes possible to fetch and launch a distro installer
>> such as Debian etc. using a secure, authenticated connection directly
>> from the U-Boot shell. Several use cases:
>>   * Authentication: prevent MITM attack (third party replacing the
>> binary with a different one)
>>   * Confidentiality: prevent third parties from grabbing a copy of the
>> image as it is being downloaded
>>   * Allow connection to servers that do not support plain HTTP anymore
>> (this is becoming more and more common on the Internet these days)
>> - Possibly benefit from additional features implemented in lwIP
>> - Less code to maintain in U-Boot
>>
>> Prior to applying this series, the lwIP stack needs to be added as a
>> Git subtree with the following command:
>>
>>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
> 
> On Pi 3 I'm again / still seeing:
> ========================================== FAILURES ===========================================
> ___________________________________ test_efi_helloworld_net ___________________________________
> test/py/tests/test_efi_loader.py:163: in test_efi_helloworld_net
>     assert expected_text in output
> E   AssertionError: assert 'Hello, world' in 'No UEFI binary known at 200000'
> ------------------------------------ Captured stdout call -------------------------------------
> U-Boot> tftpboot 200000 EFI/arm64/helloworld.efi
> Using smsc95xx_eth device
> TFTP from server 192.168.1.10; our IP address is 192.168.1.100
> Filename 'EFI/arm64/helloworld.efi'.
> Load address: 0x200000
> Loading: #
>          883.8 KiB/s
> done
> Bytes transferred = 4528 (11b0 hex)
> U-Boot> U-Boot> crc32 200000 $filesize
> crc32 for 00200000 ... 002011af ==> 2b466005
> U-Boot> U-Boot> bootefi 200000
> No UEFI binary known at 200000
> U-Boot>
> =================================== short test summary info ===================================
> 
> On a configuration that works fine with the legacy network stack.
> 

That was caused by a missing call to efi_set_bootdev() in tftp_loop()
(net/lwip/tftp.c). Fixed in v8.

I also fixed a similar issue with wget (net/lwip/wget.c) but I
noticed that the NET version of wget has the same issue:

U-Boot> wget 200000 192.168.0.30:helloworld.efi
Waiting for Ethernet connection... done.
HTTP/1.0 200 OK
Packets received 13, Transfer Successful
Bytes transferred = 12720 (31b0 hex)
U-Boot> bootefi 200000
No UEFI binary known at 200000
U-Boot>

Should I also fix it in the same way? Or did I miss something? How
are you supposed to boot an EFI image downloaded via wget?

Thanks,
-- 
Jerome
