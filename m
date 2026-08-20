Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B36C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 13:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E9B9405BE;
	Thu, 20 Aug 2026 13:07:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1zFhsiKWd2l5; Thu, 20 Aug 2026 13:07:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787231230;
	bh=RUqv2v2hNO07ZgRjAxWaAjLOvYwCQSxa9bQ1tDc07A4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HAQubG2DTjuwgrEj0auTb5+fsSqGHYcNA0tLoCJjsF3YfdwTidalcfsuxz1D7H61r
	 W2xU/82LZOnviPt6qyOW3a8MGxRuxnQ26HNTyKcv/UMzKrraf8v9sfD0T08qcgOb2E
	 8eTYdRGLfYjj1baDcmvQSYTyVBSr31ElxRj36O0R5i+B2yger/yX/NNxcZe51o65A+
	 ibmUWoESl32HGj2zXtSStaZaR1m9p0obiaiuFhpQZc6go+VD5B/4btrf+D2eO0/uOo
	 UdyRGU1ejl+YkilKTKX/0YBwXlwe76XMU6kgtBJEmHL4V0A/WjbKbjI+VKMD/MJVVM
	 lsstogUyZBxqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2CD2405C2;
	Thu, 20 Aug 2026 13:07:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FF4D40B
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7180460739
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:02:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zwIEor5TjLov for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 13:02:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=DnGw6Fi4
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E900605DB
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:02:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D09660A58;
 Thu, 20 Aug 2026 13:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4551F000E9;
 Thu, 20 Aug 2026 13:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787230919;
 bh=RUqv2v2hNO07ZgRjAxWaAjLOvYwCQSxa9bQ1tDc07A4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=DnGw6Fi4AeGXkpVWcp/NdKrBMu39ryyh94ymWHYB0XTklGpdqlwW1bzbnFpZTC9xK
 +5nhtXhbTgBJiYsdE4sS8t0COsQ4zjGUDKL+2dlDJp+jX5GOlZDAJCCuaw/JiI2W9j
 0gwyOvOH0TjN/idKaZZhVM5o3MqF4AuO9pn/4Up0XcUZBs5gmU4Bsqg8cFFO60Tngw
 MmbMUIwOoZTohnq3u/gFiRSY0tikQcMI2hXi9k6NCXqzmNnR9b5BSS9WyjIVcvbIDj
 rVrtQnEUzxNLZvq9Fmn/DkZDUEt4mULZkbHflQztI/RiFbUpTkGOMf5GmBKzAtl/u7
 Cs+G7HL8wieVA==
From: Yixun Lan <dlan@kernel.org>
Date: Thu, 20 Aug 2026 13:01:38 +0000
Subject: [PATCH 1/2] pinctrl: spacemit: configure drive strength based on
 power source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-01-k3-pinctrl-support-v1-1-b54a2450c895@kernel.org>
References: <20260820-01-k3-pinctrl-support-v1-0-b54a2450c895@kernel.org>
In-Reply-To: <20260820-01-k3-pinctrl-support-v1-0-b54a2450c895@kernel.org>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7073; i=dlan@kernel.org;
 h=from:subject:message-id; bh=Ea9C2lLTXyMHI0FQTLfaOyDrnWHvcpRe2Skf5TSQcjA=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqhvq9rhxJRM+sgHh+U85zZEWlkyCzslxC622rG
 tnJAd8wsOCJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaob6vRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+04pQ//fMPnyl3MrjrGWh62QFG1rYyZj0LPhRDpYuRgdP/eWIoAoxgC/VVSZ
 bAaNMZLwKiKQBnw3C/rBYGZjnwjKSB7ELa2/cE+Px7CVeos/OxsYVCINmQ4/ikNp4wkTGlYt4eV
 5xD2DxnqOxtH0kjnjUWziXXejYxd4bxTiyDLvfIN/p5yKt7a65FoSd7rwyLmIpel6Wa2lcGMp15
 gSKGQs5sy8/S4O66LC6xamlA0pJpQcBwf81PtWFIrFTEbOBvSyS/J0V1gz5cPon2e68QSrC9t+D
 bvUwRIU+hMzErGqsXOXyEOvuSADr1e7uDtz0+i0Ix7GO9NPfrTqDN64cHp/DE/tkgqaPDQSHGuy
 qMlT4ZEBF1pa9NiUe6xu7KHFf0IPofGpyARhMJoPQkV5QIJt7vtKfzzdWHp9GMaONv6NKla6prr
 c37+BccHfgxyYmI2SC5doQkdtht1H0tuf5/LmNBTAMdoz913UjBQwosXZ4MNac7OPNKEb5IAhs/
 g0wWtRUB/xecN/EhfI0LziQMfrn6UiJZGFLNAlB+4EGUaVo2TBwBCIF3N3K61t4t017jhjwYjG+
 O1yYVxsnk/BSIdUfKtf52WKCEPKxRf2uevKQhZnqBKDEWUki54EPZjXw1cpkKCYa5IYsJcO6Xaz
 RjkVW5rVkPx+WZ0H3rA5pu/Se1Us7w=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-Mailman-Approved-At: Thu, 20 Aug 2026 13:07:05 +0000
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

SpacemiT external-voltage pins use different drive strength tables for
1.8V and 3.3V. The selected power source therefore needs to be known
before programming the drive strength. But pinctrl_generic_set_state()
applies pin configuration properties according device tree order, which
lead to configure drive-strength before power-source.

Add a vendor specific set_state() callback that applies the supported
properties in a fixed order, ensuring that power-source is configured
before setting drive strength.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/pinctrl/spacemit/pinctrl-k1.c | 166 +++++++++++++++++++++++++++-------
 1 file changed, 131 insertions(+), 35 deletions(-)

diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index 9c0fa4badc2..469c41c40c8 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -439,8 +439,8 @@ static const struct pinconf_param spacemit_pinconf_params[] = {
 	{ "bias-disable",	PIN_CONFIG_BIAS_DISABLE,	0 },
 	{ "bias-pull-down",	PIN_CONFIG_BIAS_PULL_DOWN,	1 },
 	{ "bias-pull-up",	PIN_CONFIG_BIAS_PULL_UP,	1 },
-	{ "drive-strength",	PIN_CONFIG_DRIVE_STRENGTH,	U32_MAX },
 	{ "power-source",	PIN_CONFIG_POWER_SOURCE,	U32_MAX },
+	{ "drive-strength",	PIN_CONFIG_DRIVE_STRENGTH,	U32_MAX },
 };
 
 static void spacemit_set_io_power_domain(struct udevice *dev,
@@ -472,16 +472,59 @@ static void spacemit_set_io_power_domain(struct udevice *dev,
 	writel(val, priv->regs + IO_PWR_DOMAIN_OFFSET + offset);
 }
 
+static enum spacemit_pin_io_type spacemit_get_pin_io_type(struct spacemit_pinctrl_priv *priv,
+							  unsigned int pin)
+{
+	int i;
+
+	for (i = 0; i < priv->nr_io_pins; i++)
+		if (priv->io_pins[i].pin == pin &&
+		    priv->io_pins[i].io_type != IO_TYPE_EXTERNAL)
+			return priv->io_pins[i].io_type;
+
+	return IO_TYPE_1V8;
+}
+
+static int spacemit_set_pin_power_source(struct udevice *dev, unsigned int pin,
+					 unsigned int power_source)
+{
+	struct spacemit_pinctrl_priv *priv = dev_get_priv(dev);
+	enum spacemit_pin_io_type io_type;
+	int i;
+
+	switch (power_source) {
+	case PIN_POWER_STATE_1V8:
+		io_type = IO_TYPE_1V8;
+		break;
+	case PIN_POWER_STATE_3V3:
+		io_type = IO_TYPE_3V3;
+		break;
+	default:
+		dev_err(dev, "Invalid power source (%d)\n", power_source);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < priv->nr_io_pins; i++) {
+		if (priv->io_pins[i].pin != pin)
+			continue;
+
+		priv->io_pins[i].io_type = io_type;
+		spacemit_set_io_power_domain(dev, pin, io_type);
+
+		return 0;
+	}
+
+	return 0;
+}
+
 static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 				unsigned int param, unsigned int argument)
 {
-	struct spacemit_pinctrl_data *data;
 	struct spacemit_pinctrl_priv *priv = dev_get_priv(dev);
+	struct spacemit_pinctrl_data *data;
+	enum spacemit_pin_io_type io_type;
 	void __iomem *addr;
-	unsigned int io_type;
 	u8 ds;
-	bool found;
-	int i;
 
 	data = (struct spacemit_pinctrl_data *)dev_get_driver_data(dev);
 	if (!data || !data->pin_to_reg)
@@ -501,14 +544,7 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 				argument ? PAD_PULLUP | PAD_PULL_EN : 0);
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
-		io_type = IO_TYPE_1V8;
-		for (i = 0; i < priv->nr_io_pins; i++) {
-			if (priv->io_pins[i].pin != pin_selector)
-				continue;
-			if (priv->io_pins[i].io_type != IO_TYPE_EXTERNAL)
-				io_type = priv->io_pins[i].io_type;
-			break;
-		}
+		io_type = spacemit_get_pin_io_type(priv, pin_selector);
 		if (io_type != IO_TYPE_3V3 && io_type != IO_TYPE_1V8) {
 			dev_err(dev, "Invalid IO type (%d)\n", io_type);
 			return -EINVAL;
@@ -517,30 +553,90 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 		clrsetbits_le32(addr, PAD_DRIVE, FIELD_PREP(PAD_DRIVE, ds));
 		break;
 	case PIN_CONFIG_POWER_SOURCE:
-		for (i = 0, found = false; i < priv->nr_io_pins; i++) {
-			if (priv->io_pins[i].pin != pin_selector)
-				continue;
-			if (argument == PIN_POWER_STATE_3V3) {
-				priv->io_pins[i].io_type = IO_TYPE_3V3;
-				found = true;
-			} else if (argument == PIN_POWER_STATE_1V8) {
-				priv->io_pins[i].io_type = IO_TYPE_1V8;
-				found = true;
-			}
-			break;
-		}
-		if (!found && argument != PIN_POWER_STATE_1V8 &&
-		    argument != PIN_POWER_STATE_3V3) {
-			dev_err(dev, "Invalid power source (%d)\n", argument);
-			return -EINVAL;
-		}
-		if (found)
-			spacemit_set_io_power_domain(dev, pin_selector,
-						     priv->io_pins[i].io_type);
-		break;
+		return spacemit_set_pin_power_source(dev, pin_selector, argument);
 	default:
 		return -EOPNOTSUPP;
 	}
+
+	return 0;
+}
+
+static int spacemit_pinctrl_apply_group(struct udevice *dev,
+					struct udevice *config)
+{
+	const struct pinconf_param *param;
+	const void *value;
+	u32 argument;
+	u32 pinmux;
+	int npins;
+	int len;
+	int ret;
+	int i, j;
+
+	ret = dev_read_size(config, "pinmux");
+	if (ret == -EINVAL)
+		return 0;
+	if (ret < 0 || ret % sizeof(pinmux))
+		return -EINVAL;
+	npins = ret / sizeof(pinmux);
+
+	for (i = 0; i < npins; i++) {
+		ret = dev_read_u32_index(config, "pinmux", i, &pinmux);
+		if (ret)
+			return ret;
+
+		ret = spacemit_pinmux_set(dev, spacemit_dt_get_pin(pinmux),
+					  spacemit_dt_get_pin_mux(pinmux));
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(spacemit_pinconf_params); i++) {
+		param = &spacemit_pinconf_params[i];
+		value = dev_read_prop(config, param->property, &len);
+		if (!value)
+			continue;
+
+		if (len >= sizeof(fdt32_t))
+			argument = fdt32_to_cpu(*(const fdt32_t *)value);
+		else
+			argument = param->default_value;
+
+		for (j = 0; j < npins; j++) {
+			ret = dev_read_u32_index(config, "pinmux", j,
+						 &pinmux);
+			if (ret)
+				return ret;
+
+			ret = spacemit_pinconf_set(dev,
+						   spacemit_dt_get_pin(pinmux),
+						   param->param, argument);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int spacemit_pinctrl_set_state(struct udevice *dev,
+				      struct udevice *config)
+{
+	struct udevice *child;
+	int ret;
+
+	ret = spacemit_pinctrl_apply_group(dev, config);
+	if (ret)
+		return ret;
+
+	for (device_find_first_child(config, &child);
+	     child;
+	     device_find_next_child(&child)) {
+		ret = spacemit_pinctrl_apply_group(dev, child);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -622,7 +718,7 @@ static const struct pinctrl_ops spacemit_pinctrl_ops = {
 	.get_pin_name		= spacemit_get_pin_name,
 	.get_functions_count	= spacemit_get_functions_count,
 	.get_pin_muxing		= spacemit_get_pin_muxing,
-	.set_state		= pinctrl_generic_set_state,
+	.set_state		= spacemit_pinctrl_set_state,
 	.gpio_request_enable	= spacemit_pinctrl_request_gpio,
 	.gpio_disable_free	= spacemit_pinctrl_free_gpio,
 	.pinmux_set		= spacemit_pinmux_set,

-- 
2.55.0

