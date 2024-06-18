Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69699C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 17:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6FD58812C;
	Tue, 18 Jun 2024 19:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="fvzt+bmq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D32687F5C; Tue, 18 Jun 2024 19:40:44 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA2A1882D4
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 19:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1718732440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vqPvypzl1mcANIafztZp+8OeYABkvo12FCkG201h2BA=;
 b=fvzt+bmqaPThAtQKHYt4LGRYlfIRuNvfvYXfKXdUVjjI4d2c/cJK26ice0S7OSeijQMbr1
 hAMv5QpVv9LrTxc+fZ5TUwTnG+MVivPdJEeV3SGX42hRApzj+Q3IW9wuGbyNPe4NARzZZp
 j/mxD4MsR9mblmurmhKM56l3TiW96P3s94/85M36h88BZHTDsbCJym5J2sinbOIQuKTgC5
 AAaSeTJrBVtZi/22nDbn7jCD8UVBOsoPsTXcWG90tVsnY1gxsYfCh+8JxwF0Rlutw9Wxfy
 YmFDcaA1U4oujocPOtNyQogoCal99+Esg6CnrJhaDDQNA2kMU6fb7/l4tpgndg==
Date: Tue, 18 Jun 2024 19:40:39 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/1] usb: informative message if no controller
In-Reply-To: <0a7c5e5c0d75e1ce41227371c78e268e@manjaro.org>
References: <20240618095857.58088-1-heinrich.schuchardt@canonical.com>
 <0a7c5e5c0d75e1ce41227371c78e268e@manjaro.org>
Message-ID: <7ddb7a8ffad9a4bc7b407b13948f944e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-06-18 12:04, Dragan Simic wrote:
> On 2024-06-18 11:58, Heinrich Schuchardt wrote:
>> The message 'No working controllers found' provides no clue that this
>> refers to USB controllers.
>> 
>> Provide a message that refers to USB. Use log_info().

Huh, I missed the "use log_info()" part.  The patch description should
be adjusted not to mention it, and there should be another patch that
switches printf() to log_info().

>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> Thanks for rerolling this patch.  Looking good to me.
> 
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> 
>> ---
>> v3:
>> 	plural controllers
>> v2:
>> 	add 'found' at end of message
>> 	keep printf
>> ---
>>  drivers/usb/host/usb-uclass.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/usb/host/usb-uclass.c 
>> b/drivers/usb/host/usb-uclass.c
>> index a1cd0ad2d66..e16432a1516 100644
>> --- a/drivers/usb/host/usb-uclass.c
>> +++ b/drivers/usb/host/usb-uclass.c
>> @@ -388,7 +388,7 @@ int usb_init(void)
>> 
>>  	/* if we were not able to find at least one working bus, bail out */
>>  	if (controllers_initialized == 0)
>> -		printf("No working controllers found\n");
>> +		printf("No USB controllers found\n");
>> 
>>  	return usb_started ? 0 : -ENOENT;
>>  }
