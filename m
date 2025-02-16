Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA6AC021A4
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C95D80F62;
	Sun, 16 Feb 2025 21:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OV0cJHUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5081580F84; Sun, 16 Feb 2025 21:45:22 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 650BF80F62
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-85517db52a2so69945439f.3
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738717; x=1740343517; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b18O0mXBGODv+uK2kOscdQzbGBpYEBF3/6yNBnZfDEs=;
 b=OV0cJHUNCKoy/Yrt1A3g8qcynEAdBE1gt63Jew2eDlkeG823Nt4nNif0ulkTtB0ydx
 CcRF1PP0NmxZbyqF5kBKc66RIOMbYS1CKdOyorY8HbNT/vz8+/qUwd5hknmEUvcm8MEH
 2VvTAmfoFB3Od523Fz0lD2Zcb+2/dYrGF9WCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738717; x=1740343517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b18O0mXBGODv+uK2kOscdQzbGBpYEBF3/6yNBnZfDEs=;
 b=PFlE3+avM1ziV/yLdDgVUD0SDwswQovl5YiRywIA3UuOFKEG2/93VRfLDRTuajrFpg
 l8C9TlBsl89CAWMSDbh0rt/UKrpyAFwMpoX199fh/fhLYZi+axbkk/9vGFjhfsVxL9F5
 whS0wPdY4c80BAE5uJFS92FIqS9zVzdNZkDminQ6qRaeFhQi5VZjGOaX1Nv8cYvigsUj
 5oRezZLHMGB+cKnKs+QcQPxnRE2NW5H40NZvkIuXhPHjMUKK6nz/ZTZFhqUjKqOBZlpv
 rCN9zOcNLu88g9ddWrPVDNGcMdZROkCZscHqie+bzFVWW22NoEs5w/IsAGN06pNG+83r
 kmsQ==
X-Gm-Message-State: AOJu0YwV+hQLyHt4x2jOsqm9CNhdCDSJdKIEkXJevwNYDKTv8wuHtTy9
 g6RXfmh7T2IOWjWOJ3yBBGU9GaRURjqhN6Cor3gMgtdc69Cp7RAczVYIMKqLJo0Z8BX3nnyemiw
 =
X-Gm-Gg: ASbGncsKI7Shx/75LPFqQtPcATAnSPPvADfQTPvMb1fWzhjeyetf6SEBmdIxhIbcQzK
 EWtXCHny+V+sGtsSkf9TnSqOCaXiG/EHgOK3psaykXol67cvEP7YiImxi2gQa/UHOM1GH7R/taR
 tx9FNdXbibIrIA0tvVfA+GTq61YfFvH+w66mIZcs2PUGsolHcRtsWWkBS4/Pkv4c6xm/uUNVbzl
 /eH9cAgHrnuF0njDDr4ymzFyk+GKElKTSWlwGVDnx8GWP+mZP282fLbjFKDRC0F8gohsXkveWpS
 UiVA7RSUTU0UHZ9DudcxVXxvy5Nfi1WRedfac9MLCV1E+dHiLD6z
X-Google-Smtp-Source: AGHT+IGmO64t7jdGvBcEJEG5SlwQo5oct6d75gg3QFRVsuX5XJeJb8pV2ylU9kTQnMeAWXP6BsRLAg==
X-Received: by 2002:a05:6602:3f8c:b0:855:3ed8:ee82 with SMTP id
 ca18e2360f4ac-8557a0fb4eemr596316739f.7.1739738717288; 
 Sun, 16 Feb 2025 12:45:17 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/28] x86: Drop the message about features missing in
 64-bit
Date: Sun, 16 Feb 2025 13:43:57 -0700
Message-ID: <20250216204421.3560012-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

This functions normally and has done for a while, so drop this scary
message.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index 47cf9c862b5..0a6a761987e 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -281,7 +281,7 @@ void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 {
 	int ret;
 
-	printf("Jumping to 64-bit U-Boot: Note many features are missing\n");
+	log_debug("Jumping to 64-bit U-Boot\n");
 	ret = cpu_jump_to_64bit_uboot(spl_image->entry_point);
 	debug("ret=%d\n", ret);
 	hang();
-- 
2.43.0

