Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EEFC021A4
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A458880FA0;
	Sun, 16 Feb 2025 21:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jYm100jX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AACF80F64; Sun, 16 Feb 2025 21:45:14 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDA4980F95
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3d04932a36cso34855875ab.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738709; x=1740343509; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jhxSIFalaVLSVgG6wVZXyEthG0WD5Vpn2+AsnABXDE=;
 b=jYm100jX9UQ3yiWejHUBSQRDo77P57yAmBAXPaXWRVnwBCLyUDhKKagfeS9q4a8lcx
 0/91ZeMq+Z/s9BbDfLMXJQQc0oKpF1/+6AyYvv/WlNACRKLF1nHhpvZ66M0ch7+hL6IT
 kqY6peSRtXKxDMe0G7m8DsX4safqLRO1Pe4qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738709; x=1740343509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jhxSIFalaVLSVgG6wVZXyEthG0WD5Vpn2+AsnABXDE=;
 b=DC0nC5xarGpm/l6QOpqYRMd7WBj0TodlCfmm0BDJpoozFxn0EzQ/7IDmYE5BrKYjsg
 UrrF4q2LhIaFJwlIS+SQ3Day7tb54leECo6T5aDEx5E+2HP9jX4GiTLP9aTuGyR00mVh
 vsDSBM7se9FnekwvQzaB4hUAwa3KMGJ0s/3TLuJ6gIH3AwCMDXI6hnqhEbFjgYI8puxJ
 zgDIPSbBchw9hh//90CH1mvWo8Bc5hjuabgWAGzYmZ51g+SAX9Pir2L76JRjgQTUZU/L
 Iu3zmTymY0EiSdvh84ygPoCqkH9z3Lr7bQPxUlDnRcigoVQA/xbeWbpVvE5LgmYwjHMb
 SdSA==
X-Gm-Message-State: AOJu0Yx3i+m1TVIYAhL2xWq9+6ZYZvHaYdHaLtBiMUG9qmwKMgiWncDX
 HTfTeoLW2YDtFIB7pvFYbUDj7sfE9HrNn8j4WphY1Z23f4WFP1dlRE0oT9MvZsuvy0BeHOv106M
 =
X-Gm-Gg: ASbGncu60oVw35z1cq6QlqURVp/aeM9i3UykqWBt9oGBUDe5cnb3dRL7ttRSnxNkrKA
 QGJpQbIORUHMSECQBJtC2clBRgcc7DohaQgDQXkJ1L33DNtrTtFqywrLGwSwWSx3TpzCdv7DcA+
 ZYbCfwovZAqXNDHEQAU1RTtfEP/+Heee3T0F49w8bB+dXJjV5tqxXzvBksskEGkrOzxucxaJxZ+
 0nyoPxIfke/fEl/jPjkresfV4HcSnkD5qdJdq1zUydV5vaw4JdBXfQZbIutpA6t8VlXNmEtkT8P
 1pT8CHQAQL7rvdVQjWA0XPZxtMlDo8/u2kjqELJEn//3C+IJuGJZ
X-Google-Smtp-Source: AGHT+IFdi/76IWJq6XBcxNoWwKPC23EnxeenX+uLOqY6fmO8XbKMxP/8KWvBd6Jho/w7BcU6X6txXA==
X-Received: by 2002:a05:6e02:1aac:b0:3d0:25d0:8507 with SMTP id
 e9e14a558f8ab-3d280791f05mr52029055ab.6.1739738709077; 
 Sun, 16 Feb 2025 12:45:09 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/28] x86: Add 64-bit entries to the GDT
Date: Sun, 16 Feb 2025 13:43:54 -0700
Message-ID: <20250216204421.3560012-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

