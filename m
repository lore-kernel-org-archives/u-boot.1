Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E84C531DC
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 15:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72EA088D8E;
	Tue, 20 Aug 2024 17:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724166881;
	bh=WkPEcjbDH8WkGy+3SUlxEEHM10DtsnbQ/OnD/IaMAPk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=epneZer0/aZBPIbvbJLy+xduDdYxereCtHOwu6JdQxQ0c8m1Z8T82MKGYT0CckfFP
	 DU0ebeHlYVs3JxaNr1OhLkRrLXyv3bo3uTGQhJd4FzSzC51DaMUxxKzyA8NMejZo96
	 65wUWhr//UBVvMZ8XvEpADv58iWc01p9B9R52lbsL4dXYv2vfCprTblDackQNnniF1
	 PgXXn4oZgBKwwVll4uwuhXUmQKh/7n/KvG423EzWfYon9f0ZEfngWCYXkcJe/d38Sl
	 Lwa/VGAThog06Mpkt5mj1C2nfgxk5IpAOqzFJdx7DCEPIXXlqz3zTEyD8nNjH+eTeg
	 vwHkTGuDWwHvA==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 78A5488A2D;
 Tue, 20 Aug 2024 17:14:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724166880;
 bh=WkPEcjbDH8WkGy+3SUlxEEHM10DtsnbQ/OnD/IaMAPk=;
 h=From:To:Cc:Subject:Date:From;
 b=r4ZQ79NCjqzmvir7B9qdR+kfBOf3bNB4M6Y1PqoWTPbGv+HRztVGpKkw4UmN6BOI0
 aSqBjvHNhdXpk87MorjPxF5GjgoPStgp4Y83oqgji7Kw6qfjgOQtQJCpwVKnI1fy2C
 nq7JLXis12v3PGurPDOu1j4h52TRMCQ1MXtIw1bnP8oAUTwsHfSPUTV6QFBy0Osj1a
 YtsamHE82SGffFBqS+kj/kLz4FETk8vjboICG/OTEVvRx9b2B3vKaS3f49d85a9hf6
 d6dIBgoZAxSWx3mpSRC28ifHK6cobliqUcNvGTxeWUUE7gdyhT1E/lPGGL2JK0POwd
 d+qPQoox8bMoQ==
From: Lukasz Majewski <lukma@denx.de>
To: Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com, Cem Tenruh <c.tenruh@phytec.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Yannic Moog <y.moog@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>,
 Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2] dts: imx: Enable USB support in
 imx8mm-phyboard-polis-rdk-u-boot.dtsi
Date: Tue, 20 Aug 2024 17:14:20 +0200
Message-Id: <20240820151420.3055221-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
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

The Phytec's imx8mm-phyboard-polis-rdk-u-boot.dtsi u-boot specific file
can be extended to support SDP gadget operation in SPL.

It is especially useful when one wants to flash the module via USB with
uuu program (USB ROM booting enabled).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- Write new entries in alphabetical order
---
 arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
index 516e52e1f5..3dce6e1820 100644
--- a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
@@ -58,6 +58,18 @@
 	bootph-pre-ram;
 };
 
+&usbmisc1 {
+	bootph-pre-ram;
+};
+
+&usbotg1 {
+	bootph-pre-ram;
+};
+
+&usbphynop1 {
+	bootph-pre-ram;
+};
+
 &usdhc2 {
 	bootph-pre-ram;
 };
-- 
2.39.2

