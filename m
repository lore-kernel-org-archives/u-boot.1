Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C72C54747
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D26688AAA;
	Wed, 28 Aug 2024 03:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hvVmYl7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BDEF88A8E; Wed, 28 Aug 2024 03:44:38 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B2C88A7B
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-829e856a173so99406639f.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809474; x=1725414274; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdt/yQhGYtNjoMWAyHLJu0yyItecK5sjvsh7rw4oWPk=;
 b=hvVmYl7z6XjC5mnpvg+MwXXSdH2ihBpmMto8AjNLTWIIxDkdgIkriaPPWoSK5hpXpd
 YOl8Y9JIt/11poi3CRb9ZD8jGMJ9UfNdXiZOTb26GFAC1Dp3LIpvBxGqtKP6qCNcE3Cu
 PItFO8k0MZ3+4GyZGXGHEY9dsBsaDkH2D9atQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809474; x=1725414274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qdt/yQhGYtNjoMWAyHLJu0yyItecK5sjvsh7rw4oWPk=;
 b=C5C/IJbar+lWUI3aRyIVLKCyex3CyNJebjWL5XDTz67WV/3lgqQwWyB8utLql5Idjo
 6HJzcaGmyhPgKi+Jcr9KigrqkLEOEFhJ+jrNtrKpeckyKzpssHSBXUP5tBrDJi24+Jjj
 F9dEk7mY1F1vtjKiqBeLvOuB69As2j6l3MXLPN6UCdtAu8FkNu17L+IdtGJqQy2Lr92f
 AmtBSR6N3y0OHBlFIUFo114bPYIosUjCINbsDRCKJgmvUpXjjPyMkUpsDN+KCHyv+8Mn
 O4GliHpyiX0NpsmhWtxDEfQ7KHTdckHQdtHp51Tln/6kHlVueMPd7npeB27JbOaF0NJm
 EQ3w==
X-Gm-Message-State: AOJu0YxbarBFfHsgY+aF4Lh7dSRphEyBIBiZWZ9QSvNte4/YBXyjaavq
 Fowl6s/bNXRnB2QudocfOJ8DLvr/Fk8pNTccQeNxI87WeahMsqGfishLz6cbxN/venq1a0E1TIU
 =
X-Google-Smtp-Source: AGHT+IG5CfeM8uDGLvtH2mIkkOfLBMVgpWBPoZFFyZgQrbvoELaj0MCNmLDc8lwRqjAOPSoAhPan+w==
X-Received: by 2002:a05:6602:2c94:b0:824:e42e:a1bd with SMTP id
 ca18e2360f4ac-827881eb403mr1814354439f.17.1724809474576; 
 Tue, 27 Aug 2024 18:44:34 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8253d3da8b9sm366342439f.0.2024.08.27.18.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:44:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH 1/6] x86: Show the CPU vendor in bdinfo
Date: Tue, 27 Aug 2024 19:44:24 -0600
Message-Id: <20240828014429.3320011-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014429.3320011-1-sjg@chromium.org>
References: <20240828014429.3320011-1-sjg@chromium.org>
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

Refactor the cpu code and use it to show the CPU vendor, e.g.
AuthenticAMD or GenuineIntel

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/i386/cpu.c           | 94 ++++++++++++++++++-------------
 arch/x86/include/asm/u-boot-x86.h |  8 +++
 arch/x86/lib/bdinfo.c             |  7 ++-
 3 files changed, 69 insertions(+), 40 deletions(-)

diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index 934e98ac582..101837b3190 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -263,6 +263,49 @@ static int build_vendor_name(char *vendor_name)
 }
 #endif
 
+int x86_cpu_vendor_info(char *name)
+{
+	uint cpu_device;
+
+	cpu_device = 0;
+
+	/* gcc 7.3 does not want to drop x86_vendors, so use #ifdef */
+#ifndef CONFIG_TPL_BUILD
+	*name = '\0'; /* Unset */
+
+	/* Find the id and vendor_name */
+	if (!has_cpuid()) {
+		/* Its a 486 if we can modify the AC flag */
+		if (flag_is_changeable_p(X86_EFLAGS_AC))
+			cpu_device = 0x00000400; /* 486 */
+		else
+			cpu_device = 0x00000300; /* 386 */
+		if (cpu_device == 0x00000400 && test_cyrix_52div()) {
+			/* If we ever care we can enable cpuid here */
+			memcpy(name, "CyrixInstead", 13);
+
+		/* Detect NexGen with old hypercode */
+		} else if (deep_magic_nexgen_probe()) {
+			memcpy(name, "NexGenDriven", 13);
+		}
+	} else {
+		int cpuid_level;
+
+		cpuid_level = build_vendor_name(name);
+		name[12] = '\0';
+
+		/* Intel-defined flags: level 0x00000001 */
+		if (cpuid_level >= 0x00000001)
+			cpu_device = cpuid_eax(0x00000001);
+		else
+			/* Have CPUID level 0 only unheard of */
+			cpu_device = 0x00000400;
+	}
+#endif /* CONFIG_TPL_BUILD */
+
+	return cpu_device;
+}
+
 static void identify_cpu(struct cpu_device_id *cpu)
 {
 	cpu->device = 0; /* fix gcc 4.4.4 warning */
@@ -289,46 +332,19 @@ static void identify_cpu(struct cpu_device_id *cpu)
 		return;
 	}
 
-/* gcc 7.3 does not want to drop x86_vendors, so use #ifdef */
 #ifndef CONFIG_TPL_BUILD
-	char vendor_name[16];
-	int i;
-
-	vendor_name[0] = '\0'; /* Unset */
-
-	/* Find the id and vendor_name */
-	if (!has_cpuid()) {
-		/* Its a 486 if we can modify the AC flag */
-		if (flag_is_changeable_p(X86_EFLAGS_AC))
-			cpu->device = 0x00000400; /* 486 */
-		else
-			cpu->device = 0x00000300; /* 386 */
-		if ((cpu->device == 0x00000400) && test_cyrix_52div()) {
-			memcpy(vendor_name, "CyrixInstead", 13);
-			/* If we ever care we can enable cpuid here */
-		}
-		/* Detect NexGen with old hypercode */
-		else if (deep_magic_nexgen_probe())
-			memcpy(vendor_name, "NexGenDriven", 13);
-	} else {
-		int cpuid_level;
-
-		cpuid_level = build_vendor_name(vendor_name);
-		vendor_name[12] = '\0';
-
-		/* Intel-defined flags: level 0x00000001 */
-		if (cpuid_level >= 0x00000001) {
-			cpu->device = cpuid_eax(0x00000001);
-		} else {
-			/* Have CPUID level 0 only unheard of */
-			cpu->device = 0x00000400;
-		}
-	}
-	cpu->vendor = X86_VENDOR_UNKNOWN;
-	for (i = 0; i < ARRAY_SIZE(x86_vendors); i++) {
-		if (memcmp(vendor_name, x86_vendors[i].name, 12) == 0) {
-			cpu->vendor = x86_vendors[i].vendor;
-			break;
+	{
+		char vendor_name[16];
+		int i;
+
+		cpu->device = x86_cpu_vendor_info(vendor_name);
+
+		cpu->vendor = X86_VENDOR_UNKNOWN;
+		for (i = 0; i < ARRAY_SIZE(x86_vendors); i++) {
+			if (memcmp(vendor_name, x86_vendors[i].name, 12) == 0) {
+				cpu->vendor = x86_vendors[i].vendor;
+				break;
+			}
 		}
 	}
 #endif
diff --git a/arch/x86/include/asm/u-boot-x86.h b/arch/x86/include/asm/u-boot-x86.h
index 3acc58ad74b..5cc8f63334e 100644
--- a/arch/x86/include/asm/u-boot-x86.h
+++ b/arch/x86/include/asm/u-boot-x86.h
@@ -51,6 +51,14 @@ int x86_cpu_init_tpl(void);
  */
 void cpu_reinit_fpu(void);
 
+/**
+ * x86_cpu_vendor_info() - Get the CPU-vendor name and device number
+ *
+ * @name: 13-byte area to hold the returned string
+ * Return: CPU device number read from cpuid
+ */
+int x86_cpu_vendor_info(char *name);
+
 int cpu_init_f(void);
 void setup_gdt(struct global_data *id, u64 *gdt_addr);
 /*
diff --git a/arch/x86/lib/bdinfo.c b/arch/x86/lib/bdinfo.c
index 165e8ab944f..2a78f578dee 100644
--- a/arch/x86/lib/bdinfo.c
+++ b/arch/x86/lib/bdinfo.c
@@ -19,7 +19,12 @@ void arch_print_bdinfo(void)
 	bdinfo_print_num_l("clock_rate", gd->arch.clock_rate);
 	bdinfo_print_num_l("tsc_base", gd->arch.tsc_base);
 	bdinfo_print_num_l("vendor", gd->arch.x86_vendor);
-	bdinfo_print_str(" name", cpu_vendor_name(gd->arch.x86_vendor));
+	if (!IS_ENABLED(CONFIG_X86_64)) {
+		char vendor_name[16];
+
+		x86_cpu_vendor_info(vendor_name);
+		bdinfo_print_str(" name", vendor_name);
+	}
 	bdinfo_print_num_l("model", gd->arch.x86_model);
 	bdinfo_print_num_l("phys_addr in bits", cpu_phys_address_size());
 	bdinfo_print_num_l("table start", gd->arch.table_start);
-- 
2.34.1

