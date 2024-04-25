Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9461AC19F4F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B29488EF2;
	Thu, 25 Apr 2024 14:21:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Or89pfis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 840B788EF2; Thu, 25 Apr 2024 14:21:08 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED61988F1E
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 14:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 827EE6160D;
 Thu, 25 Apr 2024 12:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE5DC113CC;
 Thu, 25 Apr 2024 12:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714047664;
 bh=P9y8+ZIiLS9CwwuRpmOHODEqruqERYym/uIqfh7siXY=;
 h=From:Subject:Date:To:Cc:From;
 b=Or89pfishUJ5QyHhOhIaXKwoHvMJiHH8rMx5mR+TZIGTabPcnWaG9dhi8ftSztWzz
 +ttbn4e8tIPs76NQdIYdEWj+z4s4lzkiUxhej9E/MedPwz6Q8R4m+Zg/+0kTbCZTFU
 aVRYpSdQD3jTg+gEtZyKO4dmR7CHHeKBLB2BEvxkK8jTSO+n3qFwV0lz5Y9mbw3ESX
 MnDA+ZeHnSvFHQRnkTHVzGfcWHNkgJ99flS9OhPM/sCBH2AdsIlLJQi8XeMOE3lSU7
 6fyDlj2ysdK3+cOyAYDy463375M0MD9KwAXuF137Mq7gUyYbyKxlUVfL6RCOl6xjpw
 gd9uOFt+vbmnQ==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/3] arm: dts: am62-beagleplay: Fix Beagleplay Ethernet
Date: Thu, 25 Apr 2024 15:20:51 +0300
Message-Id: <20240425-for-2024-07-beagleplay-eth-v1-0-6c985de1c316@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKNKKmYC/43NQQ6CMBCF4auQWTumU2gqrryHYVHrAI2EkikhE
 sLdLZzA5fcW/9sgsQROcC82EF5CCnHMoEsBvndjxxje2aCVrlSpDLZR8AAqiy923cDT4Fbkucf
 2pp0hqm1dWsiBSbgN3zP+bLL7kOYo6/m10LH+lV0IFTLpunLGGu/p8WEZebhG6aDZ9/0H7mK2Z
 cUAAAA=
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Wadim Egorov <w.egorov@phytec.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Simon Glass <sjg@chromium.org>
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com, 
 danishanwar@ti.com, u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=P9y8+ZIiLS9CwwuRpmOHODEqruqERYym/uIqfh7siXY=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmKkqsSzrQdGIh348KS84fmmTj4z81nBUbWKCxE
 8boT2ALtYyJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZipKrAAKCRDSWmvTvnYw
 k55SD/9H2w//FYylrz79Z42FC3J8x1Q1vjrw93GS0K4kv5qOxyGA2JLiPbtmBpX4DmJ7nrOlGIH
 FMhKE/O+VnIj/2sUEi9uU6tG0UoBoSupDy3G9huejvyNlZtrlRnVNSA/XtgQNdnWx7JMFTsROzy
 09zOxc4NMpZHnNbLg3KzqnM0XFRZtXwp1uyEnZC5ZStJe6wp0UmL2NzG98xBAVnGaKvAtkSGCAv
 CJRIBDXrEL5UUrY9hzZxFkpqYFWK/R9I3MqMc/s3Ecuc0C6emJ0t/9jUb4vQsOIjpQAsAfNx9Bc
 cSjPkvwqWF5AygMyJRgyTOvdGFAVXJXOuIt7Eyog7E++24iEyF4EHdKchK7PEFBkG9jYAXV4A6Z
 0Ptv40EnFisQri1uz/kcawmGDANXz7ClJsFaCE26fN98jlSju1ScQJ1iuiD2l++dmu9MH7hzv5e
 G9Glb3OtOKG/CYMUUEqefVRyGLYdX4gQdff/kG75uGkXZgN8GMBqyUr9D+FmBe8yEBcED39h1G2
 I3xdVz3Ze/kkN9cJVb+5iJWo2y+17rmn83jq3bu51F+urDol48kxPSQne7Rxi6inbzQwCS1p+M+
 MW6G1gCA7TVlIcjSa0rzi37O3LchDiWv1ChrXMkw3G5GRd/CDxCz7pMmWfI2DK7BQrKmOsoxJLC
 EVu9Ada5pOOmZpw==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093
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

Sync AM62 device tree files with Linux v6.9-rc5 and
add in the missing bits in -u-boot.dtsi to get CPSW
Ethernet working.

The last patch is marked [not-for-merge] as it is not yet
applied to Linux device tree.

CI testing
https://github.com/u-boot/u-boot/pull/527

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---

---
Roger Quadros (3):
      arm: dts: k3-am62*: sync with Linux v6.9-rc5
      arm: dts: k3-am625-beagleplay: get CPSW Ethernet to work
      [not-for-merge] arm: dts: k3-am625-beagleplay: Fix Ethernet PHY reset GPIO

 arch/arm/dts/k3-am62-main.dtsi               | 126 ++++++++++++++---
 arch/arm/dts/k3-am62-mcu.dtsi                |   4 +-
 arch/arm/dts/k3-am62-phycore-som.dtsi        |   5 +-
 arch/arm/dts/k3-am62-thermal.dtsi            |   5 +-
 arch/arm/dts/k3-am62-wakeup.dtsi             |  38 +++--
 arch/arm/dts/k3-am62.dtsi                    |   4 +-
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi |  63 +++++++++
 arch/arm/dts/k3-am625-beagleplay.dts         |  66 ++++-----
 arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts  | 104 +++++++++++++-
 arch/arm/dts/k3-am625-sk.dts                 |   4 +-
 arch/arm/dts/k3-am625.dtsi                   |   4 +-
 arch/arm/dts/k3-am62a-main.dtsi              | 201 +++++++++++++++++++++++++--
 arch/arm/dts/k3-am62a-mcu.dtsi               |   4 +-
 arch/arm/dts/k3-am62a-thermal.dtsi           |   5 +-
 arch/arm/dts/k3-am62a-wakeup.dtsi            |   4 +-
 arch/arm/dts/k3-am62a.dtsi                   |   4 +-
 arch/arm/dts/k3-am62a7-sk.dts                | 162 ++++++++++++++++++++-
 arch/arm/dts/k3-am62a7.dtsi                  |   4 +-
 arch/arm/dts/k3-am62x-sk-common.dtsi         |  24 +++-
 19 files changed, 722 insertions(+), 109 deletions(-)
---
base-commit: 38ea74d6d5c05224acdb03f799897c1bdd56f8cc
change-id: 20240305-for-2024-07-beagleplay-eth-f82a51197937

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>

