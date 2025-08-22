Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEB9CA0EEB
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A9C9830C0;
	Fri, 22 Aug 2025 20:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="H7BWs6H7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1376B8309D; Fri, 22 Aug 2025 20:34:42 +0200 (CEST)
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com
 [95.215.58.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 310C682103
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1755887679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ccsKgldF+22c8jGHD5hsWWn5y1dJu4c63TMv+VXcfw=;
 b=H7BWs6H7v5lCcYcmdoXr7lB6/R+tZE/vQff/kPyNP/+1TJnhKYYtzh0ibbyljjmm/M7J0/
 W7l38OqD1DYFknqleS/piyFR8FRV0cXw+mrOvFf1pB0xZiOJ5VYCGZRAFv9tAtIw9Zy2Pd
 GspcEvnnl2o9RIV6Cuor66SffZc9D0U=
From: Henrik Grimler <henrik@grimler.se>
Date: Fri, 22 Aug 2025 20:33:29 +0200
Subject: [PATCH 07/11] power: pmic: max8997: support maxim,max8997-pmic
 compatible as well
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-exynos-power-v1-7-9e2f2f740029@grimler.se>
References: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
In-Reply-To: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: David Virag <virag.david003@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=750; i=henrik@grimler.se;
 h=from:subject:message-id; bh=aV3mNw+limoGlRj2qJaiwLJJSFWtbEwDQPc4FTFa0s4=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBoqLgmJZoBBunFkHpQuDib8RuudJN7wajYMwlMa
 9fueFYAkaWJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaKi4JgAKCRCwB25JC3Fh
 a9OKB/4pnuRBnW96BzmSnuj1E4S6cDR6oj5ZIb1soYVsWKcwJUZQcdw+GatJlqvr+SFGc9FOmvN
 GNBETV9KUTdDeIpPe824mHfybtCxgVSzgSuRfTEkHaM4aS7KI80FDaat/c++GL9QRPJbwahtS2O
 cMYqhBS1jigFAb2qIXSpNBRHJeaCDjJB/NGsSIQnHejlh+J4e9czLzAkAcdUBn22nLesVcyYyMN
 9J/VTjAMYgUOF3H4Wck4CU0885dhx4Qzen+AqnMw4vHiBiRUT8kkdzWk6FKajKOMvjGlNDvttQw
 Uc9ycXIAxLuETmv2hs0uPQsCm24Im8AdNXhA+LE11SHTSzqS
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

Linux's DTSes uses maxim,max8997-pmic, so check for this compatible
as well so that max8997 pmic driver can support both u-boot and
Linux's DTSes.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 drivers/power/pmic/max8997.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/pmic/max8997.c b/drivers/power/pmic/max8997.c
index 4afa6c84ef82f986d95edc00255bbd029513f769..ecdad505b2633c3d2e6ef3a39048c602bc18902f 100644
--- a/drivers/power/pmic/max8997.c
+++ b/drivers/power/pmic/max8997.c
@@ -47,6 +47,7 @@ static struct dm_pmic_ops max8997_ops = {
 
 static const struct udevice_id max8997_ids[] = {
 	{ .compatible = "maxim,max8997" },
+	{ .compatible = "maxim,max8997-pmic" },
 	{ },
 };
 

-- 
2.50.1

