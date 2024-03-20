Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA666C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7728E8811E;
	Wed, 20 Mar 2024 15:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uJh6uji8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61471880C5; Wed, 20 Mar 2024 15:57:26 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56202880F8
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:57:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d2509c66daso88416511fa.3
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710946644; x=1711551444; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P6XcPr9pfYOEmSnzHa2qooJBhM9QEIsjkS+to/+R8LA=;
 b=uJh6uji8lMdJBH0Q9kY2MLfW2dN30q0oMEcEUU+HchRW+72HQPJNj/1OsVkpG5+Csr
 Lgjd1UR945d+blUI3YS7dCtqRE+p3tAkqRgVr3qzBHDi52/pTMdgUtJDgXBXz/3gsFqx
 ynMKDocA4alseadAIIy1FhSqgh6fXGg3UTK/qVw6+KcZx1SyoqLbwsqPYzPQTyP+yDDR
 nmHAMCTLmONrNwOq0GSYiCnDICcsWMQpedoT5pEMM2Thr/P8vkRBwOAx3BkVLpz7wj9c
 uqn9ziWrtlNaqhaNbLo2nZcRceD25UsBw1YzAmyxXoeigjYL/t8CdEMn+TBycI5EVR5G
 aTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710946644; x=1711551444;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P6XcPr9pfYOEmSnzHa2qooJBhM9QEIsjkS+to/+R8LA=;
 b=Y+ntUhMBzp6pUbHsQDxJI/Di1QD6+dzuZPDdVMd/zRsBP4RRKBW/8OtUO9IrHGxdp4
 LHrpk3RwhaIoIMiVmI58GnUN3MdFoQamhcsOmltdHXeaVE4Z4gNqf9gTER2bRirqbjm5
 JQW6an8fo83vLQnPlhGPhET+RstAdoXARjIlRzs9CcxwWZMCLIgvXT724v36qiT86bkF
 HE0xCaKtuqxtw5sEUneNNC1TGNVYi98PdoolSIUCSgXY2VMTUx25+tA2Ol/aOD5YiwJ7
 5cIOWq01jt8+v9RiZ3SY83N0r+ZKTgqpvZofzDcAw3hb1+8/NkjYSARbeIaBlgtt/Jzn
 lGcg==
X-Gm-Message-State: AOJu0Yz7c3eT+IxspqW8MRJBqJOsX0MdVbQmqVOpD89YJ1giZ4xLtGZY
 WOt0zG8YqIkJ4qBIrU5Y7waPozjiSLn4m+oF4y7p2b04Sv01V88tGSerLxEr5+A=
X-Google-Smtp-Source: AGHT+IHUPEAlM9Kfi+He9g5VOLiXWNeJEfq1nRzmSxHatGxOoEM/lzNk3lpGfBtuxcwkF7hqPc+bmg==
X-Received: by 2002:a2e:b8d2:0:b0:2d4:375e:9e43 with SMTP id
 s18-20020a2eb8d2000000b002d4375e9e43mr13503102ljp.27.1710946643812; 
 Wed, 20 Mar 2024 07:57:23 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bi16-20020a05600c3d9000b0041468f79fd5sm2461268wmb.16.2024.03.20.07.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:57:23 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 20 Mar 2024 14:57:16 +0000
Subject: [PATCH v4 13/14] qcom_defconfig: enable livetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-b4-qcom-livetree-v4-13-d867ab1f06c2@linaro.org>
References: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
In-Reply-To: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=nJRZofJGcS/sPbnQvIzqGqi1p7++HEANmQebMMxA9oM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRfP52uewaX8kVvKHjXHfTx1B+5yS5CW1WyrTl++B/Q5
 Pqz4t2FjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjARThOG/2VbYvWm3yosOWBw
 MqRRxFHSStA/87Otu9LdZ6fvntweuY3hf6j6f8uI7cb/fwbUV1zdxXY433utv1iKpvSnL/HbJEJ
 mMgAA
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

