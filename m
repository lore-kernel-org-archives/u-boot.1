Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B4FC369D9
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 11:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0BD4820EB;
	Sat,  3 May 2025 13:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85DFE8210D; Sat,  3 May 2025 13:53:16 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A6081F7B
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 13:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c0:20f3:a400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 805A2B4C1BC1;
 Sat,  3 May 2025 13:53:12 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>,
	u-boot@lists.denx.de
Subject: [PATCH] riscv: starfive: jh7110: move uart0 clock frequency to config
 header
Date: Sat,  3 May 2025 04:52:52 -0700
Message-ID: <20250503115301.972550-1-e@freeshell.de>
X-Mailer: git-send-email 2.49.0
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

Move unnecessary clock frequency assignment out of device-tree and into the
board config header so that the ns16550 serial driver can successfully init
during SPL after failing to resolve the parent clock from upstream dts. The
serial driver will then resolve clock frequency from device-tree node parent
clock at init during Main app as it is expected by upstream.

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/dts/jh7110-common-u-boot.dtsi | 1 -
 include/configs/starfive-visionfive2.h   | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh7110-common-u-boot.dtsi
index 6d85b2d91a7..049b0a7ce28 100644
--- a/arch/riscv/dts/jh7110-common-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
@@ -27,7 +27,6 @@
 	bootph-pre-ram;
 	reg-offset = <0>;
 	current-speed = <115200>;
-	clock-frequency = <24000000>;
 };
 
 &mmc0 {
diff --git a/include/configs/starfive-visionfive2.h b/include/configs/starfive-visionfive2.h
index 049b0a06301..e7001b26abf 100644
--- a/include/configs/starfive-visionfive2.h
+++ b/include/configs/starfive-visionfive2.h
@@ -39,4 +39,6 @@
 	"partitions=" PARTS_DEFAULT "\0" \
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"
 
+#define CFG_SYS_NS16550_CLK		24000000
+
 #endif /* _STARFIVE_VISIONFIVE2_H */

base-commit: 6cc812f8cc55c132458c7da5b9fb7666315cbe8c
-- 
2.49.0

