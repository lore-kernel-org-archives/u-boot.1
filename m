Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9BDC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 08:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF40A830A0;
	Fri, 18 Apr 2025 10:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f67ZZc58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B45AA82F33; Fri, 18 Apr 2025 10:33:02 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2E7682EBE
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 10:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-549b159c84cso2089601e87.3
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 01:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744965180; x=1745569980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4uUpiaxIe3f9U5zJl5ydilEyTzQIzGo6H4gPBo1x1c=;
 b=f67ZZc58q5NeU4ORJqzLusov2u2n5mcFJIn3uAO+oquT2ScPNNp3h8KrBrXMQMu5Ah
 k6f9epbxMHp1577TYjyD1l8RqorJzBRUbqKcQNjupFMv6Z7fPXLFUWfQbkpaayl1fNhU
 IuCPJWAegrUvHUTpjiZslTJLJH8RnqxWYhP1pbVRX729QGhH6aZoY+MZEHVpA23lGo4r
 g/a88EojrBh9riMr9EhLuVZaO6w+cyrOyiHg8e4nDIVqgN6GvdRJzfC14hJo2qluTgeu
 CruSU/E+Q3v0k2md9IUyMmfvoNR5H4kZAR6OAeS19KzrVINAwzV5sJJJZiXDKzgG0BnB
 hFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744965180; x=1745569980;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y4uUpiaxIe3f9U5zJl5ydilEyTzQIzGo6H4gPBo1x1c=;
 b=TuKPmzANPeWDh5sWYMRKuVxYPMGfeOrZDyZyDhkseyzh/pH3bOjoo6WerXXXmR2N/s
 QcVEXcq81R2gHp4dc9b22uFcCa2zSNScL9qgdTFSLNsRbBa/Y7reYvg/apS1UNSVjZCd
 FlC1/gdjNgpxxxYZfN0+aISq8ZWmuuXFzvNjXNoZOwJNg1Xj2H48+6p2U4JgfSQ7VVuH
 ZUvOVrXguQb759XLFkDxOpkmJ1+lM5szrVQExnEu1D7iiTBhKUNGBi1b+zsonCtFNDVu
 YrrMgwg2pA7eXH9bWqgOKRunu635Ouv3McUGhhR1VJSIKPfSw2MMu2ex1BkcDX13yasn
 eiHg==
X-Gm-Message-State: AOJu0YwMsQcz2NDgSDLvsfNuqOxOZQBxBm0Ws2weKi62fm86Tde6J+6b
 TyyH4E4oxPPybXbYA8l5mOxZGfWB5wvJJLu907di3km0BQBbBpcv2rA4zA==
X-Gm-Gg: ASbGncvlgcFNHuFuLZax0OPrRsASmcP3Tq7u+Lu9ozpfGLDTxOkRiFitF8e8U4VYXYk
 tZ4TIYktFl2t6+FX81uDFiUVhUW1gEJgj+r8Tdfp1TMTb17OWMX2srU/f5b+eMacOf7MLDkpxnJ
 XR4M+mfxdSg5kI0aGsFFvlmi5xJFnJQR8UX80PMWsVXcfYY7zqhdUfWnxN11POVyYVXHL9MOtiU
 kUsF2frxEBkHFliWMkRC0d+RZlOjupMkxg9he2nBPGwnZwvPa4oEDV4GVQ3Gj0c+0fVHWx71A2a
 nVgAQjw+9MXfozf4ASX8g4svGC7x2bRz5AX/9NRMkc2TtzIU4BagL5XJd+2ak690ITQ7zMefuAE
 pYVaxrQh+KdyHbS+PVA==
X-Google-Smtp-Source: AGHT+IFlfhHj19H0BYGylky8mqg/201ohXZtktaX0SJfWJ28wkmqTKwVvemvnuAxjTloe2KkndV1mA==
X-Received: by 2002:a05:6512:2348:b0:549:8ed4:fb4f with SMTP id
 2adb3069b0e04-54d6e62cde9mr453260e87.23.1744965179419; 
 Fri, 18 Apr 2025 01:32:59 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54d6e52482esm133161e87.1.2025.04.18.01.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 01:32:58 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] tools: image-host: Fix potential memory leak
Date: Fri, 18 Apr 2025 11:32:56 +0300
Message-Id: <20250418083256.16732-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Maks Mishin <maks.mishinFZ@gmail.com>

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tools/image-host.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 4a24dee8..453cd38f 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -1029,10 +1029,13 @@ static int fit_config_process_sig(const char *keydir, const char *keyfile,
 				   &region_proplen))
 		return -1;
 
-	if (fit_image_setup_sig(&info, keydir, keyfile, fit, conf_name, noffset,
+	ret = fit_image_setup_sig(&info, keydir, keyfile, fit, conf_name, noffset,
 				require_keys ? "conf" : NULL, engine_id,
-				algo_name))
+				algo_name);
+	if (ret) {
+		free(info.name);
 		return -1;
+	}
 
 	ret = info.crypto->sign(&info, region, region_count, &value,
 				&value_len);
-- 
2.34.1
