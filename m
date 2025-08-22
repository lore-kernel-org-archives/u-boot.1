Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4884BCA0EEB
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2029983013;
	Fri, 22 Aug 2025 20:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="Q/jTKnJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4765080422; Fri, 22 Aug 2025 20:34:38 +0200 (CEST)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com
 [95.215.58.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 643BE8006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1755887675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nnzJTjO4yB8+H7PHx7Nf1nxlz4PDcFVij3PUppHkRFY=;
 b=Q/jTKnJe2FLFobdTIXvzihOR2RMW9v5AmwYsHaZuKPkIix/h1PaHUg80sHaYn+1jp/lBls
 IVds9J1BhM7ht1y9vwj+haLghE3v2AdfSzqmb86U0+lSd8VOhLtk1vOA/AM5scSCcomDH+
 +XVaY+MexRccI4ENGqxkKMatMnffvfM=
From: Henrik Grimler <henrik@grimler.se>
Date: Fri, 22 Aug 2025 20:33:24 +0200
Subject: [PATCH 02/11] ARM: dts: exynos5422-odroidxu3: rename s2mps11
 regulators node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-exynos-power-v1-2-9e2f2f740029@grimler.se>
References: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
In-Reply-To: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: David Virag <virag.david003@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=812; i=henrik@grimler.se;
 h=from:subject:message-id; bh=LBWo3zmvuydQjfM++6orsfc5iHmTL/EzZnJl6QCdkqQ=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBoqLgWSVuoTNKerO7Y0xqmzFC+a7R/VLyLrze5U
 xn+8EZCCPWJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaKi4FgAKCRCwB25JC3Fh
 a0uyB/9r27riP9YwLJAHOMyjj9gBvx0ZixFg6SPc4GCsdYTPc4x7IJZUZB2YHI2QnEugPFBMRrl
 PxDjKWQl+JjHJwY8O747i6svshd/eI0bSdWR/5f4RLe/QwKfy4Pk5HsCScIyakk8gM0PN76dONo
 SqAjzpO0u4w44177vafFkbnzyrzI8ewkmM6L+QNZnzI63N8OnWyFAjGG/wy+nbyqr1sitmvgG1D
 BOV6dwQwiFzXet2FB4hg9GzoU9BDzCz177EMtOOArYiL8PWokfHUqF6Fpnl7p9eMMf+3KOW5MLL
 hp7p1yIkK+rVK8gPwJxcXeaBDQHWAce3FoRXW2slZ0a0OKG1
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

With this both linux and u-boot uses the same node name, which
simplifies devicetree parsing in s2mps11 driver.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 arch/arm/dts/exynos5422-odroidxu3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/exynos5422-odroidxu3.dts b/arch/arm/dts/exynos5422-odroidxu3.dts
index ef25cf774470f362e0bd7b1043164617845edc7a..e147fcb8643b5bc40987e95a29620a63b658ced7 100644
--- a/arch/arm/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/dts/exynos5422-odroidxu3.dts
@@ -40,7 +40,7 @@
 		s2mps11_pmic@66 {
 			compatible = "samsung,s2mps11-pmic";
 			reg = <0x66>;
-			voltage-regulators {
+			regulators {
 				ldo1_reg: LDO1 {
 					regulator-name = "vdd_ldo1";
 					regulator-min-microvolt = <1000000>;

-- 
2.50.1

