Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36192C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 12:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9733B848EB;
	Tue,  7 Jul 2026 14:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="EGONLwZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26DC684942; Tue,  7 Jul 2026 14:39:49 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B438184852
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 14:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=73ca=FC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1783427985;
 bh=TGOB4huUGX7ZDDyZyULs3KLVSyjP1ZTzGD0YDRITWs0=;
 b=EGONLwZ2/ioT5ecRNSkhuxFGub2QU9pa+upeO2uunhAlYUB+0eq/UZtXqjnJneJ9tZUJ6DBPK
 Mt8nuq602cJxY045y05ozfyhsOTXG2wbpuOEMEhwMr5Y2VGB3nA+CEaCMIhQDJbr+f/cE/RjdJV
 bbsk6CaVg/b/kiZK6OtJ7W4LpnCQEXg/kcNg9Fg6UGLmaG46MoYbwgKL1y5PKDzY4YuBSM1aWEE
 vH8Llm7Y5jNtpiVw/pmr/51bGAW7opQCt83/RFOyJWQZQtvfpDo7u+8jsJqSoOx5DL20k7I2C7+
 tJFD4BM7F389Uv7aDGbI4UalOwcUPl7rtvbMIWhdCYqw==
X-Forward-Email-ID: 6a4cf38e696efca8b175774c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.9.9
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d3bdf508-f127-4e91-95b3-90b4b27b9783@kwiboo.se>
Date: Tue, 7 Jul 2026 14:39:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: rockchip: Align OTP nodes for RK3528/RK356x
 with Linux v7.1
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
References: <20260707100918.3057718-1-jonas@kwiboo.se>
 <5433d0d4-437c-48f0-a584-ca6f5da317ce@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <5433d0d4-437c-48f0-a584-ca6f5da317ce@cherry.de>
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

On 7/7/2026 12:58 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 7/7/26 12:09 PM, Jonas Karlman wrote:
>> The <soc>-u-boot.dtsi OTP nodes for RK3528/RK356x use different names
>> compared to the OTP nodes that was merged in Linux v7.1. This causes
>> build issues when dts/upstream pulls in updated DTs, i.e.:
>>
>>    ERROR (duplicate_label): /soc/nvmem@ffce0000: Duplicate label 'otp'
>>                             on /soc/nvmem@ffce0000 and /soc/efuse@ffce0000
>>
>>    ERROR (duplicate_label): /nvmem@fe38c000: Duplicate label 'otp'
>>                             on /nvmem@fe38c000 and /efuse@fe38c000
>>
>> Align the OTP node names in <soc>-u-boot.dtsi with the node names used
>> in upstream Linux v7.1 to avoid build issues when latest DTs are synced.
>>
>> Also drop the unused RK356x id@a subnode as it has moved under a
>> nvmem-layout node in the merged upstream DT.
>>
> 
> I guess this is fine because our driver isn't actually making use of 
> those subnodes as far as I could tell.

Correct, if I remember correctly I probably added the cpu_id/id@a node
because rk3568 was the first SoC that used a different offset in OTP,
and this worked as "documentation" until a proper node landed upstream.

> 
> I was wondering why we even keep those nodes in since they are now part 
> of dts/upstream but actually they aren't yet and this patch allows to 
> not depend on 7.1-dts being pulled in U-Boot AND allows to build once 
> it's pulled. I'm assuming we can remove those nodes right after the 
> 7.1-dts tag is merged, right?

Correct, the OTP nodes must exist until we have fully transitioned to
v7.1 in dts/upstream, after that we should remove these nodes from
<soc>-u-boot.dtsi in a follow-up patch.

Regards,
Jonas

> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

