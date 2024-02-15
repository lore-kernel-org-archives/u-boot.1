Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812A5C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CABFE87ED9;
	Thu, 15 Feb 2024 21:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qKpWzXQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6720887F4B; Thu, 15 Feb 2024 21:53:09 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F88487ECE
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33cd57b7eabso627023f8f.2
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030360; x=1708635160; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WSPw/Xa9El4BVSTPMMpD9ZBnhbB6D3kNScsbPfg+72o=;
 b=qKpWzXQOohlCtON7ujx414a8QViYCE8tBwOlptieVI5MnxtIlINbv78pc+IY4Wwf+C
 7NrwUA4SgN2fyf5IeIXgTjRo307JczmT9h3o/uNYrNsfby+8QNtYsfU0XYbOnxmpedVX
 B7bLLkbFP46eLcPk51uBlcV2uq3CHbfrfEif8+nKAZP28zPHJQyaKnKzuPvDqaeHgrao
 +SUeknRzFkuh+EgAeqSdrAlRRt+G8IRcc+sNPnY2MuZz0ZbnZFk8cgynnRUaDv7qA6qg
 BVGQuND1e74r6ncQLqx7Es8vDy1KB+s5huQz+OgG7vPmKCZSe5at6io2nVbNcREmIHTc
 vDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030360; x=1708635160;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WSPw/Xa9El4BVSTPMMpD9ZBnhbB6D3kNScsbPfg+72o=;
 b=YTM0MmSO4vNfe7l6jiV4AWfh446HUPtSAT3jN8pGpAgNA5DOhdeX0pJhgvqdGgBYpp
 XMcM4ddurCPtBx7WLrPygnB16HVa6ukCj+7JnNIyRbhkSpT/zzUfKEr0mVA+DPHf7OWd
 oSJFRQp7Lkro91W4dvVmmWGFqHhFLs075wsGfr8NRuGawCFsgH5I6hve1hBzb2qsEiM1
 B3S3hLaj/fjdkO1PdHymcZwRdEnDhtLU9orx9qh8QjfihVKtJDKFgg4tLZ5PaHBZVD3B
 /I0x13u6+uQiGCk/gbUWUSaryunMHSFWrP8ibzmb/YawpAmzI6zs6prJ0UJYAvkq0jdP
 Loxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU17Ytl/snWx9uKqAKYqlFD+wJUOeoPAlIWvjaHNAOqThyztM1Qn1tkgWN6K0tIo09whu9bqAwdVWF9ZfFKVRPyI0SgHQ==
X-Gm-Message-State: AOJu0YzDFMzbBmAnRcUGpVRIUc5otum7sG0cdx66HRSqO3DXKkjf/soI
 wnXUEeoqjtbvCLKtPXAuRAd9st7QjkAgml0Z8NyQ9h3juP4Z2yD9JcFDV56Sxr59EjxRGazWCQ2
 q
X-Google-Smtp-Source: AGHT+IEVBhxST0mvvLGLzFrXgWeSiKvUw/t4nvQsSZCM5GzWix+7laESkADeDLiHXyqAw3VJNtsoJQ==
X-Received: by 2002:a5d:4d0d:0:b0:33b:481e:8ddd with SMTP id
 z13-20020a5d4d0d000000b0033b481e8dddmr1971771wrt.62.1708030360634; 
 Thu, 15 Feb 2024 12:52:40 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:40 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:34 +0000
Subject: [PATCH v4 16/39] board: dragonboard410c: add chainloaded config
 fragment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-16-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=932;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=4U4HyWFoaDUZTFMsNyec+ppeQHwhPwsT32K3VEV4t4c=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzla1OzhIK7+O1Flw4pF2f4uDPwHBEyHbuzp8+be9rG
 rWn6Ft1lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIlYRzH8z/A5xChQ7v/q81kj
 1ony0X6377NxKLb//cp9pCrG/3uvF8P/1Pfp5zMT88Xvsu34NLVEfE5csO+TZHbVE6G+X7tL3ui
 2AQA=
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

Add a config fragment for building U-Boot such that it can be
chainloaded by aboot/LK rather than being flashed directly to the aboot
partition.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 board/qualcomm/dragonboard410c/configs/chainloaded.config | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/board/qualcomm/dragonboard410c/configs/chainloaded.config b/board/qualcomm/dragonboard410c/configs/chainloaded.config
new file mode 100644
index 000000000000..3fd064924a1f
--- /dev/null
+++ b/board/qualcomm/dragonboard410c/configs/chainloaded.config
@@ -0,0 +1,7 @@
+# CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK is not set
+CONFIG_TEXT_BASE=0x0
+# CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR is not set
+# CONFIG_REMAKE_ELF is not set
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_INIT_SP_RELATIVE=y
+CONFIG_SYS_INIT_SP_BSS_OFFSET=524288

-- 
2.43.1

