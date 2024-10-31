Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EF6E68960
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 09:01:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AEF78928C;
	Thu, 31 Oct 2024 10:01:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="K2sRG77g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FBF289293; Thu, 31 Oct 2024 10:01:56 +0100 (CET)
Received: from mail-m15593.qiye.163.com (mail-m15593.qiye.163.com
 [101.71.155.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A410891E2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 10:01:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 168f7f74;
 Thu, 31 Oct 2024 17:01:46 +0800 (GMT+08:00)
Message-ID: <eb9db3bb-069e-41c1-a6b5-8184e7fd7973@rock-chips.com>
Date: Thu, 31 Oct 2024 17:01:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
To: Quentin Schulz <quentin.schulz@cherry.de>,
 =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 philipp.tomsich@vrull.eu
References: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
 <20240918130155.299353-2-lukasz.czechowski@thaumatec.com>
 <22ae3879-e266-440c-8f25-2d46a5676261@rock-chips.com>
 <c72f7799-5748-4602-bfb2-c99ba767a614@cherry.de>
 <076ad029-7788-4f2f-b3fe-58e61fa8cf51@rock-chips.com>
 <CABd623v=h5SZPcqvH=uoVHyA09RdxuP+mjNUaisOMj7dAm7uTw@mail.gmail.com>
 <aafa4ae3-bce7-41bc-a8db-5fe4171634d4@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <aafa4ae3-bce7-41bc-a8db-5fe4171634d4@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUNLGFZPGkoaTkNDGUIfShhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92e1cf369603afkunm168f7f74
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PC46Dgw5AzIZVksfHjkKMEJK
 OCsKCTNVSlVKTEhLSE1OSEtMTkxNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNSkxINwY+
DKIM-Signature: a=rsa-sha256;
 b=K2sRG77geI5tqV7ly9JT6ffq95D6QUJG2n+m0E5RVnVjFmjfW7Znq5GBKrf/NOR1aoqniSwF5fsMoJo+2YvP4sbrBBvw4Iapq2rPAx19bqul1GuECXUwYuuT0AzJovd3z5ISHKxqpMekmvVeGPr8ohJLskab8GVLBB77ppctEPs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=y7BiD4TyTWf8NcejubLNdtI7LwmZ5GndBlz8ll8n5g8=;
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

Hi Lukasz, Quentin,

On 2024/10/25 22:56, Quentin Schulz wrote:
> Hi Lukasz,
>
> On 10/25/24 4:27 PM, Łukasz Czechowski wrote:
>> Hi,
>>
>> On 2024/10/25 14:30, Kever Yang wrote:
>>>
>>> Hi Tom,
>>>
>>>       This is regression of "#ifdef CONFIG", is it possible for us 
>>> to go
>>> back to use "#ifdef CONFIG" in this case?
>>>
>>> Or do you have any other suggestion for this issue?
>>>
>>> On 2024/9/30 16:55, Quentin Schulz wrote:
>>>> Hi Kever,
>>>>
>>>> On 9/29/24 3:53 AM, Kever Yang wrote:
>>>>> Hi Lukasz,
>>>>>
>>>>>       I think this will make the error happen like this:
>>>>>
>>>>> +common/console.c: In function 'puts':
>>>>> +common/console.c:746:29: error: unused variable 'ch'
>>>>> [-Werror=unused- variable]
>>>>> +  746 |                         int ch = *s++;
>>>>> +      |                             ^~
>>>>> +cc1: all warnings being treated as errors
>>>>> +make[2]: *** [scripts/Makefile.build:257: common/console.o] Error 1
>>>>>
>>>>>
>>>>> The main reason is that below patch removes "#ifdef":
>>>>>
>>>>> c04f856822a console: remove #ifdef CONFIG when it is possible
>>>>>
>>>>
>>>> Can you please always share the link to the pipelines that fail so
>>>> people have an idea on how to reproduce it locally?
>>>>
>>>> Here I assume it is:
>>>> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/22455 
>>>>
>>>>
>>>> A simple way is to apply the patches, build the pine64-lts for example
>>>> and then you'll see warnings (which aren't failing builds locally I
>>>> believe but in CI, yes).
>>>>
>>>> I think we can fool the compiler with the following:
>>>>
>>>> diff --git a/include/debug_uart.h b/include/debug_uart.h
>>>> index dc0f1aa4c98..b19e44d6d0f 100644
>>>> --- a/include/debug_uart.h
>>>> +++ b/include/debug_uart.h
>>>> @@ -204,12 +204,12 @@ void printdec(unsigned int value);
>>>>   #define DEBUG_UART_FUNCS \
>>>>       #warning "DEBUG_UART not defined!"
>>>>
>>>> -#define printch(ch) do{}while(0);
>>>> -#define printascii(str) do{}while(0);
>>>> -#define printhex2(value) do{}while(0);
>>>> -#define printhex4(value) do{}while(0);
>>>> -#define printhex8(value) do{}while(0);
>>>> -#define printdec(value) do{}while(0);
>>>> +#define printch(ch) do{ (void)(ch); }while(0);
>>>> +#define printascii(str) do{ (void)(str); }while(0);
>>>> +#define printhex2(value) do{ (void)(value); }while(0);
>>>> +#define printhex4(value) do{ (void)(value); }while(0);
>>>> +#define printhex8(value) do{ (void)(value); }while(0);
>>>> +#define printdec(value) do{ (void)(value); }while(0);
>>>>
>>>>   #endif
>>>>
>>>> Does this make sense?
>>>
>>> Hi Quentin,
>>>
>>>       Thanks for your information about pipeline and suggestion for 
>>> code
>>> change, but this workaround does not looks good :(
>>>
>>
>> Thanks for the suggestions. I think this code can be even simplified
>> to just i.e.:
>>
>> @@ -204,12 +204,12 @@ void printdec(unsigned int value);
>>   #define DEBUG_UART_FUNCS \
>>          #warning "DEBUG_UART not defined!"
>>
>> -#define printch(ch) do{}while(0);
>> -#define printascii(str) do{}while(0);
>> -#define printhex2(value) do{}while(0);
>> -#define printhex4(value) do{}while(0);
>> -#define printhex8(value) do{}while(0);
>> -#define printdec(value) do{}while(0);
>> +#define printch(ch) (void)ch;
>> +#define printascii(str) (void)str;
>> +#define printhex2(value) (void)value;
>> +#define printhex4(value) (void)value;
>> +#define printhex8(value) (void)value;
>> +#define printdec(value) (void)value;
>>
>>   #endif
>>
>> That will allow us to get rid of warnings. What do you think? I can't
>> think of another method besides creating a lot of #ifdefs in every
>> place debug functions are used, which will look even worse than the
>> dummy macros.
>>
>
> You need to surround value/str/ch with parentheses though.
>
> And we should remove the trailing semi-colon too as we cannot 
> guarantee it won't be used in contexts in which the semi-colon is not 
> allowed.
>
> But I guess that could work? I'm not too verse in C macros so maybe 
> I'm missing some corner-cases.
>
> I think Kever is suggesting we revert the commit he linked earlier so 
> that the functions used by the macros modified in this commit are 
> always defined, just empty. 

At first, what I think first is:

We go back to use #ifdef in the C code, and then we can apply this patch 
directly with below change:

+++ b/common/console.c
@@ -744,7 +744,8 @@ void puts(const char *s)
                 return;
         }

-       if (IS_ENABLED(CONFIG_DEBUG_UART) && !(gd->flags & 
GD_FLG_SERIAL_READY)) {
+#ifdef CONFIG_DEBUG_UART
+       if (!(gd->flags & GD_FLG_SERIAL_READY)) {
                 while (*s) {
                         int ch = *s++;

@@ -752,6 +753,7 @@ void puts(const char *s)
                 }
                 return;
         }
+#endif


Since we need to change code in function puts, then below change looks 
better, :

+++ b/common/console.c
@@ -745,11 +745,7 @@ void puts(const char *s)
         }

         if (IS_ENABLED(CONFIG_DEBUG_UART) && !(gd->flags & 
GD_FLG_SERIAL_READY)) {
-               while (*s) {
-                       int ch = *s++;
-
-                       printch(ch);
-               }
+               printascii(s);
                 return;
         }

But I don't know why use 'printch' at the beginning, maybe try to 
convert "(ch == '\n')" to '\r' which later move into  "_printch", so we 
can use printascii() now.


Thanks,

- Kever

> Is this something you could test? The downside to this is that we 
> would have a lot of unnecessary dead-code with loops calling empty 
> functions instead of just not calling functions at all.
>
> Cheers,
> Quentin
>
