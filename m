Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818B8C0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A9BF80A29;
	Sun,  9 Feb 2025 03:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D+hOtSSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3144809A4; Sun,  9 Feb 2025 03:02:34 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 705D18083F
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-844e7409f8aso89055839f.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066548; x=1739671348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BvlSbtfLFkbM7ByOi3ybeHkSVhG4Ld41TKFVJ8cKUsA=;
 b=D+hOtSSsR6/tC4dT5uJ2yNF2Uh+02+bX/JGpvBUcFPBNRIzLveO7ZjcXY3Ok+j9zz4
 ILF9PhdFf2IsoRz771TSH0REHNXAZopdy62wEDhzJB7MeEzaA1NLfeEcgcdJcExAfCdM
 iopG3LSjQ0YY77/J8i3cwSNJk0rcX2ZLYVKVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066548; x=1739671348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BvlSbtfLFkbM7ByOi3ybeHkSVhG4Ld41TKFVJ8cKUsA=;
 b=MEccr1Ozai5OZFnORt8H0lU0aYTorOVe5avglTsnQK4Oe5DcCFJwnSFYymvXW8gyLe
 W1/Vb6ZEWJioCYPSz8fO+7mIhk1XZMKM7qYI4w69aBgV4DZ4Xw1dKQI5CYlC6W9DtbTE
 dBvVKrnEmdoid6PK+R9NrsfqTgzn/gqeht9Dw6A24qjqUmbBKcs6iuazl7TBxEI/DeRh
 FBmlv9Zmk//sMV7K9OvbxVTmqsX+Kc3e57lMQv+01i5pS1FNnlZ9eeNp0toAs4X+FYkK
 xiL5MVZes8qCM69W46jtuV1Osl30cjBVk8KYharXcPFXwAGbDrRNDUJMjW1ms43Dq+oj
 W4UQ==
X-Gm-Message-State: AOJu0YzAqLEA10DHA+DMKJOyhNlTrVqpU4leUIY4c9LEoWFVKcjpvTEj
 VYG/BJpfbk6xPF/dbARhvh96x23dlfvrZ+g/RJFaQbH8exQPF/N8eotvHi0Ekfn6u8YOyvWCpSg
 =
X-Gm-Gg: ASbGncuXHJpXt+PJiGzj6aEVQCF6WZpSxsPTG81ljCyFs/JIu4pUGxnnnKA0DuIg3X+
 yhxxrrbvOvJNmLR+z7MB8aG20DKAlHVBkt5z1pDY45zJBNtV9E/KWy/uDu5XvwEm/SNGy7r5SJF
 MiT/V1FLzFHLJPCXRdUxdqdWLLcd7+DB/qUX3/n0NqqMCYx2j3UaMxS63ux9cmjnzGF/QaprweT
 3JMVZGExlwx7Bpuc2rqUtxgdgfvnOuUl+TDYGj0xzpFULoLrCxbUkCZXzY1aagDZQRQNVwHTWRq
 smzUWYN7bY4XADIczAXv2hL9WR5acEaaOFrOZtyqw1hXDa/tuLQ3
X-Google-Smtp-Source: AGHT+IHneAQQKmgFkXG1fI3MoS3Ve1vYXcwRlXTwcuXZoEH9M/5Q4ZEDT2k9lAvV/VKa9g2+HMy1Xg==
X-Received: by 2002:a05:6e02:1a6e:b0:3d0:1633:3138 with SMTP id
 e9e14a558f8ab-3d13dcfca22mr69082285ab.1.1739066546467; 
 Sat, 08 Feb 2025 18:02:26 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 16/29] efi: arm: Avoid enabling caches when running under
 EFI
Date: Sat,  8 Feb 2025 19:01:15 -0700
Message-ID: <20250209020136.4108987-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

The previous bootloader has already set up the cache, so don't try to do
it again.

This fixes a crash in QEMU when booting from EDK2

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/board_r.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index caac092c8e7..c4545e9b483 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -110,8 +110,9 @@ static int initr_reloc(void)
  */
 static int initr_caches(void)
 {
-	/* Enable caches */
-	enable_caches();
+	if (ll_boot_init())
+		enable_caches();
+
 	return 0;
 }
 #endif
-- 
2.43.0

