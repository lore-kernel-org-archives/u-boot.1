Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1851C5B572
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 13:44:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D35B408DF;
	Wed, 12 Aug 2026 13:44:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EivypK-bEtdC; Wed, 12 Aug 2026 13:44:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3615B408AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786542282;
	bh=n0fIKqnk2oBi+AvHjVNCYaBOb4wZqyMrDyAuQ13zlIA=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=STHCgoa6qBiBzZJ1ovAr/1fXyPOZL3xoKD8PbbNpnn5LlsDn/xivo720cJx0tsn56
	 kdxHYxgwz+VHPpc0tWHN389N+itdBHaPpDkdCjcYvX65siVLeQt9mYpVVKQqRDdv+1
	 3guz6Ua1qLz5KAUF80MOV1zEWAV5Cs4E5olrtCBewAc2RthBecqeZDz8Mtbvk+gPxM
	 3h50Y0YY9wY36UeHvknidpQFu3ZtTEU4rQt1ogYDX7aHNFE6FWuduGvOvaMsBBSv18
	 yCwoEYPi5s4WJe0Y1fYL2sn96GsTeAktBeUB5gexeCTbNnCI0e3oefejLTkafq8JGa
	 WV1Shpq7cmRgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3615B408AA;
	Wed, 12 Aug 2026 13:44:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D803282
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F6A060A6A
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:44:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y2bu6lqNmoxM for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 13:44:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.12;
 helo=smtp-190c.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 736AD60A67
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 736AD60A67
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [185.125.25.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 736AD60A67
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:44:39 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hKqVB2cMYzGb7;
 Wed, 12 Aug 2026 15:44:34 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hKqV94kFKzhd0; Wed, 12 Aug 2026 15:44:33 +0200 (CEST)
Message-ID: <686b7f57-2500-4776-9302-f2849f7c6eb4@0leil.net>
Date: Wed, 12 Aug 2026 15:44:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] rockchip: doc: add more building instructions
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
 <5f60ffd4-273b-4f2f-87d1-5a9f1fe74543@gmail.com>
Content-Language: en-US
In-Reply-To: <5f60ffd4-273b-4f2f-87d1-5a9f1fe74543@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786542274;
 bh=n0fIKqnk2oBi+AvHjVNCYaBOb4wZqyMrDyAuQ13zlIA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RE5SJyMsjU2a7mpoba8FPKVwoEsSzb49pxVLn4Gj6MYhRMVF1Z+ErDPuGPafr1feW
 vUDcZkqu8x/oXydx55RuY92PreBKg6oN5sVr5oOfL3FPff4qLJVFCMQXd5nbRZK+P5
 tVG/LK6nyWckaT5j1N454b652LkCesNk9I/D+W8OFb9X+4ptJIWW8o5/8WIPkmRYA9
 wUgkbFzKlFK4BvQOM56LXk57diWs1h/9oNRkTwf7VDcyancMHhdeli6OpbhXUt4cFa
 V0Q0b8KEJpJa+6W4Hta8N1FW4fGahOsMSwOp2Bq9x4SjZToj7qhkbhM/Fy+dhjPkga
 3Ru82Gwrt5FlA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=RE5SJyMs
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 8/6/26 1:11 PM, Johan Jonker wrote:
> Add more building instructions for existing SoCs.
> 

I would rather see the opposite happening.

We already list supported devices per SoC and with their defconfig in 
parentheses (well, I hope so, that is the intent!).

So I think it'd be more efficient to instead say that one can build the 
supported board by looking into that list and build using the defconfig 
listed between the parentheses.

Considering there isn't much in common between ARM and ARM64 boards in 
the build instructions, maybe we should split rockchip.rst into two 
files, one for ARM SoCs and one for ARM64 SoCs? Then ARM64-specific 
instructions go into rockchip-arm64.rst and ARM-specific instructions go 
into rockchip-arm.rst. What do you think?

Cheers,
Quentin
