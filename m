Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AC1C4167B
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 19:28:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7207B871E7;
	Wed,  8 Nov 2023 20:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S3vHVUPi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 145C2871FB; Wed,  8 Nov 2023 20:28:17 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF3C871D4
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 20:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-671357f0209so665416d6.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 11:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699471693; x=1700076493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qfjILPPltNT49PJwBqBksYB6AiCJ2Ovp6PqHUOwYXSA=;
 b=S3vHVUPidBzG9RxVCb4jLck9uMol0/I/y6kdDRcLVLVMYsBppNlZqcIIp4+DeW4ERi
 l5vprme1mkCD3CCvVMGa+ue5pxGyRlZrFODktHTOhZXcC9hbHEpcKRfsywLGHGNciQZV
 +KkT98k+XYgvFH0npzTKBd4SgtMfeow3CL1E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699471693; x=1700076493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qfjILPPltNT49PJwBqBksYB6AiCJ2Ovp6PqHUOwYXSA=;
 b=ABt1s5lWXXTUAJB0XmiEMnfPWYwTaJNCdhIoudZ3yaDkl961JYAjD4QrQl26vAbirH
 48UrDF2CW88fBCjnfwYLrMzIPjRSdxTc3fzIsdtWaOnyj39pYDKkmEI6eq0rTO4rOpKY
 z+DV3/1Mh1JjTvgea/yCHUl/Kibe63uqfQLu9LrK+ydLt9CJiZi+KeYiY6uVDcCqPYqb
 /RWBH9Vpj9yQE/OcOls/AnnK7L3lRdldRjoXWiE02hnqY49+bGXO/nuCUBi6n/iC0E8F
 r7eAm9DU+hKKXxKaYxMATx6D3rfuVd8Jw86zvErZJI87LZRshVK1afuQJxj612uGiYXB
 gnOg==
X-Gm-Message-State: AOJu0YzkMyw8v2Ymy9e/pArm07VEnzuYUu0MvgYj8a/VfeXvoWcOGDMU
 juGpv0NILuGpBUQTaVCPYO0IGDr0wzVEsl3Dr2vS/w==
X-Google-Smtp-Source: AGHT+IGvQo3JzypeNDpbEyhOYsRy2926BGdI4NZi3DQrGngRgqJbBT/+4UzUYqqMNBUcPBG8id0O/A==
X-Received: by 2002:a05:6214:19c3:b0:65b:fa3:4a01 with SMTP id
 j3-20020a05621419c300b0065b0fa34a01mr3388816qvc.62.1699471693299; 
 Wed, 08 Nov 2023 11:28:13 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a0cd6c7000000b00656e2464719sm1380070qvi.92.2023.11.08.11.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 11:28:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH] scsi: Have scsi_init_dev_desc_priv() use memset
Date: Wed,  8 Nov 2023 14:28:11 -0500
Message-Id: <20231108192811.1844338-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

When we do not have CONFIG_BOUNCE_BUFFER enabled, inside of
scsi_init_dev_desc_priv we never set the 'bb' field to false, we only
initialize it to true when CONFIG_BOUNCE_BUFFER is set. Given that we
have a number of other fields here we had been explicitly setting to
zero, change to first calling memset to clear the struct and then
initialize only the fields that need non-zero default values.

Addresses-Coverity-ID: 467407 ("Uninitialized variables (UNINIT)")
Fixes: 81bd22e935dc ("rockchip: block: blk-uclass: add bounce buffer flag to blk_desc")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Johan Jonker <jbx6244@gmail.com>
---
 drivers/scsi/scsi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 363047d0f72c..7dfe0c5e0562 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -368,15 +368,12 @@ static void scsi_setup_test_unit_ready(struct scsi_cmd *pccb)
  */
 static void scsi_init_dev_desc_priv(struct blk_desc *dev_desc)
 {
+	memset(dev_desc, 0, sizeof(struct blk_desc));
 	dev_desc->target = 0xff;
 	dev_desc->lun = 0xff;
 	dev_desc->log2blksz =
 		LOG2_INVALID(typeof(dev_desc->log2blksz));
 	dev_desc->type = DEV_TYPE_UNKNOWN;
-	dev_desc->vendor[0] = 0;
-	dev_desc->product[0] = 0;
-	dev_desc->revision[0] = 0;
-	dev_desc->removable = false;
 #if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
 	dev_desc->bb = true;
 #endif	/* CONFIG_BOUNCE_BUFFER */
-- 
2.34.1

