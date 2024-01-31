Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5639EC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 15:18:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6356B87DD1;
	Wed, 31 Jan 2024 16:17:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PCu3ff0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3FE387CE9; Wed, 31 Jan 2024 16:17:15 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9B8287DBB
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 16:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33ae3cc8a6aso3141416f8f.2
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706714230; x=1707319030; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7gS7zpo61JmV4RiezQyJ8jmpn3ALZjRjf7mpIfEhg9Y=;
 b=PCu3ff0q5/JMWRmp4I9hQMROlW4H8IuBxOMMRbnXtbruj7xBAouDtF8ZUre1BpbnXH
 ZXXU6uslwkkWOO3Ef1837IgJ4vb7TUWArH+340vcpICWv30omdzazVMM3zMLoVmFzKML
 bA5cT2jqrfw0glRa+NtNbqMyfu8PXL1MqVz+ZtEdBL7g0FJIAD5m6gJaM5LMSLEIYjLN
 KErkTS3AyDn4BuonNpoqJUAcE/oXRgxBeWPZWZcLRBjqE38h/KP+Ibi/6NeF5fASTpK0
 m1GkITkZNNe11yN2ZdR2eHEE1vbw4xrhaWj5dkMPT/ycsH2g76EBR9eUjiNzRTVNTFoR
 ByFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706714230; x=1707319030;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7gS7zpo61JmV4RiezQyJ8jmpn3ALZjRjf7mpIfEhg9Y=;
 b=vbYf+Vyi/3tVNDo1avczBvLYc1kYdkxfQf77R7G+C/Jg3jf13lmB2bNIXRmKGL2uBJ
 jdxeZxwzCkyoQhsHdqgzUODECeqMohzcgd7IpTnXqjfQ0GqlpiIPQVTs7Lhe4ZKLPsxZ
 GjexChAf3PASNjGfQ/CK7/JmuKQQcLDHRTzGPVxH0pIVBaHMPXlPsrcJP4UXgX9f4W1M
 4KOsuaVJoEJViam2c2i3PB+N3Io7fJ9GHSdCoY0Th3V6LpKDODPQzoyzguXRgsjYGwja
 RIyR76OAKx+mvNAadCehVQBlveQJeMs/gB9yF2HEoyAKpsSsra/l3uWvMx3jhHlCpSsP
 6/IQ==
X-Gm-Message-State: AOJu0YwikOu7ypL0XacOfUFO3IR5KQXw9Mt6GpVBADpfjWfoD5vT6sqC
 LiXconIvE/rniv/zSqdrhi8XSyNlLMWfQlBH1iC+7XcXQlETYsP9+za3oB7VXZqomLVIz11RHls
 N
X-Google-Smtp-Source: AGHT+IGp4uwv9zmujjpfESvij9dnXWV+GsfSJufNgCuY+o7WrCoSLxBcP+TGpVC3Sb2x0gsPDd3ORQ==
X-Received: by 2002:adf:fc92:0:b0:33a:eed5:7072 with SMTP id
 g18-20020adffc92000000b0033aeed57072mr1137469wrr.71.1706714230681; 
 Wed, 31 Jan 2024 07:17:10 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 en6-20020a056000420600b0033ae5b637d4sm11109031wrb.35.2024.01.31.07.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 07:17:10 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 31 Jan 2024 15:17:02 +0000
Subject: [PATCH 10/13] dts: sdm845-db845c: add u-boot fixups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-b4-qcom-livetree-v1-10-4071c0787db0@linaro.org>
References: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
In-Reply-To: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=dGiXbkaMfkO6VGP03CgItaGcQXC5bVnesE53z55Dua4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRdKTkXZXy+bri75ZTV+sWOC2ffM1u/n4F/7oLj+akHL
 tcXsicFdpSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJMPsy/LOxWfbe/H5/qeEr
 lhWf/5Qu7ZR8+n3/watnj+X15M1rmljL8D9tKd+OzYsvh77ZOyXpuZVom7feOs6a6bI6/M9jXkT
 8PNkLAA==
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

The USB VBUS supply for the type-A port is enabled via a GPIO regulator.
This is incorrectly modelled in Linux where only the PCIe dependency is
expressed. Add a U-Boot specific dtsi snippet so that this supply will
get enabled when initialising USB.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/sdm845-db845c-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/sdm845-db845c-u-boot.dtsi b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
new file mode 100644
index 000000000000..3c83e21251c4
--- /dev/null
+++ b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* This GPIO must be turned on to enable the 5v VBUS
+ * supply on the USB port.
+ */
+&usb_2_dwc3 {
+	vbus-supply = <&pcie0_3p3v_dual>;
+};

-- 
2.43.0

