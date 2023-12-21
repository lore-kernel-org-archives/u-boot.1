Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906FDC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 14:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 530EC87876;
	Thu, 21 Dec 2023 15:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DKf+9BZ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48FA187866; Thu, 21 Dec 2023 15:24:46 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52ACA876C9
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 15:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsankouski@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50e1112b95cso1025548e87.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 06:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703168683; x=1703773483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4cFBR+T2T7tLECoMo5gktQO9EJXLMCmlji1feGjMefc=;
 b=DKf+9BZ0ywvGsw79PyfTUr559IDMGi5/QyS43V7HZtmatmBOaHfXSA1I2WUEqLE8GV
 LSKXxRrMJpPerV5xcqyX8xVkfdBdjNL70wl/rZIEzt2Oe3XXNU4R8EBIHEJpecu+I8Ce
 C2saCPhWKX+uD6C79Dm6XOMq9aTDzyjS8REGM/X3WP8fLO93vwbAGgHETkXt6+qwWN3S
 vv1ZFaIZKzPwvZiHCETlU0myBMKGkJsI/++IzaD9lUCoj+lWZK3hRVaZqllHhiXmJHu5
 kIwIBAlI+I4+4wbKCEImYJZHRPUwswVXBDgse2Dk+EGnAXkgZCAGPtXcFn+wB/xarsnH
 N6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703168683; x=1703773483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4cFBR+T2T7tLECoMo5gktQO9EJXLMCmlji1feGjMefc=;
 b=rI7YJ+zdc6hXMAvtuGzOJkzdxn+Bvk2PBTf40ggaqxc9mV3fS8QFZ1ucGaTA4ZhsQv
 kUC1BSbWc/pdaauH1wwTZA1bamqL3o5Ybl4Vk074GmUqWtgBlqRVhsh3GxU3Td+BAqqJ
 M/bcxHF3EDqR2PegwYpEnPoWuntz4uRdiV1WhWeeG4gVfpGdTGMbX6RP203tmi8QSwfE
 SEJzMgPrImJXzf/WFCYlEfgpaDXozSnU21Q4+upNhp1P41NPP96SyBsEvIkFNVW6b08Z
 TzIdObMzymkzAaSuq8A7zjht+5Bcl0Db6pemEPorosgCsQ5kyA9kYfCbH0cSSzyoqMHf
 T7AQ==
X-Gm-Message-State: AOJu0YyBA3ZAT0S/hghYBb0zwJahF2hntCZG0CYyIJIpmMme5/1+K+l9
 qaZ57x/33wyjwTBuc9CmKkMISkMAnG0=
X-Google-Smtp-Source: AGHT+IES8aLKweZQrS/DUqFS/k/6+4oCkvEqWUo7YeDhle77/7FJYghOt6YDSYcQPSJE2PHwwg9aaw==
X-Received: by 2002:a05:6512:3b2b:b0:50e:39e0:e9ce with SMTP id
 f43-20020a0565123b2b00b0050e39e0e9cemr3294066lfv.202.1703168683199; 
 Thu, 21 Dec 2023 06:24:43 -0800 (PST)
Received: from debian.localdomain ([37.45.245.217])
 by smtp.googlemail.com with ESMTPSA id
 q17-20020ac25fd1000000b0050e3719148fsm280653lfg.235.2023.12.21.06.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 06:24:42 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
To: u-boot@lists.denx.de
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: [PATCH 4/4] arm: dts: starqltechn: add muic i2c interface
Date: Thu, 21 Dec 2023 17:24:09 +0300
Message-Id: <20231221142409.82877-5-dsankouski@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221142409.82877-1-dsankouski@gmail.com>
References: <20231221142409.82877-1-dsankouski@gmail.com>
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

It allows to multiplex debug uart onto usb port, using i2c command.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---

 arch/arm/dts/starqltechn.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/starqltechn.dts b/arch/arm/dts/starqltechn.dts
index 539c1b51ca..5b04c3219d 100644
--- a/arch/arm/dts/starqltechn.dts
+++ b/arch/arm/dts/starqltechn.dts
@@ -23,6 +23,16 @@
 		stdout-path = "serial0:921600n8";
 	};
 
+	i2c14 {
+		compatible = "i2c-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 =  <&muic_i2c>;
+		scl-gpios = <&tlmm 34 0>;
+		sda-gpios = <&tlmm 33 0>;
+		i2c-gpio,delay-us = <2>;
+		status = "okay";
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0 0x80000000 0 0xfe1c0000>;
@@ -59,7 +69,7 @@
 };
 
 &tlmm {
-	muic-i2c-n {
+	muic_i2c: muic-i2c-n {
 		pins = "gpio33", "gpio34";
 		drive-strength = <0x2>;
 		function = "gpio";
-- 
2.39.2

