Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16894C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 13:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF3C580EEF;
	Sat, 25 Jan 2025 14:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yjJnM0L6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bQHIxJI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74FDB80C77; Sat, 25 Jan 2025 14:24:18 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7454080EB5
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 14:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YgFl41GFhz9scM;
 Sat, 25 Jan 2025 14:24:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737811456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t6UO0zBwEOJNU/1PK3iOhhSnLuGOZdv8NG8CVNSnBio=;
 b=yjJnM0L6JjA4XaiTJOQ5JebNmTMdZYZ2rSD4JrlJPrp1YAc4sX6sCIifkh9SDq2iY88b+H
 gbAmH2cKq07BbEFg45zzALvpsf2i1/tKJdaW29mNCxycx/BGlxFohbzQ5nvRWs2+lowKhJ
 vf1PAsQ8sI59QcFIZO086OUTG8l5o4Wi/jnb1zSe1GLHY8qbIG7nNIFvTkUzvwMpKFeb9+
 LGsJODqelXnuBNtlcdGsvkTimpqBM+HtwVKybQ4JHGhFX6oqEACnj6IpmhrCEeT5eznx76
 fWg/CCPQjiGTLh135qwRcRyiKJSFoAR22D97JH3Q3TXZF0vEYh1Tgp1DDpLjLQ==
Message-ID: <8aa0fab5-5dea-4c08-9bd7-8f2f248ae4e0@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737811454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t6UO0zBwEOJNU/1PK3iOhhSnLuGOZdv8NG8CVNSnBio=;
 b=bQHIxJI53aeQrvCfMK35+IDUh1htSVa65hoS4DWee7l1aX0tVfmt1uySQj/+Q+Rc8uHh+i
 bKWqLlWIDVtS54ICsg9Lh1HNd/zjzMU17R+ngwh9C2K9FCVLNCKGKBDcwmF5M0IaJF0sae
 b9zKPF6ieph6qsBdRGTodYxf8+J8KfoVDr4VwHy/+rpMo6E2VeXd75j3Qws+W+ku3ct26E
 9nOajfGefWYa5mRhlO6HIXzA7ZZumVDXEC04LShiwzNCLLMvP6Ue8KoXjAHXSdVlMaSmwe
 mqztfUyJOfFNQgCWARdmVn9c2bMMMemqSNzG6c0sIL91/E20oqvb73tTG4d7Pw==
Date: Sat, 25 Jan 2025 13:30:33 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] net: miiphybb: Convert ifdef DEBUG to debug()
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250118061629.125005-1-marek.vasut+renesas@mailbox.org>
 <c150ffbb-57a6-4aae-bfb0-1c680f13e816@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <c150ffbb-57a6-4aae-bfb0-1c680f13e816@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: wmtu5stkq41ahedoid8uog7kwztbxixj
X-MBO-RS-ID: ff4ff7da4e88c698363
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

On 1/21/25 1:03 PM, Paul Barker wrote:
> On 18/01/2025 06:16, Marek Vasut wrote:
>> Replace ifdeffery with plain debug() function call. No functional change.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Adam Ford <aford173@gmail.com>
>> Cc: Hai Pham <hai.pham.ud@renesas.com>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Jerome Forissier <jerome.forissier@linaro.org>
>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>> Cc: Mario Six <mario.six@gdsys.cc>
>> Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Cc: Peter Robinson <pbrobinson@gmail.com>
>> Cc: Ramon Fried <rfried.dev@gmail.com>
>> Cc: Sumit Garg <sumit.garg@linaro.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   drivers/net/phy/miiphybb.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
>> index 171c1719b5b..5497b838225 100644
>> --- a/drivers/net/phy/miiphybb.c
>> +++ b/drivers/net/phy/miiphybb.c
>> @@ -183,9 +183,7 @@ int bb_miiphy_read(struct mii_dev *miidev, int addr, int devad, int reg)
>>   	bus->set_mdc(bus, 1);
>>   	bus->delay(bus);
>>   
>> -#ifdef DEBUG
>> -	printf("miiphy_read(0x%x) @ 0x%x = 0x%04x\n", reg, addr, rdreg);
>> -#endif
>> +	debug("miiphy_read(0x%x) @ 0x%x = 0x%04x\n", reg, addr, rdreg);
>>   
>>   	return rdreg;
>>   }
> 
> While we're here, can we include the bus name in the output to avoid
> confusion when we have multiple buses? Maybe something like:
> 
>      debug("miiphy_read(0x%x) @ %s:0x%x = 0x%04x\n", reg, bus->name, addr, rdreg);
No, not in this patch, but please test:

[PATCH] net: miiphybb: Update debug() print

Is it OK with you if I pick this patch for upcoming release ?
