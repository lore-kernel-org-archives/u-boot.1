Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E045C44500
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 22:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0523A8341A;
	Wed, 21 Jan 2026 23:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wdo0+lZt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9AD9839D5; Wed, 21 Jan 2026 23:45:00 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BDF180077
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 23:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dxK5L2DYBz9v0g;
 Wed, 21 Jan 2026 23:44:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769035494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s1J+TAcc1Cnhmy3n0hNNPG6WprTDNY/G26A5YMiArzE=;
 b=wdo0+lZtJaqMZHMJzkrU7BvAbeQLmD+6JmdmsvNL2gfTL/FWJiZ8687oz2BdxtndK68031
 XvM9aR6vg9hRu3dcUtbMypbvDimik7KyWvSIuVcjcezRq7oAyS20ZxSkW+mZhlCIyN1fO5
 KIKd8TuYjl9BpoTh8DOTCOJTYWx8CrS7vi6Ksd8muFVK7W4UT1tRM3safLKGLquuzx5oUU
 HsTvAbeDEV9Dit2ME3c7iW0gmDYTKLk99JtEbkKlgbayGsaWF5PVQPD62ObnFg/A+r8LEb
 4P8rAf+p0tL/ISfDQC/Jq1HV39rHzmw+OPxhumFzmbOcdthklPA6UV6G6E/QTA==
Message-ID: <5153f94d-8edd-4be5-85de-b096c9f6c317@mailbox.org>
Date: Wed, 21 Jan 2026 19:07:30 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] usb: xhci: fix DMA address corruption in abort_td
To: ANANDHAKRISHNAN S <anandhakrishnansasidharan@gmail.com>,
 u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, trini@konsulko.com, mkorpershoek@kernel.org,
 ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
References: <20260120145055.233298-1-anandhakrishnan.s@dicortech.com>
 <20260121170631.556826-1-anandhakrishnan.s@dicortech.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260121170631.556826-1-anandhakrishnan.s@dicortech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 6ije8tmcnjz8cn9b4j8trh1jgqp44h1d
X-MBO-RS-ID: 15364952930129c3ae9
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

On 1/21/26 6:06 PM, ANANDHAKRISHNAN S wrote:
> When aborting a Transfer Descriptor (TD), the xHCI driver updates the
> device dequeue pointer by converting the virtual enqueue TRB pointer
> into a DMA address.
> 
> Previously, the code OR-ed the ring's Dequeue Cycle State (DCS) bit into
> the virtual TRB pointer before passing it to xhci_trb_virt_to_dma().
> This produced an unaligned virtual address (e.g. ending in 0x...1).
> 
> Inside xhci_trb_virt_to_dma(), the offset calculation:
> 
> segment_offset = trb - seg->trbs;
> 
> operated on this unaligned pointer, resulting in an incorrect TRB index.
> In wraparound cases, this caused the bounds check to fail and the
> function to return 0.
> 
> As a result, a SET_DEQ_PTR command was issued with a DMA address of 0x0,
> leading to controller hangs and transfer timeouts, most commonly when
> aborting TDs near the end of a ring segment (e.g. index 63).
> 
> Fix this by translating the aligned virtual TRB pointer to a DMA address
> first, and only then applying the DCS bit to the resulting physical
> address.
> 
> Changes in v3:

The changelog should be below --- , else it gets included in the commit 
when it is applied.

> - Simplified the DMA address calculation by removing the redundant
>    bit(0) mask (& ~0x1ULL), as XHCI guarantees the address is already
>    aligned.
> 
> Changes in v2:
> - Apply the same fix to reset_ep()
> - Simplify cycle bit handling to a single mask operation
> 
> Signed-off-by: ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
> ---

i.e. patch changelog goes HERE

>   drivers/usb/host/xhci-ring.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
