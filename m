Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F78E7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:16:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00E6186E0E;
	Tue, 26 Sep 2023 16:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cberqb4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D3A986DAD; Tue, 26 Sep 2023 16:15:43 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76C2586DE7
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79545e141c7so243898539f.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737732; x=1696342532; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQo2HaX8wTDp+GAUx+rLkjEjwOKqFLUkZ/2SYhQdQgs=;
 b=Cberqb4EDgF2heAmYzXKFjGKWLe0vRCXSeZ6s5Is28WnKl6B5c2X4YXQX7pLH9dHcx
 /K+xsnULFiEvc4h/W9PfpM2cflGSMK8lP9iE8VgOD+xMrjEQhIUnJDiWStAgcNgjA5AM
 2unV2ZOuBdqjgmWAu7U1DhxN0ouQ/rSWFUcEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737732; x=1696342532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQo2HaX8wTDp+GAUx+rLkjEjwOKqFLUkZ/2SYhQdQgs=;
 b=UD4+e32cda/FnTS5pxgUa6dNEdxcNlrsULjTqCph9VMswBR2EzTEOhXeqS+KSkmA1f
 l3jOk/v/naFUIVmtS4WL1rUe54uaUd5GkbfN+r/D3ntgU4WSEHjaBWP6O4LfeDuUWkyQ
 lZrFTKcxMPcD+l0tO3EDVobJcM34B6pXO2Q8HwE303OShCfoQrEuTs0RU/kYOPpOL6mG
 ihoorRyZUVTIvFXa5iiKi4loWdxd9PNJIipnnhM9tHG+vqFZ7yHJJdKYpB9b7vWNvg+h
 iX4ivkeSdAu9L6VmAlkw3rkaAEzVvBwVMA66d/rfLB6V2P0PyqGVQbK8l7sDewuauzQb
 kXyQ==
X-Gm-Message-State: AOJu0YyRPolEOiB9LI/NShXfKgMOoERms7GJDbftlQD5SgJMQG149xB3
 gvT4k6SAtyB95eZkeYWFgufiSkrYC8VgLXG72Pg=
X-Google-Smtp-Source: AGHT+IHmqz+DNtsu1iUK1/Nxb9gK9LNP5HOs1XXzWcaXJN+Mj4dsh55zlPjyAqLjUs/cq1+kr62GNQ==
X-Received: by 2002:a05:6602:388a:b0:79d:27ef:23c3 with SMTP id
 br10-20020a056602388a00b0079d27ef23c3mr2667626iob.5.1695737732082; 
 Tue, 26 Sep 2023 07:15:32 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 09/44] serial: Drop mention of SPL/TPL_SYS_MALLOC_F
Date: Tue, 26 Sep 2023 08:14:23 -0600
Message-ID: <20230926141514.2101787-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

These symbols do not (yet) exist, so drop the usage of them in the
serial Kconfig file. It has no effect.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add new patch to drop mention of SPL/TPL_SYS_MALLOC_F

 drivers/serial/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 64861dca1a99..be5e90c91574 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -160,7 +160,6 @@ config SERIAL_PROBE_ALL
 config SPL_DM_SERIAL
 	bool "Enable Driver Model for serial drivers in SPL"
 	depends on DM_SERIAL && SPL_DM
-	select SPL_SYS_MALLOC_F
 	default y
 	help
 	  Enable driver model for serial in SPL. This replaces
@@ -171,7 +170,6 @@ config SPL_DM_SERIAL
 config TPL_DM_SERIAL
 	bool "Enable Driver Model for serial drivers in TPL"
 	depends on DM_SERIAL && TPL_DM
-	select SYS_TPL_MALLOC_F
 	default y if TPL && DM_SERIAL
 	help
 	  Enable driver model for serial in TPL. This replaces
-- 
2.42.0.515.g380fc7ccd1-goog

