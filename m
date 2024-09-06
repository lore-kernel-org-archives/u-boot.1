Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1D7CE7AE0
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB18488D97;
	Fri,  6 Sep 2024 09:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="K/Y7IXbx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A974988D40; Fri,  6 Sep 2024 09:22:57 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C83488D28
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8a789c4fc5so214955166b.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725607373; x=1726212173; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hR4rH+sPCMYlUB2bKsT0Bymd1wMnYrFKb/TnzVFvQLU=;
 b=K/Y7IXbxrdKLzr9MKrLSIhyyQF6ek9UaC72+VS/pYHfLjllTnvzoLmf3d2G7iJSbl1
 XzRwh4J9ZIZhdUhHcFllXnc3j7iKx4aSpFkpPH8+arGCkN+BbjanZzSYsmNiJdXBHGJS
 ExSe1lR5MZeEAe4tsJj2gYY3XFCkp9FLp22nSqfu1kMqI65caQy5q9qLnZOKYGJBWMWD
 CYkD7Lrxh8DYhNSKtvhycM4rIv83sRSuV1MwYfYsxNXHjMEnzRfJBGMn5GS/mpox9llV
 MCnJCpDQ8Ls0UUEDo1YGv1tlPscexwMtsRHnqCs/W+5QF6qL1H9rV+FYsVAmNRrtZvjY
 d8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607373; x=1726212173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hR4rH+sPCMYlUB2bKsT0Bymd1wMnYrFKb/TnzVFvQLU=;
 b=ecvguPQ6UWEXhc6WQTAHPNyVvJms5dz9k5GH2QK1ZKJdqJlGkHP4u3O49nD2KX7zMk
 B6v0kvlDPun1YMCWFN/nC+YsutsumgonXvHozkDFUqzCpetutWmnW8lKP5AlDklqzBpJ
 RnuCFyK6PnEPzLFD9tbGJrrQiQ+6ds678Big2e0yr/CLPFr/jEzzQOVDoTChiU0IIQuN
 tvhbkXm8lhTpnVFnrCxtKrJGtUH9Q+mvAyRaA7f3rgRwZD/oqR9EIDcmpvGkI60PIyBt
 UsxWbKdcvzlOFxbP3pFEJTIrNZ5G+hNM7MArVXy2dSrc7YE2O18JxDAoPOi9/lGrlvdO
 h7cA==
X-Gm-Message-State: AOJu0YyxpHBiSXjAiKgFAaNYznfSIU0UwE5QlndE/cM5Xl3lH8EeYlUn
 rYELOQc59F2a36SOxkC82zdD2lWFchjXNa5FtNxfH8rg5+tlSwDhfNLlY+yuCjKOy8gjqzZPZxN
 H
X-Google-Smtp-Source: AGHT+IEna41/ESWhm4vENOsJ4EYxs7evTH5KGbqfU8i3HUdYZ24t3VRPFzwH6TqsYuHwEh7WonOwgg==
X-Received: by 2002:a17:907:9488:b0:a8a:9301:8237 with SMTP id
 a640c23a62f3a-a8a930184d9mr55318666b.10.1725607372758; 
 Fri, 06 Sep 2024 00:22:52 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7f7f541csm107748466b.193.2024.09.06.00.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:22:52 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 19/28] common: Enable BLOBLIST_TABLES on arm
Date: Fri,  6 Sep 2024 09:22:21 +0200
Message-ID: <20240906072231.2531491-20-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
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
2.45.2

