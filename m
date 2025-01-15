Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC96C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 20:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 259F08073F;
	Wed, 15 Jan 2025 21:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wqn5No4W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6800880726; Wed, 15 Jan 2025 21:02:31 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 157888070D
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 21:02:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6d8e8445219so2390966d6.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 12:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736971347; x=1737576147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CPAcS8AbesU4wp+9xUmoruELXBuBy22bPIopVaQ1C6Y=;
 b=wqn5No4W2KXZVIsD5AAUgRZk137pKeEC9V5JKJJwJuSvtGa7ihswrGqE4tK8TgR3s7
 K4Wl3CDTUIfE6Mb5PcRlTd1wDXW/EzlUmnPjIESCE9HqWfa9l2BJvXUu9gt8q83R3XxU
 ehFz7oMrzGliMNNtkg6g+Yt4zNWzD9dtgoaWRr4+TPECB1z/rtdrDyh9xINr6+Lvibcm
 kFvsJigjCytDVVf7caSzTkakILOjO7+J76pGkSO/eoPL4BwxrRwO7MxM23fNdQ7Xm6J1
 qjya57mA7rRHCm3BssEqrkqh6QvnZxq/56TQS96dlSwOTyDN2mqpNesDq5GcCNEF2WoC
 x4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736971347; x=1737576147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CPAcS8AbesU4wp+9xUmoruELXBuBy22bPIopVaQ1C6Y=;
 b=me5hcL0hSCXqVhP0fRaPiqITKWDsIwgtey82HHzZ9RmuQ2FuPvkl2krmvMTFvEl/wy
 WpBPy3AF7OSm2FxjQobIFCxVoklCcdOyonzXM5aMpNOwMG8yg1svJgNjLLD6IAR9oqk3
 xHQB4waEuf2L5fUUTtZaG4/bp/rRaGkYXghZJH7CQPSFJ/ClWHH947u06/6I7uxnD+9Y
 DE8J61JgFydQr9LHN3gHbJG0z5D9t0pC1iRkeC/IaLOL9QA8/wi5ImMvv0861TenFQUl
 L1HrhCzQ58Ur5DODE+u7kZf7dw0RNApOZLaZ/6j3fEevroMy4TQH3rpEmopC5gvizBXN
 vqZg==
X-Gm-Message-State: AOJu0YzmvW6zr7NoRswDwK/3ApGGgVdeO0QsUV8WnXgHfdyEHVeULAJr
 vm+PNueJbHySJ1Mt7X2N4WzhV+KPtP3qapK8Oalj/m1XQ1M721uh/iqtpJuU4PsEtQ0d3cuxYCz
 aDPQ=
X-Gm-Gg: ASbGncu95LgLHkvhBIv/gol1dnHOqIaVO3Ez0jWmoECmMYRpcSIGseYqtIGohjfdwPS
 b70pasC7KpjSsiDz2fKn5ReJUnPZr9oYVbbFIAUWhjp2w8zei+fRTCZ1AXXGC5tuTotdQa+pGUz
 zv47PhNXQzuXKUeq9UZ2x9pCIHYLy01OO7T79XfA+5nQGvmbdrpbUOZbCCJhTj/Mll3JXPSgHAB
 UmOzaMSbH6pmaOjp1VlHoSnEp6iCl58Plh4SMUZ6fmZ0emFf6GfoF3kqIzLahl+XqvqcmtuJT3Y
 9Ds7nYJso+43W8hYhR26WXc1NKwwkLSIYQPEbEC9qIWfHW/pR9Y1bx8=
X-Google-Smtp-Source: AGHT+IH/CuU8N/teN1kVDXbK4YJjPQf9PxrvP/wWFug8un16KOkxFpX4IP/tNU04iXGIzMqakNS2wQ==
X-Received: by 2002:a05:6214:e83:b0:6d8:a754:9647 with SMTP id
 6a1803df08f44-6df9b1ed616mr412615086d6.17.1736971347430; 
 Wed, 15 Jan 2025 12:02:27 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade733e9sm68328686d6.82.2025.01.15.12.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 12:02:26 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 3/6] tpm: add wrapper and helper APIs for PCR allocate
Date: Wed, 15 Jan 2025 12:01:37 -0800
Message-Id: <20250115200144.951530-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250115200144.951530-1-raymond.mao@linaro.org>
References: <20250115200144.951530-1-raymond.mao@linaro.org>
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
 include/tpm-v2.h |  20 ++++++++
 lib/Kconfig      |  12 +++++
 lib/tpm-v2.c     | 121 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+)

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index af3158f6e4..79dc4a34e2 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -703,6 +703,17 @@ u32 tpm2_report_state(struct udevice *dev, uint vendor_cmd, uint vendor_subcmd,
 u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
 			  uint vendor_subcmd);
 
+/**
+ * tpm2_pcr_allocate_get_mask - Get algorithm bitmask for PCR allocate
+ *
+ * @dev		TPM device
+ * @log_active	Active algorithm bitmask
+ * @mask	Bitmask for PCR allocate
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tpm2_pcr_allocate_get_mask(struct udevice *dev, u32 log_active, u32 *mask);
+
 /**
  * tpm2_pcr_config_algo() - Allocate the active PCRs. Requires reboot
  *
@@ -730,6 +741,15 @@ u32 tpm2_pcr_config_algo(struct udevice *dev, u32 algo_mask,
 u32 tpm2_send_pcr_allocate(struct udevice *dev, const char *pw,
 			   const ssize_t pw_sz, struct tpml_pcr_selection *pcr,
 			   u32 pcr_len);
+/**
+ * tpm2_pcr_allocate() - Allocate the PCRs
+ *
+ * @param dev   TPM device
+ * @log_active	Bitmask of eventlog algorithms
+ *
+ * Return: code of the operation
+ */
+int tpm2_pcr_allocate(struct udevice *dev, u32 log_active);
 
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
index 045b5dd9eb..71abf070de 100644
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
+int tpm2_pcr_allocate_get_mask(struct udevice *dev, u32 log_active, u32 *mask)
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
+static int tpm2_proceed_pcr_allocate(struct udevice *dev, u32 algo_mask)
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
+int tpm2_pcr_allocate(struct udevice *dev, u32 log_active)
+{
+	u32 algo_mask = 0;
+	int rc;
+
+	rc = tpm2_pcr_allocate_get_mask(dev, log_active, &algo_mask);
+	if (rc)
+		return rc;
+
+	if (algo_mask) {
+		if (!IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE))
+			return -1;
+
+		rc = tpm2_proceed_pcr_allocate(dev, algo_mask);
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

