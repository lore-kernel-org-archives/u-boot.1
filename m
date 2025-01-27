Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4D2C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 14:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6148281436;
	Mon, 27 Jan 2025 15:59:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HKIr/ct9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4649814BD; Mon, 27 Jan 2025 15:59:24 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7793C81276
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 15:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-467a3f1e667so27397801cf.0
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 06:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737989961; x=1738594761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s472aI9s7In7zy/CUePG9P/DiVsPPFG13zP5EENinTU=;
 b=HKIr/ct9zseoOG1uOxRpvRzIdq77mADeCtRrteT0ZPEGIQZK5lR6KZMi2gfaM/ffLC
 9mpFMfGoJtPmacoIQ7SMosiSv0HJV2+RoG8oApRoIdubSY+oRBwyjgVVHs7ca2TaNz/u
 k7ZMgqTAwqzhYwiA5GatXxgEn0qz+j4BuFprObuhvQLz8uWLqtExbaLm5tDsytTi15JY
 5+pxtQv4mQeaFasE08yuXaWfdketwrjeDOlKKx8zXmqlVjsWhfnwnNX15QJ0E98BHNGG
 uWKIWlpHWi8WlXFJOjmDE7vWQ3ZNXOi2GMbHl9fOE2OGvLRQedN+8scmMmny2CFmAdVk
 /hEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737989961; x=1738594761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s472aI9s7In7zy/CUePG9P/DiVsPPFG13zP5EENinTU=;
 b=M4yOuMlvZRCkecK/wu2aNFIh7fdhHsXzUitHzAJQ3SjdRG7JUt2FoRIGrjn5ttWuKG
 GkgIxYtExcYlg1O/SovXT+31QPVwz9zwa1ZRR8qqdbXmGL8rFriARtIXwi7BVPIB66PD
 C/x1Ux6e4dSf76vEgc+vudEpg19OMsjb9qJ/TqZ3KUSPnsiNZgZc9HScaOnEPUdaL86X
 suFBcYEnPtgXGYH3m9Gjsa01Tt8u2TzRv+GjVwZk2InneC2AL0U9wecbeF8TO+xL9M4d
 0iiLtlhnfLNM6EwpG+cW/Nfg+7oSF12PAGhUT55rWsKTIHEdBhzfqCWoUQx/2U3sIA5e
 QWjw==
X-Gm-Message-State: AOJu0YzHWcTmyssIXvYtC8vct2UFYKEskZ4E2xw8j1a4W5/CTiSJ9iMP
 PuioYZGY+NBjZkh7aV76XNJiy7ZLNiOJXl4P9otNO/bb4bQSDeZvUybGn0yzZTAZvA78SFHeGrB
 Mug8=
X-Gm-Gg: ASbGncudTM7ntCd7TvS/ifCuauel3HE1tl82q1t93OEVd15vTLvULH7v96HHEdzeNKo
 5F+9jnhCQCPmvG9Bm4CWSRll1scAi7ZtXFyIBKBgUCS6FNolGtDVRwjeaurLS47sZFbcgxCJq4A
 Bw18JedgtmNaZXhe9r+NUcB+iWzTxH9yXfWsvjyJq5mU6ADIuFLQyPWgPdLmxmJRcERFkbX88ba
 NqXeDw9WGll97Ii5a+KpUlqZ5cpQKykCyvTBlpSRiz4R9lUos52Sbsvz2DvkeIrLoHMXlrgEksN
 /PlBvmb0At3IocXs5JD7ZFzfC44HXFWpIWqNQ7c9T0bV5GggdZYeRdQSvce9cMJnUFc9h9qLNMi
 xlVs=
X-Google-Smtp-Source: AGHT+IEoR0B61cdUmmfgCIsyCHTNVeXSCKJYMUDvnLmzXf9uO/xlYLTUsbyl9Aabr4oV5r4q33+JyQ==
X-Received: by 2002:ac8:7dd0:0:b0:467:4f0a:1b5d with SMTP id
 d75a77b69052e-46e12b6db1cmr536395051cf.42.1737989960919; 
 Mon, 27 Jan 2025 06:59:20 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e6689d9cbsm40945951cf.41.2025.01.27.06.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 06:59:20 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v3 3/6] tpm: add wrapper and helper APIs for PCR allocate
Date: Mon, 27 Jan 2025 06:58:48 -0800
Message-Id: <20250127145855.645845-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250127145855.645845-1-raymond.mao@linaro.org>
References: <20250127145855.645845-1-raymond.mao@linaro.org>
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

Add PCR allocate wrapper APIs for using in tcg2 protocol.
The wrapper proceeds a PCR allocate command, followed by a
shutdown command.
A system boot is required after two commands since TPM device needs
a HW reset to activate the new algorithms config.
Also, a helper function is included to determine the new bank mask
for PCR allocation by combining the status of current active,
supported and eventlog bank masks.
A new kconfig is created. PCR allocate and system reboot only
happens when the kconfig is selected, otherwise just exit with
errors.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
changes in v2
- Rename the newly added APIs.
changes in v3
- Rename tpm2_set_algorithm_mask to tpm2_scan_masks.

 include/tpm-v2.h |  21 ++++++++
 lib/Kconfig      |  12 +++++
 lib/tpm-v2.c     | 121 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index af3158f6e4..ece422df0c 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -703,6 +703,18 @@ u32 tpm2_report_state(struct udevice *dev, uint vendor_cmd, uint vendor_subcmd,
 u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
 			  uint vendor_subcmd);
 
+/**
+ * tpm2_scan_masks - Scan the bitmask of algorithms based on the
+ *		     active/supported banks and the one from eventlog.
+ *
+ * @dev		TPM device
+ * @log_active	Active algorithm bitmask
+ * @mask	Bitmask to set
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tpm2_scan_masks(struct udevice *dev, u32 log_active, u32 *mask);
+
 /**
  * tpm2_pcr_config_algo() - Allocate the active PCRs. Requires reboot
  *
@@ -730,6 +742,15 @@ u32 tpm2_pcr_config_algo(struct udevice *dev, u32 algo_mask,
 u32 tpm2_send_pcr_allocate(struct udevice *dev, const char *pw,
 			   const ssize_t pw_sz, struct tpml_pcr_selection *pcr,
 			   u32 pcr_len);
+/**
+ * tpm2_activate_banks() - Activate PCR banks
+ *
+ * @param dev   TPM device
+ * @log_active	Bitmask of eventlog algorithms
+ *
+ * Return: code of the operation
+ */
+int tpm2_activate_banks(struct udevice *dev, u32 log_active);
 
 /**
  * tpm2_auto_start() - start up the TPM and perform selftests.
diff --git a/lib/Kconfig b/lib/Kconfig
index baeb615626..0732333849 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -514,6 +514,18 @@ config VPL_TPM
 	  for the low-level TPM interface, but only one TPM is supported at
 	  a time by the TPM library.
 
+config TPM_PCR_ALLOCATE
+	bool "Re-configurate TPM algorithms in run-time (PCR allocate)"
+	depends on TPM_V2 && (MEASURED_BOOT || EFI_TCG2_PROTOCOL)
+	help
+	  This enables a detection for the dismatches of algorithms among TPM
+	  device, eventlog from previous boot stage and U-Boot support.
+	  A PCR allocate command will be sent to reconfigurate the TPM device
+	  in run-time to make sure algorithms in TPM device, eventlog and
+	  U-Boot are aligned with each other.
+	  A system reboot will be proceeded after then to activate the new
+	  algorithms.
+
 endmenu
 
 menu "Android Verified Boot"
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 045b5dd9eb..aa02a9e961 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -44,6 +44,127 @@ static int tpm2_update_active_banks(struct udevice *dev)
 	return 0;
 }
 
+static void tpm2_print_selected_algorithm_name(u32 selected)
+{
+	size_t i;
+	const char *str;
+
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
+		const struct digest_info *algo = &hash_algo_list[i];
+
+		if (!(selected & algo->hash_mask))
+			continue;
+
+		str = tpm2_algorithm_name(algo->hash_alg);
+		if (str)
+			log_info("%s\n", str);
+	}
+}
+
+int tpm2_scan_masks(struct udevice *dev, u32 log_active, u32 *mask)
+{
+	struct tpml_pcr_selection pcrs;
+	u32 active = 0;
+	u32 supported = 0;
+	int rc, i;
+
+	*mask = 0;
+
+	rc = tpm2_get_pcr_info(dev, &pcrs);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < pcrs.count; i++) {
+		struct tpms_pcr_selection *sel = &pcrs.selection[i];
+		size_t j;
+		u32 hash_mask = 0;
+
+		for (j = 0; j < ARRAY_SIZE(hash_algo_list); j++) {
+			if (hash_algo_list[j].hash_alg == sel->hash)
+				hash_mask = hash_algo_list[j].hash_mask;
+		}
+
+		if (tpm2_algorithm_supported(sel->hash))
+			supported |= hash_mask;
+
+		if (tpm2_is_active_bank(sel))
+			active |= hash_mask;
+	}
+
+	/* All eventlog algorithm(s) must be supported */
+	if (log_active & ~supported) {
+		log_err("EventLog contains U-Boot unsupported algorithm(s)\n");
+		tpm2_print_selected_algorithm_name(log_active & ~supported);
+		rc = -1;
+	}
+	if (log_active && active & ~log_active) {
+		log_warning("TPM active algorithm(s) not exist in eventlog\n");
+		tpm2_print_selected_algorithm_name(active & ~log_active);
+		*mask = log_active;
+	}
+
+	/* Any active algorithm(s) which are not supported must be removed */
+	if (active & ~supported) {
+		log_warning("TPM active algorithm(s) unsupported by u-boot\n");
+		tpm2_print_selected_algorithm_name(active & ~supported);
+		if (*mask)
+			*mask = active & supported & *mask;
+		else
+			*mask = active & supported;
+	}
+
+	return rc;
+}
+
+static int tpm2_pcr_allocate(struct udevice *dev, u32 algo_mask)
+{
+	struct tpml_pcr_selection pcr = { 0 };
+	u32 pcr_len = 0;
+	int rc;
+
+	rc = tpm2_get_pcr_info(dev, &pcr);
+	if (rc)
+		return rc;
+
+	rc = tpm2_pcr_config_algo(dev, algo_mask, &pcr, &pcr_len);
+	if (rc)
+		return rc;
+
+	/* Assume no password */
+	rc = tpm2_send_pcr_allocate(dev, NULL, 0, &pcr, pcr_len);
+	if (rc)
+		return rc;
+
+	/* Send TPM2_Shutdown, assume mode = TPM2_SU_CLEAR */
+	return tpm2_startup(dev, false, TPM2_SU_CLEAR);
+}
+
+int tpm2_activate_banks(struct udevice *dev, u32 log_active)
+{
+	u32 algo_mask = 0;
+	int rc;
+
+	rc = tpm2_scan_masks(dev, log_active, &algo_mask);
+	if (rc)
+		return rc;
+
+	if (algo_mask) {
+		if (!IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE))
+			return -1;
+
+		rc = tpm2_pcr_allocate(dev, algo_mask);
+		if (rc)
+			return rc;
+
+		log_info("PCR allocate done, shutdown TPM and reboot\n");
+		do_reset(NULL, 0, 0, NULL);
+		log_err("reset does not work!\n");
+		return -1;
+	}
+
+	return 0;
+}
+
 u32 tpm2_startup(struct udevice *dev, bool bon, enum tpm2_startup_types mode)
 {
 	int op = bon ? TPM2_CC_STARTUP : TPM2_CC_SHUTDOWN;
-- 
2.25.1

