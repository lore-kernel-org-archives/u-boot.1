Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1D2C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A924C810EA;
	Fri, 28 Mar 2025 13:58:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fwAl5xW3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A17281273; Fri, 28 Mar 2025 13:58:35 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 046AE8070C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 13:58:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac6e8cf9132so366476266b.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 05:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743166712; x=1743771512; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QJBLSmDO/7Aynl8ynNdXobDsaBhaWy8wXdnzhAEz3g8=;
 b=fwAl5xW3Kjy7vcmROs9D2E6czD/ppUQayJuWt2JtVkeYI/mYv5ADBQiwiWxYQvILKl
 Dwk9RzgxWet/3/xvL96XRCAXWqdT/k9elMT7Obgjxgl6ds76wwdLel5MFU69dvKo1ed1
 6ypvpmKq/BKu943uFcn0fD57ugRxUngQC8p6qtj/nqn/IEf5nFsW9BObGTQ2z+yIKbzv
 DfpHi4LSjrAJrYS7rhooFu1IOxKjNjP8pYs/QSRjTFf2pgCVvnMaVHNqufoXrfaAtYbn
 nO5svQcGI0mVDtr6u5ETmFoonq2j3gcxRm3BygZXKCSqd6QoGUWd8s1MPIYyfvw5udmR
 M1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743166712; x=1743771512;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QJBLSmDO/7Aynl8ynNdXobDsaBhaWy8wXdnzhAEz3g8=;
 b=CUV8FQ3ZzGKEMpdyYXwgPWEzOH1wCMYKrjndFrz/45yDIYDqwEQAPfe0OPNkfZfSPh
 bI3Gnz01NC5fRCXgVvuip2htgqmVChFfoe9besATidWGxvNBPuD70r/BoiHAWpJ6jkcj
 RU4/i1BAkMW6tQ85jZUc7VLy1H7NatI1cmjZWWH1Bp75le26Epqfhwovm6XjT8fmC99C
 M4wBpSrBFZhF+Pvhg0JbcXWZ49vV1F5eGeQMlUJHaSbge9hC5H55Nx8Ln9FpL1mXly53
 ivYL/cENk84/AsHazAcr3LX0qBhIdlGhvLC3ELAoXiXfBbahGFiZAQDaDA78yPseP4Zc
 vcWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4Syimsa5VyngM+l5tX3XI1HQzZtRaa4nmRXbkQTAnvlBjGgQsFeN6+UCKRc+pDbFxGueeAkg=@lists.denx.de
X-Gm-Message-State: AOJu0YwSM7FXM7RjXuYl468Qq2sJeVsBonX9Imq4QxVueR/9C4zDRe6Z
 WiuVsPEOq6jTXHjB0WQa2V84RoGS5iwwzPSZk9eW1z1cqOz4F8rcTMLfsU2bql8=
X-Gm-Gg: ASbGnctYspCkEmFen92aadGhNG6/Fx+e0/gA6gmYSeV8zODmmB7TtZmuDnNPKGyg6W7
 FiC3mwki942krKsIxqyQejhrbHFjdMy4R8eLXlF/hR/8fsVMVTZv3QC3r0Fne/DvP7Kg/8JupQ6
 4GS7WZRSEf4iFepmd70PnCar2fR7N/rtZ60rxYXG87FnVI24WDFA8eu9w3b+vZRVi3Xx4/GrHtD
 GYRKA7QRFFG8lSMPnuuBmtBzF2usfbP0qdqxM23LTS9ZBmooWymeX197YpcqssYhpgEMaDAwuUl
 ikhbJctlqBZJ6EC9OuTZKZIWM/Eo/ost/aXfGj3FKw6TttV6cuDR1PtVfGCqAvldZ1KzmjvS67r
 4fksMZIHkk2yey7WCDw68
X-Google-Smtp-Source: AGHT+IG6+MYDryQyF4fagMWLNB7Aq7b8/J37lPkF1+hOso1pfxS/g6QkI+TsnxVM5tvOMxXCyvlbQw==
X-Received: by 2002:a17:907:1b0d:b0:ac3:773:62a7 with SMTP id
 a640c23a62f3a-ac6faf1067bmr699843666b.31.1743166712391; 
 Fri, 28 Mar 2025 05:58:32 -0700 (PDT)
Received: from localhost.localdomain (ppp089210073071.access.hol.gr.
 [89.210.73.71]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71922b8aesm159547066b.13.2025.03.28.05.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 05:58:31 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Print extra information from the bootmgr
Date: Fri, 28 Mar 2025 14:58:18 +0200
Message-ID: <20250328125819.1080935-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
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

Instead of just printing the label, add information for the Device
path as well so it's easier to see if we are booting from disk, network
etc

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_bootmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index f9534ef85edb..6b9d809ff618 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -690,7 +690,7 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 			goto error;
 	}
 
-	log_info("Booting: %ls\n", lo.label);
+	log_info("Booting: Label: %ls Device path: %pD\n", lo.label, lo.file_path);
 
 	/* Ignore the optional data in auto-generated boot options */
 	if (size >= sizeof(efi_guid_t) &&
-- 
2.47.2

