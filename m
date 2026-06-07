Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE0DCD8C89
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 19:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26577848A9;
	Sun,  7 Jun 2026 21:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZFILbt/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2569838BB; Sun,  7 Jun 2026 17:45:47 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8475801A9
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 17:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2c0c3184c71so26024005ad.1
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780847144; x=1781451944; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vaWYRuuTttwcChvvznbSmtafyLPbGEm6//DUJwoR1sk=;
 b=ZFILbt/Jb3gVXXh/SI4uJlakpi0GgzrwpFtCdZeCBvbbTNOCysq1DFV+Try2xnllPv
 O67dpcX2sSniQqpfneT59+kwcfQ9QfArS4pzdmympCl0DQqEtMCJZ39OP/spNRI6Y+Zi
 XzQJe4JWkPat7pzwVIwaXWAKvMU9rZ0UMs2ZPkNYfYIWhP6towx76CfbsOaira5OuYrg
 uyWaxvRpzATAJvF3PhTwzm2OYsJTedceLGcb6T+A8qJCf3R9EJH/MjGK5LlCrUEzussI
 rBBEkgm86F0chkYNI5pGcZxy9d3YRaj7iZPTYVyZD1uADHS7CD2hMSVgGP6XAP6qEhze
 Fmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780847144; x=1781451944;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vaWYRuuTttwcChvvznbSmtafyLPbGEm6//DUJwoR1sk=;
 b=dYlLR867r64WmmmEAdLkF0LSAtkOXJaT7wNTKhrEcArUKHeqNkx8vrJtOizNzd7m0D
 p86fBJgw9BbfMocoaJDtrbNJxsVsvNd+xxSY4zqwjS/U1zBvnC7QVJWDtTgEcLEFMBGU
 ajfyIdUd+75WkkINaiX0Q+KdSV2qmHzPqYghklAaYa3DGmNdvTwgmIg6x6Xo+q0pK55l
 hxSNNTTfn9UsVD8kino6ggPKVSFW88bWPNutlUFOFca/I2G0sV5BqG2nyE475nkMYA9o
 G8dvyj21d8uX3IGmJVzo3htk6KtmY4GugW8eorwmyc28z8Q+mMAiitNZd4IGU7Cg/VCm
 ICUQ==
X-Gm-Message-State: AOJu0YwZgvk2ykRpIAxdyiqwA78Ql8XbkAoiJYynwVEB9aHbPuyvLzPG
 jGcZ6h8rWhmYkelI+ZtQOYhVf+1IHXjsihIPKjj3gqrNTTFnUCmZ8B7eUQcEUA==
X-Gm-Gg: Acq92OHIRZtM5I8eqEsb+uxXoPQ4uNp9mrA7tpsccs/maZDl7Q8opUZAOSkrLSZdkqh
 fSVmJOLXHN7FCKFLot2vLvIj6k30dVl4sRd5TVWjbVToqNwWfOaAMxGOtpv0hDxP2iE9U/WAINW
 Att1BPQ9hUr3EDZ2wlh1Z2XAhyPDTdg0aw5h0NWUqR5fMrUjsmtFB0Lje3Ena1cuI1hErkepqck
 kPSd6Bls00JCZSQ1v1p/6x90/6BjEJrwg1WTPyfWy9qwcIxMjUP7VvkzMPKXz/iYBrOOCRqt1ce
 8yH7jbiOOG88o39j9/UMlQ0+3W91kZ+cqwic7fH0F9sMKPmD11nwYt+5wGi0S68oKGiugQ/RqAC
 NtyLM86vQRnD/a+o6YO2XVNz4C+LSOGlUVWcv51Ee7AS9qhxGwcZ5RXjjOb4kuTKFz+nkp4YDJk
 5H1KBEpzPP2ZH+jJPIb9YkY4NWFnDhF2daxdo=
X-Received: by 2002:a17:903:1aed:b0:2c1:69cb:4423 with SMTP id
 d9443c01a7336-2c1e7e527bdmr136906025ad.14.1780847144088; 
 Sun, 07 Jun 2026 08:45:44 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f8bc5asm160531815ad.27.2026.06.07.08.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 08:45:43 -0700 (PDT)
Date: Sun, 7 Jun 2026 21:15:42 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: visitorckw@gmail.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] serial: goldfish: return error when device address is invalid
Message-ID: <vgwnt6mnls3lf3zdm6mz5siztzkvppte4ykszbvifjzukvmksf@maaxe5agqpim>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Sun, 07 Jun 2026 21:34:32 +0200
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

goldfish_serial_of_to_plat() returns success even when dev_read_addr()
fails to find a valid address. This leaves plat->reg unset and defers
the failure to probe().

Return -EINVAL immediately when the address is FDT_ADDR_T_NONE so the
failure is reported at the of_to_plat stage where it belongs.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 drivers/serial/serial_goldfish.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/serial_goldfish.c b/drivers/serial/serial_goldfish.c
index 91dc040fcf2..732f167caae 100644
--- a/drivers/serial/serial_goldfish.c
+++ b/drivers/serial/serial_goldfish.c
@@ -74,8 +74,10 @@ static int goldfish_serial_of_to_plat(struct udevice *dev)
 	fdt_addr_t addr;
 
 	addr = dev_read_addr(dev);
-	if (addr != FDT_ADDR_T_NONE)
-		plat->reg = addr;
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	plat->reg = addr;
 
 	return 0;
 }
-- 
2.43.0

