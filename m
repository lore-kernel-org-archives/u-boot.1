Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88713CF58E7
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 616B289445;
	Fri, 20 Sep 2024 10:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KHDAdulm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB82089445; Fri, 20 Sep 2024 10:13:56 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE260893BE
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f75c6ed397so19603921fa.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820019; x=1727424819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sngx/D9F4PwcGCUI+gO0BlU+bHlIHERBjQcnW0FsO6I=;
 b=KHDAdulmozqgndPbeocrvl+VEoQQTbm+BzwIT3GQqIwpXmi7yeCRED+JZYSMvy5LA5
 ox+BSkCKAkGtWdFyjRcBYVV7MzkHxmnTPkB4wPnAoUhn/GuNkGSpM7aHZaMWY2EcmT0N
 GbsH75OkySFgUJDafQK4rZnlC3ggFvq6zgwAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820019; x=1727424819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sngx/D9F4PwcGCUI+gO0BlU+bHlIHERBjQcnW0FsO6I=;
 b=DDYVusjbPgCJ5jELriCV5H1cCxJhaxeBRdugxfMgIGEOuSK+H3I9/c6K/uOdnVNd6S
 +CmitXEk1N50b9VrODxyAI9f+DhyqwT1frRslJthc3XY8Huy6R4gda33Lxv9chIRyqfh
 ny9OFn7C2qkxDArmdKmZE/TEPLVvTfO9Twp3m5BFrcWd2YZJynBoKnPcOMPmjKT3SIIw
 HPWDgors1ykigbD3A6sL+ZkuCeE8kGJe1QHUFQTdaurT7Q/SVYTBalofTKkhUlSFvSAB
 kBtu6Izv6xVVcO3nb25zpfKLU0QWIokWiEmvpNK1wI6OkmTjVLrtk+BoE6GFNqYZJG4Z
 avEQ==
X-Gm-Message-State: AOJu0YxSlIEMDUjSn2LvO/B43dAMTNwKM+dblabYBp4xpvB68CVfSiSl
 PJHkB8rgeg3c5wbmPsoRkdba8N+5WcIk5UlIjl/FgN1kMXv1IzlJxyyj/AVk2DrgXeBxRl5diNn
 GRzG9
X-Google-Smtp-Source: AGHT+IHQaIUWwWnexHV22Im24HO817Elk1zuVDHP895rgYBk/T5cm5L6RsvUWo5rACmOuwxYlwRN7g==
X-Received: by 2002:a2e:bc06:0:b0:2f7:939f:a49d with SMTP id
 38308e7fff4ca-2f7cc375d60mr9379661fa.24.1726820018782; 
 Fri, 20 Sep 2024 01:13:38 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/18] spl: Drop a duplicate variable in boot_from_devices()
Date: Fri, 20 Sep 2024 10:12:51 +0200
Message-ID: <20240920081309.140426-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081309.140426-1-sjg@chromium.org>
References: <20240920081309.140426-1-sjg@chromium.org>
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

The variable 'ret' is defined twice, which is not intended. This may
have been a local merge error.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 2eefeb6d893 ("spl: Report a loader failure")
---

(no changes since v1)

 common/spl/spl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 3f432d0fa7a..75938aa63cc 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -613,7 +613,6 @@ static int boot_from_devices(struct spl_image_info *spl_image,
 	for (i = 0; i < count && spl_boot_list[i] != BOOT_DEVICE_NONE; i++) {
 		struct spl_image_loader *loader;
 		int bootdev = spl_boot_list[i];
-		int ret;
 
 		if (CONFIG_IS_ENABLED(SHOW_ERRORS))
 			ret = -ENXIO;
-- 
2.43.0

