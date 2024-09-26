Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69E4CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32AB488D35;
	Thu, 26 Sep 2024 10:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Y+/yHRqX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD9C088C4C; Thu, 26 Sep 2024 10:02:23 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0598C88D39
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c5bca59416so577489a12.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337735; x=1727942535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ty3pISRwyVUFKzN6AV+o1jhF3tqF577Jx2Jy943PdvE=;
 b=Y+/yHRqXV9MIS15LjFDHOqZGFbTQQvEuo8ut4Vz9uti3Z06jIXKcos3DF6NEpk2qF1
 VWIKzX+z1TEbgeaRhiXHM227PzwT7DyDrr1Y/8Fu1juEMHp/H7EEvH90/jgTFXTjHJUp
 vptf5kLQw53ExjnZ2cMfW/kVyGijrYVqlGaYWVVYOLoVFswRra1cMcEPpSr/2S718VyV
 5gh/LI01KSoNJsBUeuCnpQfi+4WBZGo62fZP6tklqfdPD+Mw5joRYqROUbGnTbrHyth/
 WJURRqlLdGN9xL8AvRJopX7lDE57IV/RMxBtIMJIcifY+JZ69I+P66lxUkwIGgF2izhy
 tU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337735; x=1727942535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ty3pISRwyVUFKzN6AV+o1jhF3tqF577Jx2Jy943PdvE=;
 b=KtlnBdwQet9np50hJclR39SnFzk5FaB2saqjkHCTSAqpgdrqJFYwyjazjNvyvAIRTG
 f4k8dWH1u+UmwVHd91iKCX8D/UCnAkB8ElmW40UngoYQKTTlPl4LQ1oq8uUi7mobhCQs
 J2UmgXH4VyYdy0Sij+SB+2khdgFGGXGeQaCz45HPHSTDynnzLQvrvzccWCbi7naXWu54
 xtRIb0DHyfrQdOl4eZDQoxjn9s2x2im+a9PsaJi/CiJtTghpRc+NvD/VJFvz8dNj/n93
 itefBaOds6ykRymNGCieT7Aoaij4n9XL0H6qHR4x6yX2khyd+8x9J4JEunbb5eTMOTOB
 YBtA==
X-Gm-Message-State: AOJu0YwAtXUk6+g9S0scexnSCCXnC3FJbLEIa9I+1XgOWfGpJsdRmDEy
 TgxOajBsXC3D1Q5PJGPNOh4FQYliNFncp8aTYrTAKWcOdETvX/w3n2Hf2xJ8Cqw6Hyah+ZKH6nk
 8
X-Google-Smtp-Source: AGHT+IEZheKSF1uLk+YpvmMkRKtNPTrpknmYLduo59I7aSq/YsH4K3OPxgNd4lY7wrzyMIOYJSki8Q==
X-Received: by 2002:a05:6402:5113:b0:5c8:77a5:d486 with SMTP id
 4fb4d7f45d1cf-5c877a5d696mr1416266a12.33.1727337735118; 
 Thu, 26 Sep 2024 01:02:15 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:02:14 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 04/36] acpi: Fix typo
Date: Thu, 26 Sep 2024 09:58:52 +0200
Message-ID: <20240926080021.148031-5-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
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

Rename ACPI tables MADR to MADT.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
---
 include/acpi/acpi_table.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index c356df72ba..a1bdab7305 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -386,20 +386,20 @@ struct __packed acpi_madt_lapic_nmi {
 	u8 lint;		/* Local APIC LINT# */
 };
 
-/* flags for acpi_madr_gicc flags word */
+/* flags for acpi_madt_gicc flags word */
 enum {
-	ACPI_MADRF_ENABLED	= BIT(0),
-	ACPI_MADRF_PERF		= BIT(1),
-	ACPI_MADRF_VGIC		= BIT(2),
+	ACPI_MADTF_ENABLED	= BIT(0),
+	ACPI_MADTF_PERF		= BIT(1),
+	ACPI_MADTF_VGIC		= BIT(2),
 };
 
 /**
- * struct __packed acpi_madr_gicc - GIC CPU interface (type 0xb)
+ * struct __packed acpi_madt_gicc - GIC CPU interface (type 0xb)
  *
  * This holds information about the Generic Interrupt Controller (GIC) CPU
  * interface. See ACPI Spec v6.3 section 5.2.12.14
  */
-struct acpi_madr_gicc {
+struct acpi_madt_gicc {
 	u8 type;
 	u8 length;
 	u16 reserved;
@@ -421,12 +421,12 @@ struct acpi_madr_gicc {
 } __packed;
 
 /**
- * struct __packed acpi_madr_gicc - GIC distributor (type 0xc)
+ * struct __packed acpi_madt_gicc - GIC distributor (type 0xc)
  *
  * This holds information about the Generic Interrupt Controller (GIC)
  * Distributor interface. See ACPI Spec v6.3 section 5.2.12.15
  */
-struct acpi_madr_gicd {
+struct acpi_madt_gicd {
 	u8 type;
 	u8 length;
 	u16 reserved;
-- 
2.46.0

