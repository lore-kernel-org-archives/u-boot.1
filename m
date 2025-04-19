Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2BCC369CF
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 00:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D88C815D1;
	Sun, 20 Apr 2025 02:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745110109;
	bh=UP6gZ1F8MG4WdC40FSVokVdOVGudgMYRGlWa+3rkyQc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PRqwdNMgR5c9UgmiPy2GAR8zrh3M2OFszacszXcsSFGsnrStosg8g70cfU1r9Y4mm
	 RxRxF62xosZz+Zy3xcH0a/6y6KOKgqdBURtxmhOpN9RbqI8ZMKFAsEiepe2EN3WkYE
	 kowr7S6CK9U6eiuz/745ATVQtKn724CUku04yosKZ89ZXk26/vcIyS7Ysq78C2sPTz
	 o0fyw715vN3X6FN7wKSYY5qn+rvdmdXMs/HMNv06FMJW7WUFq0+jDZFJ4lTVH+kUB7
	 jTe+3AU+KRms43zpQD7B32H/ofGvHwNYqWKfeNwf+ybpkWBHAOwjEW5g68YdsekmJy
	 7NZ3OQP78/OTQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB38782103; Sun, 20 Apr 2025 02:48:27 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82598803CC
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 02:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="UtRH/8Te"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1BBDC103B92BE; 
 Sun, 20 Apr 2025 02:48:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745110104; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=UP6gZ1F8MG4WdC40FSVokVdOVGudgMYRGlWa+3rkyQc=;
 b=UtRH/8TeVMf54h9pqW+9k9ZO3IqKY0eWixP0nN44CRxDzqJ4ztwHnFVRgM+8d00SXA0p7F
 kexRM3ezEbpVay6Woa9QMmYVHZswm3bxk5g2Lia+IRT3ihUPofVHM62k9Wri9YL/wGV5Qy
 LToH3bWIPHfDrjg5AnnL7Aax42QSxtQKcyxyLGecB8zgaKz50mDeGWBa1ynIgUz5n6pxVL
 /XyAheYmtRq9omU+P6nDLfUd8ApLYz/GUosf7BMBQwW/+05qEt+CDN2uqc/ThJ22UbttBX
 gb/ruScXNqiQWuSxsG9CvKjFAdvQTSht2f5g7OXRPNCt8kM2ycwtYUOY9S7JNg==
Message-ID: <a4622b5a-0a7a-4897-9960-7d3a74d58892@denx.de>
Date: Sun, 20 Apr 2025 00:51:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Adam Ford <aford173@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, francesco.dolcini@toradex.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
 <CAHCN7xKGOmbj_NAV_XLhdyFX09i7Z_WMgZ-YDhyG3z2N3yF3cA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAHCN7xKGOmbj_NAV_XLhdyFX09i7Z_WMgZ-YDhyG3z2N3yF3cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/19/25 2:59 PM, Adam Ford wrote:
> On Fri, Apr 18, 2025 at 9:53 AM Marek Vasut <marex@denx.de> wrote:
>>
>> On 4/17/25 7:11 PM, Fabio Estevam wrote:
>>> From: Fabio Estevam <festevam@denx.de>
>>>
>>> Currently, fixed-rate clocks in U-Boot are named based on their devicetree
>>> node names. For example, given the following node:
>>>
>>> osc_24m: clock-osc-24m {
>>>        compatible = "fixed-clock";
>>>        #clock-cells = <0>;
>>>        clock-frequency = <24000000>;
>>>        clock-output-names = "osc_24m";
>>> };
>>>
>>> U-Boot registers the clock as "clock-osc-24m", derived from the node name,
>>> ignoring the clock-output-names property.
>>>
>>> This differs from Linux, which uses the clock-output-names property when
>>> assigning clock names. As a result, clock consumers expecting names
>>> like "osc_24m" (as defined in the property) may fail to resolve clocks
>>> correctly in U-Boot.
>>>
>>> Update the fixed-rate clock driver to check for the clock-output-names
>>> property and use it as the clock name if present. If not, the fallback
>>> remains the node name. This makes U-Boot behavior consistent with Linux.
>>
>> This part above ^ is fine.
>>
>> This part below v is wrong .
>>
>>> One concrete impact is on i.MX8MP, where USB clock lookup failed following
>>> commit b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*").
>>>
>>> With this change applied, fixed-clocks are correctly registered with their
>>> expected names:
>>>
>>> u-boot=> clk dump
>>>    Rate               Usecnt      Name
>>> ------------------------------------------
>>>    32768                0        |-- osc_32k
>>>    24000000             5        |-- osc_24m
>>>
>>> This change restores i.MX8MP USB functionality by ensuring the proper clock
>>> names are used.
>>
>> This is wrong, because this is NOT how the clock look up works at all.
>>
>> The lookup works this way. Take for example:
>>
>> drivers/clk/imx/clk-imx8mp.c
>>
>> 240         clk_dm(IMX8MP_ARM_PLL_REF_SEL, imx_clk_mux(dev,
>> "arm_pll_ref_sel", base + 0x84, 0, 2, pll_ref_sels,
>> ARRAY_SIZE(pll_ref_sels)));
>>
>> pll_ref_sels:
>>
>>    21 static const char * const pll_ref_sels[] = { "osc_24m", "dummy",
>> "dummy", "dummy", };
>>
>> the "osc_24m" is looked up in the clock-controller@30380000 clock-names
>> property:
>>
>> dts/upstream/src/arm64/freescale/imx8mp.dtsi
>>
>>    745 clk: clock-controller@30380000 {
>> ...
>>    751         clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
>>    752                  <&clk_ext3>, <&clk_ext4>;
>>    753         clock-names = "osc_32k", "osc_24m", ...
>>                                          ^^^^^^^
>>
>> The offset of osc_24m in that clock-names property is 1 , so the phandle
>> in clocks property array at offset 1 is used to look up those clock:
>>
>>    745 clk: clock-controller@30380000 {
>> ...
>>    751         clocks = <&osc_32k>, <&osc_24m>,
>>                                      ^^^^^^^^
>>
>> Which leads to this clock node in DT:
>>
>>    188         osc_24m: clock-osc-24m {
>>                ^^^^^^^^
>>    189                 compatible = "fixed-clock";
>>    190                 #clock-cells = <0>;
>>
>> The "clock-output-names" is NEVER used for any clock look up.
> 
> For what it's worth, I remove the "clock-out-names" from the device
> tree in Linux, and the Linux driver properly coped with it, but I am
> curious to know what the point of this entry is.

DT schema dtschema/schemas/clock/clock.yaml says:

  82   clock-output-names:
  83     description: |
  84       Recommended to be a list of strings of clock output signal
  85       names indexed by the first cell in the clock specifier.
  86       However, the meaning of clock-output-names is domain
  87       specific to the clock provider, and is only provided to
  88       encourage using the same meaning for the majority of clock
  89       providers.  This format may not work for clock providers
  90       using a complex clock specifier format.  In those cases it
  91       is recommended to omit this property and create a binding
  92       specific names property.
  93
  94       Clock consumer nodes must never directly reference
  95       the provider\'s clock-output-names property.

>>
>> ...
>>
>> I am fine with the first half of the description, but the second half is
>> wrong and this actually does not fix anything. Simply remove
>> clock-output-names from the osc_24m and the code will be broken again.
>>
>> The clk_resolve_parent_clk() is meant to perform the aforementioned
>> resolution(), that is what "[PATCH v2 00/24] clk: Add
>> clk_resolve_parent_clk() and fix up iMX clock drivers" actually fixed.
>> It seems there is something still missing and clk_resolve_parent_clk()
>> does not do the resolution properly for some clock, but that is what
>> needs to be understood and fixed, not worked around this way.
> 
> I added some debug code to clk_resolve_parent_clk it does return
> osc_24m as the name of the clock, but when searching for index, it
> appears to fail.

What exactly fails and where does it fail ?

> Do you have any suggestion on how searching for the
> index can query up the chain to the parent CCM driver on how to return
> the reference to proper clock?  The clock-names property is at the CCM
> parent and not inside the children, and the number of levels vary
> depending on the child clocks, you can't assume the parent's parent
> has the 'clock-name's property.

It is always the clock-controller@30380000 node to which the 
drivers/clk/imx/clk-imx8mp.c is bound , so drivers/clk/imx/clk-imx8mp.c 
does look up in the clock-controller@30380000 node clock-names and 
clocks . And from there on, it is always on phandle to &osc_24m , right ?
