Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E20CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 08:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 761EA84C54;
	Fri,  8 May 2026 10:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="MjP+56+S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B85C84C3B; Fri,  8 May 2026 10:48:55 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 828F084C50
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 10:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=hxDjW+qVyofIUA2ER04VOap2j1uczTKFgX48CTqBMac=; b=MjP+56+SSkNmD84hTkDNuwl80r
 DDJu3Vip9KbtgFXunFAmHVHNJ27wZdScS7nOgKe9rg0bFzFW+/KcGjrB5teZRU2lnfwTl5vqLFDzz
 UatpwI6qbaCF7YckbsqIKLXf6nWAcRW8LGwKsgYGiV0s8tvJ903hUVA39vsKqm6r+/Y1MFV1v7Wo6
 Ev4GTC6GFmOphrDMiJT/YhS5Rlpn2chKLql0gWWksxvaGzkeqA0gYhNQKnjtDsXA2KWo+0RPxGPLI
 cgjHjVvN9tcJvGmXxGk7AcZAmLTc3r1XbPHdF6N5JLh3/fXQnVkoBVWKMQhXp8cRsLs/uEZwzo6BK
 f0OnGk2w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGtA-0009b1-2A; Fri, 08 May 2026 10:48:52 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGt9-000KsG-2f; Fri, 08 May 2026 10:48:52 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/6] boards: tqma7: integrate sysinfo_tq_eeprom driver
Date: Fri,  8 May 2026 10:48:34 +0200
Message-Id: <20260508084834.45637-7-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
References: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Probe the TQ-Eeprom sysinfo driver during boot to print its contents.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 arch/arm/dts/imx7s-tqma7-u-boot.dtsi | 7 +++++++
 board/tq/tqma7/tqma7.c               | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/dts/imx7s-tqma7-u-boot.dtsi b/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
index 2d1d614cd57..55b9556cb55 100644
--- a/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
+++ b/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
@@ -9,6 +9,13 @@
 
 #include "imx7s-u-boot.dtsi"
 
+/ {
+	sysinfo_mba7: sysinfo {
+		compatible = "tq,eeprom-sysinfo";
+		i2c-eeprom = <&m24c64>;
+	};
+};
+
 &soc {
 	bootph-pre-ram;
 };
diff --git a/board/tq/tqma7/tqma7.c b/board/tq/tqma7/tqma7.c
index 30bd155713d..7542a081ea0 100644
--- a/board/tq/tqma7/tqma7.c
+++ b/board/tq/tqma7/tqma7.c
@@ -14,9 +14,11 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/sys_proto.h>
+#include <dm/uclass.h>
 
 #include "../common/tq_bb.h"
 #include "../common/tq_som.h"
+#include "../common/tq_sysinfo.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -65,6 +67,8 @@ int board_late_init(void)
 
 	env_set_runtime("board_name", bname);
 
+	tq_common_sysinfo_setup();
+
 	return tq_bb_board_late_init();
 }
 
-- 
2.34.1

