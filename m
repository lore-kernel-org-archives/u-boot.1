Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CB8D4978E
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 00:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14989893A1;
	Mon,  2 Dec 2024 01:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i+SeprgU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EA43893A1; Mon,  2 Dec 2024 01:13:05 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D96A893C9
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 01:13:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-29e5c0c46c3so472504fac.3
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 16:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733098380; x=1733703180; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwl/N6VG8mCw60qwYIABz6Uc4puz5Q5Mi3pd0sm1w/o=;
 b=i+SeprgUI3E2LauE0rRbBtVTjnmeyAncEh7XDIHkpY63VtcPNOkPt/VNT+MtHcSbBE
 V5Oqhd76wUFlEPdopVdKNx7xWuYO1wqkSXRhNNoCDxze+yOHRK6IxiajXsWfTx0SplWj
 vVbWvrzO0zsN4N1R4xK1ubabmn+cCiuEJMxD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733098380; x=1733703180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwl/N6VG8mCw60qwYIABz6Uc4puz5Q5Mi3pd0sm1w/o=;
 b=rTerVd/juL4FrErLros2kCAVvIXS9aY/LfTpbEviWG6nrT2A/jTH+FQy4k17s99F2b
 zmHen95BV8VB1lDh2jw32mVC1m25zZXv2ppztyOz5O3Auo9ea3gJjUbIrz6i5rVBmew6
 PtZX+BQNL4h+/Kgk3DiUkY9hrYjae+skZOcuVGu8W98t3RPtzmTjz1plJ4k9JpLctyMl
 3Haq+JseWT41rAR3BDi8NJnYqI6Tc/L51KAK3GJ7Lu80bWe5+Em2ZWh0QbSzfYD0fM8A
 Bs1W7GLKOEh49wpP09TubKGX200lJma4adhZWkWwYKkYktBXn5F2plNH40ZaK52M7wmy
 PMMA==
X-Gm-Message-State: AOJu0YwN2mPuiZYTV5e/CaF6w2i24NjDNr4Ib4Bee0d3yGPF44zgXGeu
 yEJWHt+NHTFKuCqJNk/IvFxwiToVP/FPvBaAYif9lqNhS6ZjCn1cRvlDheRTLLXo4G/NW+FtWTE
 =
X-Gm-Gg: ASbGncur/s3lxDgNmyOH+k5Yj13L3YCa6U/TTwa5i2OsoQMRDCDGnQFe8mHxTjfe5fc
 la712Cr1SnUygopA2oPINKWCosMY6Dcg8evDv2EWv6q4RKnoxe/fU0tRhXpqOdRwB6paXKsMCaQ
 QRRXtOxcKRcPm1jfdrfdTfrOJrIoi3D25ZK7sYJT1XTiYQulCjNw18dxbbkp1sUGxc2YOVc21iG
 vqyi8kQCjYfPjReK3V7ckMk1FhjzCqcCjkAU+4R2QwEjw==
X-Google-Smtp-Source: AGHT+IHOg+SeldFEhzxl2VF+4BytlJJi/ShTVWcRvdNBoW5VEenbCDGrAfOPFUT5qY8MfqUPQ22EzA==
X-Received: by 2002:a05:6870:3d87:b0:29e:5e7b:dc15 with SMTP id
 586e51a60fabf-29e5e7bf592mr1726994fac.43.1733098378653; 
 Sun, 01 Dec 2024 16:12:58 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e6ef90f5dsm14615fac.51.2024.12.01.16.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 16:12:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/7] efi_loader: Create the log on startup
Date: Sun,  1 Dec 2024 17:12:39 -0700
Message-Id: <20241202001243.1283274-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202001243.1283274-1-sjg@chromium.org>
References: <20241202001243.1283274-1-sjg@chromium.org>
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

Create an EFI log when the EFI subsystem is first touched. This happens
after relocation in board_init_f()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_setup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index aa59bc7779d..468156db813 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -8,6 +8,7 @@
 #define LOG_CATEGORY LOGC_EFI
 
 #include <efi_loader.h>
+#include <efi_log.h>
 #include <efi_variable.h>
 #include <log.h>
 #include <asm-generic/unaligned.h>
@@ -186,6 +187,12 @@ int efi_init_early(void)
 	/* Allow unaligned memory access */
 	allow_unaligned();
 
+	if (IS_ENABLED(CONFIG_EFI_LOG)) {
+		ret = efi_log_init();
+		if (ret)
+			return -ENOSPC;
+	}
+
 	/* Initialize root node */
 	ret = efi_root_node_register();
 	if (ret != EFI_SUCCESS)
-- 
2.34.1

