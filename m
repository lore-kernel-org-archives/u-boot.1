Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D50C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 07:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17EAB87708;
	Mon, 22 Jan 2024 08:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oEaVkaLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2766487776; Mon, 22 Jan 2024 08:28:32 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 793D0876B1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 08:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6d9344f30caso1680302b3a.1
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 23:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705908506; x=1706513306; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8om6QEIzofjENAff0O7c0R4K15koMexpSJCMBgdc8ZU=;
 b=oEaVkaLtT1YTVIyKUiTN055BynJZ6AAH2xWDLrXD6nTVnU6ampg9Sh2A4OhhszRxge
 VNL/K3VWJ/o+EPmG4SxHERIJWQlJJXXXZmUUtDVm+QEgYTK50lvZuQRpZ4YNoX8YlxL/
 BEpHsG9jutRa6IuJZnxumsKR8DFrbpZsIFL0vkHxib2gIYoKr4iLdlhZhzf5PKELILm7
 KD4g5UsQ9vQkifbrL9v52RlEX+WxoepGNIjxL8YYAKKtgpKBlJq112MgK/NRbfC3mmpC
 Z7qQdRU3gUaqym1RFkt+sipuePyyyGAk2vPSBbx+0hb3UOz5/p5P5OtUggo7Vz9ROSFg
 9sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705908506; x=1706513306;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8om6QEIzofjENAff0O7c0R4K15koMexpSJCMBgdc8ZU=;
 b=Gp/xSY6grU3FU4IlU1WJpdOnYQ+rLW7wUOTc98IrUphIsoyY6n7I3nbq49ixD3dT4r
 ClNZtCUtt1wTS5Ne+lAjjstfjnOvqyt293xZx1AkNY388poBhP7QJYQJscU5PtbXvh5M
 lgbz4av8aMEpZKIAMK/ngrfYzXCBi/PZ6UgvYAP3pv8h40RpoNKhowMLwUtCl+VGCK8D
 2GWWrBudG+N81JG1clriiUlHZxjTE3R1q5t8j9yZTmnB0TERoasOzf0qx83oY7rmOo82
 A2a9lqgYzp37+vg45YOhPddWa9IwPajmDvzNEpM3tJ5jZfvcTkjtjz7CADfzKNfZ8zNR
 tFCw==
X-Gm-Message-State: AOJu0YwnhXS44/x3/7n3Fy9PqiIQKmvXIcZ+ssOq5Cw7xEDGL/QcIl8A
 U4ixclsslzqQZiOVu2TcPEdFPMnZ0wMj7RmhJXxsuSoH1fOeQgdnQVLioAVTmhCAO0nk9arZvon
 b
X-Google-Smtp-Source: AGHT+IGplOQc/FBGk5hBqF5sK4cKRF2qXHXHA4M9CPiMcCINBBRxijTsDYxwEKHh/I+kvpUulSkIjw==
X-Received: by 2002:a05:6a00:a8d:b0:6db:d65d:39ae with SMTP id
 b13-20020a056a000a8d00b006dbd65d39aemr2935340pfl.29.1705908505897; 
 Sun, 21 Jan 2024 23:28:25 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 y15-20020a62f24f000000b006d93ca7f8f3sm8891936pfl.150.2024.01.21.23.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jan 2024 23:28:25 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH] efi_loader: check efi_get_variable_int return value
Date: Mon, 22 Jan 2024 16:26:17 +0900
Message-Id: <20240122072617.1104227-1-masahisa.kojima@linaro.org>
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
 lib/efi_loader/efi_firmware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 9fd13297a6..fb83fa8113 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -407,11 +407,11 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
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

