Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499CDC3601E
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 11:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6870482958;
	Fri,  4 Apr 2025 13:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UgHEgW2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C12082958; Fri,  4 Apr 2025 13:39:36 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5B608003E
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 13:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-227aaa82fafso18149065ad.2
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 04:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743766772; x=1744371572; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQp7ttLf3ENCOAQwzMx9pBnlLzngDYJ9Eb6eE5jPCBA=;
 b=UgHEgW2w9kCEGLNRveviz1+E/+TIQkBeIhAZfZ8FuGpoT+NPoem+Fn6+0FiE+FcmSf
 MYjcAg3epO45hpyGgBadQuy3NX88tHOuuck61+Ekv8KAuqqSAh8WiJ2/cJ/+l2bPpTWn
 Ffv8hS2tcc6B+p7qIprGh+MLjm6XuCwObJAjhURkfDgIr2BUjC6bFvPkGxg6pGu6xQx0
 lcf+suf6FEX+WrXYcx9LooZVflu+0oquDG7hUiymidIrGPOeR7XrcDp8yCDBl2t/zelk
 2Mudj8cjoSLD8T+MhdV//0wehhes4SYYV83I3WCo1I9mgJQAllDCWST5XCOqRJenxh47
 PNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743766772; x=1744371572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQp7ttLf3ENCOAQwzMx9pBnlLzngDYJ9Eb6eE5jPCBA=;
 b=UpeHWh1+PibMZkgxKDQt4WTly/2HeO2/mVRbGlEIgFOFF5Q8HzViiIjfd/6uLetPLJ
 QFwXf7quU1RFqJe76n/f9/Ucf/ScyMr3MKSOoXXsENZYPV/qQcYKqPiFtQ7lbyYdewqP
 UNzmNsLqkWCW8DJFyKvJ9hMHGG6Tyqx3vIhpEwu7kdfl+oQf45fKmO+/Wj2x+dMcHhGk
 7erbaSbmveA78MVbE+s2yL1QuqqzYf3r8g7MKCjoQr9MK/nPDeNTthaIxxZgv6UBdnD0
 cohmiOR/9fCaHFtbTZcIo6Gwi2S5dEuZUrFtYIfQHQKJWJkC1VHihA/mc0G90f358trR
 3l9A==
X-Gm-Message-State: AOJu0Yz+gEdtJaDBYb6ycrUJPYdgmhNs5WHLb0m/l8pnOtz1u6kWGvit
 dsZfe3DG1GgstgeOnXe4W59u6P1HFfBqbW6k7iYnZDxzas9ihAJF
X-Gm-Gg: ASbGncsFuFvTEIXZADuVbRBzEX0WyozbY91038WCsbubb9cuDmCE78SbD1Zn58UQTLM
 1tUE64mP/pb9J7d0QvWCFz2I2CA+w3EK39Y7TYvRfbOMvCbgwduTzFzd2SfgzbZOcWh4OSmtIN4
 Qv6IBsw58Mnry6B+11XAmcOcK9E5rB4cSYL29IIMrUQ09sSX1gdEVK8GJgWyTse7sqd4EYbLaVv
 cKGqO73rsEDSKgMAk8FedSQ3SyRHQItMGnUzJ74SYXxUuul5Vdqf6v7iNJ7VmoIGWawuh670cVI
 jD6wrEGHc6892rxz038Slz6hf1Sbf/2Wg+5k3BccdzD9z4LxEAsPTfzwYqQ=
X-Google-Smtp-Source: AGHT+IGIx7PYsthHGT3+1qJW2bXkv6vc+44YK8BKAe7oRoqxyVli/88Gbb5z6+6ksZwvGRHBoPhT4w==
X-Received: by 2002:a17:902:c94b:b0:21f:2ded:76ea with SMTP id
 d9443c01a7336-22a8a1bb767mr44311475ad.36.1743766772392; 
 Fri, 04 Apr 2025 04:39:32 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f547:2f82:7e0e:5ee2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785ad857sm30191165ad.37.2025.04.04.04.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 04:39:31 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: eugen.hristev@linaro.org
Cc: u-boot@lists.denx.de, trini@konsulko.com, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 2/2] board: atmel: sama5d2_wlsom1_ek: Remove UART pinctrl
 initialization
Date: Fri,  4 Apr 2025 08:39:19 -0300
Message-Id: <20250404113919.3860489-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250404113919.3860489-1-festevam@gmail.com>
References: <20250404113919.3860489-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

The UART0 pinctrl initialization is already done by DM via
CONFIG_PINCTRL_AT91PIO4=y.

Remove the unnecessary UART0 pinctrl initialization done in board code.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Newly introduced.

 board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
index ff5e51ee3926..a0ecc4f42a90 100644
--- a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
+++ b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
@@ -41,15 +41,8 @@ int board_late_init(void)
 #endif
 
 #ifdef CONFIG_DEBUG_UART_BOARD_INIT
-static void board_uart0_hw_init(void)
-{
-	atmel_pio4_set_c_periph(AT91_PIO_PORTB, 26, ATMEL_PIO_PUEN_MASK);	/* URXD0 */
-	atmel_pio4_set_c_periph(AT91_PIO_PORTB, 27, 0);				/* UTXD0 */
-}
-
 void board_debug_uart_init(void)
 {
-	board_uart0_hw_init();
 }
 #endif
 
-- 
2.34.1

