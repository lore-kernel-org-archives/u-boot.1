Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92222C4706F
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 21:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F412E87B88;
	Fri, 29 Dec 2023 22:07:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=essensium.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=essensium.com header.i=@essensium.com header.b="bTpZ3mEA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56EA787B72; Fri, 29 Dec 2023 22:07:58 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F8487B61
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 22:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=essensium.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hugo.cornelis@essensium.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33732ca677aso10849f8f.1
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 13:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium.com; s=google; t=1703884076; x=1704488876; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G9/SGZWgwBnT4ppvEjI+wJS6DJpicXcI5prxaOcchZQ=;
 b=bTpZ3mEAFFvk3o6NxZJ4t0xhI0eeKFWyTP5/9/6wJ9Koor+DFXWkbSltbUKX0OzITD
 lFqop3ooiXBvWuVcQ6jkZ1vZaMjTYZNJxQT9FfzAvcF+Ld7/dDgdG2BrlqbwwCRPTiCS
 Xw/RDRvzh915O4aEu3lzj+BfpvZ0qt76mjF0nKR0ydkiguZ7Nyp0v+mQcGDIenSg7aT1
 TcdD1v9PwpL53cIwZ6z4x6BTaZQTY++J2D+CPC8DkMLwzToOWmCqJW2UicDFnu9fBFSN
 ym/awFboHAXiZwOe0bXqK/22hmzEsEKGPDVaX+gYJJ7MtePEEL+ND3+oY5VsDpCclk4I
 ngbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703884076; x=1704488876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G9/SGZWgwBnT4ppvEjI+wJS6DJpicXcI5prxaOcchZQ=;
 b=s6wLqIUCYU0jc9pIsAXHe2URc/keDkvk6MkTIXElNJx+i+3zIKYeqCMigZZGLzTZnb
 lVpcHsYs1xFydMt2T3PNPCIjLSIcE8vBWz/YX+IEOktnmKah8axTYLiezpvC40YaANjz
 +aup9JjnkyjjBrM3vPNqV7WdKeGXRABnS76cwC5/9djRBUIFZ16BDfTOFGmXPVP/iqBH
 pZm6Xctv+MSqm4eJlNbR+73TGJdwLzUlR+ukUpqq7WYr86gxw/K5wHLO3vHGKeGGPtXX
 j9Um4BPbRzfJbPWNd1lMiBQMA40iD7j7vh+dRerMgHJVz45FbsQpw3rdr/doEUqg+/IB
 uAyg==
X-Gm-Message-State: AOJu0YwnYI5fuqYR2cJZlpXmqvFWt8nvVcET+wbeTVwniz7mp/0OobJT
 dQcf5UvF2LmsTSUi1PLACUBdD5mh4zH3dsDBQvfF76fUxKU=
X-Google-Smtp-Source: AGHT+IEg6IjKz30af3gBYDAfNsxosEgMqCWWYEtlUV9LflcsirHP7noxqzGYuUU4h5yAcNtQU3Db9A==
X-Received: by 2002:adf:fa4c:0:b0:336:7a65:eb7e with SMTP id
 y12-20020adffa4c000000b003367a65eb7emr7383293wrr.0.1703884075793; 
 Fri, 29 Dec 2023 13:07:55 -0800 (PST)
Received: from hugo-IdeaPad-3-15ALC6.home
 (ptr-4h549o5tww32w5ynsss.18120a2.ip6.access.telenet.be.
 [2a02:1810:952e:3700:2ded:4ef:219f:78c])
 by smtp.gmail.com with ESMTPSA id
 i2-20020adffc02000000b003364aa5cc13sm20144703wrr.1.2023.12.29.13.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:07:55 -0800 (PST)
From: Hugo Cornelis <hugo.cornelis@essensium.com>
To: u-boot@lists.denx.de
Cc: Hugo Cornelis <hugo.cornelis@essensium.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] image-host: increase path length when setting up the
 cipher.
Date: Fri, 29 Dec 2023 22:07:38 +0100
Message-Id: <20231229210738.82387-2-hugo.cornelis@essensium.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229210738.82387-1-hugo.cornelis@essensium.com>
References: <20231229210738.82387-1-hugo.cornelis@essensium.com>
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

This patch increases the maximum path length of the filename
containing the cipher key for the kernel from 128 to 256 characters.

Signed-off-by: Hugo Cornelis <hugo.cornelis@essensium.com>
---

 tools/image-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 3719f36117..b0012a714d 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -376,7 +376,7 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 				  int noffset)
 {
 	char *algo_name;
-	char filename[128];
+	char filename[256];
 	int ret = -1;
 	int snprintf_return;
 
-- 
2.34.1

