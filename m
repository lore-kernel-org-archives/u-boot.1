Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D53EEE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4835689166;
	Wed, 11 Sep 2024 08:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="SwQ6hBvy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C3BF89170; Wed, 11 Sep 2024 08:25:28 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 549B089167
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5365a9574b6so7374034e87.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035924; x=1726640724; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ye4pegRetMsk7hgGEAWGVKWSQXVODelTSdL4O4F/DrQ=;
 b=SwQ6hBvyFYoVBw9exI7dnf7px1jUgquS8/JAC2+BzmziBXJhNDast1iq3J0otX0gQn
 oBdEdUPMJOtItuLWi4Uo2H29jn12/4eEVoi8Zeo5cxzVNC6FOjfidycT4xdNCBYDXzo4
 FBTsV3z/eMm1h9Igr5MOhyK032h04M9ok2B4JDGHleOv40cKucDIRX6OCN6b3LVuscfL
 wP9dN8HOvNK0GmPckdyxgmyG6H83AsvFA2m01gyfVbJmzpdSSYbsrGJahySyP9ivyC8a
 L9KVXfI/qfBZjGQwqIKJ4B+1q9jNoeHyGGbG90/aQ7OF32jx/MN9ReX7unCT+clpL5Y5
 +RSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035924; x=1726640724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ye4pegRetMsk7hgGEAWGVKWSQXVODelTSdL4O4F/DrQ=;
 b=uJNXGhchk68s+xDpgACrSR24wqkRm/WWswV1n8aBMFbKdMXm/bNQTZBPVaZcITU+WM
 qbLYw+ZmzL1stbO/0U47T2K8HxIOdamKd6ZKmPu6f4C0kdVjfWndmuE1/OoM5AqUXVKp
 EARIuSZdpky2t3IYzK9YlrYo/zJTjwrXOzZq4j6N/aECY7q9QVrlhLjpCKiznF53yNbi
 ZZIvSlBXY7nNkKIJoWg3X4pOzEUc6GoO4XQ8+iY7CkpPCmX5bIe+GKWqOMIu0nDYzK2P
 nkK41WSNqSUQvVkg/Jrk91pNHFGxwJe7w2Tw5j5xGM15xem0786Qmi9uB3r3fc7eXNa2
 2JuA==
X-Gm-Message-State: AOJu0Yzl1vvxdrh6vjoVN6HSySYqD1Qfu3yQzuJbTAvE/TYS20ZQF9J7
 P9RmG1t99xdGvvcRYAKstbFXnfqIU16KTG7Q86LiopJYknnxOzdUXRwWTPvqPuZR047Wf+nsbiu
 8
X-Google-Smtp-Source: AGHT+IFFjLx3kH/SBPe3+v4yx5qa8vX/z2e+mxX5sLteBmLSL+1CikiMsIC262AXb13VcAm1yjnTUA==
X-Received: by 2002:a05:6512:3ba5:b0:530:e0fd:4a97 with SMTP id
 2adb3069b0e04-5365856d92bmr15824068e87.0.1726035924229; 
 Tue, 10 Sep 2024 23:25:24 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:25:23 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 04/30] acpi: Fix typo
Date: Wed, 11 Sep 2024 08:23:54 +0200
Message-ID: <20240911062511.494855-5-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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
index 1a49578b6e..26da42967f 100644
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

