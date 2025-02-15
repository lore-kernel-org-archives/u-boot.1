Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13542C02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 687E480F64;
	Sat, 15 Feb 2025 04:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B1h/WhFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D25B80EEB; Sat, 15 Feb 2025 04:23:53 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0954380B98
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-8556e24b5a1so158462939f.3
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589829; x=1740194629; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22DTu4dGLVb3YFvFaQrr6xvHm/rcyuyLS42GLIaK0NU=;
 b=B1h/WhFMC8fzNLbn9fFgfd9fHtHWRho91/H5Cv2CTCpadKT1rg1lH5JDL2DV6sVXG/
 0qduudhJ6uMa79lVs3pzvDvHZWV5MWaMA7CwvOm9tw4dmvSAmD9bmRvEMEK29SCIgAli
 EhpRGsPDqG5fk8ahCz3IwzsxVbgCaIIie7HaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589829; x=1740194629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=22DTu4dGLVb3YFvFaQrr6xvHm/rcyuyLS42GLIaK0NU=;
 b=MQgdXa1hu3T2n/IPrWppg52Kg8t3dqgF16qdNmwE9fWGjGvsLoTQGsC3SgLwaS23er
 qL/r3lrbL0khAP2LqgFxlwCYgiiZzuYkXaQy5k5v/U3eMtqZYfzPKM18ljUS3hDpOk6b
 37tYBRNdD4wxMAnANXss2TSyE2Y+OjWEqztWVrfG7qELZggWiREOX6YM9Gt3DuK5BrFT
 hYW7EjpcX+5HJqUUzeqERwdEZhHGtbnjyGkGnsePTqPufUmizXU6W3RTwpkEzTeSHfjT
 a1nUhteGoBi6yCD7bplBbhD0Ws5R32FqEVxASom7Yiun4Tv8qp8C5QvIL8WWN5T3BkV5
 GDrg==
X-Gm-Message-State: AOJu0YzuY9ID9VJkp5fYHS8U/s8CiR4FdI4nWfgQEmLAksc9ipR6v0Ku
 uy41urkadLKksGxRSVvvgsT2fodlE7g/YOswG4uu8ejiaHyFtpdbbYxasOww3RdszP8AbyLiJWg
 =
X-Gm-Gg: ASbGnctEyT1WqtgIjv+YbLtobI5VJIDqo3TR+K0aOZzoPdazu+6rT9EJvbRyeyGnNdT
 8POIgv4J4LDpPyPqfmfggiElBpHyx+fqa0MvTKsZuw33zRJ+fkH992UaeNmxlSvSdezreeUPi5+
 0zJyEF0RMhEkErQFrqtw/b2vvFESUSUnHeqKRxj2NWjC9wu09rvZ/5qGhtQezOAU8oadcrfv96L
 PMepkcFHK497JiJob1THuclMcVuliwNp6qeesMUhPXMWOjMeXTpr+TZvlfbpZ+fBI2YM6BTPgPn
 PMrKOF8UDEWDaTFsKAkG6ZWLftjEh8ROYR9ws0X/ft8CL2Y/vgsO
X-Google-Smtp-Source: AGHT+IFOv5bOaCnmHKkuJAKz9TGcXTvCUtT+WyMitiOvPuqNyPb+ktuUZVuoEn6FIMSNJ2m53EFr5g==
X-Received: by 2002:a05:6602:6d0b:b0:855:7707:807f with SMTP id
 ca18e2360f4ac-8557a134f89mr166956039f.10.1739589829300; 
 Fri, 14 Feb 2025 19:23:49 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 15/29] efi: arm: Avoid allocating page tables when running
 under EFI
Date: Fri, 14 Feb 2025 20:22:36 -0700
Message-ID: <20250215032254.4121030-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

The previous bootloader has already set up the page tables, so don't try
to do it again.

This fixes a crash in QEMU when booting from EDK2

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/lib/cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
index 516754caeaf..bdd0f202bf9 100644
--- a/arch/arm/lib/cache.c
+++ b/arch/arm/lib/cache.c
@@ -6,6 +6,7 @@
 
 #include <config.h>
 #include <cpu_func.h>
+#include <init.h>
 #include <log.h>
 #include <malloc.h>
 #include <asm/cache.h>
@@ -138,6 +139,8 @@ int arch_reserve_mmu(void)
 
 __weak int arm_reserve_mmu(void)
 {
+	if (!ll_boot_init())
+		return 0;
 #if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
 	/* reserve TLB table */
 	gd->arch.tlb_size = PGTABLE_SIZE;
-- 
2.43.0

