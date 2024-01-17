Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C46C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 10:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7140C87B6D;
	Wed, 17 Jan 2024 11:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R2zFdMBC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D49E7876D3; Wed, 17 Jan 2024 11:18:19 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4AC487B59
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 11:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-337bcf021a4so948608f8f.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 02:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705486692; x=1706091492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KK+MTG5qBvrYPQEJ3Sae4BhUl6EsF8DmNxmBy31sAxs=;
 b=R2zFdMBCHNJ/4LiD6tn0n51woCmM9i71gZOrDRqFMf8+O+XIp215ZDbHtmyOK0tI2w
 hcsa+bijaj5Qe8gWImjdRGkcaLQgkXWI1m5X6RZIfZ3h8WiEz4ZcFz0j5kpJ2lHneraJ
 r9ynZfk2hgu6FIYO7/5EfFVjp8BtX0USrTB0CO0/alRTBkt0fyu1CPkzda8E0S3AUbOH
 evukYWUdUFSaq1h2gsMx8lPxRN24QmjxOIaKANFdNZkGrf+0sdGpXq9jAYrO+Un0IZ9a
 Q8T4/UrekhQKXYcBXAFzzoOMYmnU0R0+ODoZ0qtHs0Pmnj/PRRdKlHZlQqgm/UtAItBs
 WymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705486692; x=1706091492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KK+MTG5qBvrYPQEJ3Sae4BhUl6EsF8DmNxmBy31sAxs=;
 b=YvWfx9PCNh8EJaMU6fXJKtY64NbXMszPB7jRIQt7KorWP8+OoJJA3TTmGAkHkHcvXO
 6r16BZ9TcphMtVcBZj4CF/HnF/LRdAveUdqZfrWx3mvO5zFx9eNJyjzWMkAVBwJVy76D
 Cy2nl6OVhecCg3+1IG9UJ6xxtMRXz8KeM622G4QCwUZihcpx8oG1BVw3QO68rJgu7jeN
 pa1OropAbZrHpAkZO8DAW1/m3RhG+AjZdShwV/2T504nSzRVQkADLi8gBRfMp6oCypmv
 jSwHkAUKTFm61ZqXcSBL8fBUJJXsVbOJ+nUxfKNTNLKIUOFlfrFA+yIbfgS1BK6g2B5A
 hLLw==
X-Gm-Message-State: AOJu0YyjkNAHcrS9dZU8ujN/T7fcqdRkR8dFwmlaZcnWdlOgWwiguQCX
 HAfBW8DgUbuewVSpPMfnB9M=
X-Google-Smtp-Source: AGHT+IE0T5jGSHdQ+48jdM+EaDQlbxHWyb+iZaLyhpSaGnq+8xQsFWE/vxWlAZww+dUeVBDoFETJhw==
X-Received: by 2002:a5d:4bcb:0:b0:333:49a8:73ef with SMTP id
 l11-20020a5d4bcb000000b0033349a873efmr4897033wrt.6.1705486692428; 
 Wed, 17 Jan 2024 02:18:12 -0800 (PST)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 s14-20020a5d69ce000000b00337478efa4fsm1305849wrw.60.2024.01.17.02.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 02:18:11 -0800 (PST)
From: Max Krummenacher <max.oss.09@gmail.com>
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de
Subject: [PATCH v1 4/4] board: verdin-am62: set cpu core voltage depending on
 speed grade
Date: Wed, 17 Jan 2024 11:16:49 +0100
Message-ID: <20240117101743.3955852-5-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117101743.3955852-1-max.oss.09@gmail.com>
References: <20240117101743.3955852-1-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

Speed grade T requires the VDD_CORE voltage to be 0.85V if using
the maximum core frequency.

Speed grades G, K, S allow the VDD_CORE voltage to be 0.75V up to the
maximum core frequency but allow to run at 0.85V.

For efficiency in manufacturing and code maintenance we use 0.85V for
the PMIC defaults and device tree settings and dynamically adjust the
voltage in the PMIC and device tree to 0.75V for lower speed SKU to
gain more than 100mW power consumption reduction.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 board/toradex/verdin-am62/verdin-am62.c | 47 +++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index 4e912b5f32f..8b9db224069 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -13,10 +13,13 @@
 #include <fdt_support.h>
 #include <init.h>
 #include <k3-ddrss.h>
+#include <power/regulator.h>
 #include <spl.h>
 
 #include "../common/tdx-cfg-block.h"
 
+#define VDD_CORE_REG "buck1"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 int board_init(void)
@@ -49,9 +52,37 @@ int board_fit_config_name_match(const char *name)
 }
 #endif
 
+static u32 get_vdd_core_nominal(void)
+{
+	int core_uvolt;
+
+	switch (k3_get_speed_grade()) {
+	case 'G':
+	case 'K':
+	case 'S':
+		core_uvolt = 750000;
+		break;
+	case 'T':
+	default:
+		core_uvolt = 850000;
+		break;
+	}
+	return core_uvolt;
+}
+
 #if IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
+	int core_uvolt;
+
+	core_uvolt = get_vdd_core_nominal();
+	if (core_uvolt != 850000) {
+		do_fixup_by_path_u32(blob, "/bus@f0000/i2c@20000000/pmic@30/regulators/buck1",
+				     "regulator-max-microvolt", core_uvolt, 0);
+		do_fixup_by_path_u32(blob, "/bus@f0000/i2c@20000000/pmic@30/regulators/buck1",
+				     "regulator-min-microvolt", core_uvolt, 0);
+	}
+
 	return ft_common_board_setup(blob, bd);
 }
 #endif
@@ -86,6 +117,22 @@ static void select_dt_from_module_version(void)
 
 int board_late_init(void)
 {
+	int ret;
+	int core_uvolt;
+	struct udevice *dev = NULL;
+
+	core_uvolt = get_vdd_core_nominal();
+	if (core_uvolt != 850000) {
+		/* Set CPU core voltage to 0.75V for slower speed grades */
+		ret = regulator_get_by_devname(VDD_CORE_REG, &dev);
+		if (ret)
+			pr_err("VDD CORE Regulator get error: %d\n", ret);
+
+		ret = regulator_set_value_force(dev, core_uvolt);
+		if (ret)
+			pr_err("VDD CORE Regulator value setting error: %d\n", ret);
+	}
+
 	select_dt_from_module_version();
 
 	return 0;
-- 
2.42.0

