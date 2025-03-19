Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D331CC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2321881F49;
	Wed, 19 Mar 2025 15:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TZF/+bUY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B02581E06; Wed, 19 Mar 2025 15:39:15 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7083281F44
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso35953355e9.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395152; x=1742999952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ysosmnWvNw/mVa3BDRAw4iPYkDjOcwT2zlbeylif3c=;
 b=TZF/+bUY2ekPfpTo13aQOCJoS1c7tS1FiYMDq0NeDIzZJ8kAdacJfGj2CjJshIc0S8
 bkSJec0P9jDXTZmYITpkPcSPLf/H5JY46BOHzbYNcvGe5t1QHucP1CjQQVwyD7BTuoH7
 r1D7EXNGV894NXXUyNqgxmXc8tYzKvoU+R7zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395152; x=1742999952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ysosmnWvNw/mVa3BDRAw4iPYkDjOcwT2zlbeylif3c=;
 b=TGIoopFg1jzxru3dGsLxAn4UgfnXjSfDWv1APdcCLdqYExDe2ZsiiI8Y3ibw60L07L
 lWbxOTCK7/GD2UmOksuKZrCOYSUDtJHfYT4RVTpui1sqxLOXMSMTUDWKGdGCVHnH0y6F
 1NrQFj8uAY7c/z/pduafGpTEFjklQNr1GqS0JIw1TCsWP8Tq+3jZVf/RiyATYIAB+U6U
 8kO9mgjcxKHDnq2dtc92CniloH8nequxT9mWd5Wk3Hi4RitDHR/l4RKboY/bfCdXgmIS
 Hvc2Z2PgfbA2vtpOspOU/htvxcC73jHrzLWUiXVS6R6JMUc1px5HityLLrqPNolO/4jQ
 rFeA==
X-Gm-Message-State: AOJu0Yx24KG5T6Y5h6ouAfRWg7sGyhCp7B6cvOxKQcmZ/BMPBc+a37pn
 nRhd4Yco5F6CR66yIRelPi0mieKWR8cpnlgSZKrmPrj6qf0TNrFiR1KMVnbSpmvY3nfNEPtmbKM
 =
X-Gm-Gg: ASbGncuQgFEFd3ECnzCOmA9HM2EOLEXC7kYlFe9tzatCokIA3O4WLtnfmb8Ai1ma/W0
 wLgWpMUbp4PWGUgrph1ZlrvKdU04lKCrOmGC0SK1CtNp4OHoaalpvo66Tfd/8d2FgTbroZNfmdf
 o4mw29bkWtnYyjRN3plJOS9rDDwwEb1NCRsoA6YfX08r35VDZWAvf0PAuYT/6hg382EfXJGopnS
 6ALOrqr41/6QVSH/rk84RB1hvPu+JmeU9h1Swk9hecaNtuR6OiOoAxvZtcMe8MEzGp1bIkR/TB2
 6kf9nU3tPqfXcSMn+YS/jLjuwhS0vv1oXsOWQZCuYQ==
X-Google-Smtp-Source: AGHT+IF8psvb9i3Ngt/UbEJJKEoIfTZ6w1Ur3p1Qxev6iRoH4vlF9/ey4ZGkFhoLPUUiOEY4IP/ynA==
X-Received: by 2002:a05:600c:3caa:b0:439:91dd:cf9c with SMTP id
 5b1f17b1804b1-43d43793a2bmr28257535e9.10.1742395152261; 
 Wed, 19 Mar 2025 07:39:12 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:39:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/17] bootstd: Expand debugging in bootdev_find_in_blk()
Date: Wed, 19 Mar 2025 15:38:10 +0100
Message-ID: <20250319143820.2385092-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319143820.2385092-1-sjg@chromium.org>
References: <20250319143820.2385092-1-sjg@chromium.org>
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

Add more info in this function so that the partition number and the call
to bootmeth_read_bootflow() are logged.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootdev-uclass.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 282f1d7b5c5..1e52ccc44c3 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -126,7 +126,7 @@ int bootdev_find_in_blk(struct udevice *dev, struct udevice *blk,
 	 * us whether there is valid media there
 	 */
 	ret = part_get_info(desc, iter->part, &info);
-	log_debug("part_get_info() returned %d\n", ret);
+	log_debug("part_get_info() part=%d returned %d\n", iter->part, ret);
 	if (!iter->part && ret == -ENOENT)
 		ret = 0;
 
@@ -188,8 +188,9 @@ int bootdev_find_in_blk(struct udevice *dev, struct udevice *blk,
 		bflow->state = BOOTFLOWST_FS;
 	}
 
-	log_debug("method %s\n", bflow->method->name);
+	log_debug("using method %s\n", bflow->method->name);
 	ret = bootmeth_read_bootflow(bflow->method, bflow);
+	log_debug("method %s returned ret=%d\n", bflow->method->name, ret);
 	if (ret)
 		return log_msg_ret("method", ret);
 
-- 
2.43.0

