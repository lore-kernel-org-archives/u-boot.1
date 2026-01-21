Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA87C44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 17:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6968483015;
	Wed, 21 Jan 2026 18:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FSzmaMmb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F13E839D5; Wed, 21 Jan 2026 18:07:29 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AD1980077
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 18:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=anandhakrishnansasidharan@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-352f00d0e83so48351a91.2
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 09:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769015245; x=1769620045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQa0gQE+Kv8RiUCIJgw2mzIkvFp4D6Vr8l4y/qyLi6Y=;
 b=FSzmaMmbPDUnTAmYgtqXW22RtGdcn89SsfIqAb6wBaXAJwh5m2Y3MbCAZN6fFSdEO2
 9eJ5bIdvtIM3aBY/H4IcL07Bfo5x+8GkLDgY/pEzI2rmZQIYuHiabkLbQUKOlYgjdZGl
 XZ+tGfRZpgB0pSW39408mnyw7Wrjov2AHpQpsFIJQxUSo5mYefZs9ZrG59UUeGkyq8eo
 diPDL9bkGMcJj30WzKJ3LpWFM9OuDbbep5k/wXF+BswzkAAAg0sDPOIu7/KDZ26lMR14
 40y1tn+rTCqszd3KxTfb/R+MY5iYR6SsBZICykO7bpUwKxWkysamLTi1DV4Aad3q/eCr
 V+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769015245; x=1769620045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fQa0gQE+Kv8RiUCIJgw2mzIkvFp4D6Vr8l4y/qyLi6Y=;
 b=pF0x88XHBPbuHkIC9D86yfDH6UL+lLoAsiA7segGvpZYLbf1PS5m/5X5ZUUyArN2F2
 DY0v+IlgziNeWsSjFVZxO2rryFVDm9ugWeb6Y/qbrpELDOY/6FJsVcRAb3bRSMIgADNG
 U3tqjcxM4oH2hztLgl6eQgsI0ScTYKvlsBDBmD2fBRzAlR7I6li9VWCCO8pXwVZLcON9
 vfca25oySaX0ovLlBC7joLL1o3/ulSgRkvlL/6n3fPbSoJKswLd7v+N8SUlGFZQd1ITL
 aurJR/2e9Nqy9cl+6GJVnHpLhSTdpj0hvsNnQ9F4ih5lOrZviLf7/iI0RT072yCCUHRV
 w6EA==
X-Gm-Message-State: AOJu0YxmfzxX4acgF13o/52H5njPZpIZLdfX7WBXWIqn5sExtOMtPOxe
 AbED+VWnEaXix1TTcHHYnagkTFgZv4kdLg3xscWvXHCpmEkMF0isBteMC0W10A==
X-Gm-Gg: AZuq6aLIBim2Wl2DdkI+tjWvfztRnjDg+Mp1iIoyO/YmqkJj2E4aJDuRtRZjbWFPPOT
 2qRXULt2igpCKPrwY9wo0rKgbRl5/i9IKE3jjlQn2bfbMVd+yGgwrurCNqKdWow6f8EhlMz7bDz
 bw+9JqznjjoLHOKehu+A7ameK+He7YWf0+JygFwEJqn9lywdwKixY0duBlxH28mg3TOeDtd1UAd
 KRqTP9U6Ge4NSBauvexut0nmkSma8tSWm/FNvAsYJIEGe4bP5HQXE/m3FgFT78TNDl8hywGYAWo
 oIWdZabq6Kfaa0p8RP76UOTJWKl2LbJ3K//hsbjt3EJiYM5GE7/d6X7tUyn7hGxFWLSEAtlxrjf
 EpmVlwbrov3VqQXL6i9mHrFisw7iTLJXhWORdgRinZLGaf39bJfivs89497E18y4dOS0wrC8ULJ
 crUBFGDa2tEnwuOITUGre+/+YI0RQ5+hpZCEOEtXEF
X-Received: by 2002:a17:90b:4b8d:b0:34c:2db6:57f1 with SMTP id
 98e67ed59e1d1-352c4079eadmr4910630a91.30.1769015245122; 
 Wed, 21 Jan 2026 09:07:25 -0800 (PST)
Received: from localhost.localdomain ([115.245.213.202])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35303820dfesm1092373a91.12.2026.01.21.09.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 09:07:24 -0800 (PST)
From: ANANDHAKRISHNAN S <anandhakrishnansasidharan@gmail.com>
X-Google-Original-From: ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
To: u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, marex@denx.de, trini@konsulko.com,
 mkorpershoek@kernel.org,
 ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
Subject: [PATCH v3] usb: xhci: fix DMA address corruption in abort_td
Date: Wed, 21 Jan 2026 22:36:31 +0530
Message-Id: <20260121170631.556826-1-anandhakrishnan.s@dicortech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260120145055.233298-1-anandhakrishnan.s@dicortech.com>
References: <20260120145055.233298-1-anandhakrishnan.s@dicortech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Jan 2026 18:12:08 +0100
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

When aborting a Transfer Descriptor (TD), the xHCI driver updates the
device dequeue pointer by converting the virtual enqueue TRB pointer
into a DMA address.

Previously, the code OR-ed the ring's Dequeue Cycle State (DCS) bit into
the virtual TRB pointer before passing it to xhci_trb_virt_to_dma().
This produced an unaligned virtual address (e.g. ending in 0x...1).

Inside xhci_trb_virt_to_dma(), the offset calculation:

segment_offset = trb - seg->trbs;

operated on this unaligned pointer, resulting in an incorrect TRB index.
In wraparound cases, this caused the bounds check to fail and the
function to return 0.

As a result, a SET_DEQ_PTR command was issued with a DMA address of 0x0,
leading to controller hangs and transfer timeouts, most commonly when
aborting TDs near the end of a ring segment (e.g. index 63).

Fix this by translating the aligned virtual TRB pointer to a DMA address
first, and only then applying the DCS bit to the resulting physical
address.

Changes in v3:
- Simplified the DMA address calculation by removing the redundant
  bit(0) mask (& ~0x1ULL), as XHCI guarantees the address is already
  aligned.

Changes in v2:
- Apply the same fix to reset_ep()
- Simplify cycle bit handling to a single mask operation

Signed-off-by: ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
---
 drivers/usb/host/xhci-ring.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 34eb4536f0e..6f5c4ec97b6 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -523,9 +523,8 @@ static void reset_ep(struct usb_device *udev, int ep_index)
 	field = le32_to_cpu(event->trans_event.flags);
 	BUG_ON(TRB_TO_SLOT_ID(field) != udev->slot_id);
 	xhci_acknowledge_event(ctrl);
-
-	addr = xhci_trb_virt_to_dma(ring->enq_seg,
-		(void *)((uintptr_t)ring->enqueue | ring->cycle_state));
+	addr = xhci_trb_virt_to_dma(ring->enq_seg, ring->enqueue) |
+		ring->cycle_state;
 	xhci_queue_command(ctrl, addr, udev->slot_id, ep_index, TRB_SET_DEQ);
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
 	if (!event)
@@ -582,9 +581,8 @@ static void abort_td(struct usb_device *udev, int ep_index)
 		TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags)) != udev->slot_id ||
 		(comp != COMP_SUCCESS && comp != COMP_CTX_STATE));
 	xhci_acknowledge_event(ctrl);
-
-	addr = xhci_trb_virt_to_dma(ring->enq_seg,
-		(void *)((uintptr_t)ring->enqueue | ring->cycle_state));
+	addr = xhci_trb_virt_to_dma(ring->enq_seg, ring->enqueue) |
+		ring->cycle_state;
 	xhci_queue_command(ctrl, addr, udev->slot_id, ep_index, TRB_SET_DEQ);
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
 	if (!event)
-- 
2.25.1

