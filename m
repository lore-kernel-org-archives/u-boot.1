Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60C4C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B9BC881DB;
	Sun, 21 Jul 2024 12:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VRD2Xg3D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A52AF87F7D; Sun, 21 Jul 2024 12:09:55 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C06687702
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-367940c57ddso1490170f8f.3
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556592; x=1722161392; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdCbfHaxIGUGoFdgR3DQv+mfj/r1qRZJyDkqjQ7IhYY=;
 b=VRD2Xg3Dyi5DxYzelJcMyGpi+7+YXEZWSWDUGK+Mju0vLWs7C1zELEbJenaFeLe0w+
 Ifs5NrrzGRmSZfxYhau9BNOsrC+nZzHeIaRwkljBqWJh3VkRjGw5oV/p60ZZ98od2byT
 h8DBuSk725076xbf7Y8pUsV1GZv/4SBI+elu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556592; x=1722161392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdCbfHaxIGUGoFdgR3DQv+mfj/r1qRZJyDkqjQ7IhYY=;
 b=N28+iF2+L2UK1M0wUDABFSa8UHyifVsIBQbkGe3nVyDPhEpdjXN4vlMBLWLB1TKNa1
 XlJBrUiVEzQcbLqliWk4oQXeoJqdy9hYM1Krtsitu5pBQaf5UCoNtmYssyPW6kD+YYZU
 5zcFWOD2aZJpNHkzICWllnIXXjO0NnYABQ950zz4C2NHMt4UrUNeCSBFHB4GgobgaCrQ
 jrqdIC/+2azdg4MlanzOwYP7aZoOpURg17ICvYw3wPPChJYZ9YCR6RQ23/A4K2dVpPL8
 y1g9M7iCDB7FUGs+ZcXe7TPyPLsrOju5F+NeGhLZK5eM6/4ViqWzWUArB8/0rhjMl2jv
 ZWFw==
X-Gm-Message-State: AOJu0YxgPdv5l7MPcT8fxgg9+s3bn5aQzlzLSxs1QoxMHBxjcQaoQ8ri
 2ecj5jVv2jSM4YV6K0l01GHz976SUzbW0cgFFvIGHu6sHG344kTDKdyxrSIfiR1t8U6+OM+ryv0
 =
X-Google-Smtp-Source: AGHT+IFsYk0OkRtRUAk0T0dB+wC+Of2f+VE/jzcW6zag3vS1sOCDBTlmLKxwOFjJO+WTFmMlAe2ZIw==
X-Received: by 2002:adf:e6c9:0:b0:369:b7e3:4983 with SMTP id
 ffacd0b85a97d-369bae01bdemr2422756f8f.1.1721556592279; 
 Sun, 21 Jul 2024 03:09:52 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69013fasm85096265e9.12.2024.07.21.03.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 03:09:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Jerry Van Baren <vanbaren@cideas.com>
Subject: [PATCH v3 04/21] fdt: Don't overwrite bloblist devicetree
Date: Sun, 21 Jul 2024 11:09:22 +0100
Message-Id: <20240721100940.3202027-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721100940.3202027-1-sjg@chromium.org>
References: <20240721100940.3202027-1-sjg@chromium.org>
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

When the devicetree comes from a bloblist, it is currently overwritten
by the appended one, if present. It should be preserved.

Adjust the logic to support this.

Fixes: 70fe2385943 ("fdt: Allow the devicetree to come from a bloblist")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/fdtdec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 5b3b26df968..01048b19737 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1677,6 +1677,7 @@ int fdtdec_setup(void)
 				gd->fdt_src = FDTSRC_BLOBLIST;
 				log_debug("Devicetree is in bloblist at %p\n",
 					  gd->fdt_blob);
+				ret = 0;
 			} else {
 				log_debug("No FDT found in bloblist\n");
 				ret = -ENOENT;
-- 
2.34.1

