Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1FEC2BA18
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 17:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 427F1882E5;
	Mon, 17 Jun 2024 19:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718644120;
	bh=8Z/M/n/nkkAmDAIN+YiGmlxaOyr7FF+BXd5QUFZiQhQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zQ7q/KksVFg6m93mccIHJmghxjc7IxMfyMMmaZyOej+C7v42uF3/TFiwz98Ar6dtJ
	 IRH0a+OMUq3jxBIIbB/gcz3rttr43rmhRTiL2ZYlVArEHap4G9CxhBasCNLWzrhTA6
	 OWB69Jc7MGzWP2OhdnTnSTRVD+OVJBRfeCqF5UQg5br8QBv1Yo/BA8sTA7Dvby9DsO
	 7RfE9P8K+SAuK0MZyBI6qlbTidxCgMn//fz5Qf0SthO6YVjE88MwYrDUTbhyap3be2
	 WThQOF1aFmCQ7xUkBpNOGd1f9j9lX66FSynqX9EgBA40b2KZ8mCQF9H2vyT/WP//Nn
	 sxOugK53f/ZRg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B02F388254;
 Mon, 17 Jun 2024 19:08:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718644118;
 bh=8Z/M/n/nkkAmDAIN+YiGmlxaOyr7FF+BXd5QUFZiQhQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=yv/nCL3LpSSYVrE7qfG9b5SCzxuKoIqTv+Ik5GEe+JBJc8VQMLLL24xLdhx04Al51
 T1IEgQXfjdMM3ybljYohcsXjLQi/z+gR+i9gB9A1H/teb+8rIb+1Vp6tUPNF0pk1bj
 piaP0wYpGx2Es3HcZeEGgT93HScVgsUw/bSBIuP6xvEiCgl3ce4dkDfWaFFKiP0CiN
 MMbblETwGofhmG8cbMrvyOCInJ97mV9C9Gcyy8ZYHJLQGx2jV78lnTV/jLw+v15i8k
 8T3oTQQV3BF67MnTwwRariPljn5s0u3lCTKMlUNCWD2M30UWELLOfepV7as6MJQcrX
 Otx3YevLIXTLQ==
Message-ID: <fdfa184c-f7a6-4eb1-8e33-8e347748532c@denx.de>
Date: Mon, 17 Jun 2024 16:52:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] usb: informative message if no controller
To: Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
References: <20240617081654.74294-1-heinrich.schuchardt@canonical.com>
 <f75f053e1fc43307f239451e85dc13fe@manjaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <f75f053e1fc43307f239451e85dc13fe@manjaro.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/17/24 10:20 AM, Dragan Simic wrote:
> Hello Heinrich,
> 
> On 2024-06-17 10:16, Heinrich Schuchardt wrote:
>> The message 'No working controllers found' provides no clue that this
>> refers to USB controllers.
>>
>> Provide a message that refers to USB. Use log_info().
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>  drivers/usb/host/usb-uclass.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/host/usb-uclass.c 
>> b/drivers/usb/host/usb-uclass.c
>> index a1cd0ad2d66..e16432a1516 100644
>> --- a/drivers/usb/host/usb-uclass.c
>> +++ b/drivers/usb/host/usb-uclass.c
>> @@ -388,7 +388,7 @@ int usb_init(void)
>>
>>      /* if we were not able to find at least one working bus, bail out */
>>      if (controllers_initialized == 0)
>> -        printf("No working controllers found\n");
>> +        log_info("No USB controller\n");
> 
> It would be better to use "No USB controllers found" as the error message,
> because it reads better and provides additional clues.

Yes, that is indeed better. Also, please keep the printf() and do the 
log_info change in separate patch.
