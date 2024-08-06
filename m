Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF3AC3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06D4288AA6;
	Tue,  6 Aug 2024 14:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CSSPLCJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C493288AF6; Tue,  6 Aug 2024 14:59:51 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD39988ABA
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-39b37b63834so2740445ab.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949186; x=1723553986; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YAd5s5Nlbb/oxDYoWI+zXPb8qiHk1bgcQqreP2GsPQM=;
 b=CSSPLCJU5tNz9Tq6K1be/9JbKawVb4zLePtMRB9GL8Yi0MnBITRv7r+LoZYr3Vn1D6
 H2yeMubkYq6Ta6soVraE0bDPlE99pTYbCp5C/wvWDbW0ZJt3kxBcXcLPA9X9ZLq8DGj4
 vVqDh0km8lZ2js3TPSPpYTTmYANoU/xcop254=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949186; x=1723553986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YAd5s5Nlbb/oxDYoWI+zXPb8qiHk1bgcQqreP2GsPQM=;
 b=pyjBSApPJsYUObnpNb/4L6gCbqCvK0g6ePkh+36hP295nqJbQ1ZgLdmFuLDkLHDjea
 TuIOnqEATxolo50T5jRYWiDAMllBsOAHBdJQ1YM2336nVncg9CsuXa9rUZ7O3wdrfDrG
 kqx01onYxp8on6fojay5obkNMYACeetnGsPXC85bsADqT9l9pOaHXh3k4eKjqLvQ2NNf
 w3p/m+B70T3Ulp4d8rzma8Pw75mtExieiBsNzmin7lhRYJyFF6MQRMtlL0yxeu8uwGdE
 iHtxTJVg8N+fwefIaKZw4uZg8yV3JCSDn+dvf/wq/CH3yTXJXVajFfGfaznNJCmcVM2L
 jO4Q==
X-Gm-Message-State: AOJu0YwYtJdYozVTe/fpwPVAhp3lV5YPBYu8F9feJaQ3kN1OFb9phbDm
 Xtd3LIhOMzctoX6Bjhezg5Gd79RiMugrSI85O+WmGLS9Y8P3Zu74uiONzFMV9UPtTjcgXy4Slh4
 =
X-Google-Smtp-Source: AGHT+IHGggH1ji62KAU+b2/TT38lgyITA+d3dzAuxJxBWJmIyaFVVgHdplk57ktltnpxC8rUYGGrzw==
X-Received: by 2002:a05:6e02:1ca2:b0:383:6af0:eb0d with SMTP id
 e9e14a558f8ab-39b1fc36ab0mr207174675ab.26.1722949185751; 
 Tue, 06 Aug 2024 05:59:45 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v2 31/39] Revert "bootdev: avoid infinite probe loop"
Date: Tue,  6 Aug 2024 06:58:42 -0600
Message-Id: <20240806125850.2316956-32-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

This turns out to be insufficient to fix the problem, since when
bootdev_next_prio() exits, the caller has no idea that this really
is the end. Nor is it, since there may be other devices which should
be checked.

The caller iterates which calls iter_incr() which calls
bootdev_next_prio() again, which finds the same device and the loop
continues.

We never did create a test for this[1], which makes it hard to be
sure which problem was fixed.

The original code had the virtual of staying in the loop looking for
a bootdev, so let's go back to that and try to fix this another way.

This reverts commit 9d92c418acfb7576e12e2bd53fed294bb9543724.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootdev-uclass.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 7c7bba088c9..15a8a3555c6 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -632,7 +632,7 @@ int bootdev_next_label(struct bootflow_iter *iter, struct udevice **devp,
 
 int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp)
 {
-	struct udevice *dev = *devp, *last_dev = NULL;
+	struct udevice *dev = *devp;
 	bool found;
 	int ret;
 
@@ -682,19 +682,9 @@ int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp)
 			}
 		} else {
 			ret = device_probe(dev);
-			if (!ret)
-				last_dev = dev;
 			if (ret) {
-				log_warning("Device '%s' failed to probe\n",
+				log_debug("Device '%s' failed to probe\n",
 					  dev->name);
-				if (last_dev == dev) {
-					/*
-					 * We have already tried this device
-					 * and it failed to probe. Give up.
-					 */
-					return log_msg_ret("probe", ret);
-				}
-				last_dev = dev;
 				dev = NULL;
 			}
 		}
-- 
2.34.1

