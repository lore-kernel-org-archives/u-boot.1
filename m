Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1B6C5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:27:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0ACE83987;
	Wed, 28 May 2025 10:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jk1aisrg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95B2C83990; Wed, 28 May 2025 10:26:08 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CF2083956
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85b41281b50so97497239f.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420764; x=1749025564; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mYnTTp5icbLCmOpWUoNMQRqJJuUYJe4jNyQJYKC0r9E=;
 b=Jk1aisrg3CSmV60pdho4yaDMnuy1P//9onjXdXoPuuKzjm2gBalHZEnTKjqt8dBI8U
 BXd/MPeAmziBEaYKpaSFQHDxdeNb91GGr//1Sdq1YeHRz8F20SpK+P2DxxLce3D5B/KR
 OaPCI8YWcK1Pq01rRF2GrwGIuQ0tXmnyv7vD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420764; x=1749025564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mYnTTp5icbLCmOpWUoNMQRqJJuUYJe4jNyQJYKC0r9E=;
 b=bkLA0K9Ap2ZSHk7cPHAm51PQsjXoDrk1DlhpoLyuCWdseCQFu0aDLrpjlvj1Fe4kMK
 FIW8Lpt7Nn3L+GQyHyh1w2Sfe5QfFA5brVVkJTjM3g4ajgVwjBS2RPDtV5FAxnWSlyqC
 yAPqbS8e4RxhiGgEyQ6bnB0FOlg5HXfaHprJdkEMYcEChONBEzSbT8tNzNxzA7ik0ZGr
 sT7ziXQWV3pXjGXFPbudejVMMSGeY2mZ3UUFXW9x54m1k5ottHudRHhDkF5RHpb+4KvL
 2hY3/cDKWkuPcpeKCJc6LWW4YOV5UWxMti1CqE4rhacXYbL6IETyf3JFhPGpEl9PUnPm
 bsLQ==
X-Gm-Message-State: AOJu0YympGAWbO/WouJjHKjhF+EeN6Ng0Te9fu9EOlWkH6Q/eB+xImUg
 UXDLD2umBnfeaefwx6rVim1qbBdDcWPfoRajhYVFZI0j9HybxffD4iJ6g6lgrbCS0jbmViAAiHK
 8wREUVYf1
X-Gm-Gg: ASbGncspfLqTy20sZFjy4uK3vTiV7pMlpwM2Jf3/yOqjOATxMJSt0LUyFM/RYfe95IR
 EOMd05+lhDympBi8Vkb8nsRaX8Jv8X9seqR57usl3+Z1uw7mYMKl5YEdZso+NoSjjlHbxVHNbOy
 sDdEn+BS+T5K9kDnUQQfaLmRaryByg8+ARHU/EvQA0Vdfs5ABme7KJcXmys7SDq5YrIhYvdxPtI
 LrITdQyDARiYBWm42CSvoq4rN2tzOYQwf6dlDU6WJofvnA1lws+xHKJ7/Nqhj0kdvj1QqcVM4vB
 ynyRFYNbej2RELi4WA6tI5RDtshBC6mhEHvxUe2gDrnUvinqSvazzrXJ1tJ9t+WOyEvk6D6as12
 hWocjMcXw2Fux
X-Google-Smtp-Source: AGHT+IGyvt8is80RDN0tjFvbvdiSxbZUNjBod0/01JyDR4EPAJEP8kIW4yHlB2VtgmKQkR5bRmaTjA==
X-Received: by 2002:a05:6e02:3cc4:b0:3dd:8a06:4db3 with SMTP id
 e9e14a558f8ab-3dd8a0653damr12154745ab.19.1748420764668; 
 Wed, 28 May 2025 01:26:04 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/27] vbe: Avoid accessing TEXT_BASE if undefined
Date: Wed, 28 May 2025 02:24:37 -0600
Message-ID: <20250528082520.152391-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

Use a condition to ensure this symbol is not accessed in the EFI app.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/vbe_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index a86986d86e9..f9368a6a9ab 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -174,7 +174,7 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 	 * external data, so this is quite small, perhaps a few KB.
 	 */
 	if (IS_ENABLED(CONFIG_SANDBOX)) {
-		addr = CONFIG_VAL(TEXT_BASE);
+		addr = IF_ENABLED_INT(CONFIG_SANDBOX, CONFIG_VAL(TEXT_BASE));
 		buf = map_sysmem(addr, size);
 	} else {
 		buf = malloc(aligned_size);
-- 
2.43.0

