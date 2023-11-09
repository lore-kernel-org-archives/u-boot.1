Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EB2C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 16:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6C898723E;
	Thu,  9 Nov 2023 17:51:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SvOcM5gg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EE9D87168; Thu,  9 Nov 2023 15:10:39 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B1148715C
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 15:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc0e78ec92so6942845ad.3
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 06:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699539035; x=1700143835; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pkawgH+Vr5CoE36UaAW8lMxUkSefY23yQVaGyVIn6Kc=;
 b=SvOcM5gg9enANsCoSNP3rqXUfdNkIrmIo3pGNLD9KFGxQ8Q09hgZvOyON46iZc/D05
 dtl9y0tzwRGohOn70MdhJQAIYfe0v+EkDqSssFld13BNwWuxjqHKnL/HTUquOjKz3wZ3
 WvUToOOVvxTrt+0LkjJ3Wq4C2bcbkGgVQjudzeWos6veOb0vxRS6+OgcSAC0qN/Wdn2s
 HBgcm0uGBTOkSBvEt5tjabiAoLbvUTGeRJ0rZNTqxFYPoxykYqdo5RhNNJYrUFdX22Fh
 Tcf+gJy6W4vUUwURRQvcwoqZN+SjEvzidIxrLdDe2uE766aP6QyDropZw2ZXm8oEpAks
 btrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699539035; x=1700143835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pkawgH+Vr5CoE36UaAW8lMxUkSefY23yQVaGyVIn6Kc=;
 b=Bpf9pXZxc6A5p3DFwkbcKdL5vp2vtHpaeGasvtHN3kEPwD9BAYhJ4jTmE5ancjGgnJ
 5+2p5ymMoyHYNrY5YkzCRMKMRvmnoLgm8KklGtfeyqYKzextAiuEGCY3GoGJvxeUJfzx
 4vbv09JMhOFYn20IBKX6+bkv2Pi3Y0x1pRJFXE1rEp6JlbS00dTrX18py4DbWMkWepfl
 ZUtZAzev8M2lZ222nVrApo3VzW6c1jA5Dd4bEfQpCiFEQsTpmtb5Q4KxAaO1LWyoCV/y
 MrpEY490MA3dJfwChzT0wO435q0v458+Jjig/vs7qEEf1r0JR7jlnUTjxJxh/R/QoG5s
 xMxg==
X-Gm-Message-State: AOJu0YypIHorT+P0Lw9zRizVznp6rjdeTlHniMbIjPhxMu/u8ny0ofPq
 JcEGmfZ8UMkVDWggWwuzJzo=
X-Google-Smtp-Source: AGHT+IExRoNH2BwRnkFnyd0pC/Lq55fAXn7+AZ2QcCOMzzmygqB0fTysh0Lxgob6wDjx4TPB8GsIcA==
X-Received: by 2002:a17:902:7c8e:b0:1cb:dc81:379a with SMTP id
 y14-20020a1709027c8e00b001cbdc81379amr4903815pll.53.1699539034568; 
 Thu, 09 Nov 2023 06:10:34 -0800 (PST)
Received: from joaog-nb.corp.toradex.com ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 ix22-20020a170902f81600b001b8a00d4f7asm3592029plb.9.2023.11.09.06.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 06:10:34 -0800 (PST)
From: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
X-Google-Original-From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
To: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [RFC PATCH 1/1] arm: mach-k3: Enable icache on am625 to boot faster
Date: Thu,  9 Nov 2023 11:09:58 -0300
Message-Id: <20231109140958.1093235-1-joao.goncalves@toradex.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Nov 2023 17:51:11 +0100
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

Enable the am625 instruction cache on SPL and U-boot earlier for the A53
to execute code a bit faster. For normal boot flow, it was possible to
gain about 2 seconds on boot time.

Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
---
Hello all, 

We are trying to optimize boot time on our AM62 devices and on TI community
forum [1] someone advised to enable ICACHE for am625. We enabled it, tested and got 
around 2 seconds faster boot on storage media and about 5 seconds with DFU
for downloading images from A53 SPL. However, we don't know if this is the correct 
solution and want more comments on this or why the ICACHE was not enabled by TI in 
the first place.

[1] https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1217839/am625-boot-time-between-a53-spl-and-a53-u-boot

Regards,
Joao Paulo Goncalves

 arch/arm/mach-k3/am625_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
index 8fa36f7b91..d665d07b0b 100644
--- a/arch/arm/mach-k3/am625_init.c
+++ b/arch/arm/mach-k3/am625_init.c
@@ -210,6 +210,9 @@ void board_init_f(ulong dummy)
 			panic("DRAM init failed: %d\n", ret);
 	}
 	spl_enable_dcache();
+
+	if (!IS_ENABLED(CONFIG_CPU_V7R) && !IS_ENABLED(CONFIG_SYS_ICACHE_OFF))
+		icache_enable();
 }
 
 u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
-- 
2.34.1
