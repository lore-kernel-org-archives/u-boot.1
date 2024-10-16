Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FED5D2069E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80FE488E78;
	Wed, 16 Oct 2024 08:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="RZF2yHdo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 652E188CB8; Wed, 16 Oct 2024 08:13:21 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76DEE88E8C
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c9552d02e6so5840132a12.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729059199; x=1729663999; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xcSEsG4P1EbTSisKnf1P6Gzou9rCQHuXJkRJa2SjG4=;
 b=RZF2yHdoIJ2GNS4fjq6MQuLsZCcUA8UrT1yIpFQ/0jeaJHBFuq+NLetAHniLsG69qr
 MTwb/QBxx3Db7eyhTp0WwoNOU1Aga2wzA5tqFs8GBIicJ2QJKy+2IpE1x4Z36BtSlJDq
 0jb4oBYqjhcev8nKzZmsDdsRWWny0AHUlD0RkWWJ7+msKdutPPMqSrf1Xhv8d5Zf4p3K
 Vc4u2u07q62A/436685rwSQGL9okAn34lYf5/9O5mwd4JE9+tmuyTmrdtMvUW7BKRDuZ
 jvfJcfTdWMbcvHPhxEVSc+IgAaDJydr/NNmBL/ahBY1nHAg5upU57a1udFmAvqnMTM9y
 oY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729059199; x=1729663999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0xcSEsG4P1EbTSisKnf1P6Gzou9rCQHuXJkRJa2SjG4=;
 b=DCL7n6Zs1l2zs39Sc9idhqeBVYSqDVZO5zawoBfmte/JJa6wLawUTXB74NsBshjQuk
 88mfmxqpfqPTxqWXXaLaVBifw7ukSa/k6XiANjQJbWEbrkbjyYbqXGyC0jP9LAdReEh+
 r/NryGDoH/dDiG7Kk1pnzX7Y/fvUJULldxvlGGU6ycB+x5eZzJvlX8Hy+p6QJb2THieK
 Kys/NYFA4FplQweZiJPdHAntLin4Mvoi9UtLLHIKX6qADVDuCySsArz5LZjNBf8MBJFe
 lrtxkrk+Em7PTvlrr+0JAkrs048+KcbikDnVnMGpkNcg+Sdmtk2qgh+GXEquydrGTvrd
 XL0w==
X-Gm-Message-State: AOJu0YynZNtQjbNDqpUNUkDIzFtYBkcmmGC4Bx+YVMoJGeDyIhYqkusC
 HKCym8t+rRzwe0qPPZZJMGrjDNKa4KJvNXTqw3HKAq1FvFQGN73DbpOs4ddhkr7Bv5oK5HKUgaU
 k
X-Google-Smtp-Source: AGHT+IGhJstM1G3IolOuRFnAAEXy+t9dTjpjAT3eUWyAidF57E8OZpkcbd6jJMBGA2Hu9IpDUGurpg==
X-Received: by 2002:a17:907:f19a:b0:a99:f7df:b20a with SMTP id
 a640c23a62f3a-a9a34e88843mr195145066b.62.1729059198867; 
 Tue, 15 Oct 2024 23:13:18 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 23:13:18 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 24/37] common: Enable BLOBLIST_TABLES on arm
Date: Wed, 16 Oct 2024 08:04:10 +0200
Message-ID: <20241016060523.888804-25-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
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
Cc: Tom Rini <trini@konsulko.com>
---
Changelog v9:
- default to BLOBLIST_ALLOC on arm
- Move default for BLOBLIST_SIZE_RELOC up
---
 common/Kconfig |  2 ++
 lib/Kconfig    | 15 +++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 957de0c5c0..9ceca8a2f5 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1035,6 +1035,7 @@ if BLOBLIST
 
 choice
 	prompt "Bloblist location"
+	default BLOBLIST_ALLOC if ARM
 	help
 	  Select the location of the bloblist, via various means.
 
@@ -1075,6 +1076,7 @@ config BLOBLIST_SIZE
 
 config BLOBLIST_SIZE_RELOC
 	hex "Size of bloblist after relocation"
+	default 0x20000 if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
 	default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
 	default 0x0 if BLOBLIST_PASSAGE
 	help
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

