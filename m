Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FBFC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 15:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 151608388D;
	Wed,  9 Apr 2025 17:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="f22mdcpv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFEED83881; Wed,  9 Apr 2025 17:17:54 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34BD3810EA
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 17:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3b7d=W4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744211870;
 bh=RYwXR1VP28W8/vx8QlvQL0Lf9pqyCa7Zs79aV/Bu8v4=;
 b=f22mdcpv5gJaOInSAgqDrRwAzqWy15djtMWHVwtQ8mCnLRmJL6cnRKf5ZikD6L9rjmDl8LFED
 Mpv7TScuMTQkXEzCPJOyVBDdfJDBvAaq7RL47YW2bTIhjw7SeQ/MHDMGcL3S1QQsTqUfNuelbJI
 LrXuCqhD5hslm7hV32XVSUJ7nNUWl3fyXGmpvuk/9QY2mcsaStrpGt9x6S/UNUCzYECUq/Gky/C
 Hq31OACgNpmuyJCldI/7VxxDkqrzxcXiDbTAyiHQKfbdNwWlvyb2Fbo4DJAPE7Em9dft2rNAmzk
 kQEAVoKgiC0tZFQgizLvzP9PQ6qG34W1sK5mwZRY3a4A==
X-Forward-Email-ID: 67f68f961aecaf4e4108dacf
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <7e70a4e1-4fed-481f-ae03-4197e265e31e@kwiboo.se>
Date: Wed, 9 Apr 2025 17:17:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] rockchip: binman: Use the skip-at-start prop in
 simple-bin image
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-9-jonas@kwiboo.se>
 <01e8a4b3-a77c-42ca-a4de-e744755a2b89@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <01e8a4b3-a77c-42ca-a4de-e744755a2b89@cherry.de>
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

On 2025-04-09 12:57, Quentin Schulz wrote:
> Hi Jonas, Simon,
> 
> On 3/29/25 4:06 PM, Jonas Karlman wrote:
>> From: Simon Glass <sjg@chromium.org>
>>
>> The simple-bin image is normally written to MMC media at block 64, which
>> is a 32K offset from start of storage media.
>>
>> Set the skip-at-start property to 0x8000 (32 KiB) so that fdtmap and
>> other embedded binman symbols in the output binary is referencing image
>> offsets correctly.
>>
> 
> Shouldn't we have this commit BEFORE we add the `fdtmap` node since we 
> know it's wrong before this commit?

Sure, this series could/should probably be reordered into, patches with:
- fixes
- no functional change
- functional change
- new features

My understanding is that the binman symbols is not really used by
Rockchip in current configuration, yet symbols is embedded into the
binary utput and possible also with the fdtmap. So the order has no
practical change/diff.

Will reorder patches in a v5.

> 
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Changes in v4:
>> - Drop defconfig changes
>> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
>>
>> Changes in v2:
>> - Move this patch to the end of the series
>> - Drop 0x8000 offset for SPI
>> ---
>>   arch/arm/dts/rockchip-u-boot.dtsi | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
>> index fb38b7b80c43..65b81bf58626 100644
>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
>> @@ -154,6 +154,7 @@
>>   	simple-bin {
>>   		filename = "u-boot-rockchip.bin";
>>   		pad-byte = <0xff>;
>> +		skip-at-start = <0x8000>;
>>   
>>   		mkimage {
>>   			filename = "idbloader.img";
>> @@ -178,7 +179,7 @@
>>   #else
>>   		u-boot-img {
>>   #endif
>> -			offset = <CONFIG_SPL_PAD_TO>;
>> +			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
> 
> This is confusing. The documentation states:
> 
> """
> offset:
>      This sets the offset of an entry within the image or section containing
>      it.
> """
> 
> My understanding is that it should be relative to the beginning of the 
> image but this now needs the knowledge of where it will be stored on the 
> MMC device (via the value in skip-at-start).

This was also my understanding but Simon has a different view and for
the simple-bin image that is mainly targeted MMC storage this could
possible be okay.

If there is any slight objection of this I would rather just drop this
patch for now and it can be part of Simon's next VBE part series.

Regards,
Jonas

> 
> Why is skip-at-start automatically deducted from offset?
> 
> Cheers,
> Quentin

