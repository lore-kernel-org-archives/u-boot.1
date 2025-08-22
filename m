Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AB7CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C095A8312A;
	Fri, 22 Aug 2025 20:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="NH+Y6Nbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AD3083102; Fri, 22 Aug 2025 20:34:46 +0200 (CEST)
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com
 [95.215.58.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCA198006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1755887683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CweGNS0EFeGXTRQ5Qu3X8kWtwLmqB7uydGy75gE4+5s=;
 b=NH+Y6Nbb1Z9vYCjwprhxOczr3vYAl5Za2EYN7Hnc5+qkWWkBjFrFYIqXVZaH8+40Rt0d3r
 +kqdFQOfd3lEzUb51rjBMqhY5rPyzCU228FqSkRtEiYsDzzSPRc5ylNRslmyG2SMq5xNEc
 CqrUFR5HteXGZr8rgz6cEDsYRtlzNy0=
From: Henrik Grimler <henrik@grimler.se>
Date: Fri, 22 Aug 2025 20:33:32 +0200
Subject: [PATCH 10/11] ARM: dts: trats: rename max8997-pmic regulators node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-exynos-power-v1-10-9e2f2f740029@grimler.se>
References: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
In-Reply-To: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: David Virag <virag.david003@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=944; i=henrik@grimler.se;
 h=from:subject:message-id; bh=reElxba9DAnsgqoOVvih/+qazTBvChK8q5D57LXZWys=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBoqLgvCke2NB4yuSPzswz8qefvFQtPFEVy1alqn
 /1/vB4UeW2JATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaKi4LwAKCRCwB25JC3Fh
 a/LxB/sFdn41MMz1gK8o+FKHje3vnUFoYCc0PCtdefW5EQ02E9qBZJg7IkCp4bUYfUhWDeblmP5
 41cklCFl0PSaXham2K955K9B1bCp2DWwQv4FwZBYh7KYWYJdUevLic5DcMLo9wAJUjnr6gIb4o/
 S/JTMMYDE3mSjg1kLPCEwJnce38IHeedsrJ+78vNth7snbhbGu52bSX2z7uFDZ0bxG+3GbDcWtz
 gbNvFzcgyH3jmCwUnd4YxjShX4Ro0DVi/n/H5o/qiukM+ohTvnA19nqd9QkQshrG/iE90RC856H
 aUpHS90FLgap+znDWijDo80J9tNgXIDxGNPVxxP8H8MOZXKN
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

The max8997 driver does not yet parse the regulators node, so we can
safely change its name without breaking anything.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 arch/arm/dts/exynos4210-trats.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/exynos4210-trats.dts b/arch/arm/dts/exynos4210-trats.dts
index 2947d79f0cd3a412c9763d98a304555250fb3eef..38b168950df912121d49178f97ecb21cf1ab9ff8 100644
--- a/arch/arm/dts/exynos4210-trats.dts
+++ b/arch/arm/dts/exynos4210-trats.dts
@@ -104,7 +104,7 @@
 	max8997-pmic@66 {
 		compatible = "maxim,max8997-pmic";
 		reg = <0x66 0 0>;
-		voltage-regulators {
+		regulators {
 			valive_reg: LDO2 {
 			     regulator-name = "VALIVE_1.1V_C210";
 			     regulator-min-microvolt = <1100000>;

-- 
2.50.1

