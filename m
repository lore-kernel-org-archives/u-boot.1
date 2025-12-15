Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0514AD41D74
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 07:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1114080050;
	Mon, 15 Dec 2025 08:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Cj3wvra4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBC0480077; Mon, 15 Dec 2025 08:57:01 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B93138003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 08:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so981402f8f.0
 for <u-boot@lists.denx.de>; Sun, 14 Dec 2025 23:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1765785419; x=1766390219; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3W8RBJHCNjVIFl6Bam2tQjTlbmf5CMnWVciuN59aCmM=;
 b=Cj3wvra4GlZL2hI6W5mrJaZuoVt8SASO1yn9HGMo0Ga9yhXUXWWlYHBX33AfGMbP38
 shPlZsz4mGD6ZS5eDnKjtZ55tNxMDQ/EVwVo3NS4qcdpz/NIyYDUoB+1LTHAuJfLcTDz
 rj5GBfIskNnYU3J8XRk5ptrks0LLW6WZie3ZOL+BBkmwVj8gnoSKGOTjQRDpr08GMlEM
 tnA1ScYKGYXrvT8iPVIewhOnsqU+yDB2mbbM9E17WteoxLT0lNJO7UnkhT6n46R8yXr9
 GJMNBC2Bnv9LeCJE5TNIzGn4LoaiyPBZAqcI/fcb2iWiEgV8HqK0FgTFVe2nQfTNZwQI
 CRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765785419; x=1766390219;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3W8RBJHCNjVIFl6Bam2tQjTlbmf5CMnWVciuN59aCmM=;
 b=V+tOrXoO+3PVJboFq6cSGHrrj45cTVlhDzdY4uBfQpItoMHU0F59IIyksSNwYSJW6b
 dDhuJlxDlL4RC0YF5i6P7OHdoyfSw0xscHtfy6D4P/Yac1z1Cm8P0NulrllvhugXqhI7
 /nWN9lQF2kz3ynJc2zTWPFKwgpM9H725ywIXBUcHr0UNugB/1Z8Q3tvcIAUIpKt4MT9z
 MG23cU4nGP1ezV+SEf3SrdBx2T8hnbBV6mu/gEtnvq0W2RoDt5hlS2hYs401FiAukGAt
 LNjoarmGRJpioSBaeD6hBwfTGIEfv6S3JQgJYk2Z0BgjFkKA5V5pJ6/QPJmUB3gw2k5A
 FeCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqXBVejvI7yXIugHp+EDqUSqIN+hXMTwSKQmM0iw3aq7b4SGxLU6r/L+sycQKYOMbwTnq2Irk=@lists.denx.de
X-Gm-Message-State: AOJu0YxFSrfuhgKg+Ln6eNfBTCjH/f4eycGb2NUnMKr3KRjyYtNgh2PP
 lPnPq13JxFlkICazCyp3jFWPKgAQkL8fiX8rbbG9L3ghVVm6jIlqDPE4LXGiBnyAB0w=
X-Gm-Gg: AY/fxX46U4YXlFTbm40ogDNNM+n3DXua96peNM7wkRVhN8j7ftPzOS+uVuIUJHoHKS3
 lkbUgr/w0AKoqLXAtdMfQRNN06CRnI0WP9ha7/kuwjvd/nBtqjprjFx48Iz2zH127nwy6AiMIgz
 KXx3p3B40JrRxckdMGUH940UzM8FOSHXplgUNKhbZZD9BbsO7nOlpgOCvaTyjyNNxwm1gj2amzd
 Dr05RsT2t7HKuJv7rukl7FbaoscDOw0t/m6LpWfkbreUVP/SXOM8Tqe58sK+DksC3HMXuig7Pg6
 acKh16KUdS5hZUYDjiwyUppfLuOouVMhGqTLumdgjMFb+L3QimDVXZaDZfCCvoRlxn4pg2uy5sY
 Bi2wCRepEAsL3DrlBW2eM20KQub450dW/u7FSuG5wQF7oL6wiE2AWoTpDhKnzW0lIMjGPzcXZyQ
 itRhm5t5jgaeaqVJ33+L+EX1gkdSKtnVE7FSNN0tyZilTlUGV1t0dveHkKgC7J3S8ZVvzJc3duz
 miOXQQcMOycfZlj
X-Google-Smtp-Source: AGHT+IGqHxaA/GOfz0EriAT5UzxKEe1/IM4xCuEPPZAivmgd45OchB7Dp36dqOBZJX9Zx3vK0XfARQ==
X-Received: by 2002:a5d:5f54:0:b0:42b:3c3e:5d2f with SMTP id
 ffacd0b85a97d-42fb48fc506mr11445139f8f.39.1765785419152; 
 Sun, 14 Dec 2025 23:56:59 -0800 (PST)
Received: from T14sGen4.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430fdcc6bbdsm3804371f8f.14.2025.12.14.23.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Dec 2025 23:56:58 -0800 (PST)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [PATCH] x86: cpu: Fix crash on FTRACE enabled builds
Date: Mon, 15 Dec 2025 08:56:44 +0100
Message-ID: <20251215075645.1795762-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.52.0
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

When compiled with FTRACE=1 U-boot will crash as %rdi is clobbered
in board_init_f_alloc_reserve() and board_init_f_init_reserve() will
memset the .text segment instead of the global_data struct.

According to the System V AMD64 ABI %rdi is not preserved and the
existing code only worked as board_init_f_alloc_reserve() was small
enough to not use %rdi.

Fix that by always passing the correct argument to
board_init_f_init_reserve().

TEST=Can boot on qemu-q35 with FTRACE=1 enabled during build.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 arch/x86/cpu/start64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/cpu/start64.S b/arch/x86/cpu/start64.S
index 78e894d2a21..3fcd8c15481 100644
--- a/arch/x86/cpu/start64.S
+++ b/arch/x86/cpu/start64.S
@@ -16,6 +16,8 @@ _start:
 	/* Set up memory using the existing stack */
 	mov	%rsp, %rdi
 	call	board_init_f_alloc_reserve
+
+	mov	%rsp, %rdi
 	mov	%rax, %rsp
 
 	call	board_init_f_init_reserve
-- 
2.52.0

