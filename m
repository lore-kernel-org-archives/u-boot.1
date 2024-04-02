Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813CBC6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 11:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB5ED87E75;
	Tue,  2 Apr 2024 13:46:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uBmnoU3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF8AF88094; Tue,  2 Apr 2024 13:46:37 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7F987BC9
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 13:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0765=LH=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1712058380;
 bh=On/vJ6g32QVmyUhdS0bDl5UgGuTt71WTPZVAlhjeoh8=;
 b=uBmnoU3oqUxaa8wDOrZ+skWOsLnasNsFMFpQnzt63R3eEOzwbF/iEHKQK7sG2kqY9I9EQ1XZv
 UMF3eR26iMnTiW+sq+FvPj46slw4NvMXYXPZJTKSVFauzfZmw2Gr6ULy2/L3O2Ot464b2GtyjBz
 +QMLkDkfOLCuXHa/OyEL/T6X+Ik0JAXBmrrBdWt+iaRmkFRayzxWLQKyMbgudhFafq4nXd+fNuW
 3UIh5YNmhLmbHa3CHzJIb/EzzJePU4o/KdP+MKCFpqUNb7ngoNaGX43IqKBjHO6LKRfIFLtOLk2
 z5RZlumDJsk6C75amvYXRlu31TW3Hz4Fhf7WsnA7nkdw==
Message-ID: <ae6da29a-7400-4b3b-a55a-40f74f7e36ae@kwiboo.se>
Date: Tue, 2 Apr 2024 13:46:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/19] rockchip: rk35xx: Sort soc u-boot.dtsi
 alphabetically
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240329190224.3613471-1-jonas@kwiboo.se>
 <20240329190224.3613471-11-jonas@kwiboo.se>
 <fba5eb23-3f52-4e99-9aca-47142189d553@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <fba5eb23-3f52-4e99-9aca-47142189d553@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 660bf00b0244bbe498a4c769
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

On 2024-04-02 12:23, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 3/29/24 20:01, Jonas Karlman wrote:
>> Sort nodes and props in RK356x/RK3588 u-boot.dtsi alphabetically, nodes
>> is sorted by reg addr then by alphabetical order.
>>
>> This has no intended change beside sorting existing nodes and removing
>> a duplicated usbdpphy0_grf node.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/dts/rk356x-u-boot.dtsi  | 100 +++++++++++++++----------------
>>   arch/arm/dts/rk3588s-u-boot.dtsi |  71 ++++++++++------------
>>   2 files changed, 83 insertions(+), 88 deletions(-)
>>
>> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
>> index 05367216e118..a0c630326217 100644
>> --- a/arch/arm/dts/rk356x-u-boot.dtsi
>> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
>> @@ -17,8 +17,8 @@
>>   	};
>>   
>>   	dmc: dmc {
>> -		compatible = "rockchip,rk3568-dmc";
>>   		bootph-all;
>> +		compatible = "rockchip,rk3568-dmc";
> 
> This doesn't follow the kernel's DT coding style:

I will resort these props, this also affects my two similar rk3308 and
rk3328 series.

Regards,
Jonas

> 
> https://www.kernel.org/doc/html/latest/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node
> 
> [...]
> 
>> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
>> index 233eb79d9ba2..e4171bd24d2a 100644
>> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
>> @@ -15,8 +15,8 @@
>>   	};
>>   
>>   	dmc {
>> -		compatible = "rockchip,rk3588-dmc";
>>   		bootph-all;
>> +		compatible = "rockchip,rk3588-dmc";
> 
> Ditto.
> 
> Cheers,
> Quentin

