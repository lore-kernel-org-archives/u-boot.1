Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AECDC3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 11:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 467EA884CC;
	Mon,  8 Jul 2024 13:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c/sS1xgy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC01E88271; Mon,  8 Jul 2024 13:33:12 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D939886AF
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 13:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a77e85cb9b4so151857766b.0
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 04:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720438390; x=1721043190; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8+RxeoDY23U098AbtdRBsqVy8mCCokuEc6na2mW89QI=;
 b=c/sS1xgyHWR704LnzZS51+ZgaU6V5r+gBRBYLvKYYPpCfT1iZg6Qqx8zZOqPD+oA2h
 IoAVB4K7eLCjdpIqEa/M/53Hd5vujHo30zSUkWrGTsNtw15FcxRZGEbul8gh83x1QrwH
 0Bb98T7r6471KEy3NuyffM0aYeviFm3gz5WDv7pa45NZeieFRD1jVFA3eosdNRTlqctw
 sF6J2uePSpQ9wBBu8yc4HV1Am03KGYcZxm4iWLQTaAWdLDZnZParkzUoLbu0rF7YFrwe
 5x9eiQSFUwj+mxlJubZiOq3NZwd3r0GIJNN0QEdeXqYZ76v+naqVqhVQvMnVx84CfVO9
 nVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720438390; x=1721043190;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+RxeoDY23U098AbtdRBsqVy8mCCokuEc6na2mW89QI=;
 b=YuNW4gUm7AwtI+SKDI58oit4zskE8TutVGPsWiSSZhTZxZTEMOamID7UMMPj5dHPgJ
 rODrZ+FqPXrB1fBzxSbXSKkZ7yeYtsrmQgjzbHAJP1KI0qho+z5zpC3wWRP6hCBNL7Nv
 KsRb03XLY9xUqcygf8ynIJzCBfFotS9pXQIJBpTX/FxMbQ48J3dBPeWdUuw4VxstOou5
 HFP7Z7tpRUUw109pTK+Zgd2uAL3GjP3RdGQ1mIMJciSLtcSRV+SgU2f5RR5apGioGYkp
 dY51TDuypFjKlDoWzqOFxfxWLHwjtBSjG+Qt0Khenv0boyCWB68tSmhA3La98LWFryrB
 M+KQ==
X-Gm-Message-State: AOJu0YxaQ5udrOtFHQK+fda6VDa9hTcSeRUBQrp6KZM/FT3Lq1szhrrp
 XdQ7C6e+lqlwo/ibv8dQUHNZjpiQoPXerOP1vV6gZ2GModAMxSmrCxWL3GLhRzNEGK8P0x08Zi6
 xls8=
X-Google-Smtp-Source: AGHT+IHla5qgMzArxV7xChBOtmpyrHSmTBYFlZKPEz+hXo4j/DxMkdZFwXBKTO/3UCEEN1fl9xpRsA==
X-Received: by 2002:a17:906:eb56:b0:a6f:b715:6cd9 with SMTP id
 a640c23a62f3a-a77ba70a7ddmr769685366b.56.1720438389469; 
 Mon, 08 Jul 2024 04:33:09 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77c9925463sm303628466b.69.2024.07.08.04.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 04:33:09 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 08 Jul 2024 13:32:55 +0200
Subject: [PATCH v2 3/4] power: regulator: add qcom-rpmh-regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-b4-qcom-rpmh-v2-3-8bc765606e56@linaro.org>
References: <20240708-b4-qcom-rpmh-v2-0-8bc765606e56@linaro.org>
In-Reply-To: <20240708-b4-qcom-rpmh-v2-0-8bc765606e56@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=18340;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=12Z5km0pLk4CJ8ivJ1W8gj0/OEPY9fyAiBdVhCdiU7o=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmi85wnO039d/qB1m6518bcx6lDWtIdSWzgKxrc
 /6rZJy2mZGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZovOcAAKCRAFgzErGV9k
 tnM/D/oCQwAHmHLLJjX3WH0Jtd2RZacY51pRmsPHG0Cb47HWTQgLX7KUvqBPTyQXlAM0fh5tRzP
 aYnse6k+UuYCd2OIoo346IzEg+W/0xy4jUYPpnpwU+NTS82Yr0aSdSFUpBW5C5tvRGk/rpF7uLV
 a6Yqb9VMeXhoyjFJO58QAkPEkU7aGE5Trqcgb78I2Xd43wtvaWyTgg18aJgSelTJU5OrGlEei9i
 Do/SIn6pXbsZluftpBQX6KyaN6IBeRAflEowG/RteAmwdr+4cMtNyqcik1RqunXiPAE9QjncDW/
 XP/A0WAhrS2gDN+aezJ22VwOOBeDC2j9dsttaYaTgaB0vxLRpQIpgNzyJ+Fx36ZwnEIVyts2YRq
 /HK6rmPN446OjOyCCJRXW6XLSn+Q74w9PY8HH9YytnxYeWZjUQrQpixrXj/evj6IU4TVyoGQeQX
 h8PnmmuJS20iB7RYL0gNndEAvTTS+J8xPd0Y/0nN9YIgzyaQTYyvx/Bqfe3ASq/qNC4DQxC2Iqd
 4NjZ0KqV+XUUQZGsM6Anobc/o/Mv1TA4Kf2AFIDvupDeFymEvk56hIufBwIpPFiXNoV1+bKzttE
 LldoNmqPisSnoKyjemBBwSYhcysKV+8f2yMaQ8bNNSkID0XHrkwBCVxdn6df/gemPZP8BRmC0kt
 4J4aK55LTCaJ3EA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add a regulator driver for controlling the PMIC rails via the RPMh on
Qualcomm platforms. This driver is restricted to only know about rails
which are required by u-boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/power/regulator/Kconfig               |   8 +
 drivers/power/regulator/Makefile              |   1 +
 drivers/power/regulator/qcom-rpmh-regulator.c | 536 ++++++++++++++++++++++++++
 3 files changed, 545 insertions(+)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 102ec7bc5f89..bc061c20d75e 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -215,8 +215,16 @@ config DM_REGULATOR_GPIO
 	This config enables implementation of driver-model regulator uclass
 	features for gpio regulators. The driver implements get/set for
 	voltage value.
 
+config DM_REGULATOR_QCOM_RPMH
+	bool "Enable driver model for Qualcomm RPMh regulator"
+	depends on DM_REGULATOR && QCOM_RPMH
+	---help---
+	  Enable support for the Qualcomm RPMh regulator. The driver
+	  implements get/set api for a limited set of regulators used
+	  by u-boot.
+
 config SPL_DM_REGULATOR_GPIO
 	bool "Enable Driver Model for GPIO REGULATOR in SPL"
 	depends on DM_REGULATOR_GPIO && SPL_GPIO
 	select SPL_DM_REGULATOR_COMMON
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index f79932d83307..56a527612b74 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -20,8 +20,9 @@ obj-$(CONFIG_$(SPL_)REGULATOR_PWM) += pwm_regulator.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_FAN53555) += fan53555.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_COMMON) += regulator_common.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_FIXED) += fixed.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_GPIO) += gpio-regulator.o
+obj-$(CONFIG_DM_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
 obj-$(CONFIG_$(SPL_TPL_)REGULATOR_RK8XX) += rk8xx.o
 obj-$(CONFIG_DM_REGULATOR_S2MPS11) += s2mps11_regulator.o
 obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
 obj-$(CONFIG_DM_REGULATOR_SANDBOX) += sandbox.o
diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
new file mode 100644
index 000000000000..7ddd6e3d21bf
--- /dev/null
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018-2021, The Linux Foundation. All rights reserved.
+
+#include <linux/err.h>
+#include <dm/device_compat.h>
+#include <dm/device.h>
+#include <dm/devres.h>
+#include <dm/lists.h>
+#include <power/regulator.h>
+#include <log.h>
+
+#include <soc/qcom/cmd-db.h>
+#include <soc/qcom/rpmh.h>
+
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+
+/**
+ * enum rpmh_regulator_type - supported RPMh accelerator types
+ * @VRM:	RPMh VRM accelerator which supports voting on enable, voltage,
+ *		and mode of LDO, SMPS, and BOB type PMIC regulators.
+ * @XOB:	RPMh XOB accelerator which supports voting on the enable state
+ *		of PMIC regulators.
+ */
+enum rpmh_regulator_type {
+	VRM,
+	XOB,
+};
+
+enum rpmh_regulator_mode {
+	REGULATOR_MODE_RETENTION,
+	REGULATOR_MODE_LPM,
+	REGULATOR_MODE_AUTO,
+	REGULATOR_MODE_HPM,
+};
+
+#define RPMH_REGULATOR_REG_VRM_VOLTAGE		0x0
+#define RPMH_REGULATOR_REG_ENABLE		0x4
+#define RPMH_REGULATOR_REG_VRM_MODE		0x8
+
+#define PMIC4_LDO_MODE_RETENTION		4
+#define PMIC4_LDO_MODE_LPM			5
+#define PMIC4_LDO_MODE_HPM			7
+
+#define PMIC4_SMPS_MODE_RETENTION		4
+#define PMIC4_SMPS_MODE_PFM			5
+#define PMIC4_SMPS_MODE_AUTO			6
+#define PMIC4_SMPS_MODE_PWM			7
+
+#define PMIC4_BOB_MODE_PASS			0
+#define PMIC4_BOB_MODE_PFM			1
+#define PMIC4_BOB_MODE_AUTO			2
+#define PMIC4_BOB_MODE_PWM			3
+
+#define PMIC5_LDO_MODE_RETENTION		3
+#define PMIC5_LDO_MODE_LPM			4
+#define PMIC5_LDO_MODE_HPM			7
+
+#define PMIC5_SMPS_MODE_RETENTION		3
+#define PMIC5_SMPS_MODE_PFM			4
+#define PMIC5_SMPS_MODE_AUTO			6
+#define PMIC5_SMPS_MODE_PWM			7
+
+#define PMIC5_BOB_MODE_PASS			2
+#define PMIC5_BOB_MODE_PFM			4
+#define PMIC5_BOB_MODE_AUTO			6
+#define PMIC5_BOB_MODE_PWM			7
+
+/**
+ * struct linear_range - table of selector - value pairs
+ *
+ * Define a lookup-table for range of values. Intended to help when looking
+ * for a register value matching certaing physical measure (like voltage).
+ * Usable when increment of one in register always results a constant increment
+ * of the physical measure (like voltage).
+ *
+ * @min:  Lowest value in range
+ * @min_sel: Lowest selector for range
+ * @max_sel: Highest selector for range
+ * @step: Value step size
+ */
+struct linear_range {
+	unsigned int min;
+	unsigned int min_sel;
+	unsigned int max_sel;
+	unsigned int step;
+};
+
+/* Initialize struct linear_range for regulators */
+#define REGULATOR_LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)	\
+{									\
+	.min		= _min_uV,					\
+	.min_sel	= _min_sel,					\
+	.max_sel	= _max_sel,					\
+	.step		= _step_uV,					\
+}
+
+/**
+ * struct rpmh_vreg_hw_data - RPMh regulator hardware configurations
+ * @regulator_type:		RPMh accelerator type used to manage this
+ *				regulator
+ * @ops:			Pointer to regulator ops callback structure
+ * @voltage_range:		The single range of voltages supported by this
+ *				PMIC regulator type
+ * @n_voltages:			The number of unique voltage set points defined
+ *				by voltage_range
+ * @hpm_min_load_uA:		Minimum load current in microamps that requires
+ *				high power mode (HPM) operation.  This is used
+ *				for LDO hardware type regulators only.
+ * @pmic_mode_map:		Array indexed by regulator framework mode
+ *				containing PMIC hardware modes.  Must be large
+ *				enough to index all framework modes supported
+ *				by this regulator hardware type.
+ * @of_map_mode:		Maps an RPMH_REGULATOR_MODE_* mode value defined
+ *				in device tree to a regulator framework mode
+ */
+struct rpmh_vreg_hw_data {
+	enum rpmh_regulator_type		regulator_type;
+	const struct dm_regulator_ops		*ops;
+	struct linear_range			voltage_range;
+	int					n_voltages;
+	int					hpm_min_load_uA;
+	struct dm_regulator_mode		*pmic_mode_map;
+	int					n_modes;
+	unsigned int				(*of_map_mode)(unsigned int mode);
+};
+
+/**
+ * struct rpmh_vreg - individual RPMh regulator data structure encapsulating a
+ *		single regulator device
+ * @dev:			Device pointer for the top-level PMIC RPMh
+ *				regulator parent device.  This is used as a
+ *				handle in RPMh write requests.
+ * @addr:			Base address of the regulator resource within
+ *				an RPMh accelerator
+ * @rdesc:			Regulator descriptor
+ * @hw_data:			PMIC regulator configuration data for this RPMh
+ *				regulator
+ * @always_wait_for_ack:	Boolean flag indicating if a request must always
+ *				wait for an ACK from RPMh before continuing even
+ *				if it corresponds to a strictly lower power
+ *				state (e.g. enabled --> disabled).
+ * @enabled:			Flag indicating if the regulator is enabled or
+ *				not
+ * @bypassed:			Boolean indicating if the regulator is in
+ *				bypass (pass-through) mode or not.  This is
+ *				only used by BOB rpmh-regulator resources.
+ * @uv:				Selector used for get_voltage_sel() and
+ *				set_value() callbacks
+ * @mode:			RPMh VRM regulator current framework mode
+ */
+struct rpmh_vreg {
+	struct udevice			*dev;
+	u32				addr;
+	const struct rpmh_vreg_hw_data	*hw_data;
+	bool				always_wait_for_ack;
+
+	int				enabled;
+	bool				bypassed;
+	int				uv;
+	int			mode;
+};
+
+/**
+ * struct rpmh_vreg_init_data - initialization data for an RPMh regulator
+ * @name:			Name for the regulator which also corresponds
+ *				to the device tree subnode name of the regulator
+ * @resource_name:		RPMh regulator resource name format string.
+ *				This must include exactly one field: '%s' which
+ *				is filled at run-time with the PMIC ID provided
+ *				by device tree property qcom,pmic-id.  Example:
+ *				"ldo%s1" for RPMh resource "ldoa1".
+ * @supply_name:		Parent supply regulator name
+ * @hw_data:			Configuration data for this PMIC regulator type
+ */
+struct rpmh_vreg_init_data {
+	const char			*name;
+	const char			*resource_name;
+	const char			*supply_name;
+	const struct rpmh_vreg_hw_data	*hw_data;
+};
+
+/**
+ * rpmh_regulator_send_request() - send the request to RPMh
+ * @vreg:		Pointer to the RPMh regulator
+ * @cmd:		Pointer to the RPMh command to send
+ * @wait_for_ack:	Boolean indicating if execution must wait until the
+ *			request has been acknowledged as complete
+ *
+ * Return: 0 on success, errno on failure
+ */
+static int rpmh_regulator_send_request(struct rpmh_vreg *vreg,
+				       const struct tcs_cmd *cmd, bool wait_for_ack)
+{
+	int ret;
+
+	if (wait_for_ack || vreg->always_wait_for_ack)
+		ret = rpmh_write(vreg->dev->parent, RPMH_ACTIVE_ONLY_STATE, cmd, 1);
+	else
+		ret = rpmh_write_async(vreg->dev->parent, RPMH_ACTIVE_ONLY_STATE, cmd, 1);
+
+	return ret;
+}
+
+static int _rpmh_regulator_vrm_set_value(struct udevice *rdev,
+					 int uv, bool wait_for_ack)
+{
+	struct rpmh_vreg *vreg = dev_get_priv(rdev);
+	struct tcs_cmd cmd = {
+		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE,
+	};
+	int ret;
+	unsigned int selector;
+
+	selector = (uv - vreg->hw_data->voltage_range.min) / vreg->hw_data->voltage_range.step;
+	cmd.data = DIV_ROUND_UP(vreg->hw_data->voltage_range.min +
+				selector * vreg->hw_data->voltage_range.step, 1000);
+
+	ret = rpmh_regulator_send_request(vreg, &cmd, wait_for_ack);
+	if (!ret)
+		vreg->uv = cmd.data * 1000;
+
+	return ret;
+}
+
+static int rpmh_regulator_vrm_set_value(struct udevice *rdev,
+					int uv)
+{
+	struct rpmh_vreg *vreg = dev_get_priv(rdev);
+
+	debug("%s: set_value %d (current %d)\n", rdev->name, uv, vreg->uv);
+
+	if (vreg->enabled == -EINVAL) {
+		/*
+		 * Cache the voltage and send it later when the regulator is
+		 * enabled or disabled.
+		 */
+		vreg->uv = uv;
+		return 0;
+	}
+
+	return _rpmh_regulator_vrm_set_value(rdev, uv,
+					uv > vreg->uv);
+}
+
+static int rpmh_regulator_vrm_get_value(struct udevice *rdev)
+{
+	struct rpmh_vreg *vreg = dev_get_priv(rdev);
+
+	debug("%s: get_value %d\n", rdev->name, vreg->uv);
+
+	return vreg->uv;
+}
+
+static int rpmh_regulator_is_enabled(struct udevice *rdev)
+{
+	struct rpmh_vreg *vreg = dev_get_priv(rdev);
+
+	debug("%s: is_enabled %d\n", rdev->name, vreg->enabled);
+
+	return vreg->enabled > 0;
+}
+
+static int rpmh_regulator_set_enable_state(struct udevice *rdev,
+					   bool enable)
+{
+	struct rpmh_vreg *vreg = dev_get_priv(rdev);
+	struct tcs_cmd cmd = {
+		.addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
+		.data = enable,
+	};
+	int ret;
+
+	debug("%s: set_enable %d (current %d)\n", rdev->name, enable,
+	      vreg->enabled);
+
+	if (vreg->enabled == -EINVAL &&
+	    vreg->uv != -ENOTRECOVERABLE) {
+		ret = _rpmh_regulator_vrm_set_value(rdev,
+						    vreg->uv, true);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = rpmh_regulator_send_request(vreg, &cmd, enable);
+	if (!ret)
+		vreg->enabled = enable;
+
+	return ret;
+}
+
+static int rpmh_regulator_vrm_set_mode_bypass(struct rpmh_vreg *vreg,
+					      unsigned int mode, bool bypassed)
+{
+	struct tcs_cmd cmd = {
+		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_MODE,
+	};
+	struct dm_regulator_mode *pmic_mode;
+	int i;
+
+	if (mode > REGULATOR_MODE_HPM)
+		return -EINVAL;
+
+	for (i = 0; i < vreg->hw_data->n_modes; i++) {
+		pmic_mode = &vreg->hw_data->pmic_mode_map[i];
+		if (pmic_mode->id == mode)
+			break;
+	}
+	if (pmic_mode->id != mode) {
+		printf("Invalid mode %d\n", mode);
+		return -EINVAL;
+	}
+
+	if (bypassed)
+		cmd.data = PMIC4_BOB_MODE_PASS;
+	else
+		cmd.data = pmic_mode->id;
+
+	return rpmh_regulator_send_request(vreg, &cmd, true);
+}
+
+static int rpmh_regulator_vrm_set_mode(struct udevice *rdev,
+				       int mode)
+{
+	struct rpmh_vreg *vreg = dev_get_priv(rdev);
+	int ret;
+
+	debug("%s: set_mode %d (current %d)\n", rdev->name, mode, vreg->mode);
+
+	if (mode == vreg->mode)
+		return 0;
+
+	ret = rpmh_regulator_vrm_set_mode_bypass(vreg, mode, vreg->bypassed);
+	if (!ret)
+		vreg->mode = mode;
+
+	return ret;
+}
+
+static int rpmh_regulator_vrm_get_mode(struct udevice *rdev)
+{
+	struct rpmh_vreg *vreg = dev_get_priv(rdev);
+
+	debug("%s: get_mode %d\n", rdev->name, vreg->mode);
+
+	return vreg->mode;
+}
+
+static const struct dm_regulator_ops rpmh_regulator_vrm_drms_ops = {
+	.get_value = rpmh_regulator_vrm_get_value,
+	.set_value = rpmh_regulator_vrm_set_value,
+	.set_enable = rpmh_regulator_set_enable_state,
+	.get_enable = rpmh_regulator_is_enabled,
+	.set_mode = rpmh_regulator_vrm_set_mode,
+	.get_mode = rpmh_regulator_vrm_get_mode,
+};
+
+static struct dm_regulator_mode pmic_mode_map_pmic5_ldo[] = {
+	{
+		.id = REGULATOR_MODE_RETENTION,
+		.register_value = PMIC5_LDO_MODE_RETENTION,
+		.name = "PMIC5_LDO_MODE_RETENTION"
+	}, {
+		.id = REGULATOR_MODE_LPM,
+		.register_value = PMIC5_LDO_MODE_LPM,
+		.name = "PMIC5_LDO_MODE_LPM"
+	}, {
+		.id = REGULATOR_MODE_HPM,
+		.register_value = PMIC5_LDO_MODE_HPM,
+		.name = "PMIC5_LDO_MODE_HPM"
+	},
+};
+
+static const struct rpmh_vreg_hw_data pmic5_pldo_lv = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(1504000, 0, 62, 8000),
+	.n_voltages = 63,
+	.hpm_min_load_uA = 10000,
+	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
+};
+
+static const struct rpmh_vreg_hw_data pmic5_pldo = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(1504000, 0, 255, 8000),
+	.n_voltages = 256,
+	.hpm_min_load_uA = 10000,
+	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_ldo),
+};
+
+#define RPMH_VREG(_name, _resource_name, _hw_data, _supply_name) \
+{ \
+	.name		= _name, \
+	.resource_name	= _resource_name, \
+	.hw_data	= _hw_data, \
+	.supply_name	= _supply_name, \
+}
+
+static const struct rpmh_vreg_init_data pm8150_vreg_data[] = {
+	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l13-l16-l17"),
+};
+
+static const struct rpmh_vreg_init_data pm8150l_vreg_data[] = {
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo_lv,   "vdd-l1-l8"),
+	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l7-l11"),
+	{}
+};
+
+/* probe an individual regulator */
+static int rpmh_regulator_probe(struct udevice *dev)
+{
+	const struct rpmh_vreg_init_data *init_data;
+	struct rpmh_vreg *priv;
+	struct dm_regulator_uclass_plat *plat_data;
+
+	init_data = (const struct rpmh_vreg_init_data *)dev_get_driver_data(dev);
+	priv = dev_get_priv(dev);
+	plat_data = dev_get_uclass_plat(dev);
+
+	priv->dev = dev;
+	priv->addr = cmd_db_read_addr(dev->name);
+	if (!priv->addr) {
+		dev_err(dev, "Failed to read RPMh address for %s\n", dev->name);
+		return -ENODEV;
+	}
+
+	priv->hw_data = init_data->hw_data;
+	priv->enabled = -EINVAL;
+	priv->uv = -ENOTRECOVERABLE;
+	if (ofnode_read_u32(dev_ofnode(dev), "regulator-initial-mode", &priv->mode))
+		priv->mode = -EINVAL;
+
+	plat_data->mode = priv->hw_data->pmic_mode_map;
+	plat_data->mode_count = priv->hw_data->n_modes;
+
+	return 0;
+}
+
+/* for non-drm, xob, or bypass regulators add additional driver definitions */
+U_BOOT_DRIVER(rpmh_regulator_drm) = {
+	.name = "rpmh_regulator_drm",
+	.id = UCLASS_REGULATOR,
+	.probe = rpmh_regulator_probe,
+	.priv_auto = sizeof(struct rpmh_vreg),
+	.ops = &rpmh_regulator_vrm_drms_ops,
+};
+
+/* This driver intentionally only supports a subset of the available regulators.
+ * This function checks to see if a given regulator node in DT matches a regulator
+ * defined in the driver.
+ */
+static const struct rpmh_vreg_init_data *
+vreg_get_init_data(const struct rpmh_vreg_init_data *init_data, ofnode node)
+{
+	const struct rpmh_vreg_init_data *data;
+
+	for (data = init_data; data->name; data++) {
+		if (!strcmp(data->name, ofnode_get_name(node)))
+			return data;
+	}
+
+	return NULL;
+}
+
+static int rpmh_regulators_bind(struct udevice *dev)
+{
+	const struct rpmh_vreg_init_data *init_data, *data;
+	const char *pmic_id;
+	char *name;
+	struct driver *drv;
+	ofnode node;
+	int ret;
+	size_t namelen;
+
+	init_data = (const struct rpmh_vreg_init_data *)dev_get_driver_data(dev);
+	if (!init_data) {
+		dev_err(dev, "No RPMh regulator init data\n");
+		return -ENODEV;
+	}
+
+	pmic_id = ofnode_read_string(dev_ofnode(dev), "qcom,pmic-id");
+	if (!pmic_id) {
+		dev_err(dev, "No PMIC ID\n");
+		return -ENODEV;
+	}
+
+	drv = lists_driver_lookup_name("rpmh_regulator_drm");
+
+	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
+		data = vreg_get_init_data(init_data, node);
+		if (!data)
+			continue;
+
+		/* %s is replaced with pmic_id, so subtract 2, then add 1 for the null terminator */
+		namelen = strlen(data->resource_name) + strlen(pmic_id) - 1;
+		name = devm_kzalloc(dev, namelen, GFP_KERNEL);
+		ret = snprintf(name, namelen, data->resource_name, pmic_id);
+		if (ret < 0 || ret >= namelen) {
+			dev_err(dev, "Failed to create RPMh regulator name\n");
+			return -ENOMEM;
+		}
+
+		ret = device_bind_with_driver_data(dev, drv, name, (ulong)data,
+						   node, NULL);
+		if (ret < 0) {
+			dev_err(dev, "Failed to bind RPMh regulator %s: %d\n", name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct udevice_id rpmh_regulator_ids[] = {
+	{
+		.compatible = "qcom,pm8150-rpmh-regulators",
+		.data = (ulong)pm8150_vreg_data,
+	},
+	{
+		.compatible = "qcom,pm8150l-rpmh-regulators",
+		.data = (ulong)pm8150l_vreg_data,
+	},
+	{ /* sentinal */ },
+};
+
+/* Driver for a 'bank' of regulators. This creates devices for each
+ * individual regulator
+ */
+U_BOOT_DRIVER(rpmh_regulators) = {
+	.name = "rpmh_regulators",
+	.id = UCLASS_MISC,
+	.bind = rpmh_regulators_bind,
+	.of_match = rpmh_regulator_ids,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+};

-- 
2.45.2

