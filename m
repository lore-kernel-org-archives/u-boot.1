Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3A7C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ABEF8802F;
	Fri, 15 Mar 2024 16:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r1zqpN2x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 440D387FEF; Fri, 15 Mar 2024 16:10:48 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC12388054
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-513d9176cf9so969306e87.1
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515441; x=1711120241; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p1DgpWWU6EAciyMI+tFL4AWkmHHqHFUrK84uXLk8RKs=;
 b=r1zqpN2x5dJn+MGcm6fsJXlG+Z3Bx+xUJkKFuUXIZxUnYe3G3/S/pCJ6LfV3LUllcj
 f8jVnYQK52rgBB08o/0+S1UkMirWK/U7cJp/L89pvJPD7hAFhIDFuIxBacxa+4n9yN6G
 c83M4UZ7eNtXPIN2XaeG+eaY8GxbBYneTNIBr1/O+1keGua806ZwpkmsWQGBMVXnpHMu
 wjLGV1mdRz3PplsJz2E+zgGCGKAtA+PSqkK2R9vzOw2QJivLqQ+vHPz5iX2Nrz1+wKe6
 BoYQ18FJL37hBN8GeCFkre8YQAMSD2BZ9mqZ3N7AujhRrtfP1YtrxhaCuo3FAsGspu5m
 vNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515441; x=1711120241;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p1DgpWWU6EAciyMI+tFL4AWkmHHqHFUrK84uXLk8RKs=;
 b=QnDdaIsRj/AQM03cFSjqUzoKlqadQjDrn688nAny9LjVT8phCwDs/EjDsKENtoXGWr
 4wfezhArbHeyo2y0zLlkGUX9Yfdd1HxNAnS3CFD2k1KT/i935R0N2pUKfTF/4skoYO50
 0zKPEHDjMM3U6uzmc87OW476/iNzNnAPBwc5hlrQw28EMeGzLAjWtIPziLS47Jt5j9pX
 dZ1Ukh8oZmrmRiGArya/RulD9f/HcKHqLo/Zs4N0JOUvSjAxkJ+waXq+4oO05O+uyew/
 APGGfjO1Zl7EzvpfUCo7GC/ZSbIhvQGjoDVxmWAe07vLBQIYmtiE30tEVw8n/8JVGgxy
 ds1g==
X-Gm-Message-State: AOJu0YyetC/DfJvoIGSQRqc1WWWyEZftgkiL1eOAZvsoDhjfGk3CIaGe
 MS+IB4mRsjS0vf9odmEDhWlgDxbgiTG4AG+/its1TZKknqRP4XuuzNhJNgJyE79ra6Na99DN9xR
 x
X-Google-Smtp-Source: AGHT+IGwrMSi0H7BxSiuOkdsASv1tLjSutTBpLFDHLeI2mVtGnub/x9OEjWoD/Yg9l+m2JZqUIf5RA==
X-Received: by 2002:a19:ae01:0:b0:513:25c6:e98d with SMTP id
 f1-20020a19ae01000000b0051325c6e98dmr2348803lfc.57.1710515440772; 
 Fri, 15 Mar 2024 08:10:40 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d4006000000b0033e699fc6b4sm3398141wrp.69.2024.03.15.08.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:10:40 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 15 Mar 2024 15:10:21 +0000
Subject: [PATCH v2 12/14] dts: sdm845-db845c: add u-boot fixups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-qcom-livetree-v2-12-ab635774b2dc@linaro.org>
References: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
In-Reply-To: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=YmBgscYN04ZbVZGGJFD08tSuDrrGuIbLaNGLiTo8A1w=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvKY+Vkv3XqAXkbJi96UnU63l1qo96M/cmb71lNtN55
 6enzcGnO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBELtcy/A9eOkU3vPfip8l1
 qq6HI3vez5n2lH+712v343NvfdriL8fP8N/phmjuzG/CNZtadsgU+BYf4Hc+vfnqLrd5scselrY
 y7PgCAA==
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
2.44.0

