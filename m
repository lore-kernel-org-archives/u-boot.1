Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9B1C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 11:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2ABE83689;
	Wed,  9 Apr 2025 13:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="WoteJlg/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A1D483692; Wed,  9 Apr 2025 13:35:37 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 685C88327A
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 13:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6bf1=W3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744198533;
 bh=no1myVbPQTDPdSWgT3rBmfkstb46mlGk2w2XOt9zcYw=;
 b=WoteJlg/lBbebxyMNz6bC9kYAonLIJZrOkb9GAj0W/d9vCmR6xBgkLFxUkuMrlUzotncrB5cF
 cFFPgVSgaJq8tPjSZW991jjo6Cc5iMPLSHP7s/7FeesAAYxwaKF4RWPq4FVAtQrxTAQrJA2xrFP
 4vH8zlUcN871jY6WjVUzD6w+yxwbfhHAluAXLZD8CAAXkH3xHl2VP8qQlqQRKKcuYEqVEqP1Ckt
 RRpr2B/5gU4uk6LTQwsqJYuE9pLQSRUGyEM5IvHvnCbFjBwz1leTV+HbTkuEzHTjcJZaQVef+PH
 GD0HoDKs7f3LUBr4tLkB0febHsS2Zg63jMDecpoXJHfQ==
X-Forward-Email-ID: 67f65b8202fba845dcdf29a2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <6921562d-702a-478c-a00b-be71576c8d66@kwiboo.se>
Date: Wed, 9 Apr 2025 13:35:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] rockchip: binman: Correct the OS prop for U-Boot
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-2-jonas@kwiboo.se>
 <5a2d27ee-f732-450d-9a80-fedc8b2acec9@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <5a2d27ee-f732-450d-9a80-fedc8b2acec9@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2025-04-09 11:15, Quentin Schulz wrote:
> Hi Jonas, Simon,
> 
> On 3/29/25 4:06 PM, Jonas Karlman wrote:
>> From: Simon Glass <sjg@chromium.org>
>>
>> The U-Boot image is currently being identified as an invalid OS in
>> spl_fit_image_get_os() due to case sensitive compare.
>>
>> Use the correct lower-case value to fix this.
>>
>> Fixes: e0c0efff2a02 ("rockchip: Support building the all output files in binman")
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Changes in v4:
>> - Update commit message
>> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
>> ---
>>   arch/arm/dts/rockchip-u-boot.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
>> index c8c928c7e508..e9ed1d4b5738 100644
>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
>> @@ -50,7 +50,7 @@
>>   				u-boot {
>>   					description = "U-Boot";
>>   					type = "standalone";
>> -					os = "U-Boot";
>> +					os = "u-boot";
> 
> It seems like it's not the only place where this is wrong?
> 
> $ git grep 'os.*=.*U-Boot'
> arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi: 
>              os = "U-Boot";
> arch/arm/dts/k3-am65-iot2050-boot-image.dtsi: 
>              os = "U-Boot";
> arch/arm/dts/k3-binman.dtsi:                                        os = 
> "U-Boot";
> arch/arm/dts/k3-binman.dtsi:                                        os = 
> "U-Boot";
> arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi: 
>                  os = "U-Boot";
> arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi: 
>            os = "U-Boot";
> arch/riscv/dts/binman.dtsi:                                        os = 
> "U-Boot";
> tools/binman/entries.rst:                os = "U-Boot";
> tools/binman/etype/fit.py:                    os = "U-Boot";
> tools/binman/test/343_fit_encrypt_data.dts: 
>            os = "U-Boot";
> tools/binman/test/344_fit_encrypt_data_no_key.dts: 
>                   os = "U-Boot";
> 
> So we should probably fix those as well.

I agree, this should probably be fixed for all device tree files (in a
separate series).

The default handling in SPL is to do the same thing for unknown and
u-boot image type, so should not be any effect, unless there is a future
code change that may depend on correct image type.

(something I think the VBE part of original series may have done).

Regards,
Jonas

> 
> Cheers,
> Quentin

