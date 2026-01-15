Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BEFD44C48
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 13:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA06583942;
	Thu, 15 Jan 2026 14:45:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="KGS+h794";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C17A80325; Thu, 15 Jan 2026 14:45:10 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF08E80325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:45:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6bf5=7V=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1768484704;
 bh=iUlFtuFJh2oMI4y3TNV6e0SHMqozQQU0kh2derO0+C0=;
 b=KGS+h7945qo+NR4JTLVhbaWnb6NsYa4y8dmAL4g2ULyzOdV1vguIvmCTUn7k2oRwyD6WhYfzU
 qfeT7+dvG5v6mhsnK0E6cUAFQxy+R3pBSta/LLklb2BWawMjLtzRxDp1vsyptE4OXrSC8kND64M
 dSlwjnmZrvt94/l4FCdtT//fODk83ZP61RfnN9uUNx2q8aOFWGJRFpx9vrUJJu82iqZruZs906I
 kOZPP5Y2xVOdThTb+HbFbVKWm+MA6hNfn7DJvxykPIf5AAJfkxaJPktz+AXkrEvXayBXHD4ckv5
 Ya1L6wh2BdZiNIcNQWnFTQzgPsZYMP+JqZquXrx27OzA==
X-Forward-Email-ID: 6968ef5c1104151281d4c0bf
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.2.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <23d37542-3a80-4b4e-8720-3e62aa5f0a02@kwiboo.se>
Date: Thu, 15 Jan 2026 14:44:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] rockchip: rk3588s-rock-5c: Add support for ROCK 5C
 Lite variant
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20260107230747.3552391-1-jonas@kwiboo.se>
 <20260107230747.3552391-4-jonas@kwiboo.se>
 <e286ab86-2253-400a-9717-acc87b7523df@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <e286ab86-2253-400a-9717-acc87b7523df@cherry.de>
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

On 1/15/2026 12:26 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/8/26 12:07 AM, Jonas Karlman wrote:
>> Add Kconfig option OF_SYSTEM_SETUP=y to support booting ROCK 5C Lite
>> boards with a RK3582 SoC. CPU and GPU cores are failed based on ip-state
>> and policy.
>>
>> Tested on a ROCK 5C Lite v1.1:
>>
>>    cpu-code: 35 82
>>    ip-state: 00 80 00 (otp)
>>    ip-state: c0 9e 04 (policy)
>>    remove cpu-map cluster2
>>    fail gpu
>>    fail rkvdec1
>>    fail rkvenc1
>>    fail cpu cpu@600
>>    fail cpu cpu@700
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v4: Update commit message to reflect updated policy
>> v3: Update commit message to reflect updated policy
>> v2: New patch
>> ---
>>   arch/arm/mach-rockchip/rk3588/Kconfig | 9 +++++----
>>   configs/rock-5c-rk3588s_defconfig     | 1 +
>>   doc/board/rockchip/rockchip.rst       | 2 +-
>>   3 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
>> index 60c16d2f32d2..675f13ab66d7 100644
>> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
>> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
>> @@ -286,14 +286,15 @@ config TARGET_ROCK_5_ITX_RK3588
>>   	  Powered by either 12V, ATX power-supply or PoE
>>   
>>   config TARGET_ROCK_5C_RK3588S
>> -	bool "Radxa ROCK 5C RK3588S2 board"
>> +	bool "Radxa ROCK 5C/5C Lite"
>>   	help
>> -	  Radxa ROCK 5C is a Rockchip RK3588S2 based single board computer.
>> +	  Radxa ROCK 5C/5C Lite is a Rockchip RK3588S2/RK3582 based SBC (Single
>> +	  Board Computer) by Radxa.
>>   
>>   	  Specification:
>>   
>> -	  Quad A76 and Quad A55 CPU
>> -	  6 TOPS NPU
>> +	  Quad/Dual A76 and Quad A55 CPU
> 
> Considering the code seems to handle removal of little cores too as well 
> as all big cores, is this something we should be mentioning?

The code is trying to be as dynamic as possible, however if I
understand correctly a RK3528 should at most have one A76 cluster in
bad/failed state, and if all cpu cores is fine there is a policy to
disable one of the A76 cluster anyway. So this text change is correct
in that the Lite version have Dual A76 and Quad A55.

Regards,
Jonas

> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

