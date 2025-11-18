Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9179CCEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85FF783F6A;
	Tue, 18 Nov 2025 19:04:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PGSeAd1A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 814BE83F6A; Tue, 18 Nov 2025 19:04:33 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF1083FA7
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3e2eeb85822so2739964fac.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489070; x=1764093870; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1E0deaVElh5HN2dzbIsbSILhOIFFjMINPMagByb1p5U=;
 b=PGSeAd1A9GM+FgG79Z/958yXy9j+LCYbUXpD6wSqylJWErXX8Ck/EmA0d22Hz/UOy+
 A0eeOjcKsJD/UAwXe9uTmHsrSbEpjKc/3+qAGzA+WRtv+zdVqqZRuC+psu4PnxNE8SST
 A5vPd38gLZf4/uXWuBw0WgCCHmK0Jn+QBicHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489070; x=1764093870;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1E0deaVElh5HN2dzbIsbSILhOIFFjMINPMagByb1p5U=;
 b=Eh2t2CdFbwdZdBOH7jimXMOq2zVsnxtHQIOo9X3KUDOx24f+tG+V3mb7o4i4493/d5
 JZrvK+nB+XkOV1fRsdwpqPxwxJtfT5/yBr6PUj5z/KdMsefEgSHm5BErQl32NB4/eB9R
 49cuOU6XZ1UEfEzL9GPsNTx9TVH4yqJjDueAbdFANFzgH0R47tK8w60OvjHziKLurMst
 8AfuRkL5eMnFzOlkH7IXFZBQsomLm5K9R0y/bSf6D+OjDYvpxWw5GfGQjkxNk2hBQL61
 VAfATkES73Dm2dGKT+ghhN6WguPG0CYMugX6dGZJrnZVOYVweIyDo3svZ+EsyddNPXFB
 M12g==
X-Gm-Message-State: AOJu0YyE7bBD2AvN5W3FGrU93ODpgxWnUo3Teeohra/qK0rgvaXpzx/d
 G0TNv1ZeIRM51ToZW3eep+DM6vzsScsaPJETreyXWMoujgCWIyqSBOTAbyg5Lk0r9Al4ERZxtnV
 0iAijPVGapg==
X-Gm-Gg: ASbGncsqnA2FHySgiTG9IKMebtqFbi262EzmB/rFCxwVvsEtKf1tddtfJdvPU6W4k51
 WZQL1tKl9KMGef+CMyOEpWKtq9nLXOit/ApE8h2w17ap3qth7S5yYuODcw8cSTvt5O+HQ3xtSiR
 Hktrt53Eh66aADBu34q/swphhxoZtyhiJ9yASr9ibu+CCcHZ/nCGLDcT9JOnIMtKMBKROVlddMw
 PQF59Z358XFmG2Z9TY+bVa2YNBuUV6/a7DcGJP0196Zy+tkrre2zNiZWC8PBjD/+3bTEu/piSl4
 EKFcDbr36NJ09E1LsEqZDBV55d2WdbamVXYwOuD9W61ebTjz7HxGld8uYBwbYUhltSE2s9nNxkQ
 /XscGCyYb76zIn805qR5QUP0WA7zXi7qTDUF4iO/tLIbgWPLrVwOYBtEzoqY5Np5PiX3KlYu6vH
 pRa25PP8B56WKSLSwFgsx/lpN6dR0DEV1AsYpoy7S/vtb8sB9cc2XR
X-Google-Smtp-Source: AGHT+IFbDLoof0LnxrrdIakseencYXLwOifWO3l0PWVpK+ZEw4bTxt47kVEYLjchz4/3arpUaoXluw==
X-Received: by 2002:a05:6871:68b:b0:349:de3c:bfc5 with SMTP id
 586e51a60fabf-3e868e82481mr8326656fac.7.1763489070263; 
 Tue, 18 Nov 2025 10:04:30 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e893c80161sm3754005fac.20.2025.11.18.10.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] pico-imx6: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:29 -0600
Message-ID: <20251118180429.591432-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Fabio Estevam <festevam@gmail.com>
---
 include/configs/pico-imx6.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/pico-imx6.h b/include/configs/pico-imx6.h
index f6a7ccfe87ca..eb9256a012a7 100644
--- a/include/configs/pico-imx6.h
+++ b/include/configs/pico-imx6.h
@@ -38,7 +38,6 @@
 	"console=ttymxc0\0" \
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
 	BOOTMENU_ENV \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdt_addr_r=0x18000000\0" \
 	"fdt_addr=0x18000000\0" \
-- 
2.43.0

