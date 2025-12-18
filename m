Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32702D68BD8
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 04:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8834183C61;
	Thu, 18 Dec 2025 05:23:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="llv2WKKu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C897883C65; Thu, 18 Dec 2025 05:23:05 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52F9683C54
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 05:23:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso2381685ad.3
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 20:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766031780; x=1766636580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQri32WyMEYoPdWHUxLw2MgdrNhfxtDKHoLd1RA4iNU=;
 b=llv2WKKuGdVdjEfj7OAxLSrowwbw+50G8048rB/YSqoTlbKOOgN9EH9wnVWhIW65+1
 6ldkted8mtZJTvqdVdo5Hsy40nRFMZLE+TdQUPbtniioQCqqrWxcBSmRADJvYjhAKktA
 9vsV5s/5tdoMEitIBz1A+vwHeVWnwqN0b6MaViwuUwA8SLnD4XQ0ohOMxkRcppIl2IGq
 lnqe8U1+qWyguWZNpxVllqnv4ITnL3EUXUSAYe/Mu6eZmPfRb3KyBDCfIQKCEypo7JTF
 +z1h3KARNEkPWpJQtuyoA5Dan6iwR1J/206H//qdHGBLPlOjBesxGUebFU38tge7VcbE
 bFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766031780; x=1766636580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fQri32WyMEYoPdWHUxLw2MgdrNhfxtDKHoLd1RA4iNU=;
 b=Noqt4Z4xPDjbDPYoELp9puGXotnLVK1uzlWzu3AmcNs/IkhtXu4LyN/xFkrZxLHI7N
 tEur9/UREe/Nsx3esIWkfz7IZroigMs/Qg3S2gsWlhAYmadzYhg+iErOMD7jTSFrYkQQ
 o71H1xRXtlivG8QLJ0GRSiGF8JBe1CbWchGDNnCKyBFT4j4kqAhpOGxmHNqLE4iAoGkA
 Q0AmaoO2vZkos/y11fjPi/jyYufxnTVGh9yVMDqT6Px3r2ZEh579pLbh5rPJF3+Cyu+c
 K8UKyTQTXbJ46WCnhRLmGCq67w7oG8ArEozIZB6yre2iB5ly3fT/qzFSXDxUbJtCNYxm
 so8w==
X-Gm-Message-State: AOJu0Yz5DwghfSOLqgy482I3rqbWQDiTLPEE4CoQ5r3J7KqN6M7zRUG2
 rIXuJgtZWto27BUtl/yy2wcjGATIFkqeTOm9A+jbXK8gcFBtXG19PKMT
X-Gm-Gg: AY/fxX5MaqnHndF9xKPTtzpEXzjTt4ZTFfEIK8RA6eKBf4xWvFK6kFbPb4MOjWDP1P5
 UjsbaSOXCQLzBPGzYYBvqM+zwFmgh7BlHJ9eM5PnkcnmzVQ3lrK+/YCBT9US+C+b3rHYWFB8R68
 bdocPeujO6qcb443OmekhKPwN1CVocsxOp0qvBMVKsj78F9g/8cFe2vl2bVUVloPnIzxQjZXAdT
 YUMzuiyQhxKNp4+kiiBqONAGQQexnnPbfNGeGX9QnkX4tsX6Mvj9b+HkIFZ3twEoGxN2EZtWbYV
 q4ujkKKPsKleSDfB+jYJ9VEOO7rd96eWKNiLaU+SxlORP4HruETR6EYYlFmnuTas2gEi8WdC/Kx
 WN0xoSa65zH6QAnU9HJB7f5e0WFfPBtZzRe+rJqB5l1epUEwSwF+iHhPrpP2W9MPPOjxjxdaDvg
 Hge5e97JR6WJ8x47iec24s7WpJ
X-Google-Smtp-Source: AGHT+IGc/Llbl6pceQuCmZMK6BbCCAQFBUGoXYxSXWVUExLl1KkUoFP0EAQpHT8qFfHZlGh8y/PlgQ==
X-Received: by 2002:a17:903:98c:b0:2a0:d662:7282 with SMTP id
 d9443c01a7336-2a0d6627689mr143470715ad.37.1766031779785; 
 Wed, 17 Dec 2025 20:22:59 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:73ef:52b5:685b:7c64])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d087d485sm9305655ad.16.2025.12.17.20.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 20:22:59 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: trini@konsulko.com,
	stefan.roese@mailbox.org,
	seanga2@gmail.com
Cc: u-boot@lists.denx.de,
	Chris Packham <judge.packham@gmail.com>
Subject: [PATCH 2/3] arm: mvebu: db-xc3-24g4xg: Remove marvell,
 nand-keep-config
Date: Thu, 18 Dec 2025 17:22:43 +1300
Message-ID: <20251218042244.1833380-3-judge.packham@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218042244.1833380-1-judge.packham@gmail.com>
References: <20251218042244.1833380-1-judge.packham@gmail.com>
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

nand-keep-config is used to retain the NAND controller configuration
from an earlier boot stage. In U-Boot's case there isn't an earlier boot
stage so reconfiguring the NAND controller is required.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi b/arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi
index dc20643bfa37..ad64813e7704 100644
--- a/arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi
+++ b/arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi
@@ -5,7 +5,6 @@
 	status = "okay";
 	label = "pxa3xx_nand-0";
 	nand-rb = <0>;
-	marvell,nand-keep-config;
 	nand-on-flash-bbt;
 	nand-ecc-strength = <4>;
 	nand-ecc-step-size = <512>;
-- 
2.52.0

