Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4024CEB2F1
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 00:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F12FB83A6A;
	Sun, 16 Nov 2025 01:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wYYOl5IH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="G+Sa3L2d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B558839E4; Sun, 16 Nov 2025 01:20:18 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1326E839E4
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 01:20:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d8BNH4gT8z9tKR;
 Sun, 16 Nov 2025 01:20:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763252415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+p8b4ziXlLex5P8c+3SZZcF7/uq1FK/9xWYPzk3YIYY=;
 b=wYYOl5IH8DO5ybJqCa30U70xvpT/LLjITqUfDXyTVhjHXFWgX6/jfx78zt6pnkFSXJ9pcg
 WSgtSD+TYnZdVl8Dzytknl8qL1HfYIEN+hZN/cB7v2DLHLGH29PnIxNyfWSAYGxp+p1IHI
 aRKmdqGr9QrCDoafNFKhatU6AVjpic3AfDbj+11D3ZksJgilWH2LRCw+utCk3dS1/tHPXw
 h4GTgL64bJxyw/Rr5P7TGh59m4ZaUlHDOtxH9j4jbP6hjdsGkuaSzy0NCHzBEsYCbv6DmH
 7fJ2I25DpDfyygsL9+jQKCFQbiqlTrzDoAewXntSnjFI4uBjlUB95KofIPpioA==
Message-ID: <07424e88-16f8-4332-b93c-f0baeed5758c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763252413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+p8b4ziXlLex5P8c+3SZZcF7/uq1FK/9xWYPzk3YIYY=;
 b=G+Sa3L2dP9Jt7d7gAPoFwSerjw782AJs7qvgMVP0FBNJ3sdqvA3XNoJORSTCUFzdp9qzcm
 HLvfPjlfCb9yBJpFPa41vtLbeNOWWY+ocXKWgL+w+qOmruUBttZM1F6qyiLo3t3TrF4CR1
 B+wjMlsns2inoag541g4RxITdP1wB45VmRL9TIYqgFwJFPPM3wlItKsspV+9HDf68WEUqN
 ckHSlesUMQbghdlUMcnc/34LVCiNriaBu0PUg0ekylgQ/LCagwh8RhEWaOjE+PeLsa/1GX
 XOj4LHaABG9vYwSlf5CyAUrwirh0IDBYz7vI6AFW6ddWpVf5jOLnOw/KBuRvcA==
Date: Sat, 15 Nov 2025 18:34:24 +0100
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH] boot: Warn users about fdt_high=~0 usage
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20251113142957.1069909-1-marek.vasut+renesas@mailbox.org>
 <20251113154900.GJ6688@bill-the-cat>
Content-Language: en-US
In-Reply-To: <20251113154900.GJ6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b9e38c48c60d2da46e5
X-MBO-RS-META: qtthrwkffm66mupajronoasaeyodaqim
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

On 11/13/25 4:49 PM, Tom Rini wrote:

Hello Tom,

>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>> index 3f0ac54f76f..e88525a3846 100644
>> --- a/boot/image-fdt.c
>> +++ b/boot/image-fdt.c
>> @@ -189,6 +189,10 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
>>   			/* All ones means use fdt in place */
>>   			of_start = fdt_blob;
>>   			addr = map_to_sysmem(fdt_blob);
>> +			if (addr & 7) {
>> +				printf("WARNING: The 'fdt_high' environment variable is set to ~0 and DT is at non-8-byte aligned address.\nWARNING: This system will likely fail to boot. Unset 'fdt_high' environment variable and submit fix upstream.\n");
>> +			}
>> +
>>   			err = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &addr,
>>   					    of_len, LMB_NONE);
>>   			if (err) {
> 
> I think we need to yell about it sooner.

I don't think so, for two reasons:

- If the user uses e.g. bootz to boot their kernel, which on arm32 is 
still sadly happening, they wouldn't trigger this problem at all and 
they wouldn't care about whichever way their fdt_high is set.

- If the user sets 'fdt_high' as part of their boot command, they would 
not get any warning print if we warn earlier, but they would get one 
when they boot and trigger this affected code path.

Maybe we need warnings in two locations ?

> Today (and for quite some
> years) if you pass a 4 byte and not 8 byte aligned DT to Linux, it fails
> to boot or breaks in loud

Worse, not loud, but silent.

> and odd ways. This has in turn lead to much
> time spent and some of our older threads with the libfdt folks years
> ago. So I think we need something earlier in code where we're seeing
> that fdt_high is set to ~0 and that's where we say "Stop doing this, it
> will be removed soon".

We cannot remove this functionality, someone might actually depend on it 
for whatever reason. It is part of the command line ABI now.

[...]
