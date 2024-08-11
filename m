Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D91C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CAE38860B;
	Sun, 11 Aug 2024 16:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fgqZ6DZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B97DA88861; Sun, 11 Aug 2024 16:52:37 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EECA889CB
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-39b3e12754eso11984615ab.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387953; x=1723992753; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7DdkER2RHUOjzF7TxOxm/2QRIyR5m8rS9CgKjZAWUo=;
 b=fgqZ6DZLZCCORbdU3viC1wG3EJuLBHHhyzgFOTxCcS7BXu7/DOE1FZHWUrAEWAB/0v
 BHcl+vZTVQfm2m9Kvc+pubaf9Wft1fPmes6pF2dSI/SzpPMFFV9tsAdqUlIPCeKiYGtX
 xGup7VI4DH45LFYCHBBqsUQS3D/VtcXoMnhfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387953; x=1723992753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a7DdkER2RHUOjzF7TxOxm/2QRIyR5m8rS9CgKjZAWUo=;
 b=Nex74SiWWwgdcfcCiJ26l64C8VijLWo7OrANcjkh/c//q4kmtVm9yyNpHSFiBayt9m
 Ohw+sVSN76CKmUKs1tnQzrcD2fw/9ibFubuWgAWMVADLicxNO6dxIg/xrVg7NwjKDF0P
 +RnKfMgdpRxq8/gY6FVUe5Gkv+sdCP0aMMBfVAKrrpGP36HZ99S3As2O6uYuooSPI4r5
 3i2OWwwCeQ2qigZUGSihEzdXNF1oHT0qvPv0Msdy4qx0SEyLdFGav56fOdRtq9SRWCEq
 ba67QtRKv+TYxJolRfi/lUQgF1f4zw5nNM3ljHVeAHxtflPGGzZYWLuKz3D/DWoCAi/h
 jFgQ==
X-Gm-Message-State: AOJu0YyY3VaeoGfVFyZhJDz3fFDffU43CmPmQKPI2Dz6bnk3CQiXL00r
 jQwZwCMnd/Dl+GDxsOTHnD4/ik5M1JPkiU/Cvny9jmYYj3uQ/z6fIwivyL5uNC2zGA+N9ZAUPgw
 =
X-Google-Smtp-Source: AGHT+IEtHaPUAqmB9J3cENuqkDkAPq9xbhPGnAyIvyeCauoW83T2rJMrrZrqcjJvBRRynPOW6w7gKg==
X-Received: by 2002:a05:6e02:1b08:b0:39b:3502:f4f2 with SMTP id
 e9e14a558f8ab-39b815a164emr73442275ab.18.1723387953194; 
 Sun, 11 Aug 2024 07:52:33 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 02/40] nvmxip: Avoid probing on boot
Date: Sun, 11 Aug 2024 08:51:31 -0600
Message-Id: <20240811145209.4191404-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

