Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1240BD49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1DF3894FA;
	Sun,  1 Dec 2024 16:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IzoBLwZ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 090FE894C0; Sun,  1 Dec 2024 16:26:13 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 378D2893C2
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:26:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-83eb38883b5so109106539f.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066765; x=1733671565; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQ9DdSmGxGe8MxWIW29OLnMKE/wm4UGeEGVfhI+q2Fo=;
 b=IzoBLwZ71S+s/zM62oeOWPQ1p7u09VoNI+EAXT8W4oXeOVSfpK/D6ikHVIu6n+dgfZ
 Vz4ScLYNkL4Otv5GBdRsPSW/kSLAN93vRldi1fEctx5npAVxJxmRUuR9jo0Vsf2cwUs0
 epwPEScBw0LD2V+LJXxwH9GzY1AkwctrDhFss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066765; x=1733671565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQ9DdSmGxGe8MxWIW29OLnMKE/wm4UGeEGVfhI+q2Fo=;
 b=o+R8cbEC6uRkkP/o13CPQZw1cZslDlqyEw/JmONeaRmbpp+NPGxrYIAcWcun84BOwE
 6LgM1eZxwFlATDgoUGJVBfAiFEVA5o+0ZUyU5m580bWq5/NbbnTYmUwBWwCpg2EME5vZ
 FOwJCK7SQECLmg4VwRsCuGOVrGsvi0x3YugkUe43fbVElTKEO6ZFTwEREBw0K/RmJ4q6
 J0suiJ2d7YwYbVgUSt7M22gCS3mZ9vxmM0a8nGGXqIOOmx7Xcw2lAhV1NlROtScbTG7H
 mHE8NseGiTjOwt3/eWUyMS4OqIvebRB6OBhQaLbZWRV7W0H7TC3s3WFC+c14QlLmowR3
 +2Iw==
X-Gm-Message-State: AOJu0YxeiNQ0tX4RjHz971RfmhDPbVcAQA7VH97DTWRAdj173SKTV0mc
 Ip9P3m+XnqexUtJLBd5vPy1D8MGhBuSrrp2C80D6w0jTgmZBO1SD5E5YTSAwZVoXAiiuCAlqY9k
 =
X-Gm-Gg: ASbGncsfy47vH7P3qKBFtbS+v+ngBksv0rxo+FCfc0veDXhgOrwVdoNuz/Ws1DDdqsb
 QJoMbtcCDOZZDwokE5kYpphUeqj0Gp7aXZfu9AxzTK2a1dzjFamcxsxWumcqFirG7CqduYxYHYo
 P9nk802Qcn8UgmWjijx1CS9M1XvQTmbpEq05QjV5RkhReeOLW5TI9BzWD5B5rAYEyzCrNjL/Nrj
 LPxWIhrYBUwb9jLIdM2wcnUcInUkbhjYqqQB4lPH3g6
X-Google-Smtp-Source: AGHT+IGl+UEDTqsQQ5Q9yHsWGtUJ8xFLCpioJdXRSSAlmeRSNZ6xme6j1o5V0/efe4nOxWFvjX5QnA==
X-Received: by 2002:a05:6602:340b:b0:83a:bd82:77f with SMTP id
 ca18e2360f4ac-843ecfd47e9mr1988352939f.8.1733066765491; 
 Sun, 01 Dec 2024 07:26:05 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:26:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 19/25] efi_loader: Show the address for pool allocations
Date: Sun,  1 Dec 2024 08:24:38 -0700
Message-ID: <20241201152505.1666789-20-sjg@chromium.org>
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

When logging pool allocations, show the address of the pointer, not the
pointer itself. This makes it easier to debug with sandbox

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add new patch to show the address for pool allocations

 lib/efi_loader/efi_boottime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 334a4d64b3f..3ea239fda41 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -533,7 +533,7 @@ static efi_status_t EFIAPI efi_free_pool_ext(void *buffer)
 {
 	efi_status_t r;
 
-	EFI_ENTRY("%p", buffer);
+	EFI_ENTRY("%llx", (u64)map_to_sysmem(buffer));
 	r = efi_free_pool(buffer);
 	return EFI_EXIT(r);
 }
-- 
2.43.0

