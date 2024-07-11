Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D65CC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A0688452;
	Thu, 11 Jul 2024 18:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jeCjgJVq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40C9288606; Thu, 11 Jul 2024 18:47:03 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 250228874F
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:47:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-58b0dddab8cso2049864a12.0
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716420; x=1721321220; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J2Xb8QGSmLC3HVEoB3mz/KYofOPaOn10RTD7PCXi0JM=;
 b=jeCjgJVqZUuMCLgkctHa1r3TxSMWWEy9arLXjd+qexBWQufm3wNHjKfi7OJtjD2AoD
 6fvwpF1ii2bymSx0KkT2KE9aIed8LFagfxC5o1M9tbKoGj+RO1CqJjlyj7EummUFrSOt
 /g+Bs9AIsdc+v3rPpvq9Sp+2EF4byG5H7n10B3tn173dnUNbgo6c/1nwKaW+kliiIv9f
 yEC0mOfLzNXMI/BoeAI67Bqi8YLjX/LIlpwpKj50hkngPWgbmRMn0/iQCVABmBjs9bUJ
 WjZ93hGEqmKKRf9t8yzDhKvo7zgeaOCo5oQehZZOmcLnp49U8gFiYvVbgqnrLrjwgRhG
 C+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716420; x=1721321220;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J2Xb8QGSmLC3HVEoB3mz/KYofOPaOn10RTD7PCXi0JM=;
 b=wt3M5xl1AVgjqfrlKDXUZYYEOxT7ZT3ggllxI0/+MLk6WzcxvluRVJgj11lrMzcVU8
 FFtS+cHsksGyeVO9eh0rxL6TtpzvPGXjL8bBASe6BCltygRfJAg41utvx/qwlxwUJzDf
 CFa9QEmvwZbN6eiaQhBuNzqu76AAGEAt/qNrwvdWEKQRwctG7cHZAMz7QSsVnHwb87VO
 CwxkiQzRRlLDx5QqKFxJqyiHCcAjqbDGfQlHFt8gyM+f/v0S6ycWna5bXrspINuBGnzE
 NHFhfXhoCkT7SguTUyszsv3VwJ69+lXDa+ZFsdAAL/c5oPAeqw0y6R+eJvH+vD7EhoTQ
 IpSw==
X-Gm-Message-State: AOJu0YwkoLhBDIXUg132pBGIpTuAeonGc+ua5KGGqzY4HsjHGg2pJ+aj
 ycXoxneWY3cRDqx2Dmxo9FfN+jTNCgC36aP3mgrwxIQb3tnmjYZgQ5+lmCeXc0ocfZ3XxIAetQO
 1
X-Google-Smtp-Source: AGHT+IGQzaUHIIWUGJkENCLpn28D3vEqVPMHUHR5cY65lSQJwgQgwL45tHhsy1VlBvlvcMy3KmNA2w==
X-Received: by 2002:a17:907:868c:b0:a77:c548:6452 with SMTP id
 a640c23a62f3a-a780b6fe882mr814457066b.41.1720716420740; 
 Thu, 11 Jul 2024 09:47:00 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8545adsm268454166b.159.2024.07.11.09.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:47:00 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 11 Jul 2024 18:46:48 +0200
Subject: [PATCH v5 16/23] power: regulator: qcom-rpmh-regulator: adjust
 headers for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-qcom-rpmh-v5-16-fbf04ce6a7e8@linaro.org>
References: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
In-Reply-To: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Oc4JtpqXYn1MXtM0lGX9maQ83ydNTHJPWFTQLcLax0I=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmkAxvjAOf9Ela/whJDiNJrGbYVAlG8lx3JCTBh
 eXmO3UVPN+JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpAMbwAKCRAFgzErGV9k
 ttm/D/93CVLG4a3uStTaa4rG/OKdF0Nberp+Nu8BrZ1LCAYbzdwcq3RfwKN9id8tGlOo2QKlqGq
 P3Nu3Hb0SJV9hEF6hih5srX72aueAaeVu2zuWXq87LDHgON9FRRsjWUnjJPNZyf/gC/lmtfwubD
 bDBQ5elFuLE9A7ma/GRXzW1iGNrk57vVcFJ48fQZFntefgcM/Q+Fi8pN0mr3+LwVZ4aPyeay3Wl
 Ejah7tqD9MzpljNo3JzrhCR1pnrTTYAftp1HGeKKD74tZyvCS92GG8qcnEDYsJEI2Yi+s3uVAQh
 VYB5UbBFVE1zF6XeweKSMSnd76WC/Upmq1xSdTZW4/BuuXMojhUYjysiYHcX9h18JtmFcjzFthO
 AnZDMqQpT/A/qwryTWO2ngJp5Zm7PtCeYhLehAvK9xVHhzWxH/XEUvUSiHo3LFOhGsKCVgliTlT
 AsjP9TAIlfz0QzsbEhj6ahkjp1uNknHEKFUwcz0jrrOAilVzYDRsV/RRPiGBkp7NP3AWTjgMbVV
 jO1tT8+5w4hG5D4o8fReik8Mv5kjO2HzHzLlBpL8pXKV/UVqivH2FzMY3D28Ao9YHaylsv0BekL
 AO5TgOQrA0ghfjk56pNRijQww3vCVVTQBqcZkBpx0582eYGbWVun8kAEpBw/HyNWQ8xVGm2kfAZ
 nEXskeZ8QnDhcOA==
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

Remove unused/unsupported Linux headers and add necessary U-Boot ones.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 80e304711345..5f522de44734 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -4,17 +4,14 @@
 
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
 #include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/regulator/driver.h>
-#include <linux/regulator/machine.h>
-#include <linux/regulator/of_regulator.h>
+#include <dm/device_compat.h>
+#include <dm/device.h>
+#include <dm/devres.h>
+#include <dm/lists.h>
+#include <power/regulator.h>
+#include <log.h>
 
 #include <soc/qcom/cmd-db.h>
 #include <soc/qcom/rpmh.h>
 

-- 
2.45.2

