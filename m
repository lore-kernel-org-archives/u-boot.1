Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7098D3EE67
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 13:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44AD6839DF;
	Thu, 22 Jan 2026 14:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZvIRiE/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85E088397D; Thu, 22 Jan 2026 06:28:17 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 375F780077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 06:28:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=anandhakrishnansasidharan@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so4162425ad.2
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 21:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769059693; x=1769664493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8MTATyQeJESt5PGxVxGZwqDQNMqXdhTi18QczYtyPfU=;
 b=ZvIRiE/QHcLbVBC12cDxtWRnRXbk4i1h11o+WZbrorLZggG3Cwb/dEJowbr3R6IFx8
 vCEbRc3dlS0xYvsXGVXzFSQfSoqR6iChhfYgj/sT/TyZWPEVWPtl9VI/jWZ3PI++R4i9
 ZPsVIRGhuWeZ24kZqpaIIu67alsWbEsTheeG6EIhkshF7SGm1LNywnK9qp5I7L1SRRpL
 U85/y5tK6ZN7oZFChuiuPj/X7UyPE0inCqueQzFQmWC8mqnPEtnlFUabxuC0jfMWTJNz
 nzW3rCBHVPzsnbFUjmY0bCiZzxCHgQffOhFId11ts//zhPbX+N2r4ttJDxdWYu8CFFHu
 rqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769059693; x=1769664493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8MTATyQeJESt5PGxVxGZwqDQNMqXdhTi18QczYtyPfU=;
 b=QBFDw5YmtWTUoyc7durit+Nok+GAALGP8LAMgBVHi3/gq6lkX8OW9msKWkC6dyh1I2
 Ah7x8ztVh160OiIeIAemJkfRq8f1ZdGwcfp0CGLKMRLBWb0EOf2JAAwAyQAzNHnsv/so
 6834INY+VbvhWnXQ+jgb0W2AJah+YsiY1Gbzh5SxADjE8V3nPH9V1hYsJZLn7w4t6HkN
 Mu8dZqXEaF3Vg+DQ6s4c7JJFRQ6vC31xjeXDUdGJaX8lW+cW9Gp38iVlgul+9udaatIB
 gn/OznStl4n1XZRj3GJ1wZdJ8KxRyGiyA4eUVxiiZ8XP0k330/9SCHxJ7W82ySsVOgc3
 qTag==
X-Gm-Message-State: AOJu0Yz3tlMkuGbqJ88Co3ELeizT8dYFR8jpFJgxID9dVJTPUmadqyH2
 d3GiS2adZdwTnxxw/PfTEEHUIVVE17/+rmsSitB3Y5EUE9gd+38ZrKkyhgGCRQ==
X-Gm-Gg: AZuq6aKq01b0oGM8nWol6B+pPAbMaegaFlROvxAfWsEPdGtldEsX9gFTDKwq5uovhxX
 0wyD1rPD5VJM8Uh+wn1Ehl5e9xCnJ1N16Hqp8HucdjGpQzvNzc9Q67CYTd7uzvfdhUNpUas3wSM
 k26UQ8EfSRIFiFLQCjQVsFlSkfEHmTdTayiTfjqfkuKHSye49xwpSYR0UOmy75rNNY5FCJywGBP
 OcoeEAjvkma5yXso1kZ6oqllmDjZxAY9SFkWqAJBfMnYcPy74J6NjvVsY4Vn25QX8O2f8uLv2vt
 SeebKz7h1UHQwVQ4njTZ/rpnOkWuBqq75bZn+ve+eMYHVT4AjkJvf5eZ4pSYXsLXAHvF6hZyBgs
 XrxBuejzZuQIqgifQy+TI2JlfxVVrptsdjBGSSL6vwredHQa1+uXm9V+HiyQUlagAWKM/ccDFDC
 Coy1Bz37wQ6CZJL2nIUlhTqTxjd6RdoPm+8S7GlRM5
X-Received: by 2002:a17:903:46ce:b0:2a7:90a5:2c95 with SMTP id
 d9443c01a7336-2a790a52e7fmr52516335ad.51.1769059693341; 
 Wed, 21 Jan 2026 21:28:13 -0800 (PST)
Received: from localhost.localdomain ([115.245.213.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a784af4269sm50745855ad.77.2026.01.21.21.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 21:28:12 -0800 (PST)
From: ANANDHAKRISHNAN S <anandhakrishnansasidharan@gmail.com>
X-Google-Original-From: ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
To: u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, marex@denx.de, trini@konsulko.com,
 mkorpershoek@kernel.org,
 ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
Subject: [PATCH v4] usb: xhci: fix DMA address corruption in abort_td
Date: Thu, 22 Jan 2026 10:57:54 +0530
Message-Id: <20260122052754.573814-1-anandhakrishnan.s@dicortech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260120145055.233298-1-anandhakrishnan.s@dicortech.com>
References: <20260120145055.233298-1-anandhakrishnan.s@dicortech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Jan 2026 14:41:52 +0100
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


Signed-off-by: ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
---
Changes in v4:
- Moved the changelog below the '---' marker to prevent it from
  being included in the permanent git history.

Changes in v3:
- Simplified the DMA address calculation by removing the redundant
  bit(0) mask (& ~0x1ULL), as XHCI guarantees the address is already
  aligned.

Changes in v2:
- Apply the same fix to reset_ep()
- Simplify cycle bit handling to a single mask operation

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

