Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EC4C44522
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 12:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6A5883B63;
	Wed, 21 Jan 2026 13:15:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OGYIM6Cb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 094A783A6A; Wed, 21 Jan 2026 11:12:19 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C327C82A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 11:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=anandhakrishnansasidharan@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a78e381fc1so4960255ad.3
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 02:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768990335; x=1769595135; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CprBYaHamoaZVRXtRcD23uyknsYdWZ5spYv4L8fl+68=;
 b=OGYIM6CbCY0MsLhnV5senWRAFuBq14l7SyJix6GP06MyXdDLBKpcFPMzM24LPKOGGi
 uYNfO7CZfS0X00rAwe618u/W8OpS8Qe0BEzFvPFzLsytUnPJOx9mjzwpP0ETXIbyfTWX
 PWGZeyye9tHZZ6fDh0WonfpBT6kUTIyDnFj78p70N/E0j6HDHReuBL/Cj+zo2lZXreda
 F8TNjDckPQHlRzdgYUakM6ESCSeCXBIqZY0iTmpmJahYXpdB9Ya7M20dzqplBNhvt3h/
 Sjh59mOaB+ojNWNi9+Ol5pK5+fS43+wwY3WSs9d84W3ckAUcmeOmM2K8sE9NPmRDyh8E
 nmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768990335; x=1769595135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CprBYaHamoaZVRXtRcD23uyknsYdWZ5spYv4L8fl+68=;
 b=ZTEjsW9Wm/9G428PXM7feXsYnfktHsg4F+UHviZM1G9qNAAWJQEZTzAEVyT88hEYn6
 4jLPLnY2pNrf0lh7aM81He+C4P0uQQtt7anfRJDK4qCL6qHJXvYc7rS1trWexhUFlBkG
 5bNtGzyNLyUgK6uWdLJcS71ePLfzirJUCXLonYVmxS3J6Iy7iYG8+sBznopFGm3ARK5b
 4ZXuMMQ8dP77ZaJ+7H6SIYTnulVBb5upIL6fmnYsAaAYezD6nQxXf+sE/nzazK11W6yt
 bkwVEZG6E29lNhaU7A0Qq9GitX1t9FebtMhbnzZhLnfeONFm3kAJqKGmdCrriE8bW5fz
 aQYQ==
X-Gm-Message-State: AOJu0YwU+CzGSKFxeg2LhjSrYIVJqHdCpey754rmfcLx0CjK4wMHGPFP
 bYg2BCk/qYQ8atzv0FSBB7ltEc1HZrUhFZkThmmQCQVykafrXGDq3RATW3W/Ew==
X-Gm-Gg: AZuq6aIMMaA4pgSn3FyKru1Eq+E4RnzNnvYiq+PSkfKbe2V4+rBN41YG1fnv+kbRMM1
 memfiQB3jgBrxlXBQqp7JZKG4tUKZReJHaWqGRO6bGd7yJTDTwtkcctBb3yn+1KHn8LmuF88ud4
 5nClI8Srr9pXcBgVPdywsKhnMV/dSyt+Qo0NzNXcKdvq6wm/qi9v4TUp2ZQWIGPhl7IrCWOAgLc
 gtzRs6ms5CJYwD4zmtub5/kuhrHyxw6q75cy66tr64dsKypuMnuLRd/10LwvunTwHPQJsyXSbmb
 5Dd+b7y3yHbGiAcnhECzs0h1aUJE7dFySIAI5LI7xMlwrj1fuP/COh6PjYf59icDjIkgtTBMV8h
 PQKqkUB4VN14m29E5X/PjPRkeQkweI4gIPnw4em/JLd35im2UirUz4VPotdrqaznZEYFLAVyiqg
 C6CLFnv13/j+vl5BKQWVY+qm4ffslNFfq58McbRx0u
X-Received: by 2002:a17:903:22c3:b0:2a7:561e:690d with SMTP id
 d9443c01a7336-2a7561e6bfamr46394125ad.46.1768990334996; 
 Wed, 21 Jan 2026 02:12:14 -0800 (PST)
Received: from localhost.localdomain ([115.245.213.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ac779sm147604225ad.21.2026.01.21.02.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 02:12:14 -0800 (PST)
From: ANANDHAKRISHNAN S <anandhakrishnansasidharan@gmail.com>
X-Google-Original-From: ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
To: u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, marex@denx.de, trini@konsulko.com,
 mkorpershoek@kernel.org,
 ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
Subject: [PATCH v2] usb: xhci: fix DMA address corruption in abort_td
Date: Wed, 21 Jan 2026 15:42:07 +0530
Message-Id: <20260121101207.432503-1-anandhakrishnan.s@dicortech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260120145055.233298-1-anandhakrishnan.s@dicortech.com>
References: <20260120145055.233298-1-anandhakrishnan.s@dicortech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Jan 2026 13:15:54 +0100
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

Changes in v2:
- Apply the same fix to reset_ep()
- Simplify cycle bit handling to a single mask operation

Signed-off-by: ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
---
 drivers/usb/host/xhci-ring.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 34eb4536f0e..229882a9dbd 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -523,9 +523,8 @@ static void reset_ep(struct usb_device *udev, int ep_index)
 	field = le32_to_cpu(event->trans_event.flags);
 	BUG_ON(TRB_TO_SLOT_ID(field) != udev->slot_id);
 	xhci_acknowledge_event(ctrl);
-
-	addr = xhci_trb_virt_to_dma(ring->enq_seg,
-		(void *)((uintptr_t)ring->enqueue | ring->cycle_state));
+	addr = xhci_trb_virt_to_dma(ring->enq_seg, ring->enqueue);
+	addr = (addr & ~0x1ULL) | ring->cycle_state;
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
+	addr = xhci_trb_virt_to_dma(ring->enq_seg, ring->enqueue);
+	addr = (addr & ~0x1ULL) | ring->cycle_state;
 	xhci_queue_command(ctrl, addr, udev->slot_id, ep_index, TRB_SET_DEQ);
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
 	if (!event)
-- 
2.25.1

