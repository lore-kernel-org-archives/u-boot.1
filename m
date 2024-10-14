Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97641D16261
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B63278917A;
	Mon, 14 Oct 2024 15:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="QzXYP4k7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E406189170; Mon, 14 Oct 2024 15:12:51 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D12A08915C
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-431195c3538so29010485e9.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911569; x=1729516369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHk1S7ioKa/xx6F4o5jh9aZ+NMbLzhqCIFe2FGWUJzY=;
 b=QzXYP4k7CmOhoquVNPskZ68i89g3cojn6IbVCOuPf93iwHknQzNfR3GQl6AeIEFH2g
 LfelctI9ub7U5uVueK2+f42C4eiDRVoaSptdr0pbZSf9SB8AHgMQ+t+pSaL6pdjY0ziW
 hWNhnIDQJHP4Xr48WTP+8s8eJBr6HNZN5edV7HSx1v3SLRjY9X6Ni4XaisgQN7Zx7Yl0
 osVhj1AGyroUCgMluB4lZdojYZYBMISKCrU4n3yA9g/uFanfAtVrOjZwX3rTIwhegEyW
 ME4tImw6iSo9zUTfEH1xHLZGId/KOdEJL51XUkjq8rh60/oliX7oMsCy70bN37Nk8BBb
 x4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911569; x=1729516369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHk1S7ioKa/xx6F4o5jh9aZ+NMbLzhqCIFe2FGWUJzY=;
 b=juHZB21xo47Dn+AcSX8+MfgucgGbPHfJ38G+NIgWcLfaSGNMUcJAu+nK+yHb/Po959
 XiJwXM7l9+upFmoWiM8erNNik/9kssQSGrYcjdpJvwGPqmQ8Ox3RCfVpPfb6BLN0KdzE
 H35cH0rpe5xo6AzWYXUOlHpoUU415ckVrr5cV52AwzV3oGpT4auBjntrzBHkbE1TT9PD
 9H9D126IcXhAqAwYr6C0xUpKprQ3Uq7gCKJf1agFzB34/fUjFWXfKcKQ5n1C9ms/weSI
 A++qek7Vh7R1n2g6/KZ3GTC9F/SDESzNFtphAFyKqn8I/GCiMuAS+gQm6oe70GQHjtA/
 opOg==
X-Gm-Message-State: AOJu0YyR6YrLS5zRP+yN74j5rrrk/LWbDlwizVcKWt4ZWyfLRYyYaV4L
 Y31/YbOfJFtD7ouWLsFjF0MvBYQ6O0qmZn0ood9OiVSMqKN2hWQuryztsW7W3xaHcRq2anghyhE
 p
X-Google-Smtp-Source: AGHT+IF/d+WE/MeRjaosnkmdNP8BiGsTmbrZNxyhg8fFyxEDtMhDCDiMMDuN7sgVFSQ5P5cyhDkF3g==
X-Received: by 2002:a05:600c:3b19:b0:430:54a4:5b03 with SMTP id
 5b1f17b1804b1-4311deba4bbmr95672635e9.6.1728911568647; 
 Mon, 14 Oct 2024 06:12:48 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:12:48 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 24/37] common: Enable BLOBLIST_TABLES on arm
Date: Mon, 14 Oct 2024 15:10:40 +0200
Message-ID: <20241014131152.267405-25-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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

