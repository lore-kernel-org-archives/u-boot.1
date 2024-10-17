Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D62D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C695F892A6;
	Fri, 18 Oct 2024 01:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m/FJhCGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 957648928D; Fri, 18 Oct 2024 01:25:41 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32E00892B7
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a3bd42955bso6281655ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207537; x=1729812337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhuRES6RdflloOM8gsZyQPRoox8duyX4YqH2/v1iNGs=;
 b=m/FJhCGrweAlStUtQWDi+NSXL1HnQgxNMrUUtdDcd+YrdeL3YS1M/YRA4T9NkUqIZl
 ymldfvH+zbqIFeibEKS72+zwg/IHaUMZ2L19jbJGYE+lATqfZEPp6ewDBoOfo5+IpkU1
 Vz/FWjcg7AJ2O5XIl9PeRjLWAh6j9w8f69NGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207537; x=1729812337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vhuRES6RdflloOM8gsZyQPRoox8duyX4YqH2/v1iNGs=;
 b=a4PvD5INzM17/NHJSIuDuwt/4GNMUk7Kfr81gisfnLYe+Z8CU3b7T6LB3bAHKjEfw3
 6gqTkYoUVGs878DovcG4xo9HWymcrUrKX2YFZ3adsSUHv8c2QAzfpREl+H0Xs9m5t9/b
 gWTUEU3ZFvOlaJyEDukt03C8IaFJEetiLs1LQitFZDoIducbVMD0woRTS3g+bOaajGIb
 kmF6aZIGban9pv60a2eJccS5IADJ+AqTW5XzIOYzRGCpeX3bLdMIVRVu5JDmAAyClmDZ
 +U9HsfZ0t6EHkymkde1Rh6UBBnT6MzucIJZ6eRv9Q33gcYBDAXQECwXZEP/MbkyK9atC
 Vkjw==
X-Gm-Message-State: AOJu0YyxYkdaHn8qL//GeehyAbMB9i/ugQNxnIRsVO4AOsF7C8Nt9oc3
 Z4fc+Gs8G0qy3vLB+485tZl8i3r3H+0tNxiCagP+GxI1H+wngsNb8Da3y0FWXovdfly/cPHVXnE
 =
X-Google-Smtp-Source: AGHT+IGQT5nKUm6hssQSKZ3Yj92GbWS09PkOGvDTLPh2doY6moohZj8CgWT6Yec852dI2Wp1wK3AWA==
X-Received: by 2002:a05:6e02:13a7:b0:3a3:445d:f711 with SMTP id
 e9e14a558f8ab-3a3f3fd2d19mr5408115ab.0.1729207536870; 
 Thu, 17 Oct 2024 16:25:36 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5ac9csm122057173.29.2024.10.17.16.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH v4 2/8] bootstd: Avoid calling unavailable block functions
Date: Thu, 17 Oct 2024 17:25:25 -0600
Message-Id: <20241017232531.726559-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232531.726559-1-sjg@chromium.org>
References: <20241017232531.726559-1-sjg@chromium.org>
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

When BLK is not enabled but BOOTSTD is, some features of standard boot
become unavailable. Add a check for this in the only site that is
currently apparent.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootdev-uclass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 807f8dfb064..64ec4fde493 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -434,6 +434,9 @@ int bootdev_find_by_label(const char *label, struct udevice **devp,
 	struct uclass *uc;
 	enum uclass_id id;
 
+	if (!CONFIG_IS_ENABLED(BLK))
+		return -ENOSYS;
+
 	ret = label_to_uclass(label, &seq, &method_flags);
 	if (ret < 0)
 		return log_msg_ret("uc", ret);
-- 
2.34.1

