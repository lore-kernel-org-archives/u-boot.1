Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7966DCDDE64
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 10:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE89C8924B;
	Wed, 23 Oct 2024 12:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729680760;
	bh=Kb7IZjrlc2LPyERAADHSKwmAKGeORhZBBEjjnh12iw8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PqdXKdJXZEowF3RWfJiebrS5woSSz762oHwNl3WYZX80lAaCn/uz/RjC15HnLGOXb
	 wnCzpBFg7etJwfWRj9/DTALjvqhZ1rv52JdIugxkdv/p3CHVVkXL7HE/fGNF2FHXf+
	 FhaEHuxFlqmBgKNqwipuKkHUr1QH1toDzyBCD4iq8egqhqXo6mKBG+BoIB5MJtXqGm
	 XNG7QqgGOhZOkToTCIFLTIkd1o9FwPdsbg8awj9hgw95M+l3NYaL8kqk9V2eqaF34N
	 3twS8HlPu/Y0dDQvHM3PRL1nTNO3vCp95TdtQ8TRWu1aqAxwVHvIyUBp1WhkMIHbsa
	 OpQGZscAmervg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1B3389266; Wed, 23 Oct 2024 12:52:38 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D5D688A9D
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 12:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XYQqL608Fz9shL;
 Wed, 23 Oct 2024 12:52:30 +0200 (CEST)
Message-ID: <6477e2b7-05b4-45db-a877-473acf28195a@denx.de>
Date: Wed, 23 Oct 2024 12:52:29 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] watchdog: gpio_wdt: add support for stoppable devices
From: Stefan Roese <sr@denx.de>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Paul Doelle <paaull.git@gmail.com>,
 Felix Blix <felbe@prevas.dk>
References: <20241002192323.632822-1-ravi@prevas.dk>
 <a95685d3-50fe-4b4d-a6bc-23adac2a33c5@denx.de> <877ca0qs6d.fsf@prevas.dk>
 <5c707249-9857-44c0-9ea6-d2d104000ed0@denx.de>
Content-Language: en-US
In-Reply-To: <5c707249-9857-44c0-9ea6-d2d104000ed0@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4XYQqL608Fz9shL
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

On 10/22/24 13:46, Stefan Roese wrote:
> On 10/22/24 13:43, Rasmus Villemoes wrote:
>> On Tue, Oct 22 2024, Stefan Roese <sr@denx.de> wrote:
>>
>>> Hi Rasmus,
>>>
>>> On 10/2/24 21:23, Rasmus Villemoes wrote:
>>>
>>> While running a CI build, I'm seeing some sandbox failures, most likely
>>> related to this change here:
>>>
>>> https://dev.azure.com/sr0718/u-boot/_build/results?buildId=375&view=logs&j=db15d90c-51e5-5ca3-902e-4c5d558bba82&t=64917d2e-7acb-5ec4-6136-40fc146da71a
>>>
>>> Could you please take a look at this?
>>>
>>
>> Ah yes, sorry about that. The two -ENOSYS in test/dm/wdt.c should
>> probably become -EOPNOTSUPP. Can you test with that change folded in, or
>> do you want me to resend?
> 
> Let me give it a try...

Changes folded in and CI is happy.

Applied to u-boot-watchdog/master

Thanks,
Stefan
