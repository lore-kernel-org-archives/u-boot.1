Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6975FD3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9DE189231;
	Fri, 18 Oct 2024 01:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UuWIUBOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94C43891E3; Fri, 18 Oct 2024 01:25:01 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B40D089208
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-836d2437852so63917639f.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207497; x=1729812297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b94H8On+a1PIqzVzkTsDchN4nHphABEZVTbm9qpQs3Q=;
 b=UuWIUBOhEe5rAHk4wg8Pd+PDQSrN3hkkxlRTuZ0U7GPlhbGpP52VdxiKiSENCAfNcm
 jPcbbsT142BmKal4ecBc6f60nnPKrtWF0auq7YjcJ6EPX4XItJ1BfwSGp5k5eo4LZWda
 Vg+qPRaMNDy4PMjJcJdGCDcNIvTSMRNGf+p80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207497; x=1729812297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b94H8On+a1PIqzVzkTsDchN4nHphABEZVTbm9qpQs3Q=;
 b=dfEQKy/Oh8nFaf26Iv5CWAqn5SdnVmSAmJUG2PEXg9ab9eGVze9dbNuuvT2QOA/YiT
 wglR3FScDOMywZV2KTmNdAq/tqRr60eZmAeTccdFWY++VuZGutS/hRHWTO9iy5TCQVgy
 Zx2lB05lADqED6fZD6z9CUbBIaAVGSJRmzuwpoaOvl+F+lz83md1rpNqamDa98AOXcf3
 1D81Cdxfe5smNNjLp/Po26yzQ4u8AF6Jhk2Ke+0ZguvLuoJr9ZEHUyvhDEETs+6BILHC
 wsPVOitbAHYNjsJ9s5F5/whkFhL6I8QFMCvd6wpSr1PdYkIGxyJ2hLJ+stjxXhxUljLY
 bPOA==
X-Gm-Message-State: AOJu0YwSVB7d0rleiUbOYFzYx4GFFQvphltHo/RXo7vM/6t8vB1AWOvR
 cv1T1A9C5DyEOjszs0yI4kmRaaCexQ31tVPKhxyI7PH3oTZ5VfuYvPWLm2RWTb73aTx/f0mxXN8
 =
X-Google-Smtp-Source: AGHT+IF7CvPGAW+9ai1pYoLM6J0z762dCNyWuFlJbX3WQ8Q9u3Sd3LvDlf6kB/AixFHLvEyfyisHSg==
X-Received: by 2002:a05:6602:168d:b0:82a:4480:badc with SMTP id
 ca18e2360f4ac-83aba63a57bmr51101039f.10.1729207497342; 
 Thu, 17 Oct 2024 16:24:57 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:24:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 17/34] image: Add a new type for logo images
Date: Thu, 17 Oct 2024 17:23:56 -0600
Message-Id: <20241017232413.724808-18-sjg@chromium.org>
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

Add an image type for logo images, which U-Boot supports reading within
the PXE code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image.c    | 1 +
 include/image.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/boot/image.c b/boot/image.c
index b13644b03dc..eaba9eb4332 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -185,6 +185,7 @@ static const table_entry_t uimage_type[] = {
 	{	IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
 	{	IH_TYPE_EXTLINUX_CFG, "extlinux_cfg", "Extlinux configuration" },
 	{	IH_TYPE_EFI, "efi", "EFI applicaiton" },
+	{	IH_TYPE_LOGO, "logo", "Logo image" },
 	{	-1,		    "",		  "",			},
 };
 
diff --git a/include/image.h b/include/image.h
index a04925aa829..0d1adee499b 100644
--- a/include/image.h
+++ b/include/image.h
@@ -234,6 +234,7 @@ enum image_type_t {
 	IH_TYPE_STARFIVE_SPL,		/* StarFive SPL image */
 	IH_TYPE_EXTLINUX_CFG,		/* extlinux configuration-file */
 	IH_TYPE_EFI,			/* EFI PE image */
+	IH_TYPE_LOGO,			/* Image / logo */
 
 	IH_TYPE_COUNT,			/* Number of image types */
 };
-- 
2.34.1

