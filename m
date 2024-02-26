Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A71C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 16:32:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACA1487CED;
	Mon, 26 Feb 2024 17:32:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Sxr2BtFj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EBA787BFD; Mon, 26 Feb 2024 17:32:43 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8E3687EDC
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 17:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2B7713F6E8
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 16:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1708965159;
 bh=5jCREzHh8KZwx785zYsah8IIsOFJ601ohliO1qgmJT4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Sxr2BtFj385JuQb/Qk2fz5buTlJ7ID0lDq02iSkbLIVWW6+jJ7AahVWXjQBG7XihX
 U/qbVKjbARckamMwB9WT934nQnyuK8Kb008zJk2J81wXVeuHKG5FIGQTfXFN/MCBuR
 SRxZAE5/gxgx9B3QbDUY2IEVCREoR7HUp9IKWI1GpruiRsF9ZyYSSm7n5ypkNd6hOF
 rkAK2ywsL1tEzgSc+n1HyhAetP4irL9Q04pEIuKbVrLXns5UvlPdQC7djECabMGcpI
 oW/53bly5VIkVvYweZ4QLR11MBiy1iuWAJwaHgL2WdGmm8HxBP2332eK01lm34NUzl
 HVTKE4o8jr/vw==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3ee69976dfso125317666b.3
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 08:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708965158; x=1709569958;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5jCREzHh8KZwx785zYsah8IIsOFJ601ohliO1qgmJT4=;
 b=ajRTELUKr1vFLbmMpVKr7rHbaTNpI7wzr7h8ZoVYdq7yJGWOWEd/DqqTyQsoU4RTa2
 ViCAfP5Qn6XDttlK1+E8GIL0stXZI0WqrIS4vmn3zf8vQrZcy+LzUtmFyeMPCXEniEvg
 KyoQ0EnUG3Xo4sDdp8FrlYESdaFKa8+6AJIgCvJrsxjaLL0ZRcftNQCdNBrOWVilenJB
 V4po3hJuQzvJu6uZeTmvqPPgIku7YkEofFgv2EcIVqyrxiYxGNpNWuVIbDO3+jP4B4ba
 Z+AxRGX/1b25qMY7UprmdLQ1N4Oa0s5wugK9ow4MDrQu1nSfvtOf10p3xqaFR5RAkELG
 PUoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+4prwoo9gt8Gz4zHlvW1vlUDk9rHEvd9B/G9u+OhiS9rEC1AYH2P4/y3g65JyNipK61wDN/dw7HvtOAly7Yan2ZtZRQ==
X-Gm-Message-State: AOJu0Yw7cdRgLXQrbkPaAq98BMeYKCxDw4OYQ53TKBzQbvVE3GABuV4o
 4Ug1YXtz0zISF/r5md8kqmOesVeFoyiumETUF6wPTrSPjORVhQ4gZKl4kk50Cwe8rpqD4Ww3v4x
 WS9FfGHnEFFA+udj19PMWlf24OXpnVuQ2ZhzAJG0xM+U68WCbBETrzjcYLSRZC1BlUI4=
X-Received: by 2002:a17:906:b24c:b0:a43:4107:137f with SMTP id
 ce12-20020a170906b24c00b00a434107137fmr2541614ejb.18.1708965158831; 
 Mon, 26 Feb 2024 08:32:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIGxjr2EWlDb5Ofm8xz+9If5UBpS4IUubwH1BqAo1mRFZcZ2++SgxjI3GH2ioABG75B2nXzg==
X-Received: by 2002:a17:906:b24c:b0:a43:4107:137f with SMTP id
 ce12-20020a170906b24c00b00a434107137fmr2541604ejb.18.1708965158446; 
 Mon, 26 Feb 2024 08:32:38 -0800 (PST)
Received: from workstation5.. (ip-109-42-179-76.web.vodafone.de.
 [109.42.179.76]) by smtp.gmail.com with ESMTPSA id
 cw16-20020a170907161000b00a4306ac853fsm2108400ejd.206.2024.02.26.08.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 08:32:37 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] serial: move sbi_dbcn_available to .data section
Date: Mon, 26 Feb 2024 17:32:26 +0100
Message-ID: <20240226163226.126288-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

U-Boot SPL loads the device-tree directly behind main U-Boot overlapping
the .bss section. reserve_fdt() is called in board_init_f() to relocate the
device-tree to a safe location.

Debug UARTs are enabled before board_init_f(). With sbi_dbcn_available in
the .bss section the device-tree is corrupted when _debug_uart_init() is
called in the SBI serial driver. Move the variable to the .data section.

Link: https://bugs.launchpad.net/ubuntu/+source/u-boot/+bug/2054091
Fixes: dfe08374943c ("risc-v: implement DBCN based debug console")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/serial/serial_sbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/serial_sbi.c b/drivers/serial/serial_sbi.c
index a51a96c1ef0..f3ecfccab43 100644
--- a/drivers/serial/serial_sbi.c
+++ b/drivers/serial/serial_sbi.c
@@ -17,7 +17,7 @@ static inline void _debug_uart_putc(int c)
 
 #else
 
-static int sbi_dbcn_available;
+static int sbi_dbcn_available __section(".data");
 
 static inline void _debug_uart_init(void)
 {
-- 
2.43.0

