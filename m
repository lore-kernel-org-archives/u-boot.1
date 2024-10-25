Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA77D0C601
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34E5A88B0C;
	Fri, 25 Oct 2024 14:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="JEll1HXh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 793938857C; Fri, 25 Oct 2024 14:31:16 +0200 (CEST)
Received: from mail-m12765.qiye.163.com (mail-m12765.qiye.163.com
 [115.236.127.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69EF388F64
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ec47252;
 Fri, 25 Oct 2024 20:30:44 +0800 (GMT+08:00)
Message-ID: <076ad029-7788-4f2f-b3fe-58e61fa8cf51@rock-chips.com>
Date: Fri, 25 Oct 2024 20:30:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu
References: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
 <20240918130155.299353-2-lukasz.czechowski@thaumatec.com>
 <22ae3879-e266-440c-8f25-2d46a5676261@rock-chips.com>
 <c72f7799-5748-4602-bfb2-c99ba767a614@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <c72f7799-5748-4602-bfb2-c99ba767a614@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxkZTVYdTBpKQx4dH04fGU5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c3a85e8c09d6kunmec47252
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxA6PSo*GTIpExcXOAoqEB1R
 IRcaFBlVSlVKTElCQ05CT09OSk5OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTkhINwY+
DKIM-Signature: a=rsa-sha256;
 b=JEll1HXhrXICsLxuoiFWspPw++vDDeftNpBbXTutwQx5P66s8SGVY47zQ9Qab3QCV9FTX3EihjwrreBzr+zLbDS9yv/nhz+2azN6mIBzZ+cPNY3lFTzhFqpCxSuRepsNandCn2HcVtJwdCseW9uYY8UxGVVkgxOa0cBrMLme79E=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=X7q7Y3QgRfO/zEqqunmbi7lW8xULAZoAZGx7T7KvbYk=;
 h=date:mime-version:subject:message-id:from;
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

Hi Tom,

     This is regression of "#ifdef CONFIG", is it possible for us to go 
back to use "#ifdef CONFIG" in this case?

Or do you have any other suggestion for this issue?

On 2024/9/30 16:55, Quentin Schulz wrote:
> Hi Kever,
>
> On 9/29/24 3:53 AM, Kever Yang wrote:
>> Hi Lukasz,
>>
>>      I think this will make the error happen like this:
>>
>> +common/console.c: In function 'puts':
>> +common/console.c:746:29: error: unused variable 'ch' 
>> [-Werror=unused- variable]
>> +  746 |                         int ch = *s++;
>> +      |                             ^~
>> +cc1: all warnings being treated as errors
>> +make[2]: *** [scripts/Makefile.build:257: common/console.o] Error 1
>>
>>
>> The main reason is that below patch removes "#ifdef":
>>
>> c04f856822a console: remove #ifdef CONFIG when it is possible
>>
>
> Can you please always share the link to the pipelines that fail so 
> people have an idea on how to reproduce it locally?
>
> Here I assume it is: 
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/22455
>
> A simple way is to apply the patches, build the pine64-lts for example 
> and then you'll see warnings (which aren't failing builds locally I 
> believe but in CI, yes).
>
> I think we can fool the compiler with the following:
>
> diff --git a/include/debug_uart.h b/include/debug_uart.h
> index dc0f1aa4c98..b19e44d6d0f 100644
> --- a/include/debug_uart.h
> +++ b/include/debug_uart.h
> @@ -204,12 +204,12 @@ void printdec(unsigned int value);
>  #define DEBUG_UART_FUNCS \
>      #warning "DEBUG_UART not defined!"
>
> -#define printch(ch) do{}while(0);
> -#define printascii(str) do{}while(0);
> -#define printhex2(value) do{}while(0);
> -#define printhex4(value) do{}while(0);
> -#define printhex8(value) do{}while(0);
> -#define printdec(value) do{}while(0);
> +#define printch(ch) do{ (void)(ch); }while(0);
> +#define printascii(str) do{ (void)(str); }while(0);
> +#define printhex2(value) do{ (void)(value); }while(0);
> +#define printhex4(value) do{ (void)(value); }while(0);
> +#define printhex8(value) do{ (void)(value); }while(0);
> +#define printdec(value) do{ (void)(value); }while(0);
>
>  #endif
>
> Does this make sense?

Hi Quentin,

     Thanks for your information about pipeline and suggestion for code 
change, but this workaround does not looks good :(


Thanks,

- Kever

>
> Cheers,
> Quentin
