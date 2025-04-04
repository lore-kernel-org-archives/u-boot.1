Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CFBC369A1
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 11:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C1DB828AB;
	Fri,  4 Apr 2025 13:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QGiTUFcM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D732826AD; Fri,  4 Apr 2025 13:39:33 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 239398003E
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 13:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22928d629faso19617335ad.3
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 04:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743766769; x=1744371569; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jc3zkh9lic4mmfwdgOPQDcgjuvVGKNkCoCe9a1uwHFg=;
 b=QGiTUFcMqNm8p63UMuGN7EvjdMJ9QK4iqocu+toqAGnAEQmR46uUaOt/rw3e1x5HKL
 O6Y0UPg83LzHxWVZJ2n+lbXor4I1GX54d3l4xq8mxjC1nViuGcrciY8PSWyrFVWo3Q6u
 QdEWffwDirNWt5nonw8GVIHPd7TvVJb7tSL8ANlscVbsNCUW/HLBRYTtSMp3I5xp/R9S
 nAkyCpwq35vtIP/O0ubk/4VRGp1RaPiGunQd5c5ekgA3vdfCo0PIkYEa+xJ08dA72/JU
 CNka2E1OOoofeCRm8ifuAu6TkNNUXTpKFAYGtjR3O0JPwVWSMVM5lfEOZtQtyXusN5tW
 GmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743766769; x=1744371569;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jc3zkh9lic4mmfwdgOPQDcgjuvVGKNkCoCe9a1uwHFg=;
 b=FiKAa2xJ7pbMDmoxaHI5b5IXbh+vL2/3Oda0hUPwYB7lU30y1oy6fnXW5JzlTncpaV
 /yb1oygXHNLR7hOqGX9WD5IK+aHCwr3zGGFHKZUfSwL7voaeFtMZJ6VnX6YuK73sjna4
 TQQ+aQSVXu14vGfCWIv+FRbFCXWgr7IYtQPm2QNrZqoHUH/+mMYDb2jKWIk9qtMtlnzO
 OXhuNd6w/NbxmU7T0NbB6yBmlOHEbGZD43GvCTTezDE87oXLriBEIoMKOBsgEIkestxo
 i8FutQ6OjSewICM5ynEo+Aus36ljEA7xakY+16YiQhiZnIB7CeFhSEJ582OUiiWvBh1l
 ARXw==
X-Gm-Message-State: AOJu0YyUoGfiMwjLuzb60WjADNZ3ebOUSF6GUGdVDkpbNfDi8t4HankA
 qkEzJGvkAEn6OtnG6H7OOLnow9PPbVPeR30xP8cTLNxq+jDg1vQ4
X-Gm-Gg: ASbGnculVcX2/DATgQ5wljahvQLb0KoB28lrt2ZBwsC9e3DGcwzJE/URhn+3ecGMopI
 sE8KBDr1IA46inCeIyjF3Cg8f5c1IpIRLvVvDY41zO6u9zoxU55+c74buqe5R6QNXwL1gZtKzew
 MTNceJ51pmWD2ahOgAUwqvtSCFOBSSWLRuCtyUeDxkmFhj4WwUBCJZRiS+wb76xCFqq1aJQbVTr
 S0VZ3JNKY2RirZHJ1nDRAZbGuI/A067H1emOjXyHPH8Hh1kPsQ79jH3QpNEDoz3EbUfWShjiOgC
 HAS6VxJgJZLDJTwGwRY0PUJuDddGXPxCqImGfMNQMZ34k+mJNI8MZ5EaOME=
X-Google-Smtp-Source: AGHT+IHEwpEi4ebyzdvvYRrX33rQRhMoH9oUrmY2GKpD21BFaO+Jkh+AMLF9J4tJqbd8YwzMsmgcjg==
X-Received: by 2002:a17:902:ce0e:b0:223:44c5:4eb8 with SMTP id
 d9443c01a7336-22a8a8ced6cmr38986545ad.32.1743766769523; 
 Fri, 04 Apr 2025 04:39:29 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f547:2f82:7e0e:5ee2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785ad857sm30191165ad.37.2025.04.04.04.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 04:39:28 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: eugen.hristev@linaro.org
Cc: u-boot@lists.denx.de, trini@konsulko.com, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 1/2] board: atmel: sama5d2_wlsom1_ek: Fix spurious serial
 output
Date: Fri,  4 Apr 2025 08:39:18 -0300
Message-Id: <20250404113919.3860489-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Currently, there are always some spurious characters showing up
right before SPL banner is shown:

RomBOOT
���=������
U-Boot SPL 2025.04-rc5-00023-g9ed4e2c45f25 (Apr 03 2025 - 23:23:17 -0300)
Trying to boot from MMC1

<debug_uart>
...

The reason for the spurious characters is that the UART0 clock is
being enabled too early, prior to adjusting its correct frequency.

Fix the problem by removing the early UART0 clock enablement in C code.

SPL DM code will adjust the correct UART0 clock frequency and then enable
it at the appropriate time.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Make the minimal change to fix the spurious characters. Improve
the explanation in the commit log.

 board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
index 04de1257eca0..ff5e51ee3926 100644
--- a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
+++ b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
@@ -45,8 +45,6 @@ static void board_uart0_hw_init(void)
 {
 	atmel_pio4_set_c_periph(AT91_PIO_PORTB, 26, ATMEL_PIO_PUEN_MASK);	/* URXD0 */
 	atmel_pio4_set_c_periph(AT91_PIO_PORTB, 27, 0);				/* UTXD0 */
-
-	at91_periph_clk_enable(ATMEL_ID_UART0);
 }
 
 void board_debug_uart_init(void)
-- 
2.34.1

