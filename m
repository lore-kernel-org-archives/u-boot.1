Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02847CF31A9
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CA758921B;
	Wed,  2 Oct 2024 11:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="D62YGO49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D517989216; Wed,  2 Oct 2024 11:52:32 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD3E58905F
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37cdbdbbb1cso2442586f8f.3
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862750; x=1728467550; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGzVt9uDHCNj4raUIpx4cJGNorylfoQJHMWgGOzAC6g=;
 b=D62YGO49XbkHE10IbOj1CK+H70fBH927640hY9HUxBFq3THHGr+nkVdvGNp2cu/LV0
 oMGtEqRHDxVMzP/6VQRIqauhHpVhYNBCng9aX6pCpj6o6gnnUT5jfDZ0ghlkySljG5Ar
 rb90oHZIPNova1lrIi/wlzeoNQVmdepAoc6urdpx/E9X+cj2rlKb81GO5YG5J5Nkngmt
 DuoGnScsEdBQ32sRkpnrpZ1Mxjvntu5K2o7BrVvQ6iHn/2sCzR1GAppXmMROdwYw56eM
 vFkWydW4z4QBOuCNlMpfn3CXr2Oxh80w3h1knJqFvZjf4Y4YdL3T78NDX60acBwsM/lF
 KykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862750; x=1728467550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rGzVt9uDHCNj4raUIpx4cJGNorylfoQJHMWgGOzAC6g=;
 b=eT+RPx59lpTFv1Ag7RY7auBDJSOSeGK5ylyQq8wD1LPDR7En54dPBwij/WDO6jVlgW
 vo4vzB9CdVH3Syvq0u0EWxWGeF8d4pv0CSoGSuiXT475m4Ym9lAyTRK18cIk6REgB/GZ
 9PldXBMu4jfkg3JcKK1DNXdYUAS+kGBZQ+HMT0jp6STYzN+YuVNvf5UzIoo7f2pllTYW
 UUnFsMRSKD8ZNkuqzZXd+tgREw3jtYYoogRp6+r0SKdYQKx9qr4jh7YfbZrWII+Nc3Th
 vGCcNL/ivTQLJ1YLXzl5tDgFZOoWUitJo9AgNgyLyUBCL/JWGMYY4z9bk2c1JV3fOGei
 jWSg==
X-Gm-Message-State: AOJu0YyDfNd9cyJvRJJVQg07c1eYBMZcawDTRXgPCErkTib+tgPsJUL8
 Jy7Qmyf5cMqbcdXFLB8OVVTzeArIN9KS0HxygSi9MRszozNgh9xd9wyLTmT2brBzTI885qusOWc
 q
X-Google-Smtp-Source: AGHT+IHSw/6Pq75nH1P7Bm7rhK35eZRs91mzVmO5xB76+Gr6jkwKWjgveLC7LaZ1ZUM6rmWrzvtKxw==
X-Received: by 2002:a5d:4fca:0:b0:37c:cbd0:8d94 with SMTP id
 ffacd0b85a97d-37cfba20777mr1320272f8f.57.1727862750360; 
 Wed, 02 Oct 2024 02:52:30 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:52:29 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 24/37] common: Enable BLOBLIST_TABLES on arm
Date: Wed,  2 Oct 2024 11:47:15 +0200
Message-ID: <20241002094832.24933-25-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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
 common/Kconfig |  1 +
 lib/Kconfig    | 15 +++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index e1b8557e0c..09ead61817 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1076,6 +1076,7 @@ config BLOBLIST_SIZE_RELOC
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
2.46.2

