Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182B5CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECF4282DA1;
	Fri, 22 Aug 2025 20:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="IYKysKSQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 323D5830B4; Fri, 22 Aug 2025 20:34:44 +0200 (CEST)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EDD082BA7
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1755887681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5AcrbSuKDlDW7p5lqGbdgawv1Lckj5eGymu9gA+qzoU=;
 b=IYKysKSQQF6Qe4FBlu4SOg8fynkXbE4CBOxmcKvSLoOngkB9YeNnf55AXhiwYTw/5I8MTt
 wB21KTz60mkxKtgCZz2X+oJchIkOLhs9oGB7Th3hNEb21z5Vmj3B8yxTGkNIzJ5Z56Mn69
 mpMw6WyLozxWYLeWXpu4qXR6N3ms8EI=
From: Henrik Grimler <henrik@grimler.se>
Date: Fri, 22 Aug 2025 20:33:30 +0200
Subject: [PATCH 08/11] ARM: dts: exynos4210-trats: use maxim,max8997-pmic
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-exynos-power-v1-8-9e2f2f740029@grimler.se>
References: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
In-Reply-To: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: David Virag <virag.david003@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=768; i=henrik@grimler.se;
 h=from:subject:message-id; bh=RZF92vTFp9F6QZUVphR2reVvnW7WJP/Ut+IN+kncEeo=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBoqLgpqi0em3Uq2m+UtQ2QoZAL2t0t7m4j3XCVu
 7GF8mA93RuJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaKi4KQAKCRCwB25JC3Fh
 aw8YCACCmdgStPXB/xVynAvHXrDMTJetGuI4QsyOeJY4zfsTPKGRjZttZGxdt1DQ/INAoX054pa
 T6gqQUa5LbD9/1lz+KgXgv8Ap3o/GCCjoD0x+KmjmawB1l57D8WO7eTKzxx3DY2HRPeh3/M+57a
 kAGVubGsJw6xNQRcL4ib0Ny3niipAWpK5SrR8NA4CdzP9dZH1WWy48NpSxo9CEBcr/7u9pRSxEi
 1NtUz5hR/viy6OsBkd0KKhQYMykOZvMsqsCcdFAPRoqdx36KVc8BNtWMlYyjPo86dBJ+CQzugf/
 JaclMk9nE+v1n/L6jpzzep/K4A7kPe8Kxj0DOMGJLfeZYIa+
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

Instead of maxim,max8997. Linux uses maxim,max8997-pmic, so with this
change we align the trats DTS with its linux counterpart.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 arch/arm/dts/exynos4210-trats.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/exynos4210-trats.dts b/arch/arm/dts/exynos4210-trats.dts
index 88e9c0ed2bb013df5896a8350042b55c40027a1c..2947d79f0cd3a412c9763d98a304555250fb3eef 100644
--- a/arch/arm/dts/exynos4210-trats.dts
+++ b/arch/arm/dts/exynos4210-trats.dts
@@ -102,7 +102,7 @@
 	status = "okay";
 
 	max8997-pmic@66 {
-		compatible = "maxim,max8997";
+		compatible = "maxim,max8997-pmic";
 		reg = <0x66 0 0>;
 		voltage-regulators {
 			valive_reg: LDO2 {

-- 
2.50.1

