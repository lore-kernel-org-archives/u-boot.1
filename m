Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAAFC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 16:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B92B18075F;
	Fri, 17 Jan 2025 17:41:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RcevCoVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED7E080756; Fri, 17 Jan 2025 17:41:01 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B23C8075F
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 17:40:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6df83fd01cbso12044526d6.2
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 08:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737132058; x=1737736858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R966DFXPX/2VpZlqYrkuWPCg4OAwhASTx3KIjoTioDo=;
 b=RcevCoVPckm48vmYzDmN75J45NLRGur+Xv70TqNBs1Ry7plK5hdWwI5RigqFNvHcO9
 mOCNWU/WuMT7sHieKzJ8A0C9ud/9tNBNorO4W1wS8I1tKIz7b8dKhKx1XwbRfBArxIpl
 lCPftGw8TbHTw8IFeRubAEMQUhoSA2iCqPzg2rQRInVflwSWIK/pDg8DS9+Onv6ttVLa
 VKV60PnggGoFe8ZqrB3xh1Xc36f39M+tCqGfoI+tv8bMPOwIerGjMeC8pz9ktB+uGodE
 7rkiyR7Xz6nioQ1Rw/Qm7VjVWpFAUYN+u+u6iMXHuq/dZsJPiHoZj/dlebpuhxeNvFLJ
 NXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737132058; x=1737736858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R966DFXPX/2VpZlqYrkuWPCg4OAwhASTx3KIjoTioDo=;
 b=lv7z2uGiuVs7c+G3VQE+pu4ud4TOMrI3bDdeOijeYsj3VGUlQqDSGzBw807atxTIS2
 10vsQmH63zQkjbbrWftkokay1eQfJyrRE221j3MHHDHZ+AEHlsexwb2888iUYGgi48qH
 qN8dxplH66chw+cQMuFComCOZztLCmuaPkREf1OoLDjYlARz5oCRDClmJRcg95/x23B3
 5LF4B0bk1+wch1HerZEyK0jWByf2VF0eU+BHWtSJsmN3eOWXUzk/VrFnBSDdorh4ukoq
 mNxE8qT+IfsapiI+1P4QjQ52a+ByaaDS/x2sUwQ/D+gm+7CAKvgF7ooeoWQ8jc6LyW34
 BGfA==
X-Gm-Message-State: AOJu0YzfcTxLAxsbR+91w5WS7x/yp8cuXFlFkw+PDmpY3R3a/dB1H8Ua
 HUtCH+nEgIDeGXLhjDoL9RrK60ozr6uTiyodpe0dGGbXIxksQ2Dg/VQVEjuHikrfNQVvVDJE2tc
 FnfY=
X-Gm-Gg: ASbGnctj2ecGm2+jN4zmDdrSXCeX2806j6hatc2UL17e6ZXRkaqUY0YT8Vof7hWxpuN
 50CF4xe+9ehrAMwNo51sqqOJhgmsW8OMlsy+jJDU89jAIcGUpHL/ZxxiF7varjyVOCQdM7qddeY
 FLYBt+Pcx9fAIQzmXtg1QsEn2z0Ti38UWAqVbjVb+ewovxJ/M7aUUYpvo3jBN6oxuhplpgZy2/D
 la7rv9JbDGXYM45kW8XBRPFbJky5BJ9Z3tLNsF91XyElpckEO+aatTNnvnqPXHA8v4BdCbtqVm8
 svlF+tWA+8BN3cr4GFaEe7BA5vT/i+DFZQTQbplfw+THBMvc+4dM1o0=
X-Google-Smtp-Source: AGHT+IFUFaY71FoLdLm+a3iMRlTBsThz5DaLUO7kY4HAQHbdlatOrJw2OyNY88zCMMGkGNA7q6CiRA==
X-Received: by 2002:a05:6214:d63:b0:6e1:69ba:346 with SMTP id
 6a1803df08f44-6e1b21594cemr71442636d6.10.1737132058167; 
 Fri, 17 Jan 2025 08:40:58 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afbf3887sm12867746d6.9.2025.01.17.08.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 08:40:57 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 3/6] tpm: add wrapper and helper APIs for PCR allocate
Date: Fri, 17 Jan 2025 08:40:26 -0800
Message-Id: <20250117164032.88942-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117164032.88942-1-raymond.mao@linaro.org>
References: <20250117164032.88942-1-raymond.mao@linaro.org>
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

 include/tpm-v2.h |  22 +++++++++
 lib/Kconfig      |  12 +++++
 lib/tpm-v2.c     | 121 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+)

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index af3158f6e4..58085c9c59 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -703,6 +703,19 @@ u32 tpm2_report_state(struct udevice *dev, uint vendor_cmd, uint vendor_subcmd,
 u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
 			  uint vendor_subcmd);
 
+/**
+ * tpm2_set_algorithm_mask - Set the bitmask of algorithms based on the
+ *			     active/supported banks and the one from
+ *			     eventlog.
+ *
+ * @dev		TPM device
+ * @log_active	Active algorithm bitmask
+ * @mask	Bitmask to set
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tpm2_set_algorithm_mask(struct udevice *dev, u32 log_active, u32 *mask);
+
 /**
  * tpm2_pcr_config_algo() - Allocate the active PCRs. Requires reboot
  *
@@ -730,6 +743,15 @@ u32 tpm2_pcr_config_algo(struct udevice *dev, u32 algo_mask,
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
index 045b5dd9eb..0e497b2c2a 100644
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
+int tpm2_set_algorithm_mask(struct udevice *dev, u32 log_active, u32 *mask)
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
+	rc = tpm2_set_algorithm_mask(dev, log_active, &algo_mask);
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

