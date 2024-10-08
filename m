Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098C8CED276
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 08:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E5CD88E35;
	Tue,  8 Oct 2024 10:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="HmyKb0r4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FBDD88995; Tue,  8 Oct 2024 10:21:12 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59AC9885D1
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 10:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1914=RE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1728375659;
 bh=1UwNWNIC58KzyreIoOMC8lkh9xnJR1Ap750ly1KESuo=;
 b=HmyKb0r4wg6Q7VngT6LZZE+hZ5/2quzieWvDPeTr3ifBYB6cIIjBUAlCzxwMRsRNeK4fPB4CS
 l2jHR3X2kiNUdxLm4vxMVvQOCEJiWFh9F6FVo6hsFbb+De2QTiJTuuPGpn+0Rn8M5xefCBcWQtu
 2hxnaHTZ+Ga3Fl9iAW12YOr8NSQgTS83y90LzX+6QXoFBfB/MscgiacQIk1TvMtmhu9hRXf0n8J
 +sPGSe1/S0rU+0csg2AOW+TfkAsoXJyDqpKg+rp7/o42DkEEXLWxHDJQbCZ4nX3mBn0DgkA+4jF
 qe2ZrLfXSzjfD8Q3PW5pneftJ3muyw5t3QPDzfMhpGKQ==
Message-ID: <b193a229-f0e8-45af-af9e-85ca430f9388@kwiboo.se>
Date: Tue, 8 Oct 2024 10:20:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: dw_mmc: Fix FIFO data transfer timeout
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20241008003503.1914718-1-jonas@kwiboo.se>
 <PAXPR04MB8459C3B35ECF12A0707132E8887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <PAXPR04MB8459C3B35ECF12A0707132E8887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 6704eb6abfcc2ccfc4b9c970
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

Hi,

On 2024-10-08 03:19, Peng Fan wrote:
>> Subject: [PATCH] mmc: dw_mmc: Fix FIFO data transfer timeout
>>
>> The commit 0252924ac6d4 ("mmc: dw_mmc: Extract FIFO data
>> transfer into a separate routine") unintentionally changed behavior of
>> the FIFO data transfer routine.
>>
>> When data is read and size reaches 0 the original loop would wait on
>> DWMCI_INTMSK_DTO or timeout. The remaining size to read is no
>> longer tracked across dwmci_data_transfer_fifo() calls and because of
>> this an extra call to fifo() and dwmci_fifo_ready() may now trigger a
>> FIFO underflow timeout.
>>
>>   Buswidth = 4, clock: 50000000
>>   Sending CMD16
>>   Sending CMD17
>>   dwmci_fifo_ready: FIFO underflow timeout
>>   Sending CMD16
>>   Sending CMD18
>>   dwmci_fifo_ready: FIFO underflow timeout
>>   Sending CMD12
>>   ## Checking hash(es) for config config-1 ... OK
>>
>> Restore old behavior and track remaining size to read across calls to fix
>> this.
>>
>> Fixes: 0252924ac6d4 ("mmc: dw_mmc: Extract FIFO data transfer into
>> a separate routine")
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> LGTM: Reviewed-by: Peng Fan <peng.fan@nxp.com>

Thanks, however after looking at this with fresh eyes a full revert of
the offending commit may instead be a better option.

The target/source buf is also not carried over and is reset for each
call to fifo(), not sure if resuming a read or write is even
needed/useful/wanted/possible.

I will send a v2 with a revert of the offending commit later after more
testing. Someone can then take a new look at refactoring FIFO handling.

Regards,
Jonas
