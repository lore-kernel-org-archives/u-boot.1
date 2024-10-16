Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551C7D1AD30
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 09:17:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C473088D5A;
	Wed, 16 Oct 2024 11:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E2P644pi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08E2888CC9; Wed, 16 Oct 2024 11:17:21 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FE7C88E81
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-430558cddbeso4581695e9.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 02:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729070238; x=1729675038; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/8GtmWHppBcSxtUCLO/+/IhpHyZGG06NI70yZcTePuQ=;
 b=E2P644pioPbF4JgoLWh3P65cD84qVRI5ml7gcENkMZuVZh1Dx4yUWd2Up/JAMkluHc
 h0w7rum+fQ3dMyP9Y1FFbri2JdplISLunW0wIAEbRAEfsu3YNyT7f1xSmdfHmCEA6vyq
 xQW7NQRBNneExPXW6jHWK0568J1RIBhcYWGO9jJfMhFW2E1P22Ft9a3KJ5/MjkC7Ftmz
 wGR+L+pPcH9kiKH9xUBDp0nLdmd9EXfGMrNU6vIF2QZAuQZOWw5ezPuj5ySSG+GIKDgf
 GWv2tPEqJU8C4KNURe0qAPZbFg0ZS1MBKmTAfxYbfo4lOrrUJfowqjEnTVcw8iL2uqx7
 9jOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729070238; x=1729675038;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/8GtmWHppBcSxtUCLO/+/IhpHyZGG06NI70yZcTePuQ=;
 b=hXmMfdpUDY8EWpHovRDn7r1n99RUcfunXlYQ5I/xq1OMFeD/KMQBHrEDlENUNrMlPh
 am9BUNLuJNi1BLyUhdFB/GnHI3obaco55d9JsQkVH56qDD5Tq9JO3VMiT8Pw2nq+Vfw4
 nFoquczNyKVOYE7MYgWR6E796Gse/4q7FKIloIw6+xJdbUT8ZchO+k7tcTE+OLi64Qvr
 iqCNf1xXvw6zAPhXTgvs6VVEBAdbadArYndmG79GDe5kXwauRUb6uGarMrs7O5jvoDjs
 r4jTQkVtYD6uLa3vweJ4uW1y7pA/MaXXZe+AjUE2P9/P2dDrXj6XOsrF+IfzoqJKDL0J
 sRIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmMyqHaTwnXXccH0JE0hgr1bQuAUiu7G73GNAvz1xaybmFK/YRYGIRIoB0sOlT50Lpa1XnGnY=@lists.denx.de
X-Gm-Message-State: AOJu0YxqXid7jr/q+WUlF6UHg7L86JI1PzpusVgR1HAFv90UgDDPXiyR
 a5c7WJTlAyyt3+YaX2MeFMxu0fBD2nsfnpFWN9vvaOXUEpO1mbvxXz8JRPt2sWU=
X-Google-Smtp-Source: AGHT+IFB1mmo7u38teZ9VNAjTIWmVsi2Dig/AQmcO1132yLJZuNHAG4+AIHmHaY/ccbQk0iHvEv6LQ==
X-Received: by 2002:a05:600c:4f05:b0:42f:84ec:3e0 with SMTP id
 5b1f17b1804b1-4314a31d5cbmr28548045e9.9.1729070238468; 
 Wed, 16 Oct 2024 02:17:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f55df34sm43638725e9.6.2024.10.16.02.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 02:17:18 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 16 Oct 2024 11:17:16 +0200
Subject: [PATCH] mmc: msm_sdhci: enable vqmmc at probe if available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-topic-sm8x50-mmc-vqmmc-v1-1-767af5351d37@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJuED2cC/x2MSQqAMAwAvyI5G2jEDb8iHjRGzaEurRRB/LvVy
 8AcZm7w4lQ8NMkNToJ63dYolCbAS7/OgjpGh8xkORkq8dx2ZfS2vgqD1jKG4+NQ8VRTVQoXBDH
 enUx6/eO2e54X2MKHLmgAAAA=
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1603;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=VMwvYlTzgoeigz6ub9LcdNP8Df1wgk0qQOjlnPSClR0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnD4SdiPJRhAEj2vCB+D0R/iK3mDol1CZhvdkq/K/1
 iiBvsV2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZw+EnQAKCRB33NvayMhJ0bKIEA
 CIXHF3hiFjaGBY623ABS6VojZ2MfLFOZ6sBFdDOKTk0NKizB+Z+Vo0ezi59Modunlgd7/Cag5r/PZ9
 rMoAWdQAFCyLbCnyu1xsvflT2sY/Tc/tvyoag11+/S1Fg791VsQIZi1vOEmBfDJNjOuwLwEmLsP7G3
 GbQr7OpvAJfVwQ+2Gy5ZrwtbTyvyhFj/XrwPBNsMVwiAtMtQ76GSeAD7fcSMWD9/Tq6jQXaceMUovX
 VpD7O/vdDJIScwr/IMrkXmKxV/lAOwhVQIy/SaKpw1Jpoq7YWIDGGcDKIkBtn0T42uTbjjXpqZKvNY
 qBSPe32PKe5CEwgfgLNbmSgUXz3n8OeRozVZyLomVEc3A0xz7e/CnYUGKaUG4KyC3eZ6vuMKHwNuhU
 pEd8rz54sqFrGmERw7dmOL5MPGjgGEPtP0QBXxWQ0LpSP5rnQLoHTUTj/xIyUjxZ7yW6wFqosHmEDX
 bIOgHIgUySN6WeML04MX1XImTijPlDZp6aUVPtSx8PRWnhV7zoGcpUkRWG+b9yo8IwVl1JaE5z+lPA
 dsvvWzZ0syf0GRMWd0cbKxsoXEWYsfXi728RUDzHGreUd4XVlCug14miWY7BtgnBCPyexu5HhEosYL
 ROs+9HhoImtiGDS5Y+sBQi6Katn4FCPhLi8pMAQkDHvxtyc/WZhikD1/jDiQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

On earlier platforms, the vqmmc regulator was enabled by the
previous bootloader, but on the newest (SM8650) it's not
and we need vqmmc to be enabled in order to have the card
to respond.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/mmc/msm_sdhci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 4e5c932c071..27bb7052fca 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -15,6 +15,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <power/regulator.h>
 
 /* Non-standard registers needed for SDHCI startup */
 #define SDCC_MCI_POWER   0x0
@@ -43,6 +44,7 @@ struct msm_sdhc {
 	struct sdhci_host host;
 	void *base;
 	struct clk_bulk clks;
+	struct udevice *vqmmc;
 };
 
 struct msm_sdhc_variant_info {
@@ -163,6 +165,16 @@ static int msm_sdc_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	/* Get the vqmmc regulator and enable it if available */
+	device_get_supply_regulator(dev, "vqmmc-supply", &prv->vqmmc);
+	if (prv->vqmmc) {
+		ret = regulator_set_enable_if_allowed(prv->vqmmc, true);
+		if (ret) {
+			printf("Failed to enable the VQMMC regulator\n");
+			return ret;
+		}
+	}
+
 	var_info = (void *)dev_get_driver_data(dev);
 	if (!var_info->mci_removed) {
 		ret = msm_sdc_mci_init(prv);

---
base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
change-id: 20241016-topic-sm8x50-mmc-vqmmc-b7cf8176ec51

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

