Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B549FC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 064E380836;
	Mon,  3 Feb 2025 18:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U0z4I8Pl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04183808A2; Mon,  3 Feb 2025 18:44:03 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E51EC8082D
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:44:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3ee1be3d496so2386777b6e.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604639; x=1739209439; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qTBsZDYMnEPPRD9ytIqWmZSqqESz7N0qRaeExn+Ihrw=;
 b=U0z4I8PlZu+sJvxm83XmSUAer/Sa948flmeKNi3GWAWoIC+s/XKCINFrVPI+yDH6GY
 Vzjnu05N25eUHtbA9jL+t9pV70UtJ7KXl9EGuM8vMN8JjZSVoaSJ3Bekg4Qw/fQ7SZbi
 iZ8Vfqq6c53lfwJM4/i9OPC9FFOl6OT53jOsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604639; x=1739209439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qTBsZDYMnEPPRD9ytIqWmZSqqESz7N0qRaeExn+Ihrw=;
 b=RoaGiKap0X3nI31jpI5D29Aw++dp1MXkQUuUEyLuOsHg5vNbbH1WDcY9/Y0Ity0w7v
 BlXI6lomG/NHqJzv3NF3ia/awOjhNcvCaTG6cnN/+HBIfeCGqtfDG57mlkMyYDRq0c6H
 iAI/r1Dsw1XX8M5khJqL1/qKwSiEyQH3iGfGuZCbkIqLBTNmZFUZKGHlb2riQJOlxLfl
 OeGiA8AiehAWpqjirbEI0nf40iADsSisZvNUzmQklDwcHJbEaryffZJPLBiRNtLGOjiL
 vG0vCM2tJspP6CI89NWF4vsPQ0eNzZiLkJqmrYvVngyOwuorueVsAw2rkODnuORQi08K
 Y4cg==
X-Gm-Message-State: AOJu0YwKfDJU4eV397/Ve3/1JhgkWGUR/hjvmewGhbhdML6EegBlBIjE
 lFR2tia3Ka9clGlCqelRIOU3Rm5vjODeDjuTySzUvpV47P2XXLRR0PrJwEarifMBkAJrKzX90P0
 =
X-Gm-Gg: ASbGncup/Q+7RxyNBtiJZjI7F29nhzoxjhhj4zVB2Udl6SElb2s5iuCjgc6iuwDWW9S
 ZcNjxQjEYQs6YuchKLRIYY/myscR4WkwPyhHH0lc3QyysWZRTQ6iStrXaJG830dcq/qbe2kM8+r
 dquxsqWRdaA64Kr1YdClkpBDtWYyvlIaOxaxlujxrT2wuyT6rSmBEewu8BesLX7uJjxGm8WQbpX
 B2mm6Wxgmxlc9AupWu+ZFreOfEKtukHGrjk9JZSrs6bmykjWpREcqlvzgst4X2+A/XH+8sXY5ts
 Q6tY1cy5UdriJW7ZBhd5TLLhW8mUQv4Kl2oL5covKxOjyRmG9If5
X-Google-Smtp-Source: AGHT+IGUvzNRmfUxu0zNDZlYxUZtM9OY5DIfsIRESf8+EiMpyNPg6h4JibFDNfbX3wFuBVosIRzOfg==
X-Received: by 2002:a05:6808:1896:b0:3ea:4b5c:60a8 with SMTP id
 5614622812f47-3f36dda93a8mr129308b6e.17.1738604639142; 
 Mon, 03 Feb 2025 09:43:59 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/32] efi: arm: Avoid enabling caches when running under EFI
Date: Mon,  3 Feb 2025 10:42:11 -0700
Message-ID: <20250203174245.1331464-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

