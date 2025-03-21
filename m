Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F3BC36002
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 23:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6819D81A0C;
	Sat, 22 Mar 2025 00:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="G5mEqKkF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34F5481C84; Sat, 22 Mar 2025 00:21:46 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 052CC81D25
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 00:21:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E9DE33FCD4
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 23:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1742599296;
 bh=9+WJZkJ5xEnn/DEttcjd5GSk+2Zhbrp4inLmXMWDOmM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=G5mEqKkFVX1ziqc631vPHOiWq9+AFWgie+Ba4sgAp7rx0uOrt1DnVw/bxqK1MZAib
 BtZ9IJ/KId7/ijmr7D3loKeFfQ3r1tbPalMyNQSTXB1LkmxPk1tnIFacUDseZKWWtx
 tyMCFC2CYbCgUpUcqnDuxEjyUssGjgd+GIJ7z5+0lzFcQ9OlZqshH6nDujYxHm0mzH
 R4lNsMQEhbCB1A5BJptUQ1Zu0w2hNCI3QzpIzCIwUHK+VzszaIVnZNHhf7DISenmi8
 R83x9lUTqPPNL+dGgxgJMSjd9LrrHQh4HaAzMSciTqCWdfQy8LMdx+DxTFaer9vpaJ
 TTZAgFd3BsHzw==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab7f6f6cd96so263831066b.2
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 16:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742599295; x=1743204095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9+WJZkJ5xEnn/DEttcjd5GSk+2Zhbrp4inLmXMWDOmM=;
 b=muB078Opeo3B8OUpIMiIDGpWv0IDedeMK0WoDsb8LULvLdH3T6DLLybRgLLgnWrvYO
 KWHAN9hyPczDIjJkKQ78bGGUBlNncwSbpoekPtGYn2E/ImzO9yYv2ig9RIHSnGIl0zdv
 zcns8dKzFGVsaLwFcHyD9gUePv45ZoSfrc39zBsi4ZH4gf++vH4V4eevYK2D/QT3oBzI
 CVMGA5kCU+mj7lY1TT4tAZxPiaFwqMu/f+Y9vT+CXUG5boiPKPFyDtb9YcYxV+J7AKKN
 DKM4SsZfG/bjo4GIow3NtUzUYzrLAuvb1KrsiZwpl52TDZyy7LszHchIagnQwn2dIKOr
 haRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo2asaSaplEJIsrjYX5FmEAjw2hofeTbK8zs2ppVbFpzVojRhPl2yuSggsRfEV2M3tsO4rrAE=@lists.denx.de
X-Gm-Message-State: AOJu0YyuNjcfFYoDFsEfpYz2J0PxpODXyZOPRVdG/sTbM5+3UG9Y2GiG
 +NB70/WQqngNQzyFPLOmkrPVBnrv/HLI9mMtbTABYUByQvYCsCkLHQG6wPiKG26iK5H4KvWBs6D
 YU4OcBbvSnY/rvgMiNt9LYWF/WIwtjlZ3u09kEsp52xeL2+YEF72C8w23XyS/61epJEE=
X-Gm-Gg: ASbGncsjuOS0fTDIfpr5Z95qlLPSA68WDjQNpKXAktfRqE66pPtudwV7oTntSzamkTx
 OewuBNzM3Nzo5ZvOQMdQ+K3R+5uFJ1tk5JCSJMnkgsceatwoSeleZzNboek0t5adciyNhXRPHna
 SCf3Vbh0XgWhUEjc7+lDA74/s1GM5V0LqaSOAvDJCt04LXGAet5r9cU8ekzl7GgsxgnbrZVvK8L
 YNv0WReEfs8iNUCRhf1Ipow+4XwLFORaGUXrotGMUOUCymNDWC3ump6bUEl3yYV1jlw8BNH4Y3I
 f3Imc3ZHESIG32r//b7oReFTJYwDVL8tGOXfvdJQ465Lvjqe4c3SHzInp8hrxcgqFGHplRtpdrY
 4BtsvwRZEgQi5MY4vWA==
X-Received: by 2002:a17:906:d7cc:b0:abf:73ba:fd60 with SMTP id
 a640c23a62f3a-ac3f22b8b4bmr541581866b.29.1742599294773; 
 Fri, 21 Mar 2025 16:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/Pdz5p2RPUGa52jcrXBJb2l//jHUbxcD4bczjsGUht/PAOfdPpneRNjyA7hhICCWBdoAENQ==
X-Received: by 2002:a17:906:d7cc:b0:abf:73ba:fd60 with SMTP id
 a640c23a62f3a-ac3f22b8b4bmr541579966b.29.1742599294286; 
 Fri, 21 Mar 2025 16:21:34 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efd3aa21sm231673866b.158.2025.03.21.16.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 16:21:32 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Fiona Klute <fiona.klute@gmx.de>, Martin Stolpe <martinstolpe@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/5] acpi: new function acpi_update_checksum()
Date: Sat, 22 Mar 2025 00:21:16 +0100
Message-ID: <20250321232121.251800-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321232121.251800-1-heinrich.schuchardt@canonical.com>
References: <20250321232121.251800-1-heinrich.schuchardt@canonical.com>
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

Introduce a new function to update ACPI table headers.
This allows to simplify the existing code.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/acpi/acpi_table.h | 7 +++++++
 lib/acpi/acpi.c           | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index b8b1f1338c6..f8e5f552ab1 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -1274,6 +1274,13 @@ ulong write_acpi_tables(ulong start);
  */
 struct acpi_table_header *acpi_find_table(const char *sig);
 
+/**
+ * acpi_update_checksum() - update ACPI table checksum
+ *
+ * @header - header of an ACPI table
+ */
+void acpi_update_checksum(struct acpi_table_header *header);
+
 #endif /* !__ACPI__*/
 
 #include <asm/acpi_table.h>
diff --git a/lib/acpi/acpi.c b/lib/acpi/acpi.c
index f4d5c1e25d0..596301a43fe 100644
--- a/lib/acpi/acpi.c
+++ b/lib/acpi/acpi.c
@@ -6,11 +6,18 @@
  */
 
 #include <mapmem.h>
+#include <tables_csum.h>
 #include <acpi/acpi_table.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
+void acpi_update_checksum(struct acpi_table_header *header)
+{
+	header->checksum = 0;
+	header->checksum = table_compute_checksum(header, header->length);
+}
+
 struct acpi_table_header *acpi_find_table(const char *sig)
 {
 	struct acpi_rsdp *rsdp;
-- 
2.48.1

