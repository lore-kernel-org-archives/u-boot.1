Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE946D42B82
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08EB58946E;
	Tue, 12 Nov 2024 14:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aMeBz6a1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D44F89467; Tue, 12 Nov 2024 14:59:51 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 126C48944E
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:59:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-83ac817aac3so238460239f.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419987; x=1732024787; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=REsVh+x8BFaXgK5WDaMptVAYtki23vGmahlsFPyj1aA=;
 b=aMeBz6a1jcgpIIXI0IhUKywgu3uY3+mcTU/i1vqyY8m5tX1yMoFNKiVfnm5Yg2Ll9W
 sa95Lf+/QP4+/D43eGSDH8rkubmG3h6SOGEH/FnIY2OF3L9DN5eYzy202eRtmNuGp6oZ
 U+K+i50i6qWAxeShd6Hhu2GKUxjr8iQCSlQDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419987; x=1732024787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REsVh+x8BFaXgK5WDaMptVAYtki23vGmahlsFPyj1aA=;
 b=s3lcmwvkOXRUdS6nDhWdOtH61jhRHbT7BLJNYU7pSXWw7tGS7oTS9u/KWbRsCzI+5M
 uFDyKpNN3PA8h3rr8ejjdc7BCn/ll68ZNjqPPaKqK92fn8mfbPC+KbYTt1IMAlgxGY75
 2v5dM2OG84tOhQfduMTOBuK8KQ+GvsKnnPtaForbRuVR3MNVx4x+SmL1MA7tUIQLIF+V
 kVv68iab8h967Lm5K3WIJ3oPkQzPBGQFr3oq11kMN1zDIDTY1jo9Y2kzHZ+ZQwnSSJ3e
 1dzszuFETYLcjiNIBMbiEagmR0Zupt2s8bDYxmpaNvjOCOt+zmoXjVtP4GN/Mt2JsA51
 FpdA==
X-Gm-Message-State: AOJu0YxHAsJNZYFd+O6CkDcwmp25cIzctNHs8y/0kNPqz0xfEU7nEAre
 oypuFa8kXa3JnBJyyZ73iDxOMK+7fl/1OdBBGIfxZPuRUeXtQyEilvDPFKmOhbTtqKNQJTJdGQY
 =
X-Google-Smtp-Source: AGHT+IGRL/FPb/4ZwV6Gc/r13vNdtx/J6r3cLjyYS2NyBMJ+lfvBu5qwHX22RszJLW2Zc90FeUb+CA==
X-Received: by 2002:a05:6602:1512:b0:83a:872f:4b98 with SMTP id
 ca18e2360f4ac-83e43175db5mr310126339f.2.1731419987256; 
 Tue, 12 Nov 2024 05:59:47 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/18] x86: Avoid clearing the VESA display
Date: Tue, 12 Nov 2024 06:59:02 -0700
Message-Id: <20241112135911.630586-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112135911.630586-1-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
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
2.34.1

