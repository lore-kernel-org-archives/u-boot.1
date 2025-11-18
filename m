Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8B0CEE347
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D044283CDF;
	Tue, 18 Nov 2025 19:03:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tQtAdsQH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F20E983E40; Tue, 18 Nov 2025 19:03:57 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D13FC83B95
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c765f41346so913063a34.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489034; x=1764093834; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4woNTf1mRh/UR29i+xUqvJZJTQfU/CSaqJHiLc7KnwA=;
 b=tQtAdsQHQQ3qZww/LeeQBCIvlXQFkw9XpWqTbP1g3ZA06u8sUdYkhiIRrAC04J/kks
 6STkZ8ISBUrMl73OhTGMjWk+ai6NQJ41CCMGL9PsmIKP1LgwdQdZsSw+t6hCKnH2dtut
 zZaFp8SuY2qZuaB6UO+8N2Fg4JoZCRZVayu3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489034; x=1764093834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4woNTf1mRh/UR29i+xUqvJZJTQfU/CSaqJHiLc7KnwA=;
 b=Cnft7SjynTCCtDFHCt7Who/+maP5A/dD0+GfCtqLqJTqdxYR2YbZSG+p5WdzPXR8TO
 bEM6hv/U1Ax2lhVh5bRZ6UDwBnFW0xOSo81LMsZHA3ZxBRJkUjWm7XCCsVf0txV5ufsp
 +Nv2zPLC2me3212ViXhn6Oye1GMQCOSIW/N/45AiJkMOik1RF/3ldNIZ/CqBL6qHUzqQ
 e1mLA5+vTomRG400LMed4bvVpoPwPJzmi76HCzAxdpLtlbtY1hXuTERiNIdSS5fdu52u
 qg//Sta5MZ7FRmF6PQJ+MQqfwADDmznCMONiufzV0WNL7/ThaQTYps/EgHlhUZ59I5dB
 Y6Dg==
X-Gm-Message-State: AOJu0YyRfe+rSoxLvJRfdz2eN9ExfB5rjxw8ePTJtXnoqT0eCL9tzCrf
 UCBL8AXxdPNTeTIhQTrn90mpQMSOGN04QcaownHh3dXISJiKBBupxQc33w1lh/haBZovtb96/IO
 VmdiM071Rog==
X-Gm-Gg: ASbGncu9i74ggDoFmFuKjNGG3n8VAl5Ik4kn+k/Oi2SOO1Qxi2Pvu+KzaaoNB6T/WBg
 ORz/7UT4KBwTkMlnl61NWCw1eYKoj/WXvs+6C9PKKGvnk2Q7Pi2sB/cJoNID6LID8UMZ0y6aUGr
 pslQWl89PwNRgzZhXYSo5m6qmPJy6EjNpqDqPRexIWr1EKXIXwbz0K1a+fdULgDLOKkM8u0+OmO
 sYqAU33ixz8Mm+u9QlSVCScf6qHW7P2vkEx/fkp2h6f4rBvImYw4leAKIREQDDBLmc8Y7CzqdFr
 JFmsj7NVvxOQP2aPhqekoiTrFR/hQm7OQGTJX+PiCyCi/pilCl55nfBBeAj5LQRfU9Ugmn+/EQJ
 BEvBv9sgxbbUGOtP/earqQUMUDFeEmCpw+Pe5maplyS5CtCqqYhxuk1rUSkvKSo+LrxcnxJU1CN
 TuoPa2vX9Q82ky+RSR3fbqrao3UQJ8QOXdSZvPpaqx690gTW4bha0b
X-Google-Smtp-Source: AGHT+IEoKxA8Ik8fJB41oMdQsLne3x1oo7yFmDwrGyITuBbA1kCM1GDrsuUtlpD8mryXxD0yQz7o7A==
X-Received: by 2002:a05:6830:6409:b0:7c7:da3:ed22 with SMTP id
 46e09a7af769-7c744557466mr10170058a34.32.1763489034321; 
 Tue, 18 Nov 2025 10:03:54 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a392fa5sm6857960a34.19.2025.11.18.10.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:03:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Nikita Kiryanov <nikita@compulab.co.il>
Subject: [PATCH] cm_fx6: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:03:52 -0600
Message-ID: <20251118180352.590985-1-trini@konsulko.com>
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

Cc: Nikita Kiryanov <nikita@compulab.co.il>
---
 include/configs/cm_fx6.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/cm_fx6.h b/include/configs/cm_fx6.h
index f7fd4c517b4f..966f75967508 100644
--- a/include/configs/cm_fx6.h
+++ b/include/configs/cm_fx6.h
@@ -31,7 +31,6 @@
 /* Environment */
 
 #define CFG_EXTRA_ENV_SETTINGS \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdt_addr_r=0x18000000\0" \
 	"ramdisk_addr_r=0x13000000\0" \
-- 
2.43.0

