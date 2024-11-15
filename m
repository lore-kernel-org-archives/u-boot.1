Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3453D6DDFA
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 13:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC13A89654;
	Fri, 15 Nov 2024 14:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NwbTKO8M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9902988B6D; Fri, 15 Nov 2024 14:48:28 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38F3C89221
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 14:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-83abf71f244so25178639f.1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731678504; x=1732283304; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPx1+KmXXGbxohCtIMBujBj9+ARlylu6OEVSW9k/Aeo=;
 b=NwbTKO8MYMORiEvhm6GAaV7AXPXvW+5ryQFyx2AoiDjik1usSAsiCAR0n3EkWsVa64
 vm1P87a+twaiq6sc0UN4ud2eDQxOu09oYh6wN6nRe5HkPm1zZrDctE/REtANfEpmYR4m
 7QuLxp9Gn9PYBLPyjtPD8+lR65s4rrn5xi9mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731678504; x=1732283304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oPx1+KmXXGbxohCtIMBujBj9+ARlylu6OEVSW9k/Aeo=;
 b=Z0JpqoUX9oR636vliHOM9UWtnYn/H8fuNllbQs2NBPjmufkkyxwZD7o1uGCR27EUMi
 Y+FM2dz4fIH5c8IGMVkBzLmqVF6FL/lk8W8Mpcw8oh4R3jMezEk1zc/jbgdmVx1AT+1g
 LaErNxNuYJzvjWYGSJwb7EEoM9tNxgZIHwmx90OR9CPPBXgtzxDKg9qPVk6NBBk8C7wh
 UXKJU9coPXYlOT2SQHqIyml/agWFvdFaIjwJEbMIaa1fyYVqBCtLQ+FNQIjqYA7So1S5
 A3xjw04nMWaul5WXg7ebnilMY7trJVQKOnd+IDLsd2+ZCcWoTel9h2oSlmFISIBz4MDp
 +I0g==
X-Gm-Message-State: AOJu0Yxl12deEXUE04t0LGyKKGU/T6Phg86q1WijJbMv+G1WKhsW/M3N
 w7gUtVtHxT/ycbKJzdC0N102hTK/ZiEIPb5BpLq1g3i7ACZFWfKPj+EeHM48pzdkearkkg01zwQ
 =
X-Google-Smtp-Source: AGHT+IGyJnlmRxK6eNnZvjUkrj9RnE6W/dcew/oBsVOrwRSq9E6V/Q41tYBAGXhBcjM7HYaBpCuDcg==
X-Received: by 2002:a05:6602:29cb:b0:83a:639b:bc44 with SMTP id
 ca18e2360f4ac-83e6c069a02mr341513439f.3.1731678504441; 
 Fri, 15 Nov 2024 05:48:24 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e6df91554sm34118439f.9.2024.11.15.05.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 05:48:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 4/6] docker: Fix LegacyKeyValueFormat warning with
 PYTHONPATH
Date: Fri, 15 Nov 2024 06:48:05 -0700
Message-Id: <20241115134807.3068947-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115134807.3068947-1-sjg@chromium.org>
References: <20241115134807.3068947-1-sjg@chromium.org>
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

Fix a warning due to the syntax used for PYTHONPATH:

   LegacyKeyValueFormat: "ENV key=value" should be used instead of
      legacy "ENV key value" format (line 304)

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index c3fd9a04287..22aeb90f9bf 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -298,4 +298,4 @@ RUN /bin/echo -e "\nx86 = i386" >> ~/.buildman;
 
 # Add mkbootimg tool
 RUN git clone https://android.googlesource.com/platform/system/tools/mkbootimg /home/uboot/mkbootimg
-ENV PYTHONPATH "${PYTHONPATH}:/home/uboot/mkbootimg"
+ENV PYTHONPATH="${PYTHONPATH}:/home/uboot/mkbootimg"
-- 
2.34.1

