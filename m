Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A264BCA0EEB
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:35:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 673C280422;
	Fri, 22 Aug 2025 20:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="YCa/xf5m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A86083093; Fri, 22 Aug 2025 20:34:39 +0200 (CEST)
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [95.215.58.182])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A924382103
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1755887677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Q4CGJuoIq8dtf1mV0ikK8TcsYF3cC0pFEty3O4TCiA=;
 b=YCa/xf5muu0N+E00Nj0htkHLVJBF8J8qgvegdIF8UUoNs/SnWUwLQboTUDsyuCQ5l+zEs8
 nqAWhCwaYfwE8qY8oxWCNSyujuG+zr6BgmJFSdVjnnXXX/tcPoifqVkT5SVBdL7/M38+TQ
 3MBj/I7E2QKoP9XIejjQ8QwdfY2FYhs=
From: Henrik Grimler <henrik@grimler.se>
Date: Fri, 22 Aug 2025 20:33:26 +0200
Subject: [PATCH 04/11] ARM: dts: exynos4210-universal_c210: rename max8998
 regulators node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-exynos-power-v1-4-9e2f2f740029@grimler.se>
References: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
In-Reply-To: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: David Virag <virag.david003@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=967; i=henrik@grimler.se;
 h=from:subject:message-id; bh=GQNmhHtAyPnOaPWCJbTKdO5haFev71YR5w66yWPJIXQ=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBoqLgcPVeuO5j4bZ0sYiRgtC+sbqrLUOFjuF25q
 Mz8Di13wrmJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaKi4HAAKCRCwB25JC3Fh
 a5YKB/0exSdBcbfJ/3QoGFLPwl588CDDn6g6+whcCcnFoq5HmAvBgroz8uqL60HqgeY6+c2GNgW
 lbfYzrybXUyuafrv30evJ3sDBsYG01/DAXEwZbbaYVaLqw+eIHznoASdNSDZh5htYFK0vIeJWui
 ypysHtQlOwIkdtIhpYyxnDK4FqhtBu+CBG1gN3ejnbGReki4nmbpZWoovfuX5IndMF7dN9yR5qR
 /5o08g3D8cwtnPAa8j59K3SjmllwlpAbcIvtqHqDHq0DCTOs6USnE0PMcisTW5DPL/tcXnhjTfm
 nT7uRV0EMInXnpZnwODRBGMrU0uVcaLCLnmD/3iz3E8LYR1Q
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
 arch/arm/dts/exynos4210-universal_c210.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/exynos4210-universal_c210.dts b/arch/arm/dts/exynos4210-universal_c210.dts
index c87b92be609d9e92b1614f7228e1051efc70b7d0..cfa99b62828610f5ba7e27fa6e79dcc6500be721 100644
--- a/arch/arm/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/dts/exynos4210-universal_c210.dts
@@ -77,7 +77,7 @@
 	max8998-pmic@66 {
 		compatible = "maxim,max8998";
 		reg = <0x66 0 0>;
-		voltage-regulators {
+		regulators {
 			ldo2_reg: LDO2 {
 				regulator-name = "VALIVE_1.2V";
 				regulator-min-microvolt = <1200000>;

-- 
2.50.1

