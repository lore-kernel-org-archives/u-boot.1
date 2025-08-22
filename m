Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF285CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2BF683093;
	Fri, 22 Aug 2025 20:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="KbkIZwyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BB1382C84; Fri, 22 Aug 2025 20:34:40 +0200 (CEST)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com
 [95.215.58.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A32C8006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1755887678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54V4REVhiBW0V1H8/NSVq3xhtuFccu4HCakV1mWwF+0=;
 b=KbkIZwyVru8lXZyDtq+9PRDjbYvzYBX2oBuCwyMNJpNOeX6mXO383fORjIWXAuMrdMGTdU
 psBUBFPCBvl429GFqpvChwjC6dNEhpzxUQNAS7A7v6InAgVZScljxh78MonLisq2zfhPd8
 kZ20nDR+B6nbo5T+XtSRZW3q8mRfqCY=
From: Henrik Grimler <henrik@grimler.se>
Date: Fri, 22 Aug 2025 20:33:27 +0200
Subject: [PATCH 05/11] ARM: dts: s5c1xx-goni: rename max8998-pmic
 regulators node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-exynos-power-v1-5-9e2f2f740029@grimler.se>
References: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
In-Reply-To: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: David Virag <virag.david003@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=885; i=henrik@grimler.se;
 h=from:subject:message-id; bh=g7yHDmM75d+0DFlV7+nWRS+J6oE/NKqBJ3BqxzioMtA=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBoqLgggFVjbgLb2lTcgY6RkzpjblsKhscgBiml6
 ByTkgxefoWJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaKi4IAAKCRCwB25JC3Fh
 a+N7B/0XtbNYbjM5DmoFZOqO0/kk5+tnIhsXwACNDCZPy+mUD+3raH69kGMbsO2uZRTMLROyDsC
 O8QYn/MThxKm8ugDU7uq4Ees65bdCaTEhgFjsH5BayH9ujDcK7D0BIpz+u+gGhb0WrxnvT5rCch
 xzU83D7lYiQiCCtLpNYPqUUj1XyAUWI2Uq3YIHeFf1IyKhrtWIyG1V+wpZK/iGrsiUS8byclFpZ
 y7qjvMnHCGaSCZxXRdGt59hVf78s25qYLe2eMyxHtK85NrJlly6bON5mVY9+78X2kZWMlrYSPlc
 OQtXa7mYyWxEMcAhgz9uwEzIWPJd14O5rdbEwIpga8QiDiHU
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

Linux uses just regulators { }; instead of voltage-regulators { };, so
this change aligns the DTSes found in the two projects.

The max8998 driver does not yet parse the regulators node, so we can
safely change its name without breaking anything.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 arch/arm/dts/s5pc1xx-goni.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/s5pc1xx-goni.dts b/arch/arm/dts/s5pc1xx-goni.dts
index 90e3405040af5d60aa5bfc62050f7223543c6c69..6c15a87ffb0f1741e3ebffaba4868df30eed09f5 100644
--- a/arch/arm/dts/s5pc1xx-goni.dts
+++ b/arch/arm/dts/s5pc1xx-goni.dts
@@ -45,7 +45,7 @@
 			compatible = "maxim,max8998";
 			reg = <0x66 0 0>;
 
-			voltage-regulators {
+			regulators {
 				ldo2_reg: LDO2 {
 					regulator-compatible = "LDO2";
 					regulator-name = "VALIVE_1.1V";

-- 
2.50.1

