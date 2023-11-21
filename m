Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46293C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AA308765B;
	Tue, 21 Nov 2023 18:10:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xmpy56zk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF19A8761D; Tue, 21 Nov 2023 18:09:58 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ECB487572
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c8769edd9fso40275881fa.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586584; x=1701191384; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vGJd1cv6Nb6YoYNzL3TjBhY+N6uF5bXW2/raoD3QwKA=;
 b=Xmpy56zk6gJS6GihEO0nuYP3tSS+jmOM/Avr0BT1JgrLdTX6ND5lH3LuwMvmi4y3I8
 gA7bKoA0Cf+U6Bu+65iWGrMOAPbuklIiOl8PpHXfd3WJGYMmXPvsCGwlYPa1phzWk8DC
 3uBTWEQGu7c0AhnABO3y5TgOWc95qNDpwR6f/meXu8y+5Byjs+5UbC0Md0REUqWjg2ZZ
 bPQvU8/K6EHwOn4BrcpuEqMuPs9Vfh8dL+fYYnt7t5dVxKgC/vpSP2eyjiVmiUEr18yx
 z5uxFYUuKCNXEFkibCWY8q1Aw3+Ej7tKLw0TLHGaNOXWCppS8qeBcZGIy0NZ+U+3mi7W
 Y4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586584; x=1701191384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vGJd1cv6Nb6YoYNzL3TjBhY+N6uF5bXW2/raoD3QwKA=;
 b=RpDBUcPG1q/Vroq2sk39U1FS7Ovd+YUVsGT4w755rGNX5BXiH4YCPk7B4puaPBR0hv
 AzVN+4RAZb+30MUlYfw7iXRmz+5ItSl0geghrv6/WFna6PM2Hrs/7GRmab3IQjQQkXJ0
 7QkrOgyvgT9mOATWELL2zIQXH59RTJuoXGdSGQKMRexBgwom+LwEL8fGNsywbbL85pU9
 0RjYtUtV3DJG2Qe/N1bETPddKpFOxRUKGnx5heUMLMsFHADGAxudpYBrXm2/Z545mjvb
 +aacnimGta3NQdoC2U6dDqNQGmmpvG2UkzWykAZPq/Ter3/Ruo0Bj4hpjQ/Z+JRgMrbb
 caXw==
X-Gm-Message-State: AOJu0Yzry3rS5A0GhAiR7FZCTXQXMVTnRZkVt5MBR28IJuUpMhw+8dLi
 0QJjnVDa9oH3nTVVvGcLERcbLA==
X-Google-Smtp-Source: AGHT+IHa43O4VBfgnIQZXG/LCo+4VBh8BSC9fICDcBGagvQ/jXy5vSokZMq2WD6IJ+a1LXZGHt/n6g==
X-Received: by 2002:a2e:b748:0:b0:2c5:94a:ac96 with SMTP id
 k8-20020a2eb748000000b002c5094aac96mr7872940ljo.9.1700586583804; 
 Tue, 21 Nov 2023 09:09:43 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:43 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:38 +0000
Subject: [PATCH 15/21] mach-snapdragon: generate fdtfile automatically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-15-9492198e0c15@linaro.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4475;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=8T6nHuYKBd+6xuzE5sB2fS+mVVK4w/bB5IH+jMUD+vE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ2434r5U7v3w57xqR0mYzsGUl/euWjVlTmfbpN7II
 mf7fLFhRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhIli3D/7A316TOf+6X5uiZ
 lFc2VzMoUOv5wzomtdOsd6a0p26Y8oPhF9OL2W5ns7tn6r1ozPL7ZcKpwifIELWhdp5iw8p83lZ
 RdwA=
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 101 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 765a2c2a95fc..d142f2fddf8e 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -111,6 +111,106 @@ int board_init(void)
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
@@ -141,6 +241,7 @@ int board_late_init(void)
 	if (status)
 		log_warning("%s: Failed to set run time variables\n", __func__);
 
+	configure_env();
 	qcom_late_init();
 
 	return 0;

-- 
2.42.1

