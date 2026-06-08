Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB8ECD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AB1684910;
	Mon,  8 Jun 2026 15:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XA+VzpXl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4206841C2; Mon,  8 Jun 2026 15:16:28 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB13183EEF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-36b8e1760ccso2542322a91.0
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780924585; x=1781529385; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=edcXFkgmM21FH7XFr/jwDETW+uD9OZG6wELlA82V5/4=;
 b=XA+VzpXl8M3Fab0p8QLO7QiwO1Qt/0C01f8KFvUc71UNzMgMnahDWYV7ulWvGTUH8A
 hrfnna1R7BAB8VHnN2kiwrNtPD8N9sDkLCW+MwnVObjJlDZ/kX4PoyR7ndv74BjbG5/d
 S5/XBnYG+8qKUKCHhhSg0+4/8r5s4dJzNiCV5lzS2h8W/z7o7mkEsdaaLZJRlWYmst2V
 0DVQK+6Uvm6zZW/9X6Cm4oOiNMN8WCe9oxg7pGNy9oPyMx7Gea0vXeLsA/ODQhjA3Vop
 ZuuhIMwWdNIf+9zqEe6RLdRUaiNExsBqrdvpzGPsZmoM2efryVhWZlzr2oKxJT3r0zoE
 X2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780924585; x=1781529385;
 h=content-disposition:mime-version:message-id:subject:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=edcXFkgmM21FH7XFr/jwDETW+uD9OZG6wELlA82V5/4=;
 b=IFRIrH4H4QARZ8yRjuTYdiH2M5snshp+e54oUAzQ9ufuXJwbqHKpYjUfXpDpxY2JU7
 liURfekMJXCXUPoixKpubnz/JgWZt4I0b0kf7pgMX6nfS5OKvPs3D/+zdlXz59zyZn4c
 Ph+39ZplTzdEtST4hL1oKkAO7fJWfCybmyV3YWBcRVuuDyCrBRpoKlEzb7+J/2umfVrA
 qVq/TquiZsY3i+6CoBPK8gvgnUqa17D5xLhn+g9JPTnTcNnBMGoBxJ9ADFDz1CajHzZK
 z+Xdg8hBsbVKcIZf02ixucwCAnxyTekqGRcz7dhvmUsjvwrBgNQEYLPr/STWmzHjl7M0
 juCA==
X-Gm-Message-State: AOJu0YzCpokw/HeF51kZyT6dtODwXwfOKB/ny39doVGJRP+4wiyMKJSW
 Bc1VGgBMn6QoeQdNa68GeC6Rg8PLCxlfqF8KnJbSgg1FSQobmJJW3pfi9eGIh72x
X-Gm-Gg: Acq92OFzWywjaE6bRZiSDyobYVeEnI9iyc4saDkty9W6TCIytIY1bKE3ebRt/HqJcty
 PD3ketvmoVr0O0v+KOgELUnuhup3ui/l/uD5sH04+DPIfJpxCkOMcF7ftIy6hcdp6ynA0hSwOPo
 xoW5YWSEYK9hR6n+xtjPweVEE8BZ2PUb3ON/1LSwPcEgwGK4cmk7mGu7UWzUm60vMgHFbn8KM7k
 7xxWain6XI9nY4kj1q6Q+cqsvR5T7Lhl+36xuEa6iCBY60+l1jNhz5zD7qTOEt1oarxp6HmyDim
 NVWHljzlxr6n5kjQUsvXLP8rZcFmQaY5YpTsZYgIMC1oC+jK3mcHmDNwpdKDzF/lgJTiZhXx7qu
 +PqScxycUj685ngJSWtgVe5eNRaAVJ7yzs2RvFI622LIXdO8HHC4feFB9gRHZPcqSJa38fuA3Ae
 vPTtK58FFjKAGWFTLNJWjKTBW/O4ASCdykexw=
X-Received: by 2002:a17:90b:5207:b0:368:6159:980c with SMTP id
 98e67ed59e1d1-370f037fa36mr16918265a91.20.1780924585100; 
 Mon, 08 Jun 2026 06:16:25 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6c668e98sm16562921a91.5.2026.06.08.06.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 06:16:24 -0700 (PDT)
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
X-Google-Original-From: Naveen Kumar Chaudhary <android.developer18@gmail.com>
Date: Mon, 8 Jun 2026 18:46:22 +0530
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] serial: cortina: check RX FIFO status before reading data
Message-ID: <aw33sgdo3pwg24enxxjyu6conersjsielblba7oqv4lx25eav6@k5pvk5uhjylu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:33:39 +0200
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

ca_serial_getc() reads from the URX_DATA register unconditionally
without first checking whether the RX FIFO contains valid data. When
the FIFO is empty, this returns whatever stale value is in the
register, which the DM serial framework interprets as a valid
character.

The DM serial framework expects getc() to return -EAGAIN when no data
is available, so it can handle retries and call schedule() to service
the watchdog between attempts.

Add a check of the UINFO register's UINFO_RX_FIFO_EMPTY bit before
reading URX_DATA, returning -EAGAIN when no data is pending. This
is consistent with how ca_serial_putc() already checks
UINFO_TX_FIFO_FULL before writing.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 drivers/serial/serial_cortina.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/serial_cortina.c b/drivers/serial/serial_cortina.c
index 3ae8fb46584..de8af5b0574 100644
--- a/drivers/serial/serial_cortina.c
+++ b/drivers/serial/serial_cortina.c
@@ -83,11 +83,13 @@ int ca_serial_setbrg(struct udevice *dev, int baudrate)
 static int ca_serial_getc(struct udevice *dev)
 {
 	struct ca_uart_priv *priv = dev_get_priv(dev);
-	int ch;
+	unsigned int status;
 
-	ch = readl(priv->base + URX_DATA) & 0xFF;
+	status = readl(priv->base + UINFO);
+	if (status & UINFO_RX_FIFO_EMPTY)
+		return -EAGAIN;
 
-	return (int)ch;
+	return readl(priv->base + URX_DATA) & 0xFF;
 }
 
 static int ca_serial_putc(struct udevice *dev, const char ch)
-- 
2.43.0

