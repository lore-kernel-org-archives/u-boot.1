Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06B6C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 13:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C9B88006D;
	Fri, 16 May 2025 15:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mNN+K01/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A3480107; Fri, 16 May 2025 15:09:14 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 385BE80050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 15:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 4426AA4E79D;
 Fri, 16 May 2025 13:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA88FC4CEE4;
 Fri, 16 May 2025 13:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747400950;
 bh=vkrrbdWW3U38P79nGUST3fCWh13q+dkTTtRYHnArcf8=;
 h=From:To:Cc:Subject:Date:From;
 b=mNN+K01/IzMcY+Tyve8HOjCWbEArK+M5C9vpTFhJyz+vBSIVSC+FOGiMDhBXARRpE
 iYaB0By/ooAPRBSDJCut2prFLKyby9HjAOaDUri3VMMAy+hfdXMLNrqgaRgqXsAr7y
 wJaKcbhc3rJTpbVPgIzI6/QGWzQ2sbLv46vtv3mKYGHSWsIS06SumH8uJ9VB1tKqJZ
 2/1Xc8jAAZ5vRKlDyj0I2fmSxC2XiNialriCv9YqtRyIEa6irwMxTqlWbOvfOPSya1
 O2hyr8/9QKcOzHDuPxyLdsMZ8V68NyJmpiVVZ9VD+D4kznfCGQXhxtMmkL2jwSwNk4
 Cgmcqc5a6zLNQ==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH] mach-snapdragon: of_fixup: Drop USB dr_mode override for RB1/2
Date: Fri, 16 May 2025 18:38:54 +0530
Message-ID: <20250516130854.606067-1-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

The default DIP switch configuration on RB1/2 is to enable flashing
support via USB type-c port either using QDL or fastboot. It's just
cumbersome to get the host mode working in U-Boot via DIP switch toggle
when you need the flashing capability using the type-c port.

So instead lets enable fastboot in U-Boot for RB1/2 boards which is
more useful in the default board DIP switch configuration. This let's
us to drop dr_mode DT fixup.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/of_fixup.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index b398c6b7b9f..328c7812f30 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -99,19 +99,6 @@ static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np
 		return ret;
 	}
 
-	/*
-	 * The RB1/2 boards only have a single USB controller and it's muxed between the type-C port
-	 * and a USB hub. Since we can't do OTG in U-Boot properly we prefer to put it into host mode.
-	 */
-	if (of_device_is_compatible(root, "qcom,qrb4210-rb2", NULL, NULL) ||
-	    of_device_is_compatible(root, "qcom,qrb2210-rb1", NULL, NULL)) {
-		ret = of_write_prop(dwc3, "dr_mode", sizeof("host"), "host");
-		if (ret) {
-			log_err("Failed to set 'dr_mode' property: %d\n", ret);
-			return ret;
-		}
-	}
-
 	return 0;
 }
 
-- 
2.48.1

