Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196C7E7BD83
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 10:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57D9C802C1;
	Mon, 16 Feb 2026 11:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="M8N2fEEw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD2D8063E; Mon, 16 Feb 2026 11:53:16 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F58180086
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DED351100B1; Mon, 16 Feb 2026 11:53:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771239187;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=q3toNFzVNlPqLEuHKg1NMN8Hr6ogT5jc7E+4JTCBDlE=;
 b=M8N2fEEwbzeN4H48bV7qU0nPFWfcB6b8zkdJ7FvfmWQT+y5iISKHQLOm1jW57Tcqmel2QR
 ytzmrkKraiDCdmlLQRwmcaNOmfcBskxxG7bjfCJ06hYMKPqVN2yUp9rg4vRbv83clHwLkp
 Ua6zNMqV8mQn5F7SeEfsQgmvYwnrqLCGRmKQ7NPSdwlIhctBvq3XSLcvQPxk8q1duUA7Dp
 oZy+OJe/pdvCC+TdkrZIIRlvmL22UkR/cL2foI0tDnV7J3MeAlkGw2l2yci3kvpyOYdN0H
 yszdoy6O3yE3e35l91bsWoxRspC7rdUCRJa0lEByTYBfemoM3kPg/aw5QlgDMA==
Message-ID: <2a270c8b-60a0-73eb-5f1e-e149970cf97e@nabladev.com>
Date: Mon, 16 Feb 2026 11:53:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 05/11] imx8qxp_capricorn config: add wget command
Content-Language: en-US
To: Marek Vasut <marek.vasut@mailbox.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Walter Schweizer <walter.schweizer@siemens.com>, Peng Fan
 <peng.fan@nxp.com>, Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20260214045703.28051-1-hs@nabladev.com>
 <20260214045703.28051-6-hs@nabladev.com>
 <1a1b9dc9-0ad5-43b9-a8b7-fefb1eb6277d@mailbox.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <1a1b9dc9-0ad5-43b9-a8b7-fefb1eb6277d@mailbox.org>
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

Hello Marek,

On 16.02.26 11:15, Marek Vasut wrote:
> On 2/14/26 5:56 AM, Heiko Schocher wrote:
>> From: Walter Schweizer <walter.schweizer@siemens.com>
>>
>> Faster than tftp.
> 
> The commit message could use an improvement .

changed to
"""
We enable the wget command since it is faster than TFTP transfers.
"""

> 
>> Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
>> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>> ---
>>
>> Changes in v2:
>> Added Reviewed-by from Peng
>>
>>   configs/imx8qxp_capricorn.config | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/imx8qxp_capricorn.config b/configs/imx8qxp_capricorn.config
>> index 62babf2626f..b5c9fdbc9b3 100644
>> --- a/configs/imx8qxp_capricorn.config
>> +++ b/configs/imx8qxp_capricorn.config
>> @@ -73,6 +73,7 @@ CONFIG_CMD_CPU=y
>>   # CONFIG_CMD_CRC32 is not set
>>   # CONFIG_CMD_BIND is not set
>>   CONFIG_CMD_WDT=y
>> +CONFIG_CMD_WGET=y
> Do you also have CONFIG_PROT_TCP_SACK=y enabled ?

No, I see in .config:

CONFIG_PROT_TCP=y
# CONFIG_PROT_TCP_SACK is not set

doc says:
"""
TCP Selective Acknowledgments in the legacy network stack can be enabled via
CONFIG_PROT_TCP_SACK=y. This will improve the download speed. Selective
Acknowledgments are enabled by default with lwIP.
"""

Ah, thanks for the hint!

@Adrian @Walter: May you can test this if it speeds up wget?


> Also, keep in mind, if/once you will switch to LWIP, the wget command syntax changes sightly (sigh).

Uff...

Thanks for the review!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
