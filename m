Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80247C54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 11:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D87D87E86;
	Mon, 25 Mar 2024 12:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S8gD9/Q6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7B0287E95; Mon, 25 Mar 2024 12:47:18 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B41E187E6A
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 12:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-565c6cf4819so8838853a12.1
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 04:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711367236; x=1711972036; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqFok0A/6n3kQ7q54XIHRa5RjPjwDUF/CJ7caSw7tiM=;
 b=S8gD9/Q66GzHVoK1BGUJsfAyl6ZVA1Dl+x2QU9jHBz5ErWhiyla9/YZAyTgyFDksHE
 BbSFuBmHNLdDlyS3YT7XerhozzOcDHo3Hi8RVR3RtNjLXkIfYAPfOOntVNDe0a3VKFa4
 wDrvC8kjJ87ahyXLc1MklBpALojv0l4AUimvzJQi2fxPhjjMe74yBjMzzi/Y1rhyDkAp
 5U+DM8W2XV//0lsAR2ZjNGrzHPKpHhzsIsv4eXwRLEP9p/gW2v5g5PT+Uv1C9FVDeLDj
 yJoLo7lBLumov+rdp6oF+8gb85+vvJbTZTiYdzjl/ujLPZUzRvOv6ZHjSXmhG/La+j4P
 a3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711367236; x=1711972036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oqFok0A/6n3kQ7q54XIHRa5RjPjwDUF/CJ7caSw7tiM=;
 b=FR7JofV0BVvICA9Uv+eY4iInvMIEu3zH5AfqVoMRkwZycQPYQLi2M9jt4SyfamO77U
 oo3M/9+v7bnI2RkgfRWW6T2hQWP30hqroTtUbPzMMbQTaOmNIRTQEgoCDat+fQ45m8Ib
 CYjgjm0WqOldMPgeEVNfLbccvb1EVNM8f9eA3kEDhfvJ56jxu2tLXIX1tiOTl9PKkB90
 xK3jGQeJLxfTqS8RFfLwOlekvmPoPvP3jWFXYB0TQS35H8E1dYzDVWWG9aULddCH8Pcg
 8KTZaiAEKLn4v9psykzK1pmlTAVPQYnj9U8HDfEfjK0/bjbO+UJVMBf0SOo4Gjoqp4hl
 sx3g==
X-Gm-Message-State: AOJu0YwN17Sr3kW4og+ghBT6lQ+l+u6cRXQliy/5b8+lILHXnCJBaN+T
 o6/iUA7dmQrKhivrn/Deiyt/owR/MAGPjtziRdiwoRYP6M0pppvu3Cz9GywuIKU=
X-Google-Smtp-Source: AGHT+IHEf6GE4k4J4kKv4yG+uZBnIR560xpX0jxsyoRiHDju+Iq+oTQ1LOhP6TN9ZzOisNt+Dvy8lw==
X-Received: by 2002:a17:906:b786:b0:a47:4145:3598 with SMTP id
 dt6-20020a170906b78600b00a4741453598mr4595729ejb.20.1711367235638; 
 Mon, 25 Mar 2024 04:47:15 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:da6e:975d:104b:c525])
 by smtp.gmail.com with ESMTPSA id
 jy10-20020a170907762a00b00a461e10094asm2988864ejc.95.2024.03.25.04.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 04:47:15 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Gaurav Jain <gaurav.jain@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Breno Matheus Lima <breno.lima@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Subject: [PATCH v1 1/3] crypto/fsl: allow accessing Job Ring from non-TrustZone
Date: Mon, 25 Mar 2024 12:46:40 +0100
Message-Id: <20240325114642.3664840-2-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325114642.3664840-1-ghidoliemanuele@gmail.com>
References: <20240325114642.3664840-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Add a new kconfig option to allow non-secure world access
to the CAAM Job Ring.
This is needed, for example, when running linux without
OP-TEE services, as it's done on Colibri iMX7.

Fixes: 51f1357f3428 ("Revert "drivers/crypto/fsl: assign job-rings to non-TrustZone"")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/crypto/fsl/Kconfig |  7 +++++++
 drivers/crypto/fsl/jr.c    | 19 +++++++++++++++++++
 drivers/crypto/fsl/jr.h    |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/drivers/crypto/fsl/Kconfig b/drivers/crypto/fsl/Kconfig
index eaad19633f1d..e95675ee3e8e 100644
--- a/drivers/crypto/fsl/Kconfig
+++ b/drivers/crypto/fsl/Kconfig
@@ -62,6 +62,13 @@ config SYS_FSL_SEC_LE
 
 if FSL_CAAM
 
+config FSL_CAAM_JR_NTZ_ACCESS
+	bool "Give caam Job Ring access to non-secure world"
+	default n
+	help
+	  It is needed when OP-TEE is not used and Freescale CAAM Job Ring linux
+	  driver is used.
+
 config FSL_CAAM_RNG
 	bool "Enable Random Number Generator support"
 	depends on DM_RNG
diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
index ceb66dd6270d..203f16252159 100644
--- a/drivers/crypto/fsl/jr.c
+++ b/drivers/crypto/fsl/jr.c
@@ -673,6 +673,21 @@ static int rng_init(uint8_t sec_idx, ccsr_sec_t *sec)
 	return ret;
 }
 
+#if CONFIG_IS_ENABLED(FSL_CAAM_JR_NTZ_ACCESS)
+static void jr_setown_non_trusted(ccsr_sec_t *sec)
+{
+	u32 jrown_ns;
+	int i;
+
+	/* Set ownership of job rings to non-TrustZone mode */
+	for (i = 0; i < ARRAY_SIZE(sec->jrliodnr); i++) {
+		jrown_ns = sec_in32(&sec->jrliodnr[i].ms);
+		jrown_ns |= JROWN_NS | JRMID_NS;
+		sec_out32(&sec->jrliodnr[i].ms, jrown_ns);
+	}
+}
+#endif
+
 int sec_init_idx(uint8_t sec_idx)
 {
 	int ret = 0;
@@ -761,6 +776,10 @@ int sec_init_idx(uint8_t sec_idx)
 #if CONFIG_IS_ENABLED(OF_CONTROL)
 init:
 #endif
+#if CONFIG_IS_ENABLED(FSL_CAAM_JR_NTZ_ACCESS)
+	jr_setown_non_trusted(sec);
+#endif
+
 	ret = jr_init(sec_idx, caam);
 	if (ret < 0) {
 		printf("SEC%u:  initialization failed\n", sec_idx);
diff --git a/drivers/crypto/fsl/jr.h b/drivers/crypto/fsl/jr.h
index 4e4c4af5805f..b136cd8d05a9 100644
--- a/drivers/crypto/fsl/jr.h
+++ b/drivers/crypto/fsl/jr.h
@@ -37,6 +37,8 @@
 #define JRNSLIODN_MASK		0x0fff0000
 #define JRSLIODN_SHIFT		0
 #define JRSLIODN_MASK		0x00000fff
+#define JROWN_NS		0x00000008
+#define JRMID_NS		0x00000001
 
 #define JRDID_MS_PRIM_DID	BIT(0)
 #define JRDID_MS_PRIM_TZ	BIT(4)
-- 
2.34.1

