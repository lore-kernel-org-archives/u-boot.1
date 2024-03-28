Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7194CCD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 18:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34AFD83348;
	Thu, 28 Mar 2024 18:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iXd8FfLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CB928083F; Thu, 28 Mar 2024 18:59:55 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22224881CE
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 18:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-415447b16aaso6539695e9.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711648790; x=1712253590; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cgGFkOv1r6ZqedijumR44euV2V/PWTObj0uui6365Yw=;
 b=iXd8FfLthb5av+lRlbykNBLWxUKw4/4LrxY+orGjXppFuF2iaUtO1+gyTMp0kgRs5C
 7NUl7SvoXXXRsMX2sHozbCQ8UXwGOGaQtMeMq1tZUtDcE7h0E4ANod8VinRDcZ479RUh
 gktHRE5jRE2f9gNIcUmr6sWBNxLnZ+ZxIEdBnX4n9EEN0JMVo3anppIH0wmjAwpMZ8z3
 mSNjBnmcdArl67MNLn9OXuiWZK+94+BHYUcUuXU/s8/mIoD5vxy831eicpgSA1zFMSxA
 64ccuHqMdFO8QUAIQT+5BgkFybKVEj8cwXzoOPywmTsHMjZb4XRd01ZvkFXV9ZEDXEbL
 OjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711648790; x=1712253590;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgGFkOv1r6ZqedijumR44euV2V/PWTObj0uui6365Yw=;
 b=LV9u6/qgk4K9LVrnw51vVlL7WmaazuHr5m8il0vLCGrsl01+92nPTbPQ61ZMAMJUK4
 +nNEiHTEZ+CIdol+cVuX59gh4xjGYwrZo+Xd2wzNlO6ikzM/Yuwudk8X4QUvs0cuaZYV
 1URG0KZ+//4C39hrcVQObmyGLXnnfNovvavu3QSTBpSM92hZEbCr5LRANXLPned4emKj
 z54McB3yzev7D7vpygzojYAuWyzPfoMi89O2dA5QqWAKJRBODjGdvmw+06LjtI0WY2ct
 +Jsgl13h7FSYhnZyYynnP6SUizNCZffqd8/8RRxtMs0lM507oBmpmHpY7s007OMQiHse
 bBYg==
X-Gm-Message-State: AOJu0Yxh5MXz+Ld0A39LVPehKOycub6oY7BdWbdAhkH3r/lhRkkZrRrZ
 b3t/XCMBW65UOPdX8CG6Mebru45yQgm5/g00oyKD6POXUq32/uLN8J0+plFMsHI=
X-Google-Smtp-Source: AGHT+IExHIV0d5kAquQkv3vKlTeIBd1tL7BcTDnMWSUN8MftuXr0Eo2cGFCFrfh0X0LazseZdLW/Fw==
X-Received: by 2002:adf:f010:0:b0:33e:ca29:5a3 with SMTP id
 j16-20020adff010000000b0033eca2905a3mr2728579wro.23.1711648790708; 
 Thu, 28 Mar 2024 10:59:50 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a5d4acd000000b00341e5f487casm2292237wrs.46.2024.03.28.10.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 10:59:50 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 28 Mar 2024 17:59:15 +0000
Subject: [PATCH v5 09/16] serial: msm-geni: support livetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-qcom-livetree-v5-9-4e98228b3d03@linaro.org>
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTWDVxnTYJmLVRbmZX1cMdpVbOwH7M/TmxJ0OefuI+nz
 VtKQHx3RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZiI8CqGv1L6Rudvmvl8Ynz/
 r2tlg+hizrYXV7/0Srsdvr+5VMH28iZGhmZBjibJF8JbvH/5rZ3Mt1vgaUefVtjO74eLhCMT1od
 9Og8A
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

