Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0A0C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFBD486439;
	Wed, 23 Aug 2023 20:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cDiP0tGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0508786439; Wed, 23 Aug 2023 20:48:02 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 606BA86440
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79244dd2e49so79368139f.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692816478; x=1693421278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvZALeEMFujSxSRCvmww8J/L0eS4R3wLljWwhMCQP3c=;
 b=cDiP0tGHMv2//ZD1ImjqUqtKH4QinUli+KxlsYBW82BPccGGEZ6lCnXGsiTAIMhNLK
 wnooNbngDuTNedtQMUtPkHx1KCBARtlmBuk8I4/WgOAfXxDiDejtxD4mzID2MmuLrA36
 m+P0ZDzaBK0PaI+jVMC/gpY8+bD1DX44+fGF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692816478; x=1693421278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vvZALeEMFujSxSRCvmww8J/L0eS4R3wLljWwhMCQP3c=;
 b=H+nENp0vId2QPfLHXbAX4nHwVdSdSzurBMYjrk8nFnZBS7paRl79EYmaKOmFrVQZAl
 ZisGicF+d+oxjCZnM03IoKXp6iWqAmEvaqxR+Tt8ydEwfiEBP40pRQBNQwqK5eLsmLJL
 SusNguh5Wgwhs5PdBMX+EHd2ATjpdZeCA9uK8DiI1FubwULEVv9w53NvlcVNUOMc/6Ai
 F3580eL3iaTXH/+UyYW/NlNl8MkE+L3+MbrO58Ogwu6zF3ncfSCicaGwxB0vsseiBIWy
 cm/aQBFDy+VEEw7+SK00b4H+6TjE9uv9FNFPkfeDfACBx7XeEPzSULPeF2uQJBFppwuT
 MAVw==
X-Gm-Message-State: AOJu0YxB7XZEB7k6gBGjlxq2nJwAmVc6WhT36XD9VrYrs1nr5XBotPei
 2WyPSV11ooyWM7L9cO9ftgcKIKvmg9dg0u6+0tQ=
X-Google-Smtp-Source: AGHT+IF2fYkUG2c3nOOipJ5iyMUIg+QjLgZQACZ3reJaf579S/bdaXru5DosszwSEDGeZ3k97Smzmw==
X-Received: by 2002:a5d:9718:0:b0:786:f47b:c063 with SMTP id
 h24-20020a5d9718000000b00786f47bc063mr3422917iol.21.1692816478002; 
 Wed, 23 Aug 2023 11:47:58 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a02c054000000b004182f88c368sm4070929jam.67.2023.08.23.11.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 11:47:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/8] x86: broadwell: Show the memory delay
Date: Wed, 23 Aug 2023 12:47:34 -0600
Message-ID: <20230823184746.842091-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823184746.842091-1-sjg@chromium.org>
References: <20230823184746.842091-1-sjg@chromium.org>
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
---

 arch/x86/cpu/intel_common/mrc.c   | 18 +++++++++++++++++-
 arch/x86/dts/chromebook_samus.dts |  1 +
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/cpu/intel_common/mrc.c b/arch/x86/cpu/intel_common/mrc.c
index 56cc253831a..ff959d1bd8d 100644
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
index 96705ceed07..ddff277046a 100644
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
2.42.0.rc1.204.g551eb34607-goog

