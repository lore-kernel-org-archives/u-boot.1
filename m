Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8B6C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 10:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C61B87DDB;
	Tue, 20 Feb 2024 11:42:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="i2fK6la7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 959A1879FE; Tue, 20 Feb 2024 11:42:21 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7F2587F67
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 11:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1708425727; x=1711017727;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=diYlIzw1jXn1JjAReABv0H8aljyy0w6IByoJ7oqPTFo=;
 b=i2fK6la7WVbSgPfWvvRN5+FdP0jldNHE23z/0WNlpKZh5RX48APT86F8OGEbY6wX
 G4Nuk783me9gzRjajNnSuhCXL3slOrlfOzZXzAtuEVUBXVyAQiBHiJe5AFCaXKHU
 M+rMhlv5dJ/w7V8QZXRRUcYqTtRPrBhGZqCieptDUAU=;
X-AuditID: ac14000a-fbefe7000000290d-8d-65d481ff773a
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B6.CF.10509.FF184D56;
 Tue, 20 Feb 2024 11:42:07 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 20 Feb
 2024 11:42:07 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Tue, 20 Feb 2024 11:41:45 +0100
Subject: [PATCH 3/3] imx8mm-phygate-tauri-l_defconfig: Enable
 CONFIG_IMX_TMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240220-thermal-support-v1-3-f6a97d8d6481@phytec.de>
References: <20240220-thermal-support-v1-0-f6a97d8d6481@phytec.de>
In-Reply-To: <20240220-thermal-support-v1-0-f6a97d8d6481@phytec.de>
To: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708425726; l=631;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=diYlIzw1jXn1JjAReABv0H8aljyy0w6IByoJ7oqPTFo=;
 b=2q1/r+MAb0DBfvgvajcvPPFRIaXypk9CTG6oWpvoVB7vJbRnYN0SMpPFHAdKQ0gxhj/2rUxlg
 Kjt/bEr7+xDA7Zb7/j24qnzgORHWKaloOEI2V4cNZXyRrvIiUoJUsaf
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWyRpKBR/d/45VUg4PrBC2mTtrMbvF2bye7
 Rfc7dQdmj1cHVrF7nL2zg9Gjv7uFNYA5issmJTUnsyy1SN8ugStjS/M99oKfLBWn795ma2Bc
 ytLFyMkhIWAi0b9jAWsXIxeHkMBiJolLtzYyQjgPGSUOX+sCq2ITUJPY9eY1K4jNIqAqcflW
 IzOILSzgJ3FzfzcjiM0rIChxcuYToHoODmYBTYn1u/RBwswC8hLb385hhihxktj4aRXYSCEg
 e3Hvf7A4p4CzRP+zJWCtIgKuEk/3GEJMiZJ4NzEIxJQQEJbYtFML5DAJgV1MEr3nv7JBxBMl
 dr6WgxgoK3Hz/BY2iK/kJaade80MYYdKHNm0mmkCo8gsJGfOQjhzFpIzFzAyr2IUys1Mzk4t
 yszWK8ioLElN1ktJ3cQICn0RBq4djH1zPA4xMnEwHmKU4GBWEuFlKb+SKsSbklhZlVqUH19U
 mpNafIhRmoNFSZx3dUdwqpBAemJJanZqakFqEUyWiYNTqoExN4olq3HHy+W7Nd5svvfRUOPt
 XpFQaYOc7J/enMs6zJWvXclsmZ7m81zawTBhor3K2lcfNhwKm2D5bdeyJYvSHxyfvdHOZYKq
 kLpQAtfb6LMrvuc8/XvK9oM1p7PCFle/u+ZePhMSNnt1FTrIzT4f5lNp68Pz1bHsxh6xi9sT
 /jH/+mKScGudEktxRqKhFnNRcSIAAApr9msCAAA=
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

Enable the imx thermal driver to prevent booting when the system is too
hot.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 configs/imx8mm-phygate-tauri-l_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index 0db3ff890cdd..a416ebc2e04a 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -112,4 +112,5 @@ CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
+CONFIG_IMX_TMU=y
 CONFIG_IMX_WATCHDOG=y

-- 
2.34.1

