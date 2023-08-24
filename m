Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209E4C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 08:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0235586554;
	Thu, 24 Aug 2023 10:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IqnE61sP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B21DC80842; Thu, 24 Aug 2023 10:09:20 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CECA86554
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 10:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b703a0453fso106747091fa.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692864557; x=1693469357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLv6PFLqhYHQGiV7OMy9/3bOnrA2SVWojuTz/X9S6tU=;
 b=IqnE61sPW4zvvtzt/KkRcY8Bkm6+yKQpyqrBsqnkfQCzLlwm+Ox0xFgb1JrEML3r/u
 uf5pEaC96WUoBy4ZOYJtkhyHcYRwcpZjMP7UysONZADvffN2VZNRAreKceGidxjVmZXx
 VuxEpkqE17GpMzzf63/tqSAlvEyrW+o7K2/cM5ZdvSbMSD0OxamsmApELaP62o+GKTGi
 70wUR/P+BHTTHaQCuQAIyfs/jHZRoqfFTclTRaouoo5DOk76TiKy2YXD9/SHrzoRzkNO
 jvBvRKpTjlA3RHxRNTvfn0piSjI2dmwHHtozdxiFhqzYhHlwM6n5cSs34stbbAgNtCAj
 v6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692864557; x=1693469357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLv6PFLqhYHQGiV7OMy9/3bOnrA2SVWojuTz/X9S6tU=;
 b=GKw7MyKIYQ9WF7Kck9XBPfZcvAe7d6JXGKjm5QHT+zpeDV5u8rZQgRg/pKMQQeRtes
 Xen7NrIXEXrXVKRKwA3dNQN54pmPFeLnjm2grDW+RYsooDil4JkAIyAHYM/VdBlznDhJ
 vOBnFMGxkMbiFeVKLnuxa8UmSX6FDBUP07XAhx3TzoEgGXNRohVp3qMWJSZI7d5NvWJV
 jqIj0gtdiYzUchd8QkALkF6BiAD0fRL5kradcWlaDXouTz/9V0yxydkoNMgLN99wlh1u
 fCi+3wOFFzTLhD2e/4HpoBXOlDR6H/EbD4MMpTmQwVu7UGVOwIhhJwi/K7A5h6oLdC2g
 edjw==
X-Gm-Message-State: AOJu0YxEfn20dkTjLZ5Ui0Ge5ERxhcF6UnFu5Zu0Wt5pLtkNocdRDKzo
 0GKW0g687V/Kslg4fE8Vk06jkxMWI9Z2sg==
X-Google-Smtp-Source: AGHT+IGGb7PVP9kG/j9lQjwhzdf8rL3NQEUv71APb/YpHGFWvUeHP0whF7JtjVgaEuHo7Ke1VAQR3w==
X-Received: by 2002:a05:6512:3b9c:b0:500:a002:292a with SMTP id
 g28-20020a0565123b9c00b00500a002292amr892152lfv.29.1692864556589; 
 Thu, 24 Aug 2023 01:09:16 -0700 (PDT)
Received: from emanuele-nb.int.toradex.com
 ([2001:b07:aac:705d:8b32:37a2:413:27e3])
 by smtp.gmail.com with ESMTPSA id
 n16-20020adfe790000000b0030ae53550f5sm21282602wrm.51.2023.08.24.01.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 01:09:15 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: u-boot@lists.denx.de
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Neha Malcom Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>,
 Bryan Brattlof <bb@ti.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH v1 2/2] board: verdin-am62: fix check for minimum memory size
Date: Thu, 24 Aug 2023 10:08:50 +0200
Message-Id: <20230824080850.1755724-3-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824080850.1755724-1-ghidoliemanuele@gmail.com>
References: <20230824080850.1755724-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

verdin am62 SKUs comes in multiple memory configuration, check that
the detected memory is at least 512MB since we have some
reserved memory just before this threshold and therefore
the module cannot work with less memory.

Fixes: 7d1a10659f5b ("board: toradex: add verdin am62 support")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 board/toradex/verdin-am62/verdin-am62.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index a3d1d07a0cbf..d09dda5bccc9 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -28,8 +28,8 @@ int dram_init(void)
 {
 	gd->ram_size = get_ram_size((long *)CFG_SYS_SDRAM_BASE, CFG_SYS_SDRAM_SIZE);
 
-	if (gd->ram_size < SZ_64M)
-		puts("## WARNING: Less than 64MB RAM detected\n");
+	if (gd->ram_size < SZ_512M)
+		puts("## WARNING: Less than 512MB RAM detected\n");
 
 	return 0;
 }
-- 
2.34.1

