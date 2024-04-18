Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153C2C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69175886A7;
	Thu, 18 Apr 2024 19:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WzTv+/VF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E28F8869D; Thu, 18 Apr 2024 19:26:32 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C34298869A
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34665dd7744so720736f8f.1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 10:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713461189; x=1714065989; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uIunq2hVl4wOxoVQv+vRWpmXjACM5TsW7K5jOwtHs2s=;
 b=WzTv+/VFMEBi7D2zOC8uhYrwr++DfoC4Oi6/H/SISCpf5TuQLsjGkHIoYp1K/tiGGM
 itVQmmh2PdYfJGrOiN85voYLdP4t24U7DTG73xJaMEwFctqPcxtk8/VP+f4X0y5gx6w9
 B0qHiVaToQxKFFSZusft0c8uaq9iyENv2CcXyylymMlooG4BvRvMot2y4IFc1aW0VNx0
 m8Iom0V3Y7nv6YuvdaTDXwiiWjy0egETIDNhkDoC0U9GwVZ18qKrbvy4c8HWXgK3mP9V
 RgQzGrOgAvqhT1x9iKNliVlY/fJqBThCjzfkb6L7+BVNCXWd+MP/QfSe+40EU0lq6TSD
 XSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713461189; x=1714065989;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uIunq2hVl4wOxoVQv+vRWpmXjACM5TsW7K5jOwtHs2s=;
 b=RYdRjnfphMpBp2HzYstzEoL7Qlg0L85s3GTbgCFjrqbuMWRG7RqUavX9EYNsMPYA7v
 EebSVS9n/A9FfFw6O7XxeF+CesTMTIsc7WkLk2j4V0AaSIbWMNyVmvE8B2tFEflqw2Oa
 6SBI3bgGE7TfSC/CjtAG5jt/+7FvAgk+FREIoAIvVB3DejJZuUGk2VM9bGZIR6Ed7FXX
 GT6/teFuV47rbK7UvFwz5Ud7giRF6pQBRJ+JD3PBXu8zEm5ffxpVZZxaasYOVX+6HSU9
 5hsbdvGqCxqyrgLCc2zN5747I2VTJy5+0iWHINSsJbTwhW1tT28BknHbc5tfEz5ypWrG
 yKQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIu1xAskIbLJ1VxJ3kDxyz76kO8GgCZNjPnoIaWPXeNOwWiF+cgCm52BjS5u0bqAAXnHeR1DWrdcltSzi1bYu7zOUBWg==
X-Gm-Message-State: AOJu0Yz5mnEkoPeizvPl8Vnlc+cAjg6bZ1LQsYYml+hBJob4AwU/fHj8
 9oL6vGr79PHZpFv8vDIssPk2iNN04VPaiKJ/u7bocZaS6zdZz4DLfgRr+xSTt5Q=
X-Google-Smtp-Source: AGHT+IHnGziyvTsSbd4/FYwmZJASzBw37yrM+gW64oJxUvzCKz9aDb5+vMx/M0ZajpwVQJvGqGp2XA==
X-Received: by 2002:a5d:684c:0:b0:345:f08b:a7cb with SMTP id
 o12-20020a5d684c000000b00345f08ba7cbmr2380672wrw.4.1713461189373; 
 Thu, 18 Apr 2024 10:26:29 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00416b163e52bsm7166057wmq.14.2024.04.18.10.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 10:26:28 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 18 Apr 2024 18:25:49 +0100
Subject: [PATCH 6/9] mach-snapdragon: implement ft_board_setup() for USB
 role selection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-b4-qcom-rbx-fixes-v1-6-f5f19d52969e@linaro.org>
References: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=vTdWylU+Qm/b2Kjzlu3fUijp+wgsNbm8wf9HDTuxWOg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTF8H388XE9U1fUmLvWffZNU5pRtttEoqq74PGq+S1ux
 6X1Lv3rKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABNhSGH4yTh5E//KkzeZOLkZ
 d+5PfGzPv6r4jeZjK8bqjxf5TYsWhDAytE9c4TJrX/jcXl5PjukqSW2bKryzWXkid/758m1xVs4
 PNgA=
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

Some Qualcomm boards have only one USB controller which is muxed between
the type-c port and an internal USB hub for type-A and ethernet. We
modify the DT for these to force them to host mode in U-Boot. However in
Linux DRD role switching is supported (required, even). Use
ft_board_setup() to adjust the dr_mode property for these boards.

While we're here, define pr_fmt for this file so we can more easily
identify log messages.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/of_fixup.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index 3f7ac227bd09..55368dd43b66 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -16,8 +16,10 @@
  * Copyright (c) 2024 Linaro Ltd.
  *   Author: Caleb Connolly <caleb.connolly@linaro.org>
  */
 
+#define pr_fmt(fmt) "of_fixup: " fmt
+
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dm/of_access.h>
 #include <dm/of.h>
 #include <fdt_support.h>
@@ -152,4 +154,22 @@ void qcom_of_fixup_nodes(void)
 {
 	time_call(fixup_usb_nodes);
 	time_call(fixup_power_domains);
 }
+
+int ft_board_setup(void *blob, struct bd_info __maybe_unused *bd)
+{
+	struct fdt_header *fdt = blob;
+	int node;
+
+	/* We only want to do this fix-up for the RB1 board, quick return for all others */
+	if (!fdt_node_check_compatible(fdt, 0, "qcom,qrb4210-rb2"))
+		return 0;
+
+	fdt_for_each_node_by_compatible(node, blob, 0, "snps,dwc3") {
+		log_debug("%s: Setting 'dr_mode' to OTG\n", fdt_get_name(blob, node, NULL));
+		fdt_setprop_string(fdt, node, "dr_mode", "otg");
+		break;
+	}
+
+	return 0;
+}

-- 
2.44.0

