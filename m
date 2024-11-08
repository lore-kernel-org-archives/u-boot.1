Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C67D5E130
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 05:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA5DD890AD;
	Fri,  8 Nov 2024 06:22:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731043324;
	bh=jJ9GYPqxF73aapWoFUBqMqm5s0zjZoAqE8Mt/nyY9fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QefY3v9NYhqfZWP9+8YH1uU0M1EGjQ/TtO6u+0MoW0Hrule1P7ll2qXm6voo9NCEB
	 WUFlgPFhnZ0xYbjvZmv1tOyYvKuJBP3K2C6uz5AfSvbbmX8VFLLeIUGZuTr9JsMbBX
	 9jWVFs09HqE9kZAD5BcHdun/auyhAWqDrADK8VDzgQhndkmL2u1Qdzugq0EZcADqNB
	 aJTW4arh0TTbZ1S7K4SB5aTJ3tgaJ/fPRzY92BzkLE2uXbjEJzwluRtxHH6rXle5sK
	 5a3UflS3JEKvpd5diFSF4r5ATqajJ4F3rKMB40M6cVibYQ/KMWk9VSQWn0SLL1T8nz
	 S5tDCwJw3i/fw==
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu
 [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AF28E88EEA;
 Fri,  8 Nov 2024 06:22:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731043321;
 bh=jJ9GYPqxF73aapWoFUBqMqm5s0zjZoAqE8Mt/nyY9fE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xC7HrLCeoneaVnrDDgiNHZsURTDyaa7oXNQZ3wa3Js6xM35TY8pYsuKfls7iJA4P4
 W+786qVDfcif2dBLNsglMgdiv6NID/dQ52qx032rjb5iacVMKINGoLfRGYexXHer0e
 KqF2FJG/WRlgR69I4hWQS6MvzQBqUrihqMTZdf8k4F7yZ4bTihxrGRP+u6qO40OHpC
 LqM9T3OxH+kF84vrXrQuKeVmMeFz3rlJVxiVCh3NSoiCFJUxoShhTUNryRztSQZvBo
 1k7E951/eF2BzW3scYstqs3xXdDhxd7PtD4QulWuQkiLWsCGfzllO0qh+4DhzfD8dk
 GLPapcgB6RMMA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 11/22] siemens: imx8-capricorn-u-boot.dtsi: add fec2
Date: Fri,  8 Nov 2024 06:21:32 +0100
Message-Id: <20241108052143.26874-12-hs@denx.de>
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

we use also fec2, so add it.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 arch/arm/dts/imx8-capricorn-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/imx8-capricorn-u-boot.dtsi b/arch/arm/dts/imx8-capricorn-u-boot.dtsi
index a1058a09a9a..365cd51ed2f 100644
--- a/arch/arm/dts/imx8-capricorn-u-boot.dtsi
+++ b/arch/arm/dts/imx8-capricorn-u-boot.dtsi
@@ -13,6 +13,10 @@
 	bootph-all;
 };
 
+&fec2 {
+	bootph-all;
+};
+
 &clk {
 	bootph-all;
 };
-- 
2.20.1

