Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FFDF53D76
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 16:53:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E50E684113;
	Mon, 16 Mar 2026 17:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wSmVkMUL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C0C884118; Mon, 16 Mar 2026 17:53:52 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BF7C8410D
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 17:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fZLlH5Nphz9tyy;
 Mon, 16 Mar 2026 17:53:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773680027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=24gcYTwvmbyTURxrSTmLEkI1LxX3Eq0TiMkU6PvVeLc=;
 b=wSmVkMULDiLz2mDAr5dtR6YFB8ZMwok2vApewtcUhn2/q8pZeqkfbwGaQEXdOumAr07byr
 JkQGhYadLGYFCqMZ5Ado5HO3GWBsKwzTfmkoClbwipwjkSbEItaDaoPrkiZrcVoaKridn2
 g81Amb99YntW86d2b/VPhbjmeJiAbeiTXXzsehF2dsiTF7bgugPbNL3xfzBvQY1l05wVN0
 5W6JNDEV12fCZ97GsM0LnEDXxGnEr58P/mEO2qTFPGKBfzdr/tbhHRWxYQkiR/EJpDTO4m
 ZOOLfH9JWd3nQY8iXJO4Toh3E4MhraFymB/ZDkC0W05dlTk/GPFQ7dFi6r0cDQ==
Message-ID: <b1f8bc9f-13fe-4931-a6b3-ae494632dd77@mailbox.org>
Date: Mon, 16 Mar 2026 17:53:44 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] arm: relocate: Introduce data-only relocation mode
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Udit Kumar <u-kumar1@ti.com>
References: <20260315235510.304677-1-marek.vasut+renesas@mailbox.org>
 <20260316145027.GK502704@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260316145027.GK502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 932213f73acbac3f5a6
X-MBO-RS-META: gkzt466srf1ejgpo5g8nddhijkfmnfhc
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

On 3/16/26 3:50 PM, Tom Rini wrote:

Hello Tom,

>> +config SKIP_RELOCATE_CODE
>> +	bool "Skips relocation of U-Boot code to end of RAM"
>> +	help
>> +	  Skips relocation of U-Boot code to the end of RAM, but still does
>> +	  relocate data to the end of RAM. This is mainly meant to relocate
>> +	  data to read-write portion of the RAM, while the code remains in
>> +	  read-only portion of the RAM from which it is allowed to execute.
>> +	  This split configuration is present on various secure cores.
> 
> Is this really configurable, or is this determined by the SoC? This
> feels like something a board should be select'ing rather than
> configuring and I do worry about boards abusing this in the same of some
> possibly dubious speed-up rather than the intented and valid use case.

On R-Car X5H, the Cortex-M core U-Boot port selects this, the Cortex-A 
core U-Boot port does NOT select this. So, this is neither SoC level 
configuration nor board level configuration, this is SoC CPU core level 
configuration. I can definitely hide this symbol and conditionally 
select it on SoC level.

> [snip]
>> diff --git a/arch/arm/lib/relocate.S b/arch/arm/lib/relocate.S
>> index 6ee58f4edfe..b6a648708f4 100644
>> --- a/arch/arm/lib/relocate.S
>> +++ b/arch/arm/lib/relocate.S
>> @@ -79,6 +79,15 @@ ENDPROC(relocate_vectors)
>>   ENTRY(relocate_code)
>>   relocate_base:
>>   	adr	r3, relocate_base
>> +
>> +#ifdef CONFIG_SKIP_RELOCATE_CODE
>> +	mov r4,	#CONFIG_SKIP_RELOCATE_CODE_DATA_OFFSET
> 
> Spacing. But if there's no other comments and propmting the user is
> correct, I can fix when applying.
Fixed in V2 .
