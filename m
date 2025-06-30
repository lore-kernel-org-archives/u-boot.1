Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52F1C8302F
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 12:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FD2F82E8C;
	Mon, 30 Jun 2025 14:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VEhTyKJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03DC081D6A; Mon, 30 Jun 2025 12:08:30 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EB0E81D6A
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 12:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ab112dea41so885291f8f.1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 03:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751278102; x=1751882902;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wLI1MO6u7Id62OYe2UfRpgXDtUulBmwu4OrmZcD/iTs=;
 b=VEhTyKJqLxe3/zJfkJTd/QXu0BtGBdmGJW1ma9qjB0ZKdCFIki+SfIUkjM51FSgbjb
 lRZMJVtyIZqPJswNe98KaUx9qD93+39ndKyTQqDPdSmIGIbNdTA19s5f1KHJeftZK+ub
 fHMK/LOwnGekdc/DcL9B0uMzBGK00Jgja9xjE8SMqRPy+MjnFjxSveF4/Hu1NL5JV8Tw
 ZqeseEvRNviXDFx+ZDmIYmsfxogMLdpzJTKj3nNDiXNZFdy6Jo2bsWlf60dDMN1z9Xvx
 s5+uMGY08F4SFOR6pN/7bCWHe3mOzDbaTwfj2VA9eHcj8YtqwA/sjE7q6TjmHseLGQCM
 QiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751278102; x=1751882902;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wLI1MO6u7Id62OYe2UfRpgXDtUulBmwu4OrmZcD/iTs=;
 b=Szc3X/pxA9r0stlocUdRAtd6bud8VCi1zGQUgwu+BoKUpRjIYosu1Kvi16VgEOBLb1
 hN9ZLY3s2iyMpQeCm9TxLKgK2GDcZm28LHkLf9uRr1nmenOZhwLICEdYLuRb8QVbz3Nb
 5fSLn940vcyFow4bCil8UR3r/eKy8AAD+47KpkoNIyUA8+HVxsZkp6hX75358nxd1s2P
 WcqxKmL+s+FnV3NFKfuZJRBVuooLVhg1AnRbylgO3RsYmBI700nxYCcDLf5cbUqlAjUA
 MXzBMSVQtJ0PF+J2uvNZMqYpTKRhPPbSx3U1r0vDh501B14nZH8o0FiVidMRHn//S3IC
 1vbg==
X-Gm-Message-State: AOJu0YwzxWz4lSm2rHNyuREElV8WVFBff2aacRdvGiI0ex1qgmwxc+iH
 zGU4zbTfF8C89iseH06YtzGJpxHXgKZfhfHViL6Wz/xwxnCmX9FGT5G5VNKKPqtOirE=
X-Gm-Gg: ASbGncvC4kfLOZKwbBlGqbNgPTmIYwH3CZuDrqrlfQ19RVHgqAXEud6SeVoFEK8TY+X
 TYcUkriTy23v5YuS88fKzArPTXnYhT9nEQb+DH1pheXI0orAx0mR2meTR3VQI8O6/ReZrph0sv5
 WFyzxFHs1tlxhmpqKGsEviCpOry0PMHD7KMeaPObq9GwEbhmeN205BXy9JTPSTku+iGpqrcX4fF
 gnLH662cKNihlK3+t29MaszbhxhlxPbun+0mN3DnBLfo3fI4mHIEYFHrSd0JMULFPjIvpaoUb44
 styUBVJ5gKIjcuq0Jm+2ccM7VZCf7ArzTrnp7bL1UsmjlWvykzDVnCxTH7NCvLaqWyvMA0I5Gp6
 eeLWbOUvt+rNwVZbJevdjkDLmuYmQ3OM+JWAPIpLKzjNwwUaiVeDX
X-Google-Smtp-Source: AGHT+IGKGnZU4k4AQgMrRLvpkdj7n8w5VfRsHtBtWhxR86xZrOfwTh6vMR6TjdRL7W1GiKGTrioFkA==
X-Received: by 2002:a05:6000:2105:b0:3a6:f2c1:5191 with SMTP id
 ffacd0b85a97d-3a8fda35afemr8328149f8f.4.1751278102457; 
 Mon, 30 Jun 2025 03:08:22 -0700 (PDT)
Received: from [172.18.0.1]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f923sm9737883f8f.89.2025.06.30.03.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 03:08:21 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 30 Jun 2025 12:08:15 +0200
Subject: [PATCH 1/2] video: display: refactor display_read_timing to avoid
 code duplication
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-read_edid_cleanup-v1-1-ec7d425472c7@baylibre.com>
References: <20250630-read_edid_cleanup-v1-0-ec7d425472c7@baylibre.com>
In-Reply-To: <20250630-read_edid_cleanup-v1-0-ec7d425472c7@baylibre.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 30 Jun 2025 14:18:06 +0200
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

Commit 2dcf143398ad ("dm: video: Repurpose the 'displayport' uclass to 'display'")
left the display_read_edid() function unused by mistake.

Mark the function as static and reuse it within display_read_timing() to
avoid code duplication.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/display-uclass.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/display-uclass.c b/drivers/video/display-uclass.c
index 61a73e1bc2a629eae6a9210434641a9babaf9dea..57e730538dfd70513c4746653719440d973aed6a 100644
--- a/drivers/video/display-uclass.c
+++ b/drivers/video/display-uclass.c
@@ -10,7 +10,7 @@
 #include <edid.h>
 #include <errno.h>
 
-int display_read_edid(struct udevice *dev, u8 *buf, int buf_size)
+static int display_read_edid(struct udevice *dev, u8 *buf, int buf_size)
 {
 	struct dm_display_ops *ops = display_get_ops(dev);
 
@@ -59,9 +59,7 @@ int display_read_timing(struct udevice *dev, struct display_timing *timing)
 	if (ops && ops->read_timing)
 		return ops->read_timing(dev, timing);
 
-	if (!ops || !ops->read_edid)
-		return -ENOSYS;
-	ret = ops->read_edid(dev, buf, sizeof(buf));
+	ret = display_read_edid(dev, buf, sizeof(buf));
 	if (ret < 0)
 		return ret;
 

-- 
2.49.0

