Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8FECCFA13
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC5A688DD1;
	Thu, 26 Sep 2024 10:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="EWCfXefS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D451088DB6; Thu, 26 Sep 2024 10:03:17 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 899D588DC4
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c40942358eso1263898a12.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337788; x=1727942588; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XoGNb8D2jp0vg8w7EjureeDuV1GbKu4z4O+1Dbpryzs=;
 b=EWCfXefS//L7CEn0VB/twdLUV4jclHtpV7ujbzh2BfV0cB5ssY93vbASxF+y8LjkqI
 nNGg6sRaxwtCjDmC0j0fGV/UPfehr57DPuxDYuRMxd7sS5GM+2cqGNdsm1JDTkWPxICF
 Jv3Dps3Ragd2O8rTXqC6TY5NkcqaKeCYP2gzzPiwHoW+xloSLSZdG9GRaPUu03o6QOya
 hp+oKgCe6JpkgynxiUCLe+aaEwNnhlj6SB0NCkpJxQ5JQSz7VggqLN2F+/gN8ScuQmwu
 gqiXkZPgMe2V+5XtYoQB4JZQ//3KA625R8CUrl4a5zDMC+ahBAA/NSN4N9dPDC5H3Qm1
 IXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337788; x=1727942588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XoGNb8D2jp0vg8w7EjureeDuV1GbKu4z4O+1Dbpryzs=;
 b=YqKYGr/0ZQnkCVsL7HemFqYKwCuSyfWD5aSFAtNjLGl6X6SGdoPGSjAEdG2XY08yqx
 AuGA+E+7/CM3+nqmkJW6KddJCW4AFTZstsupU+ei+Hw0O7YQhPKzjrNbNzJTGNhnj43a
 K86Ik+EU6JAgRV88G5ZEhZZEvAlPkA8q4XyUyYkCcD3nmgJrWGoVpHfdUGfimxQp/1bb
 kRDZ5DldWMNZQ4dWOSoRtuAyGq80KxlI+bT25uXFByS5T62uamfSFaO04Ln4gh1Xtiff
 UuOa9Bt2TkyM1OCjhjeIzBlAvzJY3eUPXhq6KMC/0aKyAClV0trCSDZi5Bcbl91dsCSx
 y62g==
X-Gm-Message-State: AOJu0YxzZdaw76w/n/C70QCYzj0QZrK0Mlt/HvYKtXQBF0fjV0Igf3ym
 SY0qUFXjo9BK6Jm7Kqxa1Vr0zNPN21Uw6W8bU867OfzXM4/ezV/dpNMZUgBrxlcgpAzMdQ3t/4X
 W
X-Google-Smtp-Source: AGHT+IHuSP0G6BD3F/+MIjvUx76NvIigv57icrWSPhPo3Se3+kCgP3xPSEmTpVdcvx/p27sGNlBVMA==
X-Received: by 2002:a05:6402:354e:b0:5c5:cda5:9328 with SMTP id
 4fb4d7f45d1cf-5c8777af7demr2284418a12.4.1727337787709; 
 Thu, 26 Sep 2024 01:03:07 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:03:07 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 24/36] common: Enable BLOBLIST_TABLES on arm
Date: Thu, 26 Sep 2024 09:59:12 +0200
Message-ID: <20240926080021.148031-25-patrick.rudolph@9elements.com>
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
2.46.0

