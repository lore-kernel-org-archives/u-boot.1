Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F9DD70E16
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 03:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 390BA8938A;
	Fri, 29 Nov 2024 04:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732851973;
	bh=FnX0YDtu6TAxWEj3QroG98YlehfUAl3uqu2IcL5J8lw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mZzI8RC7xlZXepWUCtrC1f6+EVJ+ic8uCyfX0eZrYYHNOBEJSPcmkx1E5iTVROWmD
	 LilT4aUGB4F2JOYlNfQ8gh4oRPjeQ8O33k5ijZemEAH3RgeQKqYe614AZfcIUqp6Ro
	 MH7MQCdF6fMYUQ6I/EZM8xPWCxZXRFH6Nq+P/arSpdgB5fNvLOjESMpbTOY8fVWER0
	 qgAuwTd+GE1cLafXU/7VVyN/m8gf9RzgX+U2Bt2dXXvaMFmXARUkvF3hutiDxxFTKj
	 rvRo+ocywgI1aznvPZFDdZu4UXMI1jTjeUjlS2w1wfQKzN+Ds+mQe+Hhyzk0jHcPOz
	 1ZiExNsM6ooSA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B8BB78920C;
 Fri, 29 Nov 2024 04:46:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732851972;
 bh=FnX0YDtu6TAxWEj3QroG98YlehfUAl3uqu2IcL5J8lw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SFfXeWVSLdIJTQ242JD82Rk85LLqOe7ILr02q5RBJzOCgWoCTQXSxEjH+F24+fU9g
 ycQ60sHlBw7CrQVnv/lLrZH7dcNt/FVoAA1EMQuVmO0fssP6ZPEanlSlcfOx3W3wl6
 +qjoYv922hxdh6jan+dqoSnBEwOFgjNznkwwOcT+0fdoy1be3P3eVhFA2qqDOeCuwQ
 M82MDoimv8kdBCeeg9VU4ZNAygDcHExHW3q23AJWPvfEysanEdO3LQp2aT+pSd+ode
 HMEUVX6hPHwRS4vi8Gy6XJNOlYRMztPCZbfbh9TtowLEut3jh+tvEVtXZFpZs7Zmhe
 Hnt9GXjdbrtmw==
Message-ID: <3205bf0b-0182-42ce-9fd4-465bc35d1b8b@denx.de>
Date: Fri, 29 Nov 2024 04:13:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ARM: dts: imx: Make DRAM coding GPIOs available in
 all phases on Data Modul i.MX8M Mini/Plus eDM SBC
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20241128032623.269459-1-marex@denx.de>
 <d1218a1a-ee2b-4db7-9675-5db6f440bab4@cherry.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <d1218a1a-ee2b-4db7-9675-5db6f440bab4@cherry.de>
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

On 11/28/24 12:48 PM, Quentin Schulz wrote:
> Hi Marek,
> 
> On 11/28/24 4:25 AM, Marek Vasut wrote:
>> The DRAM configuration GPIO straps must be accessible in all boot phases
>> because the GPIOs are sampled both in U-Boot SPL as well as early on in
>> U-Boot proper. The already present bootph-pre-ram DT property made the
>> GPIO controllers available in SPL, but not early on in U-Boot proper,
>> which made gpio_request_list_by_name_nodev() in board dmo_get_memcfg()
>> fail. Add missing bootph-all DT property to all GPIO controllers which
>> are referenced in dmo,ram-coding-gpios DT property to make those GPIO
>> controllers available early in U-Boot proper as well.
>>
>> Fixes: 8c103c33fb14 ("dm: dts: Convert driver model tags to use new 
>> schema")
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
>> Cc: Fabio Estevam <festevam@gmail.com>
>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>> Cc: Sean Anderson <seanga2@gmail.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Stefano Babic <sbabic@denx.de>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>> NOTE: For v2025.01
>> ---
>>   arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi | 1 +
>>   arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi | 2 ++
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi b/ 
>> arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
>> index a235e088fa4..babe51ebdc1 100644
>> --- a/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
>> +++ b/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
>> @@ -77,6 +77,7 @@
>>   &gpio2 {
>>       bootph-pre-ram;
>> +    bootph-all;
> 
> aren't those supposed to be bootph-some-ram for matching U-Boot proper 
> pre-reloc? bootph-all would enable it in TPL as well (if there's one on 
> imx8mp).
> 
> https://docs.u-boot.org/en/latest/develop/driver-model/design.html#pre- 
> relocation-support
> 
> If not, isn't bootph-pre-ram implied when bootph-all is selected?
Fixed in v2 via bootph-some-ram , thanks .
