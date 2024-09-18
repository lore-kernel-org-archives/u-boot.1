Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4570CCD1A0
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 13:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EC1788BEF;
	Wed, 18 Sep 2024 15:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GNuZUanT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A5A988CE1; Wed, 18 Sep 2024 15:49:29 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B3E7888EB
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 15:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 61F1FA4045B;
 Wed, 18 Sep 2024 13:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03004C4CEC2;
 Wed, 18 Sep 2024 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726667365;
 bh=J9l8hpCD14V83cr1NUFGlYZgr1QhA1E4av78YTjSuws=;
 h=From:Subject:Date:To:Cc:From;
 b=GNuZUanTfkaz+MqOlDjsyoPP3YNoNhPGvqttPavVNv7thYWU5y6K+MpnCGBccOk8k
 3+Eu9yufKgVq/AV1vTosveDJnzsbWJbL7FJJ6Co9yRbH7xzz0XhxsuLPs3WUdWqDRp
 6Yq9OHOXwfuyC2gqOs2QloA9aGL1kmCMaOwE80crf53bwQqvdTZT7caNF0XBC/6rlR
 Aj6ks7Pvs+54K8qKlVIbbBP5s6pHRIoaAtfMVyjqpa5lWkmENSqEN9sezxYHWXW6N2
 FqET6IdMKs2cmhLoJ94gWwSaOMsptlN0q6xu+qNohzkuBcxkqt7hERNswdOBvQ/dfH
 NLW7ARs1EFziA==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/2] mux: mmio: support "reg-mux" compatible
Date: Wed, 18 Sep 2024 16:49:20 +0300
Message-Id: <20240918-j721e-ums-v1-0-62f295dce6aa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGDa6mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0Nj3SxzI8NU3dLcYt1UY3MzY9M082QzAxMloPqCotS0zAqwWdGxtbU
 A4Zp9m1sAAAA=
To: Tom Rini <trini@konsulko.com>
Cc: "Andrew F. Davis" <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, u-boot@lists.denx.de, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=656; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=J9l8hpCD14V83cr1NUFGlYZgr1QhA1E4av78YTjSuws=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBm6tpjVV0n0Njhyd34xbFZM6rETWXr9G/Znimtj
 WCxaSfl61qJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZuraYwAKCRDSWmvTvnYw
 k7ZSD/9uTxc+eqUwPyMpcJEu+L0o51gU0jRjLRH1bb0fhmUgVqTTI9eYXkGSlTzqtann02EewO+
 RYDnWdfZ8Bc3dKalDtnDdkdsoeck7TgZ7y7S/YzY/T+e7ZoYmZ9QowJpbC6ov1zArETQ8tBHamh
 Y4WeDhqaqgw+u4kHV9hIWvlQ3nDhv/BZatFQrPi/WPnZdb+jAyu30u/3mkhU2NASSyipdhHRzl7
 iQ52OHY1Lt/eFAxHz/xmg7ED3FVrHKntVdzxYoloIDnSptLJP4RZbFy+AKixr2QLNOs8piFlYl+
 ESgNpJ2junFeg8hv0t/oObeaaOtRu60eGzf1yYwam3kfKIZIqMeOnm3L+9C5zXTe/gymk7ofUMd
 oPyp+VaU5bxTXitJzDENiljHbV/HX0Is//ASnWQIm4JPHk0pmNjilAshj6FsXOi1tMwFEc3rDH+
 zpZ4NrDNoORrtUdFx9dhW22g94j+0joh8u+rKgBxbDvmQmw8d93KyMKoKsM/6iNSSpx1ZbliHtd
 dSbFsWNsy12luEXLjvs7e/BjMR0n535SnuaClyyYiCOX/9KgZ7FKcmOgisazQFh6Duqy64fj1Mj
 w3X9JGGvO16GU44T8cZbPpwGHqv8Wkgy71MV4X9c+H/7a2/snW+SfY1LeWvyA7g+QqTFqTHaMkH
 oGwiAnwxtf3ZMuQ==
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

TI upstream has moved from "mmio-mux" to "reg-mux" that doesn't
require the Mux device node's parent to be a syscon type.

Add support for "reg-mux" compatible.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Roger Quadros (2):
      mux: mmio: Support "reg-mux" compatible
      phy: cadence: sierra: Don't spam console

 drivers/mux/mmio.c                       | 7 ++++++-
 drivers/phy/cadence/phy-cadence-sierra.c | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)
---
base-commit: 9eb0d731d800b4fbc8e9ed0178fec0d6f201d911
change-id: 20240913-j721e-ums-e37635f7c604

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>

