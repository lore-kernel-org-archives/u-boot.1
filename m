Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA6FCA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F3FB82998;
	Fri, 22 Aug 2025 20:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="N/yR+Q3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17E968006D; Fri, 22 Aug 2025 20:34:35 +0200 (CEST)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com
 [IPv6:2001:41d0:203:375::ba])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDB6F8006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1755887671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6omdbLL/gmEuli5kdijr6F4gk9Zye1zu9f26AMWf+Ks=;
 b=N/yR+Q3l1D4hdHc4P7UbvfFz7g+5pGet+tBRQTWwdwQaVH9soMDGkRL+TpiNMkjV0Sx/H0
 /z5JGddRaECYDQLQVi5M/pUQjJi2d/D2uqp4AzLAY6wdRe4MoJ1OILjU70BVJrmp/miSoS
 G29zwPW2jyfrSXHWMOfW8DiGmUROKmA=
From: Henrik Grimler <henrik@grimler.se>
Subject: [PATCH 00/11] power: update compatibles for PMICs used by exynos
 devices
Date: Fri, 22 Aug 2025 20:33:22 +0200
Message-Id: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPK3qGgC/x3MTQqAIBBA4avErBuwKUO6SrToZ6zZaCiUId09a
 fkt3ssQOQhHGKoMgS+J4l1BU1ewHrPbGWUrBlKklSHCpUNOj/MRT39zQKVsY3ptNLcGSnUGtpL
 +4zi97wdsIgjyYQAAAA==
X-Change-ID: 20250822-b4-exynos-power-00f186585e38
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: David Virag <virag.david003@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2073; i=henrik@grimler.se;
 h=from:subject:message-id; bh=pHrTIrZxAN6yBVvyZP3ovKMz/bwoxpCgTCnTKszT0QA=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBoqLgOs1Est+BQ5NKlqxnWfo5Ty9maOo0qqRXgv
 6eW8u6PiKeJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaKi4DgAKCRCwB25JC3Fh
 a1XvB/9RzhNH2rNYuo0mTwYNdKAxMKhfm4yN1buaFvQuh891CtvPc//sPX0+ednnawVNE4Sl/bD
 e+y4S50FpVPdOlRwTpFhvXiPEA2peSYGcmxMTLNW45lL2AJ2bw7iDVSj7dD5oiJ6Mu/IfnvNvb9
 8yzsY0bICYzjhVFfM1zJiQ2ujNzxloUXf89wx+bcOn/Gmdy6wP7Z2xV1M1jYTEBpGpX4v7J0JhK
 zj3w1/popfGSohj0sGO2qemlLd6WqfIrMMjqRfjQSZuzoUh8N6EtmxoBOmcmfinvj7xBx5W/m3o
 tDFrF+yTPjulcQ/fZwFp2HzjeorAndM5s0cLEdBfAbGG59nu
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT
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

To allow for using Linux DTSes through OF_UPSTREAM, we need to support
more compatibles in the relevant pmic drivers. This series therefore
adds support to drivers for the compatibles used by Linux DTSes, and
then updates the u-boot DTSes to use the same, in a bisectable way.

Also drop exynos_power_init for odroid board fix errors due to
regulators otherwise being enabled twice, and also fix some typos in
max8997 Kconfig help message.

The series has been tested on:

* odroid-xu4
* odroid-u2
* samsung-i9100 (similar to exynos4210-trats)

Best regards,
Henrik Grimler

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
Henrik Grimler (11):
      power: pmic: s2mps11: look for both {voltage-,}regulators
      ARM: dts: exynos5422-odroidxu3: rename s2mps11 regulators node
      power: pmic: s2mps11: remove check for voltage-regulators node
      ARM: dts: exynos4210-universal_c210: rename max8998 regulators node
      ARM: dts: s5c1xx-goni: rename max8998-pmic regulators node
      power: pmic: fix typo and capitalisation in max8997 Kconfig help msg
      power: pmic: max8997: support maxim,max8997-pmic compatible as well
      ARM: dts: exynos4210-trats: use maxim,max8997-pmic compatible
      power: pmic: max8997: drop maxim,max8997 compatible
      ARM: dts: trats: rename max8997-pmic regulators node
      board: samsung: odroid: drop exynos_power_init

 arch/arm/dts/exynos4210-trats.dts          |  4 ++--
 arch/arm/dts/exynos4210-universal_c210.dts |  2 +-
 arch/arm/dts/exynos5422-odroidxu3.dts      |  2 +-
 arch/arm/dts/s5pc1xx-goni.dts              |  2 +-
 board/samsung/odroid/odroid.c              | 15 ---------------
 drivers/power/pmic/Kconfig                 |  4 ++--
 drivers/power/pmic/max8997.c               |  2 +-
 drivers/power/pmic/s2mps11.c               |  2 +-
 8 files changed, 9 insertions(+), 24 deletions(-)
---
base-commit: 94e690c44a03959c39f0f5a44a9b89c851af3b60
change-id: 20250822-b4-exynos-power-00f186585e38

Best regards,
-- 
Henrik Grimler <henrik@grimler.se>

