Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87004D3B7D4
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 18:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B28DB837F2;
	Sat,  6 Dec 2025 19:18:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="VU08Mofl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 874EA839A5; Sat,  6 Dec 2025 19:18:33 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC7B809A5
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 19:18:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 396D74E41A92;
 Sat,  6 Dec 2025 18:18:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 092BE606AC;
 Sat,  6 Dec 2025 18:18:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 40505102F1956; Sat,  6 Dec 2025 19:18:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1765045109; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=KntAam1pk9/fgU0GHYUwLx7EDdpTpCo7DQotlL0soZQ=;
 b=VU08MoflJkQZmitDMweJtqjbFDHMGqJ8ogz61t9YPmVPtP5m3c2+giyNHps6Zch+6ATmTU
 YnfaFvdK6SAH92zcSTLt58tc8OxGHbkJ+4o439yIrh4TZRqF1WJoyzmIlWmV7ItbAdlngl
 rqz2C6krVwGGjVxRDCniL212Rg4WETlfE7PIgYSITSJJc56/N5GRjju1+tKtykBVgCsRCY
 l6ba1zdzhYnqXMzyhkF9DbmN7rXnXD8bhEbcOTwyn6Yw1cjUKJ7CtNuENr8gW3gqsQ6y65
 ZEP54GcZKKUJIFnQmDm+FHdEd+LNbeaTRviKFv3cTVStUq6GAZ6as5K/9YsQog==
Message-ID: <04500684-5d95-4b2b-abf9-32a5a31a9dc4@bootlin.com>
Date: Sat, 6 Dec 2025 19:18:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: stm32f7_i2c: save some ms in
 stm32_i2c_choose_solution
To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Heiko Schocher <hs@nabladev.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de
References: <20251205133641.2052099-1-richard.genoud@bootlin.com>
 <d9943642-1cce-4513-8334-1ba3d675d9da@foss.st.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <d9943642-1cce-4513-8334-1ba3d675d9da@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Le 05/12/2025 à 17:49, Patrice CHOTARD a écrit :
> 
> 
> On 12/5/25 14:36, Richard Genoud wrote:
>> In stm32_i2c_choose_solution, the double loop continues even after a
>> solution is found.
>>
>> Breaking out of this double loop once a solution is found permits to
>> gain some precious ms.
>>
>> This saves about 13ms in U-Boot.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>> ---
>>   drivers/i2c/stm32f7_i2c.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/i2c/stm32f7_i2c.c b/drivers/i2c/stm32f7_i2c.c
>> index 3f51b1dd1db4..cb5e2c0e31e5 100644
>> --- a/drivers/i2c/stm32f7_i2c.c
>> +++ b/drivers/i2c/stm32f7_i2c.c
>> @@ -651,11 +651,13 @@ static int stm32_i2c_choose_solution(u32 i2cclk,
>>   						v->sclh = h;
>>   						sol_found = true;
>>   						memcpy(s, v, sizeof(*s));
>> +						goto end_loop;
>>   					}
>>   				}
>>   			}
>>   		}
>>   	}
>> +end_loop:
>>   
>>   	if (!sol_found) {
>>   		log_err("no solution at all\n");
>>
>> base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
> 
> 
> Hi Richard
> 
> If i have well understood the algorithm, the original implementation selects the *best* solution
> whereas with your patch, the algorithm selects the *first* solution.
> 
> Patrice

Hum, indeed. The solution with the lesser error is selected.
I'll have to study this algorithm a little bit more to see it we can 
take some shortcut.

Thanks!

Regards,
Richard
