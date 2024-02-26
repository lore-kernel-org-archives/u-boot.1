Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6776C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90C248801E;
	Mon, 26 Feb 2024 18:27:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GEruE5/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 014408800B; Mon, 26 Feb 2024 18:26:58 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86A4087FB8
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d8739ddd4so2608574f8f.2
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968403; x=1709573203; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4bfGjUSY12UuXoCnxk3IB0+8QrNsn8oVVnRQLxMOJqQ=;
 b=GEruE5/5QCtgsUlVtvCDiju7V143AAz3INbDIqGIT2hmt6QHCS4FICofPTveNaqlvN
 yVchaZa1UyPHbMAiTZ6S8ILCsdNzYKC2TZQiMhvlSl9gQK3jnd2+XMOctGWqQd+TesX3
 2W3wTm5cMt/vq8FKkp8kpNzv2b+GodGjjvS4v6lA37fcVLZP4mYXboTBop7eb8823oe5
 bP9NdtHJt1pCzyxJjrq21Om7yqJ9HuWdcv7zOISSHvdimeYO4AEKZDl6Fzv573h2n+zV
 pgxmdG6kjaOh0a5K/oMYJ32MCd8V6+7Yge51QdIzoyJafcf+YzQ3M4RFbcHYuxJKI0tq
 YilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968403; x=1709573203;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bfGjUSY12UuXoCnxk3IB0+8QrNsn8oVVnRQLxMOJqQ=;
 b=dTrDFuWJZlCYYSabhWjMI/htlW2yQs5tnODfZYn52DD7K44JJM8h3R4Gq+4ya/eamY
 tvu8WTAxx8j58fY+2xxnluY+xn6R3eWCXRbJ43S/tTYNDYFFQ1FfrqeBBhty//hMJiqX
 8Wz0a55vgYqIGntDxiDdLsqj0P4HaUNhvDAbXPDV5FudnZEzEx7mESMNf7EBNiccD3x8
 kCdAHlB8U07D1964RbgMGLvbb+n9cJmNKB+3tdxkcXpc0ZVclmvKf2e8TZsUfZ4o6eKy
 uPMbweSBVrwqxqbD4tOF2EiG4FkpE1wrmyTrYLp2nlunxxqnWHBGpnceepv2ekVYw6zs
 YCGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK3rkTfckT1Drue/jHPc3AJR4SovA64SRHQnKr1Mt2fVERArV73ru/9JUD2vrnmxWoEcMTkPJ8qWIvWWyaDPudyjxFwA==
X-Gm-Message-State: AOJu0YxCl+iq3VVAUKXm51CisiD18Z/4UJbv7hbIp7aQmM19sUpMlyLq
 +nRExErHJ21GXqgDe7BudDmlgVZY1VI7pGPBf8mO3xkQIeX00j9uGkdf0IFlYR0=
X-Google-Smtp-Source: AGHT+IG1vZYxsDTPyaofv5s4OZCyAZRg89qsSxO0nFU/qwCIXcVQXj/7f96DzgLEA66yUEHi0F2wmA==
X-Received: by 2002:a05:6000:1243:b0:33d:b32a:8acb with SMTP id
 j3-20020a056000124300b0033db32a8acbmr5326517wrx.23.1708968403019; 
 Mon, 26 Feb 2024 09:26:43 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:42 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:26 +0000
Subject: [PATCH v5 22/39] mach-snapdragon: generate fdtfile automatically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-22-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4668;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=qsVwCcVKBIhHDPA3LlNhly/wSFjfo707sJL8aVKs9H4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3f3rnAXfmfksbXHc8bdtoXbWDRuTjWN+DKxNbv41
 jq7eedMO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEvn5lZGgUnL32Y9b7eSHT
 311aHrvn/JL+qfYX3878IGgQfm0Xn2EdI8OcLP19HNEdit+3lbr01tltfbbIYEvW9hVfFWP3XF6
 asPoGAA==
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
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org> #qcs404
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 101 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index f445bed3af00..5a859aabd5c4 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -159,8 +159,108 @@ int board_init(void)
 	qcom_board_init();
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
 
@@ -187,8 +287,9 @@ int board_late_init(void)
 
 	if (status)
 		log_warning("%s: Failed to set run time variables\n", __func__);
 
+	configure_env();
 	qcom_late_init();
 
 	return 0;
 }

-- 
2.43.1

