Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCBBC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 19:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FBE486F27;
	Sat, 18 Nov 2023 20:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kIohC6ST";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B70C28701D; Sat, 18 Nov 2023 20:02:37 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 587DD86D4C
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 20:02:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C18963F6E6
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 19:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700334148;
 bh=KfdK/Wai5yXnoJRDHaUZp2BJdc4XQHKYV5pNGWfX11s=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=kIohC6STxWo7fMOKqCWUb+V68eFcrfkRrLFejvum6NPQs3F3rF1Ivwwt+d2Ghv3f6
 W3RrR9Ygcf4HBDO0O0voHI/shryNzLX5fn4BionSXiO/uf3HVCx38A1r+GdaIz/XX2
 9rmzuSSu4Q7HDTiUuEswY/1wEW763/uZIBoON70TswsU9O7j40/pnHtu4bpnYZ9eIR
 1f/PD4VfxtCt1W7LpWnHVyPOPTSLuUdO0NXvt+1ZyvbMO0IjPRkN6qBEf9BdSDlydO
 sYpgpICPr22WrBV/pgd6WXTRQvsjRzA/ycbkeo4b06LGHYBW44iAH7e2/NQXLqkgMA
 9IkS+xYWoJ6ow==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4090181eec2so4470355e9.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 11:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700334148; x=1700938948;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KfdK/Wai5yXnoJRDHaUZp2BJdc4XQHKYV5pNGWfX11s=;
 b=vYtibzD87HFOOqrlSU12w6rOtQSe4lNSGcc9wFR7vmR7ib8538bqKZHqAXGFxF0k2i
 WWaFXChEbIwHtv7V6CQMtp/2Gnv5jRzNnpJlE/xIpaUBxnhammR3zjQxoWdH/u3x320U
 oLu6ei+J4/gwjyWKgfqTJajmnI+Re7aIN+cT+oCshsytXeQxexuWyKceXA2wpho7s3pB
 34WViJxtNqOyHM/clFjy2eM0Yx3FlvXR4ks+JMPW98svrR8yvjcYyDyaG59ixcekc4vb
 DLxj0hH/v44pTSZLFprpj4k6/0AbftGhmmppddezi+aWY1QJn5zvST3Vxyi8yEkpdwjG
 gBgA==
X-Gm-Message-State: AOJu0YzsexMyr9xkqWAezMU6+fU99pXGSsb+FgX28sboT/Dngcl/S/47
 VCOAffVonryWMO1a8HoQyTIxqOVPNq9xgBpOT7xtDwsm7Z46Wsrr7tCG715gn60GU/KoMSXxdsU
 9MZ7VFmLql4Jqetslb/rg3i+QW8sf6OrYT96ej7A=
X-Received: by 2002:a05:600c:1da9:b0:408:39d3:a26b with SMTP id
 p41-20020a05600c1da900b0040839d3a26bmr2488313wms.40.1700334148296; 
 Sat, 18 Nov 2023 11:02:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFndFOWOhdJH1oDNWtXYUNNe8O+dJGGOG5u2vgMQhZueHeNqaeO2pGrkwHW6Sutzan3dIoSNg==
X-Received: by 2002:a05:600c:1da9:b0:408:39d3:a26b with SMTP id
 p41-20020a05600c1da900b0040839d3a26bmr2488296wms.40.1700334147831; 
 Sat, 18 Nov 2023 11:02:27 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 n13-20020a05600c500d00b004083996dad8sm11817664wmr.18.2023.11.18.11.02.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 11:02:27 -0800 (PST)
Message-ID: <6541e6cc-44c8-4348-9cfd-248cb8d42180@canonical.com>
Date: Sat, 18 Nov 2023 20:02:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cmd: acpi: fix acpi list command
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
References: <20231112070316.17982-1-heinrich.schuchardt@canonical.com>
 <20231112070316.17982-3-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3scsicFCvRwWapE9SxPoj2Vk9+TJRx2b0o7iE7vQAv3w@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ3scsicFCvRwWapE9SxPoj2Vk9+TJRx2b0o7iE7vQAv3w@mail.gmail.com>
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

On 11/12/23 21:01, Simon Glass wrote:
> On Sun, 12 Nov 2023 at 00:03, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> ACPI tables may comprise either RSDT, XSDT, or both. The current code fails
>> to check the presence of the RSDT table before accessing it. This leads to
>> an exception if the RSDT table is not provided.
>>
>> The XSDT table takes precedence over the RSDT table.
>>
>> Addresses in the XSDT table are 64-bit. Adjust the output accordingly.
>>
>> As the RSDT table has to be ignored if the XSDT command is present there is
>> no need to compare the tables in a display command. Anyway the
>> specification does not require that the sequence of addresses in the RSDT
>> and XSDT table are the same.
>>
>> The FACS table header does not provide revision information. Correct the
>> description of dump_hdr().
>>
>> Adjust the ACPI test to match the changed output format of the 'acpi list'
>> command.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>          add unit test for offset of field Entry in RSDT, XSDT
>>          merge patch 2 and 3
>>          remove leading zeros from address output
>> ---
>>   cmd/acpi.c     | 48 +++++++++++++++++++++++++++++-------------------
>>   test/dm/acpi.c | 18 +++++++++---------
>>   2 files changed, 38 insertions(+), 28 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

The patch does not consider that

     map_sysmem(0, 0) != NULL

on the sandbox.

list_rsdp() needs to be changed to pass rsdt or xsdt as NULL if 
rsdt_address or xsdt_address is zero when invoking list_rsdt().

So this needs a respin.

Best regards

Heinrich
