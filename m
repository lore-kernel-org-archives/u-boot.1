Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1741C021A4
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B41D480F88;
	Sat, 15 Feb 2025 04:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PR8tiYmo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 137A980FA4; Sat, 15 Feb 2025 04:23:56 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB03F80756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3ce87d31480so8312545ab.2
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589832; x=1740194632; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2ZNA9bZpsMCfvCjDREi0fwnUPr6IheAOWVitEKCVvY=;
 b=PR8tiYmojOE8a5w3t/oEXZF1lyon1Ib7EmdkxWfCgLqprJT7SV+GsJujxaDsw75DAS
 A+lLhTdhh+gEN5vgtiMEeUdNvSI32XX583m4eMs58CHiAwhCwqWG649QGLr0HqF2lvv2
 TsHRfiXuU3KuCzXItZpL86R3cTC39h0nlDgJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589832; x=1740194632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q2ZNA9bZpsMCfvCjDREi0fwnUPr6IheAOWVitEKCVvY=;
 b=gIwgAXy/CHrYws+Xiz59OQhWiawQ2QzeihS5RjD8WHxe8qd98eGfY6myahdCIB7oIv
 bETU3mB2WOXTZQRg50NooyfB0KK2oWePCSFuWhNVGS2eXk1SBS6ahQnWlWoI3Yw08qcK
 mflX/n8yGpiJKLZDGifIK+uvvV1xVPBuHvqy7E/Mmy/nhnC43BfAj9c9Dp/A2nye8zL1
 ndCuEt/n0l/Oevhv0R02ZbH5wM6LPPNeyxFloySnq6ZYshvOl4dSA4Qpb7tdFKzr5T1L
 VH1G4zniOAIo0S1AYW2ZkDHOXOPkB+wmswLFjdMFW3t7SBICrKyF0KQKsXTi8HF58Qka
 E8RQ==
X-Gm-Message-State: AOJu0YzY9BY/xzeo5p1KjJx1gvL3gdVfv3x2Ye1oFdEHGKHHMU2amXNt
 UyzcA0Me+P76syOWlb2at5w4w5uarszgYl6YGUe7vH/DwvoBqWKuXuK8dhKo1vwwwLMltZQQqSA
 =
X-Gm-Gg: ASbGncueuT6KC1mxdMQBx5rI7DfFm9zxC+bJlO+EMQANPLYxYCKC2T85W8wA6luqa4y
 SK0lnAE6gqphIeGegJoeUbxAl3oPQvXWCsQ42aRZr8m0Y+vW59PUX1uU4DCuD1fEIRWjgdQe5WA
 0A+7jeq+8AR+q3zQsgopc4qak+HPs2BFvzqhQKtcqB5DTDW4Tf+gYsVUsTNRlRHI4KvFQYj+5Sk
 nzOeSWYnKfd4LaPBjRRifXZVmZUotAqde9nARsyN9Vzaw3nV5j87PZraSXCyL6BjMlDlwp2COvj
 uUiyccYukpxrOl4wU3odgho6bVcJIU6H7zTqGcpSlPy266ADuVmc
X-Google-Smtp-Source: AGHT+IHUOmNKAlH3DyOH3xjKhQqokIDnzdPUFHLxnD/ONZ1SzLrg3oWtfDXV89gV/J4Y0+CQw74AQA==
X-Received: by 2002:a05:6602:3f6b:b0:855:2f41:f849 with SMTP id
 ca18e2360f4ac-8557a13ae26mr127999439f.11.1739589832160; 
 Fri, 14 Feb 2025 19:23:52 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 16/29] efi: arm: Avoid enabling caches when running under
 EFI
Date: Fri, 14 Feb 2025 20:22:37 -0700
Message-ID: <20250215032254.4121030-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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
index 81715397544..e7d9a3b312d 100644
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

