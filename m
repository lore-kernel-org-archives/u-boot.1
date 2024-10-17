Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFB9D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42124891EA;
	Fri, 18 Oct 2024 01:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iAb1sZqV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 466D389245; Fri, 18 Oct 2024 01:25:00 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 665E189130
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-83aad4a05eeso61335239f.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207496; x=1729812296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wc/aJO31y218fa4klnqZeaECw4+LI4Aw3udhuLBxVb0=;
 b=iAb1sZqV8cA8p9PNA5vl2s08u85H4UpKSm1g2ZifdvBKks0F5c0pOQSHGctlHNBvdU
 FkojAliSwVcY3hMP3QMGEt9i/tLCwoo7tOzhMFtMJYoWUOI+5oM8p0PmgDF67B5kTtVy
 n/rCeqcdeq3brENlnznb93lkQgPVK4NUL2uB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207496; x=1729812296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wc/aJO31y218fa4klnqZeaECw4+LI4Aw3udhuLBxVb0=;
 b=W+6VWHDbfH/odn+PnotymEitnTC2k0I5E4cGYbVFWnG2ew4npojHF/Al6yfiKb+loq
 hK6p/0CZY8guOa7tILnc8X8CdpYMXgYsVJdh9h7q4MvNbjMSrXCc8kUGUlF7oMUxUBKF
 zKpKozkvzVcld+h7VQVVBn84MiYQHMGK/SI1SWvrO3RmnTZBOB1dC7EPsf7/2oqdpQ6b
 sZSUtiWqVKKRv3j95xlyarR1WBcB2RCxaA2rHwYeE8fqomvVq6in29s8u7K586JaC/8p
 cV8Ojk7XGQRGtoLpUcIWfPMFGAtnCice8rR5bgPNLxRgjYHtoKMscA1rbgyqf13GA2Hd
 g+7Q==
X-Gm-Message-State: AOJu0YzzgKQk1X8j63L4aYwBJ32GBVg/GZR53GucH4vC81G6ZY+XMo5h
 U7PMjU73IAnbJkh8lk1Rdh5VOq9FoSHP/RL1AY8x/TBjIXNC3i38/JF56f7XiK8OCLk0Z8BUD+g
 =
X-Google-Smtp-Source: AGHT+IF9gcRZE5g9RHtTATylRfUUqn1A2jQBx5O5UXU3lnEu2oRXkUCrfuWfuaNEwoy1uhUjaor/5Q==
X-Received: by 2002:a05:6e02:2186:b0:3a3:c036:e3ab with SMTP id
 e9e14a558f8ab-3a3f40a8512mr4654085ab.18.1729207495986; 
 Thu, 17 Oct 2024 16:24:55 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:24:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 16/34] image: Add a new type for EFI apps
Date: Thu, 17 Oct 2024 17:23:55 -0600
Message-Id: <20241017232413.724808-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

Add an image type for EFI applications, which U-Boot supports reading.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image.c    | 1 +
 include/image.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/boot/image.c b/boot/image.c
index cf16fb7fbf7..b13644b03dc 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -184,6 +184,7 @@ static const table_entry_t uimage_type[] = {
 	{	IH_TYPE_RENESAS_SPKG, "spkgimage", "Renesas SPKG Image" },
 	{	IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
 	{	IH_TYPE_EXTLINUX_CFG, "extlinux_cfg", "Extlinux configuration" },
+	{	IH_TYPE_EFI, "efi", "EFI applicaiton" },
 	{	-1,		    "",		  "",			},
 };
 
diff --git a/include/image.h b/include/image.h
index 606e7d49169..a04925aa829 100644
--- a/include/image.h
+++ b/include/image.h
@@ -233,6 +233,7 @@ enum image_type_t {
 	IH_TYPE_RENESAS_SPKG,		/* Renesas SPKG image */
 	IH_TYPE_STARFIVE_SPL,		/* StarFive SPL image */
 	IH_TYPE_EXTLINUX_CFG,		/* extlinux configuration-file */
+	IH_TYPE_EFI,			/* EFI PE image */
 
 	IH_TYPE_COUNT,			/* Number of image types */
 };
-- 
2.34.1

