Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C64D59F67
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 21:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 774FD88D9C;
	Wed,  6 Nov 2024 22:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sTCMDtu2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 531E28903B; Wed,  6 Nov 2024 22:27:56 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B870E88B1F
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 22:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5449=SC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1730928466;
 bh=dOTDvCh2jcbNtJPgXyczt8k2yIStqo5MQmzjH2fOHqQ=;
 b=sTCMDtu2Wttz7kU3v7yelGl2ZWjnlbEqifZovg6KcgsPH8jrXVfQlqfBGgQn3e2/iLSShP7Xj
 zAKDQqfnQcUhDr95gavPYX9rStvvd7eU+PoY5SYbCNRnun7t0AEyN/ZuJ4iqXxKp48vdx+CljYp
 VWzMzJNDybPb5+yUVINgmUUkUwarWhC8HbuQuV0a3dxA/g82FpbJCQqfoefOjNoG+os6+ZTHntU
 xupiRFpK0sVsFiI/a3cJrZAFUP7vmnIexadwbRZhMyUQHZ5GVKZ6T16tWobc8IzgKC5ylKNfyb/
 h8Ik8fEqj3fJXUsaVaJPV0/+M8/XLa36PlI17iRHb5kg==
Message-ID: <3f63e47c-5086-4d17-847d-6f331c2ae0b6@kwiboo.se>
Date: Wed, 6 Nov 2024 22:27:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rockchip: rk3288: Use rk3288-cru.h from dts/upstream
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20241104205906.986837-1-jonas@kwiboo.se>
 <20241104205906.986837-3-jonas@kwiboo.se>
 <980f5b97-d82b-412c-9450-68271ebc8ac8@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <980f5b97-d82b-412c-9450-68271ebc8ac8@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 672bdf51e997659fa2f4d69a
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

On 2024-11-06 15:35, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 11/4/24 9:58 PM, Jonas Karlman wrote:
>> clock/rk3288-cru.h in include/dt-bindings is almost identical to the
>> version in dts/upstream, remove the copy from include/dt-bindings to
>> only use the version from dts/upstream.
>>
>> One clk, SCLK_MAC_PLL, is not part of the upstream bindings, this clk is
>> not used by any upstream or in-tree DT. For now just ignore this unused
>> clk and only workaround a build issue caused by this removal.
>>
>> No functional change to board DTs is intended with this removal.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   .../clock/rockchip,rk3288-cru.txt             |  61 ---
>>   drivers/clk/rockchip/clk_rk3288.c             |   2 +
>>   include/dt-bindings/clock/rk3288-cru.h        | 381 ------------------
>>   3 files changed, 2 insertions(+), 442 deletions(-)
>>   delete mode 100644 doc/device-tree-bindings/clock/rockchip,rk3288-cru.txt
>>   delete mode 100644 include/dt-bindings/clock/rk3288-cru.h
>>
>> diff --git a/doc/device-tree-bindings/clock/rockchip,rk3288-cru.txt b/doc/device-tree-bindings/clock/rockchip,rk3288-cru.txt
>> deleted file mode 100644
>> index c9fbb76573e1..000000000000
>> --- a/doc/device-tree-bindings/clock/rockchip,rk3288-cru.txt
>> +++ /dev/null
>> @@ -1,61 +0,0 @@
>> -* Rockchip RK3288 Clock and Reset Unit
>> -
>> -The RK3288 clock controller generates and supplies clock to various
>> -controllers within the SoC and also implements a reset controller for SoC
>> -peripherals.
>> -
>> -Required Properties:
>> -
>> -- compatible: should be "rockchip,rk3288-cru"
>> -- reg: physical base address of the controller and length of memory mapped
>> -  region.
>> -- #clock-cells: should be 1.
>> -- #reset-cells: should be 1.
>> -
>> -Optional Properties:
>> -
>> -- rockchip,grf: phandle to the syscon managing the "general register files"
>> -  If missing pll rates are not changable, due to the missing pll lock status.
>> -
>> -Each clock is assigned an identifier and client nodes can use this identifier
>> -to specify the clock which they consume. All available clocks are defined as
>> -preprocessor macros in the dt-bindings/clock/rk3288-cru.h headers and can be
>> -used in device tree sources. Similar macros exist for the reset sources in
>> -these files.
>> -
>> -External clocks:
>> -
>> -There are several clocks that are generated outside the SoC. It is expected
>> -that they are defined using standard clock bindings with following
>> -clock-output-names:
>> - - "xin24m" - crystal input - required,
>> - - "xin32k" - rtc clock - optional,
>> - - "ext_i2s" - external I2S clock - optional,
>> - - "ext_hsadc" - external HSADC clock - optional,
>> - - "ext_edp_24m" - external display port clock - optional,
>> - - "ext_vip" - external VIP clock - optional,
>> - - "ext_isp" - external ISP clock - optional,
>> - - "ext_jtag" - external JTAG clock - optional
>> -
>> -Example: Clock controller node:
>> -
>> -	cru: cru@20000000 {
>> -		compatible = "rockchip,rk3188-cru";
>> -		reg = <0x20000000 0x1000>;
>> -		rockchip,grf = <&grf>;
>> -
>> -		#clock-cells = <1>;
>> -		#reset-cells = <1>;
>> -	};
>> -
>> -Example: UART controller node that consumes the clock generated by the clock
>> -  controller:
>> -
>> -	uart0: serial@10124000 {
>> -		compatible = "snps,dw-apb-uart";
>> -		reg = <0x10124000 0x400>;
>> -		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
>> -		reg-shift = <2>;
>> -		reg-io-width = <1>;
>> -		clocks = <&cru SCLK_UART0>;
>> -	};
>> diff --git a/drivers/clk/rockchip/clk_rk3288.c b/drivers/clk/rockchip/clk_rk3288.c
>> index 43c44fadbe7a..69a2a9429ffd 100644
>> --- a/drivers/clk/rockchip/clk_rk3288.c
>> +++ b/drivers/clk/rockchip/clk_rk3288.c
>> @@ -902,6 +902,7 @@ static int __maybe_unused rk3288_gmac_set_parent(struct clk *clk, struct clk *pa
>>   	const char *clock_output_name;
>>   	int ret;
>>   
>> +#ifdef SCLK_MAC_PLL
>>   	/*
>>   	 * If the requested parent is in the same clock-controller and
>>   	 * the id is SCLK_MAC_PLL ("mac_pll_src"), switch to the internal
>> @@ -912,6 +913,7 @@ static int __maybe_unused rk3288_gmac_set_parent(struct clk *clk, struct clk *pa
>>   		rk_clrsetreg(&cru->cru_clksel_con[21], RMII_EXTCLK_MASK, 0);
>>   		return 0;
>>   	}
>> +#endif
>>   
> 
> I don't really like this.
> 
> Could we simply remove this part of the code in one commit explaining 
> why we remove it (in preparation of syncing the device tree and because 
> there's currently no upstream user of that clock). It would make it much 
> more obvious from simply the commit title that we did something more 
> than simply using the dt-binding upstream header AND also would make it 
> easier to revert if anybody ever needs it.

Will split/add a commit to remove the code for SCLK_MAC_PLL in a v2.

> 
> Another option is to upstream that in the Linux kernel first and then we 
> don't have to work around that issue. That may be a bit more difficult 
> if there are currently no actual (known) users of that clock.

Did a grep for SCLK_MAC_PLL in vendor u-boot, linux 4.4/4.19/5.10/6.1
and cannot find any reference of SCLK_MAC_PLL, beside rockchip-dwmac.txt:

  - assigned-clocks: main clock, should be <&cru SCLK_MAC>;
  - assigned-clock-parents = parent of main clock.
    can be <&ext_gmac> or <&cru SCLK_MAC_PLL>.

Think I prefer to just remove the code from U-Boot :-)

Regards,
Jonas

> 
> Cheers,
> Quentin

