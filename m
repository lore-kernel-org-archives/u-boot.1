Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E959B10F997F
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 20:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2072C83D8A;
	Wed,  8 Apr 2026 22:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="cGUK6IZl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E90F3840AB; Wed,  8 Apr 2026 22:30:26 +0200 (CEST)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [91.218.175.189])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E534B83CF5
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 22:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1775680224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSR7ycAPH/8ip9z+10dIFTdBYOwKZhw6MR+BtiNFG0c=;
 b=cGUK6IZl+XXlbUP3VAc2ZbkUu3Yn5165z0/HQWnZ5op2F9NzkrwvisDZH/POybBNWRc49u
 o41lc6A3dfTvSou4cAnB8BFiSGvEJwqsOZwdSqpxTiVjCJHxG5sXypMenogAyGGgJTwQf0
 P5caY4tEuIUsx51xIseAiKUSGm97xPoe1xy6wpytx6VvAfRZVX4IBdBgfChErCTbVeuBYq
 MccCOAHDAMEdxwazGzWS5sNtbq7Bry4Q1IoRF/dy1Q1W4+x4pXNsFdSWg27TmeclclI0Qk
 yVtRa+C7t9bGdIhES79Q5T3vpQ1EVMHxuYD4ezSbMWMWuS6L2NWGh9Ye3Xg0FA==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 08 Apr 2026 20:30:13 +0000
Subject: [PATCH 2/4] arm: meson: enable SYSRESET_PSCI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-b4-amlogic-sysreset-capsules-v1-2-6f3386eb5124@postmarketos.org>
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=912;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=Gxp3GAIXrBnp462RNs+PPcQQYjHfLyf+ZcX3PQ+wncs=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp1rrbpbnC3HsysF78UJMhK1KOUgSvrsyY/RBtx
 RlaoZCzHGGJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCada62wAKCRCEr8vQ14ma
 AzN0D/9JmilcrdlCGTKeOv9a48R9O0eOAjvd/YBmwyxwjBOlxcHoUbyyI+MQKO8N07ziDzb9Xgs
 1DjFPoIegUrjMADrltIQf0pUNfCCmpxp5vmL20hiAc6JDZ0TvTkgoMTYlukblQcWFtCykV/RHv+
 iyTg7qDDinipAvmmo5MEhzo4YjtgpUTlbTR2G/UW5H44Tiq+whdHz1ZOFkbEcp1A7duQfm9iy6l
 AhXlMmpMpd4tVBXmlotmo+Kg0q9Kvul6yCdoyqew/VDGPblAihYtARqWkkCTlqqATrTwU8ITHtL
 biuoXBgQ8oKB+4Cn7TcxBS/RX9P5ow9EfY8/y4Ucyrvk7YkpzKBx5ja8bQBYvHPuJAnHxcmhlPr
 DmlS3o89el8tXzjh+cLzBkSGie8ZhEZzgj0hINeJSGmxrBDgp9QzCbrKsnq9HBaqqzPrwMzmrKf
 fito/1eSKc9OykEcDb0NvptNMEdK3P0Z3cKEM5f5VcusCAWYHIqk1dICjXuN03ywZ1MLmTJbOhH
 Ib1L6X6qSQn9byWkgWvp6q0MMdtz0+iGqFOIJaRrERYhn4pzPhVpv5+h8e/mI+KkbBtPkEz9k9M
 WAqNIK6eFbJNKra2Ae92Y0Tt/HXYvNmcQCYBZqPyWnJATmyMdr4IEBKGrb42oAqF8VEPrIETqXV
 1ir9/CfvEicb4rg==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
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

Previously, Amlogic SoCs defined their own reset_cpu() implementation
that essentially just did what the sysreset PSCI driver already
supports. To reduce duplication (and allow for EFI Capsule on Disk
support), make use of it instead of a board-specific reset_cpu.

This does not affect SPL, as in that stage we do not actually have PSCI
(BL31 is not loaded yet at that point).

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 arch/arm/mach-meson/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index ef86129b535..a615d871095 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -7,6 +7,8 @@ config MESON64_COMMON
 	select DM
 	select DM_SERIAL
 	select SYSCON
+	select SYSRESET
+	select SYSRESET_PSCI
 	select REGMAP
 	select PWRSEQ
 	select MMC_PWRSEQ

-- 
2.53.0

