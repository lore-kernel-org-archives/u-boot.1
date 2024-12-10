Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0E7E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 22:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBDF780214;
	Tue, 10 Dec 2024 23:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="s1lj3IzK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DA3880202; Tue, 10 Dec 2024 23:24:00 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E896B80209
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 23:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=db8b=TE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1733869434; bh=GHWXzUs7irxv4DDE+jwSdQAep7WzLAHlDnIYoiiLiMc=;
 b=s1lj3IzKlTKuzi+jV0MKlX1ROeCUHUaS5lVD+IHgU61+YIEo1vngwdDuPTufoq496ohPGL3T5
 bq2azwNSA7iu30xa5YBcRqj7DPL2o48bpmogD8kR97mufvM3XOhNMOcynG2xuGhXVv7YrrAj7hC
 yEwHAxjhhY0y9ffxWb5GUzyaq+Gwlh0hyfJGSMv82osSO9Idik3mwMqPgNvZo1DW854EBYFO07B
 HDnI9TYCR/1Z1zTy0AFEIfzE8e0wdekRdbKe/cDjusv6agnR3eZGy62ljJnQ1au8E7qRlhJQ8mL
 FAjg5xtN1gs8Z38lTPxckKoV0TwXhBGRXf0EDYh35v8g==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] rockchip: Add initial RK3582 support
Date: Tue, 10 Dec 2024 22:23:35 +0000
Message-ID: <20241210222341.3537543-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210222341.3537543-1-jonas@kwiboo.se>
References: <20241210222341.3537543-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6758bf79b234f44256187cb5
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

The RK3582 SoC is a variant of the RK3588S with some IP blocks disabled.
What blocks are disabled/non-working is indicated by ip-state in OTP.

This add initial support for RK3582 by using ft_system_setup() to mark
any cpu and/or gpu node with status=fail as indicated by ip-state.

This apply same policy as vendor U-Boot for RK3582, i.e. two big cpu
cores and the gpu is always failed/disabled.

Enable Kconfig option OF_SYSTEM_SETUP in board defconfig to make use of
the required DT fixups for RK3582 board variants.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3588/rk3588.c | 128 +++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index c1dce3ee3703..06e6318312b2 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -7,6 +7,7 @@
 #define LOG_CATEGORY LOGC_ARCH
 
 #include <dm.h>
+#include <fdt_support.h>
 #include <misc.h>
 #include <spl.h>
 #include <asm/armv8/mmu.h>
@@ -185,6 +186,12 @@ int arch_cpu_init(void)
 
 #define RK3588_OTP_CPU_CODE_OFFSET		0x02
 #define RK3588_OTP_SPECIFICATION_OFFSET		0x06
+#define RK3588_OTP_IP_STATE_OFFSET		0x1d
+
+#define BAD_CPU_CLUSTER0		GENMASK(3, 0)
+#define BAD_CPU_CLUSTER1		GENMASK(5, 4)
+#define BAD_CPU_CLUSTER2		GENMASK(7, 6)
+#define BAD_GPU				GENMASK(4, 1)
 
 int checkboard(void)
 {
@@ -230,3 +237,124 @@ int checkboard(void)
 
 	return 0;
 }
+
+#ifdef CONFIG_OF_SYSTEM_SETUP
+static int fdt_path_del_node(void *fdt, const char *path)
+{
+	int nodeoffset;
+
+	nodeoffset = fdt_path_offset(fdt, path);
+	if (nodeoffset < 0)
+		return nodeoffset;
+
+	return fdt_del_node(fdt, nodeoffset);
+}
+
+static int fdt_path_set_name(void *fdt, const char *path, const char *name)
+{
+	int nodeoffset;
+
+	nodeoffset = fdt_path_offset(fdt, path);
+	if (nodeoffset < 0)
+		return nodeoffset;
+
+	return fdt_set_name(fdt, nodeoffset, name);
+}
+
+int ft_system_setup(void *blob, struct bd_info *bd)
+{
+	static const char * const cpu_node_names[] = {
+		"cpu@0", "cpu@100", "cpu@200", "cpu@300",
+		"cpu@400", "cpu@500", "cpu@600", "cpu@700",
+	};
+	u8 cpu_code[2], ip_state[3];
+	int parent, node, i, ret;
+	struct udevice *dev;
+
+	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
+		return -ENOSYS;
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(rockchip_otp), &dev);
+	if (ret) {
+		log_debug("Could not find otp device, ret=%d\n", ret);
+		return ret;
+	}
+
+	/* cpu-code: SoC model, e.g. 0x35 0x82 or 0x35 0x88 */
+	ret = misc_read(dev, RK3588_OTP_CPU_CODE_OFFSET, cpu_code, 2);
+	if (ret < 0) {
+		log_debug("Could not read cpu-code, ret=%d\n", ret);
+		return ret;
+	}
+
+	log_debug("cpu-code: %02x %02x\n", cpu_code[0], cpu_code[1]);
+
+	/* skip on rk3588 */
+	if (cpu_code[0] == 0x35 && cpu_code[1] == 0x88)
+		return 0;
+
+	ret = misc_read(dev, RK3588_OTP_IP_STATE_OFFSET, &ip_state, 3);
+	if (ret < 0) {
+		log_debug("Could not read ip-state, ret=%d\n", ret);
+		return ret;
+	}
+
+	log_debug("ip-state: %02x %02x %02x\n",
+		  ip_state[0], ip_state[1], ip_state[2]);
+
+	if (cpu_code[0] == 0x35 && cpu_code[1] == 0x82) {
+		/* policy: always disable gpu */
+		ip_state[1] |= BAD_GPU;
+
+		/* policy: always disable one big core cluster */
+		if (!(ip_state[0] & (BAD_CPU_CLUSTER1 | BAD_CPU_CLUSTER2)))
+			ip_state[0] |= BAD_CPU_CLUSTER2;
+	}
+
+	if (ip_state[0] & BAD_CPU_CLUSTER1) {
+		/* fail entire cluster when one or more core is bad */
+		ip_state[0] |= BAD_CPU_CLUSTER1;
+		fdt_path_del_node(blob, "/cpus/cpu-map/cluster1");
+	}
+
+	if (ip_state[0] & BAD_CPU_CLUSTER2) {
+		/* fail entire cluster when one or more core is bad */
+		ip_state[0] |= BAD_CPU_CLUSTER2;
+		fdt_path_del_node(blob, "/cpus/cpu-map/cluster2");
+	} else if (ip_state[0] & BAD_CPU_CLUSTER1) {
+		/* cluster nodes must be named in a continuous series */
+		fdt_path_set_name(blob, "/cpus/cpu-map/cluster2", "cluster1");
+	}
+
+	/* gpu: ip_state[1]: bit1~4 */
+	if (ip_state[1] & BAD_GPU) {
+		log_debug("fail gpu\n");
+		fdt_status_fail_by_pathf(blob, "/gpu@fb000000");
+	}
+
+	parent = fdt_path_offset(blob, "/cpus");
+	if (parent < 0) {
+		log_debug("Could not find /cpus, parent=%d\n", parent);
+		return 0;
+	}
+
+	/* cpu: ip_state[0]: bit0~7 */
+	for (i = 0; i < 8; i++) {
+		/* fail any bad cpu core */
+		if (!(ip_state[0] & BIT(i)))
+			continue;
+
+		node = fdt_subnode_offset(blob, parent, cpu_node_names[i]);
+		if (node >= 0) {
+			log_debug("fail cpu %s\n", cpu_node_names[i]);
+			fdt_status_fail(blob, node);
+		} else {
+			log_debug("Could not find %s, node=%d\n",
+				  cpu_node_names[i], node);
+		}
+	}
+
+	return 0;
+}
+#endif
-- 
2.47.1

