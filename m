Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8FFFF8862
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 07:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B16C884255;
	Mon, 27 Apr 2026 09:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="YIqqRRCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EE6B83693; Mon, 27 Apr 2026 07:53:17 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65FCA80077
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 07:53:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 32B5E26F7F;
 Mon, 27 Apr 2026 07:53:15 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e1omETK2hrzt; Mon, 27 Apr 2026 07:53:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1777269194; bh=hF/3/oaGvhJkJCSEl++DsCe4KuN41XkbtppUoI/iw5w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YIqqRRCat9GwiKKPL3mWDM9ziu+hdwaYssWrfumaBQjK+mtAdmmaAIJa26uyelr1o
 ymvhH1g1g16DBxgAfxGgwNYmMHFD9OAzBUMcpv12XJMNZaumneoilliONcnFP4P+ci
 XgruwjHoL1Lu/SKdHZhFHN/HNYJAwjltULAKC4mNfwL+X+tLtZ4kEaXxCCzle0TYYl
 wosNJHSmMC+nlGg+I80Mc8LWbgv7PxlpxubHJcquVW1wvDxaJO6TWlIA1JdwIEcIQB
 wKFwJyMTpPbPOkEtzu9nsA/dO5d8zpFWGrvM84Q0oO2aF7U4ms8Ktc0wvv4p3fibNB
 YXQEp7k8lWZOg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Mon, 27 Apr 2026 11:22:52 +0530
Subject: [PATCH 4/4] configs: exynos-mobile: enable support for HS400ES in
 MMC driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-dwmmc-exynos-hs400-es-v1-4-3495df40a9ac@disroot.org>
References: <20260427-dwmmc-exynos-hs400-es-v1-0-3495df40a9ac@disroot.org>
In-Reply-To: <20260427-dwmmc-exynos-hs400-es-v1-0-3495df40a9ac@disroot.org>
To: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anand Moon <linux.amoon@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukas Timmermann <uboot@timmermann.space>, 
 Henrik Grimler <henrik@grimler.se>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Mon, 27 Apr 2026 09:28:50 +0200
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

MMC0 in Exynos7870 devices (supported by this board variant) can be
initialized in HS400ES mode. Enable the respective config option.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 configs/exynos-mobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/exynos-mobile_defconfig b/configs/exynos-mobile_defconfig
index bff4e6c6fb7..6085c294973 100644
--- a/configs/exynos-mobile_defconfig
+++ b/configs/exynos-mobile_defconfig
@@ -48,6 +48,7 @@ CONFIG_MISC=y
 CONFIG_MMC_BROKEN_CD=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_PHY=y

-- 
2.53.0

