Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F184C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 21:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A470984AA2;
	Mon, 29 Jun 2026 23:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BodUjZvL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD0F684A29; Mon, 29 Jun 2026 23:49:41 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2DD4849C5
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 23:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gq0LB1qz3z9vGk;
 Mon, 29 Jun 2026 23:49:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782769778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZhCG+3DMXQH7YVdwoK8AvWQKKieNLNDcVYj23nfaeRY=;
 b=BodUjZvLO0YN/LbB5ghAbrCHgQaBwp4mzw0TZDJOrBDFtZ0+QePbvLKMVzt5HfIWgL0VzS
 2NviO3oavMVHWWcygA6NUn8t8Z0PcjAg4WBvmEJxFKAiro3e1qEKcueeTR6nTLvycpcAt3
 NrfjG//8a8Lv5O5N6DOjUNNTzGdmXj1UW5F4oPG7i3Bf+tHBrl7kiE2XJ/V7HZxxzUEEC+
 jAAJ2psSj5/7iOGEARlw4jYVAbeHLTRUSWM3Hr11n8ZSpBm0ofE04IMJ83WyiB3YEsz3ne
 NuiwB70uXxqD/Q6izVkeqKl+MUixTnfKLIfY6lxu6y/Dcv4TxBZPcotT7IJUJQ==
Message-ID: <3e01c1fe-3e8f-402c-a823-8fca9f6c2a3a@mailbox.org>
Date: Mon, 29 Jun 2026 09:56:37 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: xhci: Fix bNbrPorts overwritten by another controller
To: m13738176232 <13738176232@163.com>
Cc: u-boot <u-boot@lists.denx.de>, "bmeng.cn" <bmeng.cn@gmail.com>
References: <1782563839-11379-1-git-send-email-13738176232@163.com>
 <dc5ecf1c-ee61-4434-a19b-966f287f1533@mailbox.org>
 <5165dbf8.4708d.19f120e171a.Coremail.13738176232@163.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <5165dbf8.4708d.19f120e171a.Coremail.13738176232@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: hf3jpjga84gmk8k91ss5upxym34rtzm5
X-MBO-RS-ID: a692532520392544b2e
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

On 6/29/26 8:25 AM, m13738176232 wrote:
> For the `struct descriptor`, only the `hub` part (`bNbrPorts` and `wHubCharacteristics`) is different for each controller; the other five members (device, config, interface, endpoint,ep_companion)are identical for all XHCI root hubs.
> 
> My previous patch only fixed the dynamic reading of `bNbrPorts`, but `wHubCharacteristics` is also different for each controller and will be overridden by the last controller.
> 
> New patch as below for referrence.
Please send this as a V2 properly. Thank you !
