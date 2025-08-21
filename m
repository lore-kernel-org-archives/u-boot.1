Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199A0CA0EF8
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 09:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 506A081D6A;
	Thu, 21 Aug 2025 11:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="E6UVRbLD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C06BD81FEE; Thu, 21 Aug 2025 11:02:46 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B52481D6A
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 11:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c6y5G2XSSz9tPX;
 Thu, 21 Aug 2025 11:02:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755766962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4rRUR7LFQUcmSoTtoC8legf1Hy6eoKBERfZg/JOiSI=;
 b=E6UVRbLDrta6MEsbVikWmfN+J5d05uk4C7EF5SzEMK6uBdhBoolVK2bCc/UNG1u6nx8IhX
 2SSvPQlTBS98LYgIR702RMzjXaatcDGjzi9oL5UyZrYnw3WqnJvFj2+1NDCrXfJ370nABh
 65YiZC5D1xg8XhNcR71hheNNsoFCxgVLc9e7WysrCGlgmwxGsOclFvcYn7lGjHubYxIW1a
 akYaZDmaAO4ceIuqck619bL/f22OsJvhmM27ek8yspsyhDsPcfkHAngkSDF51nGuie60gK
 M1SvwoidtQbNymE9G0/u/iiMo1MP6uucbPQBOzd9m1ipcyqMmIisp7tl74uovA==
Message-ID: <edcc50c3-4968-494e-9fb1-6acdefd26a53@mailbox.org>
Date: Thu, 21 Aug 2025 11:01:37 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] misc: fs_loader: Add QSPI RAW partition loading support
To: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250820075351.6455-1-nareshkumar.ravulapalli@altera.com>
 <24b4a185-3575-46ae-8d5d-43fd0902a4f3@mailbox.org>
 <088604a7-3220-4158-a7aa-6e1528b9e38d@altera.com>
 <4f28a730-3952-4a6e-8f9b-506b588b43e6@mailbox.org>
 <6f4b1dbf-45ea-42d8-8f26-a611ed215d75@altera.com>
 <48d5afec-0508-46d6-b444-117d4a7bfe32@mailbox.org>
 <303a50e6-e670-4456-a23c-cb829bc1dd88@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <303a50e6-e670-4456-a23c-cb829bc1dd88@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 036d68c4b2bf65b11ef
X-MBO-RS-META: 5w4a95zwaochskz58ufyheytonouagtu
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

On 8/21/25 8:26 AM, Ravulapalli, Naresh Kumar wrote:
> 
> Hi Marek
> 
> On 21-Aug-25 1:49 AM, Marek Vasut wrote:
>>
>> On 8/20/25 1:35 PM, Ravulapalli, Naresh Kumar wrote:
>>> Hi Marek
>>>
>>> On 20-Aug-25 4:56 PM, Marek Vasut wrote:
>>>>
>>>> On 8/20/25 1:20 PM, Ravulapalli, Naresh Kumar wrote:
>>>>> Hi Marek
>>>>>
>>>>> On 20-Aug-25 2:27 PM, Marek Vasut wrote:
>>>>>>
>>>>>> On 8/20/25 9:53 AM, Naresh Kumar Ravulapalli wrote:
>>>>>>> Enhanced the generic firmware loader to support QSPI RAW partition
>>>>>>> loading. This would enable FPGA configuration bitstream loading
>>>>>>> from QSPI RAW partition to program FPGA.
>>>>>>>
>>>>>>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>>>>>>> Signed-off-by: Naresh Kumar Ravulapalli
>>>>>>> <nareshkumar.ravulapalli@altera.com>
>>>>>>
>>>>>> Why not load from UBI on SPI NOR ?
>>>>>
>>>>> It is to avoid the storage overhead for metadata and management
>>>>> for devices with flash constraints.
>>>>
>>>> What about data integrity , iirc UBI gives you built-in checksums.
>>>>
>>>
>>> Agree, UBI supports bad block management and other advantages. But
>>> the objective here is to support RAW partition for flash constraint
>>> devices.
>> How is integrity of the data in flash handled in this case ?
> 
> RAW partition support and required data integrity handling is user
> specific. In our case, we are storing CRC32 checksum in flash and 
> computing the checksum on raw data during run time and cross-checking 
> the values.

How big is the file ? crc32 is weak . Why not use e.g. fitImage for this ?

If this raw loading should be available to users, it should come with a 
BIG WARNING about data integrity.
