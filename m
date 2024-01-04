Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966A6C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 17:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B100E878E5;
	Thu,  4 Jan 2024 18:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KP5O3wBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7492A87930; Thu,  4 Jan 2024 18:13:52 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94CDE877D5
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 18:13:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d3c4bfe45so6283765e9.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 09:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704388430; x=1704993230; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g96/FLUPxCWETfyGDBBBwzPoTEFyJI5CMD6mEUwfDs8=;
 b=KP5O3wBYPvIea25VPq+VvjXnDh1lzgkoM0tfPlawJ+CuJ0pDDnldfZunjWid/Lj3aK
 9haQSzoMtHXXYY7RAO/qOhb2Q5JU/36797TLtvnw1JHFnf3IGsL8QiEHvBZ7fsvy6mhV
 ZyW0s2ENI2/n4YT77qhujE7AYbOIsjkzReCQOr57pFMiQ5GBlARH4rxfnsq/f1Mpe3sC
 +YzrCwU5j5AV0gQmdYX4JkrRinxywgM4HIZ2oYo0aBbNMVKoH+hR51k9Oy4cES2CyYcU
 2UYXG9S8bMBj/+DQYnsrY2h1YWLg/P65l0EuusQX3Yy1aX6BR+9dHD0fcA3E7cfYvY3q
 Jcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704388430; x=1704993230;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g96/FLUPxCWETfyGDBBBwzPoTEFyJI5CMD6mEUwfDs8=;
 b=hdX8uIMHfEHF2/9hRKDOaSdVvnqlxz2U/YCBeXQ2LjzMhXN4Evl82JFTmEMCcnOLAq
 kXZbtFlRJL/gszK40EZ1cHvi5JxU+dtYg4SA5PB5qGsOF/RwTSTA1fm2JGWIf549aTNk
 p3Dp8lLS4a2W74wtjtPxiqFoDZOabADwE8311nFn2jwIOfKvWqnR2oyhGEGd2nsugpdO
 EEyiajStw/gGLhfoZZGPQcngfThNmBoZVekRsqas5RyUCZAH6exhAYgly7EMdhlz4HkD
 zpA/KuY1Nfq1/dpdmy2Oxle46DggOz2accrmgC9aVgt44YPRovpPErxm2JJCqQCKePW0
 m/nQ==
X-Gm-Message-State: AOJu0YzTYReT3xXp42VqDVk1huTOW/epT4zF65C3kv1AIfIP5lKmf2up
 hxfQyZh8EQqogMlQ9oJUYxb3Jkmx61zZ9LDSm30/gSDSEm6taA==
X-Google-Smtp-Source: AGHT+IH13NPip5GE7k0d2c1jiHJAxQZqdJxbBdcL3wM3WxtVAcYe4hO/YcfAoq85X5MMLm/Sd2AnRw==
X-Received: by 2002:a05:600c:188a:b0:40d:37c3:30d2 with SMTP id
 x10-20020a05600c188a00b0040d37c330d2mr253999wmp.312.1704388430019; 
 Thu, 04 Jan 2024 09:13:50 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-230.as13285.net.
 [92.17.96.230]) by smtp.gmail.com with ESMTPSA id
 p5-20020a05600c358500b0040d39d61a94sm1854086wmq.1.2024.01.04.09.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 09:13:49 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Mark Kettenis <kettenis@openbsd.org>
Cc: u-boot@lists.denx.de,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH] iommu: dont fail silently
Date: Thu,  4 Jan 2024 17:12:22 +0000
Message-ID: <20240104171335.342540-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.42.1
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

When attempting to probe a device which has an associated IOMMU, if the
IOMMU device can't be found (no driver, disabled driver, driver failed
to probe, etc) then we currently fail to probe the device with no
discernable error.

If we fail to hook the device up to its IOMMU, we should make sure that
the user knows about it. Write some better error messages for
dev_iommu_enable() to facilitate this.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/iommu/iommu-uclass.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu-uclass.c b/drivers/iommu/iommu-uclass.c
index 6babc0e3a672..dff3239cccb1 100644
--- a/drivers/iommu/iommu-uclass.c
+++ b/drivers/iommu/iommu-uclass.c
@@ -86,16 +86,16 @@ int dev_iommu_enable(struct udevice *dev)
 		ret = dev_read_phandle_with_args(dev, "iommus",
 						 "#iommu-cells", 0, i, &args);
 		if (ret) {
-			debug("%s: dev_read_phandle_with_args failed: %d\n",
-			      __func__, ret);
+			log_err("%s: Failed to parse 'iommus' property for '%s': %d\n",
+				__func__, dev->name, ret);
 			return ret;
 		}
 
 		ret = uclass_get_device_by_ofnode(UCLASS_IOMMU, args.node,
 						  &dev_iommu);
 		if (ret) {
-			debug("%s: uclass_get_device_by_ofnode failed: %d\n",
-			      __func__, ret);
+			log_err("%s: Failed to find IOMMU device for '%s': %d\n",
+				__func__, dev->name, ret);
 			return ret;
 		}
 		dev->iommu = dev_iommu;
@@ -106,8 +106,11 @@ int dev_iommu_enable(struct udevice *dev)
 		ops = device_get_ops(dev->iommu);
 		if (ops && ops->connect) {
 			ret = ops->connect(dev);
-			if (ret)
+			if (ret) {
+				log_err("%s: Failed to connect '%s' to IOMMU '%s': %d\n",
+					__func__, dev->name, dev->iommu->name, ret);
 				return ret;
+			}
 		}
 	}
 
-- 
2.42.1

