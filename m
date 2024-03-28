Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB245C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2327988130;
	Thu, 28 Mar 2024 11:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cSbINvSb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DF3B88141; Thu, 28 Mar 2024 11:30:30 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 582928811D
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-513d599dbabso954653e87.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 03:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711621827; x=1712226627; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/Q33ur/4r6anSZZUOURs6YTjHP5Ol358kbWt4ShhTo=;
 b=cSbINvSb9lDb2wXIqsYCXDsQgqPgUyAsnd3k9QtYmuG8fLZwHcH6xq7JmI0b1Z6YOG
 2gZh1tcHO3BLjSlqN/FwNK9HblrwQrHqzsfeXJBU2jR2gzKxRIyLGwviNYCx3KDfcBBO
 kEtsc6a6t2z0Xt1JOZ11h7TkllYAEm+w3zy8xLG3fAzimbRRe//7FDF8X3YCIc6vDZ6p
 pxYsVoEooqQA5vxd2spglSEialmHRRoViQ8af+fsuUbVB/zgZkbr2DRwCansRHqSFN91
 bt0bAd8KLfwZPYM/FT5feKpiRObpdlByYHYRv/q3f/zh7kzPnno1vzJgOxXJMm419Q1S
 iQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711621827; x=1712226627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/Q33ur/4r6anSZZUOURs6YTjHP5Ol358kbWt4ShhTo=;
 b=uc59pPYJlgJqCngR2xLF2XXGqg8RwZ+YEH+WMx4x65GTj0DxMybqLjfeIrdqshb+U+
 NMvuRYgJS0YnTLyKJgWFkoVe8wbksF4Td/Hr85l3up+qNhZ1zWk0mDSw9g3tCc1BgMP1
 kItHBYDWfUbCqzC0Cu05/B33HaZ8WzGmYj41WVN662n8IKN0UuU5ZaEHEC5z8sYlWvGj
 vPb96Qmv8Wu5HkC20tTIvpDxaQygO6oAT7B8jvXvH8SFvQdt6G0M7KQY4CVRFQH5DNpg
 qnNXZlF5hgRAQile7amlOLU08PlUDatMSHCWMDzRwfBvircl0OazgXDmpR/zxCAV/UA4
 jBVg==
X-Gm-Message-State: AOJu0YyI5SpcVmFaWa3OwtufDktMsywA8Rs2oGccI0LDo9XQlXo4UAAv
 OFnxKkwgqQ1/6HwIer3x9T/1kVTXKdyVeWKFWP9HyBOwdc40/mloiymb2xLHJs8=
X-Google-Smtp-Source: AGHT+IGyWedL+kE2X1UBRJ8PRyn/xdieq+qhgYzBiGQaUOhYa+N3uwecPsiyLudNEkvdf/xXZSad0w==
X-Received: by 2002:a05:6512:712:b0:515:8bde:56c3 with SMTP id
 b18-20020a056512071200b005158bde56c3mr1641086lfs.26.1711621826412; 
 Thu, 28 Mar 2024 03:30:26 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:baf6:ec90:82d5:a261])
 by smtp.gmail.com with ESMTPSA id
 s2-20020aa7cb02000000b0056c0d96e099sm653099edt.89.2024.03.28.03.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 03:30:26 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Gaurav Jain <gaurav.jain@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Breno Matheus Lima <breno.lima@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Subject: [PATCH v2 1/3] crypto/fsl: allow accessing Job Ring from non-TrustZone
Date: Thu, 28 Mar 2024 11:30:12 +0100
Message-Id: <20240328101724.127371-2-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328101724.127371-1-ghidoliemanuele@gmail.com>
References: <20240328101724.127371-1-ghidoliemanuele@gmail.com>
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
 drivers/crypto/fsl/Kconfig |  6 ++++++
 drivers/crypto/fsl/jr.c    | 19 +++++++++++++++++++
 drivers/crypto/fsl/jr.h    |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/drivers/crypto/fsl/Kconfig b/drivers/crypto/fsl/Kconfig
index eaad19633f1d..294e1c8a44ef 100644
--- a/drivers/crypto/fsl/Kconfig
+++ b/drivers/crypto/fsl/Kconfig
@@ -62,6 +62,12 @@ config SYS_FSL_SEC_LE
 
 if FSL_CAAM
 
+config FSL_CAAM_JR_NTZ_ACCESS
+	bool "Give CAAM Job Ring access to non-secure world"
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

