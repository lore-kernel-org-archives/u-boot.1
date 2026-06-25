Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECF1CDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 12:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2D2A846F4;
	Thu, 25 Jun 2026 14:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fbiHDZId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC836848F0; Thu, 25 Jun 2026 14:04:05 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26EEC8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joaomarcos.costa@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id E5B16C5CD50
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 12:04:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7915F5FF03
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 12:04:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B4CD7106F086D; 
 Thu, 25 Jun 2026 14:03:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782389035; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=iYh3m4FDBphnZz5vHbLD7MO6L8m3zIUSvIlzXYUgwgw=;
 b=fbiHDZIdiqa0VhzjMYzekJbBiku5Y9Y3M2+O7neFFJzVJ6Jt9WInKTvq2XdusLZpol0YAt
 /2GO+5ZUcqmEgrpIaCAKCJ4PTgD7UVLPDn53YvOlpEMc66czq81ZMgeZ4FUu7rDQX35nwg
 cigzYLxC9SmCwNgPgkKM+fnI2q6+LixBEBW+ayBZ0QIQwSxi56M4vGzJEw4JMm+c3gyahB
 kurGPRRkkZURUtfUoeyWPmuNeLn5c3NsPH8M7RGVbVBYaIcFiw84k6joGzrvji53nuGLeR
 PLBfdHZ44sPLkKF9v/EPMWkIJxfZe2knLyPh6RoVGvvpHhqH+9DYSrsFfXlPXg==
From: =?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>
To: u-boot@lists.denx.de
Cc: thomas.petazzoni@bootlin.com,
 =?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>
Subject: [PATCH] .mailmap: map old addresses to their up-to-date counterparts
Date: Thu, 25 Jun 2026 14:03:44 +0200
Message-ID: <20260625120344.274592-1-joaomarcos.costa@bootlin.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

This essentially maps @free-electrons.com to @bootlin.com addresses.

Signed-off-by: João Marcos Costa <joaomarcos.costa@bootlin.com>
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index 7aef23fd7cf..90ebf04be98 100644
--- a/.mailmap
+++ b/.mailmap
@@ -48,6 +48,7 @@ Eugen Hristev <ehristev@kernel.org> <eugen.hristev@linaro.org>
 Eugen Hristev <ehristev@kernel.org> <eugen.hristev@collabora.com>
 Fabio Estevam <fabio.estevam@nxp.com>
 Greg Malysa <malysagreg@gmail.com> <greg.malysa@timesys.com>
+Gregory CLEMENT <gregory.clement@bootlin.com> <gregory.clement@free-electrons.com>
 Harini Katakam <harini.katakam@amd.com> <harini.katakam@xilinx.com>
 Harsha <harsha.harsha@amd.com> <harsha.harsha@xilinx.com>
 Heiko Stuebner <heiko.stuebner@cherry.de> <heiko.stuebner@theobroma-systems.com>
@@ -95,6 +96,7 @@ Michal Simek <michal.simek@amd.com> <Monstr@seznam.cz>
 Michal Simek <michal.simek@amd.com> <michal.simek@xilinx.com>
 Michal Simek <michal.simek@amd.com> <monstr@monstr.eu>
 Michal Simek <michal.simek@amd.com> <root@monstr.eu>
+Miquel Raynal <miquel.raynal@bootlin.com> <miquel.raynal@free-electrons.com>
 Mirza <Taimoor_Mirza@mentor.com>
 Mounika Grace Akula <mounika.akula@amd.com> <mounika.grace.akula@xilinx.com>
 Mubin Usman Sayyed <mubin.sayyed@amd.com> <mubin.usman.sayyed@xilinx.com>
@@ -149,6 +151,7 @@ Sughosh Ganu <sughosh.ganu@arm.com> <sughosh.ganu@linaro.org>
 No generic patch CC mail please <noreply@example.com> <swarren@wwwdotorg.org>
 No generic patch CC mail please <noreply@example.com> <swarren@nvidia.com>
 Sumit Garg <sumit.garg@kernel.org> <sumit.garg@linaro.org>
+Thomas Petazzoni <thomas.petazzoni@bootlin.com> <thomas.petazzoni@free-electrons.com>
 Tom Rini <trini@konsulko.com> <trini@ti.com>
 Tomas Thoresen <tomas.thoresen@amd.com> <tomast@xilinx.com>
 TsiChung Liew <Tsi-Chung.Liew@freescale.com>
-- 
2.47.0

