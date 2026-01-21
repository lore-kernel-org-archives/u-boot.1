Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA2FC44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 15:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C956C83015;
	Wed, 21 Jan 2026 16:33:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Rct9mFo0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2139E8341A; Wed, 21 Jan 2026 16:33:51 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0684B80077
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 16:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dx7Wt1YbSz9thq;
 Wed, 21 Jan 2026 16:33:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769009626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32y8ssebXCX8rdO4JpWgVxwMIuKffOSdx/rYcvstnXg=;
 b=Rct9mFo0UcO9Ib6D8OaIwliGEGlEEkW2Yr8Vjhv4/4yElDeUL4oqSo3zAor0XbtUbRnxOs
 jN4EUOAxpzziOaCgy6TGvTDrpk/NbE3NiZEYeYyDyUQpuT8V4oJgEfbZ4GI84IEZ7YETlH
 bWiS1KDI5OPjywlah/e1LiOMtDoSDcUV5PhWX2SRYetgi7Yp82cgDsBxbrTlOwrdnHasTw
 oHeUpUfkFTJRBR6WAgkAdWz1ZbUSjpRYuZWDnk4yJQXSFIXDMKkKa7v2GcGNqxjK16qolu
 3//fpzhsz79RB9bJbk+wsRO+kPSiDs9DCG6Ouv6sqMBhD1zQXQeo8BCqHCh+wQ==
Message-ID: <151bebd8-9de8-494b-99b3-850da10d3a04@mailbox.org>
Date: Wed, 21 Jan 2026 12:09:58 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: xhci: fix DMA address corruption in abort_td
To: ANANDHAKRISHNAN S <anandhakrishnansasidharan@gmail.com>,
 u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, trini@konsulko.com, mkorpershoek@kernel.org,
 ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
References: <20260120145055.233298-1-anandhakrishnan.s@dicortech.com>
 <20260121101207.432503-1-anandhakrishnan.s@dicortech.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260121101207.432503-1-anandhakrishnan.s@dicortech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ritdd5xgixwd9o3qyyk5n4gnsp8ura3n
X-MBO-RS-ID: f4de031b39ea1b6b3c4
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

On 1/21/26 11:12 AM, ANANDHAKRISHNAN S wrote:
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
> Changes in v2:
> - Apply the same fix to reset_ep()
> - Simplify cycle bit handling to a single mask operation
> 
> Signed-off-by: ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
> ---
>   drivers/usb/host/xhci-ring.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 34eb4536f0e..229882a9dbd 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -523,9 +523,8 @@ static void reset_ep(struct usb_device *udev, int ep_index)
>   	field = le32_to_cpu(event->trans_event.flags);
>   	BUG_ON(TRB_TO_SLOT_ID(field) != udev->slot_id);
>   	xhci_acknowledge_event(ctrl);
> -
> -	addr = xhci_trb_virt_to_dma(ring->enq_seg,
> -		(void *)((uintptr_t)ring->enqueue | ring->cycle_state));
> +	addr = xhci_trb_virt_to_dma(ring->enq_seg, ring->enqueue);
> +	addr = (addr & ~0x1ULL) | ring->cycle_state;

Can addr actually ever have bit(0) set ? If not, addr & ~0x1ULL is not 
needed and you can literally addr = xhci_trb_virt_to_dma(ring->enq_seg, 
ring->enqueue) | ring->cycle_state;
