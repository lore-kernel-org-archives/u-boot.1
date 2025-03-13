Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09BEC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 22:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC3FD80F9C;
	Thu, 13 Mar 2025 23:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kHzfr76L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7E7B810E8; Thu, 13 Mar 2025 23:39:51 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E59BA80756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 23:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-391342fc148so1014401f8f.2
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 15:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741905589; x=1742510389; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YQZYtUQDBimvuW0ncdH5cOhhB3S3vrO8oOQ1DhM+eCU=;
 b=kHzfr76LL+t7Y9ilqYNOzi13qkZQKXu7sdqf0t8UaJyAlP9wQv2wHbdN3T5KVE7qXE
 dJIacWR2hXYW04xqkzCcT6n8YCxkOtU86mSXdQU/0LOXz9XcPeXDLDkMbkYiGG48ASnx
 ALLlUKoBs0HutctpN8N1m6ZEF7Cs28/CQLQGb8MSyeaJXxjKpoDpg584ApobLV96IWjo
 3n1kiYrj8AfvkUmtjZYLuaKKvfqNpfQlltyCxpNuJ5ogkOZo23S2xoPDGgnqTIcTV+wV
 E1jvP3FpcTC4h+BX0BO1X63w5svWKUSFEhCPuudDAsKmQpb3zN4U1+HxaGx/g2qStWFG
 kVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741905589; x=1742510389;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YQZYtUQDBimvuW0ncdH5cOhhB3S3vrO8oOQ1DhM+eCU=;
 b=arW9kX8nntv/k5+g88BtPXB1SLiJs18ncnNsTKOsuTS8u/0g4V8ZZUpK4m1tbvg9+L
 9UW+HHXOTfByOniYK8WasAcuKhdkFk8dJF91Dd15q8toHGgp5JtBfSh4CiOEsGhVa/0z
 qK8+S85MQh+EWeSa2j4aFsm4hj5rp2pQDEAe8dAOhR0FdzcS+DYV6dTx302oaWtknPtE
 kKo14FDOVHeUZ+762rjuhnn091Snd2B6qM8bPYm6sHc5KF7Idg1R6TFUHFn1wgCgymuA
 HkCFEBHiJOudOyaqvAG9V/ejkks8NUSmX/PeBromxwxE2U+sacCm93aCTs1TPzdfQs1m
 Gxkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK7ihBYo3Q2tUkCbMUIysIGx6Ne5GIP35duNG72RY51CUuD7XN8QUQgp/ITM51pdswahVn0z8=@lists.denx.de
X-Gm-Message-State: AOJu0YzcoXavRoexSfrXOboRNcsxfex0kUKE7FFceV9MA5B8wcA9OTBa
 YM+6A+ST30zH1a0A8O5SY2v93leyfcfRuDB9RhfdZDy7jDXHfHs0
X-Gm-Gg: ASbGncs7Vovy1mCw7cykJoQ9QliFzJemPRXePQAyaGw7ZOYnPRR/He+Osa+PUWbdGPH
 qK5qlQ7DprOLAJlthMUeg2MzSGG84fu5a8Fj+5YYS4NpBX8gdUbguIvGe3oyzVhFP9g9KyI5yWw
 WbJMPrZpFq2a83zkbPwENftlJBqaV2AlVsr8mt+XMCZ8LfC+Dh7M2/RcxkKjBt1pZt2MYsQJCzh
 Qo8vbl968lCx/Jz8FxccjRL0XN5tJJM7iZ+UVuDv7T3KA10+OpTWn+/QVlGajFyC2fzXmDkfoc7
 7nt6bdgQNaSlTBOoiqTzHCR89isdjiwJc3jeuZVTlVKJj7kcGkWKX6uB65JM5dPFg7MZy+AUlh/
 LAXAgBd/NlnqnHySdp5VwhBiP8E9bLujuB1fkYtg3sUn63Gr7AroY9vm06ce7zozdaSWvGtl0oy
 XGL8w=
X-Google-Smtp-Source: AGHT+IG7gXXI9Kq2DujBbe4b1dM5hLb6sw9qAnUFDYvVN35j1gzNxquUAXZMjSf+1OGX/WRxt8CWhQ==
X-Received: by 2002:a5d:47cf:0:b0:391:2e31:c7e8 with SMTP id
 ffacd0b85a97d-3971d1362e8mr154435f8f.2.1741905589163; 
 Thu, 13 Mar 2025 15:39:49 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (2.c.4.1.7.3.6.4.2.a.a.3.0.f.c.2.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:2cf0:3aa2:4637:14c2])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-395c8881187sm3419390f8f.41.2025.03.13.15.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 15:39:48 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] arm64: Add MIDR entries for Cortex-A55, A73 and A75
Date: Thu, 13 Mar 2025 22:39:41 +0000
Message-ID: <20250313223947.1711595-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Add MIDR entries for Cortex-A55, Cortex-A73 and
Cortex-A75 cores.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 arch/arm/include/asm/armv8/cpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/armv8/cpu.h b/arch/arm/include/asm/armv8/cpu.h
index 4dbb589aab8..2cc9bc988f0 100644
--- a/arch/arm/include/asm/armv8/cpu.h
+++ b/arch/arm/include/asm/armv8/cpu.h
@@ -5,8 +5,11 @@
 
 #define MIDR_PARTNUM_CORTEX_A35		0xD04
 #define MIDR_PARTNUM_CORTEX_A53		0xD03
+#define MIDR_PARTNUM_CORTEX_A55		0xD05
 #define MIDR_PARTNUM_CORTEX_A57		0xD07
 #define MIDR_PARTNUM_CORTEX_A72		0xD08
+#define MIDR_PARTNUM_CORTEX_A73		0xD09
+#define MIDR_PARTNUM_CORTEX_A75		0xD0A
 #define MIDR_PARTNUM_CORTEX_A76		0xD0B
 #define MIDR_PARTNUM_SHIFT		0x4
 #define MIDR_PARTNUM_MASK		(0xFFF << MIDR_PARTNUM_SHIFT)
-- 
2.48.1

