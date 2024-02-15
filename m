Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08727C48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41E7C87F3E;
	Thu, 15 Feb 2024 21:53:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fJHhGi7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9743C87F27; Thu, 15 Feb 2024 21:53:05 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9081C87E9C
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-411e5f21c0bso11354035e9.0
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030357; x=1708635157; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JT/YfULvcUfAyLH8loGuVjpmYwwBYpOtdZZCAuGHDmE=;
 b=fJHhGi7B6I1bGd+2suGiKh7NI/evkdDGE2j6S8HR+ZVi+kJPzbvUDX/RSv1cfpLeoD
 KRLMx5syzHhkO1O1Iud3bg7tKlRrisP9qtVHrKzSg23S8xv0QiOVTuKbVy5L3fMtd0jL
 Kq75+7ntRGEIy1F2KboquLzS/xJXXvosErJnlCJWphCqr/X2TnIkha4duzsHCZkDsvpM
 lzC3VbAf7ICDJEKrTC7yeciRmD7Sn54oSOziY415gwx6Zp3koJnl6/BEdPe9LiA5HRZ+
 noIvyI0uiNng96XXVp25zneAXWYLvgBhxQpTFAZJWnjP4+NBSlqf41EqW1B8vpUNnXLA
 XEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030357; x=1708635157;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JT/YfULvcUfAyLH8loGuVjpmYwwBYpOtdZZCAuGHDmE=;
 b=jsE/oqqeOcakpssC7hvBuqRtm4xmdgFu7Jk4vJY28vwa8MrXQ2H7v9txegayh7LLes
 P8K/QTADvydX2m9wpxsj8zyIX6s/W1DI7sfqCZvW3pU5G2vjkb5MlnDdXjYIQY+UVc26
 IuGFjK5QKs5fl6FNZYcI0cSboOPhRedYNZSybtlKWWH2qQ+i+ifb6vIl3xobkvJpkN7s
 miTFg5tdvkIi2iyuHgFpO5xU8qULBmPC4JDhp1vD3hk6SnuieYruIV3GXqpQKkyIqIy3
 BS9dTM/1rD3C/aQpFBrjHzpcCD62wQiOClo5lmCaqb6lmYzJzzFFLZ+ZkJt3nd+kMg1s
 cczw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbOhUc5BSxQy+cTL0Y2D/gC0QzQTNQCyMhsCA9Xz/itOo7tTxJ6Btd3ZY2B+1mwXoPE9bqaKKX0QRzVoZ5fAN8J0Bqlw==
X-Gm-Message-State: AOJu0YxB6acs+uMAIlthTlGCKoYIf4s6g6juAzptBubV4HYA64gaG8Sn
 t1uSxDnhPCUBzHnqrWi44zUfvL88w0PHXCUpfdwRfjkcmCUazU2n9kr/euuTmY6vj4cUwlM4Amm
 m
X-Google-Smtp-Source: AGHT+IHh5rFZWXJgzaAk9fuvSnphnRR7oJfsRI5BmKwY8IV1JuWtXb0OBjsG4akfBpTZmiLlcvd6Ig==
X-Received: by 2002:a5d:430d:0:b0:33b:65b3:e51b with SMTP id
 h13-20020a5d430d000000b0033b65b3e51bmr2339765wrq.48.1708030356934; 
 Thu, 15 Feb 2024 12:52:36 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:36 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:30 +0000
Subject: [PATCH v4 12/39] sandbox: dts: fix qcom pmic gpio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-12-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=922;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=fm1qcyWTfz46ooE7qb9F+mNmYNekLls8y4xKlrPYAaU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzla35rutfC3KeyLi0jScwu3vn5m0N26rq7hT+/zfb5
 rrIg2tzO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBE3A8x/A9ruuXxPy10Xqem
 7r9nX86tY/2fMTnJJP1pRUnrv/gSx30M/7TeFSiFV9QdFVk7waNiRsqWbTMc4nk4lrJm55znSlN
 61wMA
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/sandbox/dts/sandbox.dtsi | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/sandbox/dts/sandbox.dtsi b/arch/sandbox/dts/sandbox.dtsi
index 241f397ba6e7..c93ce7128942 100644
--- a/arch/sandbox/dts/sandbox.dtsi
+++ b/arch/sandbox/dts/sandbox.dtsi
@@ -419,17 +419,16 @@
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

