Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E62C369A6
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43AD683C98;
	Thu, 10 Apr 2025 14:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OS2HKxM5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCE2C82724; Thu, 10 Apr 2025 13:37:55 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDEAB82153
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 13:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wickbergster@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-54b10594812so884030e87.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 04:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744285072; x=1744889872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=GFRRYW/mQ7GTTPwvjX3gl41zwEMgVmt/tk0xtiueSVM=;
 b=OS2HKxM5oR75VB07B761B7JbGY/ZJYYkjcQ/L5ihYc4EoVHyBK6nwyvaUa50qrJ9fI
 irRrttxD5KgLw5nZjWd/8dc9iLR/G/1/ZJDFFXefPSWgXMuCHPL5NIobusb1V3/vDBIv
 6fm9tj+OifuSehcNRsdQDGiiZ02mlBHAbz/19R3aP5VJzUQ1ktUxhQy8ZpGeQ3mIwhiT
 cucM1wia5tXwVctWpLFLxdMdK5CGR70f8uheI/UgdARAnJ3TwkIsPMF0JLtZ1W7A9AHV
 Y3kV0rwQqhK1N9o9/Prm5zGVawJKA2QP2hhkqnuyQFxGlbQIgbX/q5X0v/zliDQXgZkn
 7koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744285072; x=1744889872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GFRRYW/mQ7GTTPwvjX3gl41zwEMgVmt/tk0xtiueSVM=;
 b=SYqQ/GoCtHbi/OlpwtL6gnmjjdjW+vcMAxuvPsf8nAXw69VFZO/LmWbs6l/uGSQTKX
 0w5QEkgUdk6rR4pqNFRgnMmD6uu8WcDpa2PX0lNChpLbYABhw5oPzoAFvjlrUkJSGVpS
 5VDXQjfVhiN+5YMHx0OiXFn8YuijXMhynI3xzO7UFzQIQpW3dKg0zZTUko7rlM+f+IrF
 7xf14QWqJ871ecN9GfHTP8/1+sNJvtgaK/Q1NLHjbBYCicRZDDao8YNTYLaq/0b4ygRb
 Ll2TidvwJbxk6T4rL+ROo9RDq6IwB7Pk9Wi410ugY8/LiaiIkbUkAHCOS5rB6yxkNu4I
 xI6w==
X-Gm-Message-State: AOJu0Yzmt6uTbD+NfOH5GjxEkkWk9WTpU1Ly8N4SN6dQCJ3zFd8FO5cr
 k0mAwqblQ3H1J0O0inzJIXJaYL5aqnvkNGS9EY2wPzS1h9QH5JJC32dMuA==
X-Gm-Gg: ASbGnctoOylAxBnfQdrrjJg5ruq9f94qirbYAv7aiC301DLO9vMXdLr2hFN2nAO7ye0
 c3h0rsDySBAXNtNp62d48YwMZhc3j0+SmkEUQWmomy7JnnRYKXBczVHOXSsl1x4/n3UWorlN2aJ
 rPWjt0RgOmImspULuGJddhA7qOSjpU+ItRlnspruvm49j12GN32uJWfSTfkFAajYn30qCsA8gmV
 pVfwCagEAbK4UPqGD1UTcIbyxgZI56F2j1ulixhojlgZIicPyb3q8bDzPn4nQ8FW0Lp0GojNIkL
 siRzElYU8NdJs5PsFBFA4fZwGA1sqj60lkLiL7N77hgWnev058rhMQ1VbCxvZpOYx8/Vig==
X-Google-Smtp-Source: AGHT+IGm4B6VtK8sYjEnsNRCJvNWzUXuMFiZrvpm5GlkYQ+eBRqwouCxK6+0GS3V9ADZ2cPl9elbig==
X-Received: by 2002:a05:6512:3f05:b0:549:b13a:5d7f with SMTP id
 2adb3069b0e04-54d3c62a587mr912690e87.41.1744285071834; 
 Thu, 10 Apr 2025 04:37:51 -0700 (PDT)
Received: from EliteDesk.local (dyn-13-cust157.netit.se. [85.89.70.157])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54d3d123663sm126674e87.25.2025.04.10.04.37.51
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 04:37:51 -0700 (PDT)
From: Alexander Vickberg <wickbergster@gmail.com>
To: u-boot@lists.denx.de
Subject: [PATCH] mtd: ubi: Put MTD device after it is not used
Date: Thu, 10 Apr 2025 13:37:40 +0200
Message-ID: <20250410113740.1602891-1-wickbergster@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Apr 2025 14:58:33 +0200
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

The MTD device reference is dropped via put_mtd_device, however its
field ->index is read and passed to ubi_msg. To fix this, the patch
moves the reference dropping after calling ubi_msg.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Richard Weinberger <richard@nod.at>

Upstream Linux commit: b95f83ab762dd6211351b9140f99f43644076ca8

Signed-off-by: Alexander Vickberg <wickbergster@gmail.com>
---
 drivers/mtd/ubi/build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 50e43928af0..4881287dd6b 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1152,10 +1152,10 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
 	ubi_wl_close(ubi);
 	ubi_free_internal_volumes(ubi);
 	vfree(ubi->vtbl);
-	put_mtd_device(ubi->mtd);
 	vfree(ubi->peb_buf);
 	vfree(ubi->fm_buf);
 	ubi_msg(ubi, "mtd%d is detached", ubi->mtd->index);
+	put_mtd_device(ubi->mtd);
 	put_device(&ubi->dev);
 	return 0;
 }
-- 
2.43.0

