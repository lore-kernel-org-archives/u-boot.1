Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A518C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59D5E8803A;
	Fri, 15 Mar 2024 16:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XlPZEhnb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26AA287FF5; Fri, 15 Mar 2024 16:10:38 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 662678800F
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33e9def4a6dso1461180f8f.2
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515433; x=1711120233; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ik/CLzowJAROYo2NgNmeQLOoeZUcDXxXLIxLTfZ4zUQ=;
 b=XlPZEhnbkyde4WkzpFlK7CJ1Hz+aXLSRKjY7i4geS9j83lo3BJj/2AA5SvwBE08uXY
 zHMxbZBGNL2uhn8iGesN9QOyQ8vFfmeimhnIXY9O1uU9cTuuqjjkgVj/G4B3X07hSZB7
 n/A869ftlQDLbOF3W/Ab0k5vTHV4yvcZhzluJTPunfZ5t6E0tnop/+ZpIGT2pFcDQ1xq
 tpveWOp/J44hkDDo/mp3zpB4sZQdlS2yOnxg1Rrk1mqFJ1BQ3Xq4i0G5eKmt/S4NGwTO
 9Ksx/7LEP3NNwEW1iL2a/5o9hD0avqRi56SietvKIyjnnHfuopU5Sc6Yz3IBrTnQo2j9
 InsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515433; x=1711120233;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ik/CLzowJAROYo2NgNmeQLOoeZUcDXxXLIxLTfZ4zUQ=;
 b=NuY75qBZXpMvkFRmi+BrzyWBlN5Xn4Kv6z/isC+br9RWfvJLlrNTq++K2LvabPeT3i
 sURt4PWdJkAbPjfwPI4nFqfT6gUl6bbPesb7jm4NlFjykOAZ4pUieNyn8cL/yGWTkO8U
 NY/wDoHcDjx3OMvMEGU463KBA5CHRsX8Gaoi19qszs9bpsqOrM0EHTi65lfbZ7git+uP
 UbManwqt7X6Tabgf5S3SO8Da+ltIgOZxRGyiH2r3wyVuD3RIkK7ML51tHTKTMGSfvH4K
 dhtkq3oQsgi9AyOCGi7E6J6zuG/k6vneTTXbGAw5la6BjZ/k8wNQ1RqDWqInRWXyii5r
 XQrA==
X-Gm-Message-State: AOJu0YwlSp8Nefri+XnIvG0+ksmxwwJsfo7AfHmDW2+TjLrbdnA0mCWd
 iJ1YlgUbz9hzsTpkraAv1MUPKKuCv25hH1VBHpPyB2AqjjgzpFAJEs2mvoXEkfLU9sLlhyzzrY6
 w
X-Google-Smtp-Source: AGHT+IGhXF6P3jz+FJsx39v1xCsky/rVg3iT+NshVJqN8nRfwsUgRKNkyattL0AQ0U43vyXwYdZX7Q==
X-Received: by 2002:a5d:69cd:0:b0:33e:c4c3:6f with SMTP id
 s13-20020a5d69cd000000b0033ec4c3006fmr2826672wrw.64.1710515432756; 
 Fri, 15 Mar 2024 08:10:32 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d4006000000b0033e699fc6b4sm3398141wrp.69.2024.03.15.08.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:10:32 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 15 Mar 2024 15:10:13 +0000
Subject: [PATCH v2 04/14] mach-snapdragon: disable power-domains for
 pre-reloc drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-qcom-livetree-v2-4-ab635774b2dc@linaro.org>
References: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
In-Reply-To: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2163;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=t1kvVGeh4i1zKEXYViR55Wh180+iwZWUeqzwnZOWrZs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvKY9ZJi7v/uDBbhtT4R4ww1v0eVqOSuH1s0vDgmo/G
 h/nXTO9o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzkfCEjw8wDxs+b5xnODjw/
 Kfu2t39GTu2Jts0uE7nSbsyXq5ZJ/crwVyB81SybkpDQLz+jnj3kepe6S5G5NTPGybvdN1bru8J
 6YQA=
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

