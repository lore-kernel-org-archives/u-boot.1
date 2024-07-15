Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B96C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F97E8881F;
	Mon, 15 Jul 2024 15:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721049563;
	bh=0dv90VyIfIYzjM4DanBNXiwDPLu1ZbSnR1x5Un6auyM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mZivjs/0Mwltljv7PRkuADXx/8t4rOrU0k3Jw3hrh9Q5ttgpY28sCnXs7juayl4/j
	 LMCq5WmK4me1Yvk80VQeKjXj0Tj47V0SgZo5uRygKRs1OZSWlSBD6g9eB9QHZN6iny
	 Kt5ATFe5hmnCj5IhGmH2bASTBA+5ZQQ+T8SMjhCVvel23QRzVlSN/UWeaE7iUX/6pj
	 aep4QoO0MSebRrecQ8YaVxyBiCEek6YqPaOzPWxLBvHj8/akRHfCuo6KwkRK+uT7dq
	 du+mRVlCG+6gX/UicDX420uVC9Ue7QduMXIK6Ku6BKbBItnGmRv3t9rW50IlKLIokY
	 t/LLMA1fXWmxQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1BD088835; Mon, 15 Jul 2024 15:19:21 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C618987C68
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4WN2pr2cwsz9sWn;
 Mon, 15 Jul 2024 15:19:16 +0200 (CEST)
Message-ID: <7365eec4-0ace-49a6-ba0e-6fafc1127c1e@denx.de>
Date: Mon, 15 Jul 2024 15:19:15 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] a little RPi watchdog cleanup
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
References: <20240712090725.2093317-1-rasmus.villemoes@prevas.dk>
 <0586321e-b2b0-40f6-87cd-6da74b79fc40@denx.de> <87a5ii959q.fsf@prevas.dk>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <87a5ii959q.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/15/24 15:03, Rasmus Villemoes wrote:
> Stefan Roese <sr@denx.de> writes:
> 
>> @Tom,
>>
>> I can't find these patches (and v1) in patchworks. Do you have an
>> idea, why this is the case?
>>
> 
> Perhaps because they (v2) have already been merged to master via a PR from
> Peter?  commit 1ca216522d4.

Ah, I was not aware that it was already merged. Okay, that explains it
of course.

> So one has to change 'state' from 'action required' to see them:
> https://patchwork.ozlabs.org/project/uboot/list/?series=&submitter=&state=*&q=hw_watchdog&archive=&delegate=

Nice, I never noticed that I could change this view.

Thanks,
Stefan
