Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAD1CF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F35189308;
	Wed, 23 Oct 2024 15:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="NWeUJeW1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B19389357; Wed, 23 Oct 2024 15:29:24 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D453B89367
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d3ecad390so639685f8f.1
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690155; x=1730294955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WwKTa2EBAz4I04/nwNCkYGEwdnLhNaFfCA7k8RayRf0=;
 b=NWeUJeW1iuGFkL6jUdckmN/1udx0jq06jmLVzpdiGPSlzUAM/Ak8PIaNyfIxn+HOyL
 KaG1nJXtcB+9b4k3rwS+h0G+n3gKXapm/LFtb08EmG32g0Wb2ZuSPcqZLEUx4Dh7yULU
 Y9xFE9dkjCx4SGOTZ1jYQkrgro8V18jlJthWJyoqLLGtCfljU13F5B0gk5i6sTaFSR8d
 pXb6NER1C2kxAD2oXY82nsPtZIsrxdPN/srsBLh/kVlnII9khYN26AP0ggqosP6/r7Ru
 y6F14x9yYInKJhPKmSdUWCA1ygdXiHJizqsXth/QKOmTOrrM4j/aodgzwy2XhTZAzUXt
 eGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690155; x=1730294955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WwKTa2EBAz4I04/nwNCkYGEwdnLhNaFfCA7k8RayRf0=;
 b=Z1WElmZUGCYrt+JPhbX6P+QUpXzZhd9TOWCSMtgnd2VSPDQgNy7yr9QbPJW0/gVTXi
 FPogPGxxrOel+2jf62ynjMN+y8aHYhkvDNM/BmRr6kqxBT4hMs+gqSOSS4eIOSFESpql
 pPgGPcGFhtAKsv2Ul0gG7Z+7LN018XumMUvrK20sgqDEr1MZHl7Jg7hmfpfDZ3ixcjTu
 ffmJzuPmG2GgxT5nEsekICXvYfvq/2CXqL6sFvaBnpBxD++m2kIaMW61Sid1Pr3ayEtU
 7BF83D7Zj/iCuhB6oqSES92o0QJdF+gIYqOpR+lwlAbEb3eDk08giwnkwivy0j+l6Eqq
 MeXA==
X-Gm-Message-State: AOJu0YyBk9og7iSDPEthOdFu5zXtnz4aLL8Kt6tuJUSOWPYOunxwSjt9
 f0ySjzqSBO9D3riGh99RKL86t+YZ5uMdO09HY83MyGgZqOKOq3S9KCIV5+HHSFXsB+fKHpxZGkb
 N
X-Google-Smtp-Source: AGHT+IFeBXTIINucHYCMJsW2SG5ZTFaZ8ZRlD5SIIa0gW1Uc7vsZmPgLhyH/1hWliCZd9umIKYkMOA==
X-Received: by 2002:adf:e88d:0:b0:37d:47eb:b586 with SMTP id
 ffacd0b85a97d-37ef12592e5mr4733714f8f.4.1729690154047; 
 Wed, 23 Oct 2024 06:29:14 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:29:13 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 24/37] common: Enable BLOBLIST_TABLES on arm
Date: Wed, 23 Oct 2024 15:20:07 +0200
Message-ID: <20241023132116.970117-25-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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

Allow to use BLOBLIST_TABLES on arm to store ACPI or other tables.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
Changelog v9:
- default to BLOBLIST_ALLOC on arm
- Move default for BLOBLIST_SIZE_RELOC up
Changelog v10:
- Revert changes done in v9 and use revision v8
---
 common/Kconfig |  1 +
 lib/Kconfig    | 15 +++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 957de0c5c0..c3a68e33de 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1077,6 +1077,7 @@ config BLOBLIST_SIZE_RELOC
 	hex "Size of bloblist after relocation"
 	default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
 	default 0x0 if BLOBLIST_PASSAGE
+	default 0x20000 if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
 	help
 	  Sets the size of the bloblist in bytes after relocation. Since U-Boot
 	  has a lot more memory available then, it is possible to use a larger
diff --git a/lib/Kconfig b/lib/Kconfig
index 1dd4f27159..2e0fc1bc8f 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -984,12 +984,15 @@ menu "System tables"
 
 config BLOBLIST_TABLES
 	bool "Put tables in a bloblist"
-	depends on X86 && BLOBLIST
-	help
-	  Normally tables are placed at address 0xf0000 and can be up to 64KB
-	  long. With this option, tables are instead placed in the bloblist
-	  with a pointer from 0xf0000. The size can then be larger and the
-	  tables can be placed high in memory.
+	depends on BLOBLIST
+	default y if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
+	default n
+	help
+	  On x86 normally tables are placed at address 0xf0000 and can be up
+	  to 64KB long. With this option, tables are instead placed in the
+	  bloblist with a pointer from 0xf0000. The size can then be larger
+	  and the tables can be placed high in memory.
+	  On other architectures the tables are always placed in high memory.
 
 config GENERATE_SMBIOS_TABLE
 	bool "Generate an SMBIOS (System Management BIOS) table"
-- 
2.46.2

