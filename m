Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F011D729E7
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 17:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95E178941F;
	Fri, 29 Nov 2024 18:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B9P7IizE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F23268944D; Fri, 29 Nov 2024 18:08:21 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E71B89255
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 18:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cffb4ff85eso2402713a12.2
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 09:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732900099; x=1733504899; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EoEWpu3euo1CBqBzmLawQeF4t+oNfZYdRc1n3wJTAsM=;
 b=B9P7IizE+uGJvzaxVGm3xl+0lzCTSTegZZd4ZHIZeVxLX8tnGuTpXNZ/vO4YSj1zLp
 dJMnL7LOYekP0XPdNt/j/+Aoghwcx4oVmFZdRRYT9F+WkpJB6sHmV2NjyuSL7CTzehT4
 DzuQckaj2sBRC/wTKcjTWw21C2HTLrZwvu9xrCWmGh5/qN/Zq62azbA+wLJT7tkmDSpf
 0Lt/WFRzMdbRUmuDDYfdeT/49LmduQhFfFKG3r3kupUWIvnzDMqY+jgAFgIAW6FTR5pj
 0CONKdM40wHHG4O4iEsBVax1VY0DiZURe+MTUjVIDjqM0d216N/i20HxBOapVH+hF3qc
 m/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732900099; x=1733504899;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EoEWpu3euo1CBqBzmLawQeF4t+oNfZYdRc1n3wJTAsM=;
 b=scdoTNd5uTrZwO17dpQ4lfDCMPOlNi6Jz94v8Au5tujhHABjM+fIMgy0v13O6Zb6ga
 pTU2pDvXUUNvQ+5ipZtCK6Gk5w2TywIJRMpooEAHxVMuutep//088j0xx+GuVmn9ktus
 TDhDPiTUONiRiXn47kU3qQXpYk9RVlf658K/mbX/Zkxk+Vf28sBKVIDpuRcV9oY1Wzhc
 QT/RMnEzoAB99bpFgx/aYFrlFL5v5Lz8gPfmRq/pPNyawdWo5+YYOIVyG/edksfd1WFi
 Zu8w90wu5l34R6pLKO5shcHTbIlq2GWOXufhbu7ecEbVqS3RUp+sasPdsqInbIwBO2Pa
 hXEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC1Un9P+H/19Lvs4DC8qmLX5JoW9Jujz6QmbGsBFUMB4/Yh/CguYDbL6y4KefjjHVox4ew/48=@lists.denx.de
X-Gm-Message-State: AOJu0YxqsxRKN+ytHLmhSfXXbsEb5rVflX8j5ErSj7ypHpp/a2FnxyQa
 MyaFmlNE7bs+EPRC4nZkktnQCqIWBukGngq8AC/R9HeCOEQFB9O9Puajyyd4kKk=
X-Gm-Gg: ASbGncu7//Jv8S3iRg1lnHBSZOffRXiEf4Sy+Ve3BfCWrJ3CqsRHnPb2ZY9DwmIHEtB
 I5g5uCdfpJtPYaOHGjFvqCtJKhduK5Y2ev8s7w55+SZ4ptCiF9y8ydBxylpwGKlIPzGQ7Ru4cjf
 c2g2Xhq2j6yjekVaNzKE6uO2XNuNMUFxLgCllKDkdLVNszZs0w+UYxSJ06PEP/DE2zLuSwXpC1M
 Lt3wXY6PngCp1OM9R2aKfs5r7HB5nZSfrgLbmmdphsLDpFDgaauCLoi/ygSyB2gpas162T8Sh+T
 iAw3R05qfvZKadP5ffy+qlBtng==
X-Google-Smtp-Source: AGHT+IGO6brSyY0M8g2s+RzM67T9DCmVjyJxC2p0H/JsW7l7UylZA8JBbjveifMilAG+vrpvD7JvsQ==
X-Received: by 2002:a17:907:6d12:b0:a9a:129a:1862 with SMTP id
 a640c23a62f3a-aa581093449mr1232955566b.60.1732900098602; 
 Fri, 29 Nov 2024 09:08:18 -0800 (PST)
Received: from localhost.localdomain (ppp089210064034.access.hol.gr.
 [89.210.64.34]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5996c13fdsm194733366b.26.2024.11.29.09.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 09:08:17 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH v2] efi_loader: Add U-Boot memory to the EFI memory map
Date: Fri, 29 Nov 2024 19:08:13 +0200
Message-ID: <20241129170814.768438-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

This reverts commit ("commit a68c9ac5d8af ("efi_memory: do not add U-Boot memory to the memory map")
This code was removed when the EFI subsystem started using LMB calls for
the reservations. In hindsight it unearthed two problems.

The e820 code is adding u-boot memory as EfiReservedMemory while it
should look at what LMB added and decide instead of blindly overwriting
it. The reason this worked is that we marked that code properly late,
when the EFI came up. But now with the LMB changes, the EFI map gets
added first and the e820 code overwrites it.

The second problem is that we never mark SetVirtualAddressMap as runtime
code, which we should according to the spec. Until we fix this the
current hack can't go away, at least for architectures that *need* to
call SVAM.

More specifically x86 currently requires SVAM and sets the NX bit for
pages not marked as *_CODE. So unless we do that late, it will crash
trying to execute from non-executable memory. It's also worth noting
that x86 calls SVAM late in the boot, so this will work until someone
decides to overwrite/use BootServicesData from the OS.

Notably arm64 disables it explicitly if the VA space is > 48bits, so
doesn't suffer from any of these problems.

This doesn't really deserve a fixes tag, since it brings back a hack to
remedy a situation that was wrong long before that commit, but in case
anyone hits the same bug ...
Simon sent the original revert in the link, but we need a proper
justification for it.

Link: https://lore.kernel.org/u-boot/20241112131830.576864-1-sjg@chromium.org/
Fixes: commit a68c9ac5d8af ("efi_memory: do not add U-Boot memory to the memory map")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Apologies for sending v2 so fast but we need this in for the release
Changes since v1:
- reword the commit message and fix spelling

 lib/efi_loader/efi_memory.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index e493934c7131..edd7da7d8c6e 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -814,7 +814,16 @@ static void add_u_boot_and_runtime(void)
 {
 	unsigned long runtime_start, runtime_end, runtime_pages;
 	unsigned long runtime_mask = EFI_PAGE_MASK;
-
+	unsigned long uboot_start, uboot_pages;
+	unsigned long uboot_stack_size = CONFIG_STACK_SIZE;
+
+	/* Add U-Boot */
+	uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
+		       uboot_stack_size) & ~EFI_PAGE_MASK;
+	uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
+		       uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
+	efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
+			      false);
 #if defined(__aarch64__)
 	/*
 	 * Runtime Services must be 64KiB aligned according to the
--
2.45.2

