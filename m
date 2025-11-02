Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C5ECCF9E3
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 17:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D28FD838DD;
	Sun,  2 Nov 2025 18:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SghRtbEg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B5183642; Sun,  2 Nov 2025 16:35:06 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C84F82A9E
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 16:35:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-340e525487eso468107a91.3
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 07:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762097703; x=1762702503; darn=lists.denx.de;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ny4HnWRvRpr8dFzneh3reVkZqXrDVzS8+0zI/CzR/Gg=;
 b=SghRtbEgC9vQGwpl+SjSv0tfff38Lc6ryYVRXOSPuftpHxobPUUI6CZjEYyOgUSP9s
 IKjoCP2BdkgY2fxF3gJafFR3L17VC/8QcGttRGXzqp4xmo6BDgytyx1luxUADj3JSIBV
 o1nZW6OIJTZiBpaTRHLqsZ9qWPV+m9hkbrBcBzcR0r0RAmCuR8645vcErD63Hs4Q3Duh
 KCrt6PC68fyhnf5ucNa4g4weJMjJWgkA+kmaIcGx3flffZXCCNbfZmr/L80p/v/RZnB9
 Evhop9r7bS1+Y5WsIj6vAaXRoj6YlB1lWHas2O9LYS35pT217a37tb8NCf4BlvR9RNiT
 LS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762097703; x=1762702503;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ny4HnWRvRpr8dFzneh3reVkZqXrDVzS8+0zI/CzR/Gg=;
 b=BrXaleuYSDbiPPdiZUCuOngfoRrRZPF4BoKBKrISA8phbYSSu/MVfQDr6v2ZYzLCzn
 PjrSB0Hz0bpjGVfzFxRgqPXhTNGR+PXZEhQT0KL2plgS0cAlUvJ8GD5U9V4V5f7kUnqI
 1eUCnjttRC1xtmw2jWt7ZfJ0DIat8IFUdLnyfNug0vi4nWZ5liaWmI8JH/s9eKX2SO+E
 nPOsUGwCLpllic+DN0ALN0lLPw5XfWbKJdOtrsU4Y+jYFzEafdQR+Gwhwbc8igsTSg37
 mWnTUHYqziVjx3aeG+bIquKG6YIGScxeuYQbkqz/SDjWl/Ju4CnMFqB57JD8rwD6BCp0
 qEag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJvKjKqpEgQGnRkUyFfbK1vwnfQ7ZId1GikTI5LgqTn8N0zzc8BPZmiYMLTVHi3SMvAyNj/JA=@lists.denx.de
X-Gm-Message-State: AOJu0YzP38of8D3J5VRbiNetIbFQ9sfqZVkil29OzWDwEne5pQw/Veag
 wnXZrqD98VW5+QFsNsXF9U4M28ykkUe1XcLy4zKQh2URDCF4rE0EWHkl
X-Gm-Gg: ASbGnctx0DBesVJecTVqdrOsTgzx0GyIMkxCC3Ok4YmEScf7yBcFdmIHsGHI1R54y/S
 gfSu8TALTTORMhq4lrrVE2g2Rnjt1L8HqXlbBB1rRY3lo1qJWZWPzgTqrSRgXsGROIW6PAwm44f
 J8OTODDUks52nhFsnGy5BWLN4/IAe2LRqP/eGeHZqKHdiZMmm+Hx65SE81s6rjs4RjZZGVgoGfa
 nqv5faClk47hZvyt9fSb7emEoVrtUFaCUPOONWn8MySosCtq5WfrIBzjN7FKwL2dLt/67uV3ORk
 +isMq3LbXhLWQS0/B7vBgy3KetgW4VsYTiSBKZeqOMN3rswL+fCgcdwVOxsyybTpKFOP84wZ7GC
 pANvUAHo09DKh2IJH7N+vK8YsPSi2qkjgh44MicvhWF25ftxxdzKj761HDywEQWfa+EdgnqlOvs
 7F3nDNARwbBNcI3q0nVTspA370cpq2rUHo1koR0ThxA+nrMswoQTslMKz6MLsEUlACG5IwiB4=
X-Google-Smtp-Source: AGHT+IEl9y1w+awZyq8pnDajPyromVzEIUkd4C36FhkFXCt9kIaPo1yJi1G04qcDHLpZHjXDY17yNQ==
X-Received: by 2002:a17:90b:2250:b0:340:5c27:a096 with SMTP id
 98e67ed59e1d1-34082faafd2mr13216818a91.6.1762097701492; 
 Sun, 02 Nov 2025 07:35:01 -0800 (PST)
Received: from [192.168.0.3] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-340bc3cfbccsm2711669a91.0.2025.11.02.07.34.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Nov 2025 07:35:01 -0800 (PST)
Message-ID: <0c7f155a-3bdb-4d4b-8f2d-3b79eec3cbc2@gmail.com>
Date: Sun, 2 Nov 2025 23:34:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot, v2, 1/1]net: phy: add paged PHY register accessors
To: Marek Vasut <marek.vasut@mailbox.org>, jerome.forissier@linaro.org,
 skylake.huang@mediatek.com, s-vadapalli@ti.com,
 paul.barker.ct@bp.renesas.com, marek.vasut+renesas@mailbox.org,
 u-boot@lists.denx.de
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org
References: <20251006124915.13647-1-lucienzx159@gmail.com>
 <2f894c99-3279-4d8a-8e09-b002a73d85bb@mailbox.org>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <2f894c99-3279-4d8a-8e09-b002a73d85bb@mailbox.org>
X-Mailman-Approved-At: Sun, 02 Nov 2025 18:18:08 +0100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Marek

Marek Vasut 於 2025/11/2 下午 09:59 寫道:
> On 10/6/25 2:49 PM, Lucien.Jheng wrote:
>> Synchronize paged PHY helpers with Linux v6.17.
>>
>> Add support for PHY devices that use paged register access by
>> implementing the following functions:
>> - phy_save_page(): Save current page number
>> - phy_select_page(): Switch to a specific page and return previous page
>> - phy_restore_page(): Restore previously saved page
>>
>> Also adds read_page and write_page callbacks to the phy_driver
>> structure to enable driver-specific page handling.
>>
>> These helpers allow safe access to paged PHY registers by ensuring
>> proper page selection and restoration,
>> even in error conditions, which will be used by the Airoha PHY driver.
> Are there any users ? If not, this is dead code.

I have checked the latest Linux kernel, and these functions are 
currently used by several vendors, including *MediaTek, Airoha, Marvell, 
and Realtek PHY*.

Therefore, I believe these APIs are not dead code.

Thank you.
