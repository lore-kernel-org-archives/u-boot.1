Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CC8C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 22:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 277C882B17;
	Sun,  6 Apr 2025 00:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wj47X5ka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AAFA82B16; Sun,  6 Apr 2025 00:13:36 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9ED182B1B
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 00:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-227b650504fso28575905ad.0
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743891211; x=1744496011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GK3zxFl7cCHcOsyiH5Bd1h3fTL8BmCTZfAXM7BPbyyM=;
 b=Wj47X5kawOhJ5JwANnM0TTEiI2z2IHrMc8tfnBv8ixnY8VRmMd6ouXrPB2OhsmL8gE
 84+sZR6fvaWTK0UHzijj/Wsmo0R2AEqP7Lg+siet7wFe+yu3NNF8akWmELmUh1XhvaXC
 1jf1S5RgIk+70ygnJEdlVgQPRxnb6G+qn5fn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743891211; x=1744496011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GK3zxFl7cCHcOsyiH5Bd1h3fTL8BmCTZfAXM7BPbyyM=;
 b=LNbLRlxlAgSEKtO0THr5RoUFJJOfAgNRrCbH50Sa7igf1+V0ANDlJXOr0y0t86v4+B
 HTmR7/4m+PUjz7DYk6RaW2FSA4i5IxHBXQePQ0wpSg1XnZuK1ZpHN5DIHC+QGiKknI9T
 uXFD0FAQd+QvDwjgO0wa+f8/z2L0v4b4ElL0yLI7Yv1UZ0Q36OZ45taqztD8ZuIhe2mr
 xjTHP0larCIvPAaj+axqaV+ds4p1Ts0OjDGeQLIXHfxmtKbrBmUDNl/lpMU8/AKuV1u+
 FqHbWCBH7ElnwpqkjM+8goRukUw0WZF//6SNWXWp6fe5fVa1sfzx82YO12hE9X294OPo
 Ei7A==
X-Gm-Message-State: AOJu0YwVt/LJ+rEm4GjvLSZZNMy1XbL3mh8SqajJd+GSJEcm9fIjkng2
 c/Vvx7dDziH/ckElF9S/wRjedMCxNV2Smr/SWWd+zEIfav7RXcRuD6+o5OUF9OMm6XwHfcXgF2M
 7VA==
X-Gm-Gg: ASbGncuZgi3TRH63G4LXUZ1P0zuOn6GCAPGJzzwH2xxaXJW6oVpHIGGDtvB70ev3CHU
 xhHmjZD3vgTNdXx+TMF4YfgA3TuL06HWRPpg2H4FzxKOFxNJRGFS9c/aOIEvgXX7vWYHHDV4oSo
 m/W+K7B8MHvbFDbvNgXm8IcZY8kMZXtKlos9BhFQacy6cdPo4h1xqDdaF9mVvGBK+rslbCbF65B
 btinnXQUrTR5EIU87Ub4giM8bT9coGzNnuZWjvUpeM6/RA49LzuwH7RMGXwKT2lSPPsvXxGa0wf
 xLBP2N16mKeLFqp5jPUcK2/ohdyJOzMmEWkdz4YOQok=
X-Google-Smtp-Source: AGHT+IGwHw6AvrJTIXYjMGo5cKHNcwm5RaSHocfRhCTTepX5YSbwVZAYmcBoRApINQeBXpg6PW8qGQ==
X-Received: by 2002:a17:902:f690:b0:224:912:153 with SMTP id
 d9443c01a7336-22a8a04ab76mr110479515ad.5.1743891211674; 
 Sat, 05 Apr 2025 15:13:31 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297866e612sm54431615ad.200.2025.04.05.15.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 15:13:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, neil.armstrong@linaro.org,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Christian=20Kohlsch=C3=BCtter?= <christian@kohlschutter.com>,
 Janne Grunau <j@jannau.net>
Subject: [PATCH 3/3] efi_loader: Move device-removal later in
 exit-boot-services
Date: Sun,  6 Apr 2025 10:12:47 +1200
Message-ID: <20250405221308.498047-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250405221308.498047-1-sjg@chromium.org>
References: <20250405221308.498047-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This removal should be the last thing done, so that U-Boot does no more
memory allocations afterwards. Move it and add a comment.

Note that the TCG2 log is updated after this call, but I cannot see any
allocations there.

Reported-by: Christian Kohlschütter <christian@kohlschutter.com>

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_boottime.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index ffe43accd1e..e525662f82f 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2250,14 +2250,6 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
 			list_del(&evt->link);
 	}
 
-	if (!efi_st_keep_devices) {
-		bootm_disable_interrupts();
-		if (IS_ENABLED(CONFIG_USB_DEVICE))
-			udc_disconnect();
-		board_quiesce_devices();
-		dm_remove_devices_active();
-	}
-
 	/* Patch out unsupported runtime function */
 	efi_runtime_detach();
 
@@ -2279,6 +2271,19 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
 	/* Give the payload some time to boot */
 	efi_set_watchdog(0);
 	schedule();
+
+	/*
+	 * this should be the last thing done, to avoid memory allocations
+	 * between removing devices and the OS taking over
+	 */
+	if (!efi_st_keep_devices) {
+		bootm_disable_interrupts();
+		if (IS_ENABLED(CONFIG_USB_DEVICE))
+			udc_disconnect();
+		board_quiesce_devices();
+		dm_remove_devices_active();
+	}
+
 out:
 	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
 		if (ret != EFI_SUCCESS)
-- 
2.43.0

base-commit: bcfa94be955ef263d37918ef4b8f898ee8964c61
branch: eth
