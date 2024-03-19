Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE2FC54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEFE487F8C;
	Tue, 19 Mar 2024 13:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C9XiCCpj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDD6988019; Tue, 19 Mar 2024 13:22:51 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCB8A87F46
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41467d907f1so1855605e9.3
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850965; x=1711455765; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Eoaok36SvQE01AdxOcNaL/aWUYl1mN5YThpI9r4aJaY=;
 b=C9XiCCpj4buwH3gJg61aApwMe1eIQUTdrCAmXTgKOBL+b1duh/I8ZSsjeSJQEU22md
 A5FyhYquAli3tCfMyKlJYBdQjZ3+sz7YQWua9wCQ8i/fA/jSlJCEOtX3dufShfnbTDHC
 nlB4gwYOcTBrhbUhn+W2gyJBqa2WQkM6Vv8DjDeDb1fJeN0k3ImkucTF0t1gGzPN/rfJ
 kRuSg7z78B47alhg+jpS+71MXan2/rbINn2CpJwtEeXUueGugTE92AMvhBS2EZuvE3/+
 wXSSkCR+kiEE5RidKlOs1pYiwtGoMc+p8smh6X7mVNCtMoSlCTUQ945dExtfVP3eOzdz
 m9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850965; x=1711455765;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eoaok36SvQE01AdxOcNaL/aWUYl1mN5YThpI9r4aJaY=;
 b=wcouC2GEfKUEt6UtQIQDgxHpCYSv3hkwJnEF0nFO6vR61zYCwTv91+TxG+UbnUoLrs
 IzvtJQTYkYPV+93kfqFc3c+aG0gYW1dMzVa2CUjHdf5H/HYHMzRZmmBZsV2u3Py+Q2Ne
 WgtEHkz+rAbk9e/bXilAGWEyqCheBGDAQqlrlzsdJPyBNamNZF0poqt9rYg4w6j52shG
 VDXijgWpjfQay1AzHgXH5RVYs0kYfD4RhYG1zBcvad/jUFojBIP71TbEtyBlMgt3illQ
 ZbpPsg2noyPTElfTWv7iX/Bc3ePOCF76ewIOxR1xwrqcsf0r5WDg6UDyIyAOKURmeVQ1
 ZQRQ==
X-Gm-Message-State: AOJu0Yw1Lw2cQe/KOUUOWo4EfTDMqjcNcYQBqoOkH87Ok1JYiriJM5z2
 K1RFBxD4uuX6qrEswQN68XfZjRCyK4OkxNHsa1CNU5l7DifGdPE4+X79K/j3+WeF8BkYQID33QZ
 b
X-Google-Smtp-Source: AGHT+IHYvS2086FfyEFcNrJxZsn4CeOxj9slRORYWuwfePvMJXTNiWizffkS83swYCfdJbQrt/xtGg==
X-Received: by 2002:a5d:43cf:0:b0:33e:c593:bb08 with SMTP id
 v15-20020a5d43cf000000b0033ec593bb08mr9517040wrr.13.1710850965154; 
 Tue, 19 Mar 2024 05:22:45 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 du18-20020a0560000d5200b0033b7ce8b496sm12170498wrb.108.2024.03.19.05.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:22:44 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Mar 2024 12:22:08 +0000
Subject: [PATCH v3 09/14] serial: msm-geni: support livetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-b4-qcom-livetree-v3-9-e1b38d9b4fa4@linaro.org>
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=7XmFWhELu/gIzF9JO1Gaw5wYi1Mt7sIUuWsbtDfZ96Q=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSfzV2dT7cw/Tnq8PyHZHyHY4v3rpRbfruVgxIeuuxac
 t/lxBWVjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjARnwsM/6uqb0ydd7h87SpF
 xo3W+vUOqxTM+3U+WV/x3fr+iwtb/T2G/4VZTCWfOj9f9v8qHZIUPtNKsirwTb/UTNfQvz9W/lu
 9WRUA
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

When using OF_LIVE, the debug UART driver won't be probed if it's a
subnode of the geni-se-qup controller. Add a NOP driver for the
controller to correctly discover its child nodes.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/serial/serial_msm_geni.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index 4aa0bc8c72bc..5260474fb9a4 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -605,8 +605,21 @@ U_BOOT_DRIVER(serial_msm_geni) = {
 	.ops = &msm_serial_ops,
 	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
+static const struct udevice_id geniqup_ids[] = {
+	{ .compatible = "qcom,geni-se-qup" },
+	{ }
+};
+
+U_BOOT_DRIVER(geni_se_qup) = {
+	.name = "geni-se-qup",
+	.id = UCLASS_NOP,
+	.of_match = geniqup_ids,
+	.bind = dm_scan_fdt_dev,
+	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
+
 #ifdef CONFIG_DEBUG_UART_MSM_GENI
 
 static struct msm_serial_data init_serial_data = {
 	.base = CONFIG_VAL(DEBUG_UART_BASE)

-- 
2.44.0

