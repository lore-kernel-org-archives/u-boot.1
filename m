Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F01C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 13:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FCF188DD8;
	Wed, 21 Aug 2024 15:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W/enKPtj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7430788BF6; Wed, 21 Aug 2024 15:42:00 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB78388C7E
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 15:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3718706cf8aso4087426f8f.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 06:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724247717; x=1724852517; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zLolcdfhpnv2Sr4+jU2o0ZvxpFWa2r7z1o+vmKY3kNM=;
 b=W/enKPtjbLPpOfXBJ95XWpBN74SHMzSf7YfqzclhQ8DglD54/Ubm8hmtMAJr3dU4oc
 7QSmg2IojIWCgmF7ZVpPpPipkl0d0NJdhrbZgltHWn6DI5oa5z8H/oPL2qgfxOvi1mol
 GkNDzmOd9DogYJbDxazFLX/yuyObHE0Frbk1+5S+dUC9Mk6TEn/kAnphDP0/pIcoFqNS
 MHhPWfxQj8qNWFF683e2CNpiiQmhvIyxMnx2XDqHqr0sARkmDhEdmDt6/J2uDEpAXIqS
 gfb2ryOgrf0ymsrNXXmgtPBlJ1Nk+WvqQNZ+fFud6rDTMI7k3T6vg9LtuKRk5l0ZeW9z
 9ukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724247717; x=1724852517;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLolcdfhpnv2Sr4+jU2o0ZvxpFWa2r7z1o+vmKY3kNM=;
 b=Bk58APruZpAfRV6OKvJFR/r6nSOZTRk1lGotJZ/7Ps1APRn4QEUIEES/nAymFAlsZK
 IuAn5ixOz3aQip+GhlTd5ZX/4G2D90T9SLGu+jKI2zHbc9HfYsLUaLImDouZanKiy3DN
 rSF/DzczN7mNahfl++0WXyuhXE1l5coIb99U116QJ4etTFEC+YvBD2zWg7RpfxE6F2MA
 tu2L+KZX2xor/7JzMfyV/FeFyAo5X53e7JPAVpvXa6vGTXfyZa8kzv4oIa1vTbwsuxLK
 D4AcwfMHj4eyGTilDPHRn292bg79eS+R3MX3EpFEW6J/Zr5fKhsyDSDcjBuR2TYJ7Gcv
 BDrw==
X-Gm-Message-State: AOJu0YxuxBBsFKKWph/SGz+J1lDRx2i4hMnvb9KUEI3p7sCb122LZSOU
 lTiuOgJUeGU0ryXFmDTRlVFUVDC+WlMh98BjXmGjDc74hcUPn0EuM1QELuQYSNk=
X-Google-Smtp-Source: AGHT+IFF8AJ5Hu9iRBb/BV7cCxp9j5UJEcpMy4SVnJcq2ijih+8KFAvBMsil1LfJlPGBheg9LAatHw==
X-Received: by 2002:adf:cc82:0:b0:368:6633:c550 with SMTP id
 ffacd0b85a97d-372fd82f325mr1509038f8f.52.1724247717163; 
 Wed, 21 Aug 2024 06:41:57 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83839342f6sm904164066b.137.2024.08.21.06.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 06:41:56 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 21 Aug 2024 15:41:48 +0200
Subject: [PATCH v2 3/7] dts: qcs6490-rb3gen2-u-boot: USB host mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-b4-rb3gen2-v2-3-49b07633f3a8@linaro.org>
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
In-Reply-To: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=955;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=HTbXxsrMd17GClJdrUxqmv1t42K8cKHfbuWdCzpCB0M=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmxe6djkazDSIeIn+UGkfv2WCzgyN2+Nv9IFp8u
 /7f/kVTNzKJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZsXunQAKCRAFgzErGV9k
 tt0qEACLN54DQLVEpmwhpZIBzCPjtaeMTHKNrVejy201O3Ts9I8BmKyuCQmcJReF8E1oTvhVE2p
 RRdEnopYd86hGyIc6pZZ1tNwmwCxeADAERIygNKEAGK6f6v29CJZt0OMSVRx7emdUn6wDP0/6FQ
 W7zfmxJKZMNp1gEMS80FJSa+PkI148T6WzfmKEfNbENYTwwIwC/e8yqlKXp+joiPv269f/nYbtY
 ZR6mW3re0fvIoCbUjHcIRmu5ZWB92qqfwAiSCLLlajpzIF8iDrDyOYOdb7/TxM5eWZloPwDYHaK
 0eJde2EIysMA1TJFP8ynVnUe1c4sZxDLB+ZnVUpbvGTvHjguamxfazEZlUmd1kV6m+ilTqAIlUP
 2v5eY2KUjx+MD8qm5FLgpj6JHDE9jszg3LSETAPwJDk0MICXQoY9HMu03kO8KE62j2HrRwVn7/G
 i1agSOBRJyNDHqTiUh2vYQnwwBPANZPjipnQgPkZ6Ebd98KbzzHr9Dh+kR7eC/caSf0V82YK4G8
 mPCaznXAPS+VNfT+JZQxQz7Axm1O7bWfIuSdLGqVGBRj4+4W3k1PzFWI7S46Vj4qWbpJXuWKl6I
 UlE67yw71FwYzQt6B7xLMSCr2O8bFmlv42AVl6bNjG53CZ8HmBo5AuKrhbdhpLv5HfjWK1j58tW
 Ci+WPJUvj2lPPfg==
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

Adjust DTS so USB runs in host mode. The type-c port is the only
supported port (since the others need PCIe). Booting from USB is
possible with a powered type-c dock.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
index c3ec4a317f7c..fbe72595f5ac 100644
--- a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
+++ b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
@@ -16,8 +16,13 @@
 		      <1 0x00000000 1 0x00000000>;
 	};
 };
 
+&usb_1_dwc3 {
+	dr_mode = "host";
+	/delete-property/ usb-role-switch;
+};
+
 // RAM Entry 0 : Base 0x0080000000  Size 0x003A800000
 // RAM Entry 1 : Base 0x00C0000000  Size 0x0001800000
 // RAM Entry 2 : Base 0x00C3400000  Size 0x003CC00000
 // RAM Entry 3 : Base 0x0100000000  Size 0x0100000000

-- 
2.46.0

