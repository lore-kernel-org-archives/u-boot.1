Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30CDC47422
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 00:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8CBD87C0F;
	Fri, 19 Jan 2024 01:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DnSsEgNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64FE0876C8; Fri, 19 Jan 2024 01:47:56 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8064D87C0F
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 01:47:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-598f3e9f2e3so140942eaf.3
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 16:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705625270; x=1706230070; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMkAtHbS9igJk/XqlqD1v8X9YbbdLN5u5/dkt7CG/X0=;
 b=DnSsEgNeanLRGsVa6hz4KTAVFhnseA1nehI5D5LnzFEYo6vwh95JpCvDl6FfN4wVt5
 hz/Hit0Cm+lZZjABh71TmWPkdLRK07iAiYv+IZGzbEXK1iRCJQzzd7rS4dt0crZjXsXv
 TNyg7n5StRkKyXrLXp+X4keOykC+fKQc4JzEAmJQc57gnxcIMxKrSnDIjdQmhFDStJg5
 m4frMag5FUPBuokBgLJST8ZRbTD0MoP40iJ7lSBM50lYhQdMucdPIO5slISE7hx7cdT0
 va9bxK+dmOJ4p5vIj6ddo3Q4WUIBQojiNKu42ZpNdlBlP0oejmo7F747bhvvbYU5wVWM
 4sKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705625270; x=1706230070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lMkAtHbS9igJk/XqlqD1v8X9YbbdLN5u5/dkt7CG/X0=;
 b=H0qxSN5mRMPDaIiKOwNUEe9RyoIgZBAH9PDaMVBIe6DX6NfdACcUq1ojI/ZOH/3mrO
 QZgcCwmPmCeTuLR+fSh6qe+ewufkLKA5d+5NwMJgClQvSrd3X0wWoz6HH4A9MgcvUIPa
 wwrGkOxiIgHzSyIVgMPUQdUutJlMOS61OOiNDwPopCoHczh5jBPngpPV/tu5cVNH1OOr
 wclM/MwHHgzURkwYhJPILFnue6FbotBrIcli6RkUqGnuv36P5hxH/7w1AOvE3eGAmu8Q
 Vg5VX6xmpoTNEPEdXI+IQNytVGFA0az8cUl3GmDPquWdS9T+dt0RW4ltWGp/SIF8p6bN
 PIDw==
X-Gm-Message-State: AOJu0Yyw7o7NC6Tmz/alFEGMDLMzsxrnnZOOK+fJM94U99kymmRAd3fC
 zgFa4KsejzJmSsWk7yH8maJfhTet/Q09xFfgGlJhK+hwuXoojcnSYNeviNuFRbldhqtt0YV1AQ5
 5
X-Google-Smtp-Source: AGHT+IGHlp9tMxMPWWn3SeF5S2n0K6O5756RsmL7jwVLOu8Rh8n7O0lC/TK55KrHl/a+RLQp6S+zhg==
X-Received: by 2002:a05:6358:cc1e:b0:175:e96d:3c4a with SMTP id
 gx30-20020a056358cc1e00b00175e96d3c4amr1516810rwb.11.1705625269709; 
 Thu, 18 Jan 2024 16:47:49 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 kd3-20020a17090313c300b001d5383ae01csm1946470plb.121.2024.01.18.16.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 16:47:49 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v3 1/3] efi_loader: avoid pointer access after calling
 efi_delete_handle
Date: Fri, 19 Jan 2024 09:45:44 +0900
Message-Id: <20240119004546.1084018-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119004546.1084018-1-masahisa.kojima@linaro.org>
References: <20240119004546.1084018-1-masahisa.kojima@linaro.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_disk.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 013842f077..105f080125 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -707,7 +707,9 @@ int efi_disk_remove(void *ctx, struct event *event)
 	struct udevice *dev = event->data.dm.dev;
 	efi_handle_t handle;
 	struct blk_desc *desc;
+	struct efi_device_path *dp = NULL;
 	struct efi_disk_obj *diskobj = NULL;
+	struct efi_simple_file_system_protocol *volume = NULL;
 	efi_status_t ret;
 
 	if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle))
@@ -718,24 +720,30 @@ int efi_disk_remove(void *ctx, struct event *event)
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

