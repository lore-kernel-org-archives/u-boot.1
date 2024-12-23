Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D93EE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 14:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 568DA80711;
	Mon, 23 Dec 2024 15:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mGqVU7sg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67B1D8074B; Mon, 23 Dec 2024 15:48:43 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2791B80771
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 15:48:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6dcf63155b0so20119806d6.1
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 06:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734965318; x=1735570118; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftR5lbR05gDbybhzxCixIlns72k8JxQ3zUrMUfVWPy8=;
 b=mGqVU7sg5WOzOAk2NGPyOqm8dnZCQ8Jz/Cn+FOlWfOED83ZyNJkWT6e9883Pn+IflV
 ZdnZIy4/xDKE0zM9hP0JIyU2eSBwTZRxC9v+tE19ex8LBcbhqsff16rhMfP3eWMqi+cO
 Oo3/gQEUanc8CZZb205EVMyRFFhOFGlCL/yQS05Qf9a39OQWNT4QJ6wmYHj3gEG8LKCp
 oN6ALfG5nkRha+pjeOtopWGJsmuU8F5wGpx5xRgp5Z+bjNbVY9BgsH+39gFu1++e4c2L
 X/BiEcplqE7bjehUtH6RP2wXZZzjkZwVnMAG96TOFswZllio68EXrKf5KL1Fj2jrwMQc
 4Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734965318; x=1735570118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ftR5lbR05gDbybhzxCixIlns72k8JxQ3zUrMUfVWPy8=;
 b=OymhZldTqmwetpMIQVA83bqkE+D78HF09sM5tpNfsJ8UR9NEFC37ZDSuSR73RZv8bl
 GI/DOVdLH6F542L55a+cBnmOkIVsqp/0lObsOMh2HntZKpTWssZ1maYdIRlhnGwUsNda
 u3SVY6tPsdFaWCr4rNUrD6t3r7ychiwC1I7ITki6JptdxL0UyMWoXMrIna23p8nmCbJp
 0apE6uvz6X+JMPwtRo+EGnzJPM/cYTnpsmZIAPRANwjluS4+yCyLkAG1yzDuRHtg1Pml
 kW61bClYnLYY602C01dID+v+qZYbMFEKLKccfsJKd7Bj/sWpnwd3iig3uEEdf16VFFPE
 vDnA==
X-Gm-Message-State: AOJu0YwDUwWiZBFktLZTtiMn/lVv+P2V9zlcPMiHbENJ7wos/pyZrHcp
 kT9j4MKI17loBatjYxK2fil4mKo1Ymr/MZIbHrptQomG4HYXYx2vx+G/xLBU3D8mp/xVH0Kk680
 T
X-Gm-Gg: ASbGnctZ/DFWvfnWQOiC3KhQwq4ZjYFg5TF1RzKhghOY7t6DgVxYx+niSE2ZAPk42Wn
 Ts5cjHtCZHxrlQApk1D5FCTn6aCmRz2xhP/i88XDb/CG19EcXkTlYnWRr4j1htKXNDyg0hpRti4
 N/KoDz7srhxi6FUXf9A1CxY8TmDCd8Vj0RqP/a1xws//f98pXkItTBb/xeIGKJaSvsR9MhmNYsc
 iVtzv5PLdu75DsOQBzAfWVvyuI5ZApSMUwnw+iYcp8lqtDATwjRSUnfje2hc0pmBfEDfQ/PJ9M8
 QccX/bR8hv81hI5WeP6PqHaTXXyYw998OtIyyIi3BHv+n/cv0m/B3hM=
X-Google-Smtp-Source: AGHT+IHejgDE5ZRMKyU6j5RycgBqCpDsT8fU2sC9x+KB+9/XPIYJ2nQwkplJSw+4QJFPXsX+A8mmEw==
X-Received: by 2002:a05:6214:2689:b0:6d8:8f14:2f5f with SMTP id
 6a1803df08f44-6dd23349b0dmr251016096d6.23.1734965317850; 
 Mon, 23 Dec 2024 06:48:37 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb519sm44243246d6.83.2024.12.23.06.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 06:48:37 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH 07/11] tpm: Keep the active PCRs in the chip private data
Date: Mon, 23 Dec 2024 06:47:29 -0800
Message-Id: <20241223144737.554992-8-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241223144737.554992-1-raymond.mao@linaro.org>
References: <20241223144737.554992-1-raymond.mao@linaro.org>
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

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

We have a lot of code trying to reason about the active TPM PCRs
when creating an EventLog. Since changing the active banks can't
be done on the fly and requires a TPM reset,  let's store them
in the chip private data instead.

Upcoming patches will use this during the EventLog creation.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 include/tpm-common.h | 18 +++++++++++++++++-
 include/tpm-v2.h     | 10 ----------
 lib/tpm-v2.c         | 27 +++++++++++++++++++++++++--
 3 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/include/tpm-common.h b/include/tpm-common.h
index 1ba81386ce..fd33cba6ef 100644
--- a/include/tpm-common.h
+++ b/include/tpm-common.h
@@ -42,12 +42,22 @@ enum tpm_version {
 	TPM_V2,
 };
 
+/*
+ *  We deviate from this draft of the specification by increasing the value of
+ *  TPM2_NUM_PCR_BANKS from 3 to 16 to ensure compatibility with TPM2
+ *  implementations that have enabled a larger than typical number of PCR
+ *  banks. This larger value for TPM2_NUM_PCR_BANKS is expected to be included
+ *  in a future revision of the specification.
+ */
+#define TPM2_NUM_PCR_BANKS 16
+
 /**
  * struct tpm_chip_priv - Information about a TPM, stored by the uclass
  *
- * These values must be set up by the device's probe() method before
+ * Some of hese values must be set up by the device's probe() method before
  * communcation is attempted. If the device has an xfer() method, this is
  * not needed. There is no need to set up @buf.
+ * The active_banks is only valid for TPMv2 after the device is initialized.
  *
  * @version:		TPM stack to be used
  * @duration_ms:	Length of each duration type in milliseconds
@@ -55,6 +65,8 @@ enum tpm_version {
  * @buf:		Buffer used during the exchanges with the chip
  * @pcr_count:		Number of PCR per bank
  * @pcr_select_min:	Minimum size in bytes of the pcrSelect array
+ * @active_bank_count:	Number of active PCR banks
+ * @active_banks:	Array of active PCRs
  * @plat_hier_disabled:	Platform hierarchy has been disabled (TPM is locked
  *			down until next reboot)
  */
@@ -68,6 +80,10 @@ struct tpm_chip_priv {
 	/* TPM v2 specific data */
 	uint pcr_count;
 	uint pcr_select_min;
+#if IS_ENABLED(CONFIG_TPM_V2)
+	u8 active_bank_count;
+	u32 active_banks[TPM2_NUM_PCR_BANKS];
+#endif
 	bool plat_hier_disabled;
 };
 
diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index 6b3f2175b7..6e9bc794f9 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -34,16 +34,6 @@ struct udevice;
 
 #define TPM2_HDR_LEN		10
 
-/*
- *  We deviate from this draft of the specification by increasing the value of
- *  TPM2_NUM_PCR_BANKS from 3 to 16 to ensure compatibility with TPM2
- *  implementations that have enabled a larger than typical number of PCR
- *  banks. This larger value for TPM2_NUM_PCR_BANKS is expected to be included
- *  in a future revision of the specification.
- */
-#define TPM2_NUM_PCR_BANKS 16
-
-/* Definition of (UINT32) TPM2_CAP Constants */
 #define TPM2_CAP_PCRS 0x00000005U
 #define TPM2_CAP_TPM_PROPERTIES 0x00000006U
 
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index bac6fd9101..bc750b7ca1 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -23,6 +23,27 @@
 
 #include "tpm-utils.h"
 
+static int tpm2_update_active_banks(struct udevice *dev)
+{
+	struct tpm_chip_priv *priv = dev_get_uclass_priv(dev);
+	struct tpml_pcr_selection pcrs;
+	int ret, i;
+
+	ret = tpm2_get_pcr_info(dev, &pcrs);
+	if (ret)
+		return ret;
+
+	priv->active_bank_count = 0;
+	for (i = 0; i < pcrs.count; i++) {
+		if (!tpm2_is_active_bank(&pcrs.selection[i]))
+			continue;
+		priv->active_banks[priv->active_bank_count] = pcrs.selection[i].hash;
+		priv->active_bank_count++;
+	}
+
+	return 0;
+}
+
 u32 tpm2_startup(struct udevice *dev, enum tpm2_startup_types mode)
 {
 	const u8 command_v2[12] = {
@@ -41,7 +62,7 @@ u32 tpm2_startup(struct udevice *dev, enum tpm2_startup_types mode)
 	if (ret && ret != TPM2_RC_INITIALIZE)
 		return ret;
 
-	return 0;
+	return tpm2_update_active_banks(dev);
 }
 
 u32 tpm2_self_test(struct udevice *dev, enum tpm2_yes_no full_test)
@@ -69,8 +90,10 @@ u32 tpm2_auto_start(struct udevice *dev)
 
 		rc = tpm2_self_test(dev, TPMI_YES);
 	}
+	if (rc)
+		return rc;
 
-	return rc;
+	return tpm2_update_active_banks(dev);
 }
 
 u32 tpm2_clear(struct udevice *dev, u32 handle, const char *pw,
-- 
2.25.1

