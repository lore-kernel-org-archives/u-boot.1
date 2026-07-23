Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A9DC531F7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B0BE81003;
	Thu, 23 Jul 2026 15:40:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4S8uzTNTUxdS; Thu, 23 Jul 2026 15:40:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 351EC81097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784821228;
	bh=3XaGPz67Swyn/5AdPXsEc5MylaEnGxhIxbKvyUQSX3k=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=toRhn71xmXObM5fFOh0RfNi8uAQnqErCIGeOrPLC/2Hq/1g6gq/j6gMURB2B/kmLf
	 CWeVwAi90KP+xDZDQ18C4vQnA2yAzFPYjTIoBBU0M/B66NL19TihA3jnAScbDnNTmL
	 43JXCaG8S3N4GaZVXBR8V1YU7r9IitCzbxucXZL5AVgVIqpVxTlHXxB3Mbsap7X+U/
	 INrRtOhC/z/9dFcL48FdOYz3YO+8JAqa+RLuEc1YGZD1V5IfWTRwoRo9aARlKdQSjb
	 hLsPTHSD4/0YLX+7KRQglvJ5QdZXBUiH8Jz4qymJQ118yOaUKamseCs1kAG0XUpk6X
	 TsNmVjMcsXevw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 351EC81097;
	Thu, 23 Jul 2026 15:40:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D6C2E390
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:40:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BCDBB409F9
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:40:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7EgDPUGck5_w for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 15:40:26 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 460F8409FA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 460F8409FA
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 460F8409FA
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:40:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 612B080287; Thu, 23 Jul 2026 17:40:23 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3D4C800AE
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 17:40:19 +0200 (CEST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h5b0x6QcFzKpqy;
 Thu, 23 Jul 2026 17:40:17 +0200 (CEST)
Message-ID: <014c6cff-ea11-497c-a1e8-c0733d49c518@mailbox.org>
Date: Thu, 23 Jul 2026 17:40:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm64: a37xx: pinctrl: fix info->dev used but never set
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>,
 Gregory CLEMENT <gregory.clement@free-electrons.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ben Schneider <ben@bens.haus>
References: <20260625-pinctrl-armada-37xx-devm-v1-1-6850a91dd02a@cherry.de>
 <a0fc7450-cb3c-4a32-b3cc-cc2feec78f8a@mailbox.org>
 <ab5807ab-a139-4f92-b274-318cf73f1b47@cherry.de>
Content-Language: en-US
In-Reply-To: <ab5807ab-a139-4f92-b274-318cf73f1b47@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: citzy55ys5rzdcdta6m6rxkikpnxstrk
X-MBO-RS-ID: 0bc4d32608a55911541
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784821217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3XaGPz67Swyn/5AdPXsEc5MylaEnGxhIxbKvyUQSX3k=;
 b=U+t+YjrtEv8HDYzClkx78xbVTUv0IYf4XpTZx2FjKaL3J7wlDM/zr0qMznWc2PraQGSbT2
 bKiOYEdNlbtyltE8d3VPLsV3xBm0w05xL1XNT45/GvCM162pWW8spWSnastcHv0IbX3AY7
 7MPVg+TS9N+xp3s7FVEVsFWAAjAvvITwBlfAkKzvhiVcCupjU6duTu2PX2b9hReqcHF15c
 txzSZ9YRCQ0vTxpGn+bRiYpSelQjBxxwD2IlnnuY77/Z6i31BGSUogXUdE9lph8RKfyNql
 OeCfXoZYB4FmiRfVV+25oyux1eYdLv+FPHejS3gDFwiWfLuxUdE4M3MA9Fm7kA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=U+t+Yjrt
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=stefan.roese@mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=mailbox.org header.i=@mailbox.org header.b="U+t+Yjrt"; 
 dkim-atps=neutral
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
From: Stefan Roese via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Stefan Roese <stefan.roese@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Quentin,

On 7/23/26 17:26, Quentin Schulz wrote:
> Hi Stefan, Tom,
> 
> On 6/26/26 10:29 AM, Stefan Roese wrote:
>> On 6/25/26 11:45, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> A bunch of code calls info->dev, mostly dev_* messages and devm_kzalloc.
>>>
>>> The former can be passed a NULL device and _dev_printk handles this just
>>> fine.
>>> The latter ignores the dev argument whenever !CONFIG_IS_ENABLED(DEVRES)
>>> which was true in most cases until we made CONFIG_DEVRES mandatory for
>>> U-Boot proper in commit 217cf656e249 ("dm: core: Default to using DEVRES
>>> outside of xPL"). Failing to set info->dev before it's used by
>>> devm_kzalloc results in crashes, therefore let's set info->dev before it
>>> can be used.
>>>
>>> Reported-by: Ben Schneider <ben@bens.haus>
>>> Closes: https://eur02.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Flore.kernel.org%2Fu-boot%2FIRefanijM8fTzOXeGe- 
>>> H5hmhRkm7pt4Q83BV6VcWKlWp0s4i8mYcONTQz- 
>>> IVhvNWlGta4LtnfK7ti6gxlrqq8h8cotgG1S0Fs6_DviAHvyo%3D%40bens.haus%2F&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cdee6169699cf4dbea63208ded35d01ca%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639180593585608379%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=miOSlgPfYtM%2BMUpk3G1eT1ZcJyVWDGuzeob2y3sI4mg%3D&reserved=0
>>> Fixes: 0871806629b5 ("pinctrl: armada-37xx: Add pin controller 
>>> support for Armada 37xx")
>>> Fixes: 217cf656e249 ("dm: core: Default to using DEVRES outside of xPL")
>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>
>>
> 
> Going through my inbox... Just making sure this doesn't get forgotten.
> 
> I see MAINTAINERS has been updated to point at https://git.u-boot- 
> project.org/u-boot/custodians/u-boot-marvell.git but there's no such 
> custodian tree (yet?). I don't see this patch in a branch or tag in 
> https://source.denx.de/u-boot/custodians/u-boot-marvell/ either.

Ah, I need to act here with the new list etc. Sorry, was lazy. Will do
tomorrow.

Thanks,
Stefan
