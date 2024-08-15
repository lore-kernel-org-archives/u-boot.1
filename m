Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C39C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 742E088A82;
	Thu, 15 Aug 2024 22:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KTIS6fv0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F18B288B45; Thu, 15 Aug 2024 22:25:49 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62DBA88ADB
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso5973005ab.3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753543; x=1724358343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7DdkER2RHUOjzF7TxOxm/2QRIyR5m8rS9CgKjZAWUo=;
 b=KTIS6fv0XoKz17LRxPwgJIqavONUEEe5C5Yo9vqVfxD/zxT0YpbzLExj97BRW/YiYt
 luXlrVvRMHYf8rE8ixPR2CzxUe55IRF1iqiAkZ7yELUMyOZV6QEoiQkftvklPYXqidBh
 79zjTfB4b1tBNgLesdwbOdB3JyRllSeDmAS/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753543; x=1724358343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a7DdkER2RHUOjzF7TxOxm/2QRIyR5m8rS9CgKjZAWUo=;
 b=qhakVSdmwFNVBprgaFekDge1Zj3DLWWJIsVwYoaQa8Dtjp110YbIYZKOxmn3qDYTbQ
 EcinyO1GwdPQGYkpNxvt29nNpAb5RwivbpHSqtV4+j2FSxI6IFBXFfl6rRxL7Wci8EID
 0pL82Jb81b/oPTCl3DuAzPCsq9jOwZ5dwqH4Zjsy4J9o3xNlnJkliR/Lv2E4qjjxbyb6
 Y2Lf9X+cXKVikcCwx4NU93bNRpL1XqEKVU56N15H+eRlM91/idXzTeCSfIp1i5szr7lB
 Zvy2tvJncADsUuz7eO9rJq0XOLWy7R2pcCwMk8HQpqEd2OIYfMsQRF/QYyDnLwfX517E
 7vFA==
X-Gm-Message-State: AOJu0YxVKLaPMPX87/GNImLz/t7AlRuCH2cCU+G06CjUwTllC98UZF8t
 +KlcJvzXhDng1A9KBbR95WcgTWGU/n5Y3lXswzu/M8bqgApHNLOX3WhmdBLpXbcw5dQVSy+uVpN
 mag==
X-Google-Smtp-Source: AGHT+IFJ2wvQWxZIufK49TdcGec/rkmLd9EMz1iBQ0tDcOQ9HynpcaaDFwXW1/vpjmoqG1HO4YgXWg==
X-Received: by 2002:a05:6e02:1fec:b0:39d:2124:d6d5 with SMTP id
 e9e14a558f8ab-39d26ceda1bmr9565265ab.10.1723753543347; 
 Thu, 15 Aug 2024 13:25:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:25:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 02/24] nvmxip: Avoid probing on boot
Date: Thu, 15 Aug 2024 14:25:13 -0600
Message-Id: <20240815202535.767869-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202535.767869-1-sjg@chromium.org>
References: <20240815202535.767869-1-sjg@chromium.org>
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

