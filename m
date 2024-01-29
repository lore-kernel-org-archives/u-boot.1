Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070B3C47258
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 02:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51BAC87CAB;
	Mon, 29 Jan 2024 03:53:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lNhfbyEO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0924087CAC; Mon, 29 Jan 2024 03:53:34 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1AE7879CC
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 03:53:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-dc22ae44595so2375535276.1
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 18:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706496810; x=1707101610; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yxSVKAAbYmuUECgEQFX963vgXjFrGbYtCeA84cx7gqw=;
 b=lNhfbyEORyAVNppBn+blhWjTy1MqQiKMBbb58S3V9NZ9GtjIoiZiYaX5DG9yyBf5ul
 RYsTfzObZY1LGHm35MSFQ9ZyxqqeQ4eZoYa57q21xP8P9bXNLUrboXLSQ7+ZVDeHvMK7
 O3sE53nIel/QT14T2fluSHV8JfdnSl8y3/fGEkE/pgS7uPHJjaMgYz5iakGk4kIK+OqV
 bE6c44cecxaQvfpclltIayOHGfIjneNEZv4TCXpy/20yJBsb6WP+LsdtD8UsODcfZhVl
 romvm9pFXlH0yxxav4i7orhi0Zh9ZX7uCuDLW0AEJd9FG4DABN9lM+p4E/2+kX9WJCot
 6X4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706496810; x=1707101610;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yxSVKAAbYmuUECgEQFX963vgXjFrGbYtCeA84cx7gqw=;
 b=AoWbx25iYsD/FnlHU8LR1c9uaA6b/rU9u84CZ14EE7hHKbXuV5UBkQTOXr54WMI3rt
 A+z1OYJk3eqU7V7wePI6DG+X8B/S0e74RvOQd9qc4cbemO4amV6jGU90Dvu+u25GQgxx
 BlGhODxzBVBcKs95zjcdQdgweBxT18iMzcAAQf0gS7FLI/pOGEDTGTB1MHc39IyLUWGP
 Gh7n90Z6CDCzmWI4GBifDakIJPYY2kE6rKwO6GyfT8Kg53nQlT9h5MLgRLCIiKdi5EkB
 vM7Tc70qmLMCgjjEQ9lyvtqGKsESwFIvCm7xdrf/Hx7Y50FiT5wkxo0JGD8TaqJrbULb
 A97g==
X-Gm-Message-State: AOJu0Yxbtol/t/UJYcJ1grJGYM6ED3UwZ/8D+ePKJcEfWx0kpHqgVOwB
 2cpZ2z67qtaRp6X76DwhGwZurWeIAXCCv4ELM7t6qIlPjry4NpZQvT8bGLuUK7msOS1U4/SVqqv
 Y
X-Google-Smtp-Source: AGHT+IHyh0qzFqBFJtR1EMjulVLumIkAddsP9jdMIPuHGdu/7P1G+J82+jCFZ1sRxlxReDU5EMfj9g==
X-Received: by 2002:a05:6902:248d:b0:dc2:5553:ca12 with SMTP id
 ds13-20020a056902248d00b00dc25553ca12mr2306630ybb.14.1706496809803; 
 Sun, 28 Jan 2024 18:53:29 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 y9-20020a634b09000000b005d8c07588b9sm1924365pga.10.2024.01.28.18.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jan 2024 18:53:29 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2] efi_loader: check efi_get_variable_int return value
Date: Mon, 29 Jan 2024 11:51:14 +0900
Message-Id: <20240129025114.1294749-1-masahisa.kojima@linaro.org>
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

efi_get_variable_int() may fail, the buffer should be
cleared before using it.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Addresses-Coverity-ID: 478333 ("Error handling issues")
---
Changes in v2:
- use malloc instead of calloc

 lib/efi_loader/efi_firmware.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 9fd13297a6..ba5aba098c 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -400,18 +400,18 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
 	}
 
 	size = num_banks * sizeof(*var_state);
-	var_state = calloc(1, size);
+	var_state = malloc(size);
 	if (!var_state)
 		return EFI_OUT_OF_RESOURCES;
 
 	/*
 	 * GetVariable may fail, EFI_NOT_FOUND is returned if FmpState
 	 * variable has not been set yet.
-	 * Ignore the error here since the correct FmpState variable
-	 * is set later.
 	 */
-	efi_get_variable_int(varname, image_type_id, NULL, &size, var_state,
-			     NULL);
+	ret = efi_get_variable_int(varname, image_type_id, NULL, &size,
+				   var_state, NULL);
+	if (ret != EFI_SUCCESS)
+		memset(var_state, 0, num_banks * sizeof(*var_state));
 
 	/*
 	 * Only the fw_version is set here.
-- 
2.34.1

