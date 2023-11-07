Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46924C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 23:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B72C98763E;
	Wed,  8 Nov 2023 00:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RmSOl4VN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD2DA87446; Wed,  8 Nov 2023 00:21:55 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 964C48763E
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 00:21:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A7NLgFG058680;
 Tue, 7 Nov 2023 17:21:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699399302;
 bh=Ahh1Tw3hBc9usEK/kjbTMMyepHTugyLVEVuuIpQCJTo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RmSOl4VNmiMkoBa10M7QsfuMAeUqDGsze+zz5azGyhtYICZ04idKCNcmh7pxlDaPI
 KXEtDeFsun+CbKY4To+51NtmRR72VomSqEg4/Dc/pR1B/Tfn0VuObyCOtHV9WcEobJ
 TYedn/w+pQSHE6gtmO6bf1kAKkx1WDBBB5fWrG7Q=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A7NLg8X003605
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Nov 2023 17:21:42 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Nov 2023 17:21:42 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Nov 2023 17:21:42 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A7NLfnL020671;
 Tue, 7 Nov 2023 17:21:41 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Andrew Davis <afd@ti.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 2/3] configs: am62ax: setup the 32k RTC crystal
Date: Tue, 7 Nov 2023 17:21:42 -0600
Message-ID: <20231107232139.2839534-7-bb@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232139.2839534-5-bb@ti.com>
References: <20231107232139.2839534-5-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=bb@ti.com;
 h=from:subject; bh=o2y/VsbvL8lRpowqbdrnGifJSAQ9BOjqwB62JfzF924=;
 b=owNCWmg5MUFZJlNZzBjbAgAAYf////b73v9+fEO2W/v/9v9HX8/7/+50+v9776u979nT/v6wA
 RsWEPUADRoNDTQAAANDJppo0GhoAADIAAwhkGQADQBoAA9QAA0GjJtTyajyhlADQDQAaDQAA0NG
 mgaAAAAAAeoaGjQ0ZGg9QPUGT9UABtQGgA0abU9QNMjTRD1D0mgyaADIBoAeo0ZMjQaNAAAABoB
 jUaNBkMI00MIAaAADRoAANGjTTTICCE5iqK0EmwXKYFug0grHiU3tvODs4gLAMPPDqyb+towiFB
 xVmp4gRJFfyjA5siW9OYw6w9NSllL9NSBNxsB0SPuyD0QS56NIf2M/9VAR7Y2FjXUfXDSYSBR3q
 QCsZAZgqaTYaLKC+M0DhMjLGWi7GlJcO52koIJnc27O5Va04rPGyzabnDpwfcUVZrUJoRBABlUO
 0FGn1gnuHmILJKl+p4kXTpy/Wt9UwpHiqcvYeJFu6yoBK7jcSXdQ+6wZft6IJUwWMg49VtS3GMX
 TWINYYQsArIs5vfJfzPmWpn4J571bKpfMAHiMskD4zE2R9l2HHJKEz9quMp5MEj2eBYusI9bTK1
 ofwk6qVT8oeYMDZ1CQioCwHhDq9WGF3m6Q6sXdylQMAtFCwRp2f+iTQPsaLGJlCJRccXkUEKAD9
 /Af4arNq144/+LuSKcKEhmDG2BA
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The am62ax utilizes the same 32k crystal for a more accurate RTC clock
source. Enable the configuration to set this up for Linux.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/am62ax/evm.c            | 5 +++++
 configs/am62ax_evm_a53_defconfig | 1 +
 2 files changed, 6 insertions(+)

diff --git a/board/ti/am62ax/evm.c b/board/ti/am62ax/evm.c
index f2dd3b4192ee0..6e031784766c4 100644
--- a/board/ti/am62ax/evm.c
+++ b/board/ti/am62ax/evm.c
@@ -14,8 +14,13 @@
 #include <fdt_support.h>
 #include <spl.h>
 
+#include "../common/rtc.c"
+
 int board_init(void)
 {
+	if (IS_ENABLED(CONFIG_BOARD_HAS_32K_RTC_CRYSTAL))
+		board_rtc_init();
+
 	return 0;
 }
 
diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
index d0a34c75505d2..e9e969c842d7d 100644
--- a/configs/am62ax_evm_a53_defconfig
+++ b/configs/am62ax_evm_a53_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_BOARD_HAS_32K_RTC_CRYSTAL=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
-- 
2.42.0

