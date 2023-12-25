Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0163EC3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 04:46:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1661987807;
	Mon, 25 Dec 2023 05:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gGv4Lt5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA221871DA; Mon, 25 Dec 2023 05:45:55 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFA2B87805
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 05:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-59496704246so125523eaf.2
 for <u-boot@lists.denx.de>; Sun, 24 Dec 2023 20:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703479551; x=1704084351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJ8+802lOUUV9adqdfjlz8ZWJmZz4bZ67ej717zYlRA=;
 b=gGv4Lt5dp/ZPotCwSoEY57iyHgX4XInvxGmki0TDFk4cOd9QfqO5OpR+J5rJBDWwll
 MH7LYxujbdmA0tijPsXguwEQdH4E2aBW7Ya55tHXwvVbmwH8nVBqUVXEXkv/bF0NiJU7
 KeShGmwqi1ezZkBoWBwp+MbuLkhx3rIHs4IC/u1aZroWLKsbCXORHVW4p0ZeaP/V8MBJ
 PmETPo87duc2jvMlwUAZzeZuf3ef1N+qtmmpdCOF9geTLvJ7MidgxpwK4PbZqtVlyyTw
 uSStFiG4fYCN2j/R5vpEcf0yDz+u0XLaiGOs7vTOl3VdwWNStYGrhahrbA5huBiGwWI8
 /Yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703479551; x=1704084351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iJ8+802lOUUV9adqdfjlz8ZWJmZz4bZ67ej717zYlRA=;
 b=e7pAWxXzkCeaSk/jO3XLOwEwg/dirmKX+P1LpPRkOwJad8iGyn0/H0wQs9KqOI58xS
 6UD2dUUdDbdhUpOhhYqFDzK4f/Vj+UK5s86w1xWztiM3vX/YZKpevEJgD1N4FGLRsK/g
 lqrOLRxEsoaiy44NRji8a/RkwSqAKhio5E/W9YQwepozURDcrq7l18Q9vSzcilSUErcm
 KFtjp87vXb1dZLsldXIQE4VxmTPb3f9jtOk5H6HgKq1dCPumd1fCLPYR6K3WS0rQTwIs
 hAjtKaGSw4NUiAJD82YQdd8vVK5ipHtKtzdIx7PYATUlxMFa9X2XdS6UOqOlB3ILrB3F
 NvQw==
X-Gm-Message-State: AOJu0Yz57O83m/XOq7NBGGluucYeZb+DEwPO8SMsDMmwSV9RCAuK3JKv
 sODHTE+vE3/unRRZKRjSKUQOtlI9Ts720ldePK/l+Ag16v8=
X-Google-Smtp-Source: AGHT+IFNrtAmrdvSVJ8UaZTs4tAimcgPzAQqIS6pJSSX5Iv8is4rFf2Bo5jw4unnNLPMKEHRCiST2A==
X-Received: by 2002:a05:6358:716:b0:174:f219:c9ec with SMTP id
 e22-20020a056358071600b00174f219c9ecmr300014rwj.13.1703479550779; 
 Sun, 24 Dec 2023 20:45:50 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 sm18-20020a17090b2e5200b002868abc0e6dsm11672987pjb.11.2023.12.24.20.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 20:45:50 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH 3/3] efi_loader: create common function to free struct
 efi_disk_obj
Date: Mon, 25 Dec 2023 13:43:56 +0900
Message-Id: <20231225044356.626900-4-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231225044356.626900-1-masahisa.kojima@linaro.org>
References: <20231225044356.626900-1-masahisa.kojima@linaro.org>
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
 - duplicate free for efi handle, efi handle is already freed
   in efi_delete_handle()
 - missing free for struct efi_device_path and
   struct efi_simple_file_system_protocol in some error paths

To address those issue, this commit creates the common function
to free the struct efi_disk_obj resources and calls it in case
of error.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_disk.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 415d8601ba..d2ac2fab9b 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -372,6 +372,19 @@ static int efi_fs_exists(struct blk_desc *desc, int part)
 	return 1;
 }
 
+static void efi_disk_free_diskobj(struct efi_disk_obj *diskobj)
+{
+	struct efi_device_path *dp = NULL;
+	struct efi_simple_file_system_protocol *volume = NULL;
+
+	dp = diskobj->dp;
+	volume = diskobj->volume;
+
+	efi_delete_handle(&diskobj->header);
+	efi_free_pool(dp);
+	free(volume);
+}
+
 /**
  * efi_disk_add_dev() - create a handle for a partition or disk
  *
@@ -529,9 +542,7 @@ static efi_status_t efi_disk_add_dev(
 	}
 	return EFI_SUCCESS;
 error:
-	efi_delete_handle(&diskobj->header);
-	free(diskobj->volume);
-	free(diskobj);
+	efi_disk_free_diskobj(diskobj);
 	return ret;
 }
 
@@ -570,8 +581,7 @@ static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
 		return ret;
 	}
 	if (efi_link_dev(&disk->header, dev)) {
-		efi_free_pool(disk->dp);
-		efi_delete_handle(&disk->header);
+		efi_disk_free_diskobj(disk);
 
 		return -EINVAL;
 	}
@@ -625,8 +635,7 @@ static int efi_disk_create_part(struct udevice *dev, efi_handle_t agent_handle)
 		return -1;
 	}
 	if (efi_link_dev(&disk->header, dev)) {
-		efi_free_pool(disk->dp);
-		efi_delete_handle(&disk->header);
+		efi_disk_free_diskobj(disk);
 
 		return -1;
 	}
-- 
2.34.1

