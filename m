Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80699C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 15:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC5D78843F;
	Wed, 19 Jun 2024 17:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lMArniqF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3EDF8844B; Wed, 19 Jun 2024 17:23:09 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2ECE8836D
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 17:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 737B73F2B3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 15:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718810585;
 bh=skrMnrr7eXW0ZvOM2iUnpOJOXquScmtacpDFNvM3VGY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=lMArniqF8Y617h1y2pqBLk7+CduwviiPdPUwiOjbBujpI1GRUq47dCiuqmEPnBlBZ
 tqc1pL3pQCxzd4Bo+1umCaZY6HG19ThQDxtY9enkzKcs9dH9CakPVVjrV92X+1FYPZ
 06KBZwcm9uEqxTZGn6ygNgGhZ22QapIn8P3g4hvBwKtD7uf5A52Pk3+H8WjI+KHZG0
 bZUZfvbaLx9XqvjmzjhWKQrHvlQ1Heh3DnOVKHsaDlOh5V/6tjqPolNbjWnXOmNAab
 RTGFikWnaQhSY+4W2HfRdcvdKcJL7s322y5bgeKz/8iF+353hWiyKpLLgqxNu02bE6
 UIAOcIWBW5slA==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4217a6a00d8so43695765e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 08:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718810584; x=1719415384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=skrMnrr7eXW0ZvOM2iUnpOJOXquScmtacpDFNvM3VGY=;
 b=rYzG3QEiOOcX3EFDTy7CFfcXHYhekMoHF0hmS5EdsrDkYD/hSjGSLIReIYQdy+Itj7
 lDchcLowuTb3KSOsORFgYvDHM31BmsJJYYeGxZKCtYa0oJTYV8OwtXRmwYfs9mpFOzht
 1nk/aZX+V/K4kjZp9R/m/e/oyWguZjVdf7P1gLPfV0C/3/eX8uDmjlPLlz+LEM7rMlaY
 Tfv0GxPFp98qagc+TsaDU1xlMQmyy+5ewsQoyclyx/OO31+feSu7+7JfVN3+gzGhzao4
 Oh3Y6zriji4WirlEWjomE57PdcLHPeW3E648e4ySP9VBMq5qy7nRhvQ5azZ5eRnXaFpf
 H97Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuROb6a1pWsglQaG9qQOaAstckL4m6nobb95cEXYpd/46UeYGb3plFQ+/G12Ja2Ee0KZ87DVYXksO3tKoNvorLVgDOBA==
X-Gm-Message-State: AOJu0YwE6Ck7s2zOtMjtQaM/8j9l/1GpfX8EUKbEreNcuNABqrtAe6Yd
 t9+I972ovlorbz0Y21P2QDpAgCVoiRcsgWSAbrhIgZfZRt6PbAA+U5EUbNRwv82PnMf1rf72x9H
 9mCSL8aj9eT1I7MYwsZmH/Ujn+mgZoKfOafKjLKpW7fesHWMMrU1Pee7VfCu21I25VYw=
X-Received: by 2002:a7b:c355:0:b0:421:8060:f772 with SMTP id
 5b1f17b1804b1-42475018647mr20703805e9.0.1718810584478; 
 Wed, 19 Jun 2024 08:23:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRnNfyzPIRV4+fp8076pyD7LlfbwxKkU9I/3Rz3RHKVbwb7h0itYv0JxiBshQQSEvUcdjxKg==
X-Received: by 2002:a7b:c355:0:b0:421:8060:f772 with SMTP id
 5b1f17b1804b1-42475018647mr20703675e9.0.1718810583951; 
 Wed, 19 Jun 2024 08:23:03 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-178-202-041-025.um47.pools.vodafone-ip.de. [178.202.41.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247101a955sm49199235e9.0.2024.06.19.08.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 08:23:03 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Sean Anderson <sean.anderson@seco.com>,
 Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: semihosting: correct alignment
Date: Wed, 19 Jun 2024 17:22:52 +0200
Message-ID: <20240619152252.173684-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.1
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

Commit 7400d34ba992 ("riscv: semihosting: replace inline assembly with
assembly file") reduced the alignment of function smh_trap().

As described in the "RISC-V Semihosting" specification [1] the ssli,
ebreak, and srai statements must all reside in the same memory page.

[1] RISC-V Semihosting, Version 0.4, 12th June 2024
    https://github.com/riscv-non-isa/riscv-semihosting

Fixes: 7400d34ba992 ("riscv: semihosting: replace inline assembly with assembly file")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/lib/semihosting.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/lib/semihosting.S b/arch/riscv/lib/semihosting.S
index c0c571bce9b..49bb419a962 100644
--- a/arch/riscv/lib/semihosting.S
+++ b/arch/riscv/lib/semihosting.S
@@ -8,7 +8,7 @@
 
 .pushsection .text.smh_trap, "ax"
 ENTRY(smh_trap)
-	.align	2
+	.align	4		/* keep slli, ebreak, srai in same page */
 	.option	push
 	.option	norvc		/* semihosting sequence must be 32-bit wide */
 
-- 
2.45.1

