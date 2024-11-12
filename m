Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55010D3ABFB
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:18:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A30EE88FBA;
	Tue, 12 Nov 2024 14:18:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BEXEZ9GF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D735888FBA; Tue, 12 Nov 2024 14:18:44 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD864891E4
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:18:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a4ccfde548so16014185ab.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731417521; x=1732022321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7yvsfWujFoBuhlh3UQ3aJFbTH4WeHRJ1Z6M0rQGBaPM=;
 b=BEXEZ9GFBj7UAgdrIFyCUf6dQ+T77epHAEizy7e6X8TdtTsRGpk4ybOH9e1/woVKzR
 53oQORR+fGSDf9bBtnsSvuSkmqZFRUyGjr2Iqh862CK2x96XDi6ppjTPbnM+7mhXp3tL
 QtMwiEc1ab+7SrvLb6GG6yUFM18LTmGnyr0Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731417521; x=1732022321;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7yvsfWujFoBuhlh3UQ3aJFbTH4WeHRJ1Z6M0rQGBaPM=;
 b=JyHxcWHlLDDr0XjeK8KKFh+gD5f4omzR4GP1mi8leuq51dbe6tjoESkjYnzNZuDYt2
 lKn8x7A4chR8JgbFnMgcqS/Br3ZnROtZR0bjCzbDAz0k+XMjjzz2C+j5cfvY1jkz3XBG
 ujj9NmipZ26UAMTOHS6KZjorXsoahIpxld10l8XPL0i5iB3/fXnysfgsXXZvgUYKe5xh
 5b+Uh1f+BejlIMn4fzFiSREDi+e0MxomjB8GfUw00Fz+VKCEL7veKMUeVoMlBuZv0bL3
 SvtykNijvrcMAs9LTVjZd64CePgJBoG68MqfC2b8pAX0DRcVjr8Yo5W5Hz5pCdhp3+mj
 VOBA==
X-Gm-Message-State: AOJu0Yx2G23DAuPimnyFsvnYWgrzeyViDQQa8vp6lzcRDNd777pF98QH
 hTF+vFV6mmjIP7KaG3H0vDmj9uC9C5+i6g/7jPDkHRRap3a7Sdu9mtzonMQCnEMfcA9gVPLF2xU
 =
X-Google-Smtp-Source: AGHT+IHJsAP28I5KJqYkDs6FF+hCU5tyP2vagEFIsHTWKPfnhjKZfH4t7JQ+zgF9RfIlxyck+jcbDA==
X-Received: by 2002:a92:c803:0:b0:3a0:c8b8:1b0f with SMTP id
 e9e14a558f8ab-3a6f114bdbemr142428985ab.2.1731417520653; 
 Tue, 12 Nov 2024 05:18:40 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de787d6cddsm2000923173.102.2024.11.12.05.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:18:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] Revert "efi_memory: do not add U-Boot memory to the memory
 map"
Date: Tue, 12 Nov 2024 06:18:30 -0700
Message-Id: <20241112131830.576864-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

A bisect of Ubuntu 2022.04 boot-failure on qemu-x86_64 resulted in this
patch. I am not sure how to investigate it.

The boot hangs at some point during booting of the install image, before
the Ubuntu logo appears.

I will sent a series with a script showing how it is run.

This reverts commit a68c9ac5d8afc51c619c5d3e865fcf147bea90cb.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_memory.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index d2f5d563f2a..c7400ec9854 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -809,6 +809,16 @@ static void add_u_boot_and_runtime(void)
 {
 	unsigned long runtime_start, runtime_end, runtime_pages;
 	unsigned long runtime_mask = EFI_PAGE_MASK;
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
-- 
2.34.1

