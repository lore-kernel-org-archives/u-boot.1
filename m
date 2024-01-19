Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C676C47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 00:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8383587C5A;
	Fri, 19 Jan 2024 01:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pyaGSQI8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9359C87BF6; Fri, 19 Jan 2024 01:47:59 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BAB887BE1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 01:47:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2109743a111so211423fac.0
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 16:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705625274; x=1706230074; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crWngtzxMPcMdvcVco96f8AC88kApFBYBAC8rvuPYR4=;
 b=pyaGSQI8HjyiQd98yezggVTpixqmiDgqyivwT9Lw5BV39dH0XaqV55O2JBjalN3dpM
 BeYmFSDHxpB7KmJVNcTJh4Vp2K0KA2o22ZFDIBfpCB6IzH7lSG3ALE4bcpcr05pSACwR
 244XxkyYLLIMRIoJWGAawmO5gMu842EqD2sedUCWhG9AIyFes193lJ1oYAY7lDNfA//1
 q/gzQBD9mOyEvlLr90mXBVBpNcfBaI7W81ahi/pcUoLSE3xIR6RgXIY4jMVjCpX/bsf+
 5p6+0aEmFy/JgjeBEAEAGcFRGmx4I92e7tBqGYz9CThIPXSkRt2bghrCplEpDaD65HEC
 vMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705625274; x=1706230074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=crWngtzxMPcMdvcVco96f8AC88kApFBYBAC8rvuPYR4=;
 b=pIc3XhbIGA+IH2mLH7h1rdJDnNqDj5kPObe9wlfqCg0VQb2Q5e6165lkdbsGCowp4s
 S2sYukXcbCq6Yt92cF1oGPvq2NGPvp09Bpl4Sgd3K5ZD6Hj9sgzAmqDLqCZ1VkK2xZs0
 k2FjYcqeYpsa1etqR8x96MkF6ocv8a014kC1az+L2IPJ62qbjX90srJ2swSW1wQFqFN5
 tso2kpPaofzXiCqkUemRuKXgxdKQZ2M4Nzv07o2jylfTJL2Fd5YQXsf1BHeCnff0w3EA
 791zNZKDAW/w2tAahqEsZ4+V11EKRt4jIlMujzULeGZpfKw4Bpdb7+CsPy0a99PMyprT
 cLDw==
X-Gm-Message-State: AOJu0Yx8RfBePBYjS3Mm6zAUWF5AjarJDwyQLhkOwk/o97ySP8NfpVS9
 sMXwFAK4837SyS61MWOc3tzhEd0rOH5+rWLKd6iBjQNCe8ATbbm011GRvm+wPFGtgoDRHakvHxV
 6
X-Google-Smtp-Source: AGHT+IFFB0v3QIoweENP7VV2jBYjk1m+sjI63MXSRKcfRATuFuPv8UesmfTiGKzoKKbkioufj2MFPw==
X-Received: by 2002:a05:6871:548:b0:203:afa6:ad29 with SMTP id
 t8-20020a056871054800b00203afa6ad29mr1960000oal.23.1705625274688; 
 Thu, 18 Jan 2024 16:47:54 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 k68-20020a632447000000b00578b40a4903sm2200046pgk.22.2024.01.18.16.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 16:47:54 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v3 2/3] efi_loader: create common function to free struct
 efi_disk_obj
Date: Fri, 19 Jan 2024 09:45:45 +0900
Message-Id: <20240119004546.1084018-3-masahisa.kojima@linaro.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_disk.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 105f080125..e2edc69fcf 100644
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

