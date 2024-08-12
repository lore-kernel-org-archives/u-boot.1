Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B942FC52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 20:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B2C687DB6;
	Mon, 12 Aug 2024 22:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wQusNVdq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1532787E9D; Mon, 12 Aug 2024 22:58:12 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B51186BF1
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 22:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5bd13ea7604so3071075a12.1
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 13:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723496289; x=1724101089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/915ceIWv7aY9bGmDS6CEI/wALKVv480Vkfnxpg2xno=;
 b=wQusNVdqmksNhNTXbcHzFvVrs3a4qnJbaxNLOJgVWu2QxmsZGz43ngWndNMuVl4NKm
 yj8x1b234Q7pmhQFQr0MkzDmw0gT+WHzjWpzdj2Ni2FO93u2GPom5BPblf4i4DSTCJC4
 BOrfGQsiNovblgI4IyUAU012qapRHuQjxMjCMX5DhQUp35bm3fyL3XGVo0DM2v9Ce0Tt
 dKDaI2zt33sNVQkf0UXCoavB/A6BpcY5sjZsflMIzEi+a70WgRLONqeBNCS8JtId9hT+
 ii6s1vyjGLe2d9QqppCSaal2LvYZ8HyxF9KHD0l0SHz5BBDTxeWo3J4jRLdrG4/CaACf
 +Fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723496289; x=1724101089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/915ceIWv7aY9bGmDS6CEI/wALKVv480Vkfnxpg2xno=;
 b=RPLjiXB5aiAZW55clAKCE0wNsoJ73c1Nq5Mz5rsepJgBTXy+t2zRLKjomzJC7orkUS
 ACmWoz8CZSh6brhkx4c7q9iIdklaKbyW14HbXWawh1GTZNnCzoi3PyYMrKwllKWR3BBH
 QTbeMMWSTQGB4ysMuNxHVpSU6Unkr4/ksaW4533KOLgYERwwMg2Q1N5KA2YxWsdtW5vL
 J+zmnM1ABo5GzWmltUfnwSHs84FAVOs/syE1nuDTqqoUXF74eRDxvRCIzNHk33QjiicQ
 96kpo77IKj2j7K95XaHlRDysXqKhFC+OD3f9qe55ub54HcEhpUhnC0he7rPNGzZKxEcJ
 xR3Q==
X-Gm-Message-State: AOJu0YwaBZVUJ2ur+tR2U54lChoUzRU15wRsc4ujT4qXNhtlbHbJk6Yv
 M8pOaufNeoi/ISs0DnUsbwWczupYQIkWJmIje9cvVT0BDGVXNcoaMeEQ78E6W5c=
X-Google-Smtp-Source: AGHT+IEHiUkChtZ2EHxjSmSqDrILf9pemaENak/0HlZDPiKxaXq8Dzk2OvDE1sWkPeYT0QzsLAHErw==
X-Received: by 2002:a17:907:f15a:b0:a7a:a557:4548 with SMTP id
 a640c23a62f3a-a80ed1c1ee5mr112184566b.21.1723496288403; 
 Mon, 12 Aug 2024 13:58:08 -0700 (PDT)
Received: from localhost.localdomain (ppp046103060252.access.hol.gr.
 [46.103.60.252]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3f475d8sm10183866b.38.2024.08.12.13.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 13:58:08 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: u-boot@lists.denx.de,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] efi_loader: fix memory freeing in efi_get_dp_from_boot()
Date: Mon, 12 Aug 2024 23:57:59 +0300
Message-ID: <20240812205759.1732217-1-ilias.apalodimas@linaro.org>
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

efi_get_var() allocates memory which must be freed after the variable is
used. Since the device path is duplicated after we deserialize the load
options free the memory used for the variable payload

Fixes: db61e70e0d2a efi_loader: efi_dp_from_lo() should skip VenMedia node
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 65d2116381ae..916f43da26c7 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -74,6 +74,7 @@ out:
  */
 struct efi_device_path *efi_get_dp_from_boot(const efi_guid_t *guid)
 {
+	struct efi_device_path *file_path = NULL;
 	struct efi_load_option lo;
 	void *var_value;
 	efi_uintn_t size;
@@ -92,11 +93,11 @@ struct efi_device_path *efi_get_dp_from_boot(const efi_guid_t *guid)
 	if (ret != EFI_SUCCESS)
 		goto err;
 
-	return efi_dp_from_lo(&lo, guid);
+	file_path = efi_dp_from_lo(&lo, guid);
 
 err:
 	free(var_value);
-	return NULL;
+	return file_path;
 }
 
 /**
-- 
2.45.2

