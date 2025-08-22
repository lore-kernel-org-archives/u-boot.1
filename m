Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E31CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7375E830F6;
	Fri, 22 Aug 2025 20:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="ZcUNeeoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6FA5830F6; Fri, 22 Aug 2025 20:34:44 +0200 (CEST)
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com
 [95.215.58.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F25DB830A0
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1755887682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mSgT8GQjvSi1CnhDLJflTmJ5hEXU7KFVPJPEahlw+Zs=;
 b=ZcUNeeoHnlYQ6xXYzaS/jmYOWWycQ+40X9s11JoBVHZvsEibXZBBvui5/gw7WlwskX6AuU
 vaFf6uOi9CwScaR/ebp7Rg2XwJs1LaiLBRsk0I43wvQXuJAvstzTOpjmezjXT0G9cVT3vM
 Nx3wMUF0piD075TvSXj5sXQJMt6N7VE=
From: Henrik Grimler <henrik@grimler.se>
Date: Fri, 22 Aug 2025 20:33:31 +0200
Subject: [PATCH 09/11] power: pmic: max8997: drop maxim,max8997 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-exynos-power-v1-9-9e2f2f740029@grimler.se>
References: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
In-Reply-To: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: David Virag <virag.david003@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=735; i=henrik@grimler.se;
 h=from:subject:message-id; bh=CDueucwjbSNKul4QMciW1ZtubdKwyPpGkcqJ/y1zdpk=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBoqLgsTAejWkLLUF+Lb5eoIBmiK1LT4xBO3QN/W
 B2izqAiP06JATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaKi4LAAKCRCwB25JC3Fh
 a6eRCAC4RD32vjo4dpQu+3eFh9XcdfZ41K9gBSkhdkRXSuzywckdrExiyokkmlJqhicGGZ5pGd6
 kg/WEXJsmNU9kXqR1KH/u7Aie78KnWGYmyDWVkrW5vZktqkUKcpA9nHtK1MWsFDf/nbyaTdZZU5
 nLJpj5vzpBa6gfjSSnoTYeS/wO0hxmYNGzrCDNbSQejyeng6u5my4jeSW6W4mKSpCiR3+9eQXnn
 WXoVyOWizk0hpd85bHGB4OQKUkp50v84Z3iRoUAHbjN1G8cNo6B2Z5xgDn7E5bq1koHtDMCerEm
 AUbpjYTa40FVao0zQ9OnlbdEQNN4bXfkmE8SHwdm4GHlePCR
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

All u-boot users now use maxim,max8997-pmic instead, as does Linux's
DTSes, so we can now safely drop the maxim,max8997 compatible.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 drivers/power/pmic/max8997.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/pmic/max8997.c b/drivers/power/pmic/max8997.c
index ecdad505b2633c3d2e6ef3a39048c602bc18902f..fb65a3ca73006a03ec3ce156a4ea9b1575affe28 100644
--- a/drivers/power/pmic/max8997.c
+++ b/drivers/power/pmic/max8997.c
@@ -46,7 +46,6 @@ static struct dm_pmic_ops max8997_ops = {
 };
 
 static const struct udevice_id max8997_ids[] = {
-	{ .compatible = "maxim,max8997" },
 	{ .compatible = "maxim,max8997-pmic" },
 	{ },
 };

-- 
2.50.1

