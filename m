Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDD9D49779
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5904289462;
	Sun,  1 Dec 2024 16:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FkyqxRdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 557AA89462; Sun,  1 Dec 2024 16:25:39 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42676894B8
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:25:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-843df3c4390so110569239f.3
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066730; x=1733671530; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0t66g8LAv1EmnxyTwTdw0yEyu+xBUYw0xy3tZOoHWU4=;
 b=FkyqxRdzc2W0TmjJHO9vOvkZbUNTQ8CdetY1ddW6y2u9k9/amBA4yek2QZlXFp/D1G
 f3pXmeMtEFgZTzZ9NZ7kx1zefSIrzGK/50LoFN/1zR+M0Oi1lL0yR+CFG2oWrntkMlvE
 W0XbsgUcBzQ0ztI6C895vDT9tPEZp3dM/fBi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066730; x=1733671530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0t66g8LAv1EmnxyTwTdw0yEyu+xBUYw0xy3tZOoHWU4=;
 b=BJxV+k7Jn4/z8PEUpuuO+chUYIFY1WgWPercixYdYKzImhpuxEUGgOWhUIE7aZeOk6
 qJahDcXl2gufJTNUor723/7mLqzQSfmp24mmqv3ba82mhVHlUqOSiGxOQyFW5RhcQGnH
 Webx6IgP7IiYtUT1YpXch4k0GU2PxokmPgUGIS6S5SUM1cSRqAYOSbnKX8vxyYP8hyno
 VqLMx8r9SveAUJuBVrypAW+Qh1UP5SshYN2ieHJ7kS8EzNjtPypw8tlbwtFeSk7oIihc
 Yk1E1ztuINXdBoVuhdQa8rC/+dKPqqI/U0DlYu5DpYo69lkj8alQOKMO1VR76J5RVIdH
 WafA==
X-Gm-Message-State: AOJu0Yy+EbX5+3BryhgRAa8TWAorf8h1s/Mu5fnUIN8Bxl1HDH1fsGIq
 UzYOoqeQfqDbN7v9Lsk45+oJvlmOb47mcMtW+TLSgDMhtqQ3IhMLqG6+c+b+JGG/OeE6+HIVQdo
 =
X-Gm-Gg: ASbGnctgFb9Uo6KQzvAOmzzFBU+v1szxU7uVz7vko0mJ/oyKvcA6NCLjyasL04kiMH2
 4p/89NqzVVHuVwo60yP1q603K3ep6K5PwHohZCyqX9MVK+nAfF7kSAGzUlql1yH62yqdIpM0aml
 drIgeJKcC6EPmHxFx3dSb8K7xHcvpU0QiU4S6FSLGRPV+Qp4LpfOO1RqdCeEI0giEjsY6utTayQ
 Mls1jRRgANdtAlfEAHpUe+/GyHDeDOlBK1bHuOG6EZd
X-Google-Smtp-Source: AGHT+IHtb5NwUe34ligdXYV3o5e3y4rak8iwniqCs9lE2BY7dDqu3TKsetno2kmSdhyiRJk3wnWQ9w==
X-Received: by 2002:a05:6602:1695:b0:842:ff2d:c3bb with SMTP id
 ca18e2360f4ac-843ecfffb7bmr2189501339f.6.1733066730519; 
 Sun, 01 Dec 2024 07:25:30 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:25:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 06/25] efi_loader: Update startimage_exit self-test to
 check error
Date: Sun,  1 Dec 2024 08:24:25 -0700
Message-ID: <20241201152505.1666789-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152505.1666789-1-sjg@chromium.org>
References: <20241201152505.1666789-1-sjg@chromium.org>
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

Check for an error returned from the decompress() function, just in
case.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 lib/efi_selftest/efi_selftest_startimage_exit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_startimage_exit.c b/lib/efi_selftest/efi_selftest_startimage_exit.c
index b65a10b7a4b..8d119f054c5 100644
--- a/lib/efi_selftest/efi_selftest_startimage_exit.c
+++ b/lib/efi_selftest/efi_selftest_startimage_exit.c
@@ -84,13 +84,15 @@ static efi_status_t decompress(u8 **image)
 static int setup(const efi_handle_t handle,
 		 const struct efi_system_table *systable)
 {
+	efi_status_t ret;
+
 	image_handle = handle;
 	boottime = systable->boottime;
 
 	/* Load the application image into memory */
-	decompress(&image);
+	ret = decompress(&image);
 
-	return EFI_ST_SUCCESS;
+	return ret;
 }
 
 /*
-- 
2.43.0

