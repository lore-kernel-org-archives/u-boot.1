Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4E0C0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 05:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F91803CC;
	Tue, 11 Feb 2025 06:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40A2F8043C; Tue, 11 Feb 2025 06:41:52 +0100 (CET)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95D7F800CF
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 06:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpip2t1739252471tc658pn
X-QQ-Originating-IP: MCeD10VHSptM1ypA6JyZ6sinkvw4LOoWP7uojN0aO6o=
Received: from [IPV6:240f:10b:7440:1:3c3b:b254 ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 11 Feb 2025 13:41:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3164559178289811048
Message-ID: <0D55807610EDC0A1+545b9833-1df2-4c9c-80fe-3ef637a9d6ba@radxa.com>
Date: Tue, 11 Feb 2025 14:41:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rockchip: Fix binman error
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, jonas@kwiboo.se, dsimic@manjaro.org,
 pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 ian.roberts@timesys.com, nathan.morrison@timesys.com,
 greg.malysa@timesys.com, bb@ti.com
References: <20250129132529.807031-1-naoki@radxa.com>
 <20250129132529.807031-3-naoki@radxa.com>
 <2d237669-cab8-418c-ad47-0cf936d76a86@cherry.de>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <2d237669-cab8-418c-ad47-0cf936d76a86@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NwsFSQp7kFPKM87M8nX78kuaW/LqKwpW3Xjj0eDawmVw4xZFgFrqUqZG
 DAwfq9ug3kMfxkpOcY3fCvArhlKTbqE9U0JLtoGJbJN4jPuoG/7CHRi8RMoBTgYvaXd8NFZ
 Cd7jypE7uHg19unVQ1mXszdqT0vp4AopXLPlWSCN4j5PAVSxiofvorIQh9rgmMM8tMH19zu
 OtWBj7V8bxefUbPLuvxFvZDaDQ2nHl/96cCB49halxKP1OneKoQSP9/x5YjhYqT8bExOCcZ
 XnM3qHaXdYwsz1DwSVTrotlY0whL/sqqYVtsXTCRqquyB7I7mpSPT7R8OPlUoXspZ1S8Nzh
 7A5afA3JdcseqRS6FJDUZOjx+KCI2/gurYFoIg6c2yV5JJg1pitZUkQPSsZT7e6VMBGHs7H
 7o3bwuvJr1UB4vkdHdA0cIPlSpU8iswGm/hxwi99HVfVTQTwjCAgXpBHyRMDlTEzBAd/ptg
 zqfFNni5Lwu0zO8PLYswfzYHNpNhpRDhfuZvRzUiYFeUNnh2mv15QI96eXLZaQVuhl+rkGs
 YYLwZLM4pPzyWo31QYbNM+HpormJ4qsEUHmFRT0O9c9+eupz8DlNX6w67ky/Q+7lEsGKPY6
 dr3yNQO8OjZycH7GnoP/Wa7K3W6GPO+uQwmhpxZgFRzMxzZw16YEs4xDcocDtrcUGTT24Bu
 ytMyZ+apJU9u8vz+UjyyX7mLtYQ4EdOqwrsdw+TYSAj33eCYZ0hjFD4LLmZBS0l1P/MUv0Q
 48bN6hZ6t2e8/fxHNpUDK3agKv0klAC3idbiO+3TDpkWSXM/4G4NxIAMFIt7wGB+vatTO/t
 HgA9Iw9SSDA4a2UD3NQildM2pWtUOIj82RmIs+bevlZrgP1o9XF5PBlNGWbG0wFj7aAbfaH
 /EYJTTv46zfTLN1X0egQQMjI+lMKHEup3aQNirbji8r68tuEGCjZ/5lTVoe1eO6mEtuOsOg
 gduc=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
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

Hi Quentin,

On 2/5/25 21:59, Quentin Schulz wrote:
> Hi Naoki,
> 
> On 1/29/25 2:25 PM, FUKAUMI Naoki wrote:
>> After adding the below configs, binman produces an error.
>>
>>   CONFIG_SPL_DFU
>>   CONFIG_SPL_ENV_SUPPORT
>>   CONFIG_SPL_USB_DWC3_GENERIC
>>   CONFIG_SPL_USB_GADGET
>>
>> binman: Section '/binman/simple-bin-spi': Symbol 
>> '_binman_u_boot_any_prop_size'
>>     in entry '/binman/simple-bin-spi/mkimage/u-boot-spl/u-boot-spl- 
>> nodtb': Entry 'u-boot-any' not found in list (u-boot-tpl-nodtb,u-boot- 
>> tpl-dtb,u-boot-tpl,u-boot-spl-nodtb,u-boot-spl-dtb,u-boot- 
>> spl,mkimage,fit,simple-bin-spi)
>>
>> Add "no-write-symbols;" to u-boot-tpl and u-boot-spl.
>>
> 
> I'll be frank with you, I have no clue what's happening :)
> 
> But, it seems this only applies to the SPI image (disable 
> ROCKCHIP_SPI_IMAGE and it'll built just fine). Why? No clue.
> 
> I've never liked how the simple-bin-spi was built because we should be 
> reusing artifacts from simple-bin instead of rebuilding stuff. That's 
> why you have /binman/simple-bin-spi/mkimage/fit being a blob, because we 
> want to reuse the fitImage from /binman/simple-bin/mkimage/fit but we 
> didn't do this for the other ones.
> 
> Can you try to revert your patch here and use this instead:
> 
> """
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u- 
> boot.dtsi
> index 70f35b6c197..0a5771b706f 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -45,9 +45,15 @@
>               };
>   #elif defined(CONFIG_TPL)
>               u-boot-tpl {
> +                /* sync with /binman/simple-bin/mkimage/u-boot-tpl */
> +                type = "blob";
> +                filename = "tpl/u-boot-tpl.bin";
>               };
>   #endif
>               u-boot-spl {
> +                /* sync with /binman/simple-bin/mkimage/u-boot-spl */
> +                type = "blob";
> +                filename = "spl/u-boot-spl.bin";
>               };
>           };
>           fit {
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip- 
> u-boot.dtsi
> index c8c928c7e50..fea49eb3145 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -187,9 +187,15 @@
>               };
>   #elif defined(CONFIG_TPL)
>               u-boot-tpl {
> +                /* sync with /binman/simple-bin/mkimage/u-boot-tpl */
> +                type = "blob";
> +                filename = "tpl/u-boot-tpl.bin";
>               };
>   #endif
>               u-boot-spl {
> +                /* sync with /binman/simple-bin/mkimage/u-boot-spl */
> +                type = "blob";
> +                filename = "spl/u-boot-spl.bin";
>               };
>           };
> """
> 
> This seems to work for me on RK3399 Puma and Rock-Pi-4 builds with the 
> symbols you listed enabled. I also believe this should be "better" than 
> what we have today.
> 
> If that works, I'll send a proper patch for this :)

Proper patch please :)

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Cheers,
> Quentin
> 

