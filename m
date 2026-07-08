Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DCCC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1A3F84A8D;
	Wed,  8 Jul 2026 19:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jzfac44M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF5BE849D2; Wed,  8 Jul 2026 16:57:03 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B60684994
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 16:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ccdb73f0e1so7972085ad.3
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783522620; x=1784127420; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JqkRa8/LBoS/biuL4llxook8+65SiIG/lfptBCWldc8=;
 b=Jzfac44M1Vy9kxdYwRhySpg8PU6J2LvzpXvJ/nK+l2xKs6fmRCO6Qn309KYZ/TT1hr
 Zhas8aZS5d7XR8nFuim48u/wC06kBJKM+7qxCuPAHH6yKQ8zNN6AK7UPogIx2jamHDg5
 M7qhJikcXGF/9p6uFB8yCMK4OfpKLT5H1CkrZH7AXroZPf+y3Q0hhuxZvXNLwEGZ3ZjR
 5a6MRlE76MSRYVXVUuYGeC3uJLCD9BK5lug23lsN8sx+2jVwyHygdMCmxubCWNYetAQJ
 5OCNaJYcMF0s03ePQFYuMUD9b1QzkMQMBLkoJWidPf3x4uLFoC/ZhFeVnIdU2nkSfTL/
 2xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522620; x=1784127420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JqkRa8/LBoS/biuL4llxook8+65SiIG/lfptBCWldc8=;
 b=A0nK5+3owHjIs+rrQ5eRIK7VvuuElG2pcCB6oVVM3LKc9G5HNCXdcAZTPDD6Np8e71
 MG30sq327iMpiTfqizj9kh9VdcWvityrjUtvZ/uYxRs08siNOInssPYBegl4q8geIT2p
 pKyjJFSHmRlQdO6jgqAjpp3jCiM+LdcjWy5NCdi+PCIQDHF6KtRZO87hDDrI0+o7xXMR
 CHxLOtjCTJFg721vcSWsBk1fmPqWtbJMSgMSmR+iquYA8NM8xmALoPz7lsuhB/gZEir5
 8k3shGytE1jGVhtLnouADB9b90kjwJm4EAvdCkPyMOZH+R8+qkFe0+DbGvth8rNBxk7F
 iXzg==
X-Forwarded-Encrypted: i=1;
 AHgh+RopUNL/YAFut3aaELyKYQY2eHNW91drKp2Pn7JFsOh8VqqQGFWG74PF6zZYGPcFDZXUJhyadKo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1zqFV/NLMFao6glZAPL8eDgQa2t8hz5JaN8eZ9kmMu5pwsVEB
 wroIx6rmdPDQu3japevm6sbsPo4VOlVzAHBxIKFZ9NuaGkHMqOlBkANaaHmu80ZRjjo=
X-Gm-Gg: AfdE7clJmnMHc4Hys4yc6DLrNni3yh3yafyqnDkMz0LrUbdMCXlWI66n2K/9qCrBlGc
 +t+SSvt/Yg+y8YvhZk7z2LoTck4ePrbozcKwuSVklUBkDFyJRy2CgwNWPb17WTGe+4Pj73I6Vzm
 2EsALeVhXUyFx7JFp1b2cQnYKqogqw+WlyRlb40uyzrqdXDrdvLyE1QG1N4PUomvHB2yqenqAji
 a67j1MOQp5sT/gBM3D4CvpXVRxKovN2sDZyxJC2QjirZvvQhVHrPjtzriTKW6xH88h+wUbybITR
 6GkYFchzOR1z524FYTHvaXAx7A7R2m6sBeUTHJoCT6zyqjxf/z3J+Ru/sCWCuFMqB4jNDGz5gaA
 lyZLXao68+tnY4TIP1C3fLd9m3Sfapc6VjF49D+kZOay5QODlHL8IsODrILYrC/a36o+XYwoFpx
 B7wCutyg==
X-Received: by 2002:a17:903:2307:b0:2ca:6d2a:871 with SMTP id
 d9443c01a7336-2ccea47c7a5mr29164875ad.37.1783522620156; 
 Wed, 08 Jul 2026 07:57:00 -0700 (PDT)
Received: from Sun ([240e:3a2:de2:fc10:e8b4:4f4b:5cf5:26b8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d1e279sm29449365ad.45.2026.07.08.07.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 07:56:59 -0700 (PDT)
From: Ssunk <ssunkkan@gmail.com>
To: vigneshr@ti.com
Cc: takahiro.kuwano@infineon.com, trini@konsulko.com, u-boot@lists.denx.de,
 Ssunk <ssunkkan@gmail.com>
Subject: [PATCH v2] mtd: spi-nor: Add Dosilicon DS25Q4BB support
Date: Wed,  8 Jul 2026 22:56:48 +0800
Message-ID: <20260708145648.329-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20260614134406.542-1-ssunkkan@gmail.com>
References: <20260614134406.542-1-ssunkkan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Jul 2026 19:36:50 +0200
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

Add support for Dosilicon DS25Q4BB (256M-bit) SPI NOR flash.

Link: https://www.dosilicon.com/resources/SPI%20NOR/DS25Q4BB-XXXXX_Rev03.pdf
Signed-off-by: Ssunk <ssunkkan@gmail.com>
---
Changes in v2:
- Replace Google Drive datasheet link with the official Dosilicon link.

 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 31a2ba4..0a63e50 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -87,6 +87,8 @@ const struct flash_info spi_nor_ids[] = {
 		    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("ds25q4dn", 0xe5301b, 0, 64 * 1024, 2048,
 		    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("ds25q4bb", 0xe53019, 0, 64 * 1024, 512,
+		    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
 #ifdef CONFIG_SPI_FLASH_EON		/* EON */
 	/* EON -- en25xxx */
-- 
2.53.0.windows.2
