Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C04BD44001
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 05:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B75F689500;
	Tue, 19 Nov 2024 06:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731993310;
	bh=4BdFNJkHYOO+4fFNgyd4DR6TV1/yH/4P2FZYw+t5Hgg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=UHxte4IZTh74xjaGOYHfhR4kUz0DtYc1miT7fj8vRmt5oJnwrSW75gL+G/yaSGjMm
	 ll+AsCYcVWZA604PkuxRV35NRxnaxcyDKq1WuoNrdEkPfxtbfW7x9gZqRPJ04Do2MG
	 I9NYbe1CRfvPvLpMt1DBq/T7lS80urZAftHeieXGK+I1xxlRX32Z//+W9AwD9WPoXR
	 qUEMVxAQ+Bsc6XQ2eZRZV1mtZWQbvBDecYmhHPr9gEByzJ7+li04iFpwGcUeN7pwen
	 4MfTfVk7kCqC22YLR4o8OaHJVZNYqDX4K+shMGhQkCeCphVcxx+HMBJiYjKtkJ94eH
	 LUvQ6uKxO+RpQ==
Received: from [192.168.1.107] (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D1B4C88B0B;
 Tue, 19 Nov 2024 06:15:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731993309;
 bh=4BdFNJkHYOO+4fFNgyd4DR6TV1/yH/4P2FZYw+t5Hgg=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=clq6uhe/4xMcv4WbgU8YWYl/HE47yVjkWSUxQ2HTp8MUJzA4BlqTwJLUfhSbAgOLT
 /gxqKL+GUdUjmkfB1jfmkZY5Mgw7LKfgzrDt7Ufyf8J4Ivp4O/SVRJIe4SiRBNCjad
 MDcs9ee/l+rkPlq1SMk/c/rWuJHYVKtjVmqd1+1kJMXGVz9Fg8z7aK5IQkWobCbmqG
 89RrvcSvfOtSKtveNIR5dZTRK2APOEqU7zK+oRE04UHCU90H1whYbET0zA+tRRBPld
 VmcYpB9L2+fCkBkK+r5Cf/+hgaZBuVLa+yVmLJ4C0ObXVS5edKJKVwzRZy3RPv+GkL
 w9GZcU0CDfQtA==
Message-ID: <dcfb4129-cb75-3937-6c89-bf1dd2e1b1bb@denx.de>
Date: Tue, 19 Nov 2024 06:12:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 01/20] wdt: imx8qxp: add option to control external
 PMIC wdt via IMX8 SCU
Content-Language: en-US
To: Stefan Roese <sr@denx.de>, Francesco Dolcini <francesco@dolcini.it>
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
 <12768a66-99bd-4668-b927-f8869ecdaca9@denx.de>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <12768a66-99bd-4668-b927-f8869ecdaca9@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Francesco, Stefan!

On 18.11.24 16:37, Stefan Roese wrote:
> On 18.11.24 13:31, Francesco Dolcini wrote:
>> On Mon, Nov 18, 2024 at 07:26:55AM +0100, Heiko Schocher wrote:
>>> Driver for a PMIC watchdog timer controlled via Siemens SCU firmware
>>> extensions. Only useful on some Siemens i.MX8-based platforms as
>>> special SCFW is needed which provides the needed SCU API.
>>>
>>> Signed-off-by: Andrej Valek <andrej.valek@siemens.com>
>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>
>> ...
>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index 0e45f0a0922..f317d0922cb 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -428,6 +428,13 @@ config WDT_ARM_SMC
>>>         Select this to enable Arm SMC watchdog timer. This watchdog will manage
>>>         a watchdog based on ARM SMCCC communication.
>>> +config WDT_SCU_PMIC
>> Isn't this a too generic name for something the is platform specific?
>> Or this is not Siemens specific? One or the other, I would say.
> 
> This is also my only concern right now. If this driver is specific for
> a Siemens SCU firmware, then IMHO the Kconfig option and the driver
> filename should reflect this.

Yep, I change this in next version.

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
