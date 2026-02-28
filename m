Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649CEFEE4EE
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 20:21:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED32783F53;
	Sat, 28 Feb 2026 21:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YqqMaoPh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CBAA83F14; Sat, 28 Feb 2026 21:20:34 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6EBD83F0A
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d4c1d2123dso3879138a34.2
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310030; x=1772914830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FyIq1aS/PKv78zb17fS5g07Q6HLf1Ah+hYcdx3k05zA=;
 b=YqqMaoPhgPJnFisbmuItMzpzF8GysBn/wqIaJ4vtRCQa/Iigb+ZarnCgvf9LdMz4UU
 oQItLbVtMzplsxvSs7URoX4XB1elUOdt8UjLoCc48D/5pUUcw/VH1bFYsYpyuuFgUXSf
 nHZA1dFadtsBIMojhkCKZJwJ+rN4RWIeRs5Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310030; x=1772914830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FyIq1aS/PKv78zb17fS5g07Q6HLf1Ah+hYcdx3k05zA=;
 b=NohlWucEfvzTcNoVGzdqiqhZu41etNAeVs1/whugl8EUibuEXCYbEIFqiuWl8F83ei
 Jad+5KJTAJ+oBbnVf47bc6UOa72RTf1YDM0ZWkfUkwkJntA+CAoFcBFyRdPoEdGWNcLK
 0e88ia6IPsCrvQUR20OPGlUaKauNdOeO/M3AEJ9+aa3gkYr0FM8gVKrKNYNPihPuu8fI
 dAbyf975TLBUYotIy6YeK9B15rdjImJKUsMwlt0UYrHnsYgF/uV1EsMHD6l0vi6ySfsa
 mrp9l07zxQhgUxPYVnAjoiW1tk8+QqbKhqs4lLZf0RXGacrpwGa93Hf2wnmpDfJ0va1Q
 UbbA==
X-Gm-Message-State: AOJu0YyD6Az+DXPXIvm0lKcGU5LjnoUOJgIZOTo/0PrYlBHOLunsqw8e
 HMt9HL2xQ322B0PPIzt0txCuL1qFcbqPKWOaD+9mkhCoFuoDQ/HABjxpUPjmBJk1dO20ITdC/90
 tTk8=
X-Gm-Gg: ATEYQzzGu4sX3uVuwzfJu1vQuVW+CuAeCu39hwAmE08k/6DTCoqhFU3pI5kgeyXK0PP
 AOphmXAFx15xxOHOEoMKXNDiwYHyPHt2W+HtY62Tof3Tq9xGi/TGZiYTs4NPLQ83LBeqTn+d2yp
 cuc0XnSuAuy33ko4dYvH9khmF6LZkGuPkSPXXiDiFuOHrOD3rrzxkhzue2VBbWgoIbEzdJ0chM3
 MPaj6a7UxKst3dOvU+8kttqMYx1gs9bOIH1D7lGSDNX6a7kk8bT8UK4+DsKZbkNczGjx1DGDGkZ
 KOJ277BggkRE8iQ5x+oU23MuTIxMcSe9DMuYlywGGoeN2WDU6dF2BGdbxPFD4k13otvzc3Dj/Lo
 OrPRohiUF3oWIDSjcXYHlJ2V/ZjJoKtTpe8/TjkMnYj7rodw2Uhm+LxH0geo500hpPGzBej0S/8
 MkQPuS+a5pyJ05QwyG+Q==
X-Received: by 2002:a05:6830:610f:b0:7d1:4f21:ff79 with SMTP id
 46e09a7af769-7d591bf4279mr4888249a34.22.1772310030108; 
 Sat, 28 Feb 2026 12:20:30 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Guillaume Ranquet <ranquet.guillaume@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 05/17] x86: Call bootm_final()
Date: Sat, 28 Feb 2026 13:19:53 -0700
Message-ID: <20260228202011.1834493-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228202011.1834493-1-sjg@chromium.org>
References: <20260228202011.1834493-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

The x86 code in bootm_announce_and_cleanup() is very similar to the new
bootm_final() function, so just use the latter.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v3:
- Drop the DMA comment move (now in the introductory patch)

 arch/x86/lib/bootm.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 7a94dc877e3..cde4fbf3557 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -34,22 +34,10 @@ DECLARE_GLOBAL_DATA_PTR;
 
 void bootm_announce_and_cleanup(void)
 {
-	printf("\nStarting kernel ...\n\n");
-
 #ifdef CONFIG_SYS_COREBOOT
 	timestamp_add_now(TS_START_KERNEL);
 #endif
-	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
-#if IS_ENABLED(CONFIG_BOOTSTAGE_REPORT)
-	bootstage_report();
-#endif
-
-	/*
-	 * Call remove function of all devices with a removal flag set.
-	 * This may be useful for last-stage operations, like cancelling
-	 * of DMA operation or releasing device internal buffers.
-	 */
-	dm_remove_devices_active();
+	bootm_final(0);
 }
 
 #if defined(CONFIG_OF_LIBFDT) && !defined(CONFIG_OF_NO_KERNEL)
-- 
2.43.0

