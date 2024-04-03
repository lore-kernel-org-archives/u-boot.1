Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8D0CD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07EAE883C3;
	Wed,  3 Apr 2024 14:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f7tMCc/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF593883BA; Wed,  3 Apr 2024 14:08:09 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E5D8883BC
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a4e39f5030dso650516666b.0
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712146084; x=1712750884; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dkr+CmAQ64eUqOg4M49/tTSWR5zwY0MG3Z7wMHd84mg=;
 b=f7tMCc/5xuqSxA2NwVpwRrfVH9ZVqZMojSILnxnG/qyprINn6XpU6e6tHb0GS+i2hy
 +hst8fB4QZtyj7rcz8u+CkKdoC85fZIgDsfiah8EL1RPYyPPL+vnCGtykrnVU34BTOI1
 /lDOpP8ll4E5y5pbUyjgi8A3JEe7AvBF77J1YpE/JqwFzhhdHYw64HOG9cmnALLxgBpZ
 1PPxacRYigFxsDd+nrUIIP9iIQeXBlpZD9U68lzWttTMNb9iw4EIhnt2vts3MrAuoMwd
 NzDofkfm7riBIWWE1ZmHG0L8RAVTkVrLOGSgLmL9qrVCkZvYbs8PEwK7y9cXZ69QZx1D
 4pYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712146084; x=1712750884;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dkr+CmAQ64eUqOg4M49/tTSWR5zwY0MG3Z7wMHd84mg=;
 b=AY9gIglPASP4fKal2GeUt48TPiHLviNRPh9cXyjka1gt1xyq5HzbYEOgiwFaNfRCqF
 bjyiCHHRaeF93AUvsKBJyseeu1dzQpFuprKfUCRyMKuR4WilfrqK9GUh9yrlYJohKcpu
 52FznGh4ZZ6hRczB+cUWlM8JWSVweyA8xxH1z73hrrya5c0Tn8XPYnKaTi0KjYAnjxN7
 5/p54O2Siawl46Y/KIVu81j51Tf0n0FvKavrGXSB7v5Oh4LDCGUTbsMH3CkHZRAw0NNl
 VHpFJ8+iheLHktYu20SdTxq5Yq/9tXzTWWgHQBY6NcgKV9BpIQJD54unW+wAtOzistIF
 aRhQ==
X-Gm-Message-State: AOJu0Ywl09E8iYJt1DJ4jHF/x81DwBf5dI4GkeiQAfUoEwm+o58i0G0N
 z8WgT3DTANNAOSeMSykgk7e70LZ7vDlJtdFkIvs3sK1P4oV5mNlEBAMTKCttg4c=
X-Google-Smtp-Source: AGHT+IH8OHUQLuLK74/rl7dH6AjuR8hfs1lKAg1p5yOCFzrWosf/erDztz2UGJA4kTR2EILSXHZ9Tw==
X-Received: by 2002:a17:906:5794:b0:a4e:7b8e:35ae with SMTP id
 k20-20020a170906579400b00a4e7b8e35aemr4946670ejq.38.1712146084063; 
 Wed, 03 Apr 2024 05:08:04 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::38e6])
 by smtp.gmail.com with ESMTPSA id
 lr20-20020a170906fb9400b00a46a04d7dc4sm7654674ejb.61.2024.04.03.05.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 05:08:03 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 03 Apr 2024 14:07:49 +0200
Subject: [PATCH v6 14/16] qcom_defconfig: enable livetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-b4-qcom-livetree-v6-14-130f8f50b538@linaro.org>
References: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
In-Reply-To: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=FnsFYaj7bNmRgQrn2qeK5nE0SjWYSdwas1Nyt0LNrPk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmDUaRNjL0dpjtsO/f/nGBGvsouO+laHYNvvFVZ
 RL+UaRbG36JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZg1GkQAKCRAFgzErGV9k
 tpxlD/45EFB1QPcNTGXXbiZVVMrDUCPk1mv9NgMJHvcAgsX4usbflk2lcQUoDzW35GEMOIlMHsx
 Q0CRRaOhP5T1WyuXq8n38TmIgg0KDg9r5WvG5NqUlHMkSoN5x2BZz0vkIh96moE0AGMsBTtDcHh
 rRddm2tDd5TQIw2VuKot30CQyI8Qpzfc/JUMKY3HKv75XSwWw6+jfwKTNfvk8/lmsXuKDFChJFD
 6xMS4KseCxN+3L+gFfmuO6S9SpEpKiqNzqqQZkib0fzRIPSbBAjmWnb4flO5uIPej2644tlh4Ur
 mqg8Chjd7IqDxHYkd3Rhba5Nw7qr5XZsIHovwVCbAcgiJ4+hS/N6t80UZTsDM0QUDJ34EKdb0ZM
 uKh7jOs7otAws/I1Sw2eajPXwg6ng1SEI/5iYEfvx9ycqMZQPR4+Vk9oa+fnYOwZsLnoUKwioD5
 SKmmoxohg9Wu9JJMVl6mINOP+m2to/oR4w9gjKV9z9QSOPezVdKykymQeylyxJaXzV1uRyGlKD2
 lQuuvsN32ak9Votp64bUiIBWO5yDDFAgqC94qL1UJp0PPEWW12iXyapqiwmo5goUKhDZIHareKk
 z6OeGznL1kX4oGc+VvBizs5oO+8wAbIwkv1cecbh1Rw+lkJIdpUjag3QVyqovi4jqZFcZ870kRR
 StdqN9seckz1Alw==
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

Qualcomm FDTs are on the larger size, and with the addition of DT
modifications during board_init() it makes sense to enable OF_LIVE
globally. The cost of building the tree should be offset by the
increased efficiency at which we can walk it.

Some rough measurements with CONFIG_BOOTSTAGE suggests that this might
add 0.1-0.2ms to the boot-to-console time. However the reset-to-reset
timer difference is in the range of 0.5ms so this could just be noise.

Suffice to say, no significant slow down.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index cbc612b44bd9..8c4402e8f780 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -25,8 +25,9 @@ CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_LOG=y
+CONFIG_OF_LIVE=y
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_SDM845=y

-- 
2.44.0

