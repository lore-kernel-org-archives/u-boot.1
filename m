Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79AEC48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED76D87FC6;
	Mon, 26 Feb 2024 18:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xgfeW4BP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECCBF87F1E; Mon, 26 Feb 2024 18:26:42 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAC5B87F75
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d23d301452so47368531fa.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968393; x=1709573193; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XlOYiwBO1WiIJHcWvRibDT8aCrIS0AnCmoS5G8aWDGY=;
 b=xgfeW4BPZ7aaVJBro7NmBBNdK834DLs3/vi4wOWo/yPwph4aPjuGhz4969uf3QuLs9
 6r9M40PYgpNYggJaojOVYcU0jxToRjtl3nY2fwihsgEJV7dso5zNNBWew7e+vyEqKLUh
 DKpoc2luUH7axDiU0GSrEzrmL65f6KQjI1cq37aMryAYIbSj7C+i2WsWme2oTGlO9n0t
 OzWGWzntio/AfF0FdeX1VzEWlC2U5XYloygZSdsbeAJanMpmG1BveBUGf4gVEMamHFWD
 WGSvCmc522t2sl+6S4ZvqyaDklYx27Lz0VqvRc7v4bH2FjSywBnqVdy1Nn93akct0KVw
 8U9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968393; x=1709573193;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XlOYiwBO1WiIJHcWvRibDT8aCrIS0AnCmoS5G8aWDGY=;
 b=ZEi3+XmkFjNpjuQZ4YaYsZpb0O1hrycO8ZfAZ7mf/FUk31vHLbMvI/PZ9llLJBXXxP
 nfnQl0mJ31l+Hu4o8jATX2P0tMV8iGfTOnN2DXuEHBiEc9LosvxUjaKQjxvq2lSUp/ul
 NzWIBk/fk5k3/2FQM7I410Z2HP/OSDbi+O4iFdz0wUynz9mHiArG8SNdBy0iUB9mRRNv
 Mu7e4VwLIXtWhGctWse93H/fhwjVJIXoeAT8JvvhwmGVPuvnXGyHLmXPKNMO9axfomai
 CKos8SDuNhFEwKgV/lIzcJUhphhh4HbmUyFNtvkF5AHUzs0u6FOMqJQmfJllil2rRieA
 E1Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJkdyBaZf/5JulCf5MNSE+V+ZwKulwA9B1gpFinv5Gp87UWAIpJogVCVLXF4r20CkslxZpx7c4TL4NZY6xx3tTX2bacw==
X-Gm-Message-State: AOJu0YxwPPnbk/1+L6MFmwOcDb8vkS9EHcViwzycPip9xY7P6lIVLgMQ
 aHCWpa5BvfOJOM3HYRMwHaSL+saFqkHxX/JRLeSSx/HLNkq8zteoMrxrNXn4gR0=
X-Google-Smtp-Source: AGHT+IEN6jKf0/OM94vjQl61vpOcQc4TiIsFZrva8mqGot61Nm+RRBj5DzBzdmqeL81bHGJc/Hwl9A==
X-Received: by 2002:a05:651c:2221:b0:2d2:643b:df06 with SMTP id
 y33-20020a05651c222100b002d2643bdf06mr6171880ljq.2.1708968393268; 
 Mon, 26 Feb 2024 09:26:33 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:32 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:16 +0000
Subject: [PATCH v5 12/39] sandbox: dts: fix qcom pmic gpio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-12-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=WwlByNL+1NWwT33/3zhBxoRhlvahb20kkszxnelIp8Q=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3ddPvjnXmRXB+uf1VoLWzS/qXzjdOjsNdXvWVF2d
 gaPVefKjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRMgGGfypBHpwv/q3KT+pY
 fEWx9/WWRXuKihoYlV8eXhSwYAvTpecM/xOe3/qz8t9JperTF4v/2V/5emfOQilHkT3ZdzQn7f9
 hdLULAA==
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

Adjust the DT to match upstream bindings.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/sandbox/dts/sandbox.dtsi | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/sandbox/dts/sandbox.dtsi b/arch/sandbox/dts/sandbox.dtsi
index 241f397ba6e7..c93ce7128942 100644
--- a/arch/sandbox/dts/sandbox.dtsi
+++ b/arch/sandbox/dts/sandbox.dtsi
@@ -418,19 +418,18 @@
 		#address-cells = <0x1>;
 		#size-cells = <0x1>;
 		pm8916@0 {
 			compatible = "qcom,spmi-pmic";
-			reg = <0x0 0x1>;
+			reg = <0x0 0x0>;
 			#address-cells = <0x1>;
-			#size-cells = <0x1>;
+			#size-cells = <0x0>;
 
 			spmi_gpios: gpios@c000 {
 				compatible = "qcom,pm8916-gpio";
-				reg = <0xc000 0x400>;
+				reg = <0xc000>;
 				gpio-controller;
-				gpio-count = <4>;
+				gpio-ranges = <&spmi_gpios 0 0 4>;
 				#gpio-cells = <2>;
-				gpio-bank-name="spmi";
 			};
 		};
 	};
 

-- 
2.43.1

