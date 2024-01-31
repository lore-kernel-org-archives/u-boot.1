Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD67FC47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 15:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C31E87D18;
	Wed, 31 Jan 2024 16:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wGq4/tp3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AD4987DD8; Wed, 31 Jan 2024 16:17:13 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57BDD87D7E
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 16:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40ef6f10b56so26391315e9.2
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706714228; x=1707319028; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9d6pK+oluV5IpInoW43059fRkUOQBE+4Tw5fwZZIJpI=;
 b=wGq4/tp3O7pJ58by8H16Y1h5RJ2BPtWvrrqISK8waNpoxb0K8RF5st6Qp/5gQkVWdq
 d27YD+AnEHL8ZKz0haPVBPUVR1mA/+TrdeBZRCaThLED7wSyjwgBm4LnyGz1VkwlvNX5
 r0u6JCMC+h2TNoDg/kYnn1BZRdK8JFcEiprZWYQ7wXNg7a5iLCRYbIhnLQrqP3GeTT6W
 sdM5r4YXFkBZtsN5huyUjjYy++he4QbCty83N2IblQ8HLCG8VeBLL1adppSr3+m0gP2x
 oxbsHSrRv2My+j6V6mT35JFe8XzpZzlmDUjunEDWVZNEK4T48sqbTTXWf06m53TE4i96
 Mz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706714228; x=1707319028;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9d6pK+oluV5IpInoW43059fRkUOQBE+4Tw5fwZZIJpI=;
 b=jcW0DyaRdu3dI0vMdGYH1Hhnku1X7YJo3lRvheSgGIlYgdLgIfM2f3V6c91W4D8inN
 gLz6cdvIl44YVsee6AsSkbjoVjD5xgj13OnIME4My9nN1GcMsHO6zUaavlaeyK2WcUPO
 UF6IZklPXhqbqNZFRW2DhaUNWCb2iPmM4C5d/FTOEghjlChlkd0E3rGllm2rVCvVBd1O
 xT8VfsO++ZAbtZsi2Gb/bxer/36tnFOA/suZp3rDIq7KXiBzbolvZEBOEla/5fnJbvbp
 A+Nrth1IOfl4GsxnpxiskqGS2ba5N5EuUzTgeA6c28ZxJNu8QE76UYTDTW+yvO/d3JYN
 +8xQ==
X-Gm-Message-State: AOJu0Yzly9L6slxJ0+npCynjCdFBcwtqMVpR5abxdEKXCwBQe1OdRzle
 YFBKDxnFFUI+p/1tVR2B2sR9nwrQ4v80LpkTxnqIe1iQ87QdNrPv3amcJGBCeSD2dAwnrBgg7CJ
 g
X-Google-Smtp-Source: AGHT+IFJ4C1QJSvUaXMjK7QtcZrq/XJ4ofzGOYJQwdMglcJT/IZ/h0DDMevTFGOAB8DmLSrwBnqVkA==
X-Received: by 2002:a05:600c:3544:b0:40f:b335:fe7c with SMTP id
 i4-20020a05600c354400b0040fb335fe7cmr1470483wmq.39.1706714228657; 
 Wed, 31 Jan 2024 07:17:08 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 en6-20020a056000420600b0033ae5b637d4sm11109031wrb.35.2024.01.31.07.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 07:17:08 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 31 Jan 2024 15:17:00 +0000
Subject: [PATCH 08/13] serial: msm-geni: support livetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-b4-qcom-livetree-v1-8-4071c0787db0@linaro.org>
References: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
In-Reply-To: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=kxKkRT67ZfSHqA1UC4TLHGzsRNTPg9F90ko30AeYXqo=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRdKTm5BtZ/fkvfmTPl6veP4dwJF3aErxcovjDxdn/xA
 velBseWdpSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJ6CYw/M96snFaVtT73DQn
 W6dZhc9Xqd2wnnNc18n7bP7l19/C0lUZ/lkruOxc+sg83bhvttT7DwGJd6tm/Jq268ero/bV97l
 mndcFAA==
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/serial/serial_msm_geni.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index e5c3dcffc1c6..6455b0fff63c 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -606,6 +606,19 @@ U_BOOT_DRIVER(serial_msm_geni) = {
 	.flags = DM_FLAG_PRE_RELOC,
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
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
 #ifdef CONFIG_DEBUG_UART_MSM_GENI
 
 static struct msm_serial_data init_serial_data = {

-- 
2.43.0

