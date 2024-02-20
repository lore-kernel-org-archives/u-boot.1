Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34E7C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 10:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21ED387F3F;
	Tue, 20 Feb 2024 11:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="P+6Krs4H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58ECE87D4D; Tue, 20 Feb 2024 11:42:23 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B6ED87D94
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 11:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1708425726; x=1711017726;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BaWEX4HQjTzvTG1ub794/5rwYiiyKaoO9T1p0V/gGwE=;
 b=P+6Krs4HC8csU8hnPx1hXnOCnvz3VqaaRvUqBuWPM63wceNWjcA86wm66BTYwdn4
 yLVDCiYzYPsp6joOiLBDYBLWg22duhqn/q4COFmlvPXt1otSow+1TSdukyFGrxki
 3LjrX0NJ0attpnHQRNUMDnePeOYlZCF66jGdkaytFGs=;
X-AuditID: ac14000a-fadff7000000290d-8a-65d481fece63
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E5.CF.10509.EF184D56;
 Tue, 20 Feb 2024 11:42:06 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 20 Feb
 2024 11:42:06 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Subject: [PATCH 0/3] Enable IMX_TMU driver for PHYTEC boards
Date: Tue, 20 Feb 2024 11:41:42 +0100
Message-ID: <20240220-thermal-support-v1-0-f6a97d8d6481@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOaB1GUC/x3MSwqAMAwA0atI1hZirYJeRVwUTTTgp6Qqgnh3i
 8u3mHkgkgpFaLMHlC6Jsm8JRZ7BMPttIiNjMli0Dq1Fc8ykq19MPEPY9TAlOa4ZG+ZqgFQFJZb
 7P3b9+35EJN96YQAAAA==
To: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708425726; l=678;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=BaWEX4HQjTzvTG1ub794/5rwYiiyKaoO9T1p0V/gGwE=;
 b=f7JfnKr2iA4S/c/C9thyuaWFV05KPTwRMmAUXqXXc9nu4u9TdxNcmVl9iU1d+vJtb4szOEzUx
 iVFtRU0wNQoBlkZbjTT2v+pfrWxagoG5uSlC+6bY9H0QtMkxEDtmAAn
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWyRpKBR/df45VUg66nmhZTJ21mt3i7t5Pd
 ovudugOzx6sDq9g9zt7ZwejR393CGsAcxWWTkpqTWZZapG+XwJXR+KqNuWAFa8XLOYvYGxjX
 sHQxcnJICJhIbLo1kbGLkYtDSGAxk8SX1edYIZyHjBJdN78zgVSxCahJ7HrzmhXEFhawkTiz
 8D5YnEVAVeLjh6PMIDavgJPEwf4rLBC2oMTJmU+AbA4OZgFNifW79EHCzALyEtvfzmEGmS8h
 sIFR4uzTY0wgNSICrhJP9xhClEdJvJsYBGJKCAhLbNqpBVG9iwlo4j8miHiixM7XciAThQRk
 JW6e38IG8Yq8xLRzr5kh7FCJI5tWM01gFJ6F5J5ZCPfMQnLPAkbmVYxCuZnJ2alFmdl6BRmV
 JanJeimpmxhBQS7CwLWDsW+OxyFGJg7GQ4wSHMxKIrws5VdShXhTEiurUovy44tKc1KLDzFK
 c7AoifOu7ghOFRJITyxJzU5NLUgtgskycXBKNTAW8vDz8h3t79usz3it64PFysnrW75snaok
 nOx08G9N4JTbM6d8et9o+nfGMo88Oce2b2+s+Q92Kn0XvN6valooIhYrqej/daqy0ba4haoM
 2nHxvzYKzbvnO6Ht9t1vCqIzLhk8nf2x7++x9+4vVeZzqep0i68UWR1uKCy67PGV99e/N4Yx
 L0hWYinOSDTUYi4qTgQAHNJMbGACAAA=
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

Enable IMX_TMU driver to prevent the system from booting when it is too
hot.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
Benjamin Hahn (3):
      phycore-imx8mp_defconfig: Enable CONFIG_IMX_TMU
      phycore-imx8mm_defconfig: Enable CONFIG_IMX_TMU
      imx8mm-phygate-tauri-l_defconfig: Enable CONFIG_IMX_TMU

 configs/imx8mm-phygate-tauri-l_defconfig | 1 +
 configs/phycore-imx8mm_defconfig         | 1 +
 configs/phycore-imx8mp_defconfig         | 1 +
 3 files changed, 3 insertions(+)
---
base-commit: 3e6f2a94bfc25f1782ce2d45db27f47ec781feb1
change-id: 20240220-thermal-support-3e4f6f09ff5c

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>

