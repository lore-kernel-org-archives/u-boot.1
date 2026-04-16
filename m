Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60221F433F7
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 06:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D1AB8421D;
	Thu, 16 Apr 2026 08:00:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Pxd27JVy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E5F08420C; Thu, 16 Apr 2026 08:00:19 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FB2F84207
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so100542135e9.2
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 23:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776319214; x=1776924014; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PxGW5JexjN+wNEzNZwIRVtmLNulzvxhoaehAmbwC1zk=;
 b=Pxd27JVyJFOUbTDX0oC+Kc4JyoaPEJ/WB91owRJ7rIqKTsR/PKeuG4lCiKJsRfjCdQ
 Fn+m53aOUQFDPW/Glil51tvyBKPAqlkXYBQlg9XV3gNZEHRuhkpREsZ01bdfw4tj1GFB
 VNYZe9VVbxSX6CtUx6BwW0ASzNlGlRkU6KdTvaeOVHz7XQ+gYdzsCvb7dxGr55DNXXZ7
 2874uLZOGv4hFb5d2oXNrpX7qBYyDPNLFmVr0PLvEnyW6WVe95eRq5Ne8WKfogs+NrxX
 kfFpP6ElqBLpaFAbaQ4d3nMo7KCyP3M5XqoobnZptnkDJIeOO4B/ViylZks9ia3ckuZw
 Sp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776319214; x=1776924014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PxGW5JexjN+wNEzNZwIRVtmLNulzvxhoaehAmbwC1zk=;
 b=d29tSAxWuL05rcWaaExrUPF8dcDAa5xmzp3LWXuuEUjVW7SfZv+nKtXNyjmAOc0hhL
 LweaCNlhO252dD7UHAN/WhCyb0KLOnIHge1I0Q2XbUqJRw6/uKQWTVRVD3xLlT0wf/45
 Q1YyPY80WW8VO98W65ZyAm4vUopH4ImfginDUd4fY2dGMd5sai0aRqY61PGbdUxveHvb
 klVR2R9y4erdjtibJhaIaeQqUrW63vY7c97VYVb11z00+XJMK6LXJL2Uvgqre7Bqfl6Q
 nkAUdQloSxr69VeiKOTmtWdIe7nEDy8/pbL2JjKGZ0l3EBNrPE4Uq/ZB0mVKEKbbo4R3
 qkAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pK+TX7qErC5c9ZDPjs9Z0H+Jy9XTlodqOULpXfZLmnQ0YumOg8LwUF4FGm8C6egQyvke7Jhg=@lists.denx.de
X-Gm-Message-State: AOJu0YxWM/l8OjNtWx2YxcYDgCKDa4DU50LCsGeusvolkCkxqehdJ4Qe
 Q5VO+Ob2NM3eOzd3vhyHNhXE7fF71I7MNEsG+DKKbQHUEf/5ceTh/RDQGSh/u8H2TIo=
X-Gm-Gg: AeBDietyD1rsX+rdvGsvfZ/uzfqvulNWSPxTxZ/P8R3dYC/0MG3irsgJZw+6RMqwa9d
 RtLdf7iTNawfjYtRUMKleHfL1KY9G+25g9XgTjDyt+doMzgnjn6/bMvLYkE4Ri3oNTLIeHJn9Vo
 X+CA6Zz30VZfypGJ6OFNQcs22KllJI1UbpgNdAja72cVg9flCUwyWV8+rieWxbm45bdnluUoUK8
 79K56uVXnYTsiivnCqam1xUl8kQ/QnDUHKo1qmWo362YY4lCXEaRraXbm3euQWdU7+fIecs2MyP
 tnuJ00OLhn9uHhHQO7lLCRt/ciIrR309Vql3gwBXia6lGWxxDJJJk2UpsNoa8bv9U9b+Y4Ss0Fa
 eglE4NCbvw5GZMtkQKu6/vs44zHGvFhatUJkTJa1EJaAGRtOvPF629YHa8a0/EnvABfZicBsdai
 LGQEQnt0l+A6NZXjsY0bG3dmHHPD1KjfL0MR0pH+6c/rhMmRi8byJeYOml0w1CdcoM+9cDWYqkk
 kQH5aD12qa4njwiB22YLFlGliktMowXKgqxadShPScu2wldm2zr6YQtYpeGwOnPZXzTTUYIea4C
 gxCTUhZTITeuzAkEIdQd9eCBLtwjxICHIVYUT2nK7dcrsqO1iMAOI67HZUxVOyj0kAJbB6eFp+u
 bwtx8Lu+NNIpvMbylNPbiz3ssu0kH0MADHt/w92GYrZD8bXWR2yA4pI7dW6C1upijFJ6+ap4iIx
 KfnR76xO1cF6SCuvS0OIcIV9wBNdHCEF/b7Zo/b3MHrZjU8slwjx9AwFR+TsfC1TpfWdxDXRs=
X-Received: by 2002:a05:600c:3acf:b0:485:35a4:939f with SMTP id
 5b1f17b1804b1-488d68a8275mr298985935e9.28.1776319214302; 
 Wed, 15 Apr 2026 23:00:14 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0e9a770sm36379755e9.19.2026.04.15.23.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 23:00:13 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 4/6] common: move ram_base calculation to independent
 INITCALL()
Date: Thu, 16 Apr 2026 08:59:40 +0300
Message-ID: <20260416055948.130041-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
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

Currently, ram_base is calculated within setup_dest_addr().
However, upcoming patches that enable U-Boot relocation to the highest
DRAM bank require ram_base to be initialized earlier.

The default dram_init_banksize() definition relies on ram_base
to calculate the start of the first bank. But following patches
will move that function to execute immediately before setup_dest_addr().

So let's split the ram_base initialization in its own INITCALL.

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 common/board_f.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 0da2916aff4a..d1e7d0d2f046 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -328,6 +328,14 @@ __weak int arch_setup_dest_addr(void)
 	return 0;
 }
 
+static int setup_ram_base(void)
+{
+#ifdef CFG_SYS_SDRAM_BASE
+	gd->ram_base = CFG_SYS_SDRAM_BASE;
+#endif
+	return 0;
+}
+
 static int setup_dest_addr(void)
 {
 	debug("Monitor len: %08x\n", gd->mon_len);
@@ -347,9 +355,6 @@ static int setup_dest_addr(void)
 	 * get fixed.
 	 */
 	gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
-#endif
-#ifdef CFG_SYS_SDRAM_BASE
-	gd->ram_base = CFG_SYS_SDRAM_BASE;
 #endif
 	gd->ram_top = gd->ram_base + get_effective_memsize();
 	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
@@ -959,6 +964,7 @@ static void initcall_run_f(void)
 	 *  - monitor code
 	 *  - board info struct
 	 */
+	INITCALL(setup_ram_base);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
     !CONFIG_IS_ENABLED(OF_INITIAL_DTB_READONLY)
-- 
2.53.0

