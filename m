Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E84DC28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 01:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63E328211F;
	Sat, 15 Mar 2025 02:29:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MZPY7F35";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60F1E820F5; Sat, 15 Mar 2025 02:29:11 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 392848213E
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 02:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6dd420f82e2so37131086d6.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 18:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742002143; x=1742606943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uylKCW8WLXEv0oXHujS559HH6BZlXhwlrtLB1+kRH5M=;
 b=MZPY7F35XPhk1haUszPSxLlwcfS7BuWV2y9BtPbTTdsc0rOZSpMJVDbwWHcHjSHVZU
 14Ufgi1EIj5963jeHaIA+ao6MFxYyHgyBhBTk2bsectnIygCJcSftBDYSGa6sfpiqpmb
 kR+dFKFyV89LOylP0QWSRd0JS7xhMnutbbxW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742002143; x=1742606943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uylKCW8WLXEv0oXHujS559HH6BZlXhwlrtLB1+kRH5M=;
 b=H4/ZN7qPtQ+SFaHGSmfi4qYSVeU7eI1RM8Ux3DQ/liWzzvNqMspBpylgv5PzOFj0ME
 Kpw7IbFmx0qlLtOO3+zOEPnr2HqRjvxZG+NtezJORw4Ksv4SiXuX0MKhoKQdw0s9nduO
 8nnjF+VtTAeP8S1Kxj2sWoQKjbQF2p/QrhSfZF9WjL4tZZeUinFe3QpVdbXoW/FT7FUq
 cNVPRNgHQAVeirMMUE9hw81acmVRqli6/NErjjiox4bPxDJF0rHn92ccFAF1vVJpt5QJ
 ILbbNQlk3Es7ftlshFcAixPQFMCLVw8OzdQP8kexoxE4WIRCQfqjde/8cvIwVs+ySJB6
 TFkA==
X-Gm-Message-State: AOJu0YzW9yhbX3NOnpUcx6nlHZqr7UJkWQ5gzLGcaRraYVQ5JwHcz5yf
 7w4fk+Q/zt7Xwe6dyscV4OAE6gI3KEox/IoHagFkyTd0YgS/FRLmdgHk/yPRqv3UeGexBF/urB9
 D
X-Gm-Gg: ASbGncsk5TrIyfb6nuMNyU//LA68Rr00/Z7Ofr/FEND6vrixpCTiRcdF7Q20zFXoAEu
 12gpaFSgy1VJIsGOvb4QLZiLwUl95QRSXxCp257/s9NkgJEAX89v8RqqpLUtylnvC7HRp2WxMy/
 /Y0Fy9F2eApdoQmkFNMsFjeQIAbXYi+wpNuHP/pfVXfc3SJhVE24uPIuN1tlMtP8i/JywqN3ApP
 WOQUBurQOHcerhH54GaIlXaKqkuOtsNfPygMWKmEbE7Kt2uZTu3VwDRLs6y6WuBX7XIEGpYUYNj
 ZKb7HfFY4ZIFeYI99UkbkLvTOpnHGXhfqpwnlZTTnrMSYyPj
X-Google-Smtp-Source: AGHT+IGUDrDk64PvX+bH34jfC+dFLmIpXjWxsVQBVotqgs3BMR314vvaQ6UISfYXVTGd7XemT6BItA==
X-Received: by 2002:a05:6214:1d2b:b0:6ea:d090:6365 with SMTP id
 6a1803df08f44-6eaeaace24bmr59487426d6.32.1742002143139; 
 Fri, 14 Mar 2025 18:29:03 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade24d030sm30430876d6.53.2025.03.14.18.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 18:29:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
Subject: [PATCH] ARM: socfpga: Drop incorrect imply
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION*
Date: Fri, 14 Mar 2025 19:29:00 -0600
Message-ID: <20250315012900.399381-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The use of both "imply SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION" and
"imply SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE" here is wrong as
those are both part of the same choice statement. Furthermore you cannot
select/imply something from a choice statement, it must be a "default ...
if ..." construct within the choice statement in question.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cf08fe63f1e7..071fbf1fb202 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1163,8 +1163,6 @@ config ARCH_SOCFPGA
 	imply SPL_DM_SPI_FLASH
 	imply SPL_LIBDISK_SUPPORT
 	imply SPL_MMC
-	imply SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
-	imply SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
 	imply SPL_SPI_FLASH_SUPPORT
 	imply SPL_SPI
 	imply L2X0_CACHE
-- 
2.43.0

