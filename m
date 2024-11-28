Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F002D69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8D1A89D71;
	Thu, 28 Nov 2024 16:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FtZMOVr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE25089D71; Thu, 28 Nov 2024 16:48:45 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BBC489D6B
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3e63e5c0c50so559519b6e.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808921; x=1733413721; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZYDkIVKzhWactk/ctPat93Nv3pcKjT/jUjDinUg5E0=;
 b=FtZMOVr7xQvNu1v9XDypiUziELD08gqxCyDVxU7ljqwtHlHcaAdlBas0pZ3C/STiPJ
 uWNh6WHT4tvF/gTwwcZx5+mAPuNrjmDWEsJ8NhB0QP/3mswyhPWQpGxJ5qaiz1DsZSHa
 lCOo+2TqK+cl8H9SGGI2WmWGrNSCunK45wp9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808921; x=1733413721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZYDkIVKzhWactk/ctPat93Nv3pcKjT/jUjDinUg5E0=;
 b=ZPFkW6pV5iR3xm3NDI8ZBxzwTXjtRXPqPTW5Vbrurbj7FugQDTH4xDn5V2iXhkxK+L
 B6KBzMUQHymIEG1ZFprmWJIswezySQ4GZEPp3VcJ23S+z9YEUntmU4qJSIaMZYfpqm6y
 kRIIVcQj5TtlXh142+SOTLObOfVoE4OVPXq1QC2DZywygBhlR1ZMOtvyTUpYx2/eyi+Q
 H2NITsMX9HMrhnXlP3GrqzfpinkJ3e45AV2ZiOGnRhObu8hz6LZLkVvXxAyskWf7xohk
 sWBi1ZQY416INvsboJvg+RRWzsF4SOVbysC8iMEJ71y25bVxXk2klm5D4HYP48Yd5WNc
 dVwg==
X-Gm-Message-State: AOJu0YzH2DHucVqi65hr9zKJX1kb8zWFwmZzoJigH+gED9GQPEL1XQ5c
 5F5HmJdDRfcOYIGdUbCopKUJ68NwbJquRhf3N8ndGrJNiR0h1sEJ3tjqZviWw71+V/B4hpzNOV0
 =
X-Gm-Gg: ASbGnctFlJ+viJ0Vw5dtsYwQAmn8nC6n+ARF7JmBiKdKxmE8ryejJUhTHRRXsLc/qmL
 rUm0IK3ZzFiyX8sUe6e0wp8/0fRH5gKK50pCyGwzHxnZHO/JCZRsaTRrg5GRvQrV5RXFRi4axs2
 fNYEeZ7qqMgmThtLF9GFhJqcKeM4+8dVaW8suCUcyqw45187Em8THnAX+YunZkWgn6rsU5iXYi8
 ibaYa/8KqDWSoU3AXV+9fftrVQedcceVMkX01mjv4NAUw==
X-Google-Smtp-Source: AGHT+IH/ZUNkCrBlXIpmo1yZn3gzZDrxAX9jFR6UK0AUxDE4qSPpK97+/YYAvIl/K9ldaeqT6gPdPw==
X-Received: by 2002:a05:6808:13d2:b0:3ea:51bf:fcc1 with SMTP id
 5614622812f47-3ea8142626bmr1970165b6e.6.1732808921605; 
 Thu, 28 Nov 2024 07:48:41 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:48:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Janne Grunau <j@jannau.net>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 20/28] lmb: Reduce mapmem contortions in
 lmb_map_update_notify()
Date: Thu, 28 Nov 2024 08:47:19 -0700
Message-Id: <20241128154727.771871-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128154727.771871-1-sjg@chromium.org>
References: <20241128154727.771871-1-sjg@chromium.org>
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

Now that efi_add_memory_map_pg() uses a address rather than a pointer
cast to an int, we can simplify the code here.

This is fix#1/4 for: Update efi_add_memory_map() to use address

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/lmb.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 14b9b8466ff..588787d2a90 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -10,7 +10,6 @@
 #include <efi_loader.h>
 #include <event.h>
 #include <image.h>
-#include <mapmem.h>
 #include <lmb.h>
 #include <log.h>
 #include <malloc.h>
@@ -448,7 +447,6 @@ static bool lmb_should_notify(enum lmb_flags flags)
 static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 				 enum lmb_flags flags)
 {
-	u64 efi_addr;
 	u64 pages;
 	efi_status_t status;
 
@@ -460,11 +458,10 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 	if (!lmb_should_notify(flags))
 		return 0;
 
-	efi_addr = (uintptr_t)map_sysmem(addr, 0);
-	pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
-	efi_addr &= ~EFI_PAGE_MASK;
+	pages = efi_size_in_pages(size + (addr & EFI_PAGE_MASK));
+	addr &= ~EFI_PAGE_MASK;
 
-	status = efi_add_memory_map_pg(efi_addr, pages,
+	status = efi_add_memory_map_pg(addr, pages,
 				       op == MAP_OP_RESERVE ?
 				       EFI_BOOT_SERVICES_DATA :
 				       EFI_CONVENTIONAL_MEMORY,
@@ -474,7 +471,6 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 			status & ~EFI_ERROR_MASK);
 		return -1;
 	}
-	unmap_sysmem((void *)(uintptr_t)efi_addr);
 
 	return 0;
 }
-- 
2.34.1

