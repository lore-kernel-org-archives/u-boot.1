Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C24CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:30:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B626836C8;
	Wed,  1 Oct 2025 23:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ye9gTMoF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF21E836B4; Wed,  1 Oct 2025 23:29:53 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 955C2835D8
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-938de0df471so24732339f.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354190; x=1759958990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q59I1ZHdyH9KKc3dRyfwGz/qWa/qkBzGWOjckXwYLIc=;
 b=Ye9gTMoFdFqgrajbnpSQhUD3OZBGyIshEOAn/9LefhrCjwF75FcgRIpJi9Yav5sRHB
 gej+2pllLSnVYoc/OTBuK7U8xPUwjNO9OdAkrivHxqznjWidnYEmDXwxuI+rjW2Gv+Vn
 jUo9MJ5ddngGXVb7UrcpOioixC4eGPKMrZSKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354190; x=1759958990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q59I1ZHdyH9KKc3dRyfwGz/qWa/qkBzGWOjckXwYLIc=;
 b=AxkAnURjPxB1w/JImwhPbrAo5zCXw7WR/BkY4B4tFIxDMyP6XzPHitCRC5ZuL/J9z6
 CaKAzOeCzffrDOIXjbzjC4xwnMhogXDVxHmrZVxp5D6FP/brajW60VkXw3mfDLnHP7q1
 K9hpOqgSV349t6OIHsvsjwthcxf/CLt41UjSM6rMqLxgor/g342IKboy0eXjizt5dHZ8
 fqpAz9nQW+614R+8VPfFNc+LFW5OVrrDsl5wJqhrxDgLCKsCaG5rJdARoYmDsD0SWXFQ
 qgq/BsUfYzIPkFwdXUVhWVjCrZ2kLY3S9O8JyxysClSngp96fyvQ5bT6cpuLHw5FdDUf
 E1SA==
X-Gm-Message-State: AOJu0Yy9jQF/nPnoHjoAG5bcEHP6+CXItL8x6DAFAlfyG5zS43aJ6NDB
 bDLKA6w/+AT4CL+ntU6j+IKihzpJccASE/4UP+axsIghSpNqQvzjS5aupJ0st8+Kuv1tQexKu0P
 k7sxqqilK
X-Gm-Gg: ASbGnctWlzcmeH6dEzSKtHLVmb3dBUeATsPS1P1GNxJYV9sliTiHI2ZN+6j8+7Zjtfy
 hBHKFsWuBRD3eGJ7zNzNRcrVkfiznD9dhuruh5nmdUW61Hh8PiQpGZB0ZTP0VjheyscQOB8FwDC
 nOTqnhKI8xrDSPuT09jZPZ0gtWdJ/3IJa+oGWrPtlqwqeqLtuxB6kzn3aRYfb++ENNotpfmn3Ao
 Mmlc76eh2re0QlQOmeztcpHGRYa9rHHY+a08sb1iIQMz1dy5tGHdN1spAAxfLDhLtPkDG5xIeTd
 LztRArSN6v5ONr2wCU8MFr1NsEAQNnrw17hcSs+IHJ62GKS6Sf/i5YkNbLaTY0p7VFPxGwZVaAo
 5YoPb0acBVGaiLu7OADLDMskTky01TkO30u5qJKz6
X-Google-Smtp-Source: AGHT+IEaQpNEPU8e0rtIE3Ye23EySenP1phpFKxMj9wQd0iqXrNtrWOBDhoCRSwGyEuFFsh8oj+e+Q==
X-Received: by 2002:a05:6602:484:b0:892:f398:591 with SMTP id
 ca18e2360f4ac-937a91908admr720427239f.2.1759354189755; 
 Wed, 01 Oct 2025 14:29:49 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:29:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/17] boot: Move preparing bootdev into a function
Date: Wed,  1 Oct 2025 15:26:35 -0600
Message-ID: <20251001212649.3263574-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212649.3263574-1-sjg@chromium.org>
References: <20251001212649.3263574-1-sjg@chromium.org>
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

The code at the end of iter_inc() is already somewhat tortuous. Before
making it worse, move it into a function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 60f3498e2b9..4218b53d19f 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -245,6 +245,32 @@ static void scan_next_in_uclass(struct udevice **devp)
 	*devp = dev;
 }
 
+/**
+ * prepare_bootdev() - Get ready to use a bootdev
+ *
+ * @iter: Bootflow iterator being used
+ * @dev: UCLASS_BOOTDEV device to use
+ * @method_flags: Method flag for the bootdev
+ * Return 0 if OK, -ve if the bootdev failed to probe
+ */
+static int prepare_bootdev(struct bootflow_iter *iter, struct udevice *dev,
+			   int method_flags)
+{
+	int ret;
+
+	/*
+	 * Probe the bootdev. This does not probe any attached block device,
+	 * since they are siblings
+	 */
+	ret = device_probe(dev);
+	log_debug("probe %s %d\n", dev->name, ret);
+	if (ret)
+		return log_msg_ret("probe", ret);
+	bootflow_iter_set_dev(iter, dev, method_flags);
+
+	return 0;
+}
+
 /**
  * iter_incr() - Move to the next item (method, part, bootdev)
  *
@@ -387,18 +413,10 @@ static int iter_incr(struct bootflow_iter *iter)
 		}
 		log_debug("ret=%d, dev=%p %s\n", ret, dev,
 			  dev ? dev->name : "none");
-		if (ret) {
+		if (ret)
 			bootflow_iter_set_dev(iter, NULL, 0);
-		} else {
-			/*
-			 * Probe the bootdev. This does not probe any attached
-			 * block device, since they are siblings
-			 */
-			ret = device_probe(dev);
-			log_debug("probe %s %d\n", dev->name, ret);
-			if (!log_msg_ret("probe", ret))
-				bootflow_iter_set_dev(iter, dev, method_flags);
-		}
+		else
+			ret = prepare_bootdev(iter, dev, method_flags);
 	}
 
 	/* if there are no more bootdevs, give up */
-- 
2.43.0

