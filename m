Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8C1D3B7F0
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 08:34:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C848899C1;
	Mon, 25 Nov 2024 09:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E5c5m26M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1A36899ED; Mon, 25 Nov 2024 09:34:33 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4660E89657
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4349e1467fbso7047825e9.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 00:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732523670; x=1733128470; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bo9Hu66oZ8PsQMoD2Su7fUmvQ1AXzDE8iHd+dJewOpo=;
 b=E5c5m26Mkq4fKKHAF5khhNY0NOxBSpTqNOf6ezi9eNxCtLaBcYAkI4HMRmYaKpnDk1
 JyPqmy3U0Aq5fZJfEoEvp1cAPVXBM3LA+VGuEbVGCGwUygtkPfbPUztNdqxagEbZGg14
 YRixjIZMDp5FZB5HXVb5/HNPMfIhVv7v0SEYttfVzaQmoNq8kUHRq9W+msHYsPlU3TLU
 uiXC0IT/kac2Sp/lWE0zpkc+nuZieNJbQCOIjwciAyQmQH4Cku1tegUBehKWdIUsG4R9
 sM/lIJnCr+VwtA2h+z1IIktc4q4i0l88aR8WquZ85phSqLFG7U7+cj16isfWpbxUZfD0
 aRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732523670; x=1733128470;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bo9Hu66oZ8PsQMoD2Su7fUmvQ1AXzDE8iHd+dJewOpo=;
 b=tUmVcLOnd0Df4Zj/IImB2/wSbjVDkiyYJ8Tml3+pJUO4rvs0jWh1ppWGLah0ll4UlZ
 0YBDE7uoJ3WyZxqc51mnYBHqcGjTwcPgUtcTCRTRrfS9zsD1yeO6lYY2kzrsYEylAI3o
 uNbzqdT31wAo76ftMVQMtI3nPgmzFggmX14h8dfnmGUxUnPZtRmbiJH9NySQLnKKNygy
 nWInZt8zEh5gVFF0KaCJGnZrt4iesZH2htTpWSboJLDoIWa+/lYAp0hh2lG+HOTBleiY
 xWSB8vgb+NGUcpqM9tvEGONkblYjwaa9b+yK+Qx76mfpL1b/IrncZKmldDfljMthaGnz
 RFcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKncuhQ8PXav55ce7i7NObWdy+UmL4mlr9LYOcOwjgzDg7Jte/svzLeBfJCqtEY+l4UFt2uq0=@lists.denx.de
X-Gm-Message-State: AOJu0YztFp0pzIMgLMd9O9xIYTaGnN91w1Nski8ifpUjLM3gWY/UShqw
 0yKK//Z7kaa+VaRxbCIK8m3BZ15F4rEPB8Exick+XZfzoQqh8cFtcfR7saXutTc=
X-Gm-Gg: ASbGncvtpd+nkvAYt1YDmgGu5ylnXM71sTxm8EJcyChxifAYkcLKF6rlnn2Xam9bH87
 WUoPEBw70cabhFl4Qsm42qQBg4N2IY/soWKnjjNhbiWLfmuGNOcFVKSqEtCq0folHIjQ/8XOshI
 VYZNbSTT9usjw04YGIxsAHs0Cb0rbATUDX8NFjRGKv3l6Ptkxs4hhxqfVMfsqQE/3PeyWQTA2YC
 StUe8Fz7fBofOHkNtBCNnQHsRK8AEjXndMI9tfyxcZ9qZRN3mvbGkj4P4ZNzx1PaGG6ntE=
X-Google-Smtp-Source: AGHT+IHJGLqAU2neLS4ZPlkSE7KfGt1EL0YVP1jiYbSGOXmU9NaFMEubTNcLl6piPoGjQA49+QUu7Q==
X-Received: by 2002:a05:6000:1449:b0:37c:d569:97b with SMTP id
 ffacd0b85a97d-38260b60008mr9674420f8f.19.1732523669664; 
 Mon, 25 Nov 2024 00:34:29 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825f98b3a4sm10013421f8f.0.2024.11.25.00.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:34:29 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/4] clk: qcom: add PCIe clocks
Date: Mon, 25 Nov 2024 09:34:25 +0100
Message-Id: <20241125-topic-pcie-clk-v1-0-4315d1e4e164@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJE2RGcC/x3MQQqAIBBA0avErBtIK4quEi1knGooVDQiCO+et
 HyL/19IHIUTTNULkW9J4l2Bqiug3biNUWwx6EZ3SukeLx+EMJAw0nngyG3X29EQDwZKFCKv8vz
 Decn5AxfNIfJgAAAA
X-Change-ID: 20241125-topic-pcie-clk-8e345d8ace7a
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jYNgRXjvGSiarvMG7dlJyGEvg61/N2e52gONoI1JQdo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnRDaSRBpa8R1jXS2zvZlpOGBYTP6E0pDEUil0St9K
 lYAIHL2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0Q2kgAKCRB33NvayMhJ0enZEA
 CuENIZBI3DO0d/aeTUWor6eau8fHAb+PTM1uyA89HWaTGYfunQlV/PjnkWRN057Etyp+5AqHic/rjz
 4KkbvWDl1GL+7yRJiWfvXGyROl+8KoOAuXJcP/6mlw+nNTkru5nhiFqkGBEm4igxnNO1XUHz/lYLHu
 tFbQHp9yBSi4Gs5z6sa7eZKf4lMtYzfwFtO6KkVrvYuUCcJ03EPBwC8vr4K/zUWAbTd68QEVzGQMc6
 bMSKBZK2ZvIQ2t2BegXRbSvNtfmrAiTMNeYUMBYkJM2M2lWqrUP9q9FFQ2yr2fX8QPU0OzD6NIwvh0
 SZnaeJwH7II8XoG7qLfgsuI3Gh5Z7Ex3PumdqYgi0X7fwtu+bjRYXdYH733P1lbzBj1H2EZVl07o5Q
 hL/JqHfG4ltoMcDwmXJ6Ujakhunl0NiF6B+jttW3n+oZzDAVMgKTXFWP35UPJyjPLSsJRbTm0WC8AO
 mRYgAm0IF2aRrKlFcTWYVJAwZduOpGaoAkSY687vhPQ5Y1cbn0Q6nPgxR4ObNus5NVomUc3EQIRMI7
 32Rn2q2gsKA027A8H6ge3bFY2mqB4ruQmamnQlQCWBufNS4tXk89yUJ65qIqzKC6nR3RWw+j+kmpb3
 eKZxR1RLRQZ2HVGXAzU2n2cZnE13bRhYPnsA7pFnOyuHWlegfBIofbkf8toQ==
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

Add the PCIe clocks for the SM8550, SM8650 and X1E80100
platforms to enable support for PCIe feature.

Depends on:
- https://lore.kernel.org/all/20241118-topic-x1e80100-clk-v1-0-8841e87ad81f@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (4):
      clk: qcom: add clk_phy_mux_enable() for PCIe PIPE clock
      clk: qcom: sm8550: add support for PCIe clocks
      clk: qcom: sm8650: add support for PCIe clocks
      clk: qcom: x1e80100: add support for PCIe clocks

 drivers/clk/qcom/clock-qcom.c     | 19 ++++++++++++++
 drivers/clk/qcom/clock-qcom.h     |  2 ++
 drivers/clk/qcom/clock-sm8550.c   | 36 ++++++++++++++++++++++++++
 drivers/clk/qcom/clock-sm8650.c   | 36 ++++++++++++++++++++++++++
 drivers/clk/qcom/clock-x1e80100.c | 54 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 147 insertions(+)
---
base-commit: c7934881aa75d34aea2493322de0a417524ebf4a
change-id: 20241125-topic-pcie-clk-8e345d8ace7a

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

