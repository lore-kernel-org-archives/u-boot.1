Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5437CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1482B83164;
	Fri, 22 Aug 2025 20:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="dP5XQygM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69F0483106; Fri, 22 Aug 2025 20:34:47 +0200 (CEST)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com
 [95.215.58.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AB61830A0
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1755887685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IGM3DFG3IOeJldqHqDEY/RwidycwNV3f6eYKX+uH0J4=;
 b=dP5XQygM/sSUndQwZXikS0gsUMJJODtWhn+NP6awQwcQ9QM2VPtXVF+k/nH0jQE+EYx+u6
 6L6ffewqSW0bJTu4XFcNikZiBvE1dtbTxlxe/wVNHoNJ139dBr9/TRf+LEzZ19L74ICjaa
 lBSwKTDkWTi2tHLcGdQDbAJzDxRp0T0=
From: Henrik Grimler <henrik@grimler.se>
Date: Fri, 22 Aug 2025 20:33:33 +0200
Subject: [PATCH 11/11] board: samsung: odroid: drop exynos_power_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-exynos-power-v1-11-9e2f2f740029@grimler.se>
References: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
In-Reply-To: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: David Virag <virag.david003@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398; i=henrik@grimler.se;
 h=from:subject:message-id; bh=HwyOBLIJUYJxKIicutiJTH5WsePioxwMCLxGRuLbaFk=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBoqLgzkFbG0D7KJdWHEqHAhSgZUDrHsuVqNd+Lc
 oICmTUkHbqJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaKi4MwAKCRCwB25JC3Fh
 a31AB/4oAWb0RAzSQqsJfmLicKuc2jGN6X946B4wdhaD/KrVP4SbD9d1y0e/If+fyJH9Of4LVmt
 AbeWGW6K8co3wLJ8hLNP+mPrq4mNiiPyoAW7eerw1ohtBVXauXN2+/XZcHCBFFM/KIq2t1Qe2Bl
 hmzGEOILH2sggyNEKESjuYUhtKzYPZBlAQECBGLHz4x2XfWvOH+lK9JLf6BqlQsM2lXeX89IDtx
 vkAPAHy5qGFhwyArrbtphfaXR1nOHhw7SpylPBJJlRt0p27ABZgS8jIgim/VFvwE55UIj+2oIsZ
 0H9+9zgYmTKJsRvM/GJdhZnEeyqmknBsQKv55q1aBIfcYWKM
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

exynos_power_init sets up regulators for the emmc and sdcard, but
these regulators are already marked as always-on and boot-on and hence
are handled already by the regulator-uclass. Since we currently try to
set them up twice we get error -114 (EALREADY) from exynos_power_init
on every boot:

    LDO20@VDDQ_EMMC_1.8V: set 1800000 uV; enabling (ret: -114)
    LDO22@VDDQ_EMMC_2.8V: set 2800000 uV; enabling (ret: -114)
    LDO21@TFLASH_2.8V: set 2800000 uV; enabling (ret: -114)

Remove the superfluous exynos_power_init to silence these errors.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 board/samsung/odroid/odroid.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/board/samsung/odroid/odroid.c b/board/samsung/odroid/odroid.c
index 84d6d919f07f33fa4122910db31973a97358f29d..a48b8e94b77ce9b10f3e1937020b4f33a28c30b1 100644
--- a/board/samsung/odroid/odroid.c
+++ b/board/samsung/odroid/odroid.c
@@ -428,21 +428,6 @@ void exynos_init(void)
 	board_gpio_init();
 }
 
-int exynos_power_init(void)
-{
-	const char *mmc_regulators[] = {
-		"VDDQ_EMMC_1.8V",
-		"VDDQ_EMMC_2.8V",
-		"TFLASH_2.8V",
-		NULL,
-	};
-
-	if (regulator_list_autoset(mmc_regulators, NULL, true))
-		pr_err("Unable to init all mmc regulators\n");
-
-	return 0;
-}
-
 #ifdef CONFIG_USB_GADGET
 static int s5pc210_phy_control(int on)
 {

-- 
2.50.1

