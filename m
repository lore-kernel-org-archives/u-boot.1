Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945A8C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40CFA88A1B;
	Mon,  2 Sep 2024 00:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cSZyg7qy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5805C889FC; Mon,  2 Sep 2024 00:26:50 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D9CB884C3
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-82a20593e53so140624639f.2
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229606; x=1725834406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7DdkER2RHUOjzF7TxOxm/2QRIyR5m8rS9CgKjZAWUo=;
 b=cSZyg7qy4UrBODxQR3zFfvKUoFMw6sRHev1yTZb+l533om9wY9AwP7MeoeXEBxZbNB
 Vna62JorLueO9uqUmFrkupL1Dj9fOZjTlhH1pYpRYQB7Yevjc/ir0mU0TcxuUcZy4ULc
 GHgPr0QVn8TKxOhUni3JTmhQPaPpr7YzEuP3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229606; x=1725834406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a7DdkER2RHUOjzF7TxOxm/2QRIyR5m8rS9CgKjZAWUo=;
 b=ipTCNZx6zuwIud8WFNcHqmQugYc2qD5jB1d8PJKpwLVfr/LIAM5TyUzQ0PYZ2GnQIp
 xf6o76w/aYSwvWM7Fq6+oLSQVQDMkyyEYViL22LM/PvlpkA+dbamQ0FLbsBI1UV+lULj
 H1YvEiE3lQEquUPsO5ZfkutvWFHyKrdNGuVok6YnebNjzJIFlKNLUBxwEWt/87pSJ6Mb
 e3PYHIBUxQFxcjHZGh2lu8bFrmrym0pFokU+pibACAG+RRJy4+sx3VDShQfAkIo99VtO
 cmaUfc1cLgF4zQOq6RocmwLcaUMlsOmQtOrBoJaJhs/04JhtGv/EcIr2VX/3XVncMJcc
 /RGQ==
X-Gm-Message-State: AOJu0YyYe9DiRIZUYNrFMVd8v8Qz1JlhmFOkoek/VRT76JMEWB2GlgeX
 EVBnZeCICyD2NnBKs1OCwC9beQfi3oLgcmtyKENL1SG+NXzItocw6xvOFVNmYa4Ma99mMK7hmfE
 =
X-Google-Smtp-Source: AGHT+IHoMVaRivTvhb+vR+FL6pA2O7oAKDpXxIrtNNQ3LQlhhcqZZUKxJKVhtJxn+baUwecMpZc4fg==
X-Received: by 2002:a05:6602:1352:b0:827:86d9:4e1d with SMTP id
 ca18e2360f4ac-82a11085691mr1050147639f.17.1725229606539; 
 Sun, 01 Sep 2024 15:26:46 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:26:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 02/23] nvmxip: Avoid probing on boot
Date: Sun,  1 Sep 2024 16:26:13 -0600
Message-Id: <20240901222634.460873-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222634.460873-1-sjg@chromium.org>
References: <20240901222634.460873-1-sjg@chromium.org>
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

Devices should be probed when they are used, not before. Drop this
boot-time probing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/mtd/nvmxip/nvmxip-uclass.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mtd/nvmxip/nvmxip-uclass.c b/drivers/mtd/nvmxip/nvmxip-uclass.c
index 58e8c3fb74b..d18bd0e3d6b 100644
--- a/drivers/mtd/nvmxip/nvmxip-uclass.c
+++ b/drivers/mtd/nvmxip/nvmxip-uclass.c
@@ -53,14 +53,7 @@ int nvmxip_probe(struct udevice *udev)
 	return 0;
 }
 
-static int nvmxip_post_bind(struct udevice *udev)
-{
-	dev_or_flags(udev, DM_FLAG_PROBE_AFTER_BIND);
-	return 0;
-}
-
 UCLASS_DRIVER(nvmxip) = {
 	.name	   = "nvmxip",
 	.id	   = UCLASS_NVMXIP,
-	.post_bind = nvmxip_post_bind,
 };
-- 
2.34.1

