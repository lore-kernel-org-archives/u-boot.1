Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665D5D262B6
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 02:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EFA08341A;
	Wed, 21 Jan 2026 03:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FNq40Qol";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 438AB8397D; Wed, 21 Jan 2026 03:24:04 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D244B82A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 03:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dwp0b2kD5z9v0t;
 Wed, 21 Jan 2026 03:23:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768962239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2JyHOT44KF3v9ksZKLNm++wzctja6X6FY4gkdRY867w=;
 b=FNq40QolqlfdTfCf7BT2SkPDK+RSdmlKNTuQSGZNbbrTLSaqgJcPu4Nra9rxxCIV9XlQI3
 1EfikXQVxmJeI4nDrRtuDU08bu20S29cQu1gTVdBGKy3XbIxOHyoTPKvjY/nAddsAAB63Z
 dO4GJgFxZW18q9ZFS9lgCUtWErucbRHsCk1mH96wf1AkUzPDXddStLUYy5XyrGm5pby5sB
 O6807pisutjt4IH5UFol/YvpszrDW9CNIalwFBJ/prrHHV80aIWfxjGLJkfl0gLokQCp/k
 L5NhOQ2+q8kXd9GvexXXGBNCBxesXpTwoZo3+kKJrly0gblSN1hqA+RjxeRyNg==
Message-ID: <1b72905e-03bd-48e7-942b-1a32fdeb2100@mailbox.org>
Date: Tue, 20 Jan 2026 23:43:46 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: xhci: fix DMA address corruption in abort_td
To: ANANDHAKRISHNAN S <anandhakrishnansasidharan@gmail.com>,
 u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, trini@konsulko.com,
 ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
References: <20260120145055.233298-1-anandhakrishnan.s@dicortech.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260120145055.233298-1-anandhakrishnan.s@dicortech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: wwch4ncfxy8w9p5nw3gu96mib7boeor6
X-MBO-RS-ID: c307940548f42c9168d
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

On 1/20/26 3:50 PM, ANANDHAKRISHNAN S wrote:
> When aborting a Transfer Descriptor (TD), the xHCI driver updates the
> device dequeue pointer by converting the virtual enqueue TRB pointer
> into a DMA address.

reset_ep() seems to have the same problem ?

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
> Signed-off-by: ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
> ---
>   drivers/usb/host/xhci-ring.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 34eb4536f0e..9e0ff71710a 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -582,9 +582,11 @@ static void abort_td(struct usb_device *udev, int ep_index)
>   		TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags)) != udev->slot_id ||
>   		(comp != COMP_SUCCESS && comp != COMP_CTX_STATE));
>   	xhci_acknowledge_event(ctrl);
> -
> -	addr = xhci_trb_virt_to_dma(ring->enq_seg,
> -		(void *)((uintptr_t)ring->enqueue | ring->cycle_state));

-		(void *)((uintptr_t)ring->enqueue | ring->cycle_state));
+		(void *)(uintptr_t)ring->enqueue) | ring->cycle_state;

cycle_state is already either 0 or 1, isn't it ?

> +	addr = xhci_trb_virt_to_dma(ring->enq_seg, ring->enqueue);
> +	if (ring->cycle_state)
> +		addr |= 0x1ULL;
> +	else
> +		addr &= ~0x1ULL;
>   	xhci_queue_command(ctrl, addr, udev->slot_id, ep_index, TRB_SET_DEQ);
>   	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
>   	if (!event)
