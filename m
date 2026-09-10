Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57212C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 290B160B21;
	Thu, 10 Sep 2026 12:14:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VwqexMb60K0P; Thu, 10 Sep 2026 12:14:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 348B7608E2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789042453;
	b=fhAUUlVaFWNcCU+6+lNSIx1LswgFyvMYoOV4NGwS6SrHK6WaKXxzO+2txywfiixG0Az0
	 JqwJ3wC9eyaAT4/OrQnikdySfpoSKkRMuxHNLJfORof+UMMZtXxlwnFJmb1Jaj+PSrt1c
	 ttlpp8ghQf/CuBKE38fyj4HA99HXmvXx33he3p8pFyoba2iGDyUInwU7Tmw5ZBcqWqrOx
	 x5LnwCPytO3rl/DvSyEP/Y6M4xsYqKZZetxlHbuEATE0Z8EG4PXE8Vw6jr1oinlZRZfhd
	 apJdn5tmX+wTblNM1wrmW04XINrPN+ZAWmF25+0gJllDp/Xb7gxGQ+nrAq1sNVW21sg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789042453;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bgdeg5YOjD/bZF9dwpOUoe/caO94irRiqbsHQaQarws=;
	b=sNMAWrGx7GQquVDcx0qCoTZEcz4D9KXy+MdMctk3bIhm54QA1Qm+8laxS0LvbzMG79Rm
	 jE8a3SEjbroySqeQvmDQiXRGuvcE6ZoP3lWCofWhYp7kAZfzvM3nbFvn+N/pw81oVrbGI
	 JVBlJj7OSK9TKYPWe7/kGVltFHU9T5vS8JPxc6UMYvBhmW565JbrQtrq5WyzOGV2AlgUO
	 BWMlJwWe2OkaQljlfLbhdm69aD/jFWcasrAj7s1lHwOEMZhq/pUAdsYXJkZjxtiJH4TAG
	 H+UOj0Y4c0rQXFUdMhCG+404mfab71/KKb5KBpNOJpycs6gCHBx603ACWKsafQhr06w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789042453;
	bh=bgdeg5YOjD/bZF9dwpOUoe/caO94irRiqbsHQaQarws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=df5wVwZmCd+9tLBsZdfR6PtIX2Pj/mrYakAQqaLFx6VhXMTgHPqC0MMS1DybX/tTE
	 9Y1HDaOXIDPMQ+YOaGoxnZV/5mH5+JQYZWdNPMBMu6nv/5oSPVpPrZad9Dt+YQt84l
	 /VGFxtFqp8x26VoY8M7IjAABQaiWqsEeGgCFRT/hYya+JrqZlWtYxXAGOBz+ThVCth
	 8tivlOtEHKENcuu9LoPvhDR3FeRUK6MKcPr9sm7qkcid+XgmbIyBW+V87PDQxCTjoL
	 356DzVQ7IqetfyJ/XOFoXWsLuocEvCTtn8RrFFNqF47aNzkLFSjbLQuC420XJKSexK
	 YTcKhy4kM2haw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 348B7608E2;
	Thu, 10 Sep 2026 12:14:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B955143F
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F49B80FE8
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jnxS3eVyqNJh for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 09:54:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 653BC80F7D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789034040;
 b=QJQRBWvPwVPFrhKY0x9S7jtIYcf1cOJRoytAw+qcjGI9TB1J9Z7CVvG98VZBXeZvjwrM
 FrpbRFMKh4KVSc77ka6GFvebuUe+lU+ByX45gbyUYdIveDX+i1j0qnrWXpGeaFK7bogEt
 4vzxB86272AsVXaEGEdRMdSBLH4knKE+kQ1SS9hgxLWEFwEtGk8MPS8xlz//MGhn9NNcS
 RuEBB19O6znEYE9E2P8HmCY+XNevwfa1XP5zvI7K7mDQQ1xjHHufqeQT9W/oyhQLzIuVH
 HO/Ik5s9/RrJVrkM6pmwyLJTkPIk7jKSj8PBJCA5phEa23pYmcshFTbwX73GZJCTHYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789034040;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=bgdeg5YOjD/bZF9dwpOUoe/caO94irRiqbsHQaQarws=;
 b=tWgVHB0TelfXxoYAjWAPl7aiRjpyIHToMoU0IEmbM7FzeOQZJN0qACnjW/Q+4Yl4NM9n
 bn4rUCYhUy6NGkev3YbCoyN5QOWjv9ug2ZNGkvYU25RI/8me1jx35l07YSfnWrcrwmjqV
 3HDlY5+dL4ITyivlVAlGDZRLvLICs/W7HNCe8knji+qwnlXn82UjfJZLMPfzad7JYC8hh
 nKU4z8kZWbLIirDy8FwE9Z1/PJWX0zwBiOYLcKS2wX4rMat+USU/J5Bs0F36ll0MsOzsH
 vpuEoSTN0WSPuk0nZxDRGajwmN7eo4FRjpkpoIPcMfKqgGwUjYoDA0eOm0acxQLU1ig==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=COAbL+lZ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com;
 envelope-from=imkyufie@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=COAbL+lZ
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 653BC80F7D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:53:59 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cc4aa0248cfso1231116a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 02:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789034039; x=1789638839;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bgdeg5YOjD/bZF9dwpOUoe/caO94irRiqbsHQaQarws=;
 b=COAbL+lZxgqne1Yj5RN3HHhKyl2Vu98EygvBSgjW3r9psXT66PtMoEVqQ9J85k44gk
 ERMtR96qyk8HM5o2F4dhhVGZzuapn0TThKKFxkqSeDOEfQ8Kn2npE/a0N5ZdZ9/oPfXz
 1fg1ql2ik5ou3lytEBdU/zCItggJqllXS/L1xXva07prqeX+Lmbc7RyHQHX3INWM5gng
 +efAF6epSmHx7z1c+lDfUUd8iXmBgjvU6X9f4A1z7cZr0elyjw8mhs/rgyxNPQANasNh
 Z/KjKivap2K9y8ta0UWr80wsDvE5ahl6LT6hW2amiOAN1cDYMP40AQYnENKUU4Nziil2
 pLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789034039; x=1789638839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bgdeg5YOjD/bZF9dwpOUoe/caO94irRiqbsHQaQarws=;
 b=M7+fPW/1VjmgwYkuRUwKwvrV1Ey9QpHrLGSgZPSA0WzMXu+sgUF96kj0rqbK5dMytB
 gI1+JOsJrJyxS9k9XZIXQqC+h0opecnHg1EK1FtCCuQ3Pb56kb5h9z0rI9elva8Jkohd
 uRt8qZ6B4iGAZv1jLVRqeLM1sNkUJ42/s/ose7ZWkZShWqZk2Qu8KglPoD8OqjA7/eBr
 12QiPl2MSWX/sDMI9QScCRmA+A+J0S5b2YKEDkeqFDNg5aYFJ5ydhYt6absHvX/imbGF
 A7hTr5lMnHKmqVXkYIhIu2otCV5tc9uoc2oF+y5RhmkcPz4k8Rnf/GowvsNl7GWpCEDv
 YuzQ==
X-Gm-Message-State: AFuF++lns0QtZUdiWQYhWzwjw0kB6g0kqZL0YlSZRrEWAEzcUCPw4X+Z
 acvMXVDJDab7s1aQkMR5+H1XF148MarySfS0n6BbAEhl0i4qYKbwVyJG0zCFeg==
X-Gm-Gg: AYBFou10GGdHwXYzYnlW74sj5T0nSePBgm7UdRSjluZ/fYh7JWztf74uIqo6w7WhYqB
 cyQsPYGZTYtDMSkpN+ACW2+BiWBeXVLfazm7362TcQY3NZFQlXIb4Cr+j+1gv2nKu354yOsMZ7d
 5DblekmIQAcmXY5DhrlqPfbOkn06j6Y8mY98TD8C6emz0aBtUDiW59gq+nTcTfRzgWhlzQh6c0L
 yOOM3INUyLNNM2QUP6nsOGpsgVH2AqC2YfxvKIDXMgkDHDlCyDM6S5w0krQkktW3LH4sMstgnvf
 Qe0UTEZGJVp2YFodCRqwEGmrE1FjTuJDYtvnje3HO9gPebOI9oT7PF9aZkHX/CuYGDs688HBgZZ
 fVxYwjQbdBAddz5tHWrowUzYn0aPr9whQW5bTVyrmCSVbMPdE37te8+jaEsCoy9RWYDGYU2SyGk
 THHgKh3+627WqohPzIxqBKDa2/CaNhaHd3KibaZNiw80GKsmRmeeM9Yx/HRwuZXHiuUPffPWr2
X-Received: by 2002:a17:90a:d44b:b0:398:bee5:61d6 with SMTP id
 98e67ed59e1d1-39b26252edamr65482084a91.24.1789034038899; 
 Thu, 10 Sep 2026 02:53:58 -0700 (PDT)
Received: from thefoxflat ([2404:c0:7029:b3c6:7b99:50ff:b405:5c31])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d7e77498csm3849455a91.3.2026.09.10.02.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 02:53:58 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Reza Kurniawan <imkyufie@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
Subject: [PATCH 2/4] pinctrl: qcom: Add pinctrl driver for MSM8917
Date: Thu, 10 Sep 2026 09:41:45 +0000
Message-ID: <20260910095339.110427-3-imkyufie@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910095339.110427-1-imkyufie@gmail.com>
References: <20260910095339.110427-1-imkyufie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 12:14:04 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add pinctrl driver to configure pin parameters and managing GPIOs
necessary for certain peripherals.

Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---

 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-msm8917.c | 642 +++++++++++++++++++++++++
 3 files changed, 651 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-msm8917.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 7dd3782c1..10737b5e2 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -62,6 +62,14 @@ config PINCTRL_QCOM_MILOS
 	  Say Y here to enable support for pinctrl on the Snapdragon Milos SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_MSM8917
+	bool "Qualcomm MSM8917 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon MSM8917 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_QCM2290
 	bool "Qualcomm QCM2290 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index a7a9ad035..df445ef09 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PINCTRL_QCOM_IPQ5424) += pinctrl-ipq5424.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
 obj-$(CONFIG_PINCTRL_QCOM_MILOS) += pinctrl-milos.o
+obj-$(CONFIG_PINCTRL_QCOM_MSM8917) += pinctrl-msm8917.o
 obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS615) += pinctrl-qcs615.o
diff --git a/drivers/pinctrl/qcom/pinctrl-msm8917.c b/drivers/pinctrl/qcom/pinctrl-msm8917.c
new file mode 100644
index 000000000..78edd653a
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-msm8917.c
@@ -0,0 +1,642 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm MSM8917 pinctrl
+ *
+ * (C) Copyright 2026 Reza Kurniawan <imkyufie@gmail.com>
+ *
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+typedef unsigned int msm_pin_function[10];
+
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9)\
+	[id] = {					\
+		msm_mux_gpio, /* gpio mode */		\
+		msm_mux_##f1,				\
+		msm_mux_##f2,				\
+		msm_mux_##f3,				\
+		msm_mux_##f4,				\
+		msm_mux_##f5,				\
+		msm_mux_##f6,				\
+		msm_mux_##f7,				\
+		msm_mux_##f8,				\
+		msm_mux_##f9				\
+	}
+
+#define SDC_PINGROUP(pg_name, ctl, pull, drv)	\
+	{						\
+		.name = pg_name,			\
+		.ctl_reg = ctl,				\
+		.io_reg = 0,				\
+		.pull_bit = pull,			\
+		.drv_bit = drv,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = -1,				\
+	}
+
+enum msm8917_functions {
+	msm_mux_accel_int,
+	msm_mux_adsp_ext,
+	msm_mux_alsp_int,
+	msm_mux_atest_bbrx0,
+	msm_mux_atest_bbrx1,
+	msm_mux_atest_char,
+	msm_mux_atest_char0,
+	msm_mux_atest_char1,
+	msm_mux_atest_char2,
+	msm_mux_atest_char3,
+	msm_mux_atest_combodac_to_gpio_native,
+	msm_mux_atest_gpsadc_dtest0_native,
+	msm_mux_atest_gpsadc_dtest1_native,
+	msm_mux_atest_tsens,
+	msm_mux_atest_wlan0,
+	msm_mux_atest_wlan1,
+	msm_mux_audio_ref,
+	msm_mux_audio_reset,
+	msm_mux_bimc_dte0,
+	msm_mux_bimc_dte1,
+	msm_mux_blsp6_spi,
+	msm_mux_blsp8_spi,
+	msm_mux_blsp_i2c1,
+	msm_mux_blsp_i2c2,
+	msm_mux_blsp_i2c3,
+	msm_mux_blsp_i2c4,
+	msm_mux_blsp_i2c5,
+	msm_mux_blsp_i2c6,
+	msm_mux_blsp_i2c7,
+	msm_mux_blsp_i2c8,
+	msm_mux_blsp_spi1,
+	msm_mux_blsp_spi2,
+	msm_mux_blsp_spi3,
+	msm_mux_blsp_spi4,
+	msm_mux_blsp_spi5,
+	msm_mux_blsp_spi6,
+	msm_mux_blsp_spi7,
+	msm_mux_blsp_spi8,
+	msm_mux_blsp_uart1,
+	msm_mux_blsp_uart2,
+	msm_mux_blsp_uart3,
+	msm_mux_blsp_uart4,
+	msm_mux_blsp_uart5,
+	msm_mux_blsp_uart6,
+	msm_mux_blsp_uart7,
+	msm_mux_blsp_uart8,
+	msm_mux_cam0_ldo,
+	msm_mux_cam1_rst,
+	msm_mux_cam1_standby,
+	msm_mux_cam2_rst,
+	msm_mux_cam2_standby,
+	msm_mux_cam_mclk,
+	msm_mux_cci_async,
+	msm_mux_cci_i2c,
+	msm_mux_cci_timer0,
+	msm_mux_cci_timer1,
+	msm_mux_cdc_pdm0,
+	msm_mux_codec_int1,
+	msm_mux_codec_int2,
+	msm_mux_codec_mad,
+	msm_mux_coex_uart,
+	msm_mux_cri_trng,
+	msm_mux_cri_trng0,
+	msm_mux_cri_trng1,
+	msm_mux_dbg_out,
+	msm_mux_dmic0_clk,
+	msm_mux_dmic0_data,
+	msm_mux_ebi_cdc,
+	msm_mux_ebi_ch0,
+	msm_mux_ext_lpass,
+	msm_mux_forced_usb,
+	msm_mux_fp_gpio,
+	msm_mux_fp_int,
+	msm_mux_gcc_gp1_clk_a,
+	msm_mux_gcc_gp1_clk_b,
+	msm_mux_gcc_gp2_clk_a,
+	msm_mux_gcc_gp2_clk_b,
+	msm_mux_gcc_gp3_clk_a,
+	msm_mux_gcc_gp3_clk_b,
+	msm_mux_gcc_plltest,
+	msm_mux_gcc_tlmm,
+	msm_mux_gpio,
+	msm_mux_gsm0_tx,
+	msm_mux_key_focus,
+	msm_mux_key_snapshot,
+	msm_mux_key_volp,
+	msm_mux_ldo_en,
+	msm_mux_ldo_update,
+	msm_mux_lpass_slimbus,
+	msm_mux_lpass_slimbus0,
+	msm_mux_lpass_slimbus1,
+	msm_mux_m_voc,
+	msm_mux_mag_int,
+	msm_mux_mdp_vsync,
+	msm_mux_mipi_dsi0,
+	msm_mux_modem_tsync,
+	msm_mux_nav_pps,
+	msm_mux_nav_pps_in_a,
+	msm_mux_nav_pps_in_b,
+	msm_mux_nav_tsync,
+	msm_mux_nfc_pwr,
+	msm_mux_ov_ldo,
+	msm_mux_pa_indicator,
+	msm_mux_pbs0,
+	msm_mux_pbs1,
+	msm_mux_pbs2,
+	msm_mux_pri_mi2s,
+	msm_mux_pri_mi2s_mclk_a,
+	msm_mux_pri_mi2s_mclk_b,
+	msm_mux_pri_mi2s_ws,
+	msm_mux_prng_rosc,
+	msm_mux_pwr_crypto_enabled_a,
+	msm_mux_pwr_crypto_enabled_b,
+	msm_mux_pwr_modem_enabled_a,
+	msm_mux_pwr_modem_enabled_b,
+	msm_mux_pwr_nav_enabled_a,
+	msm_mux_pwr_nav_enabled_b,
+	msm_mux_qdss_cti_trig_in_a0,
+	msm_mux_qdss_cti_trig_in_a1,
+	msm_mux_qdss_cti_trig_in_b0,
+	msm_mux_qdss_cti_trig_in_b1,
+	msm_mux_qdss_cti_trig_out_a0,
+	msm_mux_qdss_cti_trig_out_a1,
+	msm_mux_qdss_cti_trig_out_b0,
+	msm_mux_qdss_cti_trig_out_b1,
+	msm_mux_qdss_traceclk_a,
+	msm_mux_qdss_traceclk_b,
+	msm_mux_qdss_tracectl_a,
+	msm_mux_qdss_tracectl_b,
+	msm_mux_qdss_tracedata_a,
+	msm_mux_qdss_tracedata_b,
+	msm_mux_sd_write,
+	msm_mux_sdcard_det,
+	msm_mux_sec_mi2s,
+	msm_mux_sec_mi2s_mclk_a,
+	msm_mux_sec_mi2s_mclk_b,
+	msm_mux_sensor_rst,
+	msm_mux_smb_int,
+	msm_mux_ssbi_wtr1,
+	msm_mux_ts_resout,
+	msm_mux_ts_sample,
+	msm_mux_uim1_clk,
+	msm_mux_uim1_data,
+	msm_mux_uim1_present,
+	msm_mux_uim1_reset,
+	msm_mux_uim2_clk,
+	msm_mux_uim2_data,
+	msm_mux_uim2_present,
+	msm_mux_uim2_reset,
+	msm_mux_uim_batt,
+	msm_mux_us_emitter,
+	msm_mux_us_euro,
+	msm_mux_wcss_bt,
+	msm_mux_wcss_fm,
+	msm_mux_wcss_wlan,
+	msm_mux_wcss_wlan0,
+	msm_mux_wcss_wlan1,
+	msm_mux_wcss_wlan2,
+	msm_mux_webcam_rst,
+	msm_mux_webcam_standby,
+	msm_mux_wsa_io,
+	msm_mux_wsa_irq,
+	msm_mux_wsa_reset,
+	msm_mux__,
+};
+
+#define MSM_PIN_FUNCTION(fname)                         \
+	[msm_mux_##fname] = {#fname, msm_mux_##fname}
+
+static const struct pinctrl_function msm8917_pinctrl_functions[] = {
+	MSM_PIN_FUNCTION(accel_int),
+	MSM_PIN_FUNCTION(adsp_ext),
+	MSM_PIN_FUNCTION(alsp_int),
+	MSM_PIN_FUNCTION(atest_bbrx0),
+	MSM_PIN_FUNCTION(atest_bbrx1),
+	MSM_PIN_FUNCTION(atest_char),
+	MSM_PIN_FUNCTION(atest_char0),
+	MSM_PIN_FUNCTION(atest_char1),
+	MSM_PIN_FUNCTION(atest_char2),
+	MSM_PIN_FUNCTION(atest_char3),
+	MSM_PIN_FUNCTION(atest_combodac_to_gpio_native),
+	MSM_PIN_FUNCTION(atest_gpsadc_dtest0_native),
+	MSM_PIN_FUNCTION(atest_gpsadc_dtest1_native),
+	MSM_PIN_FUNCTION(atest_tsens),
+	MSM_PIN_FUNCTION(atest_wlan0),
+	MSM_PIN_FUNCTION(atest_wlan1),
+	MSM_PIN_FUNCTION(audio_ref),
+	MSM_PIN_FUNCTION(audio_reset),
+	MSM_PIN_FUNCTION(bimc_dte0),
+	MSM_PIN_FUNCTION(bimc_dte1),
+	MSM_PIN_FUNCTION(blsp6_spi),
+	MSM_PIN_FUNCTION(blsp8_spi),
+	MSM_PIN_FUNCTION(blsp_i2c1),
+	MSM_PIN_FUNCTION(blsp_i2c2),
+	MSM_PIN_FUNCTION(blsp_i2c3),
+	MSM_PIN_FUNCTION(blsp_i2c4),
+	MSM_PIN_FUNCTION(blsp_i2c5),
+	MSM_PIN_FUNCTION(blsp_i2c6),
+	MSM_PIN_FUNCTION(blsp_i2c7),
+	MSM_PIN_FUNCTION(blsp_i2c8),
+	MSM_PIN_FUNCTION(blsp_spi1),
+	MSM_PIN_FUNCTION(blsp_spi2),
+	MSM_PIN_FUNCTION(blsp_spi3),
+	MSM_PIN_FUNCTION(blsp_spi4),
+	MSM_PIN_FUNCTION(blsp_spi5),
+	MSM_PIN_FUNCTION(blsp_spi6),
+	MSM_PIN_FUNCTION(blsp_spi7),
+	MSM_PIN_FUNCTION(blsp_spi8),
+	MSM_PIN_FUNCTION(blsp_uart1),
+	MSM_PIN_FUNCTION(blsp_uart2),
+	MSM_PIN_FUNCTION(blsp_uart3),
+	MSM_PIN_FUNCTION(blsp_uart4),
+	MSM_PIN_FUNCTION(blsp_uart5),
+	MSM_PIN_FUNCTION(blsp_uart6),
+	MSM_PIN_FUNCTION(blsp_uart7),
+	MSM_PIN_FUNCTION(blsp_uart8),
+	MSM_PIN_FUNCTION(cam0_ldo),
+	MSM_PIN_FUNCTION(cam1_rst),
+	MSM_PIN_FUNCTION(cam1_standby),
+	MSM_PIN_FUNCTION(cam2_rst),
+	MSM_PIN_FUNCTION(cam2_standby),
+	MSM_PIN_FUNCTION(cam_mclk),
+	MSM_PIN_FUNCTION(cci_async),
+	MSM_PIN_FUNCTION(cci_i2c),
+	MSM_PIN_FUNCTION(cci_timer0),
+	MSM_PIN_FUNCTION(cci_timer1),
+	MSM_PIN_FUNCTION(cdc_pdm0),
+	MSM_PIN_FUNCTION(codec_int1),
+	MSM_PIN_FUNCTION(codec_int2),
+	MSM_PIN_FUNCTION(codec_mad),
+	MSM_PIN_FUNCTION(coex_uart),
+	MSM_PIN_FUNCTION(cri_trng),
+	MSM_PIN_FUNCTION(cri_trng0),
+	MSM_PIN_FUNCTION(cri_trng1),
+	MSM_PIN_FUNCTION(dbg_out),
+	MSM_PIN_FUNCTION(dmic0_clk),
+	MSM_PIN_FUNCTION(dmic0_data),
+	MSM_PIN_FUNCTION(ebi_cdc),
+	MSM_PIN_FUNCTION(ebi_ch0),
+	MSM_PIN_FUNCTION(ext_lpass),
+	MSM_PIN_FUNCTION(forced_usb),
+	MSM_PIN_FUNCTION(fp_gpio),
+	MSM_PIN_FUNCTION(fp_int),
+	MSM_PIN_FUNCTION(gcc_gp1_clk_a),
+	MSM_PIN_FUNCTION(gcc_gp1_clk_b),
+	MSM_PIN_FUNCTION(gcc_gp2_clk_a),
+	MSM_PIN_FUNCTION(gcc_gp2_clk_b),
+	MSM_PIN_FUNCTION(gcc_gp3_clk_a),
+	MSM_PIN_FUNCTION(gcc_gp3_clk_b),
+	MSM_PIN_FUNCTION(gcc_plltest),
+	MSM_PIN_FUNCTION(gcc_tlmm),
+	MSM_PIN_FUNCTION(gpio),
+	MSM_PIN_FUNCTION(gsm0_tx),
+	MSM_PIN_FUNCTION(key_focus),
+	MSM_PIN_FUNCTION(key_snapshot),
+	MSM_PIN_FUNCTION(key_volp),
+	MSM_PIN_FUNCTION(ldo_en),
+	MSM_PIN_FUNCTION(ldo_update),
+	MSM_PIN_FUNCTION(lpass_slimbus),
+	MSM_PIN_FUNCTION(lpass_slimbus0),
+	MSM_PIN_FUNCTION(lpass_slimbus1),
+	MSM_PIN_FUNCTION(m_voc),
+	MSM_PIN_FUNCTION(mag_int),
+	MSM_PIN_FUNCTION(mdp_vsync),
+	MSM_PIN_FUNCTION(mipi_dsi0),
+	MSM_PIN_FUNCTION(modem_tsync),
+	MSM_PIN_FUNCTION(nav_pps),
+	MSM_PIN_FUNCTION(nav_pps_in_a),
+	MSM_PIN_FUNCTION(nav_pps_in_b),
+	MSM_PIN_FUNCTION(nav_tsync),
+	MSM_PIN_FUNCTION(nfc_pwr),
+	MSM_PIN_FUNCTION(ov_ldo),
+	MSM_PIN_FUNCTION(pa_indicator),
+	MSM_PIN_FUNCTION(pbs0),
+	MSM_PIN_FUNCTION(pbs1),
+	MSM_PIN_FUNCTION(pbs2),
+	MSM_PIN_FUNCTION(pri_mi2s),
+	MSM_PIN_FUNCTION(pri_mi2s_mclk_a),
+	MSM_PIN_FUNCTION(pri_mi2s_mclk_b),
+	MSM_PIN_FUNCTION(pri_mi2s_ws),
+	MSM_PIN_FUNCTION(prng_rosc),
+	MSM_PIN_FUNCTION(pwr_crypto_enabled_a),
+	MSM_PIN_FUNCTION(pwr_crypto_enabled_b),
+	MSM_PIN_FUNCTION(pwr_modem_enabled_a),
+	MSM_PIN_FUNCTION(pwr_modem_enabled_b),
+	MSM_PIN_FUNCTION(pwr_nav_enabled_a),
+	MSM_PIN_FUNCTION(pwr_nav_enabled_b),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_a0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_a1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_b0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_b1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_a0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_a1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_b0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_b1),
+	MSM_PIN_FUNCTION(qdss_traceclk_a),
+	MSM_PIN_FUNCTION(qdss_traceclk_b),
+	MSM_PIN_FUNCTION(qdss_tracectl_a),
+	MSM_PIN_FUNCTION(qdss_tracectl_b),
+	MSM_PIN_FUNCTION(qdss_tracedata_a),
+	MSM_PIN_FUNCTION(qdss_tracedata_b),
+	MSM_PIN_FUNCTION(sd_write),
+	MSM_PIN_FUNCTION(sdcard_det),
+	MSM_PIN_FUNCTION(sec_mi2s),
+	MSM_PIN_FUNCTION(sec_mi2s_mclk_a),
+	MSM_PIN_FUNCTION(sec_mi2s_mclk_b),
+	MSM_PIN_FUNCTION(sensor_rst),
+	MSM_PIN_FUNCTION(smb_int),
+	MSM_PIN_FUNCTION(ssbi_wtr1),
+	MSM_PIN_FUNCTION(ts_resout),
+	MSM_PIN_FUNCTION(ts_sample),
+	MSM_PIN_FUNCTION(uim1_clk),
+	MSM_PIN_FUNCTION(uim1_data),
+	MSM_PIN_FUNCTION(uim1_present),
+	MSM_PIN_FUNCTION(uim1_reset),
+	MSM_PIN_FUNCTION(uim2_clk),
+	MSM_PIN_FUNCTION(uim2_data),
+	MSM_PIN_FUNCTION(uim2_present),
+	MSM_PIN_FUNCTION(uim2_reset),
+	MSM_PIN_FUNCTION(uim_batt),
+	MSM_PIN_FUNCTION(us_emitter),
+	MSM_PIN_FUNCTION(us_euro),
+	MSM_PIN_FUNCTION(wcss_bt),
+	MSM_PIN_FUNCTION(wcss_fm),
+	MSM_PIN_FUNCTION(wcss_wlan),
+	MSM_PIN_FUNCTION(wcss_wlan0),
+	MSM_PIN_FUNCTION(wcss_wlan1),
+	MSM_PIN_FUNCTION(wcss_wlan2),
+	MSM_PIN_FUNCTION(webcam_rst),
+	MSM_PIN_FUNCTION(webcam_standby),
+	MSM_PIN_FUNCTION(wsa_io),
+	MSM_PIN_FUNCTION(wsa_irq),
+	MSM_PIN_FUNCTION(wsa_reset),
+};
+
+static const msm_pin_function msm8917_pin_functions[] = {
+	PINGROUP(0, blsp_spi1, blsp_uart1, qdss_tracedata_b, _, _, _, _,
+		 _, _),
+	PINGROUP(1, blsp_spi1, blsp_uart1, adsp_ext, _, _, _, _, _,
+		 qdss_tracedata_b),
+	PINGROUP(2, blsp_spi1, blsp_uart1, blsp_i2c1, prng_rosc, _, _, _,
+		 _, _),
+	PINGROUP(3, blsp_spi1, blsp_uart1, blsp_i2c1, _, _, _, _, _, _),
+	PINGROUP(4, blsp_spi2, blsp_uart2, ldo_update, _,
+		 atest_combodac_to_gpio_native, _, _, _, _),
+	PINGROUP(5, blsp_spi2, blsp_uart2, ldo_en, _, _, _, _, _, _),
+	PINGROUP(6, blsp_spi2, blsp_uart2, blsp_i2c2, gcc_gp1_clk_b,
+		 qdss_tracedata_b, _, _, _, _),
+	PINGROUP(7, blsp_spi2, blsp_uart2, blsp_i2c2, pbs2, _,
+		 qdss_tracedata_b, _, atest_gpsadc_dtest0_native, _),
+	PINGROUP(8, blsp_spi3, blsp_uart3, pbs0, _, _, _, _, _, _),
+	PINGROUP(9, blsp_spi3, blsp_uart3, pbs1, pwr_modem_enabled_b, _, _,
+		 _, _, _),
+	PINGROUP(10, blsp_spi3, blsp_uart3, blsp_i2c3, gcc_gp2_clk_b, _, _,
+		 _, _, _),
+	PINGROUP(11, blsp_spi3, blsp_uart3, blsp_i2c3, gcc_gp3_clk_b, _, _,
+		 _, _, _),
+	PINGROUP(12, blsp_spi4, blsp_uart4, sec_mi2s, pwr_nav_enabled_b, _,
+		 _, _, _, _),
+	PINGROUP(13, blsp_spi4, blsp_uart4, sec_mi2s, pwr_crypto_enabled_b, _,
+		 _, _, _, _),
+	PINGROUP(14, blsp_spi4, blsp_uart4, blsp_i2c4, _, _, _, _, _, _),
+	PINGROUP(15, blsp_spi4, blsp_uart4, blsp_i2c4, _, _, _, _, _, _),
+	PINGROUP(16, blsp_spi5, blsp_uart5, _, _, _, _, qdss_traceclk_a,
+		 _, atest_bbrx1),
+	PINGROUP(17, blsp_spi5, blsp_uart5, m_voc, qdss_cti_trig_in_a0, _,
+		 atest_bbrx0, _, _, _),
+	PINGROUP(18, blsp_spi5, blsp_uart5, blsp_i2c5, qdss_tracectl_a, _,
+		 atest_gpsadc_dtest1_native, _, _, _),
+	PINGROUP(19, blsp_spi5, blsp_uart5, blsp_i2c5, qdss_tracedata_a, _,
+		 _, _, _, _),
+	PINGROUP(20, blsp_spi6, blsp_uart6, _, _, _, _, _, _,
+		 qdss_tracectl_b),
+	PINGROUP(21, blsp_spi6, blsp_uart6, m_voc, _, _, _, _, _,
+		 qdss_cti_trig_in_b0),
+	PINGROUP(22, blsp_spi6, blsp_uart6, blsp_i2c6, qdss_traceclk_b, _,
+		 atest_wlan0, _, _, _),
+	PINGROUP(23, blsp_spi6, blsp_uart6, blsp_i2c6, qdss_tracedata_b, _,
+		 atest_wlan1, _, _, _),
+	PINGROUP(24, mdp_vsync, _, _, _, _, _, _, _, _),
+	PINGROUP(25, mdp_vsync, pri_mi2s_mclk_a, sec_mi2s_mclk_a, _, _, _,
+		 _, _, _),
+	PINGROUP(26, cam_mclk, _, _, _, _, _, qdss_tracedata_a, _, _),
+	PINGROUP(27, cam_mclk, _, _, _, _, _, _, _, qdss_tracedata_a),
+	PINGROUP(28, cam_mclk, _, _, _, _, _, qdss_tracedata_a, _,
+		 atest_combodac_to_gpio_native),
+	PINGROUP(29, cci_i2c, pwr_modem_enabled_a, _, _, _, _, _,
+		 qdss_tracedata_a, _),
+	PINGROUP(30, cci_i2c, _, _, _, _, _, _, _, qdss_tracedata_a),
+	PINGROUP(31, cci_i2c, _, _, _, _, _, _, _, qdss_tracedata_a),
+	PINGROUP(32, cci_i2c, _, _, _, _, _, _, _, qdss_tracedata_a),
+	PINGROUP(33, cci_timer0, _, _, _, _, _, _, _, qdss_tracedata_a),
+	PINGROUP(34, cci_timer1, _, _, _, _, _, _, _, qdss_tracedata_a),
+	PINGROUP(35, pwr_nav_enabled_a, _, _, _, _, _, _, _,
+		 qdss_tracedata_a),
+	PINGROUP(36, pwr_crypto_enabled_a, _, _, _, _, _, _, _,
+		 qdss_tracedata_a),
+	PINGROUP(37, _, _, _, _, _, qdss_cti_trig_out_b1, _, _, _),
+	PINGROUP(38, _, qdss_tracedata_a, _, _, _, _, _, _, _),
+	PINGROUP(39, cci_async, _, _, _, _, _, qdss_tracedata_a, _,
+		 atest_combodac_to_gpio_native),
+	PINGROUP(40, _, _, _, _, qdss_tracedata_a, _,
+		 atest_combodac_to_gpio_native, _, _),
+	PINGROUP(41, sd_write, _, _, _, _, _, _, _,
+		 atest_combodac_to_gpio_native),
+	PINGROUP(42, gcc_gp1_clk_a, qdss_tracedata_b, _,
+		 atest_combodac_to_gpio_native, _, _, _, _, _),
+	PINGROUP(43, gcc_gp2_clk_a, qdss_tracedata_b, _,
+		 atest_combodac_to_gpio_native, _, _, _, _, _),
+	PINGROUP(44, gcc_gp3_clk_a, qdss_tracedata_b, _,
+		 atest_combodac_to_gpio_native, _, _, _, _, _),
+	PINGROUP(45, _, _, atest_combodac_to_gpio_native, _, _, _, _, _,
+		 _),
+	PINGROUP(46, _, _, atest_combodac_to_gpio_native, _, _, _, _, _,
+		 _),
+	PINGROUP(47, blsp6_spi, _, qdss_tracedata_b, _,
+		 atest_combodac_to_gpio_native, _, _, _, _),
+	PINGROUP(48, _, qdss_cti_trig_in_b1, _,
+		 atest_combodac_to_gpio_native, _, _, _, _, _),
+	PINGROUP(49, uim_batt, _, _, _, _, _, _, _, _),
+	PINGROUP(50, qdss_tracedata_a, _, _, _, _, _, _, _, _),
+	PINGROUP(51, uim1_data, _, _, _, _, _, _, _, _),
+	PINGROUP(52, uim1_clk, _, _, _, _, _, _, _, _),
+	PINGROUP(53, uim1_reset, _, _, _, _, _, _, _, _),
+	PINGROUP(54, uim1_present, _, _, _, _, _, _, _, _),
+	PINGROUP(55, uim2_data, _, _, _, _, _, _, _, _),
+	PINGROUP(56, uim2_clk, _, _, _, _, _, _, _, _),
+	PINGROUP(57, uim2_reset, _, _, _, _, _, _, _, _),
+	PINGROUP(58, uim2_present, _, _, _, _, _, _, _, _),
+	PINGROUP(59, _, _, _, _, _, _, _, _, _),
+	PINGROUP(60, _, _, _, _, _, _, _, _, _),
+	PINGROUP(61, _, _, _, _, _, _, _, _, _),
+	PINGROUP(62, _, _, _, _, _, _, _, _, _),
+	PINGROUP(63, atest_char3, dbg_out, bimc_dte0, _, _, _, _, _, _),
+	PINGROUP(64, _, _, _, _, _, _, _, _, _),
+	PINGROUP(65, bimc_dte0, _, _, _, _, _, _, _, _),
+	PINGROUP(66, sec_mi2s_mclk_b, pri_mi2s, _, qdss_tracedata_b, _, _,
+		 _, _, _),
+	PINGROUP(67, atest_char1, ebi_cdc, _, atest_combodac_to_gpio_native,
+		 _, _, _, _, _),
+	PINGROUP(68, atest_char0, _, _, _, _, _, _, _, _),
+	PINGROUP(69, audio_ref, cdc_pdm0, pri_mi2s_mclk_b, ebi_cdc, _, _, _,
+		 _, _),
+	PINGROUP(70, lpass_slimbus, cdc_pdm0, _, _, _, _, _, _, _),
+	PINGROUP(71, lpass_slimbus0, cdc_pdm0, _, _, _, _, _, _, _),
+	PINGROUP(72, lpass_slimbus1, cdc_pdm0, _, _, _, _, _, _, _),
+	PINGROUP(73, cdc_pdm0, _, _, _, _, _, _, _, _),
+	PINGROUP(74, cdc_pdm0, _, _, _, _, _, _, _, _),
+	PINGROUP(75, wcss_bt, atest_char2, _, ebi_ch0, _, _, _, _, _),
+	PINGROUP(76, wcss_wlan2, _, _, _, _, _, _, _, _),
+	PINGROUP(77, wcss_wlan1, _, _, _, _, _, _, _, _),
+	PINGROUP(78, wcss_wlan0, _, _, _, _, _, _, _, _),
+	PINGROUP(79, wcss_wlan, _, _, _, _, _, _, _, _),
+	PINGROUP(80, wcss_wlan, _, _, _, _, _, _, _, _),
+	PINGROUP(81, wcss_fm, ext_lpass, _, _, _, _, _, _, _),
+	PINGROUP(82, wcss_fm, cri_trng, _, _, _, _, _, _, _),
+	PINGROUP(83, wcss_bt, cri_trng1, _, _, _, _, _, _, _),
+	PINGROUP(84, wcss_bt, cri_trng0, _, _, _, _, _, _, _),
+	PINGROUP(85, pri_mi2s, blsp_spi7, blsp_uart7, _, _, _, _, _, _),
+	PINGROUP(86, pri_mi2s, blsp_spi7, blsp_uart7, qdss_tracedata_b, _, _,
+		 _, _, _),
+	PINGROUP(87, pri_mi2s_ws, blsp_spi7, blsp_uart7, blsp_i2c7,
+		 qdss_tracedata_b, gcc_tlmm, _, _, _),
+	PINGROUP(88, pri_mi2s, blsp_spi7, blsp_uart7, blsp_i2c7, _, _, _,
+		 _, _),
+	PINGROUP(89, dmic0_clk, _, _, _, _, _, _, _, _),
+	PINGROUP(90, dmic0_data, _, _, _, _, _, _, _, _),
+	PINGROUP(91, _, _, _, _, _, qdss_cti_trig_in_a1, _, _, _),
+	PINGROUP(92, _, _, _, _, _, qdss_tracedata_b, _, _, _),
+	PINGROUP(93, _, _, _, _, _, _, _, _, _),
+	PINGROUP(94, wsa_io, sec_mi2s, pri_mi2s, _, _, _, _, _, _),
+	PINGROUP(95, wsa_io, sec_mi2s, pri_mi2s, _, _, _, _, _, _),
+	PINGROUP(96, blsp_spi8, blsp_uart8, _, _, _, _, _, _, _),
+	PINGROUP(97, blsp_spi8, blsp_uart8, _, _, _, _, _, _, _),
+	PINGROUP(98, blsp_spi8, blsp_uart8, blsp_i2c8, gcc_plltest, _, _, _,
+		 _, _),
+	PINGROUP(99, blsp_spi8, blsp_uart8, blsp_i2c8, gcc_plltest, _, _, _,
+		 _, _),
+	PINGROUP(100, _, _, _, _, _, _, _, _, _),
+	PINGROUP(101, _, _, _, _, _, _, _, _, _),
+	PINGROUP(102, _, _, _, _, _, _, _, _, _),
+	PINGROUP(103, _, _, _, _, _, _, _, _, _),
+	PINGROUP(104, _, _, _, _, _, _, _, _, _),
+	PINGROUP(105, _, _, _, _, _, _, _, _, _),
+	PINGROUP(106, _, _, _, _, _, _, _, _, _),
+	PINGROUP(107, _, _, _, _, _, _, _, _, _),
+	PINGROUP(108, _, _, _, _, _, _, _, _, _),
+	PINGROUP(109, _, _, _, _, _, _, _, _, _),
+	PINGROUP(110, _, _, _, _, _, _, _, _, _),
+	PINGROUP(111, _, _, _, _, _, _, _, _, _),
+	PINGROUP(112, _, _, _, _, _, _, _, _, _),
+	PINGROUP(113, _, _, _, _, _, _, _, _, _),
+	PINGROUP(114, _, _, _, _, _, _, _, _, _),
+	PINGROUP(115, _, _, nav_pps_in_a, _, atest_combodac_to_gpio_native,
+		 _, _, _, _),
+	PINGROUP(116, _, pa_indicator, _, _, _, _, _, _, _),
+	PINGROUP(117, _, modem_tsync, nav_tsync, nav_pps_in_b, nav_pps, _,
+		 _, _, _),
+	PINGROUP(118, _, ebi_cdc, _, _, _, _, _, _, _),
+	PINGROUP(119, gsm0_tx, _, ebi_cdc, _, _, _, _, _, _),
+	PINGROUP(120, _, atest_char, ebi_cdc, _, atest_tsens, _, _, _, _),
+	PINGROUP(121, _, _, _, bimc_dte1, _, _, _, _, _),
+	PINGROUP(122, _, ssbi_wtr1, _, _, bimc_dte1, _, _, _, _),
+	PINGROUP(123, _, ssbi_wtr1, ebi_cdc, _, _, _, _, _, _),
+	PINGROUP(124, coex_uart, _, _, _, _, _, _, _, _),
+	PINGROUP(125, _, _, _, _, _, _, _, _, _),
+	PINGROUP(126, _, _, _, _, _, _, _, _, _),
+	PINGROUP(127, coex_uart, _, _, _, _, _, _, _, _),
+	PINGROUP(128, _, _, _, _, _, _, _, _, _),
+	PINGROUP(129, _, _, _, _, _, _, _, _, _),
+	PINGROUP(130, blsp8_spi, _, _, _, _, _, _, _, _),
+	PINGROUP(131, _, _, _, _, _, _, _, _, _),
+	PINGROUP(132, qdss_cti_trig_out_a0, _, _, _, _, _, _, _, _),
+	PINGROUP(133, qdss_cti_trig_out_a1, _, _, _, _, _, _, _, _)
+};
+
+static const struct msm_special_pin_data msm8917_special_pins_data[] = {
+	SDC_PINGROUP("sdc1_clk", 0x10a000, 13, 6),
+	SDC_PINGROUP("sdc1_cmd", 0x10a000, 11, 3),
+	SDC_PINGROUP("sdc1_data", 0x10a000, 9, 0),
+	SDC_PINGROUP("sdc1_rclk", 0x10a000, 15, 0),
+	SDC_PINGROUP("sdc2_clk", 0x109000, 14, 6),
+	SDC_PINGROUP("sdc2_cmd", 0x109000, 11, 3),
+	SDC_PINGROUP("sdc2_data", 0x109000, 9, 0),
+	SDC_PINGROUP("qdsd_clk", 0x19c000, 3, 0),
+	SDC_PINGROUP("qdsd_cmd", 0x19c000, 8, 5),
+	SDC_PINGROUP("qdsd_data0", 0x19c000, 13, 10),
+	SDC_PINGROUP("qdsd_data1", 0x19c000, 18, 15),
+	SDC_PINGROUP("qdsd_data2", 0x19c000, 23, 20),
+	SDC_PINGROUP("qdsd_data3", 0x19c000, 28, 25),
+};
+
+#define N_GPIO		ARRAY_SIZE(msm8917_pin_functions)
+#define N_SPECIAL	ARRAY_SIZE(msm8917_special_pins_data)
+
+static int msm8917_get_function_mux(unsigned int pin, unsigned int selector)
+{
+	unsigned int i;
+	const msm_pin_function *func;
+
+	if (pin >= N_GPIO)
+		return -EINVAL;
+
+	func = msm8917_pin_functions + pin;
+
+	for (i = 0; i < 10; i++)
+		if ((*func)[i] == selector)
+			return i;
+
+	pr_err("Can't find requested function for pin %u\n", pin);
+
+	return -EINVAL;
+}
+
+static const char *msm8917_get_function_name(struct udevice *dev,
+					     unsigned int selector)
+{
+	return msm8917_pinctrl_functions[selector].name;
+}
+
+static const char *msm8917_get_pin_name(struct udevice *dev,
+					unsigned int selector)
+{
+	if (selector >= N_GPIO)
+		return msm8917_special_pins_data[selector - N_GPIO].name;
+
+	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static const struct msm_pinctrl_data msm8917_data = {
+	.pin_data = {
+		.pin_count = N_GPIO + N_SPECIAL,
+		.special_pins_start = N_GPIO,
+		.special_pins_data = msm8917_special_pins_data,
+	},
+	.functions_count = ARRAY_SIZE(msm8917_pinctrl_functions),
+	.get_function_name = msm8917_get_function_name,
+	.get_function_mux = msm8917_get_function_mux,
+	.get_pin_name = msm8917_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{
+		.compatible = "qcom,msm8917-pinctrl",
+		.data = (ulong)&msm8917_data
+	},
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_msm8917) = {
+	.name		= "pinctrl_msm8917",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.bind		= msm_pinctrl_bind,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
-- 
2.55.0

