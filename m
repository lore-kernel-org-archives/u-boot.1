Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217BBD49237
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 15:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 916DA88ECB;
	Mon, 18 Nov 2024 16:38:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731944295;
	bh=i0Gv46eVTn+5kphkvb80w4er/Yx02RnNGCncnLTeL2A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mN1QD18WYHswrpuye9GAB/tjn3rElnFNcc5zgcyw+ZPOCOOHfjG3WyqoDim5sDvSk
	 3okYW9LlJSWy9h/V8yC9YP4/JWNrqW5fFi3R7euj4W+nAilImzINy9JNu7vYAXPX0/
	 jISsFlwxyK7DQOd0AECoO81hZci2+7UexWbxcENokDbzDbsEvjk6Y7+5hqESDt/r35
	 LnxYe5N1jVe59VPDAaYbCS5h7UNsQtorv43yWEAPB0zxdsQaGp1LckPrDmQ5oxqW49
	 U0Y8InicPEfooCO7fzl4/t6rKakZAFdReOq2Y2JSvZux9HIWge4ZXxTN+8029yUyj6
	 0WXm8oFLbvNlw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A5C389364; Mon, 18 Nov 2024 16:38:14 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E5CB88C53
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 16:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4XsWwt5QYnz9sbP;
 Mon, 18 Nov 2024 16:38:06 +0100 (CET)
Message-ID: <12768a66-99bd-4668-b927-f8869ecdaca9@denx.de>
Date: Mon, 18 Nov 2024 16:37:57 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 01/20] wdt: imx8qxp: add option to control external
 PMIC wdt via IMX8 SCU
To: Francesco Dolcini <francesco@dolcini.it>, Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andrej Valek <andrej.valek@siemens.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 CL Wang <cl634@andestech.com>, Chanho Park <chanho61.park@samsung.com>,
 Fabio Estevam <festevam@denx.de>, Igor Opaniuk <igor.opaniuk@foundries.io>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Randolph <randolph@andestech.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20241118062715.32989-1-hs@denx.de>
 <20241118062715.32989-2-hs@denx.de> <20241118123139.GA42367@francesco-nb>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241118123139.GA42367@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 18.11.24 13:31, Francesco Dolcini wrote:
> On Mon, Nov 18, 2024 at 07:26:55AM +0100, Heiko Schocher wrote:
>> Driver for a PMIC watchdog timer controlled via Siemens SCU firmware
>> extensions. Only useful on some Siemens i.MX8-based platforms as
>> special SCFW is needed which provides the needed SCU API.
>>
>> Signed-off-by: Andrej Valek <andrej.valek@siemens.com>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
> ...
> 
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 0e45f0a0922..f317d0922cb 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -428,6 +428,13 @@ config WDT_ARM_SMC
>>   	  Select this to enable Arm SMC watchdog timer. This watchdog will manage
>>   	  a watchdog based on ARM SMCCC communication.
>>   
>> +config WDT_SCU_PMIC
> Isn't this a too generic name for something the is platform specific?
> Or this is not Siemens specific? One or the other, I would say.

This is also my only concern right now. If this driver is specific for
a Siemens SCU firmware, then IMHO the Kconfig option and the driver
filename should reflect this.

Thanks,
Stefan

