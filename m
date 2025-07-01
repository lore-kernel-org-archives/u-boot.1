Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81599C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 18:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E578682F49;
	Tue,  1 Jul 2025 20:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k2Yx4Euc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E23B882EA9; Tue,  1 Jul 2025 20:42:57 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A715A82F49
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 20:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-40af40aee93so3840392b6e.0
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 11:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751395374; x=1752000174; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JZkuW7F5L57sgLogb4Rv7/4k0/nCwnmTDEIFd4HsB/s=;
 b=k2Yx4EuczpdfPNsvwErrCbMez9hi6IQGYtNlk+nM6oZAaigqg1M33Jy5ZqNS2HxeZr
 C1mdJ9YNcaEbWowR2Zm8IF9nHegn/MN3tcVDWxojQImezMR7840aF8zsrmLWzALMZJmT
 G5hNzhUo4uMe9PlBeRTvnTCZgHaLmk3k1VOiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751395374; x=1752000174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JZkuW7F5L57sgLogb4Rv7/4k0/nCwnmTDEIFd4HsB/s=;
 b=AmKcwteQBIksh0pdkUcCo8kP/TwUyGsEnFvNqhTiNtifDeFMZdMZAn33nGwWZprkpf
 OlJm2YCh7yF+I1FawIgXpqvzQ10SpsFzCuG05ztRZRjoGaOSvd9bEKjnRrhwGkewLlnT
 u6QNgrkHSfDWMYLyRM1gJF19DVcHmUVf7QR7hmgrU4cl0mWojV4PaZkCcST+4UOo5jjg
 eAnch0VHuKZLOS7eR55gAac7XyXwZZTUoNE2P2gn/Rpf6FpVQdTP5q+VSKCO9ighiE1w
 PGSXBb+qGd5cLMmpJaDCY0XGlBDFjJuzZZx8VVdqUrYeI0VX8ZKilqX+T9RChHV+li6I
 gwTw==
X-Gm-Message-State: AOJu0YxlLIPYREvt78gF/kkRYjaD+ppW/p2fK8b+SHR4LXGaJYT6eE4h
 pHIUpUIdGA+FbvzB7mCGiGzbJ23xmJkpTQzX/onMb0llh3EBmxeLrkEhPAxMiuMaCXkHoOwnexZ
 aF3/m75Q=
X-Gm-Gg: ASbGncvxe/QF/2JkejkNe0vZEBiRrozMMSkJyNhVGqsAQFv8p1HVz07fJk3ZMyJm//3
 LB4WpckrQIxqfyA3nRjkX43oNuQTX9xr5Exxg2b7+s/HT7EP19tDMXvLXZISM+f3C1TLN+HDdLQ
 xlIkWrgOHPZM++WKCTSFV3AFs6ywztuhQm2F9U0AW9OWzgmWr02crfEgdkZiICINuTV7M7Y/VGP
 CFDfcxUWeiu8fHZ8aUqkQ2qLmrG/UffCEaRlaZTPODTkrx9hiJMOiqG5njLhxlqOdSytb2dXDW1
 qnCYa2NMbJ3UWyF0mIqOPY31dHUUQL+6Lj0BlNtizdSoh9nqXymSkZixW2o30lwkb+rjh/BZKcC
 mCIucbQiknJicT45eQG8BrLCvdA==
X-Google-Smtp-Source: AGHT+IFWbdefKvJuXBnCSLOTdjP2gwhI9Fes9+wcGMAssAMXimEcLPIXLJz7j5od29Pt68bg9nO0TQ==
X-Received: by 2002:a05:6808:17a9:b0:401:2e2d:cb54 with SMTP id
 5614622812f47-40b33e649cemr14316076b6e.29.1751395374196; 
 Tue, 01 Jul 2025 11:42:54 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b3243e189sm2239234b6e.49.2025.07.01.11.42.53
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 11:42:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] power: Correct dependencies on POWER_LEGACY
Date: Tue,  1 Jul 2025 12:42:52 -0600
Message-ID: <20250701184252.3191485-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701184252.3191485-1-trini@konsulko.com>
References: <20250701184252.3191485-1-trini@konsulko.com>
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

The POWER_LEGACY option depends on not having SPL_PMIC enabled, so add
that here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/power/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index eed65058e667..fd1c871f0dbb 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -15,6 +15,7 @@ if POWER
 
 config POWER_LEGACY
 	bool "Legacy power support"
+	depends on !DM_PMIC
 	help
 	  Note: This is a legacy option. Use DM_PMIC instead.
 
-- 
2.43.0

