Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D78BC47DA7
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 09:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C665287B3D;
	Wed, 17 Jan 2024 10:46:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RiHWw7QC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B444287B30; Wed, 17 Jan 2024 10:46:53 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 166ED87B3D
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 10:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-59502aa878aso4948120eaf.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 01:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705484807; x=1706089607; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ho+PLVyTZdaqLEvAtRVLK3xm2WuFnKSJpTJE1JOfHA=;
 b=RiHWw7QC68GUvwyuQmie5/F2P2sTi9f0Q3kmeNpQHf6Wis+nUNeNpA33qRVC4NbNXG
 8ZfHaNkxc7ts3A1sbLvCWJt6ymHhxHU9qd/3yqQxFkRQPWBHV8TwD8BmW/Jo6K6s2BPv
 qv9o7LXaCFa9CaSVQX9DUru4C75Q2b+OfY5dkkTHTNceyOwyxJwrRBBYPTCB+VmDs6OS
 PeayBfX7T8t/bEpZv3ItFE1JUr+bFpOjljJ24jZ76N5BPXaWnZJWfhodOz/fFBVNTf8d
 briV98GbFjuRHbDooXyNjRPM7XWsRmb1moOCTCppL9DnOAEyHvcysdn1Teu5iQDu+5e+
 kD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705484807; x=1706089607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ho+PLVyTZdaqLEvAtRVLK3xm2WuFnKSJpTJE1JOfHA=;
 b=QZjhnoCUOoc0jwsO6mo/CXytMLxfbevWUf2JT/2KAsexoKS+Dm4iIuNrFguHb4uZED
 aiQ3zLNB2qJx9AtxpeO8L9un1rs9hrJmpBBGmZ1yF51zZCod+ZsOoVa3XVAOf+16GP+f
 ZAnjk15j+Ix+44yaOsPJ5PhmG4XXTMdg3C71YDyrKCBSTTYesM1iI1vUReqpZXF+bLVz
 vaC+Q6ORqQUyKCVTAuzhoSNjrS/6ABbKrtFzkk80A5PXTzYx/ovamF7SiIY4JSfp6sTH
 owjYvAv51mqWuNwIIZ4PJpM+EbCZeU8C5aWYoB+u1GX5MBo2nhZUyvqHTS0u89RFDZfO
 nHlA==
X-Gm-Message-State: AOJu0YyXgO4DhA4ZLvZaz4ISoi9KZmXsGGaHQE6gEnH7Iq8XlBejKAZB
 4KLfPxly5X1pDa+pb2xacNnOEfFnDcAsvygvTZQMW5dQkEE=
X-Google-Smtp-Source: AGHT+IFwt1PJnsQDgLClEJs28MjC99UZp6TaftGhFL/sDg5xcp/LEQ1iyD45o+EmsdyUAvw2jzOzdg==
X-Received: by 2002:a05:6358:6f0e:b0:175:5bd4:f418 with SMTP id
 r14-20020a0563586f0e00b001755bd4f418mr7093707rwn.65.1705484807289; 
 Wed, 17 Jan 2024 01:46:47 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 t19-20020a056a00139300b006d9abaf83ebsm993880pfg.164.2024.01.17.01.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 01:46:46 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2 2/3] efi_loader: create common function to free struct
 efi_disk_obj
Date: Wed, 17 Jan 2024 18:44:31 +0900
Message-Id: <20240117094432.1049168-3-masahisa.kojima@linaro.org>
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

Current error handling of creating raw disk/partition has
following issues.
 - duplicate free for EFI handle, EFI handle is already freed
   in efi_delete_handle()
 - missing free for struct efi_device_path and
   struct efi_simple_file_system_protocol in some error paths

To address those issues, this commit creates the common function
to free the struct efi_disk_obj resources and calls it in case
of error.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_disk.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index ce46c1092a..4897a7a7a8 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -371,6 +371,20 @@ static int efi_fs_exists(struct blk_desc *desc, int part)
 	return 1;
 }
 
+static void efi_disk_free_diskobj(struct efi_disk_obj *diskobj)
+{
+	struct efi_device_path *dp = diskobj->dp;
+	struct efi_simple_file_system_protocol *volume = diskobj->volume;
+
+	/*
+	 * ignore error of efi_delete_handle() since this function
+	 * is expected to be called in error path.
+	 */
+	efi_delete_handle(&diskobj->header);
+	efi_free_pool(dp);
+	free(volume);
+}
+
 /**
  * efi_disk_add_dev() - create a handle for a partition or disk
  *
@@ -528,9 +542,7 @@ static efi_status_t efi_disk_add_dev(
 	}
 	return EFI_SUCCESS;
 error:
-	efi_delete_handle(&diskobj->header);
-	free(diskobj->volume);
-	free(diskobj);
+	efi_disk_free_diskobj(diskobj);
 	return ret;
 }
 
@@ -569,8 +581,7 @@ static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
 		return ret;
 	}
 	if (efi_link_dev(&disk->header, dev)) {
-		efi_free_pool(disk->dp);
-		efi_delete_handle(&disk->header);
+		efi_disk_free_diskobj(disk);
 
 		return -EINVAL;
 	}
@@ -624,8 +635,9 @@ static int efi_disk_create_part(struct udevice *dev, efi_handle_t agent_handle)
 		return -1;
 	}
 	if (efi_link_dev(&disk->header, dev)) {
-		efi_free_pool(disk->dp);
-		efi_delete_handle(&disk->header);
+		efi_disk_free_diskobj(disk);
+
+		/* TODO: closing the parent EFI_BLOCK_IO_PROTOCOL is missing. */
 
 		return -1;
 	}
-- 
2.34.1

