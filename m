Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D423FEC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 15:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A33B86A76;
	Thu,  7 Sep 2023 17:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HIYSlhOK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4047F86A34; Thu,  7 Sep 2023 17:58:38 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF6D186A4F
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-794d98181f0so47770239f.2
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102312; x=1694707112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLG5YWPCOfsIkcQGFGJTkJ9JloCWZlOTM+d36yPCeLM=;
 b=HIYSlhOKpxJaQzFL6x0QbhN9EIpUUzuhEaSF3iIC7RnBRvFF1KdxkrvHXF2tS/CPBJ
 jj3jHX038pxPQOWzwj8ETKBTpX36FcOFDyqnF6FAh34bsC3QY5BgtdOieGJSZmAgavxb
 UdzpNBqeCt/ubfKqk5eNk5aYaGI2zrXxLlChc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102312; x=1694707112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YLG5YWPCOfsIkcQGFGJTkJ9JloCWZlOTM+d36yPCeLM=;
 b=RFJkdfhzX4JkEMHzWvmixL8oGmbbN+xvbOKw3Ey4IVq0pAaD2NVpaf72G76os4Xmsy
 H3P2gnJ6p9Fdf/WDYrDOcRuOEA2wtNhuNvszjMcZjU3OPLAhQR+Zu9qBILfBYRJIm1vH
 tEmCYySfXg3wcZQj+YwgB9KMdQb0gCrffXD0hYGJw3AJMb4Mr+IoLydOJblCO4jP+66h
 Y/bmsg3mkU4y27vACJ45n09A8e+99mmsLsWVthfMNeb17UYPPVE8uWfPNiDAOBuIZzxa
 XRLbkRZHEDIKctx+0i48K0tWYxJ29fftv9/V80gjHy5De1h/M0NNUCIbu23L71/hBSKV
 2SDg==
X-Gm-Message-State: AOJu0YwJxy32IVWSqSR0OzwCKrh/phIw75dGD4xRC+hRKBmMEzfMI5RL
 KbG+MpK//jp/cYzua+oIyFW5Q8YoWaGkd0FqMiA=
X-Google-Smtp-Source: AGHT+IEfgNd8KUDv645pRmc3NKJ6QU2YlvuV5njlV9dB2xRxuyYX/HnNB7KcJzbjTCSjw95sCJH9eQ==
X-Received: by 2002:a6b:a08:0:b0:792:989b:c621 with SMTP id
 z8-20020a6b0a08000000b00792989bc621mr175200ioi.1.1694102312439; 
 Thu, 07 Sep 2023 08:58:32 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a02b881000000b004317dfe68e7sm5498839jam.153.2023.09.07.08.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:58:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/9] x86: broadwell: Show the memory delay
Date: Thu,  7 Sep 2023 09:58:14 -0600
Message-ID: <20230907155825.48056-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155825.48056-1-sjg@chromium.org>
References: <20230907155825.48056-1-sjg@chromium.org>
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

Samus only takes 7 seconds but it is long enough to think it has hung. Add
a message about what it is doing, similar to the approach on coral.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v1)

 arch/x86/cpu/intel_common/mrc.c   | 18 +++++++++++++++++-
 arch/x86/dts/chromebook_samus.dts |  1 +
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/cpu/intel_common/mrc.c b/arch/x86/cpu/intel_common/mrc.c
index 56cc253831aa..ff959d1bd8d8 100644
--- a/arch/x86/cpu/intel_common/mrc.c
+++ b/arch/x86/cpu/intel_common/mrc.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <init.h>
 #include <log.h>
+#include <spl.h>
 #include <syscon.h>
 #include <asm/cpu.h>
 #include <asm/global_data.h>
@@ -251,13 +252,28 @@ static int sdram_initialise(struct udevice *dev, struct udevice *me_dev,
 int mrc_common_init(struct udevice *dev, void *pei_data, bool use_asm_linkage)
 {
 	struct udevice *me_dev;
-	int ret;
+	int ret, delay;
 
 	ret = syscon_get_by_driver_data(X86_SYSCON_ME, &me_dev);
 	if (ret)
 		return ret;
 
+	delay = dev_read_u32_default(dev, "fspm,training-delay", 0);
+	if (spl_phase() == PHASE_SPL) {
+		if (delay)
+			printf("SDRAM training (%d seconds)...", delay);
+		else
+			log_debug("SDRAM init...");
+	} else {
+		if (delay)
+			printf("(%d seconds)...", delay);
+	}
+
 	ret = sdram_initialise(dev, me_dev, pei_data, use_asm_linkage);
+	if (delay)
+		printf("done\n");
+	else
+		log_debug("done\n");
 	if (ret)
 		return ret;
 	quick_ram_check();
diff --git a/arch/x86/dts/chromebook_samus.dts b/arch/x86/dts/chromebook_samus.dts
index 96705ceed074..ddff277046a4 100644
--- a/arch/x86/dts/chromebook_samus.dts
+++ b/arch/x86/dts/chromebook_samus.dts
@@ -266,6 +266,7 @@
 			board-id-gpios = <&gpio_c 5 0>, <&gpio_c 4 0>,
 					<&gpio_c 3 0>, <&gpio_c 1 0>;
 			bootph-all;
+			fspm,training-delay = <7>;
 			spd {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.42.0.283.g2d96d420d3-goog

