Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74768CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 13:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A16118331B;
	Thu, 28 Aug 2025 15:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Op6xcUp8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21D488331C; Thu, 28 Aug 2025 15:03:45 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED36C8328F
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 15:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 40A163F71E
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 13:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756386222;
 bh=ICeGV9TQXNOo/upeT4h+7gRnQ1VDvXJ7Rj/LFjxn2DA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Op6xcUp8BxS0lNa5IVMNOxRw9M15nRHR7FZxqiMbxpvSUv7Xh8h5melqxkufaLSta
 XhfPNnewnMNEpbDh2C0LUXGF1cL7c51hWSg150sYqPBlDU8hjMD8rW57s8wl7Xd52p
 GYz8UBe9VDy4K360WDGq8qiJD4QcJlcoG6BpiLMfKvKiKM8IrsYBVv/eovb69xKuBk
 V2A669dKVW+JWNsZw2E3GtrjqeQe/TnpolIXpzDyVrC2N1ZkSRkZdfFZhQW6nDlJPY
 ZRzLkoYoZuWCGyDlHSdFlXxbeDWfiV/uajMdgAVnHctFOMXBz6QOtpwoJKAAX4vuBd
 FJtyQxLf7H8bA==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b0caae1so4808835e9.3
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 06:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756386222; x=1756991022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ICeGV9TQXNOo/upeT4h+7gRnQ1VDvXJ7Rj/LFjxn2DA=;
 b=ThItWs4ua2tL0CaBQEwXM0U7CIbzX8knQAjP7z05vKQRRkC95kWvvLzntrDzah7tIG
 vIlnmkovWknJxvyseDOJqnMQnk9cdiub/Fjy4Ins/fCQU7Tkd6VpWU8dSO/tZP/a/7Pj
 fkZRoSkFSOS4gL01g8FapXffn7tncv31YTX+UC0zsrpbcMg0kyXAVjk/I5W77aj7D67D
 aj33/VfyU9EWpp12lXBa3cZMVWBTw47SbSl6JX/4EFrmZKIRURkZopY24jajgKQD4j8t
 bKldLjGWK1s6a8fNVI57fo+/RHvycoB9tLTCueRh12UvWkrNsX8/P+idlYpBrkxrp21k
 By+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkNRn2w/ETtUlR3qnedXHroNW9/eqtefvfO4v9zLy7m/qpxV94531NvKFFlAf/AKYumqj2H0Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwSxcp+iIZ0TCoPYK+y5BHXCLqMY4qxk/D7JwgGlBa/ZFehQCLs
 4ybR2QJE8BDNO/0vMFIlxRlzMxiZvekqh7dZZ26rthQy8PoLhejkRT1spwxulxc35w0BDi+KUaV
 av8/GYA7Sh4DXXJ2aQvuYpS9xs6/kxwlSIpqs9OOc8L6HGTgrBJsfh7Z405l2R3wmtnvbnCs=
X-Gm-Gg: ASbGncsobewlcBecSGsN2b3kaiukrQICW66sDi8VGK+Xl9fbq2sah11byjCuuUrWXJ/
 /z836580OWw9FdNvSDPaynDFbYAA+t4h3BPNWLuoPbG9OuKGQYxGTErU2hz5GyBujFei0bP+E45
 3tyIh11O4F3++zHJxnpKv4ZYorCLNcLvJ36hBNqkP5vgQUzG2vefaBSAqB+FcJ+WUsLMv1V4x1U
 /ISXptrJlxDcDHD0h2pgijIXxH3A3zVC9L4fq1dnzuWt+lBc0VwYjplrPhBFEx4yEErNB++ntDb
 8u25Xab83VbKx57ZX3HtTEkq/JS9U7co/C2LMIE9x6DsK4gIuMzcF46IyUfoPtcra70GXvH0fuA
 k0pSZQPiTCw26v8sMcOhcC9yhSsYzLUM=
X-Received: by 2002:a05:600c:45c8:b0:45b:627a:60c7 with SMTP id
 5b1f17b1804b1-45b627a62e6mr134456225e9.6.1756386221782; 
 Thu, 28 Aug 2025 06:03:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaDsG7q6SRn/vwuOIImhi4Phsr8Rb0YswISShRkwhqxF6Ip0Jsbpl8HzZCA7YuAihFGxLf/w==
X-Received: by 2002:a05:600c:45c8:b0:45b:627a:60c7 with SMTP id
 5b1f17b1804b1-45b627a62e6mr134455825e9.6.1756386221317; 
 Thu, 28 Aug 2025 06:03:41 -0700 (PDT)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b72c55c1bsm68894305e9.10.2025.08.28.06.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 06:03:40 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: E Shattow <e@freeshell.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] starfive: avoid NULL dereference in fdt_check_header()
Date: Thu, 28 Aug 2025 15:03:35 +0200
Message-ID: <20250828130335.24173-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.50.1
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

If the u-boot.itb read from SD-card is invalid, fdt_check_header() may be
called with a NULL pointer.

This was observed on an StarFive VisionFive Lite when trying to revover the
board via UART.

Add a missing check in the starfive board code.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/starfive/visionfive2/spl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 3dfa931b655..fe14b44ce28 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -23,7 +23,8 @@ DECLARE_GLOBAL_DATA_PTR;
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
 	/* Update the memory size which read from eeprom or DT */
-	fdt_fixup_memory(spl_image->fdt_addr, 0x40000000, gd->ram_size);
+	if (spl_image->fdt_addr)
+		fdt_fixup_memory(spl_image->fdt_addr, 0x40000000, gd->ram_size);
 }
 
 static void jh7110_jtag_init(void)
-- 
2.43.0

