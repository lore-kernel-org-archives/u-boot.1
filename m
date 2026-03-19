Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190861091916
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C5F840A2;
	Thu, 19 Mar 2026 21:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VlBegcsI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 532AD83FE9; Thu, 19 Mar 2026 21:02:23 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D90883F00
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-467161c4b89so664594b6e.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950539; x=1774555339;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6D9kJ8EtOQ/NPio6GcIYSF7PZ8k46b1D8G/quaq9aJE=;
 b=VlBegcsI6u1id3frblwi30WYgy7WeGytrRgsG7gcBL1v03Ib8UMzewQ+vZ5KaO8J9J
 lBtkincr9KXSYnmewvGQcViNefR0H8YNDhJMFRYQ8q9sU14Y3wSPDxNOKul275F2mSjm
 e7PPU3QQrRANKUOSMONCHdXVJ1X9sEN2Wa5xQFXSav0Bbz18ERdUlZXMvEGLDgrvUkvN
 39OvKwQPh97LFrMDktzrUOnqnWsuloJ6wjc0z0xx1j7UjMqAKDjyfKPmWbbqD5Pg6VbR
 17A7rwGIFBX8KqQ1Qy5ts57tWa4gdBA6vQgRkf9GsJe04g0gV7dKEsbYJSuBLEoFsFJt
 oy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950539; x=1774555339;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6D9kJ8EtOQ/NPio6GcIYSF7PZ8k46b1D8G/quaq9aJE=;
 b=KbUx4xtCuDu/Exn0fwrwHKvvXgDjsZDUbbDz2zt/L8ksQq5qegE8RzXngZ5G4KeG9z
 Zu4sVZEXYZntZT2ZtFq9k7xOJzcH8W8POw4RPkv3xTPnsweLbvHFbMD+JncQRHPyEWQ5
 4dKf8aqL423DJIozYbUoJXQEq6r+XQmfmFx5umleW5pdwB5qMGpzDEYdHRPrUOYZOkyt
 sGI8WTnHKER4MKBxaaSdZzm4HXRoAVu1N/Dg18J501X6ocmuhtMMEPO/RZamvxfLmMsg
 pyl1cNgYOIDoO3WfLq9GTRAp9g/tcOnPY+eA2sP1y11PKcBeZnUXFa0oUwx/9FNEYFZV
 bgpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBEW5XMb7BFcTZT+Sp1UWNavSQQ5W2f1XH2wFXJvmvsF4Tj8QWqHt9ImKprgl3bENak7tvBdw=@lists.denx.de
X-Gm-Message-State: AOJu0YyDoEqyE51gqRniKBo3UwdNl+NkkA5zxIm92y62OnstoaRLaqhs
 t0NKJa5Xs3yrprI/l4cJroNoMb81fSMjClEBJlHl3x87ivGvXNWuCJvl+3Es7vj9QQwG47upWxI
 Tk/wo
X-Gm-Gg: ATEYQzx6LIzg0Uaaa68mzb9Ocxo0dA5sjAe8CRzP7/Jwase4gITQrGpfl1i8kiLA+EM
 OE3fqxZL7CFw3mK6b2J1l7YBu8Ku5mXsxX0B3xfBlEQElx7M70Oyvse1yXIFiRgVu0L3fElqPW6
 r9kBUtFJYcrHMtwjwEw9f9mn1WNtOBFxzXab4ffabx4wchiX7qyeCAs90TQLfVYfyJx02luEsWJ
 OJeTfDWMF3ykP3t/tDXAviik2JMQh/h6wHZrAeA/ddvxWkk1jfepkI60UHI83FWrWVoIyzF/qf4
 kqFIpislzghWz4gLCqdY6fRF7vanwvuLpScqhV+7oNGVe/iueeyS1UavOLzt1PRMHcKNzqenZn/
 c0WS7juwQ8fZtlWy8i4bQxkppzRFyl3NL3KF5Tr/6rnqdLi9khkQ34YPYvAIPqNUjceVGcQXrlv
 MOKbUxuIP8u4esMwZMted9MVk4QLWC
X-Received: by 2002:a05:6820:221a:b0:668:d715:1099 with SMTP id
 006d021491bc7-67c22f93062mr511013eaf.62.1773950538604; 
 Thu, 19 Mar 2026 13:02:18 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:00:13 -0500
Subject: [PATCH 10/17] arm: mediatek: mt8195: check return value of
 fdtdec_setup_mem_size_base()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-init-fix-dram-v1-10-6171ec141f40@baylibre.com>
References: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
In-Reply-To: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=798; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=c+5LvAVIGcn8Q9OedNoej+Y0gXFKM/PXawVnhtuyXYs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFYJmb+xlCBSeLmCp6yfyG/skiP41JlowTsJL
 OI5BsW9X+iJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxWCRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A4rgH/jBM0KV8iIPnRcvdbYJvya9crPHvhRDnxbAbOO2
 /kBQDs7kv6Kah7MGa9HRMxiqa3Ki4hLXrMJjaRwO5hHaaaLhhUiCjbGgfs8qkK1VaDoNGU+84Tr
 +OXVJm+4UEx6xAMvSDeMNp5O1TL38l9YsE2ztOKDpfeQ6lbTxHguUDH3V5U0alopFlt0IKxc3Cm
 tN899dlOkcuzSCrkhaAmvChKo7h0AiHpfccJWbTI5JmttZoySe4Qo9NAYwrEF/SeQ2KbKSHaVOA
 URthakitlMpqcpzmAti4c3hiCxkhcqs7iY45dwbFecKfnk8eE7U+M8P9NVTZw38zQwgxhUGe6wI
 RLnw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Check and propagate the return value of fdtdec_setup_mem_size_base() in
dram_init() for mt8195. This function could fail if the device tree is
malformed.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8195/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/mt8195/init.c b/arch/arm/mach-mediatek/mt8195/init.c
index ee463e90409..cc9a2c68e0c 100644
--- a/arch/arm/mach-mediatek/mt8195/init.c
+++ b/arch/arm/mach-mediatek/mt8195/init.c
@@ -22,7 +22,9 @@ int dram_init(void)
 	if (ret)
 		return ret;
 
-	fdtdec_setup_mem_size_base();
+	ret = fdtdec_setup_mem_size_base();
+	if (ret)
+		return ret;
 
 	/*
 	 * Limit gd->ram_top not exceeding SZ_4G.  Some periphals like mmc

-- 
2.43.0

