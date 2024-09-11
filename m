Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D089EEE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 955A3891B7;
	Wed, 11 Sep 2024 08:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="bNFw6JMw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 359E5891B7; Wed, 11 Sep 2024 08:26:03 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A4028918D
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c3c30e663fso1924549a12.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035957; x=1726640757; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BxCFxz2bLoFRC2x/WPEy3sUdM3u3vLiqPM2r7g97edM=;
 b=bNFw6JMwgsNDdlDaFq5S2UdODVmWkbDUMeNMLSPNMImHlOD52VtwQliVqNSr6mZ8tj
 KBK+7VM+Ocu693AcDAI8eG3VelNPdTgmyguEnXWiT9l9DMBk1eThSvatzA76cJMVzqAo
 EYowIqSiuSuprNbyk+1Ka2moQYnIdBazuO3An3GKTns4l/8/u7tHqjK/jINOB+Bdk/D+
 N62kMA8PXPzfP4qzyW57RC7MXZ5zVI4RdzMZ/lkhfAcqsxS9QP7z7PpyukoYxRlRp7e0
 9/hEtyULmC9okqb8NCQNC7g7ayAsrxKJVo6hP7+sQqYSpk8as52+tLHh0qe8kTOF0f5Z
 mlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035957; x=1726640757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BxCFxz2bLoFRC2x/WPEy3sUdM3u3vLiqPM2r7g97edM=;
 b=OitaUkXxx3D/G8ILkvZEMl5gzfToxy7DMJDgWm1DDLbmsQMy19a2kVOKsg4Zqi+TsG
 jxEnt9DdJo4fje2b7wR6s0Ff4/gk+oH60IOjrzG7+DZ+xqJUW7+1M5waonV+KQsYITn8
 VzAoXXWPgPGIOsobM1brTspVw1oE1OmLJIdOPRt6Q96BX0zdVlpeOWB8X4AzqKXpLJ2Q
 qN8oNosy71hUuWWJA2+LyJNrJFN5wf9sRUSXCSWgycEgUor3X+gDyXl8PQMLU38oz9K8
 qNOTIgkDtW5zqDv0ippIyPNh+Nm1D3nD9wUAUfEiJT2MhRBIxItRKoEEEHCex56wcraX
 vbJQ==
X-Gm-Message-State: AOJu0YyIw2mE7C301K2iXaWEab+e0duudNq3xLLlqKekbZx6i8FVxsvs
 EbMDieRoE1irv3e0136ZEu0pQahsl9EntvSWTO6Ko2YN1hRdqP81lS0mUrAxhvlzvKoIqbduiv8
 l
X-Google-Smtp-Source: AGHT+IHnbhD/epd2XJEWZ+EEx+VenyGemZ45EKiZLjhS6pJY20qH6Hh1VfnRnfCiyKiurj+UK5qLhA==
X-Received: by 2002:a17:907:e2d4:b0:a7a:bcbc:f7e1 with SMTP id
 a640c23a62f3a-a900482ff26mr201137866b.15.1726035956825; 
 Tue, 10 Sep 2024 23:25:56 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:25:56 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 21/30] common: Enable BLOBLIST_TABLES on arm
Date: Wed, 11 Sep 2024 08:24:11 +0200
Message-ID: <20240911062511.494855-22-patrick.rudolph@9elements.com>
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

Allow to use BLOBLIST_TABLES on arm to store ACPI or other tables.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Tom Rini <trini@konsulko.com>
---
 common/Kconfig |  1 +
 lib/Kconfig    | 15 +++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 83c81edac2..a864e24508 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1075,6 +1075,7 @@ config BLOBLIST_SIZE_RELOC
 	hex "Size of bloblist after relocation"
 	default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
 	default 0x0 if BLOBLIST_PASSAGE
+	default 0x20000 if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
 	help
 	  Sets the size of the bloblist in bytes after relocation. Since U-Boot
 	  has a lot more memory available then, it is possible to use a larger
diff --git a/lib/Kconfig b/lib/Kconfig
index 2059219a12..ea444354eb 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -983,12 +983,15 @@ menu "System tables"
 
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
2.46.0

