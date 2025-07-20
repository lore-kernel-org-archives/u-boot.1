Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3288EC83F22
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 17:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35D0483710;
	Sun, 20 Jul 2025 19:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="VMZSNVnw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB8B682F8E; Sun, 20 Jul 2025 19:00:59 +0200 (CEST)
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com
 [95.215.58.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04EC883010
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 19:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1753030857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=akRedbxrn3llTuo87vUJRPVpGMKEtmQ5uAKx5wlQzhg=;
 b=VMZSNVnwYNECSZShNwIs1r4mLtu93pboCVh6pyvf95hie2H6jYDTLilL5mKoGu8EBCVAzl
 oErGq7VxnBIXpIG/3ti+3P1x53xAJSvEHWnmEPdzyTSh9mbzszPhS8R8bV9g09ju87XE57
 ue/TOF8GSiMpblrPyhdwJ9ssZK5THVg=
From: Henrik Grimler <henrik@grimler.se>
Date: Sun, 20 Jul 2025 19:00:28 +0200
Subject: [PATCH 3/3] mmc: exynos_dw_mmc: add exynos5420 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-samsung-mmc-fixes-v1-3-cb705abfa594@grimler.se>
References: <20250720-samsung-mmc-fixes-v1-0-cb705abfa594@grimler.se>
In-Reply-To: <20250720-samsung-mmc-fixes-v1-0-cb705abfa594@grimler.se>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 David Virag <virag.david003@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org, 
 u-boot@lists.denx.de, Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=henrik@grimler.se;
 h=from:subject:message-id; bh=LgXCutD1dEedoQUm5qUvFf7IcaqW3WQojRI2qtqcFBI=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBofSDBrzzJyejM7TH+z5SjzC+DkuYe3aWD9Zc9J
 uhSkYFREH+JATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaH0gwQAKCRCwB25JC3Fh
 a2ixB/9i6iXynFhTAI0gtELcgK11s5XkXUZPIcP1xAhUq56T07ckCWZazQXKX//1KbON6gz9d2t
 AEopJLavs8hADAnbSBTXgJxtOfrKPUsPkt8TBi/8AhrJl/8UcLIIcj5GTlVj11XLXTBL3BbfrW1
 3f4xvbX0KzyZj8f0BeF79x8tYBiUMuix2iTgKFF0O+hmk7fB8chj/SXhDjY/E3OgTGcubglrtfN
 4RZK8NXkyLJktf3zvoPA+nhbV4yDzu5y7LJzIIWd0aFX8nK3VWu9NQawc6rk/ElUoB/qPXRlGza
 tX0/swOdimC1Xop+9o+iqcA1yNCbVfwzqN19dX0zvOSSg8Un
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

From: Jaehoon Chung <jh80.chung@samsung.com>

The exynos5420 DTSes in linux kernel uses the compatibles
samsung,exynos5420-dw-mshc{,-smu} instead of just
samsung,exynos-dwmmc. Match the additional compatibles in the driver
to make it possible to use it with DTSes from Linux kernel.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
[ grimler: rebase after clksel reg abstraction and re-write commit message ]
Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 drivers/mmc/exynos_dw_mmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index c8bf89d6d3552c1e0ebcaccc48a08087cbf3f596..12e37cb4b7884c5cdac0303245c93988d034459a 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -372,6 +372,12 @@ static const struct udevice_id exynos_dwmmc_ids[] = {
 	{
 		.compatible	= "samsung,exynos4412-dw-mshc",
 		.data		= (ulong)&exynos4_drv_data,
+	}, {
+		.compatible	= "samsung,exynos5420-dw-mshc-smu",
+		.data		= (ulong)&exynos5_drv_data,
+	}, {
+		.compatible	= "samsung,exynos5420-dw-mshc",
+		.data		= (ulong)&exynos5_drv_data,
 	}, {
 		.compatible	= "samsung,exynos-dwmmc",
 		.data		= (ulong)&exynos5_drv_data,

-- 
2.50.1

