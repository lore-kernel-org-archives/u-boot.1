Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621F0C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE0D87807;
	Tue, 19 Dec 2023 17:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bkopxe/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6A7D8784A; Tue, 19 Dec 2023 17:04:45 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE218877A1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40c60dfa5bfso56304595e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001873; x=1703606673; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JButcUx5EqAmqGpkf2jGyugvykMJpnrebMLZRjCIsVE=;
 b=bkopxe/okrqiDo7rmmKWCwmu7L8p2O12zOsjKGmRwqtjScUu7U+Gef1M6ZVSonZ1Yc
 Kzlqdj0R6buYhweAvIC13O4lxs9J5R8M9uC9f9A/HAzak5PCzCIIfG1n8pvxTZTX1VP2
 aZJokOwO2CKQQcR6CM3Fjn16iL2UOosccsKafK4D55lxJSZCraSoCN5I1UTpEwF+FOCS
 x+BGXx5HIGOy3tuwX4GUKX6241++6z8w56GwgpHcp41zTNITDBCfvqojBoIa5kbo51dI
 roc+jIjaLet0FhBtv6B7PibrejNvK3/J034/7c7ZaB9x3zzsVaj1eDGj16KBMAaRNL0Q
 R5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001873; x=1703606673;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JButcUx5EqAmqGpkf2jGyugvykMJpnrebMLZRjCIsVE=;
 b=i5IRYoQW5H2YozZ+jTPH6WFv1TbfnxlGcz4LoJmEhw+XjLLFlJcgONiClv+96GGgfE
 cljI+zF/Q/u4x9RB/+4JESe/5Nse8hKw2Xc9SB/7sSm92L+DyG88uMCdKoSiCbIgSYeH
 XOK3PuLthswCC/Rb/XIakHT1bYzczTYbwlgUIBouzc9yCMwII32Jg2bj5w/y02v43ZtC
 Pb+uXyNbOnPQPFSzcLEyVESFpqXeQ2XzUiPgiq1DofDdKdasetkOSBfnKDOrjL0UrLLK
 tB4DRbAIo/lLYjwkBz52uITRqWeYggWixr1m1pailYTh+nF3L6ZfBx87daSFoKLTkBiP
 ohvw==
X-Gm-Message-State: AOJu0YwLjmBHd7ws5w3qOk/UaqSzsPs2KLj25mSRNlemjpxaWpgzKe5B
 K+yUOTwEQRU82YqsYGO3+UFgGA==
X-Google-Smtp-Source: AGHT+IFqZWSGSjsRHTZxROQGqIeAgtc8ssbdGhhGvE8SjuvKnfw1bnkQ4zMAz4RWNl0bIJ6Qnbr6lQ==
X-Received: by 2002:a05:600c:3d9a:b0:40c:3d70:2751 with SMTP id
 bi26-20020a05600c3d9a00b0040c3d702751mr9495292wmb.149.1703001873462; 
 Tue, 19 Dec 2023 08:04:33 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:33 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:12 +0000
Subject: [PATCH v2 11/32] board: dragonboard410c: add chainloaded config
 fragment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-11-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=875;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=r9bM3Hxmr7eZ3bpO72RbzrN4tdx9nW/pBR07LRM1dbA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/UyL85dvfsS9eBHrFuXQLItjhfWL86ZVS1w9PWfCn
 lOh7ldVOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEpL8y/OHQ8cllu758ZhZz
 5a9dzzoXMSrlOshnH9+916xT5+CGg9qMDBPVf8/h47L88zD0eVpK545Z2wRXPVh94OV86d+6qz5
 un/ASAA==
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
2.42.1

