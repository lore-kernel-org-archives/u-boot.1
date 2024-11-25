Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7BFD3B7F5
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 09:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2521C89A0C;
	Mon, 25 Nov 2024 10:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dJSQC/Tl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C82289A17; Mon, 25 Nov 2024 10:46:21 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 174348965A
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 10:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3823e45339bso3155132f8f.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732527978; x=1733132778; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JyKxS+hLgYzISS3761MGPAZ7z6zzltfIEZhEborCt3E=;
 b=dJSQC/Tl+hcTwQHeAdNPDSeMOMLpDMBVbbjrOc0LceaFCUV/ngKhOT8iTXFWBrCLYB
 pHM1/CdiU/pnE2cjV22v7w8RGDnFAZfakZwyGPMQrzDVlGsz1EOrQuvm+/iGUyoyrok1
 EzNREkg+ovBnbpxc/e9slB/KEyWUoLesxBNtNVLvf6EjW2yme2zqbDRjIEbdhZsEkgMi
 vrhJk6oWw/odi11FV2o5bmDCkG9bnVUMO74X4aP3fHb6ENJJo735MYFERRFf9b4DW3fC
 WMKHlL94rb0QCBsFktk5nQ0SYGjos3w3/bLhEK8oeux5k3SiwUofNxY+xRRWwiEP0Iwq
 OFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732527978; x=1733132778;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JyKxS+hLgYzISS3761MGPAZ7z6zzltfIEZhEborCt3E=;
 b=G4XiL+gZILWPAyuRlH1YCw8fQTHOCLx8EEz1MV4W4ruMxOMlm6EVojzE/gUmBKuxCj
 vaxi3MGy62v6fNu9nG2l8s7dusrVX9rVsLUtOent205wZMvYlsC8kl78awo1FJC5Pn5Y
 7Sc+27nM+/lQ1vmP7hJMDR2/Tw4pQB70+YTs/hfba+EBlbkW2mNgdwJDQo0VyAfyGMTF
 GdxG8nMVTWUDK4vPuG9IBaCO/GE4bVplpmadQIqZXzepDSqTF29SOz26BudhbcSeLQkn
 XzCP79qPXTa5hcivVzMS34N/YukZ79YjnokyHKjwzbilWGc0SQGc28i2W4/RoVoQc2rF
 dUyg==
X-Gm-Message-State: AOJu0YxzB6xlVOed7E0yZogbdAczhC+j4F/Oh5pKc9MhVHVegXLIyLLR
 pQoeQcHM+9Iw6iwWIgIIfzkAxE0Oy5g9iph8fhp17/3oG9Gg1YGOZZytkncYDBI=
X-Gm-Gg: ASbGnctoApQFJYp5UiZOLVe4OOhT0mu2bSaoBRT32LSDD18iRna/2L3aucj5gZ5oyVh
 K4hLHQ5eg3bPCJphJzgHxdwUmElXbsBmD0nWcRKxOJJKKeqfK+QPri0dhoH8Bj8JMxkiguuPr1K
 q5EKYtVbnrlPM129WkBDPa+dkExl7DkzPO0fvG2KCpXqm1ODK7GNUVlwEhHJPA7BLSLKl7j0A5F
 m5O7CmB+CB7r+dxtaimp0+5GZZug2M8k7IpND7li1shzAa4rznNXmma8dBsY9w66YAGgeg=
X-Google-Smtp-Source: AGHT+IE4pIC4Bxm78UnV/M0+zzZDqAfvm8wKWlXnW0yo5JhaakYhteGOO1bp/LIzhjwuxKN5+U1JCQ==
X-Received: by 2002:a5d:64e8:0:b0:382:3894:3479 with SMTP id
 ffacd0b85a97d-38260bcb9f3mr9805034f8f.41.1732527978581; 
 Mon, 25 Nov 2024 01:46:18 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb271ffsm9804590f8f.53.2024.11.25.01.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 01:46:18 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] pci: Add support for Qualcomm PCIe controller
Date: Mon, 25 Nov 2024 10:46:15 +0100
Message-Id: <20241125-topic-pcie-controller-v1-0-45c20070dd53@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGdHRGcC/x2MQQqAMAzAviI9W9imXvyKeNDaaUG20Q0RxL87P
 IaQPJBZhTOMzQPKl2SJoYJtG6BjCTujbJXBGddb6wYsMQlhImGkGIrG82RF8lVas/ph7aC2Sdn
 L/X+n+X0/bj6mgmcAAAA=
X-Change-ID: 20241125-topic-pcie-controller-cf11210bf5b3
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=883;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Ms54ZhaKqTJn9UDj6cizrIZJTKnuVFsIYiXUp6/W3Vo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnREdoQDtzWGj4z1lXJzpVLVHJ9HooOKUdp7M837t7
 /TaMj6KJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0RHaAAKCRB33NvayMhJ0TQdD/
 9vbZqm/rLsAQ0aVrr688vjnl8ZN6xY8tMbjfbYGSlRjXSvgH8nLYuVXmlgYfiRaGQ8vDz2Eo1N6gwG
 BLoHQUL3wCU9hhTVVCoKyg9uA6tCRWlElrhMYM6NW4wGzgmHYkPGchic2EoZ7OByDfIxK87KLEP5Rg
 lrcGuYIMyI7MnZJVekKPVOtbGPXF6OzxT7lcaNr5Qhx98VM1O+tBnOodHp/ygQl4y+ioxND0Y0oPLX
 SVwHfLhUhsRygzF/UztDu3bK91RoWHoxYuPl13T5nsmokjuCt62h6JOtjx4Hs1SrB711wyJe+ANTxX
 tV9a6iKfoEWr6MMrZN/xJudz+vxFY9I1FBRlLVcOJmaHMmCtpTuxF5qJTCqFy/ahzIAAfGy9juvDJJ
 b7B5fr9o7DyizHLObDp6BWQDcjDt5uEnyFl9nSAYBNVwrf8mQF3hqC7r0UZmI8cKHlYYS23FIPrw+y
 2/ORjvEZ7QiPsVav72cbBptwIQ0w7kKpC4qRMVXyO/vtFIc+1mXJ3wtmxmw03Hz/7kfQPTX2pIDyTv
 F+4Q07FR9vgAin42fA0WNK5zpj1RBEnuGOEUHPJMaxoC8+RSBqvGi6d04N6RK0ETDUnzUu8E9nDdtr
 o0YRwwwaIJGanJrCaGCdRnmcba5tx2+Ueae5j4LRvIJ4s05RBUx5rucRLzUA==
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

Add support for the DWC PCIe controllers found
on the Qualcomm SoCs, it requires introducing
pcie_dw_find_capability() to properly configure
the Host controller capabilities.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      pci: pcie_dw_common: introduce pcie_dw_find_capability()
      pci: Add support for Qualcomm PCIe controller

 drivers/pci/Kconfig          |   8 +
 drivers/pci/Makefile         |   1 +
 drivers/pci/pcie_dw_common.c |  42 ++++
 drivers/pci/pcie_dw_common.h |   2 +
 drivers/pci/pcie_dw_qcom.c   | 571 +++++++++++++++++++++++++++++++++++++++++++
 include/pci.h                |   4 +
 6 files changed, 628 insertions(+)
---
base-commit: 7fe55182d9263a62e18b450c97bdf0b8031e5667
change-id: 20241125-topic-pcie-controller-cf11210bf5b3

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

