Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011A7EE645E
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 19:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1068414B;
	Wed, 31 Dec 2025 20:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="p5gfU7NT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F6EA84164; Wed, 31 Dec 2025 20:22:50 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32F9A84105
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 20:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CDB2A3F2D2
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 19:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767208967;
 bh=uu3sohSYh32EydX/mQB65OR9vWevz384t23YR0nbN0g=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=p5gfU7NTrv9Nxg9FxDbyx8s08+CjH6VmdsWVrHIuu5V9+qxaKu9TD2/x/8vxuyb+3
 Qi2s1LshKhRkwOlL1frYHTesvvzqa/skOv5lK799QF6FA5EcGMUFzI+4vKOqmKVYkl
 3k2g35tL0cpSjwZOFpKH9vsQcfl58NRqzJdQf/5EICYAC69rK5jFB7b54Gbrw7NogV
 yWwaifhdZ0LWKED+jIvmZUNOf6ZGeFIkfmA8dYdopGBiTzb6FUteR46dQjLyV+Atzh
 b2sDx+ySwioqsKuuaxJIrjawJ4Yf6eo1t92uh1iVlRVbhwBX1gtiK7is7iKsV5RMHN
 4X5p2yRnB+FSl00Rul/YqoTjLBlDl8msVwKZJECqJXL8TDr3gaC2oaVMk/njpmv7vY
 LT6ZQKcaM3cm10CZckbSJoZ0wub8Xu5QI/jt8sa1UqyKQmbuQHI3iRmcwg2DC0KI1u
 rTWYvVY0YcWl/GvsKlfClA/YMkTxJn1h6W6EiA7Jow5Rr7LtwlDQxs6BF+Ffv5xFUa
 eWnHZibpOxbqq9UloTOapnWy4f2wGl/LNMw4Yi8E65rwKdUNuHABWn0LEXnCoLZSO/
 m7T6CWuHrQauDKDw4DM+9dyqB3/ycP8bvGBXcurHrSgKyqeV410+HwxaweRqSCWi9V
 eHhhQOBon37ID6GJFrEpifLA=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fcf10280so7891036f8f.0
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 11:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767208967; x=1767813767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uu3sohSYh32EydX/mQB65OR9vWevz384t23YR0nbN0g=;
 b=DLNRmogvImezSvY4K+n69fc/9yVW9yc2sT/YFOkmNnP7KwW/egMSIiFcugY66JCltQ
 XgNejvsnij8OAm0yPu2LgJs1IhQYxR19bFMkm09KpFc83HQ6Z0GFgLSQhNp1r7QoAXc/
 A8Vm5Esx6EbGTFZ9F6KnpAMaCSXmaoujHi0krtMblRSUeDNIG5sdvJoNINQ3k6iC4ey9
 Ft6c/sJwXhH1L0DEZ7ulK25nQlKM6yIaUmaXtHDH0uQq031ZfOsUZrEyEVnDIZkflluy
 IJPCnnGA41DS9as7EMxgf4SlHWQ01unHCELvFX8yXNHdyDd1pFO4SVTIGAjz/rX4sdEd
 voXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8QMPGitvbXnjfSv5erDpNZhRw82MQbnyVcrB81Gv3T3DQ3GqdxQPu1cISdyQ7bTTKJcYEYZY=@lists.denx.de
X-Gm-Message-State: AOJu0Yyq2dAY3pNan7nFJ/SpqICo2t21SlxbfUTMzCCQf/xNyR46T7Bl
 jvY0NNX1XyNB1DaOCJeW/6Ssksa79ywN9bpygZm5RVIsURPRlDsUBWbLaDYqc4L2GabNeo2Suo8
 PxMygrz80WdKZBBPmTPuQ7QdCUm8ZQ5eKLOkfwVtIvWwhI4xGaa+SrRVdnkJedH6cqLJfrCw=
X-Gm-Gg: AY/fxX4gE9ynEttTrJTql8+joCWzeYX3nK5fHg1OwXhJa3Q8obuq9OwuZly4UQdHBkd
 /wXxJc90bg1bt+QGnFD1FbKzxeUVzBXPaK0vxYri6+mwQFW25kH2jQi7v6PBm8T7O/NdqGSOWuy
 AZqJzEkAYc3KVRKCvYVIkAxx7GbZEtC2wnmGAa5LUG08cFrYfS+93gfnvavXhsD9ZMmDkbYjOb3
 Nt3/vfl5J6lGd7sGM0UwqbCCnwc8yBpnPxaJcZ9w2rFVBQpHCC4HX8FYH5vM4nx3p0ls/9IORBO
 yMSVQ1mYy44R8w9sWAoo2fvt+U28iRDUoHCQH0eNVXE/IUa17Btf+fCUbKN33Q/n2VY/dQY1VYu
 5ITOQ8ZU2W0yrRnrGuq1mvzgY8HCJdokZUl/kF7WRheZ4PDee+D1z/Ni0iIs+I5/AZmIyDFOfNx
 +Q
X-Received: by 2002:a05:6000:400c:b0:430:fd0f:2910 with SMTP id
 ffacd0b85a97d-4324e4cd09emr50667367f8f.26.1767208967357; 
 Wed, 31 Dec 2025 11:22:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqnPEFCLe8eL72L8DrHwxX2fnP/Z/+Afsa2oZ+8cxz+qSffu8eGGG2NY9QTr06xay0YgeEZg==
X-Received: by 2002:a05:6000:400c:b0:430:fd0f:2910 with SMTP id
 ffacd0b85a97d-4324e4cd09emr50667345f8f.26.1767208966999; 
 Wed, 31 Dec 2025 11:22:46 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830f3sm74830609f8f.22.2025.12.31.11.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 11:22:45 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] video: correct label for cyclic video_idle
Date: Wed, 31 Dec 2025 20:21:57 +0100
Message-ID: <20251231192157.248090-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

When the cyclic function video_idle() takes too long, a message like the
following is displayed:

   cyclic function video_init took too long: 87707us vs 5000us max

The text "video_init" is misleading. Replace it by "video_idle".

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	fix typos in the commit essage
---
 drivers/video/video-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 53641fc28b6..228d6bacc58 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -734,7 +734,7 @@ static int video_post_probe(struct udevice *dev)
 		uint ms = CONFIG_IF_ENABLED_INT(CYCLIC, VIDEO_SYNC_CYCLIC_MS);
 
 		cyclic_register(&uc_priv->cyc, video_idle, ms * 1000,
-				"video_init");
+				"video_idle");
 		uc_priv->cyc_active = true;
 	}
 
-- 
2.51.0

