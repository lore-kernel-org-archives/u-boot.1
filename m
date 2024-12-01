Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A978ED49779
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A58C7896A9;
	Sun,  1 Dec 2024 16:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VIgKbbfm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2DC98966F; Sun,  1 Dec 2024 16:26:14 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85B5E8948A
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-84198253240so123486339f.0
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066767; x=1733671567; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8jkRDaqIvlr/a/jLQOYzRFeKLCLagEcpHQivrCeYqc=;
 b=VIgKbbfmFBtn0gt31sIcPMDdFuvQzbKqrprPevSHL9Ta+PCFY/cZpYI0WeUGkhEtYy
 I5QhXuhmB7hM6tGS70TyiLCwq+wKkGROyc3K5ejVm3FxKtEHOCTM0qFSow5ubtcM6R9s
 RFuoj3Cz+9DzxmrxSgfF5+66jA/3z2m3H0V5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066767; x=1733671567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8jkRDaqIvlr/a/jLQOYzRFeKLCLagEcpHQivrCeYqc=;
 b=fIJi9BS/hLBFkOGRjOFKW5TNsY/hUFSnebXUiLjNSDQC9l1LeoQDtqJ5qwcdBAmpgr
 ybZ3YkLR/ONsIoz/6YUvjmTGGBWUprpEIbs1giKi/VBvORiXCPNSfTkfsZiX6NWle20s
 YQ2Kas7mBiElXZB7rHCN3riZSkfa7Ws+RY6UjWNkH1vgrm05JuCRXLStdZMv7Eoe2opl
 3uQwjceo+nlM+oxhPaQcPcIl9XCETQwyeASkVKt65m2zI7TIT8BjnKo9TS2aCB6iWTFT
 e6VHf/GNcqA0LZhgy5hox20Oto0pIm+VcC3xbVspucc6Lfk6f7ybtTewuOBplzMtnXbS
 RA3Q==
X-Gm-Message-State: AOJu0YxdlyAo/WuniKj7EnykeSKPgxrc+XjYCF1i49U7AapP63MQcZ6i
 IYQc+ZnXtUICm5qPNXxct7qFFBD8WJCGa/9Kndc0hc+AX3lW+pyT3PlFI22lPp/oWpnE7Pg+yBw
 =
X-Gm-Gg: ASbGncs5Av9JFqQztgWhY8yZ4z5XjtUViCY0kL+fMP65xHxuYO0HJ2kNKDkkm2LZAq9
 knYQRGyEGgu5F3uih2K/3BT+gdrkBcPs/uHAVdBLWvyKa3imjBSe0z8gPuQW4BPPoWVTzwYvp86
 WqVrHl88nw6KnfVzoR4WLIl5kGTNbJxSMfEsJQHcZ6c49DBfUnE2K8dxrWIMFDm7eYpnzJ8qc69
 G7J6a8f6cgtEjzdyhRlcqiQTh4fQBd4kSKMfWusXkI/
X-Google-Smtp-Source: AGHT+IFYoeLUGt8HPdz6rmhXcFrYVWG0qsz902zyeV7sTGD2x5GNny9bHdBM3Mv6Ptx33bsdOBUVag==
X-Received: by 2002:a05:6602:342a:b0:835:4cb5:4fa7 with SMTP id
 ca18e2360f4ac-843ed09db4amr2276187839f.12.1733066767026; 
 Sun, 01 Dec 2024 07:26:07 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:26:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 20/25] efi_loader: Don't try to add sandbox runtime code
Date: Sun,  1 Dec 2024 08:24:39 -0700
Message-ID: <20241201152505.1666789-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152505.1666789-1-sjg@chromium.org>
References: <20241201152505.1666789-1-sjg@chromium.org>
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

This cannot work since the code is not present in the emulated memory.
In any case, sandbox cannot make use of the runtime code.

For now, just drop it from sandbox. We can always adjust things to copy
it into memory, if needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 89f22388fc4..b3ba67413ee 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -769,16 +769,22 @@ static void add_u_boot_and_runtime(void)
 	runtime_mask = SZ_64K - 1;
 #endif
 
-	/*
-	 * Add Runtime Services. We mark surrounding boottime code as runtime as
-	 * well to fulfill the runtime alignment constraints but avoid padding.
-	 */
-	runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
-	runtime_end = (uintptr_t)__efi_runtime_stop;
-	runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
-	runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
-	efi_add_memory_map_pg(runtime_start, runtime_pages,
-			      EFI_RUNTIME_SERVICES_CODE, false);
+	if (!IS_ENABLED(CONFIG_SANDBOX)) {
+		/*
+		 * Add Runtime Services. We mark surrounding boottime code as
+		 * runtime as well to fulfill the runtime alignment constraints
+		 * but avoid padding.
+		 *
+		 * This is not enabled for sandbox, since we cannot map the
+		 * sandbox code into emulated SDRAM
+		 */
+		runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
+		runtime_end = (uintptr_t)__efi_runtime_stop;
+		runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
+		runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
+		efi_add_memory_map_pg(runtime_start, runtime_pages,
+				      EFI_RUNTIME_SERVICES_CODE, false);
+	}
 }
 
 int efi_memory_init(void)
-- 
2.43.0

