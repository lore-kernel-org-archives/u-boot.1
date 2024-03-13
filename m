Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA65C54E58
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 01:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E9208785F;
	Wed, 13 Mar 2024 02:00:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WAzyPIxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEF0C87F3F; Wed, 13 Mar 2024 02:00:00 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5BCC8785F
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 01:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dd6dbcc622so15492745ad.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 17:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710291596; x=1710896396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4gUkE5wU5+OFqfx98i5luTlq7X2MQhw+us4yFrDNO8A=;
 b=WAzyPIxfG4PT+qEX9pCPK+QUYipfwrBlANqq36BzdRbm5IrBskDTprnMHxDrGOOm+Q
 77t6LZgyB9Z8nqJMuE/upfRvhrJRghRrtHpMg8ODVzL2KyNtzQNd6S2CGGHh1CeCMNaw
 ffgtEdu2P49t8AoOiXHrMxuEwzStEHBO74BIJXcmraQj8AXeCdMlELUnnmCR+SVH3lu4
 ygr2hI+gLBhjC+ySAfWIeMkWn8oySR8EukF3PpCqA+OLSnox4oqLsVtHdnTUrI4EUUsD
 vb9LO+yFYPZQbAoaWDPjefHqka/RsQzmAN7nGK4hcNX8krNLDwkVKOnS9lrm5/8pgkfN
 0tPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710291596; x=1710896396;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4gUkE5wU5+OFqfx98i5luTlq7X2MQhw+us4yFrDNO8A=;
 b=THsaObkKDb4+tghESAWl3GZdk1mt0BN/w/OTFaDZt8jHLdjTT5IO2Uada3MepKSo4v
 dKlMh/+gSBUMX8cEaqizREPG4aPh2lahITDCYtp4i29X8VtkWJ87K9eEHPfP55kY8fgQ
 jC2ueeRHdgnBBkLaPsZclPdLRLOZNPuYb9dbr+2WbsiLKhiTsD+BcEKgrHjlFaL9l6b9
 5qvom5c7lqaug76MuItGV3KlThwp+pTlwBw3GyfapQXKXDSvm2Y3dMAziwFD65Vs8cfE
 66gxJUkrirN1IQ3NvQE6Kdfj+2OWbn/HIjaVNx3cuaeUCovKqkUG/xWuyppofZ10c6+a
 JzPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrjS2cXdaQt9QmK5INueK5TH6sOWO9P5NBKPsYe+VAuLfmdf+BK/uNUMvIt8L64OrNni2xtmT2+9soXDhM/TezYc3EFw==
X-Gm-Message-State: AOJu0Yw/4B7fdc88CkFzEnV/E6exMNVX3lyztBpZJeN1mrNtrK4eOhVg
 8FzmEB/8nsHAG6O+PjULnVLBJIwCdYAY5q22zvbV3oxSmqRl5F2nZhFhBeal
X-Google-Smtp-Source: AGHT+IHYQsevsl3Z3rJhnV+j+/7K87oCoRxA8Qg+iyI0zeBT/9BNAYVu5wUzj3giDZ0Zp4cjghUeow==
X-Received: by 2002:a17:903:2289:b0:1dd:7d66:bfc0 with SMTP id
 b9-20020a170903228900b001dd7d66bfc0mr11165941plh.4.1710291596002; 
 Tue, 12 Mar 2024 17:59:56 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:6994:9b01:a251:4ea2])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a170903018200b001dd7d00f7afsm7129284plg.18.2024.03.12.17.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 17:59:55 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: festevam@gmail.com
Cc: marcel.ziswiler@toradex.com, hiago.franco@toradex.com,
 francesco.dolcini@toradex.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 joao.goncalves@toradex.com
Subject: [PATCH] apalis-imx8: Fix sc_misc_otp_fuse_read() error check
Date: Tue, 12 Mar 2024 21:59:41 -0300
Message-Id: <20240313005941.2654166-1-festevam@gmail.com>
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

Commit bfb3409d676f ("imx: toradex/apalis-imx8: correct SCU API usage")
made an incorrect logic change in the error code check of
sc_misc_otp_fuse_read():

-       if (scierr == SC_ERR_NONE) {
+       if (scierr) {
                /* QP has one A72 core disabled */
                is_quadplus = ((val >> 4) & 0x3) != 0x0;
        }

The other changes in this commit are correct.

sc_misc_otp_fuse_read() returns 0 on a successful fuse read.

This inversion causes board_mem_get_layout() to report incorrect RAM size.

Go back the original error check logic to fix the problem.

Fixes: bfb3409d676f ("imx: toradex/apalis-imx8: correct SCU API usage")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 board/toradex/apalis-imx8/apalis-imx8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/toradex/apalis-imx8/apalis-imx8.c b/board/toradex/apalis-imx8/apalis-imx8.c
index 2483a63c6733..49719f2f5533 100644
--- a/board/toradex/apalis-imx8/apalis-imx8.c
+++ b/board/toradex/apalis-imx8/apalis-imx8.c
@@ -133,7 +133,7 @@ void board_mem_get_layout(u64 *phys_sdram_1_start,
 	struct tdx_user_fuses tdxramfuses;
 	int scierr = sc_misc_otp_fuse_read(-1, 6, &val);
 
-	if (scierr) {
+	if (!scierr) {
 		/* QP has one A72 core disabled */
 		is_quadplus = ((val >> 4) & 0x3) != 0x0;
 	}
-- 
2.34.1

