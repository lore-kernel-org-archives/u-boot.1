Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED31D17123
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 18:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C16D588EDA;
	Mon, 21 Oct 2024 20:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kQbynRwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38EFD88F01; Mon, 21 Oct 2024 20:15:51 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25C1B88E8A
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 20:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3B0443F2B3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 18:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729534548;
 bh=A65flM1CDdeTupmwfMu2DvSZGSAu6JThIPvC04QPlZQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=kQbynRwDNByv7KAL7Ult/AXkh1oF03AcnKTQ6+DmtZ4ApsxG6WE7NSiouArpgBcup
 Mxwc9vrxn25k4UhCwLGeOIhdviU5OQKbvPeRG6NrzNQs5Ul+Blf1XD54206Z9O1c1C
 2icjQbS3Bd+HUs3Q6wJm3dyLWlR8APRcgFGwD01Ltz71p+HQv3hk9gy9e0BDpBvk+T
 VVACQoNZGFxI+ccz25b5NGfUUeThDnm5366n0Upwy5RVm8MVzMyik0mHK0eYYIC6Dv
 8/OqawAQGFxpdRDcQ3ksj1vYz76rkhzhj6m4Nj+J1rZGBQgY2/2yzTi/oXrYWFrwXQ
 Jv89dtKMM4KVw==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a9a1be34c68so324927966b.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 11:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729534548; x=1730139348;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A65flM1CDdeTupmwfMu2DvSZGSAu6JThIPvC04QPlZQ=;
 b=sq7WXcAr6Cv4wzZU9OFtFY+bYRTGMLmR25AN1TzC87bksRucklC9dRu6bGkNpqUNjb
 BMcCILkuIzfjbh4JiT/JPH2NAAw05DeXecuSnK3ILR8PEp+L694+TBI7MPBJeFkug6Rt
 Ygz8mVnXThtMrpiV7ivfyqse2l9Ol2up0xb/ceyuBEkjwzlZ9QByB3Aa+ossqE9nP8CD
 oiTckUpPipoaw21Jkk2hgeziwtpFkxBstJ9zjojnmhGhaLdjzeCize2uqnlTubjmVcNT
 qxGKspgq/l1WKa2LMdhhmZnCr4EoCYxESLbOEioVtn8VcVCi2vPUSf1QGS6XDA3qWvnh
 sOTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs1QUBpqrkcfarjB1fn5iwdVHbxAJFiHsNM97zFlPFLC8MSrK9kh1wiZR4Q4ofRfHtv/Ebcrs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx749nBIQ4xHJjXC1vkJPfeZKMXYdsgQA5aaPkTyZLohddtY7B1
 5+dy1Q6rrWvJbtDVR5jYO4UX8/2RdKl6hUjn0EgQkxv8KtTY6Lc/UVkWp18mcC5Ovw6y8RXkUaP
 /f3mR4AfPX2annfeajPdylehN0dFQ6vVPY4PsPSR7Yg5FGhXPbebB80PH9VoyE+78Ato=
X-Received: by 2002:a17:906:6a04:b0:a9a:1585:dd6a with SMTP id
 a640c23a62f3a-a9aa892dc0cmr88243966b.36.1729534547765; 
 Mon, 21 Oct 2024 11:15:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+elWkF9Nh+kQU8yJzDbGQ5Q5ZS4liKv/AjsidM8UO5GTGUgBRHgmkrC6pxbLhwEVmV3E95A==
X-Received: by 2002:a17:906:6a04:b0:a9a:1585:dd6a with SMTP id
 a640c23a62f3a-a9aa892dc0cmr88241866b.36.1729534547289; 
 Mon, 21 Oct 2024 11:15:47 -0700 (PDT)
Received: from [10.43.6.224] ([87.215.50.114])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6644sm237046566b.81.2024.10.21.11.15.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 11:15:46 -0700 (PDT)
Message-ID: <1e9609f3-f237-4aa7-9f9a-4eb30243261f@canonical.com>
Date: Mon, 21 Oct 2024 20:15:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] doc: do not include K3 boards twice in TOC
To: Tom Rini <trini@konsulko.com>
Cc: Sean Anderson <sean.anderson@seco.com>, Nishanth Menon <nm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>, Dhruva Gole
 <d-gole@ti.com>, u-boot@lists.denx.de
References: <20241021180101.18452-1-heinrich.schuchardt@canonical.com>
 <20241021180101.18452-3-heinrich.schuchardt@canonical.com>
 <20241021181234.GQ4959@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241021181234.GQ4959@bill-the-cat>
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

On 10/21/24 20:12, Tom Rini wrote:
> On Mon, Oct 21, 2024 at 08:01:01PM +0200, Heinrich Schuchardt wrote:
>> Sphinx writes a warning if a page is included twice in the table of
>> contents. Use references instead.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   doc/board/ti/k3.rst | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
>> index c3513f0aee2..5d01f487622 100644
>> --- a/doc/board/ti/k3.rst
>> +++ b/doc/board/ti/k3.rst
>> @@ -32,19 +32,22 @@ K3 Based SoCs
>>   
>>      am62ax_sk
>>      am62x_sk
>> -   ../beagle/am62x_beagleplay
>> -   ../phytec/phycore-am62x
>> -   ../toradex/verdin-am62
>>      am62px_sk
>>      am64x_evm
>>      am65x_evm
>>      j7200_evm
>> -   ../beagle/j721e_beagleboneai64
>>      j721e_evm
>>      j721s2_evm
>>      j722s_evm
>>      j784s4_evm
>>   
>> +K3 SoC based boards in other sections
>> +
>> +* :doc:`../beagle/am62x_beagleplay`
>> +* :doc:`../beagle/j721e_beagleboneai64`
>> +* :doc:`../phytec/phycore-am62x`
>> +* :doc:`../toradex/verdin-am62`
> 
> Can we just make the changes to :doc: links be inline and keep the list
> sorted/ordered as-is? Or does that not read well once rendered?
> 

This is nothing Sphinx would understand:

WARNING: toctree contains reference to nonexisting document 
'board/ti/:doc:`../beagle/am62x_beagleplay`' [toc.not_readable]

Best regards

Heinrich
