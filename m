Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF63C3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 07:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2258688718;
	Sat, 27 Jul 2024 09:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="RR1/qN/7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B35588210; Sat, 27 Jul 2024 09:20:21 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52532886A6
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 09:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52efbc57456so2222827e87.1
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 00:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1722064818; x=1722669618; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YjZv73GiUnPDjpL34Uqc2pCleiAzOUH+gfGUlHFsQV8=;
 b=RR1/qN/7ESckD8VCstvcP4oyF3OitM95yAAVOjeuTeRH5PYrPWiq0RLNyLrrqbnQcj
 I5UvSV04TYZ3vb2+ebZMh+Vgy0VezDaGLRWYKdM0bd+bt5x91GR3LCmRPENedM1S4wUi
 /6O6SMuwotqFUA8Nqv9jeqU8T2wtzF2zN17jf0F3EvmmsjyN25R8kbdghfJMJw53UWKW
 4EdCwpBCZ49xXwr8tBN7OrJ/NnRSVstozElm3d3ackAZo4Obdqt7OfgYFi1nzVKrIozi
 //auDa6f6cgxSlggxRjS9RXFhPKte1qqlfiMbMhT3xU9iuMiOKXXXy7tDBXlSQ1AKHT4
 zieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064818; x=1722669618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YjZv73GiUnPDjpL34Uqc2pCleiAzOUH+gfGUlHFsQV8=;
 b=nN7V72z5iwgZVmwA5DCLJ62QvfKgt3CKEDhO8u5E/ugguonN76ndotTV/D2rOM9f36
 Up4ZaPZDyw9DTUZb+GB9zpe/P3jaQS1vDFXmW0PmrfKSrqKI4pDv9Ecg61dACqZbts5K
 21msh4hUyWNn6lky2AlbveHGpXHJ9ccr/WMxS0fcQkXz1P+qXBova4U7k8EYPMIwkiAi
 T/15hf8S2NxC9rsNLO/IwXsbbNYqtIWWrMEaNYVkozhy/PoHNRF/OLTa3ldgHWHjIKUm
 OcuqxCmDRsI4GF6GkzN5RRdwj4yAzZltM0YTrJdnO4Vvw4/CSKDERf/0NN57EZ12CfOJ
 SFTQ==
X-Gm-Message-State: AOJu0YyAiLNrXRutwjlYyhIxSy2Wo09VxUG5io268AUmHtOl86goejTN
 oAeThDe78NuPID50Pp06A0O7WIdXMqJ8j0V7AEToOqqa5mA3kzzs2FOPTSM0KI6JP1h6zM4xACw
 Bzsg=
X-Google-Smtp-Source: AGHT+IFbe/FgcQtxlDYn3FNMznG0jcTJLikmcfO/WHqfDNeQtbNGObPbIujqEZX/3lxqn2/AGIT6Zg==
X-Received: by 2002:ac2:4da8:0:b0:52c:c9ce:be8d with SMTP id
 2adb3069b0e04-5309b2ce922mr1084191e87.57.1722064818535; 
 Sat, 27 Jul 2024 00:20:18 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm253102866b.7.2024.07.27.00.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 00:20:18 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: mbrugger@suse.com, pbrobinson@gmail.com, trini@konsulko.com,
 bmeng.cn@gmail.com, Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 08/17] acpi: acpi_table: Bump revisions
Date: Sat, 27 Jul 2024 09:17:09 +0200
Message-ID: <20240727071742.1735703-9-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
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

The FADT structure found in U-Boot represents FADT revision 6 and the
GICC and GICD structures defined in U-Boot are based on ACPI revision
6.3.

Bump the table revision to fix FWTS failures seen on aarch64.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 arch/x86/cpu/tangier/acpi.c | 2 --
 include/acpi/acpi_table.h   | 3 ++-
 lib/acpi/acpi_table.c       | 7 ++++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.c
index 9e5e6c57aa..7b0bcfd956 100644
--- a/arch/x86/cpu/tangier/acpi.c
+++ b/arch/x86/cpu/tangier/acpi.c
@@ -28,8 +28,6 @@ void acpi_fill_fadt(struct acpi_fadt *fadt)
 		ACPI_FADT_POWER_BUTTON | ACPI_FADT_SLEEP_BUTTON |
 		ACPI_FADT_SEALED_CASE | ACPI_FADT_HEADLESS |
 		ACPI_FADT_HW_REDUCED_ACPI;
-	fadt->header.revision = 6;
-	fadt->minor_revision = 2;
 }
 
 void *acpi_fill_madt(struct acpi_madt *madt, void *current)
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 19771c133a..cbaac2fcb0 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -290,7 +290,8 @@ struct __packed acpi_fadt {
 #define ACPI_MADT_REV_ACPI_3_0		2
 #define ACPI_MADT_REV_ACPI_4_0		3
 #define ACPI_MADT_REV_ACPI_5_0		3
-#define ACPI_MADT_REV_ACPI_6_0		5
+#define ACPI_MADT_REV_ACPI_6_2		4
+#define ACPI_MADT_REV_ACPI_6_3		5
 
 #define ACPI_MCFG_REV_ACPI_3_0		1
 
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index d94e454018..fd8e6e4986 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -63,9 +63,9 @@ int acpi_get_table_revision(enum acpi_tables table)
 {
 	switch (table) {
 	case ACPITAB_FADT:
-		return ACPI_FADT_REV_ACPI_3_0;
+		return ACPI_FADT_REV_ACPI_6_0;
 	case ACPITAB_MADT:
-		return ACPI_MADT_REV_ACPI_3_0;
+		return ACPI_MADT_REV_ACPI_6_2;
 	case ACPITAB_MCFG:
 		return ACPI_MCFG_REV_ACPI_3_0;
 	case ACPITAB_TCPA:
@@ -223,6 +223,7 @@ int acpi_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	memcpy(header->oem_table_id, OEM_TABLE_ID, 8);
 	memcpy(header->creator_id, ASLC_ID, 4);
 	header->creator_revision = 1;
+	fadt->minor_revision = 2;
 
 	fadt->x_firmware_ctrl = map_to_sysmem(ctx->facs);
 	fadt->x_dsdt = map_to_sysmem(ctx->dsdt);
@@ -258,7 +259,7 @@ int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	/* Fill out header fields */
 	acpi_fill_header(header, "APIC");
 	header->length = sizeof(struct acpi_madt);
-	header->revision = ACPI_MADT_REV_ACPI_3_0;
+	header->revision = acpi_get_table_revision(ACPITAB_MADT);
 
 	current = (void *)madt + sizeof(struct acpi_madt);
 	current = acpi_fill_madt(madt, current);
-- 
2.45.2

