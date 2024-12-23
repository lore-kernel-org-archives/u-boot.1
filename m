Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088F9E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 07:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99A5A806DC;
	Mon, 23 Dec 2024 08:07:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="er4DAacr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31099806D3; Mon, 23 Dec 2024 08:07:16 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2787D80655
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 08:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d3bbb0f09dso6392010a12.2
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 23:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734937633; x=1735542433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdkPJ6qBAKsND2sFuGCMeH0/ObZSgwnNcp0TiSCR7A8=;
 b=er4DAacrzsyPzL9qH4krC9SZ5i0fgces9IliKNgfr9ffZ92SIBwTLDLyYZcP6r+M+d
 Gn9epLhV5S6wYaX30XFONWbdMuAiZoMZ3Fm/FxZHAf+kVNyUJK+uWAxov+KtgqGa7o4J
 P4LpLg9EOK/3FmeXgPPLmTS3Y5XmYlDs/zWE7EgHTHLpPCFwwXfyvHTEz0zsLc3JISnl
 Jdw8uFByAd8tI2sxmZKRWJ5rd9oxu/+a3bDzCfgD8wb5YzI9TctxbAWtZyFxTA//yQFU
 BymxnyA+lk2d/XFvprRPvAKVS1/Iv8qcWtC0mwY7abKwdGnkQliLKY6Q70cNEEcze5iB
 ui3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734937633; x=1735542433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CdkPJ6qBAKsND2sFuGCMeH0/ObZSgwnNcp0TiSCR7A8=;
 b=qfKPHYKgNoVR4cTZhjESXj8dheRfPcwIIkk/MiwHaE9tnPhEgDmgGxByEH8qicXdqy
 3mUYDtWA7wS01nxmQw7GsIkbJtgvuhONdK1QARSPgEPF4Z91qhbONzPqSaEIpDL/3i2E
 jA6WqympVCiza9Rrn996D0+chn96zjqrap3amGiAiFzCegUivuoK0mi54JUB8aT/imD5
 THQS2l1cvj549+GuMhf7BcoWxH+5XogaPGdj+x75kVeCBtmLa45TBs3nJtUWCMn0uSjt
 7hnPe4VHwkSJw3CKEGYC7SyWWwwsCksVLo/xvLf3LCGbW1s04g73h9nm+lRK2AQ3T+zJ
 GMsA==
X-Gm-Message-State: AOJu0Yye10ndAK66GMiXLjvBJ7S5gXd5WsK+SXRB6GTp5dLrZPi7VESt
 IYmNNhhV4uRL80JDpBmihzA/HpP9TKuHuJG6iE5qwam5Rzu1ZRTn
X-Gm-Gg: ASbGncvbQR4+i8dihf2mXU3BAx5FcaA7NSsx1W4CTOqTIgW+/7dKdahlb0kqOQ54ryK
 kTTnMmU9/QJXwgGW/e03529xta6AgBqNMENjt1rC/Ziw96N1XDbSDvJHntH3C/kgP2l4uFzuV5a
 584uJ+NzLYxuV1wxkiwINLTqNKyszB2I2cXYai6UPju6sFqlTQfi9P1C3mYwlhcp8hyX4eFI8Qv
 ViblB93PwbgMZE+WPEwnvPrGYPWcA3TaYPhKgQrAZvSknQY
X-Google-Smtp-Source: AGHT+IEQG886OhkbWsRuKJEdFUTnhsEdDVZiD9j9UoJP0ikEPzz/rVzNe1ha3hvDpjZfC2XLzZYLBA==
X-Received: by 2002:a05:6402:2794:b0:5d3:d8bb:3c5c with SMTP id
 4fb4d7f45d1cf-5d81ddf3bd5mr10660790a12.12.1734937633164; 
 Sun, 22 Dec 2024 23:07:13 -0800 (PST)
Received: from xeon.. ([188.163.112.67]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80678c8dbsm4511895a12.40.2024.12.22.23.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 23:07:12 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/7] pinctrl: tegra: add Tegra K1 support
Date: Mon, 23 Dec 2024 09:06:32 +0200
Message-ID: <20241223070638.35748-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241223070638.35748-1-clamor95@gmail.com>
References: <20241223070638.35748-1-clamor95@gmail.com>
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

Tegra 124 is fully compatible with existing Tegra pincontrol
driver, but it needs a specific MIPI PAD control pinconfig.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra124/pinmux.h |  4 ++
 drivers/pinctrl/tegra/pinctrl-tegra.c       | 56 +++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm/include/asm/arch-tegra124/pinmux.h b/arch/arm/include/asm/arch-tegra124/pinmux.h
index 3aba17d21e4..fbe15fc612d 100644
--- a/arch/arm/include/asm/arch-tegra124/pinmux.h
+++ b/arch/arm/include/asm/arch-tegra124/pinmux.h
@@ -578,6 +578,10 @@ static const char * const tegra_pinctrl_to_drvgrp[] = {
 	[PMUX_DRVGRP_AO4] = "ao4",
 };
 
+static const char * const tegra_pinctrl_to_mipipadgrp[] = {
+	[PMUX_MIPIPADCTRLGRP_DSI_B] = "mipi_pad_ctrl_dsi_b",
+};
+
 static const char * const tegra_pinctrl_to_func[] = {
 	[PMUX_FUNC_DEFAULT] = "default",
 	[PMUX_FUNC_BLINK] = "blink",
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index ad7112a05e6..e6b957f5537 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -67,6 +67,58 @@ exit:
 	kfree(drive_group);
 }
 
+#ifdef TEGRA_PMX_SOC_HAS_MIPI_PAD_CTRL_GRPS
+static void tegra_pinctrl_set_mipipad(struct udevice *config, int padcnt)
+{
+	struct pmux_mipipadctrlgrp_config *mipipad_group;
+	int i, ret, pad_id;
+	const char *function;
+	const char **pads;
+
+	mipipad_group = kmalloc_array(padcnt, sizeof(*mipipad_group), GFP_KERNEL);
+	if (!mipipad_group) {
+		log_debug("%s: cannot allocate mipi pad group array\n", __func__);
+		return;
+	}
+
+	/* decode function id and fill the first copy of pmux_mipipadctrlgrp_config */
+	function = dev_read_string(config, "nvidia,function");
+	if (function)
+		for (i = 0; i < PMUX_FUNC_COUNT; i++)
+			if (tegra_pinctrl_to_func[i])
+				if (!strcmp(function, tegra_pinctrl_to_func[i]))
+					break;
+
+	mipipad_group[0].func = i;
+
+	for (i = 1; i < padcnt; i++)
+		memcpy(&mipipad_group[i], &mipipad_group[0], sizeof(mipipad_group[0]));
+
+	ret = dev_read_string_list(config, "nvidia,pins", &pads);
+	if (ret < 0) {
+		log_debug("%s: could not parse property nvidia,pins\n", __func__);
+		goto exit;
+	}
+
+	for (i = 0; i < padcnt; i++) {
+		for (pad_id = 0; pad_id < PMUX_MIPIPADCTRLGRP_COUNT; pad_id++)
+			if (tegra_pinctrl_to_mipipadgrp[pad_id])
+				if (!strcmp(pads[i], tegra_pinctrl_to_mipipadgrp[pad_id])) {
+					mipipad_group[i].grp = pad_id;
+					break;
+				}
+	}
+
+	pinmux_config_mipipadctrlgrp_table(mipipad_group, padcnt);
+
+	free(pads);
+exit:
+	kfree(mipipad_group);
+}
+#else
+static void tegra_pinctrl_set_mipipad(struct udevice *config, int padcnt) { }
+#endif
+
 static void tegra_pinctrl_set_pin(struct udevice *config, int pincnt)
 {
 	struct pmux_pingrp_config *pinmux_group;
@@ -170,6 +222,9 @@ static int tegra_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 		if (!strncmp(name, "drive_", 6))
 			/* Drive node is detected */
 			tegra_pinctrl_set_drive(child, ret);
+		else if (!strncmp(name, "mipi_pad_ctrl_", 14))
+			/* Handle T124 specific pinconfig */
+			tegra_pinctrl_set_mipipad(child, ret);
 		else
 			/* Pin node is detected */
 			tegra_pinctrl_set_pin(child, ret);
@@ -236,6 +291,7 @@ static int tegra_pinctrl_bind(struct udevice *dev)
 static const struct udevice_id tegra_pinctrl_ids[] = {
 	{ .compatible = "nvidia,tegra30-pinmux" },
 	{ .compatible = "nvidia,tegra114-pinmux" },
+	{ .compatible = "nvidia,tegra124-pinmux" },
 	{ },
 };
 
-- 
2.43.0

