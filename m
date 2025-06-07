Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940DAC5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 09:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFD0882B00;
	Sat,  7 Jun 2025 11:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="APC6v6xs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A45D82B00; Sat,  7 Jun 2025 11:37:39 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39D1C80E9A
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 11:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-606ddbda275so5267500a12.1
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 02:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1749289056; x=1749893856;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIZOBsaFYYEjxcHR9lV+uTimm4H/Ly/1YE4Yh6CRGkY=;
 b=APC6v6xsYU4TGis0M+dmd1eym4/7QoDT70pouCcC4S8ePr8GJ7YH14VpD2DZojtn2p
 C1UqX2KdSjYz2B0DMdPfGOY9pWaqd807fUhB3tLg7IGsY8AgKviM7SnjAevgPmZ6kLWH
 XmTDfVta0llP7s836kF+a234sKo8gF6zgtEb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749289056; x=1749893856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIZOBsaFYYEjxcHR9lV+uTimm4H/Ly/1YE4Yh6CRGkY=;
 b=S7XM68h/Cyi0VoE0N8ZFjXQV3fjqv1tBzc5TPWqdmGJMIsuCrzh5rYT3LJp0uGglca
 KOQId0cEQlpQe5leJ76KMi6iuUuBeCVNn7/3+NOBVMVDzyXjLSKHwBGPz8hIrz5qq+KM
 Chqp1Lb6sWCa9FxbPTG8ZFVMwPiO3ifI1b97o4AKYRYI7xs8bvuw+8iGuZvhH+7m6MUM
 eWbfC9vW/HXqeKezp7aOWaMmrA5OLcQdFaEw1ynUZ5b5DHG6tOg+jQpmXc542l0ors5W
 AmySjfjazPoWT+F7c1w43BNBEYpfMcTZI+stFc8qH7LtVgueCLYuw8CrInJrodBMcrYm
 BnDg==
X-Gm-Message-State: AOJu0Yx28cq/vm8BpPjwhYeSde8wibI4rIPXwzbUHipY3UBfROxW3i/v
 ehb8W7UU4xTL9rjdEsCsIKDZ4WlZf9YN7Yny4FWodcN8qBWXZsbx19e/rO00VvARfM/BJLefxZy
 IFCum
X-Gm-Gg: ASbGnctFiuWY4U+L2yUozPXd5oCcUJpalu6s6v3ukBP18N0A2TVApvJUdw6HyyxYBR4
 ZcJD+KApZMfFhRXjoJvSkV0u4DH0NgMCyNv6EvWbEygLbQWQ8VPxqtMKJdDsBPLeBirz/FJqEdQ
 ewTX5I+XeuyGttf8cyRURTAEh4djj36Bf5MmLFNLhKHdRh3Slo9EkXOSLbJ+k/RTMWJXMrSAu09
 G1ER9f52IHBK0FHhynMyfljvZ/B/wwn3NIot1LY9rz250QMa88EooOyCY8QEpBkfiXQQwnO83YY
 EZZAjrLA39pxn2L2yNOGcPYemm++DIX5v2FPqn0xMzTEbz+y9eJfb2I8VqCevtWA9cRnYnAQGlW
 OeS9g5azGRz+5dufeOpxBNV7kEFmBksuTsWYgyPOQ43tnfzXGgHwZTfQxD5iBFkBLWsFunDShkW
 pxQRqWYCEMTpM9
X-Google-Smtp-Source: AGHT+IFAdqnB+dLeUsyPjUsfpZI5jwFPAUcSwSLXQx8GQZPR2e3lgnPNhna3Qs6fUHoedNIahRsZhQ==
X-Received: by 2002:a17:907:805:b0:ade:3bec:ea40 with SMTP id
 a640c23a62f3a-ade3becfd3bmr193018566b.10.1749289056123; 
 Sat, 07 Jun 2025 02:37:36 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-5-95-99.retail.telecomitalia.it. [87.5.95.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc38cffsm246524966b.124.2025.06.07.02.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 02:37:35 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/9] dt-bindings: arm: stm32: add compatible for
 stm32h747i-disco board
Date: Sat,  7 Jun 2025 11:37:10 +0200
Message-ID: <20250607093730.2249536-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
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

The board includes an STM32H747XI SoC with the following resources:
 - 2 Mbytes Flash
 - 1 MByte SRAM
 - LCD-TFT controller
 - MIPI-DSI interface
 - FD-CAN
 - USB 2.0 high-speed/full-speed
 - Ethernet MAC
 - camera interface

Detailed information can be found at:
https://www.st.com/en/evaluation-tools/stm32h747i-disco.html

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250427074404.3278732-3-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[upstream commit: 815d49f61ea049075482161f897aa13e1ae30cbb ]

---

 dts/upstream/Bindings/arm/stm32/stm32.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dts/upstream/Bindings/arm/stm32/stm32.yaml b/dts/upstream/Bindings/arm/stm32/stm32.yaml
index b6c56d4ce6b9..a0660a0b494f 100644
--- a/dts/upstream/Bindings/arm/stm32/stm32.yaml
+++ b/dts/upstream/Bindings/arm/stm32/stm32.yaml
@@ -42,6 +42,10 @@ properties:
               - st,stm32h743i-disco
               - st,stm32h743i-eval
           - const: st,stm32h743
+      - items:
+          - enum:
+              - st,stm32h747i-disco
+          - const: st,stm32h747
       - items:
           - enum:
               - st,stm32h750i-art-pi
-- 
2.43.0

