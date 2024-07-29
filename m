Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D06C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 17:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2407788247;
	Mon, 29 Jul 2024 19:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rGnpwKLO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A46F887B9; Mon, 29 Jul 2024 19:04:39 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1077587705
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 19:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=7921=O6=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1722272666;
 bh=WJ7IpkGiz0169n7wJOTysYzF4TthNVEh/dKyZGHlcms=;
 b=rGnpwKLOLS4VpgII0MoYLMxEDakDhEz9t22MM+atlwWsf4XEWWDN5LyPJFBofcqpD606QYfXN
 3e1bAJexwBgKm1H8aLtf7WKLe3rIy0ZaPXhQvPetAKAJVeg//d5UMTVKrkrg8u230+BFfyJ0cbA
 mus43j3zzlFLkC2w8m6hgd6hseAieTnOHzwPQ+CAJH8zN6o3l+7Bq95thFKfMApLLG0a+eztyHu
 bCGKoaUXhwk5G76Ac3Rlm0v8er+SfzPVeZKmDLAO1OdsKrcb+6EfHnOsmrPcG1NDYopO/ehETpw
 uZyddcrZC3WlNIQlTGsY+kHe8y21cgFIt8MyyhU+B0qg==
Message-ID: <19c64a61-503c-4cec-b204-87f0a1970a9a@kwiboo.se>
Date: Mon, 29 Jul 2024 19:04:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3308: Update otp node in u-boot dtsi to match
 v6.11-rc1
To: Quentin Schulz <quentin.schulz@cherry.de>, Kever Yang
 <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240724074409.2758552-1-jonas@kwiboo.se>
 <adda6a86-06f2-4914-ac50-422473eff669@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <adda6a86-06f2-4914-ac50-422473eff669@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a7cb944788c8beeb41d5bb
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

On 2024-07-29 10:48, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 7/24/24 9:44 AM, Jonas Karlman wrote:
>> The merged upstream DT node for OTP differs slightly, update node in
>> rk3308-u-boot.dtsi to match Linux kernel v6.11-rc1 in order to reduce
>> possible issue in future when devicetree-rebasing v6.11-dts is merged.
>>
> 
> Why not simply cherry-picking the commit from devicetree-rebasing.git 
> instead?
> 
> If you spend the time doing this, better do it once than twice?

Agree, this patch will be superseded by a different patch in a new
series that cherry-picks rk3308 dtsi and rock-pi-s dts updates from the
devicetree-rebasing v6.11-rc1-dts tag.

Regards,
Jonas

> 
> (but I realize the v6.11-rc1 tag was only pushed half a day ago so maybe 
> the timing was unfortunate :) ).
> 
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

