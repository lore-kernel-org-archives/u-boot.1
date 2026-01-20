Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFF8CA5FA6
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 16:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EB6F83AEE;
	Tue, 20 Jan 2026 17:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RsKoR2Sb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9B7A83A9F; Tue, 20 Jan 2026 15:51:07 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C58783A6A
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=anandhakrishnansasidharan@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a0c09bb78cso42303915ad.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 06:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768920664; x=1769525464; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VYFIbddIWPkvfhoLTsQHdSnEAgdgcM1ba27B6sH+VwM=;
 b=RsKoR2Sben6Sz+0MFh1A0lMj3y89ONRgFOwL1Ma86RX6iNyJtT5NE6Gk3nC0MgGPBx
 aZ0IBIskZ5jXHkSWyf4OKrfvU/6OjG+Dp9eDLY4sIGkvoo4Iuprcbf8OGji2YwVInnwK
 V+nRw/Y7y1JCSuvlRWH7GlQE+zPxs/rKp4abFLpbsf1XAUDAYeW8lo9I4KFfQcDZC9Xc
 nU0yhbjyQwus0cqo8iWanJBM9ZPQqfOKE88qkvMOx/pUC3pcFBb714OQ4EZ4yhUvaLFQ
 SuwcoRcvmKZvzyFxzW3MvTGXo7f+Zc0i0FyucE8T1rPXl1IMM0yKhyw4PIyGD3M4koAT
 puOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768920664; x=1769525464;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VYFIbddIWPkvfhoLTsQHdSnEAgdgcM1ba27B6sH+VwM=;
 b=l4KhVoTvVuGDtas+/exdV3B7eNYsM6tXuqhqVZu2A/wymIfyCknbxOMQdRSfNBrSqa
 gz1DL9fNAykXjX3gRYGxW5uzPMLxu9XT++yyixftyOWKW3QO2KVBHvbnkQoRQ+kQMegv
 nP60jX+eFa0jubSyzmZD8CPcCkb5UNW6Ymrf1HsXM/lGcQ8RX9/FezOUWn5NwmqwWyvz
 r39e6UQ2M91U618XHwsyQI+d2PXL8TI96khIg+aWwFCZnoM28Bsft2tHl2aV5/Gl7Vqw
 TMPWQaLBnF5BY+FZQwrb+Y4xDUnWmDjMTUBA2lA4AAUL15UUnMObobWXywoOvr2eOUAV
 IIoA==
X-Gm-Message-State: AOJu0Yw8PcDfJvChUeTvqMeahX+PFtQUqIheDfFCkSrMceXgO4MWx5mU
 WWoJnQi18/VGrhxucd+rNUUPHtgqOWLtZIUSNW8sR3F+jjEjsP3jam5FsgvQtw==
X-Gm-Gg: AZuq6aImyGREjEtnbytJ0fZT0r8Ynmopck6ZlYomFuMiw3ku7IDPIZ/CxmV6VpPNKup
 5TaSMWb+zeQYP50b71i4eSqpXPAoiyM4boPwZNWczpcF1CYMTdv5xjWxmc7O/6HDkFlFJYP7zJP
 bG6r1alJgfGuLWzDdbmsSuqkQk+HWEpm/HLVT8liFo45B18mcXun8sdo4V5OG8/corjmz/sTkVA
 uVE7NeMDGuVcB6bYlx2MiuYPAGQkkTiRq6kHZ80cwmQGGsoAj2aw6P/x4dbOquPUURReGk6LWJ/
 XlWIFvyzYNbS1FJvRBPQF/iLUSLlqrTFqBPwlDS373PjJ/JLlMBl5tF3xVXF0KgCSrPZxndk5qL
 AcvvSqHoG7sGz8MwOcCJ+TKU9/nvF4OjXeMpljk8MbQLtP6amnuIIOff7YaQU7Fs5SgkgXnvQxP
 98KpvOIQGvF9Zar2/82LECg/2U4NxZQn84sXy3sjcN
X-Received: by 2002:a17:902:f745:b0:2a7:9163:8e60 with SMTP id
 d9443c01a7336-2a7916393a6mr217495ad.23.1768920663607; 
 Tue, 20 Jan 2026 06:51:03 -0800 (PST)
Received: from localhost.localdomain ([115.245.213.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a718f79f40sm126980505ad.0.2026.01.20.06.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 06:51:03 -0800 (PST)
From: ANANDHAKRISHNAN S <anandhakrishnansasidharan@gmail.com>
X-Google-Original-From: ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
To: u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, marex@denx.de, trini@konsulko.com,
 ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
Subject: [PATCH] usb: xhci: fix DMA address corruption in abort_td
Date: Tue, 20 Jan 2026 20:20:55 +0530
Message-Id: <20260120145055.233298-1-anandhakrishnan.s@dicortech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Jan 2026 17:15:29 +0100
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
 drivers/usb/host/xhci-ring.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 34eb4536f0e..9e0ff71710a 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -582,9 +582,11 @@ static void abort_td(struct usb_device *udev, int ep_index)
 		TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags)) != udev->slot_id ||
 		(comp != COMP_SUCCESS && comp != COMP_CTX_STATE));
 	xhci_acknowledge_event(ctrl);
-
-	addr = xhci_trb_virt_to_dma(ring->enq_seg,
-		(void *)((uintptr_t)ring->enqueue | ring->cycle_state));
+	addr = xhci_trb_virt_to_dma(ring->enq_seg, ring->enqueue);
+	if (ring->cycle_state)
+		addr |= 0x1ULL;
+	else
+		addr &= ~0x1ULL;
 	xhci_queue_command(ctrl, addr, udev->slot_id, ep_index, TRB_SET_DEQ);
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
 	if (!event)
-- 
2.25.1

