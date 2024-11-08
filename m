Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D066ED5E12A
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 05:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67C028900E;
	Fri,  8 Nov 2024 06:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731043319;
	bh=HvLqSL4GSadNljzl0PGqXf0pZJe6kJNTMqCZb4JG3uQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gQYkl6uDscIta/TNJ3OL0EYAOPxn+Gag0MbLJMq/0M98zg51T6st5ierMYMLw92qn
	 ZUWWT84p8olMpxujDvQLCywG+aFOCRyVRSE2UD1VYnNkGzYXNEz2yiZwK87x6HZJ0O
	 YgLgZOhN9jtbV20kh6q8/McyiLdWGIwQp0FnVqGYluhnUZSCM/mwrFm5Li++f/MkkS
	 oyHKxBHcTmpdbwTPkxSZwgyVGSOsaOICSA8l0mtcylDTdZjQhIXLU+bgAF8Hz5ygTJ
	 4a+Hl0kMNsfI2BZDTUNEZGILZT2lnyNuXyCSXNx8+/mpiyFgXDxunXCzBitLWjK2Wx
	 9lJPAt/zfFeGA==
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu
 [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A0B9A890BC;
 Fri,  8 Nov 2024 06:21:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731043318;
 bh=HvLqSL4GSadNljzl0PGqXf0pZJe6kJNTMqCZb4JG3uQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gX8YEV700ucAsPS0UXaVHoR+QDKLs04KgSJX6WmalEu5594byOezC4XWhLXxIDSua
 tuPrW4jq7ZGacrUhCWutFLWcmDaLJXddxZxeb3T8hDY9JKxQ4GvwmXq+JW8tzaYQm4
 bou/DW2mJPNuepVOkIf4H1GG41ZQCnEgPmyPOwVyFyunEfdk5HV/4eyGjrbBo4T6+I
 DkelWET82+c+dELavagLJg+dENk/43P2m4+GVlTKyYTViG6EgnLUb2dxA364v51SlU
 OSVIrHawhugirNyJThbaQei+VThkOZAXYrcTHhMqgDyelBiEeuKvq/+ZXIFf2mzqh3
 /VhJBeVu9wQRA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 07/22] siemens: imx8qxp-capricorn-u-boot.dtsi: fix boot
Date: Fri,  8 Nov 2024 06:21:28 +0100
Message-Id: <20241108052143.26874-8-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241108052143.26874-1-hs@denx.de>
References: <20241108052143.26874-1-hs@denx.de>
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

current generated flash.bin image does not longer
boot on cxg3 board.

Rename bootph-pre-ram to bootph-all so flash.bin
boots again!

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 arch/arm/dts/imx8-capricorn-u-boot.dtsi | 65 ++++++++++++-------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/arch/arm/dts/imx8-capricorn-u-boot.dtsi b/arch/arm/dts/imx8-capricorn-u-boot.dtsi
index cba56188f86..a1058a09a9a 100644
--- a/arch/arm/dts/imx8-capricorn-u-boot.dtsi
+++ b/arch/arm/dts/imx8-capricorn-u-boot.dtsi
@@ -6,130 +6,129 @@
 #include "imx8qxp-u-boot.dtsi"
 
 &{/imx8qx-pm} {
-
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &mu {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &clk {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &iomuxc {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio_gpio0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio_gpio1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio_gpio2 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio_gpio3 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio_gpio4 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio_gpio5 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio_gpio6 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio_gpio7 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_dma {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_dma_lpuart0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_dma_lpuart2 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_conn {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_conn_sdch0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_conn_sdch1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_conn_sdch2 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &gpio0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &gpio1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &gpio2 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &gpio3 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &gpio4 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &gpio5 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &gpio6 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &gpio7 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &lpuart0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &lpuart2 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &usdhc1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &usdhc2 {
-	bootph-pre-ram;
+	bootph-all;
 };
-- 
2.20.1

