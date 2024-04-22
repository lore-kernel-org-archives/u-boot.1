Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99C6C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 11:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FC9A88791;
	Mon, 22 Apr 2024 13:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="MoU5VAkA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B686A883F7; Mon, 22 Apr 2024 13:44:07 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CFC688397
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 13:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41a70466b77so4116625e9.0
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 04:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713786245; x=1714391045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6SSe2eO+Lpq165vb84LS9XHZOQP2b1qqXfU81mqgABs=;
 b=MoU5VAkA26JW3AJVpRAKBRozKWhUAt329NVstw/en51s9FnD5ZKMsX3ysHl/nNXWe6
 j/uNlnafsUB56ScF1/2XJsyVof6EXEkA27Zc1WKUa8xMtsiIyUx5WaDrA5vjDp314qbq
 9g9uUsCvS8snPyba0zIFNbI9u1JgQ5ufF+8vgUU2SaI8W5s97yLS+kYt9naEqb4XqqoG
 T+FLOBjU/lHyxlYlWSAXaxNhN+qvQFLEQU/FhVOBPHCN4CyfojvMl873fP2Nn3RpuYBj
 SRklX8co6uqUJPe58FTswn68cE6y0297BRR3zfGu3C1hjNf4CfTJp3OVXfi39i+St1nO
 9IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713786245; x=1714391045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6SSe2eO+Lpq165vb84LS9XHZOQP2b1qqXfU81mqgABs=;
 b=kqkTKtZ2Z8KjgYKNIoYowlxQUlT39IAP7kD5qtpI/o1dWacX3E+Dkc3DvFxx/x6B7T
 Ij6ldd0PZL+pZuhxj/va/3fyRoXX4NXKLYdWcx/xV0PwpUx9nrquRVb1X5eKm4JX76PE
 76Icln2It6MyoaYCMDhIaO5spNwmWyMMb3VBXbo1uN8wY1Y6nC6uuvHprbNE3GY7C7zp
 5sleq0Wrf8od2gZSNnxeizlhdkzTdS6r4PkxQQleNmsxL742looRwrDNUv3mS47zkdHq
 Z080PF8p6E6aid8BAPhpea1hWbxQAOrGMT6Q7uliTMNAkVxWeMHPtaTJLDXBYC3ZLYSR
 moJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUruljERVKl5cQuWlH8Z75jnBpBSANRBpHGlrpKFznVPtKv/YlHEefhpVADwqRncv2btLVvQ3Asrg3JKlu8thGnv7F40w==
X-Gm-Message-State: AOJu0YxtdYOJrPpL7ycY2W0Z9NmEg1uRaxlRecYxfABlWHc0fHQl/SZm
 s13EnR6iefM6QKxLPMJZNgUrd7GomtPXBA2gBkyrRf9zfLvIpaDRnKDDsdBg2Qw=
X-Google-Smtp-Source: AGHT+IEDLm/BFRxTKwhM3AlrbT2IHMNQf2nGZ+jhyrqfBVA8fAq0Zlk5MpOJgaa9KY85kQGq/rbCww==
X-Received: by 2002:a05:600c:4ec8:b0:419:c823:5355 with SMTP id
 g8-20020a05600c4ec800b00419c8235355mr7509594wmq.17.1713786245138; 
 Mon, 22 Apr 2024 04:44:05 -0700 (PDT)
Received: from fedora.. (dh207-14-170.xnet.hr. [88.207.14.170])
 by smtp.googlemail.com with ESMTPSA id
 e5-20020adfe385000000b003455e5d2569sm12022977wrm.0.2024.04.22.04.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 04:44:04 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 4/5] pinctrl: qcom: ipq4019: enable DM_FLAG_PRE_RELOC
Date: Mon, 22 Apr 2024 13:43:27 +0200
Message-ID: <20240422114359.219762-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422114359.219762-1-robert.marko@sartura.hr>
References: <20240422114359.219762-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If compiled with logging and debug UART support, the following is printed:
serial_msm serial@78af000: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19

This is due to the fact that IPQ4019 pinctrl driver is not available prior
to relocation and thus MSM serial will fail probing as pinctrl provider is
not available.

So, lets enable DM_FLAG_PRE_RELOC for IPQ4019 pinctrl to fix this.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/pinctrl/qcom/pinctrl-ipq4019.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
index 4fcc4b1810..48644a51ae 100644
--- a/drivers/pinctrl/qcom/pinctrl-ipq4019.c
+++ b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
@@ -68,4 +68,5 @@ U_BOOT_DRIVER(pinctrl_ipq4019) = {
 	.of_match	= msm_pinctrl_ids,
 	.ops		= &msm_pinctrl_ops,
 	.bind		= msm_pinctrl_bind,
+	.flags		= DM_FLAG_PRE_RELOC,
 };
-- 
2.44.0

