Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2FCC282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B4818141E;
	Thu,  6 Mar 2025 17:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Oci/bZE4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6343805D7; Thu,  6 Mar 2025 17:05:11 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D6EB8141E
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3d03d2bd7d2so7098645ab.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277107; x=1741881907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALveOlJ1YYPaatt9hXqXziYO3Z3wJwBWWAuV27HIJfw=;
 b=Oci/bZE4jMW9RAz7YsKIfCg3Ei2PtW3e6VQQdsP4Hc0UGMkQI02OVb+aBT0noOmIWb
 3pIXWIFTCr0fUn6/peQ1QJGrjzoBjHwRIHrA5B2nFRgHCZwPlaaaCObnC6vbhLAQKciX
 fyNxTOLtk/at8mWzaFBsY0MHXc0gF81PQVtz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277107; x=1741881907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALveOlJ1YYPaatt9hXqXziYO3Z3wJwBWWAuV27HIJfw=;
 b=YW6W0mYGuyEB+wwKw+lTU+ZpWa3aXzBNBu/RR8sQc+lG4Wc0toFtJhd/EYQnkrOshl
 4cflYm1G3jKsvOub/QQfJt/m7K9T9MKrAOexlNSRfAI7dhGowho8YXu5zwGs6mxR6472
 q36xvaQU2zkYuhVN/177x5SPl83mITT5Hndvl/+sldF4Idq8OsDel16KTu8UUO7pzHoR
 RDyGHvbLYpEgTjOqocElOrHM1NBRKd1wukOU3fvHlYvsZ30F+2zm6lWr+GdeI5KmoPeZ
 ek4idD1GJgLX+f3WoL+ZXHiE2AmQ6BYPA/V3kK+kpvkQIKfro6IGjRoFogJumAsbnPf/
 /wzQ==
X-Gm-Message-State: AOJu0Yz6qHSqbsAgiw8bUqEmtNCEZz5epwszQ7eacgjYrkbM74Hm0xSL
 44mqx+u0bA0mbeI9tLst9UTM8s7uJY6Eesu7OL21GZyXi95fZBOOT7qjV6WP7tDmAu+Jz8I/ucg
 =
X-Gm-Gg: ASbGncvlKGBmYNPE+0u4jSTDeNn4TCnF56Y8g5DaGUcxmzmO/TxjaXjmodlqHbenLQV
 WcIDD+dZ4k5nRWtvWrTujvxlaODLKmAq4GLb7vu06dy4+d2wbtkNjsc8WY+UqFkZTfUB2prpC8I
 xwhZ/PWPQeGaK4562cFXRyt28UyiASV+FNs5Ibiw7iDQEv6laQpemxWibEwOozMrbNShKzIK3cx
 j1Qf/6H56nsezKPipOABC4NgG//sCpO4YMCXiPJ3/DX9fnPRnwxN7dHPQtOw0aW1zAjlMm5rLAI
 apdgr6R65szY9EFa/x+KfvylxdjlB4LckbY1PyQC7LG+FkMAiSuW66Gb4F1QNAzpmRN2aFaTqph
 VnNR80g==
X-Google-Smtp-Source: AGHT+IGEfNKjcbNa0q6S9wqYiuptvv0nCwy97C034ohvlpQ5E5edBJcqMQ0rXMi5cp/rrY2NmReiRw==
X-Received: by 2002:a05:6e02:164a:b0:3d3:e3fc:d5e1 with SMTP id
 e9e14a558f8ab-3d44187b924mr975335ab.1.1741277107442; 
 Thu, 06 Mar 2025 08:05:07 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 10/47] x86: Avoid clearing the VESA display
Date: Thu,  6 Mar 2025 09:03:37 -0700
Message-ID: <20250306160428.3041057-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

U-Boot clears the display when it starts up, so there is no need to ask
the VESA driver to do this. Fix this and add a comment explaining the
flags.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/bios.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/bios.c b/arch/x86/lib/bios.c
index 5dfe5a647eb..de4578666fb 100644
--- a/arch/x86/lib/bios.c
+++ b/arch/x86/lib/bios.c
@@ -231,7 +231,11 @@ static void vbe_set_graphics(int vesa_mode, struct vesa_state *mode_info)
 {
 	unsigned char *framebuffer;
 
-	mode_info->video_mode = (1 << 14) | vesa_mode;
+	/*
+	 * bit 14 is linear-framebuffer mode
+	 * bit 15 means don't clear the display
+	 */
+	mode_info->video_mode = (1 << 14) | (1 << 15) | vesa_mode;
 	vbe_get_mode_info(mode_info);
 
 	framebuffer = (unsigned char *)(ulong)mode_info->vesa.phys_base_ptr;
-- 
2.43.0

