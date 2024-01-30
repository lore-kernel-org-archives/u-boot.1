Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CD2C47DDF
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20FDD87E9D;
	Tue, 30 Jan 2024 15:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LeJ+EwGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D901387DFB; Tue, 30 Jan 2024 15:05:39 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7EEA87DFC
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50eac018059so4657387e87.0
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623528; x=1707228328; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6x9MvgyokiXyR0iPLqVNfv6b8IjH1ppokOmF5Xx6h9o=;
 b=LeJ+EwGe0nJ1qkSWYlna703QNCNa/DIO6+pG7xRtRQ8VEP8wFPtkxBhJt5+DTP35Hr
 SM8v0ZDEW7D1NDP3yF1bQh/VnTh1l7dbVvfnp4Y/oVZrCckisuYz+owEPQVYZm946ptp
 /ZI7X/cAZY1napwBHOL8jLRplNT9OdHQLbXbOquL6kZvVQTnJGsn6Hd9Rgb8qBDYIrmu
 G2cygAz08PF1H5C5Q95b4l96CZkBrsc79VJ2XhnWsFu5364OSY+jjSxhmZvbfL2XmWgg
 i6IVqMt5DRgnlokN0ywSdXudtXzll93ten5ck2DGk+7HnT59tCGcwzSTQzxcE0Jsar0y
 gPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623528; x=1707228328;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6x9MvgyokiXyR0iPLqVNfv6b8IjH1ppokOmF5Xx6h9o=;
 b=ugHXj/iUWie5/c30VeMBoI+XkrARMcXLodiWnZm+z0WxdBRU7sL6LTUCV8tmm9uafc
 qvUHDZLOnZlLrGo6x9mr6Zn3MnH56xFwS1D3RgxShHtVkK8d36rqpvUTVGR/fhv042hu
 /YkYCA6KVu76LKFYIA+KNF0gcObAyfWQCHcBk4Ggj7argnsIq8Twq+FgvmEognLXZtnN
 9KrVeTOsB5cSlFqH4+3MGWhcZxxnUy1B0mCFPfAbBGbfJOUtsEBIZa8rjocb7btS5Ahq
 jKy2/FxuDyGg7Ys97qNvyJhNwSnT8HorGLFgZ//0RYYIVFrtDl0iUOJ2R9Q4dvL440k0
 c+Dg==
X-Gm-Message-State: AOJu0YzwFBUQHXJdbYAHtKj7gdaPUWwkT1kwLrjD9DU7eF8+Nmid8a59
 DjTAOnrxkQR1LQeC6TvfYU33e/jLwuMlMLeaVve6t/9KnnogJJd7o1kGL7HTylI=
X-Google-Smtp-Source: AGHT+IETdeEyHvSOQWDH9SVvIPHA9MOxCjOtkUed8gr/fJQPYoVF/CL3IiuQv+Ny5lHONr+pEYa7vw==
X-Received: by 2002:ac2:5319:0:b0:510:1620:939b with SMTP id
 c25-20020ac25319000000b005101620939bmr5512014lfh.0.1706623528120; 
 Tue, 30 Jan 2024 06:05:28 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:27 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:05:07 +0000
Subject: [PATCH v3 19/36] mach-snapdragon: generate fdtfile automatically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-19-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
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
 bh=mca0p4WTJ0abRTF25uup8zemVxUZi6uZ7B4bsUne0N8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTIIXzjwtz9vAk8tlHjW/TaJcpMNWQH53uNOHF4pm9
 hUhjZM7SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwESeODL8j7m6yMSaX8Tdh3up
 jbiCy2aGFfuvnJf8N8XdI2m94NIAM4b/CT2v/u6reCqxZW37bTcB+TJduZVLP9wXEGpv0Uop4Np
 vAAA=
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
index 3f51c4ab42d6..9d8684a21fa1 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -161,6 +161,106 @@ int board_init(void)
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
@@ -189,6 +289,7 @@ int board_late_init(void)
 	if (status)
 		log_warning("%s: Failed to set run time variables\n", __func__);
 
+	configure_env();
 	qcom_late_init();
 
 	return 0;

-- 
2.43.0

