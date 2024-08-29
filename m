Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B45C83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C91388C90;
	Thu, 29 Aug 2024 16:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BNPkOiWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B96588C7D; Thu, 29 Aug 2024 16:58:27 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 050BF88C4C
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-82a13d1c8f9so36713439f.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943504; x=1725548304; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixclGoSsfN1D7gNPxGNFkSpMFxxd4DaA+G5KLLTyiG8=;
 b=BNPkOiWqJKSA9zvUh6xxedUGFJ/HoOGwADjqyIFdO/5d82OkvtEuYFYMPOagyfEf9+
 gbfl+ZQfxSDs/0I636NC94FM28leI/NQmF1f4/9aSbZyo4c4ZNwkXECy03KVBpJL8Wk/
 DaylJaLShIc4Ac48sNFJhC5JZY1PWWe8FklVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943504; x=1725548304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixclGoSsfN1D7gNPxGNFkSpMFxxd4DaA+G5KLLTyiG8=;
 b=Jw0I5ey1bMBr16aFFUAOfdH9eiWKfr8VCiPEe0QMahIwLwqIoFh4EI40dUFNE1toE2
 Lm6/Aic8hWTpR9n2pDaEzswuOKUqZrxwb/KJDYMaadBdE19Ncjv2x8nAMZ4+0ES/SlT3
 cmwvR35MWFq0E4hO5WTcclIEiHFHaAud+5OwR3xCe5oJbPfgf9z5YG/nHUtVAN4gxl86
 FC1IxX52CxYNvP3/9CgtRaH/50xfHmLWvmAUXB7hT4LRH+w17smCJiTVnoMTym/RyXVb
 lXM4dux+FqOWxnMAnJ7yzC2R7zTK8q3UwNjqq7XrV3uQHZoD2zxEqjZZMjbmKDdwHCQp
 b4YQ==
X-Gm-Message-State: AOJu0Ywe69SFDjDinKDWbP3UWrQ3C4YR2n+CqJVLmtv1Uvc5gJCzOjQf
 7mJ58VG1qqIT4yeaDqvbcM53GwO7qn82xwhjInW56hQFQiOHKO38OrgZQ2LmbG7Emqs+bDyTRAo
 =
X-Google-Smtp-Source: AGHT+IFSXe/fd8mujhoX7HwK8FG0m4GbAljQNTc9HHsDeUP4iLEQIMfATjlxgx96bIvBvFuaEn/+gg==
X-Received: by 2002:a05:6602:150c:b0:803:4fcb:6e10 with SMTP id
 ca18e2360f4ac-82a1109b3a7mr281119339f.15.1724943503622; 
 Thu, 29 Aug 2024 07:58:23 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/19] spl: Report a loader failure
Date: Thu, 29 Aug 2024 08:57:52 -0600
Message-Id: <20240829145802.1827952-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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

 common/spl/spl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index da110ee0783..143ae96baf0 100644
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
2.34.1

