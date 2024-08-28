Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8714BC636EE
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 18:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D099088744;
	Wed, 28 Aug 2024 20:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="anOvPKFN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 107D58857C; Wed, 28 Aug 2024 20:32:51 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A77BF88744
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 20:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4830=P4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1724869963;
 bh=fI0cgWzge9sGRsvM9kz90n8YbMK6aBMmr8mtjn1EsAU=;
 b=anOvPKFNNpH/kk/NEPehlLy4WR47HDZwAvw6RXG3hpKnA0pKXiMgIfB19UB17uXul3Udu9GFh
 dzulYPcJjeLU0jH0NBNastDjwDnNDD3IGmIKfoMqDyOKmG7oC8nfzAidqVoC680y4FiFUYiya2I
 7U2BgC0F21i1cbPc3q7Aw0/rG5Xb+1ub5rrKnYgfdDmIxESYVHy24wfuJx4I/v9GxHPtkOQ0rx0
 WLTx8svOcjKyJhxyLzZrZepT9e1DMIzn+GItwB/MdndATk7VgjUrgT7YT3rNM7e9VxpLSoc6B5u
 vGFpfEZePSJD5bWPmi3OuP1b9eVAX+QIQRBKriKfinPw==
Message-ID: <c6b27581-890d-4308-84df-2f338a81e15f@kwiboo.se>
Date: Wed, 28 Aug 2024 20:32:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] bootstage: Fix unstash of records from SPL
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20240803124149.2916030-1-jonas@kwiboo.se>
 <20240803124149.2916030-2-jonas@kwiboo.se>
 <172486961888.3064792.636174658599384187.b4-ty@konsulko.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <172486961888.3064792.636174658599384187.b4-ty@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66cf6d480a22b811484a04f7
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

Hi Tom,

On 2024-08-28 20:26, Tom Rini wrote:
> On Sat, 03 Aug 2024 12:41:44 +0000, Jonas Karlman wrote:
> 
>> The commit b81e31a1e6c5 ("bootstash: Do not provide a default address
>> for all") changed a bootstage unstash call to bootstage stash, this
>> has resulted in bootstage records stashed in SPL no longer get unstaged
>> in U-Boot proper. Fix this by changing back to a unstage call.
>>
>>
> 
> Applied to u-boot/next, thanks!
> 

I expected this patch to go to master as it fixes a regression
introduced in v2024.10-rc1.

Regards,
Jonas

