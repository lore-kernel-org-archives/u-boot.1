Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF61C54F32
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 12:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76CD388A2E;
	Wed, 28 Aug 2024 14:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VWodHQFv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6CB688A2E; Wed, 28 Aug 2024 14:10:54 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F19088AA7
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 14:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42ab880b73eso59982785e9.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 05:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724847051; x=1725451851; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSCk/K3y0znMBwS36qz04ulKJ9c8kUuxfDOEXC+T2eY=;
 b=VWodHQFvhvknrees0AVzYVR7rHKsD8oQHl7LeGQ9W2vtr02mH0NtINHnX1fA8+GER3
 E4Gh1QRFh+nPZ3wvWGlk4y9hCEU0L2cupWY5hez+fG+Bl7/fmR5JzVkKbByKVadf/Iwe
 /l95UThNbGeKFc1FY7w8GOmQzzRvj/P69j7UpJl5fsYderY6TsKPp8/kXpQuF1ycKGeI
 TE2peKG8loQHxQP8Iz+K9aty3ny+z/XlGiRQuiMsKX5IxFgrxODR2G6SkgBcX751DTvn
 Q93hyhIJycTPEPm3q2mPji9nRwKJYp2z2xlNI41PZ+GhzkwO7srEyvl1fnWaFiCSU4dy
 f6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724847051; x=1725451851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pSCk/K3y0znMBwS36qz04ulKJ9c8kUuxfDOEXC+T2eY=;
 b=YfHpqvb43UrQLHDnnnys728qrYkQYBWpmxwp7QQbi29ZGSqIUIrPIIf3lbnp8uxBHI
 +jlzeDD4Yt/LBO1/uDKIdzLEzhNeUGKyCz0zYyUbxHdbDZuI4kbJGY3KTyN7aZ9/yeXK
 c/QOA3SYewQYVIE1uTmVwMemhk5N3P0eBaT4XV6oio8I6SLg5+qXrqaZgXZLZCjQhyuf
 sGUmoLIoUp/cU1Bs0yMRQ/ZgY2JkgCnns6eXm6uJlY8L6/ZP8DXZBsfFPA16A3B5n5Q/
 D90BYVdVuLWNrZAE+lfuAwDTQDqkvfnQmrD1DyALRDGHYIDaz2qgywxyCkdZTAS7Nik4
 XNOw==
X-Gm-Message-State: AOJu0YwGZib6j4GXLO6GsoPZRZ8z9rpsdo/pm6UrMfz/OHM8Qq0M0AlB
 Spq2Fv6Lw507YBZBvPRlswBzHxYo54sMZMkyWnBfTvNNXa0cnPOvO0tMM2Vps3SyaaJ1YH6+98v
 AP1I/lnHg
X-Google-Smtp-Source: AGHT+IFKE6vEyo6n8qObhIyPYf9gI37xSGt99ARlKlY8CyQ9mWMeThTH6iwkh9/EwurB5kVKxA5Ptw==
X-Received: by 2002:a05:600c:4f83:b0:426:6320:7ddf with SMTP id
 5b1f17b1804b1-42ba66c1a10mr10959975e9.35.1724847051555; 
 Wed, 28 Aug 2024 05:10:51 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:8ac3:aada:f033:985a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639687csm19470365e9.8.2024.08.28.05.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 05:10:51 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH 10/13] net: fec_mxc_init(): do not ignore return status of
 fec_open()
Date: Wed, 28 Aug 2024 14:10:33 +0200
Message-Id: <4d8009789411a42fb860fcd00343c73d8fbe628c.1724846454.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724846454.git.jerome.forissier@linaro.org>
References: <cover.1724846454.git.jerome.forissier@linaro.org>
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

The fec_mxc_init() function currently always returns 0. This does not
allow the callers to detect when for instance the PHY initialization
failed due to the port being unconnected. Fix that by returning the
status of fec_open().

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/net/fec_mxc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 0a0d92bc2c..2dc1364bee 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -615,8 +615,7 @@ static int fecmxc_init(struct udevice *dev)
 	if (fec->xcv_type != SEVENWIRE)
 		miiphy_restart_aneg(dev);
 #endif
-	fec_open(dev);
-	return 0;
+	return fec_open(dev);
 }
 
 /**
-- 
2.40.1

