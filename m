Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E23C369A4
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 17:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9B9482B45;
	Tue,  8 Apr 2025 19:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QKjtGxRe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F062982B7E; Tue,  8 Apr 2025 19:48:51 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E978215B
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 19:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6bf1=W3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744134527;
 bh=TzG7S+LbkBO2ccBBC9Aou0f5G5TRfaYXsSeGaQ4vSaI=;
 b=QKjtGxRezUu4nZ8SQwbAtfWx1If/S+An3hYJ5O4BjkHudEJdjfUYeGldUnK4t/RaZ/1zbpoIe
 qUK56zHFzyFSETwE68zPh0U1m9+UX7/x7N5l7NFS0DcnMTUI3mQezgW2pdLEk0HvJ8DJBUFGTvP
 7huCmWoBWctf6Gr/IsjP3H1QYpbZpl2KCr4H5s2+7D/lr6agsF5RfcB+O0Wo4WObNIvJNall8DK
 CjNuGZOQNFmYCXlwpxNlfL0GxYjp2kn8jZhC31yzjmQiqiTJ1fgSnU8N2P7HVnQi/wInU7OziVJ
 npB7fzeL5kQ0/p9cYbMQheFrLUwcFMjge78950PTuYdQ==
X-Forward-Email-ID: 67f56175ba63fca1da408abf
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <7dfb0e62-5116-4c40-b98a-c252659c1d78@kwiboo.se>
Date: Tue, 8 Apr 2025 19:48:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rockchip: avoid rebuilding most binaries for
 u-boot-rockchip-spi.bin
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
 <20250211-has_rom-u-boot-rockchip-spi-bin-v1-3-0d77f95b6239@cherry.de>
 <d46f46fc-4300-4bf1-b547-c1e87e066e67@kwiboo.se>
 <67492a22-0e36-4466-9b34-6b27d30271a3@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <67492a22-0e36-4466-9b34-6b27d30271a3@cherry.de>
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

On 2025-02-11 12:43, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 2/11/25 12:35 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 2025-02-11 11:29, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> Essentially the only differences between u-boot-rockchip.bin and
>>> u-boot-rockchip-spi.bin are the formatting of idbloader.img which is
>>> handled by mkimage (via -T rkspi/rksd) and the offset at which U-Boot
>>> proper is flashed, the content of the binaries are identical otherwise.
>>>
>>> This fixes some issues[1] where binman tries to find the symbols defined
>>> in the proper binary to install them in an xPL binary. However, because
>>> we use the binary for proper (on Aarch64) generated in simple-bin image
>>> node and not simple-bin-spi image node, binman doesn't have access to
>>> that symbol anymore. Therefore, let's depend entirely on binaries built
>>> by simple-bin in simple-bin-spi so those issues do not arise anymore as
>>> nothing is compiled essentially, just assembled.
>>>
>>> [1] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>> ---
>>>   arch/arm/dts/rockchip-u-boot.dtsi | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
>>> index c8c928c7e5089db3a2239f2564e6dee1d82aad95..2e8a3bd09e49ed73a8cea3fadfb6d2b592082365 100644
>>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
>>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
>>> @@ -187,18 +187,28 @@
>>>   			};
>>>   #elif defined(CONFIG_TPL)
>>>   			u-boot-tpl {
>>> +				type = "blob";
>>> +				/* sync with /binman/simple-bin/mkimage/u-boot-tpl */
>>> +				filename = "tpl/u-boot-tpl.bin";
>>>   			};
>>>   #endif
>>>   			u-boot-spl {
>>> +				type = "blob";
>>> +				/* sync with /binman/simple-bin/mkimage/u-boot-spl */
>>> +				filename = "spl/u-boot-spl.bin";
>>>   			};
>>>   		};
>>>   
>>>   #if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
>>>   		fit {
>>>   			type = "blob";
>>> +			/* sync with /binman/simple-bin/fit */
>>>   			filename = "u-boot.itb";
>>>   #else
>>>   		u-boot-img {
>>> +			type = "blob";
>>> +			/* sync with /binman/simple-bin/u-boot-img */
>>> +			filename = "u-boot.img";
>>>   #endif
>>>   			/* Sync with u-boot,spl-payload-offset if present */
>>>   			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
>>>
>>
>> I think changing to using a template may suit binman better, however it
>> will be at the expense of having to re-generate the FIT, not sure what
>> option is best.
>>
> 
> Unnecessarily rebuilding images is not great for build times :) If I'm 
> not mistaken, binman still compiles sequentially so doubly not great.
> 
> At the same time, this is relying on undefined behavior (according to 
> binman spec; i.e. using a binary from another image node) but we've been 
> doing this for a few years now and it seems to be doing ok so far?
> 
>> It would be great if Simon can split out the rockchip-u-boot.dtsi
>> improvement commits in a separate series as I suggested in [2].
>>
> 
> That's fine but we need something soon, this is already preventing 
> people from contributing stuff for their boards. I don't mind either 
> (haven't checked the template stuff so far though), just no need to wait 
> too long for the perfect implementation. Also this can be merged as an 
> intermediary fix and templating done afterwards.

The fit-template patch (and others) was extracted and are included in
the "rockchip: binman: Use a template for FIT and other improvements" v4
series, see [3].

I suggest we skip this last patch in this series, and instead apply the
change to use a template from that series. If not, a v5 of that series
would just end up revering the changes made in this patch any way.

The added time for building two (or three with ram boot) times seem to
be negligible on my build machine. 

[3] https://patchwork.ozlabs.org/cover/2066701/

Regards,
Jonas

> 
> Cheers,
> Quentin

