Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973D7C36000
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 16:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82857806D8;
	Fri, 21 Mar 2025 17:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dayJeltp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2EF5807D7; Fri, 21 Mar 2025 17:59:24 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44572803DF
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 17:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5499c8fa0f3so2622843e87.2
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 09:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742576361; x=1743181161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zSFqRQ87hagrLVBUNZlsgTNeM+Q7GGQtaBYc7zkIFVU=;
 b=dayJeltpS1M7bKfIVF5CNARDUx8alIFvTes6UQbF4XwfY2PEBcKJFUu0BMbUCQdXKZ
 l3R1JqdLB+AGyK20VnZRdqzUUm51WpZVQmLAcim77Ug3p2Y20zfm8XW4E2762qIb2PCj
 9HSF61anptmmIO02LVVFH60/b2I696IDYqofyvp2vP408EnCg5HYfMRwJooVrTOcLOrW
 PclOZ3TlJaX+rEO6z75sltyrfJJLhWv3w1DevD1yzW9PjKHQEBqhu4mdaAAX7O1j0WHY
 Mdx2LHWRKAtssE+2+BBeYTwfn5OtIsuIp7YT6ohqX5co0710OVQVgtguk9qkZIObOsE8
 cseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742576361; x=1743181161;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zSFqRQ87hagrLVBUNZlsgTNeM+Q7GGQtaBYc7zkIFVU=;
 b=jo4scLIbUg3P1ZYJZ07SjRnU9XWuYIJSRtOg5HLNkLJv6bYHhJPSFR+f+afppd6+xN
 133j8xaDXABWN90Z1k+NWTwHsfUEkuSYxD0YspMNwidVCwb5Kv1xhLxmBsNWXY2HX7vr
 cHSlz3u2/9oCG3pC+tZCrZTAUYrScGFoHUn6JS9xPqGiwuwa3BnG42JNTo4dC6B9g6MB
 B3srn2eDnIa1rA6x/+X+Jp9UcxhL19SvRf4/SZT+U0uBUnFXlzspoCZ7O8qn2G/b0oMq
 8kSr/vsefEjzjaOVp+FnBNuuzH/BMCPU3HzZgUANMVnD/yKSLLMqEkJaMxqf1JuQtABl
 EPWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4ubPxvHElh4IyDzh5RR2uWT/PuksyzOVOCifQlRhagqHD/2z6O11xLREhIgPQeszNaenxx/Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyD//fRaO9RXbDci9J37B43b8Hft0QSRxULethxYFovMJwropV5
 cvAd9DE3GdlQ4XIyXJIXiYE4+Y/Mi+xc3pPKNFpkljsocFmSWp7q
X-Gm-Gg: ASbGnctfSnTcdPC7c9h8cE0YZgS5QFB44t2UMX9+VJqqQeRD6oNB8+f9ktwaMbLYoTE
 +Zms+nhG3f+96Zu+Hi+MU0AFP/BJT1SyKeVJ3m2jkQrKtmrppIeLUaAY/x4dVrWn7TXNYvjyGbA
 6ZrpznAAR5et87q+dfkO46gkiTB/1GOs6qWTHcspwXi9CnyoySt2WyNjWVhTKpib7n0R58m9qG6
 Nq8VLcI8bHgI0YxrVmDHHdbF3iGu6yjoQFog6C624JNwfUStuyI+Vyt09oOzguFbcTo5jaV/uu/
 jt8zYsrKIHLuYpRS66UhC+7bomCaFL9S25ZkXQMteqspeY6oZ4+q/CRseKl2FD9dKIu/Bj0=
X-Google-Smtp-Source: AGHT+IGSVu4+FqGLAHzlHevIPNBlr0NjwCU/+B2q/lB9To8zx5agnuUc9HvwdvND0uou+mP29oF2NA==
X-Received: by 2002:a05:6512:ea8:b0:549:b0f3:439b with SMTP id
 2adb3069b0e04-54ad6494351mr1710236e87.16.1742576361154; 
 Fri, 21 Mar 2025 09:59:21 -0700 (PDT)
Received: from wpc.lan (host-93-124-32-178.dsl.sura.ru. [93.124.32.178])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54ad64806dcsm217907e87.96.2025.03.21.09.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 09:59:20 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Godfrey Mwangi <godmwan@microsoft.com>, Janne Grunau <j@jannau.net>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Hector Martin <marcan@marcan.st>, u-boot@lists.denx.de
Subject: [PATCH v1 0/1] USB xHCI wrong act_len calculation in case of using
 multipe TRB
Date: Fri, 21 Mar 2025 19:58:49 +0300
Message-ID: <20250321165853.742837-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
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

Hello everyone!

I've encountered an issue where the actual length of received data is
calculated incorrectly in the case of a multiple TRB request.

Below, I'll try to describe the essence of the problem:

A USB-ethernet adapter ASIX ax88179 is connected to my board Li4pi,
and I'm sending a DHCP request to the server via dhpc command.

The response from the DHCP server always has the same length (0x168).
However, in some cases, I noticed that the received response had
an incorrect length and network subsystem is completely ingnore
incoming packets.

The problem turned out to be in the xhci_bulk_tx() function.
I added some debugging[1] to better understand what's happening.

Here's the log from a working case:
```
    dev=000000057f786b90, pipe=c0010283, buffer=000000057f787540, length=20480
    PUSH. trb_len: 0x5000
    POP. trb_len: 0x4e98, comp_code: 0xd
    udev->act_len: 0x168
```

And here's the log from a non-working case:
```
    dev=000000057f78b610, pipe=c0010283, buffer=000000057f78bfc0, length=20480
    PUSH. trb_len: 0x4040
    PUSH. trb_len: 0xfc0
    POP. trb_len: 0x3ed8, comp_code: 0xd
    POP. trb_len: 0x0, comp_code: 0x1
    udev->act_len: 0x1128
```
As you can see, in the second case, the buffer spans a 64KB boundary
(buffer=000000057f78bfc0 + 0x5000).
Therefore, it is split into two TRBs with lengths 0x4040 and 0xfc0.

Then, act_len is calculated as the difference between length and
trans_event.transfer_len:
```
0x5000 - 0x3ed8 = 0x1128
```

However, it seems that this is not entirely correct,
and act_len should be calculated as:

```
trb_buff_len - trans_event.transfer_len
(0x4040 - 0x3ed8 = 0x168)
```

0x168 is the correct length, which is the same as the length
obtained in the first case where network rx works fine.

Also I looked at the Linux xhci-ring code where urb->actual_length
calculated as:
[2]
```
    requested = td->urb->transfer_buffer_length;
    remaining = EVENT_TRB_LEN(le32_to_cpu(event->transfer_len));
```
[3]
```
    td->urb->actual_length = requested - remaining;
```

Perhaps I missed something or misunderstood, so I would appreciate any help.

---

[1] Patch for debug output
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 89d2e54f20a..b1433a16a99 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -791,6 +791,8 @@ int xhci_bulk_tx(struct usb_device *udev, unsigned long pipe,
                trb_fields[2] = length_field;
                trb_fields[3] = field | TRB_TYPE(TRB_NORMAL);
 
+               debug("PUSH. trb_len: 0x%x\n", trb_buff_len);
+
                last_transfer_trb_addr = queue_trb(ctrl, ring, (num_trbs > 1), trb_fields);
 
                --num_trbs;
@@ -816,6 +818,10 @@ again:
                return -ETIMEDOUT;
        }
 
+       debug("POP. trb_len: 0x%x, comp_code: 0x%x\n",
+             (int)EVENT_TRB_LEN(le32_to_cpu(event->trans_event.transfer_len)),
+             GET_COMP_CODE(le32_to_cpu(event->trans_event.transfer_len)));
+
        if ((uintptr_t)(le64_to_cpu(event->trans_event.buffer)) !=
            (uintptr_t)last_transfer_trb_addr) {
                available_length -=
@@ -831,6 +837,7 @@ again:
        available_length -= first_trb_trimmed_sz;
 
        record_transfer_result(udev, event, available_length);
+       debug("udev->act_len: 0x%x\n", udev->act_len);
        xhci_acknowledge_event(ctrl);
        xhci_inval_cache((uintptr_t)buffer, length);
        xhci_dma_unmap(ctrl, buf_64, length);


[2] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/host/xhci-ring.c?h=v6.14-rc7#n2346
[3] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/host/xhci-ring.c?h=v6.14-rc7#n2413

Maksim Kiselev (1):
  usb: xhci: fix calculation of act_len in case of using multipe TRB

 drivers/usb/host/xhci-ring.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.45.2

