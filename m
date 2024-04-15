Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C869C04FFE
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B19E887E4D;
	Mon, 15 Apr 2024 13:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TCwWWVw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5112987DDF; Mon, 15 Apr 2024 13:01:05 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1290A87E75
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d27d=LU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1713178823;
 bh=Y6HBW5ilv1TLueifZAByHwLkthdLx4YG9GIYG7N1jE0=;
 b=TCwWWVw8k4jeZ1Mndrl/2xL6h8c7/LiMtRSuWuSf5hlhntp0uWBtR/sC8yo1WbthFdr2PculT
 FI5ESlA4mExZgHbWU1TVtw+7SpMR7jQPpR6A25crmoJq1jNSgBkRKba0Hoq9JTZBFRqhckOZyyG
 tn+cRuVxN53OzmTXQbNPkizs/Zh8uAEwmkgcaUI869IZDksoYiS/Y5wpMvAbVf3ZFuJacEAX9ZD
 xxDPi1dcUALvgqSRXieR5vbgtdlLAs0l/xF5NHl4g1efELMlZ/MKS/qeRCxhpY8PieGs9SfKPv1
 0gXEVHpvsftiXn5AMGHDx3Yul6KkXshVBV7h5Q5PplaA==
Message-ID: <3e1681d6-e682-476d-b2f4-29a34b98e916@kwiboo.se>
Date: Mon, 15 Apr 2024 12:50:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/23] rockchip: rk35xx: Sort soc u-boot.dtsi
 alphabetically
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-11-jonas@kwiboo.se>
 <3d710c01-c602-447d-b652-c9e613e8b3ee@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <3d710c01-c602-447d-b652-c9e613e8b3ee@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661d06730a38760305bd5a9b
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

On 2024-04-15 10:46, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 4/13/24 20:13, Jonas Karlman wrote:
>> Sort nodes and props in RK356x/RK3588 u-boot.dtsi alphabetically, nodes
>> is sorted by reg addr then by alphabetical order.
>>
>> This has no intended change beside sorting existing nodes and removing
>> a duplicated usbdpphy0_grf node.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2: Follow kernel sort order (Quentin)
>>
>> [1] https://www.kernel.org/doc/html/latest/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node
>> ---
>>   arch/arm/dts/rk356x-u-boot.dtsi  | 98 ++++++++++++++++----------------
>>   arch/arm/dts/rk3588s-u-boot.dtsi | 69 +++++++++++-----------
>>   2 files changed, 81 insertions(+), 86 deletions(-)
>>
>> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
>> index 05367216e118..1ecf719202e9 100644
>> --- a/arch/arm/dts/rk356x-u-boot.dtsi
>> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
>> @@ -38,46 +38,10 @@
> 
> [...]
> 
>>   #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>>   &binman {
>>   	simple-bin-spi {
> 
> We could also alphabetically sort the binman node if we wanted.
> 
>> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
>> index 233eb79d9ba2..543327954b1a 100644
>> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
>> @@ -41,6 +41,17 @@
>>   		status = "disabled";
>>   	};
>>   
>> +	vo0_grf: syscon@fd5a6000 {
>> +		compatible = "rockchip,rk3588-vo-grf", "syscon";
>> +		reg = <0x0 0xfd5a6000 0x0 0x2000>;
>> +		clocks = <&cru PCLK_VO0GRF>;
>> +	};
>> +
>> +	usb_grf: syscon@fd5ac000 {
>> +		compatible = "rockchip,rk3588-usb-grf", "syscon";
>> +		reg = <0x0 0xfd5ac000 0x0 0x4000>;
>> +	};
>> +
>>   	usbdpphy0_grf: syscon@fd5c8000 {
>>   		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
>>   		reg = <0x0 0xfd5c8000 0x0 0x4000>;
>> @@ -72,22 +83,6 @@
>>   		};
>>   	};
>>   
>> -	vo0_grf: syscon@fd5a6000 {
>> -		compatible = "rockchip,rk3588-vo-grf", "syscon";
>> -		reg = <0x0 0xfd5a6000 0x0 0x2000>;
>> -		clocks = <&cru PCLK_VO0GRF>;
>> -	};
>> -
>> -	usb_grf: syscon@fd5ac000 {
>> -		compatible = "rockchip,rk3588-usb-grf", "syscon";
>> -		reg = <0x0 0xfd5ac000 0x0 0x4000>;
>> -	};
>> -
>> -	usbdpphy0_grf: syscon@fd5c8000 {
>> -		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
>> -		reg = <0x0 0xfd5c8000 0x0 0x4000>;
>> -	};
>> -
> 
> Would have been nice to at least mention this node is removed because it 
> is duplicated (or have it removed in a different commit to make it more 
> explicit).

I did mention the removal in the commit message :-)

"This has no intended change beside sorting existing nodes and removing
a duplicated usbdpphy0_grf node."

> 
> [...]
> 
>>   #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> 
> What's below this git context is &binman, which we could also 
> alphabetically sort if we wanted.

Was unsure about the binman node, ideally we should not be need it in
the <soc>-u-boot.dtsi file, so I decided not to touch it at all, will
move it in v3.

Regards,
Jonas

> 
> Did the change manually and it matches, so:
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> Thanks!
> Quentin

