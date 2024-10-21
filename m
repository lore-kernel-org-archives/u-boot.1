Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E859D0E6F4
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55F66892F5;
	Mon, 21 Oct 2024 13:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iqvoCYtP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0778788FD6; Mon, 21 Oct 2024 13:39:14 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C71888FCE
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2fabb837ddbso58788331fa.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510747; x=1730115547; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OeMWxNRIqZjpnDbU35dP4Jmk8uLHkJVJebN/IM0jx+w=;
 b=iqvoCYtPHTlovl8Q3jL+uMS6TeENGo7IueY2N4w9CX1zqdWm1cMENsjnaE7TjLV+KU
 wxqQm+TsYxlpcWAs1dYvmePARx/qMAvuV50yY3IrizFt3Eews/dH7pnTapeCVkUE9oYh
 Mg50stMLUpTkgw6IzhAoxrhY+UoQprozX+45U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510747; x=1730115547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OeMWxNRIqZjpnDbU35dP4Jmk8uLHkJVJebN/IM0jx+w=;
 b=ZyQ8Iiyx2tshJrA3xn1z2B0xFXFexrhuAa+0SVkHgOXs4gy8S7840hT8jknb/G/qfM
 EH+W6dQSBin3D0H7rkk/zx8puUKc6mjcuZNn1JNazeH9pLby6pZT/8vc0kHsHkXXhx6F
 mzsvLOArQDARhIe7xk8EKTuL30Y6WOoPYQVzLbzjtJdxrJ3dc/4rKZqiXHHDxZbWG6RG
 6hX5MCkDyLcrLarO0FYuGwBUwL1uA/cnwySrS/81nWWrhAeBbwEP3hBlkbgw7zqiq5yE
 mH273oFvFGPHwq63Txbb9c/lUbbHAo4J2RXYa1gNccj4WpHmiOhY18fvFifyiW4iML7+
 OJ9Q==
X-Gm-Message-State: AOJu0YyMKZMtf1pQrnaOylYi9rkEMfDYIUwFKD6NN6zva0o7OBufqCJx
 Ztg56rR5Aj3SWUii0zoZQL4g8ZnNKz0vFP+mgtL+RGwHlrhEt0Utvl5+Db7sUNeVidRxrq9ZOtq
 Dz8uw
X-Google-Smtp-Source: AGHT+IHEYjDTpuXoUVM1It63DLUK8wiX8+054di9ZfhfVN7fqXlzinnE7YuItncj3jaxbNkerawuvw==
X-Received: by 2002:a2e:b8cc:0:b0:2fb:62ad:89fa with SMTP id
 38308e7fff4ca-2fb8321b58emr64688041fa.45.1729510746918; 
 Mon, 21 Oct 2024 04:39:06 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:39:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 18/25] igep00x0: Drop unused status_led.h header file
Date: Mon, 21 Oct 2024 13:38:26 +0200
Message-ID: <20241021113839.318572-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021113839.318572-1-sjg@chromium.org>
References: <20241021113839.318572-1-sjg@chromium.org>
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

This header file is not used, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/isee/igep00x0/igep00x0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/isee/igep00x0/igep00x0.c b/board/isee/igep00x0/igep00x0.c
index a35a7cd3b1f..35bb8c55806 100644
--- a/board/isee/igep00x0/igep00x0.c
+++ b/board/isee/igep00x0/igep00x0.c
@@ -8,7 +8,6 @@
 #include <init.h>
 #include <malloc.h>
 #include <net.h>
-#include <status_led.h>
 #include <dm.h>
 #include <ns16550.h>
 #include <twl4030.h>
-- 
2.43.0

