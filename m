Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EE8CA0EE4
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 19:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 625D883AEC;
	Fri, 15 Aug 2025 21:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PcE1Il7G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D132283AEF; Fri, 15 Aug 2025 21:07:24 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 977F583AEA
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 21:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4c3Wng2pzpz9sqS;
 Fri, 15 Aug 2025 21:07:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755284839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1wN9YiLHx0/Jwl45/iO1RS5P5H4SYwZzPQOhwZiAhU=;
 b=PcE1Il7GR0J7OTFuDrtUFmTiq8EVvp+8/9fEAExVfjHIfQ2hWNq881tjmMg2ftUkorY8SE
 rkcuuBqpX1UL7+MP3ZOatZRuJKgk4YRa1Ry89WmDgBwtXvmat6bJ8m6EtebmYQHZ/mZJBl
 LyVPiKLk556KtvmFJMzTk2vJDZXJeQXJyrCoPRPKZBaTAYZX6gB1cKc8mAUwcqvwNHSPoP
 ivNafvYjRRkZNRgBIbxFZ0Ze/rfQu0g2Vjecwh/5QXVz9onsBjRNYDozxtOy8n27H9VxlY
 EkfW9lOMMNbsPAloNp0Z5TuFHFCGcytoe/E48vLrsgHol5WOmMk5Kw5mDULPfQ==
Message-ID: <b4df190a-84b7-4c4f-aecf-116b9a1f4899@mailbox.org>
Date: Fri, 15 Aug 2025 21:07:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1] misc: fs_loader: Initialize actread variable
To: Tom Rini <trini@konsulko.com>, alif.zakuan.yuslaimi@altera.com
Cc: u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
References: <20250805024630.24558-1-alif.zakuan.yuslaimi@altera.com>
 <20250815185818.GA55961@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250815185818.GA55961@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6e586aa72e0444916b2
X-MBO-RS-META: dmrjigajzopxk7tfcweoakfdd38jhr6r
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

On 8/15/25 8:58 PM, Tom Rini wrote:
> On Mon, Aug 04, 2025 at 07:46:30PM -0700, alif.zakuan.yuslaimi@altera.com wrote:
> 
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> Initialize the actread variable to prevent undefined behavior
>> that can occur if the variable is used before being assigned a
>> value.
>>
>> This will help to prevent potential issues, especially if
>> actread is used (e.g., read, incremented, or returned) before
>> being explicitly set elsewhere in the code.
>>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>> ---
>>   drivers/misc/fs_loader.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
>> index 66803f4b997..cc07bfa7f14 100644
>> --- a/drivers/misc/fs_loader.c
>> +++ b/drivers/misc/fs_loader.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>    /*
>>    * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
>> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>>    *
>>    */
>>   
>> @@ -148,7 +149,7 @@ static int _request_firmware_prepare(struct udevice *dev,
>>    */
>>   static int fw_get_filesystem_firmware(struct udevice *dev)
>>   {
>> -	loff_t actread;
>> +	loff_t actread = 0;
>>   	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
>>   	int ret;
> 
> A one line "initialize a variable" is not sufficient for adding a
> Copyright line, please drop in v2, thanks.
Technically they already have a copyright line there, they only updated 
the year. This was probably written when altera was intel PSG, now 
altera is altera again, so there are two copyright lines, but it is the 
same group of people.
