Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65757C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 09:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 206C187B42;
	Wed, 17 Jan 2024 10:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GDAYTqFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D45E87B41; Wed, 17 Jan 2024 10:46:47 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4BC587B12
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 10:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d5dfda4319so13019835ad.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 01:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705484802; x=1706089602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/mGCQb8aGXFjbqqblC/NhK7evpYwFCorbUPtKhDUy8=;
 b=GDAYTqFeR14oAwpvHDRTwPvMXqFuWj3SygUcCD8T2O+C1mykOBcOAHCQ1GI/Ew9N9w
 qNFrunp71jcY9aopSXsZoNJzqboSo1go5g04by71lvokWddAx/QoYULisrhCDjFyOYwD
 IVSPNntkC7/J/X/ZNiVOxqbZ55g0H9PhOb1zV/E39rNQ0nOvmrUPSB7Uqb6GB4ZP5z3c
 Nd+ozlay6gh9NJRcLH8M/neFSaM8/t8OWpg6RP4zY9247pXSC8b3HzHgikKvmeKQPnoP
 GiXjLsUiGSVmXk1e3uL4CO9RCSyTQKPhdlovztaFvpg0u8PyfOiDefcd14zQddoRNjt5
 hW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705484802; x=1706089602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H/mGCQb8aGXFjbqqblC/NhK7evpYwFCorbUPtKhDUy8=;
 b=k9VxAhRBeqnkfGFJV6pgxW0wSqRh0HzUs+LV+d8K62FBS0vz0prUO5Mq2yhTN4u+lA
 s6Pj/UMTSz9foJwiAbMfFD3e4YBBikwE5KjxhnF8XxlBkMJasNrGZcebA36Gxh5zDHPZ
 Aqqkfb+tig48GSaRnP1yTu9ukSt+SmQs3D0XQS7G+59V/X6j+3jqI8KmUcXxFfi/fYSt
 jJYuTF2TuICS6YWzQs+HYtphjZDEX/F+AQ0HCl9W29XAVf+wuh+qqAsOORcz9HKe/yIo
 wf3nkQ/Ugj3H3fFWmz+HbPM6VyUGl4YofWBgEycJyD1P5HEtM9l1ssusg7oEpuiFE1Ma
 aNlw==
X-Gm-Message-State: AOJu0YzLgC6LzbZ99ZdfCitci54ALyuQjUIJmJvvi3neFeHkB1PYFAo0
 wXpkAiNMUImooGgEBtK/wV7uxe7ymHZE2xgndftjvneqb3Y=
X-Google-Smtp-Source: AGHT+IEjXDEl36zInabhulJs4chxv2t3eh514VXX4EMH80gwEKHWMO1JcWFrV6mp8s+FaKALsLfA5A==
X-Received: by 2002:a17:903:2986:b0:1d6:f3be:aad0 with SMTP id
 lm6-20020a170903298600b001d6f3beaad0mr366119plb.32.1705484802372; 
 Wed, 17 Jan 2024 01:46:42 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 e23-20020a170902ed9700b001d5eb912f8fsm2371267plj.15.2024.01.17.01.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 01:46:41 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2 1/3] efi_loader: avoid pointer access after calling
 efi_delete_handle
Date: Wed, 17 Jan 2024 18:44:30 +0900
Message-Id: <20240117094432.1049168-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117094432.1049168-1-masahisa.kojima@linaro.org>
References: <20240117094432.1049168-1-masahisa.kojima@linaro.org>
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

efi_delete_handle() calls efi_purge_handle(), then it finally
frees the EFI handle.
Both diskobj and handle variables in efi_disk_remove() have
the same pointer, we can not access diskobj->dp after calling
efi_delete_handle().

This commit saves the struct efi_device_path pointer before
calling efi_delete_handle(). This commit also fixes the
missing free for volume member in struct efi_disk_obj.

This commit also removes the container_of() calls, and
adds the TODO comment of missing efi_close_protocol() call
for the parent EFI_BLOCK_IO_PROTOCOL.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_disk.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 013842f077..ce46c1092a 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -707,35 +707,46 @@ int efi_disk_remove(void *ctx, struct event *event)
 	struct udevice *dev = event->data.dm.dev;
 	efi_handle_t handle;
 	struct blk_desc *desc;
+	struct efi_device_path *dp = NULL;
 	struct efi_disk_obj *diskobj = NULL;
+	struct efi_simple_file_system_protocol *volume = NULL;
 	efi_status_t ret;
 
 	if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle))
 		return 0;
 
+	if (!handle)
+		return 0;
+
 	id = device_get_uclass_id(dev);
 	switch (id) {
 	case UCLASS_BLK:
 		desc = dev_get_uclass_plat(dev);
 		if (desc && desc->uclass_id != UCLASS_EFI_LOADER)
-			diskobj = container_of(handle, struct efi_disk_obj,
-					       header);
+			diskobj = (struct efi_disk_obj *)handle;
 		break;
 	case UCLASS_PARTITION:
-		diskobj = container_of(handle, struct efi_disk_obj, header);
+		diskobj = (struct efi_disk_obj *)handle;
+
+		/* TODO: closing the parent EFI_BLOCK_IO_PROTOCOL is missing. */
+
 		break;
 	default:
 		return 0;
 	}
 
+	if (diskobj) {
+		dp = diskobj->dp;
+		volume = diskobj->volume;
+	}
+
 	ret = efi_delete_handle(handle);
 	/* Do not delete DM device if there are still EFI drivers attached. */
 	if (ret != EFI_SUCCESS)
 		return -1;
 
-	if (diskobj)
-		efi_free_pool(diskobj->dp);
-
+	efi_free_pool(dp);
+	free(volume);
 	dev_tag_del(dev, DM_TAG_EFI);
 
 	return 0;
-- 
2.34.1

