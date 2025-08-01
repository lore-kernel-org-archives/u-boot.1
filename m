Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B69FC87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 20:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E994E83B1E;
	Fri,  1 Aug 2025 22:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="XSZCyqZK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4588F83B1E; Fri,  1 Aug 2025 22:33:50 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC59483B1E
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 22:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=984e=2O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1754080395; bh=aZ9W4+uqV/KWO9CIEsdxSNFv+MMBkLbDrjg2zW/DJGY=;
 b=XSZCyqZKrIpr7xOgwI8Djkve7rCWRHfz6tQBOxEQWggcy5jwVPxgytRSg9iPOrXjtIzhSyicu
 t6xYk9NGdw+VWfUDYyFzGN8GDl62NxbU7jFGM9gffFmt+hcetreD9ZuW6Tu6INrKM4wsfD3sgMR
 C1mbfTYRTh9A0dGZHSP/iCPQFqzfZKwPbQ05i39Pxr6FUgZsXlkGMNqQATPbNy3v6kbmIwTYbJR
 FoL5NEkWKizeY01qA7cya46Ka8RCwvnbcIlTi5fPnfOR6HHLc6s1PVZ0uyWRw0G0xCt83tTHT+a
 TL31o0E7enmFw9DsfP+iJ5uffrtOrMqMQiFRR3imgKqw==
X-Forward-Email-ID: 688d248a03c11ad4017608ee
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 4/8] rockchip: rk3576: Implement checkboard() to print SoC
 variant
Date: Fri,  1 Aug 2025 20:32:40 +0000
Message-ID: <20250801203255.2590535-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801203255.2590535-1-jonas@kwiboo.se>
References: <20250801203255.2590535-1-jonas@kwiboo.se>
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

Implement checkboard() to print current SoC model used by a board when
U-Boot proper is running.

  U-Boot 2025.04 (Apr 22 2025 - 20:43:17 +0000)

  Model: Generic RK3576
  SoC:   RK3576
  DRAM:  8 GiB

Information about the SoC model and variant is read from OTP.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: No change
---
 arch/arm/mach-rockchip/rk3576/rk3576.c | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
index dc53941ab2f5..a6c2fbdc4840 100644
--- a/arch/arm/mach-rockchip/rk3576/rk3576.c
+++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
@@ -3,6 +3,10 @@
  * Copyright (c) 2024 Rockchip Electronics Co., Ltd
  */
 
+#define LOG_CATEGORY LOGC_ARCH
+
+#include <dm.h>
+#include <misc.h>
 #include <asm/armv8/mmu.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/hardware.h>
@@ -159,3 +163,47 @@ int arch_cpu_init(void)
 
 	return 0;
 }
+
+#define RK3576_OTP_CPU_CODE_OFFSET		0x02
+#define RK3576_OTP_SPECIFICATION_OFFSET		0x08
+
+int checkboard(void)
+{
+	u8 cpu_code[2], specification;
+	struct udevice *dev;
+	char suffix[2];
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
+		return 0;
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(rockchip_otp), &dev);
+	if (ret) {
+		log_debug("Could not find otp device, ret=%d\n", ret);
+		return 0;
+	}
+
+	/* cpu-code: SoC model, e.g. 0x35 0x76 */
+	ret = misc_read(dev, RK3576_OTP_CPU_CODE_OFFSET, cpu_code, 2);
+	if (ret < 0) {
+		log_debug("Could not read cpu-code, ret=%d\n", ret);
+		return 0;
+	}
+
+	/* specification: SoC variant, e.g. 0xA for RK3576J */
+	ret = misc_read(dev, RK3576_OTP_SPECIFICATION_OFFSET, &specification, 1);
+	if (ret < 0) {
+		log_debug("Could not read specification, ret=%d\n", ret);
+		return 0;
+	}
+	specification &= 0x1f;
+
+	/* for RK3576J i.e. '@' + 0xA = 'J' */
+	suffix[0] = specification > 1 ? '@' + specification : '\0';
+	suffix[1] = '\0';
+
+	printf("SoC:   RK%02x%02x%s\n", cpu_code[0], cpu_code[1], suffix);
+
+	return 0;
+}
-- 
2.50.1

