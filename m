Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F285C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E1DA8193A;
	Sat, 15 Mar 2025 15:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hBdbL7dz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A98E980FF7; Sat, 15 Mar 2025 15:27:35 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFCD8819B1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso6197625e9.2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048853; x=1742653653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jhxSIFalaVLSVgG6wVZXyEthG0WD5Vpn2+AsnABXDE=;
 b=hBdbL7dzBWrQWpYrcZgZMf5arV9r1cE2HIz6tx3HNZCRqgiopPahxg28C8bCR6AzfO
 phS+H0eTA9zn6TKbJvdilIWP65+4KQFFskCN0CAKZv12gGyYypqJOrIQPRLJiz37jsUB
 Is9oyNlsLAq050ZKrHSLqEvIanKi1z7ty6u2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048853; x=1742653653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jhxSIFalaVLSVgG6wVZXyEthG0WD5Vpn2+AsnABXDE=;
 b=pK0VcWMRcMV+C3fC7oNu/1i0gO3DCVou6Ajmf+v3qLr8tHQuDwNXnrkM/CC+eUZQR9
 kXDs+xt+aPI1XiRgrctvHKSFdT7M9JT+ERxOrtgjH0NzB9iNnIsm0P+EVjLHRaG94COV
 gg29nyhPv87tjc+XvgeUXVnVvBNmcNNjkGIMCFlDSAlYDC57YgcaRLAcJcv30WGLQXiT
 ji0QQaTdrNcg4nPSsGJkAxDaIcv8t6zCNr0UhJN4qnl+wNI2GOQc/ku5hL4HmCkKPHud
 H2qlDu1OxR6EwhCf912NNfiCxvkQvG99/lZnF560z5pdu10G6PFQrm9eIrarU5QFNs0D
 zX8Q==
X-Gm-Message-State: AOJu0YxDK1HAH+jZnXqOp4CwQ3kbMHDUPsLclqZk14iOkZoMwcjKuDfx
 1YTUd96djoxmqXwSwKj8apSQW8P9iefGP0TL3vZ+fPL4oNtM/HWmAQQU2rtO1WGxNFWNB3KSGE/
 qDQ==
X-Gm-Gg: ASbGncsmvtV9PUnKj3kzRLQKzky5MaVXV/orkJjMnZNWdU9zQBWSg11vQWnpHv3kf39
 5nsv7BPQc1AsCQBJs5PqArIACv3JmZqpz7o2gduoCutCKcdU8jVUyLzH2SUq+WmIaF3E1RlV7QC
 EY889jxs7sY96iSB+YEwX8eGpaqB7uuiPW7UoLchliJWotEx+1YHp9JIp3AFv74eX+BZP0YUxwK
 g02B7nKEXCKyBcgrOLh1o1L45gwjQpooHcu+SQcO9Lhn6ENGEMhBJbJqz7jhc9QKScd6hpEh1N5
 tnMfDOhXrsICxd7wJ9km0ftVxbHBRoBB2RDGNd1PZg==
X-Google-Smtp-Source: AGHT+IFX/24xAs19T1fwChwCMR4nYN9u2AcvkUiBhDtX9e0i3IN2UDzXh7fsFRfCKcxXbcdT3LGvrg==
X-Received: by 2002:a05:600c:4fd4:b0:43c:f8fe:dd82 with SMTP id
 5b1f17b1804b1-43d1ec8e682mr75321525e9.18.1742048852696; 
 Sat, 15 Mar 2025 07:27:32 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 11/46] x86: Add 64-bit entries to the GDT
Date: Sat, 15 Mar 2025 14:25:31 +0000
Message-ID: <20250315142643.2600605-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

At present it is not possible to execution 64-bit code without
installing an entire new Global Descriptor Table. This is inconvenient
since kvm does not seem to like switching into long mode with a new
table.

It isn't actually necessary, since we can just extend the existing
table. Add some new entries to this effect.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/i386/cpu.c          | 3 +++
 arch/x86/include/asm/processor.h | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index a51a24498a7..3bbad3b2eca 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -160,6 +160,9 @@ void arch_setup_gd(gd_t *new_gd)
 
 	gdt_addr[X86_GDT_ENTRY_16BIT_FLAT_CS] = GDT_ENTRY(0x809b, 0, 0xfffff);
 	gdt_addr[X86_GDT_ENTRY_16BIT_FLAT_DS] = GDT_ENTRY(0x8093, 0, 0xfffff);
+	gdt_addr[X86_GDT_ENTRY_64BIT_CS] = GDT_ENTRY(0xaf9b, 0, 0xfffff);
+	gdt_addr[X86_GDT_ENTRY_64BIT_TS1] = GDT_ENTRY(0x8980, 0, 0xfffff);
+	gdt_addr[X86_GDT_ENTRY_64BIT_TS2] = 0;
 
 	load_gdt(gdt_addr, X86_GDT_NUM_ENTRIES);
 	load_ds(X86_GDT_ENTRY_32BIT_DS);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index d7b68367861..ad8240be387 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -18,7 +18,10 @@
 #define X86_GDT_ENTRY_16BIT_DS		6
 #define X86_GDT_ENTRY_16BIT_FLAT_CS	7
 #define X86_GDT_ENTRY_16BIT_FLAT_DS	8
-#define X86_GDT_NUM_ENTRIES		9
+#define X86_GDT_ENTRY_64BIT_CS		9
+#define X86_GDT_ENTRY_64BIT_TS1		10
+#define X86_GDT_ENTRY_64BIT_TS2		11
+#define X86_GDT_NUM_ENTRIES		12
 
 #define X86_GDT_SIZE		(X86_GDT_NUM_ENTRIES * X86_GDT_ENTRY_SIZE)
 
-- 
2.43.0

