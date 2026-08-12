Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C19C5AD5A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 09:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F5414085D;
	Wed, 12 Aug 2026 09:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JmkUO3DBPiUA; Wed, 12 Aug 2026 09:35:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 64CEE40852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786527356;
	bh=RnewTHw7qIN2pNmnqlGQvC0RM9o/D56EkQbAwpbFIVc=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=nZLSNzOUia3dSGTtkcdxGAP1Si6sMZmu70quzYyDd9JQy73Ux/6qu1RMpm2Z1KtFV
	 H65Yv4YPIqKE4R23rIarrVLDfacAq4Z19a2MNvq7IpMdCppwtQ1UtO5iK7hAndxmPu
	 YJiR3Ps5Rj/4EZUJiL5+FGR6fsGAR0Swh/x4WfkMsk4XS5HxANQqj2PIw9RUd5FOU9
	 Hd+mZBQf7tQmOgfcFnPypl7ujXPczik22eIHcg7frByeR+HstaYlHL+dy08HxdNepD
	 1kCNHEvbG2MKBOJXC/SGqq9D/R43W7w/sdHcMg5Ixytpftl4zaUy3oi5PQVwLOwsm+
	 Cueuc5NfBy7dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64CEE40852;
	Wed, 12 Aug 2026 09:35:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AE151F41
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 09:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C9B3811AE
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 09:35:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NgoJhLa7SFzs for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 09:35:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 363D08119C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 363D08119C
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 363D08119C
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 09:35:53 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hKjzD1MrCzKwL4;
 Wed, 12 Aug 2026 11:35:52 +0200 (CEST)
Message-ID: <f71ebcbb-6cdc-4c07-8d1e-0f39ccbfa141@mailbox.org>
Date: Wed, 12 Aug 2026 11:11:49 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: Add missing fragment for Versal Gen 2
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org,
 git@amd.com, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
References: <11956eca5ebd0b3626b7e2d0fa52331cbd3dc1ec.1786361819.git.michal.simek@amd.com>
 <f29ac2fa-4d73-410f-ace5-819c2a459cb5@amd.com>
Content-Language: en-US
In-Reply-To: <f29ac2fa-4d73-410f-ace5-819c2a459cb5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/12/26 8:35 AM, Michal Simek wrote:
> 
> 
> On 8/10/26 13:37, Michal Simek wrote:
>> Versal Gen 2 and especially march-versal2 is not covered by own fragment
>> that's why add it.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   MAINTAINERS | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e1379a6a3e7e..eb48eea55c5a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -821,6 +821,12 @@ F:    drivers/spi/cadence_ospi_versal.c
>>   F:    drivers/watchdog/xilinx_wwdt.c
>>   N:    (?<!uni)versal
>> +ARM VERSAL GEN 2
>> +M:    Michal Simek <michal.simek@amd.com>
>> +S:    Maintained
>> +T:    git https://git.u-boot-project.org/u-boot/custodians/u-boot- 
>> microblaze.git
>> +F:    arch/arm/mach-versal2/
Use "N: versal" instead for the globbing match .

In fact, "N:    (?<!uni)versal" above does not work ?
