Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6130CFD31D
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F0C58935E;
	Fri, 11 Oct 2024 12:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="AIGQGWyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66E6D892FB; Fri, 11 Oct 2024 12:35:13 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74F0389355
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9960371b62so212430866b.3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642911; x=1729247711; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHk1S7ioKa/xx6F4o5jh9aZ+NMbLzhqCIFe2FGWUJzY=;
 b=AIGQGWyWVvaqp1o32RZg11gkZJmf+mvXVrCbmkUjHFlNdffoUJPAOLKTbsS02JQgPm
 o0RBg71yuqTEpHc3q7VLAXyBlIxuK/vx1eXgJvVOO6N7ioCZxcmhXvXI3FCPT+uf+qos
 hAvmpWkEPVuOa0ZihhoMbmszXGnCtkyYPiiX2cVb268lb4RbWDoQZF0bNFznn7uoBpMD
 noCqJmr7Cv83VcpLDW/82kdyMo14UKYfGNwL0xn7xlSKnYCVfd+8bx6WRyBbp2pjPelw
 2YaM3LAg3QdTHRR7WfCQqvJGSd/OyB5yZ9OWi3PnOX+E7hcTmBk8GrciyA7IOWncBGjn
 lZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642911; x=1729247711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHk1S7ioKa/xx6F4o5jh9aZ+NMbLzhqCIFe2FGWUJzY=;
 b=NlU/aIfXhGDzUyXoXjvnhZiC4kYteml3wgCzFKiySCI0OIAjyDBC277eA0R1CaKSqe
 y//V9H0g+A8gWwE7rB1S9e7BYi+f1X8/9HDjslmN3Vgte22+6gc9gcLaTNkzGEJZWaap
 +NFnKCy0eYSs1IPj7J4DZgQ4B2gfSEFx2nl3dFa4MiLNaMnPSp8ki+tVTYBOyLEe2fNK
 Tx95scr6g+SKv3C+fF6DCkPSeMcCkm9c4LQyhx0gK/oPtaBIXfoSbFmxDT+xZpZWDGH0
 rYGcaaQPAlupQ/Z2HQmi+zXqHSGRGlsw6QGFWWOVZJZ17Kfz2e0z+ouX9AKCGzGXBrd5
 gzHA==
X-Gm-Message-State: AOJu0YwjsKagIZwUIpRXQXh6ruhV6XsRmUl376P5vMJrH4xKYiSwiAC0
 Ebj9xhnaV0/h9NHAmQuumb/7Uydf+fI0/sb+d4qT7OLnzefGxwBUJzjzN14tEnNnGcr2m1Omj24
 ng4M=
X-Google-Smtp-Source: AGHT+IHuZs5UeXyca+Hfa861pkuMuGUOnx1ioWgclW5/P1mOXjWGJlYEoMCF/pFiUjJCtvwvz+QO6A==
X-Received: by 2002:a17:907:f14c:b0:a99:7e95:49ac with SMTP id
 a640c23a62f3a-a99b941b43emr200086666b.1.1728642910779; 
 Fri, 11 Oct 2024 03:35:10 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:35:10 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 24/37] common: Enable BLOBLIST_TABLES on arm
Date: Fri, 11 Oct 2024 12:23:05 +0200
Message-ID: <20241011102419.12523-25-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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

