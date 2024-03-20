Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0ED3C6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C559388104;
	Wed, 20 Mar 2024 15:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CWOCoUYl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 644E58809C; Wed, 20 Mar 2024 15:57:22 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43430880F1
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4146feb33e1so624905e9.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710946640; x=1711551440; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cgGFkOv1r6ZqedijumR44euV2V/PWTObj0uui6365Yw=;
 b=CWOCoUYl6yupj7ZhUDOGG+fJY/TX090mC+2p4m83QAHwRXzk9YAY/x7wbpQhL7t6nh
 bnnn2pcRY96WLE1Nyz3zwZGie8zJjciY6fiKxhKgo36o7Uhu+zEt2qjl3bwHsfYpmJcC
 QD+1TUx4QXYdrIVdH/2Di30x5RcNq6kxmakItMubzmzowOk6eQbWvFgYb9OIkXrERRcP
 2cm/Ain9l+lz9oxC9ZvSr0/AX4AR3tO71z9rHlj39cGbZTcZAwNQFirZBPlGMCh5Hlzi
 IOXXR+HK3hRu0SW76UXYwKROf4WDvyzGQ3/kMPwvP/p2E5mqfrGLrcnQXMQ1XKwayC5o
 0kYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710946640; x=1711551440;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgGFkOv1r6ZqedijumR44euV2V/PWTObj0uui6365Yw=;
 b=WrGnpH9mjNxszOj/hYXBZIChbFKR9Q7pBdEH/PTRpU4JZdPC08ZTf6uShyCijkepd4
 ZbBkg6tmBWhFCH3FUX2Ow7s+e6cLHICV4o+uyoXuIpuV+PNSO4rrIZR2sJKfC0kdHuR+
 AAHrQUQUn3I0VCd8vagZYCgRSnPLQNmX4+7b9uD1jixjffHoAMFA3B4dA+hxwef1O1HI
 pfbh1YUBGlhEbu2k/LVVm+s7DD5kgHIg4SZz16g6U1VHtL156norUl5+Va5gaiaEAP8L
 /jXqfOSLyjvnrxFlPKXdEDAGYBnQ/3w34ixkevOICu0kxvWZtitJgXXG9HbG+q50haOP
 U4aw==
X-Gm-Message-State: AOJu0YyN8lQh1bzXQrGdatAJtYtUjsJmwwGdo5VLSpfA5e2jhmDHZapt
 v3oXNVtg4xzI38xnzGex3kwUoWnBbHla4Bfq49KeILKcTr/svXlE5uGOlW6oTkw=
X-Google-Smtp-Source: AGHT+IGRMug3fliQ3oVuRrzoynmgGS4PDtkqWtE7RB98O1RIWVdZm8JVNeuT7wRfPov9+CZbTe5vTg==
X-Received: by 2002:a05:600c:1c19:b0:414:63c6:8665 with SMTP id
 j25-20020a05600c1c1900b0041463c68665mr4644700wms.2.1710946639896; 
 Wed, 20 Mar 2024 07:57:19 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bi16-20020a05600c3d9000b0041468f79fd5sm2461268wmb.16.2024.03.20.07.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:57:19 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 20 Mar 2024 14:57:12 +0000
Subject: [PATCH v4 09/14] serial: msm-geni: support livetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-b4-qcom-livetree-v4-9-d867ab1f06c2@linaro.org>
References: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
In-Reply-To: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=e9QvEtgQXqVS65y/B+mDQKCzyUPIH18kPws1KWRjbZI=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRfP51Yj008uO/B8p5PljLzv15sK7Fx6L0g2d0jccTcb
 v++W3m8HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiRicYGdZJul34OuPP4zQl
 8buNS+UYmLJmJcpI1hSVZWveMin4/IyRYcVD15CHkl3G5T0lC9MjvF8E5HBL1IY3VBgI5jnvPX+
 iAwA=
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
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
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

