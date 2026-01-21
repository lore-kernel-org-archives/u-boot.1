Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B59DC44502
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 09:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE9628341A;
	Wed, 21 Jan 2026 10:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EmV1JbUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8216D839D5; Wed, 21 Jan 2026 10:16:36 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8740682A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 10:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dwz8b2c6Wz9tq3;
 Wed, 21 Jan 2026 10:16:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768986991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yt5Lv6iHp73JPH99cl7sAuwQ1crAwsh8BkmquL5eC4E=;
 b=EmV1JbUSjlXcEei/cwXFv7Wz5azZWxh1bYnWr12UJaX+Gh3uMQfb42CSzyZ8y2YHzhlrKj
 PtnK4s9y+OrmEzkNj9UKsVohMq8N1YxuFYi9XUwnaxnWY3RU5zaBX6tU1+zAiWWbvwyomM
 T5mzKlLc5lwfGeSe67vGmDOwtqC9J59hwfxGdTziBl1rNbjDeq98Zm+vTqPhLj2azCmGGE
 Q/vGfclrQPB49b46PZI4ZK57YD4nnSiaoiwvZwGONzKrgBrqXEKdUKRhC2oBiZQej0hYQn
 VvfwDYkt3oJ1L5Wt3BvLcC7i4a0Hd4rvE3T4mG2+b7nWs+GDGoPWFZzm8HBzVQ==
Message-ID: <0930431a-1152-451b-a351-862efda4e889@mailbox.org>
Date: Wed, 21 Jan 2026 09:55:55 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: xhci: fix DMA address corruption in abort_td
To: ANANDHAKRISHNAN S <anandhakrishnansasidharan@gmail.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: bmeng.cn@gmail.com, marex@denx.de, trini@konsulko.com,
 ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
References: <20260120145055.233298-1-anandhakrishnan.s@dicortech.com>
 <20260121085001.405127-1-anandhakrishnan.s@dicortech.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260121085001.405127-1-anandhakrishnan.s@dicortech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 419j44eeg1f8xjrzcs6aed1tn68o1qtd
X-MBO-RS-ID: f3b6689e174fa2a8dd8
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

On 1/21/26 9:50 AM, ANANDHAKRISHNAN S wrote:
> On Tue, Jan 20, 2026 at 23:43:46 +0100, Marek Vasut wrote:
> 
>> reset_ep() seems to have the same problem ?
> 
> Yes,it follows the same pattern of OR-ing the cycle state into the virtual
> enqueue pointer before translation. I’ll audit that path and include a
> corresponding fix so the cycle bit is applied only after converting to
> a DMA address, consistent with the change here.
> 
>> cycle_state is already either 0 or 1, isn't it ?
> 
> Yes, `ring->cycle_state` is indeed either 0 or 1. The intent of the explicit
> masking was to make it clear that the cycle bit is applied only to the
> *physical* address returned by xhci_trb_virt_to_dma(), and not to the
> virtual TRB pointer itself, which was the root cause of the corruption.
> I agree this can be simplified stylistically, and I can fold it into a
> more compact expression in a v2.
> 
> I’m happy to change this to:
> 
>      addr = (addr & ~0x1ULL) | ring->cycle_state;
> 
> I’ll send a v2 addressing both points.
Please do a V2, thanks !

Also, please CC Mattijs for V2.
