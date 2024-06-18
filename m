Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73094C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 12:01:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE8FB88307;
	Tue, 18 Jun 2024 14:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718712084;
	bh=jVkghSxTvHSI+TZghD5RCn0yT1mK4gLnxLE4q7AfdAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zcXc8h+3g3y5oWX9Pz07Qpy9COc1W6znLRAj4NNsA5Z5o/saNL46iDd09u7hW67XK
	 6zgGkXilK3mtVw/UHqgHhg4cnUQho2id9Mp0rqNpmNMErB22vqItNgL59XWxweo6O0
	 agpPt8FDbK9R+2oi2AzyMMq57m20PjJGhN+2+zkZnwMQlRZaPmwptCIBkXW5Jc2HeL
	 +ufRuP8J9eBLxJ2PtVwCJzGLuGr0qAMujPLssIsMfLek5YG/dYrVH5w2/Wg1dYg/Fh
	 /hQVx8Ebx0PtKnl3GOx0ubZW7Ju8tbyyUM/Ec+ohJEgtQKUbUgOVKsOijpMjH2jQbL
	 4Agqy9Gbxz+bg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7DC71882D4;
 Tue, 18 Jun 2024 14:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718712084;
 bh=jVkghSxTvHSI+TZghD5RCn0yT1mK4gLnxLE4q7AfdAU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=0VBq13hNLZsenOO6b8UOWVLmYDZWiSSsE+ZfQmrH1WCO2FvMgDGMkX5YUTIzNMe10
 4N7DYmfblmwQMFXPjGrW/DxpwoewFjSYUVaM70dVUx5qoCwuIEPCNKn7k7roQRjDrX
 XP8ZQQUBKfyPryZfyypYdL5Mx0HD+ME8C08Fd89KohRljGhZ+d1HrfTxoDqYTvcVye
 XeVnbkpzj7uD0EVyyBnSG/pIUIR++Pk6sBZdtMZ5Rdm0mZxI5K/Q47rzt+sW9I/0xE
 PlBm4HelA5rqUZ1DGSHrmZkniEzN86Y+NtihrB6s+Y8NtLJCQ6a0pmyAAYTHN/U1Yj
 niWIkEGtLsa8w==
Message-ID: <8e31c246-5151-4cbe-8aa0-32199b13ffe0@denx.de>
Date: Tue, 18 Jun 2024 13:49:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] usb: informative message if no controller
To: Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, u-boot@lists.denx.de
References: <20240618081632.29995-1-heinrich.schuchardt@canonical.com>
 <0405e4f048f0cfbfa7f83df2edb82975@manjaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <0405e4f048f0cfbfa7f83df2edb82975@manjaro.org>
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

On 6/18/24 11:44 AM, Dragan Simic wrote:
> Hello Heinrich,
> 
> Please see a nitpick below.
> 
> On 2024-06-18 10:16, Heinrich Schuchardt wrote:
>> The message 'No working controllers found' provides no clue that this
>> refers to USB controllers.
>>
>> Provide a message that refers to USB.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>     add 'found' at end of message
>>     keep printf
>> ---
>>  drivers/usb/host/usb-uclass.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/host/usb-uclass.c 
>> b/drivers/usb/host/usb-uclass.c
>> index a1cd0ad2d66..bd861270af3 100644
>> --- a/drivers/usb/host/usb-uclass.c
>> +++ b/drivers/usb/host/usb-uclass.c
>> @@ -388,7 +388,7 @@ int usb_init(void)
>>
>>      /* if we were not able to find at least one working bus, bail out */
>>      if (controllers_initialized == 0)
>> -        printf("No working controllers found\n");
>> +        printf("No USB controller found\n");
> 
> The plural form, "controllers", should be used instead, because it sounds
> more natural.  I wrote it that way in my earlier response. [1]

The singular controller does make sense in this context, but in the user 
facing print that goes on console, the plural controllers is easier to 
understand. So, yes, please do a V3 with 'controllers'.
