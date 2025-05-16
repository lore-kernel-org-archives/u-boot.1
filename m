Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDCBC3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 17:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E18F80107;
	Fri, 16 May 2025 19:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aUr/EqIt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67FBA8059D; Fri, 16 May 2025 19:40:27 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F32C8006D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 19:40:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-310447fe59aso24529451fa.0
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747417224; x=1748022024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XlsJ2H9ITYg7hmAA+XnkJgVqc/G30cOHSifNiMJNGBo=;
 b=aUr/EqItjt/tfi62GVn0boqhWON/qodL6Hk2/aJ1QAWTsPS045HBJU6D5wcn5/TbU+
 KIEJc9SzcuUIHZ7nmyCHHLzmqCwBtyNAUia8UGnrHLgPxITMCAhade6Q3Yuan5sZs8K/
 JvsfOYUgZlO+iIMgBZcngcssXSkwlhrV1VkFnoUhmP95eZQFm3I6jRnLd7jP6VA5EvCd
 f0rPOhy95AjTsYuVGXLctRZJtV3lwjFY3PVW6I9jbF9vvmw8OWu5jsDCrnuvsL4k0uSO
 dWVrTc10Baw8wBfbvTh4hAYOGC6jngqFCxdof57avYFVS9hcbkVCqPkv1kETJC68ee4q
 AN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747417224; x=1748022024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XlsJ2H9ITYg7hmAA+XnkJgVqc/G30cOHSifNiMJNGBo=;
 b=ZqgGCO52Eafk/cj5v0CRJzpktGwgsuOUsIJykDksKe+N4uCDLikMvbtZz09R22BXK7
 o4NXOShQbwzKJNnqRY6rRB3fgh/26VYFzO+7H2VKJ1ofgnTKvjL/7F44cBDc5HPE/ESj
 ByM5ycEOOBvSRlAHdck3EHcow3hNzQt4Sab9JebxoD5LYjhtZruI/+9L8qFlzL/89/qF
 vU3jiCR46rObBNEmmYkrBwJqjwgDwoLLO48AfDbE0llNuAr2fI55qa1NzaKcj8OASPLT
 /c4RPrb9FQhVs7hYB7eezBM05AHtx4kPvo/odFHEHa6WCKpArCFAM3f3ee5Y2kYGVkpk
 OarA==
X-Gm-Message-State: AOJu0Yy/3YSmBfn9v+yiOleFe1Lkim+LIlJlWfCq/kJP2T6DqlzJLBOJ
 qVExKNP7+B8OrHXAbkgtpX+puO7eqhofYuaQK1kkvdKuB0cB2yfCTXawvA5fx5Kl
X-Gm-Gg: ASbGncv7vrvA+pKGP05N+gSwg0k+AEw6iidN1gLvMkM95K4ZuVSLHilS+FidM8bbyeX
 BHNMd+Sx2UmQ2eOLZjzM2hxERad3NrpQPNM860pnw7YPH0j32XKxA+2fPFvZXsaVt9B099Du6GX
 8xFrAj9NBeGrU25xFiJfLwVsopr/2IozyT59aK54ODIt4yL/d3vy917xO+z+5vcetVkio2xpwM8
 25GCjpq3Mv435WQ9tKh1WPkMsNSzBy5k/qsPrWsoXLWl2+oLqIzt9xpMHOaTQDPkyC+HxXAzOcH
 IuPdauFJ9U5vH0g7UWRChKl39eMoPS8Kev+kYUAbz0kV0fgusG4Kdz0eiFKMnuqiFxWTl0xPVqD
 TD4z0mfgVLEKlmPYMIA==
X-Google-Smtp-Source: AGHT+IGXiitzW3DOlgD/8NNvkRHSs1q82G4PLePVvD76COyudmwJXcLQiO1JL+jAHO7+ikpRO1mfVA==
X-Received: by 2002:a2e:ae0e:0:b0:326:cf8a:7f30 with SMTP id
 38308e7fff4ca-328077a2dd9mr15318701fa.32.1747417224005; 
 Fri, 16 May 2025 10:40:24 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-328085b8795sm5212121fa.79.2025.05.16.10.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 10:40:23 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] drivers: scsi: fix: memory leak in do_scsi_scan_one()
Date: Fri, 16 May 2025 20:40:20 +0300
Message-Id: <20250516174020.118229-1-ant.v.moryakov@gmail.com>
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

From: Anton Moryakov <ant.v.moryakov@gmail.com>

Free allocated name buffer when blk_create_devicef() fails to prevent
memory leak. After successful device creation, the name ownership is
transferred to the device structure and should not be freed manually.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>"

---
 drivers/scsi/scsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index cd0b84c0622..a9e364d3fdb 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -522,8 +522,10 @@ static int do_scsi_scan_one(struct udevice *dev, int id, int lun, bool verbose)
 		return log_msg_ret("pro", ret);
 
 	ret = bootdev_setup_for_sibling_blk(bdev, "scsi_bootdev");
-	if (ret)
+	if (ret) {
+		free(name); 
 		return log_msg_ret("bd", ret);
+	}
 
 	if (verbose) {
 		printf("  Device %d: ", bdesc->devnum);
-- 
2.30.2

