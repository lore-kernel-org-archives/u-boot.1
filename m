Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C98C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 909288815A;
	Fri,  5 Apr 2024 10:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R/knAc4u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1967488485; Fri,  5 Apr 2024 10:15:17 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2805887F52
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4162b74f2a1so9642355e9.3
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712304914; x=1712909714; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V2SS4/2t/c6En9Spd9NiFTrW5lny8h6oQLSCLmmKFKc=;
 b=R/knAc4u2zJmyt/OA+bJgbtdN17YkPiq3rmVwAySGxUFEoHJGtNzIckEXR/0JxLrp+
 PGd69avO8GJMMAx0+pV8JBihmtGxt5qG2CjIbOK3G4TTiPzLGX0yTN0/GXCF29e9dS1d
 tgOlUp+qwCTbnk58r+2wpPMk2IlhiQmeR/9tuCWYPj5OKQGx1bG3b/5QozXq2i5LcS6E
 jAso4VYtabnjLq+/UC3uvQxFH/diOKJPYMldtcd+fSGgLReu76UOFEDVfcJPNEfV3mo5
 mGmu3tCDGFpGIa9HajHzNSYFp7Z4GLZ2uBOpEKTX0Rhf+72V5K63w5SVV6mn5SmPWrWr
 EwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712304914; x=1712909714;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V2SS4/2t/c6En9Spd9NiFTrW5lny8h6oQLSCLmmKFKc=;
 b=R4VHNTqtoWRpVpO2BjbagfIkwHE5mWIZBxVaq+fS1U36HCe/sb630TVzy1k4xHNmkR
 WoiuU9iuwyYef3zYkTrW1Mnv4upp6BfiRcpUyGMgOHi34fAqOGhR8/SllZS19ovd0QyG
 oNmvgPb2YV4+3lqdFMBqRBST+QqI8NRdmQj8cMo9rdJsNvjHpHewoFCa9kP2x+99thZK
 VudTkAm8+cYR/9ME7Scu+30/iB+P+oo2yzwnAvzCk3yBK+5OavnWIhcbKzePkEpyCOHE
 ySBKKP+q0WtaL9ae9TgivTok41j/R/PzifE7g695ACI+tegXRE+X+qI/8sLXdc8ogO9g
 KQDA==
X-Gm-Message-State: AOJu0YyvjjnqjIMnddTzLtiUEWgCDTdpPAGLipMAqURdC66Q4Vq2nSVH
 2d1PfYXxF0BgM5X4MS5KUTEseniCV7+5REb9zFgg34JYB/bKcQV/j/bnB2L1g3I=
X-Google-Smtp-Source: AGHT+IESbeJXwKXt1MkPHT9NIwjr1/JLPKPwSEQiHI1IxEGKPOlGYZNY8gv09I/YEPxQFRtVfiS4ng==
X-Received: by 2002:a05:600c:5107:b0:414:63c6:8665 with SMTP id
 o7-20020a05600c510700b0041463c68665mr828527wms.2.1712304914215; 
 Fri, 05 Apr 2024 01:15:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 jg24-20020a05600ca01800b004162d5233d5sm2034407wmb.42.2024.04.05.01.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:15:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] qcom: add pinctrl driver for SM8550 and SM8650
Date: Fri, 05 Apr 2024 10:15:09 +0200
Message-Id: <20240405-topic-sm8x50-pinctrl-v1-0-92d563c28c90@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA2zD2YC/x2MywqAIBAAfyX23IJa0eNXooPYVgulohKB9O9Jz
 GkOMxkiBaYIU5Uh0M2RnS0i6wrMoe1OyGtxUEK1ooDJeTYYr+HpBHq2JoUTpZCbNr0aV9VASX2
 gjZ9/Oy/v+wFk9R27ZgAAAA==
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=iQN+VcFYeJg8JZuruoIqZi7VFWp9omzTnuAU9UaNbWA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmD7MPqr46pMFWCqJ9L1+fglqYBolOchqCWRuSrZDI
 GzBgD0+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg+zDwAKCRB33NvayMhJ0YGLEA
 CHWhB4rK8EKRXZ3N8ohttIAmOrE/xTbOv7m2LyZ9Y5QKVj/lPc3PdxQ/q3uZCEztFNyT6Mz1jSQ9vi
 RenAbXyPZ4lcSWjqzwHA1ClJlPPqbCaoFp/ip+B2r6CMyiNdQ5f4CrSVltoLQhZJJl0n0mj+vClROC
 FuI7HDZ2/VnNOPvmuckWaEcePZGcoSdsNO0mfy5oQB2eETMeObPnmlqjkIifCMHp2AxIwlPi0HU5ie
 kNrXtXorwhCPwzzIqI5g5CNcNxO5Hu0x3sghyaI/ZcZqjm4/NP9yQW04xuNWu2xKhiTjs1o5wx/VkM
 h3dE7IwEeLmFZmKsRCcLXsmPKEnSMhC3BPyY2zdW4s3JVUZuL63sFUCKVMZjDyZMCNQSdwW4DjVaiZ
 pGBgCB/MqF+da9NY9eQqOtGnfiCQBPg0dMuKhIIWJhcVIoTyW+EPd0unHK7R3tYXRW0XHSUGfkALfB
 gQdFFfYMs/YwDj2ggzyqZmOqkdYPCxtSNZ96cj6KjTdTZOfdo346XhrQp0amEFJeKBYJmjFdZ1JY8W
 R2ykMaBZMKjfBzSVyFZL5IzZqd23em9LhrY9ltDXtoEAnMVlINF9OJ9TbCpm1a4ChBatktImA/E4Es
 a36YmwxG8k6jkMgO75PfvbpFlkBWG0GX32zd+9iLj8bMs/eTunnw5KWhn57Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add pinctrl driver for the TLMM block found in the SM8550 & SM8650 SoCs.

This driver only handles the gpio and qup debug uart pinmux, and makes sure
the pinconf applies on SDC2 pins.

Finally enable both drivers in the Qualcomm defconfig

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      pinctrl: qcom: Add SM8550 pinctrl driver
      pinctrl: qcom: Add SM8650 pinctrl driver
      qcom_defconfig: enable SM8550 & SM8650 pinctrl driver

 configs/qcom_defconfig                |  2 +
 drivers/pinctrl/qcom/Kconfig          | 14 +++++++
 drivers/pinctrl/qcom/Makefile         |  2 +
 drivers/pinctrl/qcom/pinctrl-sm8550.c | 75 +++++++++++++++++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-sm8650.c | 75 +++++++++++++++++++++++++++++++++++
 5 files changed, 168 insertions(+)
---
base-commit: cec1c47bdaf84a643f318d480b1218bfff1041ff
change-id: 20240404-topic-sm8x50-pinctrl-101fac729d23

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

