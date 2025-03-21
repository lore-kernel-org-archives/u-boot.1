Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0CEC36000
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 16:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BD75809A4;
	Fri, 21 Mar 2025 17:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fnlGke5V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A58F9803DF; Fri, 21 Mar 2025 17:59:29 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC4D809A4
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 17:59:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-549b159c84cso2496228e87.3
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 09:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742576367; x=1743181167; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVzgu/YmvIezHkCBGWL9gYZorifQSwA+98U7CYX9XDY=;
 b=fnlGke5VjOA/ul+0mbL9tuMJ4vKtlGSx8ptqrytXlBWlL/jRYFC9siZ+ykDpyDwLQ4
 +dtRgPfiWeZTNMztiKb/Plo3BsxpWcsnMCWUE1N1wOU8yMokCsWHi0AmDaxJoUk8U6w7
 piGy9mXhtZ1xPoSqF5AXj3+2sjbMTuGJLbPTY5KhN75gnxUi1VPIvjZc5A1aIwxHcgVm
 AGxgdlbIRekb0tAFCALi88BnoHxI6qJFDPvMOdX1SPIcS8FB7AhM8TQGbQjbglMuvnbd
 IUHLO2NzVAzqjBuHBSEUJxIFFQ4XX5lSDX21NGKevrUA7154EnHASLVVOrcEuHnglY1m
 15ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742576367; x=1743181167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BVzgu/YmvIezHkCBGWL9gYZorifQSwA+98U7CYX9XDY=;
 b=q9CdP7D7FIzwih3N3zLmr9aybD9VEL5xLxZFAhQ+Y6xrYZFyejj2hNpawqOr9X5uIe
 VuZqr5lo1IkUslzXukaN18NQw6jdTxaKk6lon9xzuU3T2Bp3CP2TiAx57OovAYWlSZi/
 VE+xrjvpzz8OIMB3vKUk6dTJRa4/ONxu4OiTdSqQ+GtxnoNyxXmdiOeAHTutqPX1hejH
 CJy6h0WOfHKw3sfLIHAYtrtcAzUMT/LJO0EmMlDy45sptMY6+3wiT4g77hiAyatytu7B
 oytuJtCbzBgmrUg9MskHyCcaYUa8AO96EPXvXJktKDzmC9bzD+yVR8HF28BvADksnQGk
 cFAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Y5qR3uvzhI3D8g8v070QsRqcGVORi452jMEisjetnyssctQT7UVVqkbM8jPc2fqjfpSmiDY=@lists.denx.de
X-Gm-Message-State: AOJu0Yyl6Qukg+stPG6jD2ihAbrm0baFi/jPRkXdqP1QnaBFg+TrJFc8
 VqYXR34r/2GO5XvEcHNfpHVFEEgOikwpQj6xVct2PWj4/k9iDE3S
X-Gm-Gg: ASbGncs0w9W+JSWWzZ1PzF0KRm83sQboJsTm+ogRe9JVRhoeKklD/2UsuUC/lm016BS
 cPK9FzFoMybKPGJ75Ma/SEKkb4dXGvo5rnGJEAzPuZNLz6yOh4JaNeRVuAO83AHj2ItrFnRb9DQ
 RGHoem6vGlBMj9DADXxvnBvXnSZPI5pnQqzuf2dakScl8EHbB7cNKnpel2Sb+wMSRMRaFJtyCVk
 2WrdAFUyh9Vaq3tPNNq97bLC9SpCNmPmXAlun74yWrgtejgfBgfda2QH6XrfsPu8X0LaBMz306/
 ANQEw/5B+CBHOEDEec5blBD76tL11C2448KAfQO2KTkR7w+sJycEX68KtL7SX7WfjXkC03I=
X-Google-Smtp-Source: AGHT+IHCMAKZRqDP6Uo4pgT/ufXhtBnHss6DOtJXU5CJfWhG1g7yqVK/JdY1gQAbqlktrmAw4Z6G4A==
X-Received: by 2002:a05:6512:b22:b0:549:8d16:7267 with SMTP id
 2adb3069b0e04-54ad647995cmr1420752e87.10.1742576366761; 
 Fri, 21 Mar 2025 09:59:26 -0700 (PDT)
Received: from wpc.lan (host-93-124-32-178.dsl.sura.ru. [93.124.32.178])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54ad64806dcsm217907e87.96.2025.03.21.09.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 09:59:26 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Neal Gompa <neal@gompa.dev>, Janne Grunau <j@jannau.net>,
 Hector Martin <marcan@marcan.st>, Godfrey Mwangi <godmwan@microsoft.com>,
 u-boot@lists.denx.de
Subject: [PATCH v1 1/1] usb: xhci: fix calculation of act_len in case of using
 multipe TRB
Date: Fri, 21 Mar 2025 19:58:50 +0300
Message-ID: <20250321165853.742837-2-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321165853.742837-1-bigunclemax@gmail.com>
References: <20250321165853.742837-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Maksim Kiselev <bigunclemax@gmail.com>

In the case when the transfer buffer spans 64KB boundary, one trb is
divided into several. In this case, the size of the first trb buffer
sets equal to the size of truncated to 64K boundary.

However, this is not taken into account when calculating the actual
length.

To fix this need to subtract the trimmed size of first TRB buff
from the available_length.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 34eb4536f0e..89d2e54f20a 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -659,6 +659,7 @@ int xhci_bulk_tx(struct usb_device *udev, unsigned long pipe,
 	u64 buf_64 = xhci_dma_map(ctrl, buffer, length);
 	dma_addr_t last_transfer_trb_addr;
 	int available_length;
+	int first_trb_trimmed_sz = 0;
 
 	debug("dev=%p, pipe=%lx, buffer=%p, length=%d\n",
 		udev, pipe, buffer, length);
@@ -740,6 +741,8 @@ int xhci_bulk_tx(struct usb_device *udev, unsigned long pipe,
 
 	if (trb_buff_len > length)
 		trb_buff_len = length;
+	else
+		first_trb_trimmed_sz = length - trb_buff_len;
 
 	first_trb = true;
 
@@ -825,6 +828,8 @@ again:
 	BUG_ON(TRB_TO_SLOT_ID(field) != slot_id);
 	BUG_ON(TRB_TO_EP_INDEX(field) != ep_index);
 
+	available_length -= first_trb_trimmed_sz;
+
 	record_transfer_result(udev, event, available_length);
 	xhci_acknowledge_event(ctrl);
 	xhci_inval_cache((uintptr_t)buffer, length);
-- 
2.45.2

