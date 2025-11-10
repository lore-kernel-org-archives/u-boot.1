Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A3ACCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 10:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70C9A839D7;
	Mon, 10 Nov 2025 11:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="lL3mgBt5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87E0B839DE; Mon, 10 Nov 2025 11:58:18 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93B73839AD
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 11:58:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b728a43e410so613302066b.1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 02:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1762772295; x=1763377095; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6erHCoCjH1UEujcY3Y5p+Sjo7Kxe0pA02ZFhZPbwNBw=;
 b=lL3mgBt5uJnw7trLabdmdpXmxn85u0mLeWWUEaGXJoRq9mOpTTHEUQK2OT4EGx6oj1
 jtUNrAPedLypYlySHdD4y3zx8dAS8NL5cBpC2ykkoEZ5/C4pu53pinYyEOAVcCajQFiG
 O1AyDm7Sewx2Hz/ofMpCrx9iW1zUOsoz2uGti2SKoQnj0VG7Epv7aT+ZUFExZX/C2zXq
 CUGKuTX1PbVkIRS7Iwg9QRfFF8dC5h5Lz+0kxrE3TaLdtb4nqyjnhOia7GaqpysC8M3z
 A7PFaLv49CQkqOGBF24vE41vZdHGKJ3A56dQr9UbWPivXlwz5kzUcGIqgNl5o+v6YJtH
 86hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762772295; x=1763377095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6erHCoCjH1UEujcY3Y5p+Sjo7Kxe0pA02ZFhZPbwNBw=;
 b=Wvu/pRB7oySYRt3xIlXrC+bokdYxD+EVLOMvwFhMrdCEAdPmq1SOqM9iZRYKYOJa+j
 41zB+LMIzkLtVognRFm0raddGlG/X5LTkw4r8p6ENlAC+rR82Vzo+ZpLnXJjQ3NoXcQA
 TapJUih/nYceRGPJP9DrUcwgv2SBK1cghLh3+1ybtByN8vX4Q4UecsocPb0KJDpH1VYx
 BmrB39R8xE7SNujZC+k0tMZ3PIvYIHmN//bXF8RFG6dBwdZfDw4ELWXXbefb0+5AZi37
 C4T7WBwo1Q4eu5nA7jGGnzgYlQG+y5b87Xnd5lm5kGjkYKx79c8xGLuBd9iDZSDcxOUQ
 zTzQ==
X-Gm-Message-State: AOJu0Yxj0fLteL+kmBMvIKINgOjkv/i8CcmAy/nUvc659msz0nnRGW+2
 ImztkaNkFrBidWKkmF4KWBPQUxABTce5lmDJ/V8aHcLdI+F6rQJUgl4lEBgKK7Yu
X-Gm-Gg: ASbGncsE28b0qAOK6gB9uiyamvuRWzEIT+N+MsNPIDe2yQz8QOFtpuAKwOdbFXg8PRW
 VFhAfKhlQrflBmsoCAB4C9zRJew5PET8wzezZouGhy1RusYffK6KkaYcVe0+P1NcUkdavB2CP7P
 zxo2XnwUuXnbBVGSDT+kaoDY+SfvUBQ96b6sKl+0QDAztpYEe44FbGqB61ui4z7swpsz1kBz/0I
 WOrSMz6Vft8J6jmkjDNDKmY8ri2IKg3+IYowsmzallf5e/mmkuJogx1xoKHWbSnEftT30JfWIdC
 N6KAPjTBXJcG/C4yXYRLgB8DtgBNOUKmPPwt6o3gTsYqFYU9q8JgQxB+B9l6FyWE8LTgG6eK4zg
 cNnhyyakrRt72m1PLDRJZKO2bJaoWDzrnN43k0STD4qnxccZo7JZyfzRMqlaHygCJASe74C1sLw
 4rhZfTZuma7PdhfnqywB4ApEhXfbOzwBhIRmpZn7ax+ylsQIvWCaDQwE5qJzrcjT8PMT4=
X-Google-Smtp-Source: AGHT+IGhVMjGCX0vf+GgJ1Ak1mquJVWnyuJV0NakM4PXE9o45DXUBFBsgi5Wb5Vtkf+OQNvDX+8ZYA==
X-Received: by 2002:a17:907:86a1:b0:b71:9c99:7b8a with SMTP id
 a640c23a62f3a-b72e05e5a1bmr664374566b.49.1762772295278; 
 Mon, 10 Nov 2025 02:58:15 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de.
 [213.209.99.202]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bdbcadb5sm1102658166b.9.2025.11.10.02.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 02:58:14 -0800 (PST)
From: yegorslists@googlemail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] .gitignore: ignore more files generated for the sandbox
Date: Mon, 10 Nov 2025 11:58:12 +0100
Message-Id: <20251110105812.427041-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
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

From: Yegor Yefremov <yegorslists@googlemail.com>

Change the existing regex "/capsule.*.efi-capsule" to
also ignore the following files when building the sandbox:

capsule_in.capsule1.efi-capsule
capsule_in.capsule10.efi-capsule
capsule_in.capsule11.efi-capsule
capsule_in.capsule2.efi-capsule
capsule_in.capsule3.efi-capsule
capsule_in.capsule4.efi-capsule
capsule_in.capsule5.efi-capsule
capsule_in.capsule6.efi-capsule
capsule_in.capsule7.efi-capsule
capsule_in.capsule8.efi-capsule
capsule_in.capsule9.efi-capsule

As test/overlay folder was renamed to test/fdt_overlay,
fix the related ignore entries:

test/fdt_overlay/test-fdt-overlay-stacked.dtbo.S
test/fdt_overlay/test-fdt-overlay.dtbo.S

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 .gitignore | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index 1ac737d2718..2bf86a6b5d6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -73,15 +73,15 @@ fit-dtb.blob*
 /defconfig
 /generated_defconfig
 /Test*
-/capsule.*.efi-capsule
+/capsule*.efi-capsule
 /capsule*.map
 /keep-syms-lto.*
 /*imx8mimage*
 /*imx8mcst*
 /*rcar4-sa0*
 /drivers/video/u_boot_logo.S
-/test/overlay/test-fdt-overlay.dtbo.S
-/test/overlay/test-fdt-overlay-stacked.dtbo.S
+/test/fdt_overlay/test-fdt-overlay-stacked.dtbo.S
+/test/fdt_overlay/test-fdt-overlay.dtbo.S
 capsule_esl_file
 
 #
-- 
2.34.1

