Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F658CD11DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 18:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F8E0881E8;
	Thu, 28 Mar 2024 18:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JUoH7lbQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C6B5881C5; Thu, 28 Mar 2024 18:59:47 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AFB5881B9
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 18:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-341ccef5058so808679f8f.2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711648785; x=1712253585; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oFmODt990ad8kjLTTOpTYnAwB7mre5Em7KQhg5E3z/E=;
 b=JUoH7lbQfI0Ia9oaODe2wL/gqYC3FoPgjsyoEzaresbxN2pRSyiEJf4i4WkrHeb1Kz
 XbDo2Wxli2n1RPpFnNoIVVPId94gdAq1UmlS6kS63vAzQ8TpA2P7w0hSMPmWyaL6PqD+
 dAqUHmV+osLBAhdfa6HL8CPRsJJWI4/xGKTQ1qA9HODZ0HIavrXTKewIBOgwFrAxpdey
 oKTKzgj6CAFiWgmAN2bqQXyb/tZlHVOxsqIXx3Ykt1eLDtUZTLNWSlrcIYnxTsG2lX2B
 a+F/6i1QrPbckoYSxt8SKm6eOzVe9l9LaWOk97llywSPoCp9aZ01BAk3d7xL9uP3oibm
 ZPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711648785; x=1712253585;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFmODt990ad8kjLTTOpTYnAwB7mre5Em7KQhg5E3z/E=;
 b=iOK+oo4souOjjePlaKpvkWnneyWxUHfHIAayXW5C0LZbJTU0uEHp15MNcTCyC/WYa3
 8y70QAFPI29H9SrRuziSJWV2yaXsvYAqfBr1UP/7/mIvZj6CSyuOE3A41MUCCylSLtac
 1MBl8gPQ9Uf36knz6OWKW3d2A7EEOjIIu4IHfXcORi6ZOp1xopvONyH45yEY6lKnZwRG
 R06WXzWXdujoAMHtQotPWMG759+pp7uS4DwQr2iYyjEAeMk3630/zmO1lcbOTvPoum43
 00pJECQEIQ9JPcxOjAo0z2SzBXqRjdn4B5K7uhMfDxhn1MQCqgv75eY3Ms8OfJ4iJMJQ
 7ZZQ==
X-Gm-Message-State: AOJu0YwU/CGDM4zU20FIU8cYbQoU73HabAo4bUvySsv5i3fQnTSEp2Sm
 m3Ug9r1+BJNGu6g8szAtB5N+QOrhIeUSmfAmbIs50q4lagfFCmm7q4JEMFEr3zc=
X-Google-Smtp-Source: AGHT+IE52IrGBwkvJkWAls0IiaJzT0XvYZwClDirtZ5rT4FghSLK7eh/kI/nw/U4UsH6k+3equLhcg==
X-Received: by 2002:a5d:6585:0:b0:33e:d68a:7d42 with SMTP id
 q5-20020a5d6585000000b0033ed68a7d42mr2739987wru.30.1711648784952; 
 Thu, 28 Mar 2024 10:59:44 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a5d4acd000000b00341e5f487casm2292237wrs.46.2024.03.28.10.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 10:59:44 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 28 Mar 2024 17:59:10 +0000
Subject: [PATCH v5 04/16] mach-snapdragon: disable power-domains for
 pre-reloc drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-qcom-livetree-v5-4-4e98228b3d03@linaro.org>
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTWDZz9UbUzGK9YZ0+Z+E0ygsnn0sZbX4/yHWE74C8S/
 eTcqgS5jlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRpBaGf/ZvKqMZhJM+ijtF
 TIvWW6egpFO7wm+rFKP/lf8C6ZX/7jAyLLzM/dRJKvDmiV26ZYmz9WMWvJQKigmeq7Omzeiey0u
 T3QA=
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

