Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E662EC021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:08:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E62AD80F3F;
	Tue, 25 Feb 2025 00:07:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P1eIEBPk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FB6180FD6; Tue, 25 Feb 2025 00:07:17 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B25F180FF0
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3d03ac846a7so16633965ab.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438432; x=1741043232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALveOlJ1YYPaatt9hXqXziYO3Z3wJwBWWAuV27HIJfw=;
 b=P1eIEBPka5OCSrJ+1TAsYZI+ojMEhMNOe8htCkzLO99g5vfBge+MX9dy/hIlNl7ODT
 wyED6tftJaEH7UX8IeoylrCa1Nxa68oAR+6tnleNq3obQy7iIBs6L3e4iQgg0mCpgjtU
 WYe5OdQbLFk/AOp4Eg81y5zLahALjmrtAAMEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438432; x=1741043232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALveOlJ1YYPaatt9hXqXziYO3Z3wJwBWWAuV27HIJfw=;
 b=sHSUfsDpTV9mRZsNy8OpFZQvX2cQUQqorbksJFLfX4JhEm5ZydLdXF5eg418l0GPMs
 MK7x86D/M0G9BPvlJ76tBvCxQfPko/ME3MtPD2Hc27lpDw+48BWCQKjHSko/8g7D8xjA
 iPFV4JV4HOfUXhTrkT5dfYwjYjxcXdytHOgfT2T+LG5O6nHmgUcZbPRD/xoq46hL8UJi
 dZhAvXYVAI4RxE62AFoUfzgQlBB+C+NNLphUKCLI4y8Ok6ni1fEQ8f5jE+Jo9S156vsk
 zi2I9BGJHUqarTDZC1HrefAZGsbcVP7KTUVQUTqxz3d08YbwLhi4WRa52o/B+LjP1QTy
 xusA==
X-Gm-Message-State: AOJu0YwYGk8rRF5yFh3WLLpm1fZdcmZptcHF3QE6QztvaiVa0dlqel7p
 4Q9MIlynBZb0O0zpRtZb3EAHqu9gVwYPjLSU2OsLm1p+wafW/nTvppmGIo+FO5YBBcr6omLEniY
 =
X-Gm-Gg: ASbGncuVpxbVaRsKQavJ1mWM4Gs+l/ULUsNWEhVbypKVNBmyJ8omp+aEd1emYa1TKqj
 L6zVMNy8A6WlhrXxBRSXyNtHVxCjfw3bUH/rAQCM9ao3PfCXx+bZ2OyO5wdJoakN6qN8V6brp3t
 lMViPy1LhbC12gW3Hz32XVd/ToHTOgtop+XsO1viaaZb5kkyZlQhxLePqJXW6gXKHMbr7MX7hP4
 mLGT09HEe+/XyEBVYZCo9e21eE+F4kt5ZTD9+u5AVbUDrxyXOg0GlK4wAMt3vJ7GDCafITHQKfr
 seZgc08W5JN9mOYUotmHZuUlVM1+dyQYdU9bUXUO4H8bltwLtBXE6g+Dy4HZEIk=
X-Google-Smtp-Source: AGHT+IF1xnnt3OpaeJc3fF/hcvi2Yq78Q1wd87MnKIElm5Tlz6NV8HAjd5AUaesOX6s0Mc5Lw+qkcg==
X-Received: by 2002:a05:6e02:3f89:b0:3d0:2fcb:e7f with SMTP id
 e9e14a558f8ab-3d2cb354a65mr153161615ab.0.1740438432557; 
 Mon, 24 Feb 2025 15:07:12 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 08/44] x86: Avoid clearing the VESA display
Date: Mon, 24 Feb 2025 16:05:57 -0700
Message-ID: <20250224230640.2665206-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

