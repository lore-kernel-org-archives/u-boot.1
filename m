Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6769CD128A
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 16:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5623688150;
	Tue,  9 Apr 2024 18:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="axTNm4iV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1904C88155; Tue,  9 Apr 2024 18:08:38 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC1B387527
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 18:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=445b=LP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1712678904;
 bh=uHDzwpG6raMTyiGeab+YY/9uG9UaP4c9zQ8bAUGo2vk=;
 b=axTNm4iVrQA3fh4IB3nvDFph3K84Kh1VkYGZep3nC6jdvTq3VEOLX+jbfSLBzbJn8FjvlymZq
 3A1mYK+qiGnnMd2LFnX9jQAUofmGl1bb/KU2e+WXPdD0NWDycDZrbguCU03q2N9JjKCNW6RBvRu
 C9fTKzRGc5zz00MauG8k7e2CUn5SuParu1fEHwzlzlWr+R/d6Ex5805freHufVUPEUsPmfpASt0
 VI7zp7tQPfU7rAXAZ9xIl2A8qnYA6ZN41AgxpbOcZUeT3SUmQ1J49P3VVPN/ZWH40Y8FBB99gRO
 iD457gPwHIvX764H6W5GmG1rkDENK7gs5ScpJtxq/bbQ==
Message-ID: <5e58212d-2dfd-434d-945e-c6697da1e5bf@kwiboo.se>
Date: Tue, 9 Apr 2024 18:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] rockchip: rk3308: Generate ethaddr based on cpu
 id
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408181429.3676856-5-jonas@kwiboo.se>
 <b568b461-4a21-452f-b91e-92b888941dd9@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <b568b461-4a21-452f-b91e-92b888941dd9@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661567f7e7a102f19b2a9b53
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

On 2024-04-09 17:41, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 4/8/24 20:14, Jonas Karlman wrote:
>> Like other Rockchip SoCs the RK3308 has cpu id programmed into OTP
>> memory. The rockchip_otp driver already support the RK3308 variant.
>> However, the device tree is missing a node to enable use of OTP.
>>
>> Add the missing otp node to soc u-boot.dtsi, enable the rockchip_otp
>> driver and enable use of misc_init_r() to set ethaddr based on cpu id.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2: Add clocks and resets props
>> ---
>>   arch/arm/dts/rk3308-u-boot.dtsi | 16 ++++++++++++++++
>>   arch/arm/mach-rockchip/Kconfig  |  3 +++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
>> index db2c20a7055e..436f66d1b87d 100644
>> --- a/arch/arm/dts/rk3308-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3308-u-boot.dtsi
>> @@ -10,6 +10,22 @@
>>   		mmc0 = &emmc;
>>   		mmc1 = &sdmmc;
>>   	};
>> +
>> +	otp: nvmem@ff210000 {
>> +		compatible = "rockchip,rk3308-otp";
>> +		reg = <0x0 0xff210000 0x0 0x4000>;
>> +		clocks = <&cru SCLK_OTP_USR>, <&cru PCLK_OTP_NS>,
>> +			 <&cru PCLK_OTP_PHY>;
>> +		clock-names = "otp", "apb_pclk", "phy";
>> +		resets = <&cru SRST_OTP_PHY>;
>> +		reset-names = "phy";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +
>> +		cpu_id: id@7 {
>> +			reg = <0x07 0x10>;
>> +		};
>> +	};
> 
> Any plan upstreaming this to the Linux kernel so we can avoid 
> maintaining it in U-Boot?

Yes, I want to get this and some other fixes sent upstream. Will
probably not happen until I have finished up v2 of my other U-Boot
rk3xxx series.

Regards,
Jonas

> 
> It seems supported (the compatible is matched by a driver and there's a 
> DT binding already).
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> Cheers,
> Quentin

