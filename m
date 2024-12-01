Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD35D49776
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5595989471;
	Sun,  1 Dec 2024 16:25:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BqWMz1hl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C7D3894AD; Sun,  1 Dec 2024 16:25:29 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8234689432
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:25:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-84198253284so111248239f.3
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066721; x=1733671521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tw/Po+MoVeCInPVatEY5bglYg4JQ8jM92Mt/Y0ope/E=;
 b=BqWMz1hlW3PyPluYJo9T9SK7Vu4E3zCzRazrVP337Vg6/vEcVIsVqYao3G40vvfHaT
 uBsEr7+AXilo4W3xN9eYOW3HmvstfXx3hxaNL0lmBJkguxTHSXtopGGcqG4dY7wBr5Ap
 HV++0LLIZDTOwThi7GLSJ8OZTwp39tlZxBwaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066721; x=1733671521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tw/Po+MoVeCInPVatEY5bglYg4JQ8jM92Mt/Y0ope/E=;
 b=ZRHP23GBxzeY3ZcRcz71C04zwv+xKT+0+3j+p05ctI8kc6dZJiGRfLLXKVMYzxOSiZ
 Eo4S/ri8V0i8izmWzhWTvqKbG8YrY3vcwafBG2ijAwZGktqJWZwQ0XJC52RT6L2DxBvd
 tZP5mJ9dLMOrggUcfBaZOPqtRTAyDJ5cJH2LVal/O10OwF341IbLtlVHfvHWrIFUCtXG
 J2J/XsjOP2nwLjQqP7lGe/KjyOl+csWJk4SXwSPsZNO4GpAFLaZvAMraEM4zyDJlZ3Uq
 1SgUnQ6oAF6pzBM/kDj1qL9fRuVyZusMU61j+BKisvNsvLKy9j3zU8RGc4bk0hEJXf4s
 4QUg==
X-Gm-Message-State: AOJu0YwRY/9X/ZkWAxTR5T4nHSKaitdPilUoE+ihT/AqYS5EJz6DBQfs
 8TTtOVOMnKwiZJ0ScWCV0+hpCeoTE6D1J0ZW7KQUfehp3EjcKwwEjLKWytiMBGxtqV7FRfY+4TA
 =
X-Gm-Gg: ASbGncuyMSYIQU5yyVx9McuRypwx7RolnbgI5lZ4hrb6HiqGYrsPijobzG5/9LOCHwh
 P8rICVjbV2gxCuEpGKWjqobZtA2uCKgexvWqUJonAGoS8hDZBpHqAv/0D1NTBwG8t7sEuQCAj/m
 0/XSOz9rcTDYdrMXoD77B8l1ejArsCGg4w4a5xoGelgjh35AvZXQSFU19ZNl5H/o1UF8TYygiZx
 2CgSrU5furqX67cQ86LCTS/Qu5QZdoS0gwzWvFiioiD
X-Google-Smtp-Source: AGHT+IGXdkV1woFOtHGW7qrxQP4xlRTfR6YCGqY9RFcBcYaY2JGMmGrqkBfQBYzvi1GKnKHBzRsRfQ==
X-Received: by 2002:a05:6602:140f:b0:841:9516:4e2e with SMTP id
 ca18e2360f4ac-843ed0b7569mr1821978839f.11.1733066721469; 
 Sun, 01 Dec 2024 07:25:21 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:25:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 03/25] efi_loader: Drop extra brackets in
 efi_mem_carve_out()
Date: Sun,  1 Dec 2024 08:24:22 -0700
Message-ID: <20241201152505.1666789-4-sjg@chromium.org>
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

Simplify a few expressions in this function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index f1154f73e05..3b1c7528e92 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -206,11 +206,11 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
 			     (carve_desc->num_pages << EFI_PAGE_SHIFT);
 
 	/* check whether we're overlapping */
-	if ((carve_end <= map_start) || (carve_start >= map_end))
+	if (carve_end <= map_start || carve_start >= map_end)
 		return EFI_CARVE_NO_OVERLAP;
 
 	/* We're overlapping with non-RAM, warn the caller if desired */
-	if (overlap_conventional && (map_desc->type != EFI_CONVENTIONAL_MEMORY))
+	if (overlap_conventional && map_desc->type != EFI_CONVENTIONAL_MEMORY)
 		return EFI_CARVE_OVERLAPS_NONRAM;
 
 	/* Sanitize carve_start and carve_end to lie within our bounds */
-- 
2.43.0

