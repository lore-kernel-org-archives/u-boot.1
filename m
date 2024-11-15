Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3242AD68BC6
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 15:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71D9C89221;
	Fri, 15 Nov 2024 16:44:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CFnqJS+Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF4089362; Fri, 15 Nov 2024 16:44:21 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E93B89294
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 16:44:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4315e62afe0so16908485e9.1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 07:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731685459; x=1732290259; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fyLxjtMSBtFxwOuNyD9lDgw7kfhukvlG21xsyoAkdw0=;
 b=CFnqJS+ZGsjicSztz3t7tWFPdEyzjOeXsK14eO14pNwzfRMCGoD9ooJ3v8+H/UZ8/G
 t7KIW74cwmftNXDY9BDHy/udBctiIuAQAtp/2xIZQ5zaGGrUCTyX2jnLayF39wgyT/Tv
 di3kiz9iJlQ5J0VrT9A1lNFqJgKj9RgjPCTBrNyGKbm3dm6e32geFkEFtPL9ZIV+u2M5
 a/QdQK1DSmkYGRR9R1wbcaVenTQ4sHOMz+bvodKwkdwEcfQrrepQhfsoTvvujdKqSzhl
 cPZ72znPoxKq74BT/BTp1aTNTK6+aMIgDz1obA8eihoSIS3KAy85BDYc2KCjCrtv8lNX
 pPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731685459; x=1732290259;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fyLxjtMSBtFxwOuNyD9lDgw7kfhukvlG21xsyoAkdw0=;
 b=sRd3N5tD3kwbexa3hqPMSg05AasFEbe3qnyhM2Rfpam+7Sb/7K3D0pE9Y1OaJr79hj
 BFixHRUTgyPg0AhxIaFgk99sQP0jkeBD6vbe2Z97wuTzZkgfiL8SwCukXVTrcrJ2Cp4W
 gMNuSekieXme1Sytay5bIkAGXTpm1ljxKWkxRTdGsdCfejIp/vNyhob9Y1ko/UnndJYc
 X5VwoYe8wjHdVFnn0N1IermmPCTRLTbwNd+x1zz6yCQpUYUwdOtIMBR6qrLkQhdLfu5n
 AL8/uJDXiUu0JkFgXwhHeaRFsmOl22bm/vfR/GCFA1wIlbtH+dME102r+qaE9jzGaV+Y
 9FVA==
X-Gm-Message-State: AOJu0YxYxkgPChP/YXJYiVmmjItS72kfXX/TLRso1LVqxxE/NR2SFm4f
 ulHyjS55UcFnnkMxFqPaKviH6Ke0uvqI8EiPXXXSCm3PqQo3RaWz0ozGuDjWtaY=
X-Google-Smtp-Source: AGHT+IF0YRMvvKp/r3BiqUESSh4rx8SP20tevpopOg+cjqTLkgWq61U+nsmyqk3vRz2eDX9hnSL03g==
X-Received: by 2002:a05:600c:1e18:b0:431:5df7:b337 with SMTP id
 5b1f17b1804b1-432df7286ffmr26720045e9.8.1731685458724; 
 Fri, 15 Nov 2024 07:44:18 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ada3fc9sm4637773f8f.20.2024.11.15.07.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 07:44:18 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] pinctrl: add support for X1E80100 TLMM
Date: Fri, 15 Nov 2024 16:44:14 +0100
Message-Id: <20241115-topic-x1e80100-pinctrl-v1-0-35f984226e47@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE5sN2cC/x3MTQqAIBBA4avErBtwouznKtEibayBMNGIILp70
 vJbvPdA4iicYCgeiHxJksNnUFmA3Wa/MsqSDZWqaiJq8DyCWLyJO0VKYRBvz7ijM7q3rW5NQwZ
 yHCI7uf/xOL3vB8SF0gNoAAAA
X-Change-ID: 20241115-topic-x1e80100-pinctrl-fb69c767b51b
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=713;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Ad8/QAXAeGUmdRdeJpW6DhvlFhQADAyqY9iHqIfK+tc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnN2xQCXzQ11FPCOKDExkeM1giyyNLrlZR9rUuYiDl
 KZsc3c+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZzdsUAAKCRB33NvayMhJ0X2tD/
 98vrV1BgwnZtxYFR1R9E3A0kECtVJI1ehoQWwEepitrwu8DbTYLmTOFWqTXFikxPVGIngUjgixkpGX
 55Nff7tm3dhejvL9UGJ6mDQd86UxB3DlDTiJ/JFWWimsiluY9w70iYVPrdEKFec3gKoAAgp2veSz+5
 ITsiTqDJDgez260i6iGVLuF1EyZemdAaMWoniSfxmZerI51Pbn+XC5d7BAtT+imUDFglkByGkDUZZ8
 /X3U/5TzJTWg7Gc/+by9Py6w3osTnA0vW3h1oasUC9RQBdvH+BgDhWsGLXRxWmoFdeq096WuWC26uu
 JFB3iauW34VZIdAIlNsKcCcHfj9RCZ4V8S3mffd0KydL6B/ldggvcrJVqM0BCG5YjiUIWU0r4VvHhx
 DU0/XSCisE+9zJn8etexqjV/rF1MKFAVcsUADhzhWpUJLJrz3XSlPoE5HzugVZ1viCfVmDwjsWFLsd
 2cNxmttsiwV1wLJGyzxKiAK1gn2J+agG65O0fFZ7Srkx1Pu+krtD1OmKo9892jMbi3izi231Tp+HQa
 ybJIvf1iKe+rqmxyacG47R7HxXCX1raIkiRcy5ck63bpnBc90PY6ear1vdpkWiDbiwAI9eDe7dENVC
 VqMyBXRmCgSff4g9JL6ueJmB/I4L1u8zEiIBcai3k489OvX1X6af9mduCKSw==
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

Add support for TLMM in X1E80100, and enable it in qcom_defconfig

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      pinctrl: qcom: Add X1E80100 pinctrl driver
      qcom_defconfig: enable X1E80100 pinctrl driver

 configs/qcom_defconfig                  |   1 +
 drivers/pinctrl/qcom/Kconfig            |   7 +++
 drivers/pinctrl/qcom/Makefile           |   1 +
 drivers/pinctrl/qcom/pinctrl-x1e80100.c | 100 ++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+)
---
base-commit: 56accc56b9aab87ef4809ccc588e1257969cd271
change-id: 20241115-topic-x1e80100-pinctrl-fb69c767b51b

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

