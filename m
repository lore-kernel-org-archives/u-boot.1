Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3005C48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62D5687F18;
	Thu, 15 Feb 2024 21:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qtWe1h1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C5A487EDB; Thu, 15 Feb 2024 21:53:35 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FB6387E79
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-411f165ef9bso11514475e9.0
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030366; x=1708635166; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YRKiJv9Pjl1OknnSRiUDn+XASB9h9J25v+zkVE7TQnk=;
 b=qtWe1h1D3qmnKeAYgqQya6Z2Y9uPEJO/xNPOqb2yxJwU4v0wQ60pOmRE4JQYuzJE2d
 6hk6HoIp2bbznKhOKnX8mr200tsdFqCbz6nqosoXLlNv4T4vmW9K/oxhLmfNH5pJ17HP
 W/epnQEd3TBvBracTlMWYJ7RSudSkVeX/Ix8xpDdg3AQstKLm1SAfVauzchz8wWrSeYf
 sQ6E+crm2Fd3ndeEI80Io6fGM/Wp9lbVfizRvTsbUGcdiyB3od1m3mP8KqATv6KPuTFR
 BrcyX494ayQ/x2DX8+FA3pMbaaSVzChKT8HnIBHnUFDtCLsim3IbMqXD8Gee6IeZlclB
 lsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030366; x=1708635166;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YRKiJv9Pjl1OknnSRiUDn+XASB9h9J25v+zkVE7TQnk=;
 b=KnTxsylWxi5AOH99l7BdLHbdmIp0kF0021vXREHH/WKsFumIkgVBURJsjZS1QlcUjp
 fbpSjATP4oePW/TMSEVf4LDjVspo395UQq1C/8Cij93jdyvYm2MAZSKdFTTbwXoG1Edh
 wn7ViFkQqYJ8pUNvOc2WrU1kGsaAqn64SrxG18WSUQTsFiU++SAuvMg2/F2DGSTwoU0B
 C7+/StHKTC8nwlP5t86Pa2fWSXwT7HjZv6+KiBWfRF4lmGBdjhRQWNghW95yuRF3kEUM
 w2XXr7IyJ0OMwt+MO/2eyWHKVWWOoOzd+Kc1cj3h2/hclBrCuyLxUjj/1xici0JKEiMg
 CxWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXa56qIIPMiw4HhZ9KeXzDJOdBRUomGTcdsy4bAMMgTzRD/B/Uf5pqzwmRsBB8l+S3EebLPPxlOtnU2LbqQBZofHijHA==
X-Gm-Message-State: AOJu0YwyBqBHbgb+Xbez7/sWXv5UklgjLzgf3geIFu26TqEKl35eFDyw
 ZLGqnIOWK0hh8ojw9YZ9apKmUdlutbkE63YLXdduEioeEXNsJtR5+GXO5apW6JZB7ngVK6fyj6q
 5
X-Google-Smtp-Source: AGHT+IGVuWrvKyeKuCrL48UGxbRlyjfgKhsOxc/5jggOxfhVNtCm9tTodR4dpmPUIKYGpxdKze1Dbg==
X-Received: by 2002:a05:600c:4fc4:b0:412:913:5484 with SMTP id
 o4-20020a05600c4fc400b0041209135484mr2391362wmq.11.1708030366761; 
 Thu, 15 Feb 2024 12:52:46 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:46 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:40 +0000
Subject: [PATCH v4 22/39] mach-snapdragon: generate fdtfile automatically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-22-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=4532;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=I38G8hjXtbsqscXMDAJjXf3TEey9oOi1xhEVCt+IxSU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzlW1cX3QV3D87XTu0zf7V9EdxQoo8Chc+dxd0mpz7O
 8dALOtYRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhIPjfDf7cV8y7Ir94czWHq
 uO1dR/+HPrslue03OOQ+zsxetD9nqiLDH/6QCTvnfY5STuH8rF3/bf/OMnmx32r5Hz5ozHu8YlX
 ui+0A
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

With just a few basic rules, we can generate the $fdtfile environment
variable to match the format used in Linux. This uses the root
compatible property inside u-boot, with specific handling for the
Dragonboard845c which is a special case, and for the qrb robotics
boards.

This is known to work on supported platforms, and lets us avoid having a
big lookup table.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 101 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index f445bed3af00..5a859aabd5c4 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -160,6 +160,106 @@ int board_init(void)
 	return 0;
 }
 
+/* Sets up the "board", and "soc" environment variables as well as constructing the devicetree
+ * path, with a few quirks to handle non-standard dtb filenames. This is not meant to be a
+ * comprehensive solution to automatically picking the DTB, but aims to be correct for the
+ * majority case. For most devices it should be possible to make this algorithm work by
+ * adjusting the root compatible property in the U-Boot DTS. Handling devices with multiple
+ * variants that are all supported by a single U-Boot image will require implementing device-
+ * specific detection.
+ */
+static void configure_env(void)
+{
+	const char *first_compat, *last_compat;
+	char *tmp;
+	char buf[32] = { 0 };
+	/*
+	 * Most DTB filenames follow the scheme: qcom/<soc>-[vendor]-<board>.dtb
+	 * The vendor is skipped when it's a Qualcomm reference board, or the
+	 * db845c.
+	 */
+	char dt_path[64] = { 0 };
+	int compat_count, ret;
+	ofnode root;
+
+	root = ofnode_root();
+	/* This is almost always 2, but be explicit that we want the first and last compatibles
+	 * not the first and second.
+	 */
+	compat_count = ofnode_read_string_count(root, "compatible");
+	if (compat_count < 2) {
+		log_warning("%s: only one root compatible bailing!\n", __func__);
+		return;
+	}
+
+	/* The most specific device compatible (e.g. "thundercomm,db845c") */
+	ret = ofnode_read_string_index(root, "compatible", 0, &first_compat);
+	if (ret < 0) {
+		log_warning("Can't read first compatible\n");
+		return;
+	}
+
+	/* The last compatible is always the SoC compatible */
+	ret = ofnode_read_string_index(root, "compatible", compat_count - 1, &last_compat);
+	if (ret < 0) {
+		log_warning("Can't read second compatible\n");
+		return;
+	}
+
+	/* Copy the second compat (e.g. "qcom,sdm845") into buf */
+	strlcpy(buf, last_compat, sizeof(buf) - 1);
+	tmp = buf;
+
+	/* strsep() is destructive, it replaces the comma with a \0 */
+	if (!strsep(&tmp, ",")) {
+		log_warning("second compatible '%s' has no ','\n", buf);
+		return;
+	}
+
+	/* tmp now points to just the "sdm845" part of the string */
+	env_set("soc", tmp);
+
+	/* Now figure out the "board" part from the first compatible */
+	memset(buf, 0, sizeof(buf));
+	strlcpy(buf, first_compat, sizeof(buf) - 1);
+	tmp = buf;
+
+	/* The Qualcomm reference boards (RBx, HDK, etc)  */
+	if (!strncmp("qcom", buf, strlen("qcom"))) {
+		/*
+		 * They all have the first compatible as "qcom,<soc>-<board>"
+		 * (e.g. "qcom,qrb5165-rb5"). We extract just the part after
+		 * the dash.
+		 */
+		if (!strsep(&tmp, "-")) {
+			log_warning("compatible '%s' has no '-'\n", buf);
+			return;
+		}
+		/* tmp is now "rb5" */
+		env_set("board", tmp);
+	} else {
+		if (!strsep(&tmp, ",")) {
+			log_warning("compatible '%s' has no ','\n", buf);
+			return;
+		}
+		/* for thundercomm we just want the bit after the comma (e.g. "db845c"),
+		 * for all other boards we replace the comma with a '-' and take both
+		 * (e.g. "oneplus-enchilada")
+		 */
+		if (!strncmp("thundercomm", buf, strlen("thundercomm"))) {
+			env_set("board", tmp);
+		} else {
+			*(tmp - 1) = '-';
+			env_set("board", buf);
+		}
+	}
+
+	/* Now build the full path name */
+	snprintf(dt_path, sizeof(dt_path), "qcom/%s-%s.dtb",
+		 env_get("soc"), env_get("board"));
+	env_set("fdtfile", dt_path);
+}
+
 void __weak qcom_late_init(void)
 {
 }
@@ -188,6 +288,7 @@ int board_late_init(void)
 	if (status)
 		log_warning("%s: Failed to set run time variables\n", __func__);
 
+	configure_env();
 	qcom_late_init();
 
 	return 0;

-- 
2.43.1

