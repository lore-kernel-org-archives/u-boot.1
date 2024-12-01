Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBA0D49776
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED3E8947A;
	Sun,  1 Dec 2024 16:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KThUb/ir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8762789451; Sun,  1 Dec 2024 16:25:25 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 751B8893C2
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-8418ecda128so123063339f.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066716; x=1733671516; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/bRHVKrPOkEX2Rw9G+S474MWrSTyLblFxrC/konpWvc=;
 b=KThUb/irWkyb4AVWU0OUwIDY0CXoK8jxxVKoLU2J107kSEAMblKeFIbLkItfG3PvpY
 4SDCfqHrmAkWbVIPciBJoXOVR9SBu/R+w//jhdAIYFTDouzyVxnMX1kYJF0MCVLy5UrP
 /pr9cuverDXvUm7uD1x0ATbAf2UCVcPv4VY78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066716; x=1733671516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/bRHVKrPOkEX2Rw9G+S474MWrSTyLblFxrC/konpWvc=;
 b=kKPBFYlXDjAdAoG7WUfDFtpQ3ru7VzZaVAJGRnkjPKqi2O8y2o2/MM8nj1sHBT6qRy
 ui0Nb9aCqLq8vmhWNlf6NqdCXvtNv3UBktJpPM0rt290duHxpmUmbQRZJdT92YZF54OW
 dIxOTbIYvx7dddBPiYntM/c/OdTiSLGxqNMkuHstRq1N7uCF/FCo2/+ym70aNLOpFynU
 76rYCSC+76dkSztfSbYGiEJm+Lg7mZbHe5t2maCJNBMJFhWctNlAkJFUe64z2LSonhtI
 S5YZhd8uC+65sqAJXPn9WeYLi+9nbzp++x8H6WA87uTS0QToYtNrWek2CM4kszsNH3tQ
 qVwA==
X-Gm-Message-State: AOJu0Yy4Dw13Rp30QLhQg8YlbFurKYQElu4JaFxpBEyWV83NTqRpIWsg
 YzJKNM8+gzInoDyEuGslVLejcg3ftgu5ONkFCcixzIa7JhEI8jefKp9w+/pcW4nn1FlVc5wPF9k
 =
X-Gm-Gg: ASbGncs+68qfRw5qpWqknKhF3Qex+DI5Gc7xFafw+cbMUtR6B1nvaCbSy2tMJwVKwrJ
 kTE38EPNe2kwx54kBdH7o4NjjmtszXmO/EMnIazdHO/7HwycaRaPW4uKHhaiAqDyd6dp0IejcFW
 3OEj8ZIGVLt6CVqGYBzmoZxIv1bMwfRq9+yU1wxYT3KDSvmi1vkmJ2/tCt4Dp4txM7AJzlP6DAA
 hGcFHNZ01+mNivGDWf53cY1Rb6JBtbZulIMtxWw2x6q
X-Google-Smtp-Source: AGHT+IHLtIU/awzaUx/eQ1YmWRDrsgQ2VF2hbzgnSqGCxDyFKYPF7GoY0qnOMYGWNapE7oInauZdBQ==
X-Received: by 2002:a05:6602:6412:b0:837:7e21:1688 with SMTP id
 ca18e2360f4ac-843ed09db55mr1899466639f.11.1733066716187; 
 Sun, 01 Dec 2024 07:25:16 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:25:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 01/25] efi: Define fields in struct efi_mem_desc
Date: Sun,  1 Dec 2024 08:24:20 -0700
Message-ID: <20241201152505.1666789-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152505.1666789-1-sjg@chromium.org>
References: <20241201152505.1666789-1-sjg@chromium.org>
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

There is quite a bit of confusion in the EFI code as to whether a field
contains an address or a pointer. As a first step towards resolving
this, document the memory-descriptor struct, indicating that it holds
pointers, not addresses.

Dro the same for efi_add_memory_map() as it is widely used, as well as
efi_add_memory_map_pg() which is only used by lmb

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Adjust comments

Changes in v2:
- Fix missing @
- Note that this holds pointers, not addresses

 include/efi.h               | 21 +++++++++++++++++++++
 include/efi_loader.h        |  6 ++++--
 lib/efi_loader/efi_memory.c |  4 +++-
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/efi.h b/include/efi.h
index c559fda3004..348ff9efd16 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -273,6 +273,27 @@ enum efi_memory_type {
 #define EFI_PAGE_SIZE		(1ULL << EFI_PAGE_SHIFT)
 #define EFI_PAGE_MASK		(EFI_PAGE_SIZE - 1)
 
+/**
+ * struct efi_mem_desc - defines an EFI memory record
+ *
+ * This field implements the EFI_MEMORY_DESCRIPTOR type of the UEFI
+ * specification.
+ *
+ * Note that this struct is for use outside U-Boot, so the two 'start' fields
+ * are pointers, not addresses. Use map_to_sysmem() to convert to an address, so
+ * that sandbox operates correctly.
+ *
+ * @type (enum efi_memory_type): EFI memory-type
+ * @reserved: unused
+ * @physical_start: Start address of region in physical memory
+ * @virtual_start: Start address of region in virtual memory, which will be the
+ *	same as @physical_start before where both addresses will always be the
+ *	same before SetVirtualMemoryMap() is called as the UEFI specification
+ *	requires identity mapping.
+ * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
+ *	bytes)
+ * @attribute: Memory attributes (see EFI_MEMORY_...)
+ */
 struct efi_mem_desc {
 	u32 type;
 	u32 reserved;
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 39809eac1bc..ee0cdd36500 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -788,8 +788,10 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
 /**
  * efi_add_memory_map_pg() - add pages to the memory map
  *
- * @start:			start address, must be a multiple of
- *				EFI_PAGE_SIZE
+ * @start: start address, must be a multiple of EFI_PAGE_SIZE. Note that this
+ * is actually a pointer provided as an integer. To pass in an address, pass
+ * in (ulong)map_to_sysmem(addr)
+ *
  * @pages:			number of pages to add
  * @memory_type:		type of memory added
  * @overlap_conventional:	region may only overlap free(conventional)
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index e493934c713..f1154f73e05 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -384,7 +384,9 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 /**
  * efi_add_memory_map() - add memory area to the memory map
  *
- * @start:		start address of the memory area
+ * @start:		start address of the memory area. Note that this is
+ *			actually a pointer provided as an integer. To pass in
+ *			an address, pass in (ulong)map_to_sysmem(addr)
  * @size:		length in bytes of the memory area
  * @memory_type:	type of memory added
  *
-- 
2.43.0

