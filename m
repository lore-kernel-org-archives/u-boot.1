Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CE4C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 14:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1A8887FEC;
	Fri, 15 Mar 2024 15:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kfz/fdRt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CFB987FF5; Fri, 15 Mar 2024 15:45:10 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9996B87FEC
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 15:45:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41403b203e0so2757195e9.3
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 07:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710513904; x=1711118704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o/oWiFqLhIeFMT4HX2dy0K5iAC3dXk3TCC+ZKIm9/Zo=;
 b=kfz/fdRtFtLMqG5n+cGi9k+62tH6kKOSiLuFy7CSM3ZvaASsJTZoq1GOJq2+OmY5MR
 y0sLZjjnG2r5QRvU38u+bh9imgGwk4eJEf2NX9vwI2KIUupql5gg5U3dAVdw/x0e+Y7N
 A1DslCuFy1ccJfYcBxOSgl7kqzzxVTtpf6a5b0btoYxMJYA6uCgMUM3dpBDyad2lhZZQ
 uwA3aAqpqjjipUQxfU3pKE2pC6PUgm+G07jVNhUsoE809cgIRlfzfxpFfrY4aO0/G2xL
 c+Y757XldQu4bxrMeGs9b2zIAvubP6XnxL5h6D4l9QYDvwGLwLtIGdixIOuT0OFbpDzF
 AX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710513904; x=1711118704;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o/oWiFqLhIeFMT4HX2dy0K5iAC3dXk3TCC+ZKIm9/Zo=;
 b=KEZknAfX+JMfcQ7Ffg/7JRzfmJoqeEYjvHXypHnTvRYdQxlQ+o7e7WA2/HM8eq3y13
 YzpDHvrLckHxk0QnCb+qcDUwOg5BgN1WXMh7nxkc65C8Yp3/o1M+7UyBpyo6YQYRHYv4
 WXqMXGuGvcvet0GXdvYVaDJAttW2SbGKn7cIU1ohNQ569K+rwId7Lm2p/SYICZjF3XaJ
 loShsNpM1o+hobqWTQd2P1egvghw6MxVr9aQeyE33vRPMFTxFxlZIIPV+wy7G7VSRBfI
 F2UBiHj/YI4ug4ouPKYsoJCVYcnOzwy2yCxbC3oKAECW9ONaDN8rzbX6CeNgN6swTjFK
 Yucg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLO6Y4DWUr40kY5FR7e4l8sP1qPagl9K1vNn5fxFBzWvxbKmqZP1bCzk5VKZUmvl/1sQqLNTBtZUc4OdOL+KY/Eg6g/A==
X-Gm-Message-State: AOJu0Yzsuy1KRiMG6jXhbUhMW+GbHqudm4bK0Wem1GJ/7A5qShM38TCr
 pbYtEIzcGVxWZZLbug+piKvKgkXOh2IxrOxcbtwocFxJ8CESx2bc
X-Google-Smtp-Source: AGHT+IE3NLiyVsgp85d5WHr1JSHRKVTOdYKNs3Xj5jSvc5ZRr+NUQ7YPBQAlNFaG9iaZUWU64i5K/g==
X-Received: by 2002:a05:600c:4e16:b0:413:fe47:f793 with SMTP id
 b22-20020a05600c4e1600b00413fe47f793mr2715352wmq.7.1710513903536; 
 Fri, 15 Mar 2024 07:45:03 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e60f:3100:6891:cf6a:a43:74b6])
 by smtp.gmail.com with ESMTPSA id
 je20-20020a05600c1f9400b00413e6af1bd5sm5877114wmb.47.2024.03.15.07.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 07:45:03 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] arm: imx: imx8m: soc: Fix NPU/VPU fdt disable fixup
Date: Fri, 15 Mar 2024 14:44:25 +0000
Message-Id: <20240315144426.38560-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 15 Mar 2024 15:45:34 +0100
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

From: Vitor Soares <vitor.soares@toradex.com>

On imx8m[m|p|q].dtsi, upstream Linux uses different names for NPU/VPU
IP block nodes. It leads variants without such HW block having it
enabled by default.

This patch adds the upstream Linux node's paths to the disable list while
keep the compatibility with downstream Linux.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 arch/arm/mach-imx/imx8m/soc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 39802d6a79..0c49fb9cd4 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -933,19 +933,28 @@ int disable_vpu_nodes(void *blob)
 {
 	static const char * const nodes_path_8mq[] = {
 		"/vpu@38300000",
-		"/soc@0/vpu@38300000"
+		"/soc@0/vpu@38300000",
+		"/soc@0/video-codec@38300000",
+		"/soc@0/video-codec@38310000",
+		"/soc@0/blk-ctrl@38320000",
 	};
 
 	static const char * const nodes_path_8mm[] = {
 		"/vpu_g1@38300000",
 		"/vpu_g2@38310000",
-		"/vpu_h1@38320000"
+		"/vpu_h1@38320000",
+		"/soc@0/video-codec@38300000",
+		"/soc@0/video-codec@38310000",
+		"/soc@0/blk-ctrl@38330000",
 	};
 
 	static const char * const nodes_path_8mp[] = {
 		"/vpu_g1@38300000",
 		"/vpu_g2@38310000",
-		"/vpu_vc8000e@38320000"
+		"/vpu_vc8000e@38320000",
+		"/soc@0/video-codec@38300000",
+		"/soc@0/video-codec@38310000",
+		"/soc@0/blk-ctrl@38330000",
 	};
 
 	if (is_imx8mq())
@@ -1100,7 +1109,8 @@ int disable_gpu_nodes(void *blob)
 int disable_npu_nodes(void *blob)
 {
 	static const char * const nodes_path_8mp[] = {
-		"/vipsi@38500000"
+		"/vipsi@38500000",
+		"/soc@0/npu@38500000",
 	};
 
 	return disable_fdt_nodes(blob, nodes_path_8mp, ARRAY_SIZE(nodes_path_8mp));
-- 
2.34.1

