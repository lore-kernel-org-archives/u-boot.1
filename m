Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D075C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F58887837;
	Tue, 19 Dec 2023 17:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KlCP8Gdf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57E81877CB; Tue, 19 Dec 2023 17:04:59 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B6DC87767
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d22d3e751so5554055e9.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001880; x=1703606680; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CqYLQiJnv+GrBww6Eo/HLRc1qaI4dDGGvAdJahExWrk=;
 b=KlCP8Gdfc7Q1aTEqpKTPGPucELGA3hV2fl+HZiQ+uOsLP2BKqoGr5qzIK+7ur2v5pY
 MvWYqBv0Ad1qrWW6Y3WYcXOcmANzE/7vE4FzHtZQNQ0Km3oqXPIOsGkIMzt1hJgVwb/I
 rrs/BvHuGhm3AnJOjllw6PdEUXeCgPMGATtrtryCycujEt+XiJ6HSY+ibFb3XPAfnrWn
 B9s/bI8tV6ZrEJ2/LR0wWLu/CQfTWkIoVAGPfsgtZMqrI328gAV/F5UOQCOZMxJebuE7
 ofX8hiTGqSSnDIwBqd9C+qOI5F5JTKXqySGULSZMUGZ6OBn5KcbiYINhiI3jcBLSuMn7
 P+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001880; x=1703606680;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CqYLQiJnv+GrBww6Eo/HLRc1qaI4dDGGvAdJahExWrk=;
 b=GckBqr8gtle8Fhw03QzpHOFi3JBqidIraBuUU+xl6OrMAUyjF8k71zJ/FIB+5TJ736
 tWjwvAuh0TuFT9yDtVcNqrZl7x7yFXs4wgsXi7TxnZO9g5Uw2JFjnzHrWDpi4ymyyJSD
 1KJJJNKMKDZFh4ol4JwDiA8tMJwhInUeCs1ocYUqXax/Jl/2mf4C3znsUHmfy/8RE5lA
 LquUvr30vWi9eT0DMpTWXWvfEabHKzoFD0wrl/K7IC56fN+QsOjQhQRH56cJubrLUo6O
 uTMoCJGfI9/TGDt5o5/4HxAKrdfuh/VStS1u7kOYhSHxxXzWvzjVOyVWjDAcQKoz1KWc
 uXjQ==
X-Gm-Message-State: AOJu0Yz3xhR2rP3cecbvbOlIB2QZwBcmiw4y1ErAbxepwI8Y4eHq9LmL
 eGnhVJXgix4IElQNiDaT0hNS9g==
X-Google-Smtp-Source: AGHT+IGzrBgh1dcVaYmt7jIHqd4LZsglFzVSqtX4Wx5snp614zWDjfafDiDiJsOuLKobH2NA/ZzOuw==
X-Received: by 2002:a05:600c:3b06:b0:40d:27dd:a5f2 with SMTP id
 m6-20020a05600c3b0600b0040d27dda5f2mr558749wms.26.1703001879886; 
 Tue, 19 Dec 2023 08:04:39 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:39 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:18 +0000
Subject: [PATCH v2 17/32] mach-snapdragon: generate fdtfile automatically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-17-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
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
 bh=I2uZje4bewT+WPG0zhYg/49WJvSyjlrFAr+e9Iv5NS4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/cyMM5SmXZxwXuRmetyJ6WnbIsW2a0bdffikUUwze
 NKRw42rO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBErrIxMqwXl+c+yLto/bPt
 lleU/ysyLm0t531csHpixwTWcv13ly0ZGdb+1TLI+VUqGCz2dvJf5iNHr36eVLbu3eGVP6ftlY/
 rNjQGAA==
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
index b00f536d38b4..752166ea7563 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -113,6 +113,106 @@ int board_init(void)
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
@@ -142,6 +242,7 @@ int board_late_init(void)
 	if (status)
 		log_warning("%s: Failed to set run time variables\n", __func__);
 
+	configure_env();
 	qcom_late_init();
 
 	return 0;

-- 
2.42.1

