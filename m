Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2112C982FA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 13:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 321B66083A;
	Wed, 23 Sep 2026 13:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id viboisSpUdrF; Wed, 23 Sep 2026 13:07:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 261026067C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790168845;
	b=V4W5s7TyxUv7pfI1SrdLh07lpUAulvnl79N4irbayfuakXRZ3K8ZD2BQMGMdyEEtcLIe
	 5MnkO8ElVbFinSRl9G35eWnZcvYSJGjly1WeafS4YrO/vmo0glrCry3UmEFbZzea1Q13X
	 5C4mdH1TvOtqikbu/iwf3xibrJzohcOPz9CWQvfhs2xsFreS10mXf31VdfKkb73k8vF3u
	 Vr9DnMZ2/0mgDjGzi6KjGo0JHXUJTU5Xyc7WZCyeT7/Xl2hMMdq5nTTUDSVUDp7z/I2gx
	 yM7KCm+ymwNcENEHoS43xDoO6oNKBkfo26dH76FZ/RrhXayOYulYra4Hsv9CQ2C6D6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790168845;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/BybliXQSWH+ZkcavOxGghDgz7upOXeNBthAHaLbN/E=;
	b=CNXIfno36wM6Ij5eHMHuczeJ9yaf+7PSIB4OzWti1Vua2WPEploDV/yXkbmFGWf0uis3
	 NO9KfrFsuIkpr+Wi2QoZ2qdJIjrjj2MoTKSTv7/WnvvXQNEpu9QhWFTjhzBDV6hRAfa3+
	 kZPnaVyk0xrmHau+lOxdqNrvbRsiVAfVo2sD6sG6xGhUTADLlhiWL1xLAxFMb6iOA7RVc
	 5rMvwvEIaqQXOK0pdQTaSlhT6aZSbhNuMEd4s9FX5QbJunlrKrJZ3ERETjog52dy97tcI
	 ol8ozTGNe46WotGxkcQlCZd1hQHq76H+1G2325piJaXdKdlspi1LQJ5xAP5SKiT+MvQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790168845;
	bh=/BybliXQSWH+ZkcavOxGghDgz7upOXeNBthAHaLbN/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cOhMsbNr52baBGtkCiJxtDErhiStNo4l6I6czq3j/TfEpIQcGgKCI5WF2hW4p1e0K
	 QSW63SatnQnV+fiELQRlx70p3ZS3zLlp47H7XTbQfXOj2n4Y9vWtDHeBIX17IygQjR
	 rVRRpNxY+K6ptPqFnxvG6ZvqcpaxqE++nPrxGnQWio2Ks783kPT0c+SU5oijaWhI8h
	 PE2JuvtmX9i/QLmx9yEXa9XOwVhBVV4lRV8u97LJGJbTCnX9geBTaBpXMYN0QiuqYJ
	 jes/d1ujFpogcqZeLKXk2+K5B3c9xyaF5+NPqGA4Txns0pc4JfdJIrE0wxGh9tqeN/
	 wm5XH5bPJRD/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 261026067C;
	Wed, 23 Sep 2026 13:07:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A070C28C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 651BE404DE
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:07:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fzkM1OAyN6-k for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 13:07:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 625FA4063E
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790168842;
 b=HlMbpjQq9JjUENMvRYavbshWcL5f3+1u9S5Yhga4OAS56H4NQTVdlWCBgCcd/oalad94
 /J2ZP18QixNAdI67UQpeaiZY7TpuJ2bjh3ab5B7pkFzHmV1r2rVOywMLEiQ/4ozgE2g3S
 UqXF+vz3DE2d04zc3HmXDkKA0DSDKdTyuZBYLO16yJNR9SccIHLZ4vgzoNO/eOCEQd7q7
 q4lfrumaj/SfVsXsSeZoQTKWFU70TlQoh64BV/4EDjj0PvWWaddqqb2HhdLwB+S4x0EhZ
 75Npmp3NfSO9X08lMopby/TslW7Yezmc21IBuoraToMvZrzr0Osgo+pkbdTlbeu1HvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790168842;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=/BybliXQSWH+ZkcavOxGghDgz7upOXeNBthAHaLbN/E=;
 b=Md6pceIFZPUb/yHgFJRoSTIgmq2o2qPlkKF0L8S2i0tkvcHZ7j2i4h8zJfsSNO/gA4Wt
 Ob5yzVbsNpyCTu7udQoAJPcKrY5eqn9fqZos7TgRsqfnXNUG2gIdpXS0JhMMG6UH1u5FK
 qWzSU3JTCOnZjvuK4RGFQFMBtcEAoF6P0NxSEVv8uTic7mI+7MBimVcfL8Rgb8FcHiyhd
 77y80/iyudR6k59I+8oAzYvcav51ZdWHd8UoEiTavbZlsXYUb1sgzCXwMllJ3+JRTJBQA
 9a0L27lz1VVJPEsEzObj0K/GK2BKBWHPsudQLm2OGLiLZe49WE4mWZhRvdE/4rOWGSA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MJKyPghN; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=MJKyPghN
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 625FA4063E
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:07:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 035DD601FB;
 Wed, 23 Sep 2026 13:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00331F000FF;
 Wed, 23 Sep 2026 13:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790168839;
 bh=/BybliXQSWH+ZkcavOxGghDgz7upOXeNBthAHaLbN/E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MJKyPghN+PmpM7vYfGRRG2YkF/VVFQnNy/BdPiKdV9k1yLFy0vvCJVO3HfLMDkq9H
 fznYAzb7qncCTWcAjXG47M2Q4Y44mSBiGq3hUkGuPGpJIpZhNZoQN5LU51eFCFrXtB
 VK/0bhpcAPXNF86cY8B+a5Ed49gak5wcSc6PfqI/RC0rNPbZq1V5QCr87RoBFW9PoL
 N0Op4XGHOlrJKLPlHQQ5wpEBvgAxsIguhi+DK+AbTBdAj1JVms97dpANMHYfzS2bUE
 5lO3Sf+cTc7En0ICwpGeOpC74clQG39ZVhYhZQ98Xd5tuUkQB9bjICj1Wy1/eOnk0Q
 //Dx3QkT6ZrWg==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 23 Sep 2026 13:06:52 +0000
Subject: [PATCH v2 1/2] pinctrl: spacemit: configure drive strength based
 on power source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-01-k3-pinctrl-support-v2-1-e76a917ee252@kernel.org>
References: <20260923-01-k3-pinctrl-support-v2-0-e76a917ee252@kernel.org>
In-Reply-To: <20260923-01-k3-pinctrl-support-v2-0-e76a917ee252@kernel.org>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7097; i=dlan@kernel.org;
 h=from:subject:message-id; bh=ftQL+BhQgtNADGjtWJO5yGZhEW40b567pvFpztBV5dM=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqs879i2ZYYkrdvyGIIHVCjW7voUSjXwzk9BMs3
 DxN0N7dOTyJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarPO/RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+2R5g//QBjOnEjZyxpYycM8vmiWx/K3sAzmcMNxzXv7I9guPRG1A/gdIo4VP
 sT0XllaMz1SxL/fGW4tobPeXKetKeAyGnbAj7Wi5DmLj+t8DTYshLbAusZ27qHUsoZMgoour8O3
 FN+vvuqCdDmHNcFhaVqqezLnkUvIlFH1HKWnr6eRmeDSdskDaS7neTIbyyY1dujo5AyJKdLuavt
 +iyhLulnsh+KzdcbjxyeFpBhI9GCuubMyKJpxehZyon7URnBoPkoKsNtdiwNhxSHVqFp9wjBSJ4
 iefGmzb1mo1rfAiF8YSDBZI5i8qdiLcrHaA9qzzscHLhsP8X78fx0Ebxdo5nRTrHTdP3USBBiIU
 ikAvjvdDSYJgm5TIWyHAKAWzzrCYOT4Mo4aRoTPfHiqUCcnUIdrE6DmqNfrtMwxRU4qB0SmYtyN
 NBahbhm5BpBHyMByt3W5BMtlPIlhHCYdd6Jm+THfb7g/0lgmdksMORXzR1OViNBq+YYmVhS8y26
 d9fySq8BsBeHWiDH/GqkZdnbRe2uzcrSz3uILmhrq3PWuMIkGM3u835qttgQ+Df+wIm/tGUDWeu
 HqSmQB7SWVHPkCcvLFaqmKypiD6kAS5aWZrWfFKTMp93z6BCL4YireV1VUO8/Ow0hLX9TJr0/IT
 Tn5a33Oe3Ulug7m/smlt3rlOcIOuyM=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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
index 7d801f08d20..ff0fa3a4b18 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -441,8 +441,8 @@ static const struct pinconf_param spacemit_pinconf_params[] = {
 	{ "bias-disable",	PIN_CONFIG_BIAS_DISABLE,	0 },
 	{ "bias-pull-down",	PIN_CONFIG_BIAS_PULL_DOWN,	1 },
 	{ "bias-pull-up",	PIN_CONFIG_BIAS_PULL_UP,	1 },
-	{ "drive-strength",	PIN_CONFIG_DRIVE_STRENGTH,	U32_MAX },
 	{ "power-source",	PIN_CONFIG_POWER_SOURCE,	U32_MAX },
+	{ "drive-strength",	PIN_CONFIG_DRIVE_STRENGTH,	U32_MAX },
 };
 
 static void spacemit_set_io_power_domain(struct udevice *dev,
@@ -474,17 +474,60 @@ static void spacemit_set_io_power_domain(struct udevice *dev,
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
 	u32 mask;
-	unsigned int io_type;
 	u8 ds;
-	bool found;
-	int i;
 
 	data = (struct spacemit_pinctrl_data *)dev_get_driver_data(dev);
 	if (!data || !data->pin_to_reg)
@@ -504,14 +547,7 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 		clrsetbits_le32(addr, mask, PAD_PULLUP | PAD_PULL_EN);
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
@@ -520,30 +556,90 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
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
 
@@ -625,7 +721,7 @@ static const struct pinctrl_ops spacemit_pinctrl_ops = {
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

