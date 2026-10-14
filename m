Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF789CC6B2A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A7FD80E25;
	Wed, 14 Oct 2026 14:17:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9FPSRf5Lhv31; Wed, 14 Oct 2026 14:17:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 748B180E15
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791987463;
	b=b7mbM+SdE0oWTcieMyh4epefkrtr8oNZp4gViVEWUFKxZqwnQOiUdR85ux245S3mAO0V
	 tS/MgHCX1rkYQ8gte73iC90XCKIs6F0fZWcyESMaCiqE2WrLVjdaO1TrqVYxm65COmw9V
	 4CR6eeUJRJPnJksmXjuPouURPtDXI/QgfWuRDHb7bLWPe0AA4+IkrlfJ4H/m4bTVeWpJW
	 xVyIhMfhg35UrXfE1QW7Cg6xE38fXlHmWMvZaSpEduH5PJA8qmCn86cQ+7+h6RA9EVrRv
	 b0w4Ff5/dZGe971p7DJCNvrbiD/7B8cuqZ8OVqeV902Squ4Drg1+fcXp3nVHDHf0gEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791987463;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ItZWJyqP6ad7l90as3QnMv1pYXIaUSqvVVSNpiWZO9c=;
	b=kIxFVhfzyKXX57F9RQRnMRVYMAhP+IYEuXnHyCo3gkTa9vniav9AaWN3dqelvVo7hTxc
	 zLSYI0LMsa9fiehldhqXU0y1Nlj+V2PH4PxDlDaft9mJf328haZ/a2nVjr6SYgKAt8s2T
	 yZw91oXa4QXeIbazyH3gjyRA0kkd1UbT3HUqPmj2VWcUXagYy1nbybESpX5KoMygWGMWj
	 uvvPH+vvaGrh4CyE6B1PC9fncneVJN0ct5a4jEL1FLHcQkSaBenJIcabNqP9E8v+JtE+5
	 xDaG1PBRvJO7XXs/w1tREcbMNu2ny3Rez6PncD+00XtvtmlMwwDQTiOM3uxCB5zYEFQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791987463;
	bh=ItZWJyqP6ad7l90as3QnMv1pYXIaUSqvVVSNpiWZO9c=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pu7icbpzChZYkIinOXm5hqhgLBSdcQ+CWpVlXdFgu9h7gvkXG9SrYLdoFu5+48VMj
	 GFlo4QykhHPDpSa/7JrFoMcW+EYeaPl6HhT7WwLVWecC+X2j1V/TAX9sCp1j4O75Ww
	 m/1dnI636h8q6D9DaCbzpMK8b8ouA24FijRv7SBlLh6s3afz1YQC/fblYtmOTrMMXk
	 iZw+XEbOPA/pAjP5MCDXQwD9sXqM04ioLynLcRdGGMrjXhvfqpO2qUAHAGbb+FT37w
	 BSYeV3wWNtmqJl8IIYm3fI/Zpis3Oa4LMjCKvlfN5bfGP/a2hv5TF5HO06m72oI3ez
	 itoT2SCpC16jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 748B180E15;
	Wed, 14 Oct 2026 14:17:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 269BB2A8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0CD96606C7
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7w0bn9RQsRsd for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:17:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A85C060818
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791987458;
 b=L355sPlMFJbt0trUqSpu9fiL/rIXtVyhS3UZhoXIF2VNum9MOKO7oRmqAtrgvi2HyH5C
 WTvJ4uoX3F/eMTUEEBjR/elzeTGVAPW3151IBVVHgQWBTzvv7GXOQ1uNRErTF4sMFRWMi
 N5fwCd5KWK0SR3SuabiLEUVXjbaPwf6IYiWtBPR0xh3VeGne6nfWaX8qCqDBDVJMtlflU
 wgCIwaU14CBEon5AjrOCKIbN8TWc8j1FUPKC9sf7BdUuyMq6/ZvX9GdOyhXpyp7+aDttd
 sCa2F89bhUuuk6gArJS4IUS55TUCfi9b5ASywaYQ3z7r2fLiV60MihqrpzRAmDiVMrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791987458;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
 bh=ItZWJyqP6ad7l90as3QnMv1pYXIaUSqvVVSNpiWZO9c=;
 b=e+bWb5CK2GvyUmVgpFSm6FbDrwIYe6Hhww935sicz4h+PB16mas7+v6sV+nZ0P9LqTAg
 9fObpM1ThGqfYQMY+8uHyjI5JzUbyaFXx+LOogtlMwIMFGmbe7moKcoSo+1hfTpHCV3GQ
 sX21WTR0SpyDCfzkYlMeU3z545DSQl6hl97yTeRVZnw/siZF/MmR/FHiV09v64vFh2J+Y
 fnMAq7tXghg+rYyM4UeJrMRsdOuXC6dyPd95nMx2MV9GdbSQyqumO/n/77YMCS1xDwFCT
 2W9+1YZ20fggLVh/RooU+v8cB9DXNwi4D7KAzR5NijvBa6MwZPdTibpIP4jFhT4L5Cg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=microchip.com;
 dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256
 header.s=mchp header.b=BNriUaMh; 
 arc=none smtp.remote-ip=68.232.154.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7405916af=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=BNriUaMh
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A85C060818
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1791987458; x=1823523458;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=R76OCC/Uc0ILV/xfpquV8cChm7Oic+b9OJaspj0sg6U=;
 b=BNriUaMh/V0F/v3/PM0UGrPy/MfYqJnYDlgb0x5BgUa06PxVO/7I1jQw
 SqEPug7ugbeFfQxGxNgx/cfSgoEsoP2feRWRIRWmqkkkSQvdxCyo8oxNi
 ygj3EviyDWhHKRlVddIo9rYeM3ujhNqa+Y205WB1Xf2v2RzBYbYOe4pI/
 My2mIK/KX6Ky6oXqCvL2o9T5Ko5zvNh/VQI6KPeT2PDq8DpWiU3FKtYwz
 54bqV9iBKXNijS2KDijqPMEefE9nm7Gu/zEimsiL9PWwcBLNNiGaFZ+ua
 TMjyiF7My/peotJTG/wMB7/JLLedv7+OR1gwvA+dS7vZ+T6UNv+c6hb5/ Q==;
X-CSE-ConnectionGUID: JpO8xqARQFq/v9weWGmUhw==
X-CSE-MsgGUID: zTWHWHQRRrSX+ojpQiIQtQ==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; d="scan'208";a="64088548"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Oct 2026 07:17:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 14 Oct 2026 07:17:31 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 07:17:28 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Wed, 14 Oct 2026 10:17:08 -0400
Subject: [PATCH v4 4/8] drivers: clk: add support for RPMI clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261014-rpmi_v4-v4-4-d53d34a49780@microchip.com>
References: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
In-Reply-To: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
To: <u-boot@lists.u-boot-project.org>, Yao Zi <me@ziyao.cc>
CC: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey
 <romain.caritey@microchip.com>, Mame Maria Mbaye
 <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, Michal Simek
 <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>, Yao Zi
 <me@ziyao.cc>, Peng Fan <peng.fan@oss.nxp.com>, Subrahmanya Lingappa
 <subrahmanya.lingappa@oss.qualcomm.com>, Charles Perry
 <charles.perry@microchip.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The RISC-V Platform Management Interface (RPMI) defines a service group
for control and monitoring of clocks [1]. This can be exposed as a
UCLASS_CLK driver.

[1]: https://github.com/riscv-non-isa/riscv-rpmi (chapter 4.8)

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
Changes in v4: None
Changes in v3: None

Changes in v2: (from Yao Zi review)
 - Reorder headers
 - Don't null check pointers before free()
 - Remove transition_latency from struct rpmi_clk_def as its unused
 - Simplify last return path of _rpmi_clk_enable_disable()
 - Move the call to _rpmi_clk_get_rate() from _rpmi_clk_set_rate() to
   rpmi_clk_set_rate()
---
 MAINTAINERS            |   1 +
 drivers/clk/Kconfig    |   7 +
 drivers/clk/Makefile   |   1 +
 drivers/clk/clk_rpmi.c | 344 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/rpmi_proto.h   |  39 ++++++
 5 files changed, 392 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b3c2376bb93..cf45df9a027a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1561,6 +1561,7 @@ F:	doc/README.rockusb
 RPMI
 M:	Charles Perry <charles.perry@microchip.com>
 S:	Maintained
+F:	drivers/clk/clk_rpmi.c
 F:	drivers/firmware/rpmi/
 F:	include/rpmi*
 
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 3f39b36949a6..4d3f5005d2e8 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -188,6 +188,13 @@ config CLK_OCTEON
 	help
 	  Enable this to support the clocks on Octeon MIPS platforms.
 
+config CLK_RPMI
+	bool "Enable RPMI clock driver"
+	depends on CLK && RPMI_FIRMWARE
+	help
+	  Enable this option if you want to support clock devices exposed
+	  by RISC-V Platform Management Interface (RPMI).
+
 config SANDBOX_CLK_CCF
 	bool "Sandbox Common Clock Framework [CCF] support"
 	depends on SANDBOX
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 4b241a9240ac..9e19e6f6d845 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_CLK_OWL) += owl/
 obj-$(CONFIG_CLK_QCOM) += qcom/
 obj-$(CONFIG_CLK_RENESAS) += renesas/
 obj-$(CONFIG_$(PHASE_)CLK_RS9_PCIE) += clk-renesas-pcie.o
+obj-$(CONFIG_CLK_RPMI) += clk_rpmi.o
 obj-$(CONFIG_$(PHASE_)CLK_SCMI) += clk_scmi.o
 obj-$(CONFIG_CLK_SIFIVE) += sifive/
 obj-$(CONFIG_CLK_SOPHGO) += sophgo/
diff --git a/drivers/clk/clk_rpmi.c b/drivers/clk/clk_rpmi.c
new file mode 100644
index 000000000000..42b1616ee7ec
--- /dev/null
+++ b/drivers/clk/clk_rpmi.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ */
+
+#define LOG_CATEGORY UCLASS_CLK
+
+#include <asm/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <linux/clk-provider.h>
+#include <rpmi.h>
+
+struct rpmi_get_num_clocks_rx {
+	__le32 status;
+	__le32 num_clocks;
+};
+
+struct rpmi_get_rate_rx {
+	__le32 status;
+	__le32 lo;
+	__le32 hi;
+};
+
+struct rpmi_get_config_rx {
+	__le32 status;
+	__le32 state;
+};
+
+struct rpmi_set_rate_tx {
+	__le32 clkid;
+	__le32 flags;
+	__le32 lo;
+	__le32 hi;
+};
+
+struct rpmi_set_config_tx {
+	__le32 clkid;
+	__le32 config;
+};
+
+struct rpmi_get_attrs_rx {
+	__le32 status;
+#define RPMI_CLK_TYPE_MASK GENMASK(1, 0)
+	__le32 flags;
+	__le32 num_rates;
+	__le32 transition_latency;
+	char name[RPMI_CLK_NAME_LEN];
+};
+
+struct rpmi_clk_def {
+	u32 num_rates;
+	enum rpmi_clock_type type;
+	char name[RPMI_CLK_NAME_LEN + 1];
+};
+
+struct rpmi_clk_priv {
+	struct rpmi_chan chan;
+	u32 num_clocks;
+	struct rpmi_clk_def *defs;
+};
+
+static int _rpmi_clk_enable_disable(struct rpmi_clk_priv *priv, u32 clkid,
+				    bool ena)
+{
+	struct rpmi_set_config_tx tx = {
+		.clkid = cpu_to_le32(clkid),
+		.config = cpu_to_le32(ena ? RPMI_CLK_STATE_ENABLED :
+					    RPMI_CLK_STATE_DISABLED),
+	};
+	__le32 rx;
+	int ret, status;
+
+	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_SET_CONFIG, &tx,
+				  sizeof(tx), &rx, sizeof(rx), NULL);
+	if (ret)
+		return ret;
+
+	status = le32_to_cpu(rx);
+
+	return rpmi_to_linux_error(status);
+}
+
+static ulong _rpmi_clk_get_rate(struct rpmi_clk_priv *priv, u32 clkid)
+{
+	__le32 tx = cpu_to_le32(clkid);
+	struct rpmi_get_rate_rx rx;
+	int ret, status;
+
+	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_GET_RATE, &tx,
+				  sizeof(tx), &rx, sizeof(rx), NULL);
+	if (ret)
+		return ret;
+
+	status = le32_to_cpu(rx.status);
+	if (status)
+		return rpmi_to_linux_error(status);
+
+	return (((u64)(le32_to_cpu(rx.hi)) << 32) | (u32)(le32_to_cpu(rx.lo)));
+}
+
+static __maybe_unused int _rpmi_clk_get_config(struct rpmi_clk_priv *priv,
+					       u32 clkid)
+{
+	__le32 tx = cpu_to_le32(clkid);
+	struct rpmi_get_config_rx rx;
+	int ret, status;
+
+	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_GET_CONFIG, &tx,
+				  sizeof(tx), &rx, sizeof(rx), NULL);
+	if (ret)
+		return ret;
+
+	status = le32_to_cpu(rx.status);
+	if (status)
+		return rpmi_to_linux_error(status);
+
+	return le32_to_cpu(rx.state);
+}
+
+static int _rpmi_clk_set_rate(struct rpmi_clk_priv *priv, u32 clkid,
+			      unsigned long rate)
+{
+	struct rpmi_set_rate_tx tx = {
+		.clkid = cpu_to_le32(clkid),
+		.flags = 0,
+		.lo = cpu_to_le32(lower_32_bits(rate)),
+		.hi = cpu_to_le32(upper_32_bits(rate)),
+	};
+	__le32 rx;
+	int ret, status;
+
+	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_SET_RATE, &tx,
+				  sizeof(tx), &rx, sizeof(rx), NULL);
+	if (ret)
+		return ret;
+
+	status = le32_to_cpu(rx);
+
+	return rpmi_to_linux_error(status);
+}
+
+static int _rpmi_clk_get_num_clocks(struct rpmi_clk_priv *priv)
+{
+	struct rpmi_get_num_clocks_rx rx;
+	int ret, status;
+
+	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_GET_NUM_CLOCKS,
+				  NULL, 0, &rx, sizeof(rx), NULL);
+	if (ret)
+		return ret;
+
+	status = le32_to_cpu(rx.status);
+	if (status)
+		return rpmi_to_linux_error(status);
+
+	priv->num_clocks = le32_to_cpu(rx.num_clocks);
+
+	return 0;
+}
+
+static int rpmi_clk_enable(struct clk *clk)
+{
+	return _rpmi_clk_enable_disable(dev_get_plat(clk->dev),
+					clk->id & CLK_ID_MSK, true);
+}
+
+static int rpmi_clk_disable(struct clk *clk)
+{
+	return _rpmi_clk_enable_disable(dev_get_plat(clk->dev),
+					clk->id & CLK_ID_MSK, false);
+}
+
+static ulong rpmi_clk_get_rate(struct clk *clk)
+{
+	return _rpmi_clk_get_rate(dev_get_plat(clk->dev), clk->id & CLK_ID_MSK);
+}
+
+static ulong rpmi_clk_set_rate(struct clk *clk, ulong rate)
+{
+	int ret;
+
+	ret = _rpmi_clk_set_rate(dev_get_plat(clk->dev), clk->id & CLK_ID_MSK,
+				 rate);
+	if (ret)
+		return ret;
+
+	return _rpmi_clk_get_rate(dev_get_plat(clk->dev), clk->id & CLK_ID_MSK);
+}
+
+static __maybe_unused void rpmi_clk_dump(struct udevice *dev)
+{
+	struct rpmi_clk_priv *priv = (struct rpmi_clk_priv *)dev_get_plat(dev);
+	struct rpmi_clk_def *def;
+	u64 clk_rate = 0;
+	int i, state;
+
+	printf("              Rate State  Id Name\n");
+	printf("--------------------------------------\n");
+
+	for (i = 0; i < priv->num_clocks; i++) {
+		def = &priv->defs[i];
+		clk_rate = _rpmi_clk_get_rate(priv, i);
+		state = _rpmi_clk_get_config(priv, i);
+		printf("%18lld %s %4i %s\n", clk_rate,
+		       (state == RPMI_CLK_STATE_ENABLED) ? "   ON" : "  OFF", i,
+		       def->name);
+	}
+}
+
+static int rpmi_clk_xlate(struct clk *clk, struct ofnode_phandle_args *args)
+{
+	struct rpmi_clk_priv *priv = dev_get_plat(clk->dev);
+
+	if (args->args_count != 1)
+		return -EINVAL;
+
+	if (args->args[0] >= priv->num_clocks)
+		return -EINVAL;
+
+	clk->id = CLK_ID(clk->dev, args->args[0]);
+	clk->data = 0;
+
+	return 0;
+}
+
+static int rpmi_clk_get_attrs(struct rpmi_clk_priv *priv, u32 clkid,
+			      struct rpmi_clk_def *def)
+{
+	__le32 tx = cpu_to_le32(clkid);
+	struct rpmi_get_attrs_rx rx;
+	u8 format;
+	int ret, status;
+
+	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_GET_ATTRIBUTES, &tx,
+				  sizeof(tx), &rx, sizeof(rx), NULL);
+	if (ret)
+		return ret;
+
+	status = le32_to_cpu(rx.status);
+	if (status)
+		return rpmi_to_linux_error(status);
+
+	format = le32_to_cpu(rx.flags) & RPMI_CLK_TYPE_MASK;
+	if (format >= RPMI_CLK_TYPE_MAX)
+		return -EINVAL;
+
+	def->type = format;
+	def->num_rates = le32_to_cpu(rx.num_rates);
+	memcpy(def->name, rx.name, RPMI_CLK_NAME_LEN);
+	def->name[RPMI_CLK_NAME_LEN] = '\0';
+
+	return 0;
+}
+
+static int rpmi_clk_probe(struct udevice *dev)
+{
+	struct rpmi_clk_priv *priv = (struct rpmi_clk_priv *)dev_get_plat(dev);
+	struct rpmi_chan *chan = &priv->chan;
+	int ret, i;
+
+	ret = rpmi_open(chan);
+	if (ret)
+		return ret;
+
+	ret = rpmi_check_versions(chan, RPMI_MKVER(1, 0), RPMI_SRVGRP_CLOCK,
+				  RPMI_MKVER(1, 0));
+	if (ret)
+		goto err_out;
+
+	ret = _rpmi_clk_get_num_clocks(priv);
+	if (ret)
+		goto err_out;
+
+	priv->defs = calloc(priv->num_clocks, sizeof(struct rpmi_clk_def));
+	if (!priv->defs) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	for (i = 0; i < priv->num_clocks; i++) {
+		ret = rpmi_clk_get_attrs(priv, i, &priv->defs[i]);
+		if (ret)
+			goto err_out;
+	}
+
+	dev_dbg(dev, "num clock = %i\n", priv->num_clocks);
+
+	return 0;
+
+err_out:
+	free(priv->defs);
+	rpmi_close(chan);
+
+	return ret;
+}
+
+static int rpmi_clk_remove(struct udevice *dev)
+{
+	struct rpmi_clk_priv *priv = (struct rpmi_clk_priv *)dev_get_plat(dev);
+	struct rpmi_chan *chan = &priv->chan;
+
+	free(priv->defs);
+	rpmi_close(chan);
+
+	return 0;
+}
+
+static int rpmi_clk_to_plat(struct udevice *dev)
+{
+	struct rpmi_clk_priv *priv = (struct rpmi_clk_priv *)dev_get_plat(dev);
+
+	return rpmi_get_by_index(dev, 0, &priv->chan);
+}
+
+static struct clk_ops rpmi_clk_ops = {
+	.of_xlate = rpmi_clk_xlate,
+	.set_rate = rpmi_clk_set_rate,
+	.get_rate = rpmi_clk_get_rate,
+	.enable = rpmi_clk_enable,
+	.disable = rpmi_clk_disable,
+#if IS_ENABLED(CONFIG_CMD_CLK)
+	.dump = rpmi_clk_dump,
+#endif
+};
+
+static const struct udevice_id rpmi_clk_ids[] = {
+	{ .compatible = "riscv,rpmi-clock" },
+	{}
+};
+
+U_BOOT_DRIVER(rpmi_clk) = {
+	.name = "rpmi-clk",
+	.id = UCLASS_CLK,
+	.of_match = rpmi_clk_ids,
+	.probe = rpmi_clk_probe,
+	.remove = rpmi_clk_remove,
+	.ops = &rpmi_clk_ops,
+	.of_to_plat = rpmi_clk_to_plat,
+	.plat_auto = sizeof(struct rpmi_clk_priv),
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/rpmi_proto.h b/include/rpmi_proto.h
index 4b557bfeedf5..dc0937ce7053 100644
--- a/include/rpmi_proto.h
+++ b/include/rpmi_proto.h
@@ -83,4 +83,43 @@ enum rpmi_message_type {
 	RPMI_MSG_NOTIFICATION = 0x3,
 };
 
+/* RPMI clock service IDs */
+enum rpmi_clock_service_id {
+	RPMI_CLK_SRV_ENABLE_NOTIFICATION = 0x01,
+	RPMI_CLK_SRV_GET_NUM_CLOCKS = 0x02,
+	RPMI_CLK_SRV_GET_ATTRIBUTES = 0x03,
+	RPMI_CLK_SRV_GET_SUPPORTED_RATES = 0x04,
+	RPMI_CLK_SRV_SET_CONFIG = 0x05,
+	RPMI_CLK_SRV_GET_CONFIG = 0x06,
+	RPMI_CLK_SRV_SET_RATE = 0x07,
+	RPMI_CLK_SRV_GET_RATE = 0x08,
+	RPMI_CLK_SRV_ID_MAX_COUNT
+};
+
+/** Clock rate match mode */
+enum rpmi_clock_rate_match {
+	RPMI_CLK_RATE_MATCH_PLATFORM	= 0,
+	RPMI_CLK_RATE_MATCH_ROUND_DOWN	= 1,
+	RPMI_CLK_RATE_MATCH_ROUND_UP	= 2,
+	RPMI_CLK_RATE_MATCH_MAX
+};
+
+/** Supported clock states */
+enum rpmi_clock_state {
+	RPMI_CLK_STATE_DISABLED	= 0,
+	RPMI_CLK_STATE_ENABLED	= 1,
+	RPMI_CLK_STATE_MAX
+};
+
+/** Clock type based on rate format */
+enum rpmi_clock_type {
+	RPMI_CLK_TYPE_DISCRETE	= 0,
+	RPMI_CLK_TYPE_LINEAR	= 1,
+	RPMI_CLK_TYPE_MAX
+};
+
+#define RPMI_CLK_NAME_LEN 16
+
+#define RPMI_CLOCK_RATE_INVALID		(-1ULL)
+
 #endif

-- 
2.53.0

