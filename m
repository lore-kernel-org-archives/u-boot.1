Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E08CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 12:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B399C86DEC;
	Mon, 16 Oct 2023 14:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697460672;
	bh=bMW48ApBNBUxEb3Zrb1rlCoSGgsWip3hWVFNGBluChc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nh9pZuSpb7wPjX7IlG7qvR+rtdyr8jAPvYVjGiSdsEW7hk+1SHpJPXcGHnaTMOBrq
	 HIKo5dMbxJouK6niZX/i9plJ7+jLQ9lfSARdPQy43DB9uwHQ7I8uMbPm8wjvdG9XSd
	 aPjP3iBAQz1xgBYfHSeTqy+GGnsbXlzD0xmXIT1vkJ4D4aR5yzqXSX6WyfOWOwq/Qz
	 OpCmo41GXjYzh/W7fpxxFk9WCcWhycd5Vj7BG7eU5uL4IdteLvlAGPrqunYzuuf4WY
	 PLcKyr74gfPcXJhzfiOaBPYsFMKh75SGaM4HKudz1qM7a2dKcs7LGfkFTvex/Dh36z
	 rdupKqEnIhkSQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A274286BEC;
 Mon, 16 Oct 2023 14:51:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697460662;
 bh=bMW48ApBNBUxEb3Zrb1rlCoSGgsWip3hWVFNGBluChc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UsaqXcrSxgaVQc3gtvAI18bs357sLaRCUSjmx+up6loxs5w2qHJSFMkitaekiHjDR
 EjGYqU4fmKpYa859qzuigU3kKGSOMnTzxGX50LZ1TPeFDfLlABh3OMNuTsxmEVVH8M
 qVzL3q/TeyZS1/I3DTDVxQs2UF0izQpyOsagRXkGbYouQlZTeYIxRqLtl7SeZ4jIJD
 tLVSABvwGFJgGKzt1yGPkjWYGBWmtQ1qSXhhanzVr2Nar/ctfK1U5f+/VtNdyXcy3y
 ryOH43GoRPDYLc1LCeekixjaVQpo9QUNPwc1Tc1QmBpCno7YxNStYuIPe0t+ykVajI
 NOL/l3oC5pWZw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH v2 6/7] arm64: dts: imx8mp: Make GPIO3 available early in
 U-Boot proper on i.MX8MP DHCOM
Date: Mon, 16 Oct 2023 14:50:07 +0200
Message-ID: <20231016125019.21583-6-marex@denx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016125019.21583-1-marex@denx.de>
References: <20231016125019.21583-1-marex@denx.de>
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

The GPIO3 has to be available early during U-Boot proper start up for
DRAM size detect to work correctly. The GPIO3 is currently available in
SPL and late in U-Boot proper, which is insufficient. Add the missing
bootph-all to make the GPIO3 available also early in U-Boot proper.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
---
V2: Rebase and collect the patches in one series
---
 arch/arm/dts/imx8mp-dhcom-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
index a29db0ddd3f..b05be57e71b 100644
--- a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
@@ -42,6 +42,7 @@
 };
 
 &gpio3 {
+	bootph-all;
 	bootph-pre-ram;
 };
 
-- 
2.42.0

