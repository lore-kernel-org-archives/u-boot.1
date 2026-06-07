Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E0FCD8C8C
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 19:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA8E584869;
	Sun,  7 Jun 2026 21:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VCSWLJSr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D12838BB; Sun,  7 Jun 2026 17:33:49 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FE89801A9
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 17:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-36ba706ab46so2326548a91.1
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780846426; x=1781451226; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=edcXFkgmM21FH7XFr/jwDETW+uD9OZG6wELlA82V5/4=;
 b=VCSWLJSrY0/J114DNKNNy3vyQ3glJ2RmwdPKTLyzlINludAWQi9xzhSq31OD3hD0U1
 j/1lJenmNMbgucEL4LAUDkcXVfmwFDbtJe+jkYgM9pP/tFLq3rRTETC2QVV2rlsp3ddL
 7E8LWM/OJ7UJW3qoqaQ2l8o59bjki3faSFANcBfvuEsmTnAMQMGeUamrhAktR5YXxEyF
 LhZ5VILlH1WCsiBPSOaFmgFQYLzOKCL+Te/wMXKbuPWIMTnETrKHiqk9HSyliREnn8F0
 qX7CF7OAPc0xIN85+vzCEOPMySjZ6TJQYwhClNGhBsHGPTu3XsSVzZlGF+hWaEZYM6qy
 xv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780846426; x=1781451226;
 h=content-disposition:mime-version:message-id:subject:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=edcXFkgmM21FH7XFr/jwDETW+uD9OZG6wELlA82V5/4=;
 b=mIT2XKlZa0O1xUJ9+5GQs7Q0WOJ3gIeiITshZ8PRYFd8YHaykzpgsBeW9bLYswBbgb
 tK6qq5MEXrqk1/iufSjnP529YXz759W8NI0buyfODsBjOC09YcPQ1+E4ESBQZGCSlZiT
 eDw3tP0cg39lE6OzZ7HIJse8FXiTLSsX74UXkkEsAVp31HWCbbeTvZjhX6S/VzeYcBq/
 C8ICY//oUzJLyZLUbdF8TkEczX53AzisDhjKK+RTyqJEngvfXjWFQCZatWnOu7vU3Cn6
 yySt0sTZlpedOftkW5eFiwVcZ+0AB2lSNSEz5VUBrTX323Mocu1Cq1WZ1HBeteiheEFU
 +/kA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7Xkm3dETr7OPRr6lmW+iX/lYTHsorwofSLnIvUiW8cxqFZCjJLvXTb+dByKNHTXwexwqZ5jQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7QLPfRjYHuKddA/FCJJcAwxIj9U/tjVjsUvbXr6Bg/9X62mXS
 Bg6m4MoWcr0iPO1Fct0CczZFqP0zIn2v0HPodW5sa/ToPOD4TAGh+yRsDABEGA==
X-Gm-Gg: Acq92OFNklqL4q+A7fUfASYRSczXcBKGq8phQH3gfuUV5fCX6Onels5FHi+fbsCf+eG
 9/cTqakmoBHjvbfiwalVlUbvwXzZwK2vulccU5dqAoJhz32r53CHxXpMmc7O4W2TdcxE7u8CfWI
 2H3JlkdaMDAgoaMOrUTM6m246jRdJWAxoWW6hcBy3vfSP4bIDz1xHJKlldVZmlAsLuHpWnPzdbU
 /tnaqBiRGvUw/1M2AVdiiP7QOdkjfkTJIa/j3jVtPUeFIKRixXFdP0jDK1G3hR8tJRKA0nbKm2F
 eXg/AU/ymj1WYZ9z7TdJe8+b50j4hpYL0mqkTI25dxabgcYeEvnQ9TrK3FKEtV1iSQbZHB+1pa8
 NU9XYKikRXggfwNj1XEwErlPXpFOHe8152/YbsnYQo7zIWD9EaXutEVjS41uqXLkh1z0LBFQCBZ
 iwAyMA16iKB/I0Fr/LAacWbt4GJPzx5JXY7g==
X-Received: by 2002:a17:90b:4a50:b0:369:7421:b36f with SMTP id
 98e67ed59e1d1-370f0c4ecf2mr12445638a91.21.1780846425627; 
 Sun, 07 Jun 2026 08:33:45 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428221a7e9sm19324243b3a.11.2026.06.07.08.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 08:33:45 -0700 (PDT)
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
X-Google-Original-From: Naveen Kumar Chaudhary <android.developer18@gmail.com>
Date: Sun, 7 Jun 2026 21:03:43 +0530
To: alex.nemirovsky@cortina-access.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
Subject: [PATCH] serial: cortina: check RX FIFO status before reading data
Message-ID: <wsktuup6zqzu7hr7f2asm2gqkoo6pksdft7f3ff3h5ek3slyw4@3dtswkklwpu7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Sun, 07 Jun 2026 21:34:32 +0200
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

