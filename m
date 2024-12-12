Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEBFE77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBFB280269;
	Thu, 12 Dec 2024 11:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ccRZXbpm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CF9980214; Thu, 12 Dec 2024 11:21:33 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6661D80141
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa69107179cso77868066b.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998891; x=1734603691; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0dciG/B6io1KT8uJfWXG8NdwHO9GG90j444uif4697s=;
 b=ccRZXbpmHcYh3yCVV9Fh8chGcrg4HxaKZp/yzrGLERizkdmLP3m+fY44VzrFknscml
 nrKRWuC8n7es25L02Toe9KBDFz6qHq626nqKtcxhvS5rfWlugQmNryLVfESp6qHpiy/i
 TMyKdkvaIlPJr+ixQtd+UbyX07G9vj28wjCE3lZMJnuwV/BAxB3QDyJxM3l1Ucpn8aX6
 hKwhytOepyav6IlVa+j4noVZSdMPnmQ7CtcGohIwEjLibS3u8BQrqOBo/FAIdP0B89ya
 MV+xTrialy8olGG2gA7MY1Xr4JHbluCgwWmgjVHhDYE0WNXjMdywovn3RlpIqEfYomtj
 gtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998891; x=1734603691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0dciG/B6io1KT8uJfWXG8NdwHO9GG90j444uif4697s=;
 b=AmhC7D6Rve/HR9bmdOny7Rj+MADqDT5yuy1xiV7Bl6Y1SyYEoWdlwYHCWsTiGiGPE0
 1Gsj+CKJdQSMRhztPcmFeT8leRbSeMOIioPrwWGrdX9EzzUDLzy9hiiMpM5qoNXf3/Fa
 dEY4Mi9zeb4v6sS/4HUtHPc7Wx/EO9AXbVhlUqWMk3ZjhN+gPXxQeoV/NAaSwbM/aCUB
 KBBDCgcsJpGsAVFY8Cklf+XZXJrfYj6fGmL1MQGXTpvWVCCJ6afkiaw/nMqyOjXi8RiS
 wT5mZO9b+6mWbHjQqZjNmkCCDerLKQWQ/8yqNmQTgR29y9PXYkNqNww3eu6Dlpg/pH9F
 lqxQ==
X-Gm-Message-State: AOJu0YxRNZGnrnuAMn2xFWHVIankMNUrEVc1YtCxgKSX68YqZUksu3Dz
 cG0s21Nv4KKjBAB74MUN0eFOgFYJqYqhFxXPeMhMcqlsa+Rjq2yk
X-Gm-Gg: ASbGncuEKb/yr7DQ+42i6AsSC6y7zKALn+AiAcmuM4u+vSRvWj5+O9q1M6YdeGTPf6K
 AHUuRBkDPPcL0PLm9bj9hYUnLPHwQNsiagjtbh0vafUZp8pWyxSyKLV6FPUqphlpE7ZItghmEVw
 DW+zos5G1Hsq4s8NXkjV9SzNPHiGMPzQghvHpbLoIQ8Rm3VMUCHfoTparWNw9aRE9xkDlndKm/G
 Acs+qtLCD9LlHTFepClh1AzIu6OIHTeI9iKHSiaNxX1A4ag
X-Google-Smtp-Source: AGHT+IG6n6FPhYpYWr6kasHkpMaWLHBIfHMXAXAMKkyanDHwRF2gMdnLAVpm779pulGiPLy3TfXHsg==
X-Received: by 2002:a17:907:3a0f:b0:aa6:a732:212b with SMTP id
 a640c23a62f3a-aa6b13db76dmr581838266b.58.1733998890689; 
 Thu, 12 Dec 2024 02:21:30 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67d6fcd3dsm646818066b.80.2024.12.12.02.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:21:30 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 03/12] video: tegra20: dc: remove excessive headers
Date: Thu, 12 Dec 2024 12:21:10 +0200
Message-ID: <20241212102119.6466-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212102119.6466-1-clamor95@gmail.com>
References: <20241212102119.6466-1-clamor95@gmail.com>
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

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index d54279ebda1..54d60836b66 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -10,20 +10,11 @@
 #include <fdtdec.h>
 #include <log.h>
 #include <panel.h>
-#include <part.h>
-#include <pwm.h>
 #include <video.h>
-#include <asm/cache.h>
-#include <asm/global_data.h>
 #include <asm/system.h>
-#include <asm/gpio.h>
 #include <asm/io.h>
-
 #include <asm/arch/clock.h>
-#include <asm/arch/funcmux.h>
-#include <asm/arch/pinmux.h>
 #include <asm/arch/powergate.h>
-#include <asm/arch/pwm.h>
 
 #include "tegra-dc.h"
 
-- 
2.43.0

