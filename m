Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8490DC0218F
	for <u-boot@archiver.kernel.org>; Sun,  2 Feb 2025 20:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C4280085;
	Sun,  2 Feb 2025 21:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zp7fOUNt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80992800B3; Sun,  2 Feb 2025 18:59:46 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8880F80077
 for <u-boot@lists.denx.de>; Sun,  2 Feb 2025 18:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maks.mishinfz@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-30761be8fcfso37395611fa.0
 for <u-boot@lists.denx.de>; Sun, 02 Feb 2025 09:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738519183; x=1739123983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hA5TTR4eD8GGhF2BcOsxRrA+OM3++L4Dz/qFNSOETjw=;
 b=Zp7fOUNtQyoT/mLYt3adJsT4LvRThAiVMDHgmCUs868RWRUNr3uDbneG+OYrzXq08C
 Fz8VehSdMdlNB6PkWGsNFiYU9vpdUeE3z85NwQV215Wwc1KCzBvW42XLIXp1AJTdznaQ
 enfq0eUtZoi7/xA33GxuUQvYsU3qimkuGvJQAJmimkeAYRGtB4cOagPH4RSFYgaqMQ5g
 7r4X597zF7a7dCp1c+dGXJrpf0GdLNHNQDOSKbbXi5yCzmHp6IbewZ59Y78NB+mvMu1z
 9sPOP4vVZyImEyuM9XR/XXzMcJt1uGldoYIaAEUWVNOuhYAJ4CPeAOrx1DR0jd9vPQHC
 wrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738519183; x=1739123983;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hA5TTR4eD8GGhF2BcOsxRrA+OM3++L4Dz/qFNSOETjw=;
 b=kckKBTWPezBMpHNwYe85s7rPUhishqPcsIxjQ4GMyrsnoKILoVIa0mrRt+12NesbKO
 ateo6fg0DDB6Qe59e/SPd3EeWgKhI/lOCr4sb9hnJcJruhIDvA0oTKLG3vebxRsut+yd
 //DQeRDLvO+fM6Rv/b6FVSodb43HIeK15OjcEBdvpVDcsYEISyMtlJpyG1I3quh0L1DI
 jKzXdK7pFYQH364nQbJebLpNzig9PtfNilnpdwV3nsD+GokQldAToLAXkQOkk7nx/94J
 0m4z5uylV6N+KHaHXzP6JV63r3VSJ0ycvTicRQzcVRr3aEB2HRuQZ1bUce2ueyBbNISA
 ut/Q==
X-Gm-Message-State: AOJu0YyHcqwDwkipLyR3LqXtdE0NaY4s/B6+9kRnmVtAdccgCvy4Ruu8
 SGJa4pSXbJtFNkLEK8ryvbohUf1J0FzZawINx6fYIbAS8co9Ll9ULzmFew==
X-Gm-Gg: ASbGncsLHUpRhtdCo6mdpe8dXVjcZkWs56Atl0LT73Y9hY4hdL+hhxM8N2B81sqw442
 imToWBee6lBiKYUxrMrV7YRCy0ckctXFHnVJFgVwhB6GLAd54mC2WtVCxuWwy26OlHNks4EZsXT
 b+7iBnI0gMlSjz9uCsu7Z7DUkU60dPjB64aD33vUd+LE2dM1M2Om3Xijlb+Sfc03MFrunmIPXHj
 1ksO30XjWcwi8YSPgvMqhGdTYlmN9XG56O3miyN+qAIoRipZvKj73A1P/0tbHu9mD+QPiYxEd1f
 AeIRT94PboAdIs78vfUdYkg=
X-Google-Smtp-Source: AGHT+IHtLeFd2VFJjhzzgr5amabQvaX1We1UrPfvtO21jUpxxI3Aldhov3pgknDVo7LWYI6EkfKnUg==
X-Received: by 2002:a05:651c:b0e:b0:300:7f87:a6a with SMTP id
 38308e7fff4ca-307968b86f0mr67728181fa.7.1738519183343; 
 Sun, 02 Feb 2025 09:59:43 -0800 (PST)
Received: from dev.rasu.local ([212.22.67.162])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-307a3086e52sm12363871fa.24.2025.02.02.09.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 09:59:42 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] efi_loader: Fix potential deref-after-null
Date: Sun,  2 Feb 2025 20:59:40 +0300
Message-Id: <20250202175940.2150031-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Feb 2025 21:32:10 +0100
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

After having been compared to a NULL value at efi_disk.c:426, 
pointer 'part_info' is dereferenced at efi_disk.c:534.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 lib/efi_loader/efi_disk.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 1f3de0a233..83e8eb6fe4 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -531,13 +531,15 @@ static efi_status_t efi_disk_add_dev(
 
 	/* Store first EFI system partition */
 	if (part && efi_system_partition.uclass_id == UCLASS_INVALID) {
-		if (part_info->bootable & PART_EFI_SYSTEM_PARTITION) {
-			efi_system_partition.uclass_id = desc->uclass_id;
-			efi_system_partition.devnum = desc->devnum;
-			efi_system_partition.part = part;
-			EFI_PRINT("EFI system partition: %s %x:%x\n",
-				  blk_get_uclass_name(desc->uclass_id),
-				  desc->devnum, part);
+		if (part_info) {
+			if (part_info->bootable & PART_EFI_SYSTEM_PARTITION) {
+				efi_system_partition.uclass_id = desc->uclass_id;
+				efi_system_partition.devnum = desc->devnum;
+				efi_system_partition.part = part;
+				EFI_PRINT("EFI system partition: %s %x:%x\n",
+					blk_get_uclass_name(desc->uclass_id),
+					desc->devnum, part);
+			}
 		}
 	}
 	return EFI_SUCCESS;
-- 
2.34.1

