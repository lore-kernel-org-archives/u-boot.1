Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5FFCF58E7
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC6E89437;
	Fri, 20 Sep 2024 10:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ccNk0t8t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1B1F893BE; Fri, 20 Sep 2024 10:13:38 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72DBB89438
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c3d209db94so2234054a12.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820013; x=1727424813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfb3fVBRE4QDu7o1T45Lr8rikHqKiUqDfbNjYxtDrx4=;
 b=ccNk0t8t9UtOn1VYsxEA2l0n7/Ml3zql+nb2WSLXJ6Zco90EEGHT74dxJiK048FyPj
 6sC6WKsKO02HR7k2CEG3GLQto+VNn8B7hsQhyC7yWC28haQWkuc+/NkHOpFGaMhxtt84
 PkMJtXgBNKVVEqfpKon5ZChohLcO0MAtxw2Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820013; x=1727424813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bfb3fVBRE4QDu7o1T45Lr8rikHqKiUqDfbNjYxtDrx4=;
 b=WEGAJKfzB6PfzWgoGxtBgsi4F9e+IZkEprjyThjVmws8qa6ABF+c8MTmRHq2EcwH6S
 SZe6c2is4pzo/dp3819ijNJagxKmcmgAPNDhTFOSomE5I2zLG/2Kovzvl7eD7GGsXi3n
 g4csn3iicvL9v9tY91BY3ziRYGVi4NaRpNZ56EMHVIP2kFxIhGhIbSHwNaMb7SRMCj0x
 JR0sz/GH8Ddm3cAcuhcx6VgytCtLUUA0VCb1qH7ofMqhJTYfdgZuZ9eKBEyY8eCQ0wsc
 iW5V2ywjV2hBuw2jD254DmscLXOMv61U3JkuJqGzw+O15yKAZybJarQ++ZaFVRjoTDGM
 4oUg==
X-Gm-Message-State: AOJu0YymJdoOj3ln4AeMQ0GJKpirGSzN08Eq7XXBwU5/h1VzvpKNnRiV
 RYIIM9WtwRxLLm5OPZ5rfTedWpuDaCAw6qeV38J1wfroEZ2S/nmFWr4LPpbMaEWZPiO9KD2p5XO
 DLanv
X-Google-Smtp-Source: AGHT+IGxx6eaOUcO63+zHbA+wN3m8pp04eFd+52iXAI+AlkoYd71xCuz/829N/I4fnJmwdJNqifZFw==
X-Received: by 2002:a05:6402:5c8:b0:5bf:fb:33b8 with SMTP id
 4fb4d7f45d1cf-5c464dfbcf3mr1510441a12.34.1726820012590; 
 Fri, 20 Sep 2024 01:13:32 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/18] spl: Report a loader failure
Date: Fri, 20 Sep 2024 10:12:47 +0200
Message-ID: <20240920081309.140426-9-sjg@chromium.org>
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

If a loader returns an error code it is silently ignored. Show a message
to at least provide some feedback to the user.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index c13b2b8f714..ecd90169f65 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -613,6 +613,7 @@ static int boot_from_devices(struct spl_image_info *spl_image,
 	for (i = 0; i < count && spl_boot_list[i] != BOOT_DEVICE_NONE; i++) {
 		struct spl_image_loader *loader;
 		int bootdev = spl_boot_list[i];
+		int ret;
 
 		if (CONFIG_IS_ENABLED(SHOW_ERRORS))
 			ret = -ENXIO;
@@ -632,10 +633,13 @@ static int boot_from_devices(struct spl_image_info *spl_image,
 					     "Unsupported Boot Device!\n");
 				}
 			}
-			if (loader &&
-				!spl_load_image(spl_image, loader)) {
-				spl_image->boot_device = bootdev;
-				return 0;
+			if (loader) {
+				ret = spl_load_image(spl_image, loader);
+				if (!ret) {
+					spl_image->boot_device = bootdev;
+					return 0;
+				}
+				printf("Error: %d\n", ret);
 			}
 		}
 	}
-- 
2.43.0

