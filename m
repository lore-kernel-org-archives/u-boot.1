Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40BFCA0EEB
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 12:03:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1693980B9B;
	Thu, 21 Aug 2025 14:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="psZsijIC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EF3C81D5D; Thu, 21 Aug 2025 14:03:23 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF53480548
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 14:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c725g5F4nz9slm;
 Thu, 21 Aug 2025 14:03:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755777799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVlPe5ywCkJzp+tgmwunXeyy86VK1F4W2NONM5U56BM=;
 b=psZsijICoiDLvYS1eXRgl2XjJr9LxZDQSqFGUNFc7fZNwvOEP47jhU1TwssN3XLbi/ZzTo
 /fJ59NMQRhLtxlOUzV8gNQxAGQDyJLM7rvgIUiY963aJ4y+Xcel4hEW2DuH64iuEkpsnff
 ekDwJ/J0v0tvEvtelLlsevdKVlIY8Zm/mDHpOBRr7CTpXUBlGERNiKsArUS/PQ3p1Gnkd8
 5UPCyTG+HT/d8eIodsDJGkic/DQ/NdR3KCSL2WnvIvAiejHc2p5t3UWC8t+u144Vd4JL79
 j7IZxl6bgbJnmGZvGDDwxJ9St/AYsTkc/mldAFhbKHxmtlGbY4gr5n0ShCyxIg==
Message-ID: <6935fd0b-8027-48a0-b9ec-076535d929b9@mailbox.org>
Date: Thu, 21 Aug 2025 14:03:18 +0200
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
 <edcc50c3-4968-494e-9fb1-6acdefd26a53@mailbox.org>
 <c13ee750-2534-4cfa-ac6c-a6a51dec33b1@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <c13ee750-2534-4cfa-ac6c-a6a51dec33b1@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ijtiqq41d8wq1ga5kbe7fdkcj9owcape
X-MBO-RS-ID: 46f83ab35170bac4054
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

On 8/21/25 12:26 PM, Ravulapalli, Naresh Kumar wrote:

[...]

>> How big is the file ? crc32 is weak . Why not use e.g. fitImage for 
>> this ?
>>
>> If this raw loading should be available to users, it should come with a
>> BIG WARNING about data integrity.
> 
> User can use CRC32 and if they require SHA256/512, they can use that as 
> well or any other algorithm as desired.
> 
> RAW partition support is helpful for flash constraint devices especially 
> in a use case where we need to store data as RAW during run-time and if 
> data integrity is required, user has the flexibility to choose 
> respective algorithms like CRC/SHA etc. The whole objective of this 
> patch is to provide that flexibility to the user.
> 
> I don't think we need the BIG WARNING, as RAW data by definition will 
> not have any built-in integrity features and users should exercise 
> caution if data integrity is required. It is mentioned in the enum 
> definition that choosing "DATA_RAW" flag will store data as RAW.

It is not a good idea to use RAW data in the first place, because it 
gives the user false sense of safety, but in reality it can lead to 
silent data corruption. Hence, please add big warning.

Also, how big are your payloads ? You did not answer that question .
