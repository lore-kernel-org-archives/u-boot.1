Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA98C27C65
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 14:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD8E888577;
	Mon, 10 Jun 2024 16:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RwAgZO5F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B788885B8; Mon, 10 Jun 2024 16:59:41 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0223E88476
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 16:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-375ae697210so248335ab.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718031577; x=1718636377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XeXW3Qkj/z7FbBVWiNsQkea6rMAPAsdsziJNKVVIk2Y=;
 b=RwAgZO5FVgQuz3BjbM9/wHFlhLWKO7JGns/ZWn6hoGUsamn7u3LDY4MJr0HlxROWi0
 MMsDMA57xo4eFEOx1anucjLX5W5aF2wqijS+2RhKTfrXaiYlqKBPGYJXBDRwYwDq0y2u
 COiMIiY4k2RwLRVdiQCi7OHQ3u4fb0POhajDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031577; x=1718636377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeXW3Qkj/z7FbBVWiNsQkea6rMAPAsdsziJNKVVIk2Y=;
 b=t7FETDj6guITYABQdymobLSFtXY5XRC2t8oS3xGQ6STLHFlTt8dxhwbJhLoDRkcgk/
 l7b2yGzjk2UBnI4Q7iJaaHAgM+j+04tdxw+bvRCEyXSQSrDBkXmHTwg6/0U/wi/RVoKP
 6Wn1ZE+Uf6a/LetanIgojbllFFN8ZtuFZjMjZ2JaOcrnXaFlpZ0twc3VulwTAXTXvSu6
 8KwgVcMyRRPoanFNHBvbsyJ9ia84ioOsj3MIIasq6fAe1SQxNBC34E0rRSlH597LREFe
 szD0JFHbu2qpjHv8Imef/DhWSD4kXMmWgBLyI6YPDoXl+j1QkwlZFU0gOBal3/FW0/0m
 xCcA==
X-Gm-Message-State: AOJu0Yyi9ir71ilJYfylCr2VfQzix/Q88+hRZMLEbAJdEU9s8nCGgSZv
 9RBLbEDDbhZJsb3o6Tw76sClBlxy4DSqo0VKenwtSFW6pTzN4ojv7Pg+Djdd+YvC6EPM1au1DvE
 WNw==
X-Google-Smtp-Source: AGHT+IGkSUlsifQmynEWx+w8m3cDyQ4IxFYFnJU9eLCblGqfVBVVn8a3Krxj+7Jgzl8VDKOL5QzhdA==
X-Received: by 2002:a92:d151:0:b0:375:873a:aa99 with SMTP id
 e9e14a558f8ab-375873aaceemr84695835ab.25.1718031577527; 
 Mon, 10 Jun 2024 07:59:37 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ac6104dasm2526885ab.4.2024.06.10.07.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 07:59:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Allen Martin <amartin@nvidia.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2 1/9] nvidia: nyan-big: Disable debug UART
Date: Mon, 10 Jun 2024 08:59:12 -0600
Message-Id: <20240610145920.3302001-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610145920.3302001-1-sjg@chromium.org>
References: <20240610145920.3302001-1-sjg@chromium.org>
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

This cannot be enabled early in boot since some other init is needed.
At this point it is unclear exactly what init is needed, so disable
the debug UART to avoid a hang.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/nyan-big_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/nyan-big_defconfig b/configs/nyan-big_defconfig
index 1483d17d975..4dec710cf8d 100644
--- a/configs/nyan-big_defconfig
+++ b/configs/nyan-big_defconfig
@@ -17,7 +17,6 @@ CONFIG_TEGRA124=y
 CONFIG_TARGET_NYAN_BIG=y
 CONFIG_TEGRA_GPU=y
 CONFIG_SYS_LOAD_ADDR=0x82408000
-CONFIG_DEBUG_UART=y
 CONFIG_FIT=y
 CONFIG_FIT_BEST_MATCH=y
 CONFIG_BOOTSTAGE=y
-- 
2.34.1

