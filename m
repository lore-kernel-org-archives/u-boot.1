Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE91CA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 11:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 912DA8211F;
	Wed, 20 Aug 2025 13:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Eu2NWnXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91B4082B07; Wed, 20 Aug 2025 13:27:02 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32FC1801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 13:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4c6PLB124jz9tfr;
 Wed, 20 Aug 2025 13:26:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755689218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHkenFl21CVKWRGMMVfueNU/B7r5H8+lH413CrRGsl0=;
 b=Eu2NWnXEUB1VsvJpHy3c43l63YLeecT4iOcwlwb0eCbcvj1Rlohi/YSDSpWbMLqjF3fO2g
 1XQPG8vuDwj+L5ojDo2IGmlc8F8J58JRQnIi9XqdwF7pjfuU0KPH2qW22m7lFeStCDf5CG
 6D4Gpch3I+93CW4kLX2a/h4St3OAwLLlAkP4rylfX1u1Rx0qD1TI6mx+i3eUtoGEhditOz
 a8pv17f7QAZrpongZrhy1a2XLeyZuBu54LM21krk8VtowqlP4wrDxruT35bJUBEjBLRRL0
 grrXOd7uiafcvE/RhtdzF8nBglGGl6gPm74I/DhBkz3WRI8OHQvlBaRQmCjkVw==
Message-ID: <4f28a730-3952-4a6e-8f9b-506b588b43e6@mailbox.org>
Date: Wed, 20 Aug 2025 13:26:56 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] misc: fs_loader: Add QSPI RAW partition loading support
To: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250820075351.6455-1-nareshkumar.ravulapalli@altera.com>
 <24b4a185-3575-46ae-8d5d-43fd0902a4f3@mailbox.org>
 <088604a7-3220-4158-a7aa-6e1528b9e38d@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <088604a7-3220-4158-a7aa-6e1528b9e38d@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: jun7j6emj3nteio6gm7443to8i6se164
X-MBO-RS-ID: 0bddb3a89380045c8a3
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

On 8/20/25 1:20 PM, Ravulapalli, Naresh Kumar wrote:
> Hi Marek
> 
> On 20-Aug-25 2:27 PM, Marek Vasut wrote:
>> [CAUTION: This email is from outside your organization. Unless you 
>> trust the sender, do not click on links or open attachments as it may 
>> be a fraudulent email attempting to steal your information and/or 
>> compromise your computer.]
>>
>> On 8/20/25 9:53 AM, Naresh Kumar Ravulapalli wrote:
>>> Enhanced the generic firmware loader to support QSPI RAW partition
>>> loading. This would enable FPGA configuration bitstream loading
>>> from QSPI RAW partition to program FPGA.
>>>
>>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>>> Signed-off-by: Naresh Kumar Ravulapalli 
>>> <nareshkumar.ravulapalli@altera.com>
>>
>> Why not load from UBI on SPI NOR ?
> 
> It is to avoid the storage overhead for metadata and management
> for devices with flash constraints.

What about data integrity , iirc UBI gives you built-in checksums.

-- 
Best regards,
Marek Vasut
