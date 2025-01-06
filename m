Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A08DE77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:34:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6120080655;
	Mon,  6 Jan 2025 15:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EmCT9Yx4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34425805EA; Mon,  6 Jan 2025 15:33:15 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0318D801C3
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a9cb667783so112660165ab.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736173991; x=1736778791; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNzhiYaDuSY2qfMKKPj+FTxYW/XZvJ39nNjskChGRyY=;
 b=EmCT9Yx4L6D4w3Hkva2MBOPKnBlg1BcKIANMd259vejpmtWWj+hVOACxQmx5rUttaB
 4lnMA3SvMLvZUFE7pAjGaxdBY0jz9mxz+MssHzD0nok/omG6j3oXiut3QYR10t15P412
 dbUEzUSlHj9nD7Z3dEcrMxVA7xRd93ml6vYqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736173991; x=1736778791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rNzhiYaDuSY2qfMKKPj+FTxYW/XZvJ39nNjskChGRyY=;
 b=SkMYCvY3Vo+CHSczub7VvpOsqp9TKeOOgLqt9MgdR/1h1gxJMARIUGjMl/wWvc775J
 oNmiE3q+JwmAR9uOBHBWdFgDThoFbv/0+jFt73LlcrImHcUO4/L8RB4RiTkAzWkI1v6D
 35YiWH4KOJVQZ82YQNFWYCFa+utliFbsy1DOPpTjAgWl8SxAUD5bNAahHfljBSNuZ+ma
 6FTatQCL7RLPFfIKqPbrt23L0Vzf1gjLzIAD8r5Sg8SFOVLdAGGTKasFhvpXsWUx9uk6
 AhShh/yocNTvo/WUuMcKN1E/SvOSAtK7XMNyIg9CGfsiE6XuZ9HGQXJbd2+AEq6XJ/5c
 Qj4w==
X-Gm-Message-State: AOJu0YzmYPLp9TVk3t4otTavCPJ2er2dGhobAGEhYW22LXjh2uLIjz4S
 TmKTDf8A8bxIH/Ja0WUt7aOAUUbu6BVOW1e/ylKaFlsSWMuFrgN9HI8/nAeTP9rpaUc/BeORoAQ
 =
X-Gm-Gg: ASbGncv//Q0Ck0syO13qlO2LT0r8ujlu3HEdUCi19y4vTdyw6v0fWwjvJM4FPMI4BBz
 HYTy/8WbOgUCJ5HlRSucgaJBmoD4CLNNgZb7dcxuYLr93Zhyl5uKgiAsUXeNTL0ZWMw7ecwzyka
 b6SCyW49++QQ1cvCj5jR/MkhLWw4eMgYngqkg0pOx/Wl5g5MKwtMqfbICcN98uOshHzLO8lb9ws
 bz35WBpV6Ct1RoBIxh+rIXtVhpkK+VhtpBt+PGB5kQ7WVHwRha2myfFYS59m+I3fV6LJPr7+U1h
 YKL44xez4cJutfr9mg==
X-Google-Smtp-Source: AGHT+IHOVivZ7IoWH4WDy2Zavo8aql5cpRnHs/bChlN4uMUUA1/vZK0kAct3YGPFrfAe1fEaW1MJ+A==
X-Received: by 2002:a05:6e02:1d0e:b0:3a7:87f2:b013 with SMTP id
 e9e14a558f8ab-3c2d1e7df90mr444088445ab.4.1736173991239; 
 Mon, 06 Jan 2025 06:33:11 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/33] ofnode: Use 4K for a default tree-size
Date: Mon,  6 Jan 2025 07:32:08 -0700
Message-Id: <20250106143229.3023771-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

At some point it would be nice to have the ofnode API automatically
expand the tree as required, to accommodate new nodes. For now, expand
the default size so that UPL can be supported.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/ofnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 950895e72a9..ec03f6f550d 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -118,7 +118,7 @@ int oftree_new(oftree *treep)
 			return log_msg_ret("liv", ret);
 		tree = oftree_from_np(root);
 	} else {
-		const int size = 1024;
+		const int size = 4096;
 		void *fdt;
 
 		ret = check_tree_count();
-- 
2.34.1

