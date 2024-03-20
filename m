Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EB8C6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D068880AB;
	Wed, 20 Mar 2024 15:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HHCC4aHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FF5E87DF8; Wed, 20 Mar 2024 15:57:16 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDE8B88047
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:57:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-414701303f7so259475e9.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710946633; x=1711551433; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oFmODt990ad8kjLTTOpTYnAwB7mre5Em7KQhg5E3z/E=;
 b=HHCC4aHcJ1bvGiVxgLtIeVHqKDvXi1t8gFRJ9FwIdoYNZDNcC3k0WlLLcTwvFcIb9G
 ZEL+Q7ODQAPMkY9fPlQiryCJI+hbl2FjPVFLvrNYhYmTHa92hpB+lnPnhxgLhGDSD2PJ
 qWIGGo/mySorlq9htM7c37xn3ia1kGKRRoTl97Ab9JzyZFbX+BRx+ESSg0FCC+a7117p
 D+eeCbyfQ7tnmAYxooMVfqr7Wdxms1v/DyGkAu50l7eDILZeUn1AtOFDjJSivqIp9SrU
 +im/kNNSKIJoQ1tHk+3XcDWfp6UpV9/SCwmOftuiUfoKldYrZxQSEr6g1nHvAn5Arzpg
 w8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710946633; x=1711551433;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFmODt990ad8kjLTTOpTYnAwB7mre5Em7KQhg5E3z/E=;
 b=F8TEV55mZkov9EP8IpFDYjamLjiweqnOS0/MuAnb06Hk0Fxhu1VejjsQFC7HHxC0W3
 lNoeWtJqSDUwvmjZUC4rXJ/VrRzouEFeBC3USDHCFPHCFE185faiUN+TdOQ+pWCmvUnE
 mh5d/+vw1wp6+taryNRYfliZOxb/9vIIyFZ2WWu9ijdx0SnMno8REcguVTFYy0bk2qYe
 VddaqFHXewdAy0V1qFxwsN532PLsQMjpxBRWh0tGM8w7UOXimJxjKWALRw9QT6xD2MR2
 pqJLI41Ml+NuncYi6cBw3vKjOrn+Sds1vP95fa67ISo1VTAIZke6O7RxX5SEGiq0wkjk
 6n/w==
X-Gm-Message-State: AOJu0Yw7dKpP+YoA1kHC1iumZzp+O/Uas/nEYqSXLHdrJ9SkwTpiooWz
 1d4vtRQt01AGIDINSL3/xUSLHEehybskhRf1xPKKbHXTU6KkLHaNFWqwOWSQA5k=
X-Google-Smtp-Source: AGHT+IESTDpMUVNeMWvP/cgQ416i+C5QEtBaw3IRk7bRRn1jnrr4KJlkpf7U52Pz5E/nZSOMwrYVig==
X-Received: by 2002:a05:600c:35c8:b0:413:feed:b309 with SMTP id
 r8-20020a05600c35c800b00413feedb309mr12164123wmq.6.1710946633497; 
 Wed, 20 Mar 2024 07:57:13 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bi16-20020a05600c3d9000b0041468f79fd5sm2461268wmb.16.2024.03.20.07.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:57:12 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 20 Mar 2024 14:57:07 +0000
Subject: [PATCH v4 04/14] mach-snapdragon: disable power-domains for
 pre-reloc drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-b4-qcom-livetree-v4-4-d867ab1f06c2@linaro.org>
References: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
In-Reply-To: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2212;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=lNaop02wGgSTfoA1P61dU8gqi6TppeaoShUOEotMpkk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRfPx0j2LKlgic8cBeVPdodG2bVZBzyYnbU0o0P2jKYV
 F5cdvnTUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACay8gLDP8trW3RP3ZrmObO+
 y/v59Jsbb+SVLQhysz8WpROQWFfqoMfwV0DERfnm5M8VicFaWiYeFtWP+7PmeSyPsM40kfk47aL
 hOQA=
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

Some devices like the UART and clock controller reference an RPM(h)
power domain. We don't support this device in U-Boot, so add
DM_FLAG_DEFAULT_PD_CTRL_OFF to tell DM core not to try and enable the
power domain.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-qcom.c    | 2 ++
 drivers/clk/qcom/clock-sdm845.c  | 2 +-
 drivers/serial/serial_msm_geni.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 7a5938a06a34..6303dcbf8461 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -226,8 +226,9 @@ U_BOOT_DRIVER(qcom_clk) = {
 	.id		= UCLASS_CLK,
 	.ops		= &msm_clk_ops,
 	.priv_auto	= sizeof(struct msm_clk_priv),
 	.probe		= msm_clk_probe,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
 int qcom_cc_bind(struct udevice *parent)
 {
@@ -410,5 +411,6 @@ U_BOOT_DRIVER(qcom_power) = {
 	.name = "qcom_power",
 	.id = UCLASS_POWER_DOMAIN,
 	.ops = &qcom_power_ops,
 	.probe = qcom_power_probe,
+	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index 36ffee79d966..babd83119e2c 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -182,6 +182,6 @@ U_BOOT_DRIVER(gcc_sdm845) = {
 	.name		= "gcc_sdm845",
 	.id		= UCLASS_NOP,
 	.of_match	= gcc_sdm845_of_match,
 	.bind		= qcom_cc_bind,
-	.flags		= DM_FLAG_PRE_RELOC,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index e5c3dcffc1c6..4aa0bc8c72bc 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -602,9 +602,9 @@ U_BOOT_DRIVER(serial_msm_geni) = {
 	.of_to_plat = msm_serial_ofdata_to_platdata,
 	.priv_auto = sizeof(struct msm_serial_data),
 	.probe = msm_serial_probe,
 	.ops = &msm_serial_ops,
-	.flags = DM_FLAG_PRE_RELOC,
+	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
 #ifdef CONFIG_DEBUG_UART_MSM_GENI
 

-- 
2.44.0

