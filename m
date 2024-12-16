Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25324E77180
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 16:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A62800D7;
	Mon, 16 Dec 2024 17:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Elo5Sr/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8898280104; Mon, 16 Dec 2024 17:59:27 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26548800D2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 17:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6BF9C3F2B4
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 16:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1734368364;
 bh=PnR+MlhHeoxQR+eQF/wqpKfNJNpmPSJA7UOpzYk5elQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Elo5Sr/D20+WUVRuNEle7HLLcWlpdlHLmUtEq2KpIWI8Pvo2LKsNl7XiPJdFdMlOK
 5G2cS43kQTNKiZfgM4otmTVxBaeuTk6h2uneHNyhwTrBo6hX+NFVtm/cCjTCYMAW+z
 FNbBt5nTtvGiZzatxlmc6NEzG3UH6UIU3kyfcnL5vXeDX9KLIjtUcVeUtM1iSTuX8s
 gzwPGPO0kkxiSDuE5g5ZLv4N2LsUfoXcTbGG7cywW2GjeXcMrKA1N7IGrB4t95aQEO
 F8SnxXjLtOLpSVtw0K5LD8De+Ue/itu0YkCgpmL7GBdBB128rLRJ99A2MYObD1D+lK
 mGQfRU0aI84IA==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e3cbf308so1779703f8f.2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 08:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734368364; x=1734973164;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PnR+MlhHeoxQR+eQF/wqpKfNJNpmPSJA7UOpzYk5elQ=;
 b=vq36RbxjML8wIQNylJvHHzkVcQQXdvHjEG1/khU6Dh1x9Owua0oka6wHw3SXXgFHkV
 ChiBKtvx8bEJ5gudMyqKmqE4tiKda/Smnex0DLGWFolE/XCc0VXiJAX7Ntq+cRbYZWtl
 t+WERPXsGA3oqiAmXnrzb2tv1+hou5anuWjAry3nYIyjY6NVTm+hZF3omDRLXTDZVrqK
 0kSVC3Lw6Ebujcsr0DQSLA7goyYlrp+4uRc2G5Ij0p+/sTNV6ORLaYMGRzOHMLHrF46p
 +wftoadpf7mMqJljRm2rZ33nsJ7UGchU26JG8jBPtSH9iwsB2MLcoCghIgO1RacBUYox
 X6LQ==
X-Gm-Message-State: AOJu0Yx7Fw8Wjnx/NRKhNt7dh/0aFCx+WJzwISxcVAJr1U9sSLmksDgI
 cwuoAQ7ZGYg/ol2l1njp8uGaKSppzK+3x5w1jPe3hIrPhAplQ3oTgkqYmOK30pF13a14DifzAbj
 oPWZefLdjSsAyeq1HCl71/d3ANCgu6crS25Qt0BHnNpCQfoZTmoEQSwFGEo2tj1z5ENQ=
X-Gm-Gg: ASbGncsMKAXDmeU6Fn2MRZAx+vjroPwTXQRQCf007amuusCJqj6CMHWJx56KO6C4OBc
 jxGxgZ6kA2ZThy2scjzW0ZIqfRzAsVkgbaU2yRA3MXRueVAy4twVQGQ1SyiPx8PVIoivY38fimc
 hhuEpvIr3M+//8jML3ekwxhZkpttljvBx8voYu8yhaxmWJDlj2mbnKd4yO5TDHeHRy/e0a/UrMG
 5fFRtZDt+X0sRuviUDmcLTZH47x+tUeqF7i7HmELHZ3TZjXFJ102Skwj+ZPNEzCo4CGqCUMzI6n
 4sXl3q5MicQjNKVydXJaz7xz+c6RuPgwK5493m+Aur1+oTNV4KhP5w==
X-Received: by 2002:a05:6000:4024:b0:386:3f3e:ab11 with SMTP id
 ffacd0b85a97d-3888e0bd231mr11006543f8f.34.1734368364040; 
 Mon, 16 Dec 2024 08:59:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGh97BlzS60DRxPeTtx/Ht7hMmVK5HG12ZnFH5WjBkHhpWT5fL3leAcnw2Bzig9DkrFvTxHxw==
X-Received: by 2002:a05:6000:4024:b0:386:3f3e:ab11 with SMTP id
 ffacd0b85a97d-3888e0bd231mr11006514f8f.34.1734368363718; 
 Mon, 16 Dec 2024 08:59:23 -0800 (PST)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80120c7sm8626030f8f.13.2024.12.16.08.59.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 08:59:23 -0800 (PST)
Message-ID: <d22efd6f-f680-4a4f-8093-aa74ca17cd35@canonical.com>
Date: Mon, 16 Dec 2024 17:59:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] scripts/spelling.txt: add GPL-2.0+
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241215023732.68902-1-heinrich.schuchardt@canonical.com>
 <2ebed5a8-002c-4792-a474-7cf31b6c0bad@canonical.com>
 <20241216153845.GG1505244@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241216153845.GG1505244@bill-the-cat>
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

On 16.12.24 16:38, Tom Rini wrote:
> On Sun, Dec 15, 2024 at 03:55:35AM +0100, Heinrich Schuchardt wrote:
>> On 12/15/24 03:37, Heinrich Schuchardt wrote:
>>> The correct SPDX identifier for the 'GNU General Public License v2.0 or
>>> later' is GPL-2.0-or-later.
>>>
>>> Checkpatch.pl uses the misspelled words from spelling.txt both as keys of a
>>> hash and as part of a regular expression. For usage in the regular
>>> expression special characters like the plus sign need to be escaped.
>>>
>>> Heinrich Schuchardt (2):
>>>     scripts/checkpatch.pl: allow special characters in spelling.txt
>>>     scripts/spelling.txt: add GPL-2.0+
>>>
>>>    scripts/checkpatch.pl | 2 +-
>>>    scripts/spelling.txt  | 1 +
>>>    2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>
>> I sent similar patches send to the Linux kernel list:
>>
>> https://lore.kernel.org/lkml/20241215025104.70096-1-heinrich.schuchardt@canonical.com/T/#t
> 
> Thanks for trying this upstream. As they seem uninterested, adding this
> to the existing function of "sub u_boot_line" in our checkpatch.pl is
> fine as an alternative.
> 

u_boot_line() is not called for *.rst files.

Best regards

Heinrich
