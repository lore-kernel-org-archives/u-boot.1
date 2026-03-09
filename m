Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583BAEFCD98
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 10:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 652AD83BC8;
	Mon,  9 Mar 2026 11:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="ckqtoTnP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 774E483F2A; Mon,  9 Mar 2026 11:51:37 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F20383BC7
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 11:51:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3597fea200dso6139196a91.3
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 03:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1773053491; x=1773658291; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPAJwJh+Gn9WoG+TRvcaIpmEE4aF+mR1X5PtEd4THaA=;
 b=ckqtoTnPG2KJzTjOf4E9OBHKndBbKbZ8Jr6QqH6FxsIl/IKKn531l3lnD5S5a/8W1X
 5MZRZY2SFUvJKVtPsfCEcYBBozpXAHaCCx3jIzfSADyzNUg9YHbikHVRcYKa+z70b/Lp
 S9+zE8H+38YW4G0fw4ZrpTCw04992JwLsHqrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773053491; x=1773658291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EPAJwJh+Gn9WoG+TRvcaIpmEE4aF+mR1X5PtEd4THaA=;
 b=Xs0G5hSDceD2VN7eCys7haOD+ByigoF71qmtemahTDwktRrqO9+J9+jmblOFOjKyer
 WiBzKD/uhufeYAmrdjapX90Erbs3FGDHieHiq9vRP6DZII434oGuAIlNv7SmWADlsrt0
 Id/Oj3ijmWzQklvTF9Iej5D4KDZ6fteiWKxynd7+5pO2ixwXCpgvy//NvTLIiVzJJmCz
 q4AAN7ANO4KZubNEYjNP4UfdQUZEJLBkmaOgfkMDkyXaTJxXXRHp1FBp2/xwn8y0HUZm
 cdd3fMlakZEinLhOlIwMXhMbgA2SL9o9ZVSmcrl0kEjZk54LViJPQydpSbbQUtX5ofU1
 xWUA==
X-Gm-Message-State: AOJu0Yya0f31xpVKXEs939EzCrU8RhxzI3DuCeHlm0MROEovWKXD5wAi
 bPwaGoYUXQeFbyP8Xldq6YUQ3vsq67P929wi8dRogWVNueUqsOAeEocq6nJaYbfW7cA=
X-Gm-Gg: ATEYQzywOT2pJKLoPsvnfYI9CSQAAza8RuydHvGJJ1Z963U1QvJSqsF4Aa9aNcOZxEa
 NWGfp99gBXuWbMcr7+SzY5lDRJKcsPd5NEuOe/qAVUSqMrzH10G8R8fRmMMrvI0GjhN0awaQ9YT
 wUqyP4dxTBTbTjyXoycm3ZJ4O5MtvOEOkzfS2NtbTQQRxfxiy348LM9q5AKMfMeqvvBk7RAYY0G
 /knAtIEchiaGEY0o30ODzU5f+qNazkrBBswz0y8TZQyhQiWrbNO01eh4ZaQVtGoisDiHWPC/z6Q
 RVOcQvCBjHHi14YgPRlZgzUNkzlarkmatXa9U4NBStceBV1bnbRq7iqb9hSWWU8B9rE5DElw53a
 pJpWxZ4YO1+ZyOhSD+VRfbZrW4AfDNBqlvOqaKiNkInzN/+cCNaKAuPaU/LH0y1DaFo81XL+WtA
 mXePjoqpYVRmOmHl6Ra6aN6OsPHHVICAX1BWAw6kMHbIav51Z3C2rF6MEok3ZQtdyJCw==
X-Received: by 2002:a17:90b:1d51:b0:359:849a:7357 with SMTP id
 98e67ed59e1d1-359be2ecca9mr9833342a91.20.1773053490942; 
 Mon, 09 Mar 2026 03:51:30 -0700 (PDT)
Received: from shiro (p1766150-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp.
 [153.167.218.150]) by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359bbbaf51bsm5491921a91.1.2026.03.09.03.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 03:51:30 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: visitorckw@gmail.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 2/3] m68k: m680x0: Initialise the debug uart
Date: Mon,  9 Mar 2026 19:51:09 +0900
Message-ID: <20260309105110.672832-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309105110.672832-1-daniel@0x0f.com>
References: <20260309105110.672832-1-daniel@0x0f.com>
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

Once the stack is ready we can init the debug uart to help
with debugging so do that.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/m68k/cpu/m680x0/start.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/m68k/cpu/m680x0/start.S b/arch/m68k/cpu/m680x0/start.S
index 0802ca1fca2c..fdfcd66f7785 100644
--- a/arch/m68k/cpu/m680x0/start.S
+++ b/arch/m68k/cpu/m680x0/start.S
@@ -42,6 +42,11 @@ ENTRY(_start)
 	/* Setup initial stack pointer */
 	move.l	#CFG_SYS_INIT_SP_ADDR, %sp
 
+	/* Setup the debug uart if enabled */
+#ifdef CONFIG_DEBUG_UART
+	bsr.l	debug_uart_init
+#endif
+
 	/*
 	 * Allocate Global Data (GD)
 	 * board_init_f_alloc_reserve(top) returns the new top of stack in %d0
-- 
2.51.0

