Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E8606A329
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 04:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NWtzcEKd;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E19KkSen
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54F2F60D80;
	Sat, 14 Nov 2026 04:05:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PirdDzGtoJ-7; Sat, 14 Nov 2026 04:05:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7155F606F1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794629106;
	b=oMLOgddf+uUcjgpo7GOlcXokz0GWMc+TRWiIR2e0nMvLlihv/bJ6z96691/2+NU6FsbY
	 KXUmDa60xwmlY/CXuJBBEpWsjTbmVd5wXnxFhVvv+QCekJkJOHzKJoIh3B9mN0p4EBEw+
	 H5IeSIP2DDe2+nxsDvDSzo96kPo4hDTp2u1GfDa/TyFfFzEpkK4TraJD46yJh9xytN8wr
	 V2gAIr+Qfe5EQgA20xrpe6WXQ0IlKc0QUwqPJMuOQseiWhzBnkVVcv2Cyy2CYSSY3TpsL
	 6iKQRIOoY9XpaL1956fWm1eh0T6DTTDiGbct0Lcfx6Ad+jygxDSigPGrUtP+cdRxs9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794629106;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=IcLkSEHFWTTMSAncZlX1pQicg3DlbEuaUcUxF7cgiUE=;
	b=DnMTdeFhXjqTtgv9Uq3iSbW6Y6T7tir3lk0Fe1rx7TZg17TOJv/T8wMlk9hdsyE0IWm1
	 eEZmlsXmT9vexKIVG/OewXCoX1wxAiPfdwlIa11Vu9BO3cWvKpcK8k68ly1gUtMNEdzjm
	 j4WLMNj7KeYlvz1daCMA1sSICMzZwlKv4l8tgZ4EzqyZpoumXeD2z039KhbjkgvkI4W7m
	 CqwA/mD0qj2q1KB9eX3PufZ2pGp6Io8AnGkenf+cqUyOw/vPGwgp+zJ4CyoF5FVpUNrK6
	 Of08cd/VuRngGNm1M9TT3qa7M/KtJ4KoVOpU0MmBu2JPlqrCxEhCQ2b1xf/4AgpWNIg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794629106;
	bh=IcLkSEHFWTTMSAncZlX1pQicg3DlbEuaUcUxF7cgiUE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=NWtzcEKd0/SlYdb/iJY0qoyH3r3SQSE+h/4Ar81CuEH//abgOGvbhbxW2CyTcCoTt
	 dMLTZU7f62r3ydcy1cCYB8ohxIhX9MsXrGHM33jXnUF3JdcrMsWofwdgp09iWiqH2j
	 tU+m5+dsbKhMsCTeXJH8X8ufUj0j80d5J/GFZJHVQJXNB6xVMUmE34flhiztPcve4g
	 mYqbbCF0MABLTEvMQY1Bo8fyJuz5S/LfUx4ooexu9BnN0N8ZmE1IEsEjAYT5y4Xj2b
	 wEfbvX3fBVCWRTUGc4E4WSJ+gNgNmZxNpHbPN7KcDa9WZNeGeWg6UhFALqGiMOCI/h
	 HSKaU0ydhY1sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7155F606F1;
	Sat, 14 Nov 2026 04:05:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 98F52150
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8165640EB0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v2Eb03ej73o1 for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 02:22:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5EA3540EA0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+me.fromdisposition.org@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=E19KkSen
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5EA3540EA0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BC68545BDB;
 Sat, 14 Nov 2026 02:22:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id EAF601F000C6;
 Sat, 14 Nov 2026 02:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794622935;
 bh=IcLkSEHFWTTMSAncZlX1pQicg3DlbEuaUcUxF7cgiUE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=E19KkSen6ALZdpuJRWgj4W1TlxFbYyH04128KTLSB5U+DR7vmpnJQxcyoEttM+RLZ
 zascY5qXvVBPE3D3phNvMQJjJPhKCQfJ8luptjZdyB0m4b2fbHqSwnmhp0AZMmZffW
 jOXWwMuZ5HTX1JA4EUpiHU8l5fu3Ggj5K2TwEPXofu0VnU47c7tw5ro9wx/cckmK6p
 CpYMOB5COvHL5nIw0i6aq/nUfaa63azydXpiMfL18ekSRCjiTQ7Rpsqw0jnuA0s16i
 AUoHrAKTbH2auGdnEV2/0IilJGJ/43N7VPTz2FW9zFLXYuSmvu0wl7+2piT8to14VH
 6UYigu2jIbN3Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 74AC349C27;
 Sat, 14 Nov 2026 02:22:14 +0000 (UTC)
From: Demeter Barna via B4 Relay <devnull+me.fromdisposition.org@kernel.org>
Date: Sat, 14 Nov 2026 02:21:56 +0000
Subject: [PATCH 2/9] pinctrl: qcom: Add SM8350 pinctrl driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-sm8350-support-v1-2-414271f59474@fromdisposition.org>
References: <20261114-sm8350-support-v1-0-414271f59474@fromdisposition.org>
In-Reply-To: <20261114-sm8350-support-v1-0-414271f59474@fromdisposition.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Vitalii Skorkin <nikroks@mainlining.org>, 
 Erikas Bitovtas <xerikasxx@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Federico Amedeo Izzo <federico@izzo.pro>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Demeter Barna <me@fromdisposition.org>, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794622936; l=4747;
 i=me@fromdisposition.org; s=20261012; h=from:subject:message-id;
 bh=2EcApNXV/eG/Pm7CCvLKbtl+vUubNR3+bLBbP8YfanQ=;
 b=5QxEqws3YtxsBbD77gO5cvrVd+5L3ukxS+juDgfmCStMBuw5PvdbmqguWMX7QoZV4G4k9nQGN
 PwXHG3Lc1DoDuWqG2q+EtGmC9q42Cadz37YIG75DWk0skeonQ0CKYhC
X-Developer-Key: i=me@fromdisposition.org; a=ed25519;
 pk=S0QFlGq1BQEaAtPPdAH8YKEOXMeRuSkTgctXuvtU+1Y=
X-Endpoint-Received: by B4 Relay for me@fromdisposition.org/20261012 with
 auth_id=1163
X-Original-From: Demeter Barna <me@fromdisposition.org>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 04:05:04 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: me@fromdisposition.org
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Demeter Barna <me@fromdisposition.org>

Add support for the SM8350 TLMM: 203 GPIOs, the UFS reset and SDC2
special pins, and the debug UART function.

The data are those of Linux's pinctrl-sm8350 driver (tag v7.4-rc1).

Signed-off-by: Demeter Barna <me@fromdisposition.org>
---
 drivers/pinctrl/qcom/Kconfig          |   8 +++
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sm8350.c | 101 ++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index fa0385f159..00ce340b69 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -187,6 +187,14 @@ config PINCTRL_QCOM_SM8250
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8250 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_SM8350
+	bool "Qualcomm SM8350 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon SM8350 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_SM8550
 	bool "Qualcomm SM8550 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 97d59f5eac..8e49e8085a 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_PINCTRL_QCOM_SM6350) += pinctrl-sm6350.o
 obj-$(CONFIG_PINCTRL_QCOM_SM7150) += pinctrl-sm7150.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
+obj-$(CONFIG_PINCTRL_QCOM_SM8350) += pinctrl-sm8350.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8650) += pinctrl-sm8650.o
 obj-$(CONFIG_PINCTRL_QCOM_X1E80100) += pinctrl-x1e80100.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8350.c b/drivers/pinctrl/qcom/pinctrl-sm8350.c
new file mode 100644
index 0000000000..0365887d20
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sm8350.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm sm8350 pinctrl
+ *
+ * (C) Copyright 2024 Linaro Ltd.
+ * (C) Copyright 2026 Demeter Barna <me@fromdisposition.org>
+ *
+ * Based on Linux Kernel driver
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{"gpio", 0},
+	{"qup3", 1},
+};
+
+#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
+	{					        \
+		.name = pg_name,			\
+		.ctl_reg = ctl,				\
+		.io_reg = 0,				\
+		.pull_bit = pull,			\
+		.drv_bit = drv,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = -1,				\
+	}
+
+#define UFS_RESET(pg_name, ctl, io)			\
+	{					        \
+		.name = pg_name,			\
+		.ctl_reg = ctl,				\
+		.io_reg = io,				\
+		.pull_bit = 3,				\
+		.drv_bit = 0,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = 0,				\
+	}
+
+static const struct msm_special_pin_data msm_special_pins_data[] = {
+	[0] = UFS_RESET("ufs_reset", 0xd8000, 0xd8004),
+	[1] = SDC_QDSD_PINGROUP("sdc2_clk", 0xcf000, 14, 6),
+	[2] = SDC_QDSD_PINGROUP("sdc2_cmd", 0xcf000, 11, 3),
+	[3] = SDC_QDSD_PINGROUP("sdc2_data", 0xcf000, 9, 0),
+};
+
+static const char *sm8350_get_function_name(struct udevice *dev,
+					    unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *sm8350_get_pin_name(struct udevice *dev,
+				       unsigned int selector)
+{
+	if (selector >= 203 && selector <= 206)
+		snprintf(pin_name, MAX_PIN_NAME_LEN,
+			 msm_special_pins_data[selector - 203].name);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static int sm8350_get_function_mux(__maybe_unused unsigned int pin,
+				   unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+static struct msm_pinctrl_data sm8350_data = {
+	.pin_data = {
+		.pin_count = 207,
+		.special_pins_start = 203,
+		.special_pins_data = msm_special_pins_data,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = sm8350_get_function_name,
+	.get_function_mux = sm8350_get_function_mux,
+	.get_pin_name = sm8350_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,sm8350-tlmm", .data = (ulong)&sm8350_data },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_sm8350) = {
+	.name		= "pinctrl_sm8350",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+};

-- 
2.53.0


