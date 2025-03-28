Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81302C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 08:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C317F81E06;
	Fri, 28 Mar 2025 09:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q/F0asaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38A9B81E6C; Fri, 28 Mar 2025 09:53:28 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6F9E81A0C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso1335727f8f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 01:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743152005; x=1743756805; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9cMHkM2nk5/R7lypKEEPJYe69ZOqC6LW4uz0RheZJp0=;
 b=Q/F0asaP/htxgEMk0b+FhFc3TkuBTaoqyX9QQjjjtivb2fEbBkVepGsXenwv5lSQzp
 uIDOk0z3+Yk2bFugRNZytZOnRDsbgmmReL9QlmvchBg2SZXj+3owVP8lY/fIgyvFCeyP
 KGlXxjmbiBu3RDmtJZg9RIt9FA45HfTGTODrbRk28Ej+6cg3kebdjB6ixGewEVDe9LXF
 actUR0R2SuvlajUbjYCQD8imjL7xtNBj5B5SXyssQsTnSMYqipOn9J0hWDChTgNmKiau
 IlyudXe+7mVsE2SIcAYLnXQQwasj5D3F5ops9/PIz/rnd8mudjBEdoAUE+EcpZIZyeso
 Xgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743152005; x=1743756805;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9cMHkM2nk5/R7lypKEEPJYe69ZOqC6LW4uz0RheZJp0=;
 b=oQQmNahPcvvkkQdfjdzJiXdSBuJk2CUtONCHPQCkbEbtgOM2smIIc+Wc5i9RAV7AVC
 VOZWyb8APwA5Fi0mKLt6JkvbWeFW2u3uw+wNV7xBHrHJIbZ1M0ZoqEQ/vjITez2tby24
 VnxLrAQoPvovKg3Urn5qRThAm8X+N8J2wFVyNWH9hN7/JHeRd4vlJ64+f3MYhib0rjXw
 aRCfb7VkSmQd4IvKeiEmjcyvMxuXRkjbuRFEXWQ7HMhTvLt72xL8bEnCrS007JFzh4jJ
 U+W/bUt3fmDT/smITFk4AruFMxWGEr29sCidESdG1s49Zl2AR1UsHt2vCn11dY4K7a+U
 o2iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkw2uarWMfwCa9wAr8fhXxKmPl8+QBEE3UrC1AwzjEItMlr02G6REuazGovck8sVGD/rgVcZg=@lists.denx.de
X-Gm-Message-State: AOJu0YwdICcU9WWOYnFXDBIRC5XKfSiV+bS88KXihK7XB259k1vjU9wx
 J5W4BenBSXuNloqLbASx9Pdo+0G9qJ2wNVnwByXxXVh9UWiTWG3KKFAPtWmW1dM=
X-Gm-Gg: ASbGncsvi53umlepJLjT37hkIkGD9eQuZyHgWlM6CjqXjT6p65s976nBmK118+xIQyb
 oAQfCRl534F4RH7rOxAp2SQZYECfzvmF1fTJ4Nit+RKQ27OuyD5ODOZsUmKSQ2sONGdl0HrElDB
 +poxR4hqSNnkAFyepvmFnzsUGgftKcBzYtBwGSlZ5lD/7yT3ZAd+GCFTLg09LQIqiYx2KyHYZ9Q
 zMO1JW9gwO2qor2WrVUxB/67I7KdzJrCuRM+sa0JD6WxRNETBVBieu6T0fg/LNJUsUspZLgjBkI
 lX/KWynzW3wvR0EJxe72P6i0WHJOpIHaP0fqRm3vfBuFGK0toA8r8P0pTNzBfgIL6Q==
X-Google-Smtp-Source: AGHT+IEiCm1P+bcuzIOtaFIn34MQqqr/Ctyl7SwUIBZtiL6NMlsmpa6woBSuDt4GHlPBP1SZAcfe+w==
X-Received: by 2002:a05:6000:178a:b0:391:9b2:f496 with SMTP id
 ffacd0b85a97d-39c0bf32242mr1439397f8f.16.1743152005200; 
 Fri, 28 Mar 2025 01:53:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e0basm1969794f8f.63.2025.03.28.01.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 01:53:24 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/4] spmi: msm: fix pid mapping for v5 & v7 controllers
Date: Fri, 28 Mar 2025 09:53:20 +0100
Message-Id: <20250328-topic-sm8x50-spmi-fix-v1-0-a7548d3aef0d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIBj5mcC/x2MQQqAIBAAvxJ7bsE0I/pKdChbaw+puBFB9Pek4
 wzMPCCUmQSG6oFMFwvHUKCpK3D7HDZCXguDVtoqo3s8Y2KHcvS3VSjpYPR8Y0N6aY2ZO+9XKG3
 KVPT/Haf3/QAMN05hZwAAAA==
X-Change-ID: 20250328-topic-sm8x50-spmi-fix-1e2b433a6ffd
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=971;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Crqo+goIfzzRC6DtmNEoZ8owKHzx5cqbya+Y6dPF3lE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn5mOCrUSkQjlGGxN/WtYmx9P06ywdu40Ph5yptesT
 CWQMPgCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ+ZjggAKCRB33NvayMhJ0UdIEA
 CAY7L8BdI5aKDQM/EFUB4zbUiBpA7oLWzs72f8Dckf43QWgPU4xPrWjQQqak/NVTEX3cabSpZJu0Sr
 hxwTaTmOqfDSbhNfUK+XttYy0L6SBQ5h5Eo32svogEPE5+64BbxL/5mGhUa3TlZHxjDL/+n7NOdszH
 Uw3EqI+IrCzZIMwLAFVvN5/hQXzzCQj1NcBVvSBbi3D3wdygpPd/VJRY249MrCFJYr0gbiHtwzoUxw
 Uoi7Pwg5lHtJ46ds+dHhwS+ajghzUuikcRhooCItKDW3iyALvzzpMzqOU2P7C6VxaWIOECwZaeoefb
 WmNoazy9LWGox7d/EefrhFe7N2DxCU2x+wCJkQtFGlfJbgax1a8IFd9p+TI4ikVQcnehhxfenwhHmi
 Cw2DlNhVmgUZxQiZyG2aqHzMIgHZcbkER3A7slaopofaL2ii9pdTEGSnM0bRyASEbxmO0ZqTc83xKq
 5egtqH4dLeuGh12YM+C2dDd1aJAT5KHIz1D3LntaQWG5qXMoeEyDH82ihTqVv9j0VzXjTiLhq/0ukB
 qrFqF4MfuyDpGqBEd7fwSexZvD0CSJUjl3Ai89Rli6/L//zWKh5Dn9dSKmfJ0MrBoqpW7Ab8TpHO4w
 hbuZ+DGsR/D9F36RMYXN7yIioENJi0YRcGvKWh2THrXt8fpVDOaElnv5xyuw==
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

The v5 & v7 controllers has complex mapping for
different Execution Environment, and v7 supports
two busses within the same controller so it needs
some special care when parsing the hardware map
table to get the proper read & write channels.

Test are welcome, especially for v5 controllers.

Tested on HDK8550, QRD8550 & QRD8650.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (4):
      spmi: msm: use real number of channels for v5 & v7
      spmi: msm: factor out channel mapping for v5 & v7
      spmi: msm: introduce SPMI_CHANNEL_VALID flag
      spmi: msm: correctly handle multiple mapping entries

 drivers/spmi/spmi-msm.c | 59 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 10 deletions(-)
---
base-commit: 4adbf64ff8d8c730223fd8ae299d770bebb6fe86
change-id: 20250328-topic-sm8x50-spmi-fix-1e2b433a6ffd

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

