Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE75E668BC
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDCB6899AC;
	Sun, 24 Nov 2024 20:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h01RwCfP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FECA895B2; Sun, 24 Nov 2024 20:18:00 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DDEC8976D
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9ed49ec0f1so601870166b.1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 11:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732475878; x=1733080678; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bz0DcyHRx0hkL1S8HbghMdXXb2wIen88j5kPHngewYA=;
 b=h01RwCfPFDHTWV22o9UFcWxWSCHimU2TpqMUEZmAe6wRWC7CIwBxQT02JSeiV2MsYC
 UIsMwP4nL5hbwuJ8aecrJbftVU7x2cT9Swwc6jVsZHeGo/1yq3NgUM3KWNAebPJJM1O2
 Q8OYnlvlQuXtRk7eZkb29r9yDiU/bZLpyPxk5Ie26iS6+G1gp0n2ZshA8N83khcEnH00
 L8JMO5rMk92FQtQBCciKy35pLEkcDIDCDOmzVa+sDpNGEirTLdYiK6eKsg3e7vtzkuYD
 OPdyjuQ3MJ+iiKsG+iAlpMDRahCabSMfq7WmiJgPFT1dncTRhtMxEKjTpCdqefcQdPCo
 XuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475878; x=1733080678;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bz0DcyHRx0hkL1S8HbghMdXXb2wIen88j5kPHngewYA=;
 b=ezxb8DquBajkoHS8ZAYxjLUsxc7mj0cLENzQevwiAV3lrh9sd0zrAh4UqI/tHzbcsL
 yIsDY9ZohTj7WMu1/n1sjLr/iESn3vcTvU1FEzshlL2dmEK130f35fxSWnAB5r/tAMam
 5rc4DeRxmZWVpou9cmZvWE3lzgvQ84KAPFqtTKVYuu7N9uhjOigdjjbyPIECkdkfgeed
 h8HmcLcM+iWiVSZO8NGqRTaA6usbLud39Rfqwch5yUXOZsctOVfHrd79Xayv/Xumd1VR
 NYS9sm+4ppFvK2tWWap+7J2pk//GgOc8FxF0eQ/cHXY8A0vZZx+NJ/ppIPzpSFZ1UPZT
 aOZQ==
X-Gm-Message-State: AOJu0YxTmxzLtfm7jKWSJ1qiuAQQe/BUTko1rigfAaHN1iCCPoEMnEWk
 Yl5/kwTv6SQM0l3fz4J+GX4Cf+4NqhzNTE4nD9njgyn+ZQZ8Xhedj50NEIGEL58=
X-Gm-Gg: ASbGncvalgzdKYGhum+Ks55zeOs01cm8QWMjI1q1g1y06/TuseKeRGH9Qzghp+U/zY4
 R2vPloiTNKd6vhZrHle2LwRQ1ZsuN/jsm0Xlw/lv9WoYyBCun+sqhq9uKiPwL1UeZtSKo4Cd+Br
 r+PgfirhNMHooVgH4kIgBD/AmILsuFHFqGH6UGWF47PupIxM2le1MVWCjl0nFQ/1fSuezCwRm7X
 ljzDulpGECVorr80IyHyPmmDbLD1QHHmIMnhyfP1LZt6m2GgdYdNUHpJtqGaNjwbwmQ
X-Google-Smtp-Source: AGHT+IGvnyJFLgSd9DaHVi7T83+dmtFS8gzefugO4z08VCPf73wCNDL7GboNJXiWRgtmUFbRsaCR/g==
X-Received: by 2002:a17:907:7807:b0:aa5:38c5:c1c8 with SMTP id
 a640c23a62f3a-aa538c5c29amr372977166b.19.1732475877967; 
 Sun, 24 Nov 2024 11:17:57 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28f848sm371874566b.36.2024.11.24.11.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 11:17:57 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 20:17:52 +0100
Subject: [PATCH 10/15] soc: qcom: smem: add build infra
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-modernise-smem-v1-10-b7852c11b67c@linaro.org>
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1419;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=rqzJL5uV+UGped6diF7bdsE/hCg6rNpz2vZE9yG+F80=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTn6puSen/ufbj/a/GCB9nhPyyT18Y3L9NKkWduzu7Wa
 0r4YHi5o4SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAExk33mGH6/utnpKcqYyXVKa
 c3n5yelzb3G0J07On81il3X035vQDQz/c7L1FG9+kz53/HfzEm2TQ+or9om9eWwwp+H/2ZzO/Ip
 HEgA=
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

Build the new SMEM driver port, and select it when ARCH_SNAPDRAGON is
selected, since it will be a hard dependency for Qualcomm platforms.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/Kconfig  | 8 ++++++++
 drivers/soc/qcom/Makefile | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 4aa7833930c7..ee3d299eebe6 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -23,5 +23,13 @@ config QCOM_RPMH
 	help
 	  Say y here to support the Qualcomm RPMh (resource peripheral manager)
 	  if you need to control regulators on Qualcomm platforms, say y here.
 
+config QCOM_SMEM
+	bool "Qualcomm SMEM support"
+	help
+	  Say y here to support the Qualcomm SMEM (shared memory) client driver.
+	  SMEM is a shared memory region that is used to pass information about
+	  the hardware (e.g. DRAM layout, PMIC configuration, etc) between bootloader
+	  staged and the OS. If in doubt, say y.
+
 endif # SOC_QCOM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 78fae8bbfa16..f4102f9155a8 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_RPMH) += rpmh-rsc.o rpmh.o
+obj-$(CONFIG_QCOM_SMEM) += smem.o

-- 
2.47.0

