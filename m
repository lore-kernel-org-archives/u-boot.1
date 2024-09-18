Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D05FCDD540
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB6D88F65;
	Wed, 18 Sep 2024 17:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="gyE9tBvV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B66F088DBB; Wed, 18 Sep 2024 17:22:47 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56EB788F65
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d446adf6eso839629666b.2
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672965; x=1727277765; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wKzDi9As5SUTRNf+iP2eQJ0dVtOM33ZHfoAYE4hPG48=;
 b=gyE9tBvV/P8l+us1GJHs4me4VoaQ7XBqUDhhFYpZR/LE3wDZqCnndclMQxDF1/4x3b
 qugDYvd4Ja591Xj1hoIiaWE3TQ7j26gt76/GDKSBl5c8tyM6qIJIlAjQt/CU3LQbd+Br
 qE+Sx0jkUFLa5FVUwtifHqBOgtGAuQmesWyO5g02YocL0DDdrUsCkXYF9a6sPJOFgePX
 lKwIlvSERUuS+l1NGbo7V2VgfD4u03/KTYicDPfM+LH/JJpjyslAn+M+Pi3IOVcR33Dq
 8F1TrshVxRfbLHgnFLxYJ89M6tKuEiJFGHiMBta9rXFS65PZkguNK4UJz81ndyBT5NDs
 W2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672965; x=1727277765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wKzDi9As5SUTRNf+iP2eQJ0dVtOM33ZHfoAYE4hPG48=;
 b=taYJX9D5pQIGgbFnvgBDR7D2n7rC+REHpQiQPTU236FaX2Bce3fX30ywIEKpNSN2jD
 9Q+URRneld86Y0c5APMTlr3bs5bBprFSqn4tbEuqvPVlXfvlIA0Egqd2qUFsGG2VMW6N
 Kf1mVAwSO57/QGGZYQBbTFsV9E2JpuQ7cuElS22c1M0v6yn8Ms7TDIr4OIAvZS6Kg33B
 boyAg/ZAhEaSNw60WMgZU7sQASu+VIFUQegKrTxPDb4NjxW3xeAzqnfMBKdxuIgcTFkC
 oRJVLzCDUUkKil/uik7I8XLLW/oQCVkbVu8zpw6mYqHFKKzpnTdKQj23+QGzti7TV3M+
 l3xQ==
X-Gm-Message-State: AOJu0YysWRlqagM6jcYhhsF5dWsDVH2rmH+qWfz18k4FKZugO43FOuXQ
 jzBmiExfnfulw2gU+EUDGj47O8i9BoaLFYFakcZN+97v3C4JeTrUslvW/9vAgNtaEfDpMvdCmp6
 R
X-Google-Smtp-Source: AGHT+IEJwbSpH6xC598WivXDw6t9Z/FFISmG1rm+OMvFZi/JFAgAxSCVLybIpE0/09+AVkQ/ueow0A==
X-Received: by 2002:a17:907:e647:b0:a8b:5dcf:493e with SMTP id
 a640c23a62f3a-a90480cd286mr1852782266b.58.1726672964818; 
 Wed, 18 Sep 2024 08:22:44 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:22:44 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 24/35] common: Enable BLOBLIST_TABLES on arm
Date: Wed, 18 Sep 2024 17:20:28 +0200
Message-ID: <20240918152136.3395170-25-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
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
2.46.0

