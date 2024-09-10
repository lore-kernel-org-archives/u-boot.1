Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1D1ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E201C88FD4;
	Tue, 10 Sep 2024 11:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zOU1vIKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96E8488F7E; Tue, 10 Sep 2024 11:50:26 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2294A88FB7
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42ca4e0299eso28768555e9.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725961814; x=1726566614; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=162gYNsGnKE71FSIbRen2KNBrLK4FtYW5p3v1kYpjPw=;
 b=zOU1vIKrNoaYjgvPsClqjFUpD47OVk+jj+R30YwvMgqhrW7E6yz0S7Q8YWYkH5PP2D
 d1e1rqze96SuFC97KS7DfBLvXHJa6rInzEYdw3Am40wNW4ZVIFS/GdhYEH2ozdbiaIlI
 2912zup3BN4cFK9VamKYqEGRV9k7JcobPS0gVeaWhfYKnw9KHh/eyfOun5nGcJSWl/w5
 vS+OirU66+2v4TwP8a1I/GiI8ROo34wQlTUAM2xux7IeMX5WkoDVpqblgk5hRClenQ7P
 hD2XheGyh1W7i0hGZy7fOTaeQpBCLMfaC5S6u5NDmerXzz8hY6R193DO8ErwhtvaHxCC
 QYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725961814; x=1726566614;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=162gYNsGnKE71FSIbRen2KNBrLK4FtYW5p3v1kYpjPw=;
 b=MsXBB2vy+UR12e91BFleAOl4XUSkTLlxh4r0KvjsL6cKULOJ8d+HahNDQALX/WNeQ3
 ysYLP7R+aSb1PJ0Q4NtlIcl7NJ/oUrDtqN+TCk2uU5mBeESegxGJxK8M6s4bTP4vzqk6
 R4DLhM6Wl4L/M/ppdTHnFBxPGfoVmxcGIDwuCVKBLZJuehqI377+VvZNERguKm7V9uR9
 CY8YLIEEKi8bHaWyDeh/jvgsfHUnOHVKxa9AphK6uGOejGp6Po2vmrHbpFYxWH3D0LMN
 l/YOiOpVCnGkXJsznbK2+7Q3j6pA0a4dQ3Xno6YKSwmZY80FCboZqlwB17PC7neIo9aj
 pVpQ==
X-Gm-Message-State: AOJu0YxawOdgYzn0MsUzBm8hhtdU8PKgWHoYIEdM/3w8Rimhuqy9zu/w
 0tfFR8KQiRVmXKCYicQei8rMtMZdXxtcWtjosdL2B1Azi95baitawUC0WAbC/uE=
X-Google-Smtp-Source: AGHT+IFsivT8Ld4TVUKUTypKkZNWFq8LRVc8pvu5l1A6GWI+GaltQW8M7lq1mItpXYTb6bKIHDx/WQ==
X-Received: by 2002:a5d:4991:0:b0:368:5bb4:169b with SMTP id
 ffacd0b85a97d-378926858b2mr5687244f8f.4.1725961813909; 
 Tue, 10 Sep 2024 02:50:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d3738sm8364030f8f.69.2024.09.10.02.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:50:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/4] ufs: add support for Qualcomm UFS Controller
Date: Tue, 10 Sep 2024 11:50:09 +0200
Message-Id: <20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFEW4GYC/x3MTQqDQAxA4atI1g1kxh+YXqV0UcfYBuzEZqwI4
 t0dXH6L93bIbMIZ7tUOxqtk0VTgbhXEzyu9GWUoBk++oeAIF50l4n/M+Iv6xahpMZ0mNmx6H6j
 tHIWuhtLPxqNs1/vxPI4TAsnFwmsAAAA=
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=O0p2fQwb+fGWrfC+NcUh8TCBVGmucPSlvb48quk+Jnc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4BZTVIFI1g05orSFYt9pPX+IV6zs5NowSIXYdbYc
 UsnYnGKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAWUwAKCRB33NvayMhJ0c8wD/
 wJxkhJoEM+won9nr27tVNhP1ED4u/tHDQeWIqPTuKCHp6tzilcWjXuve2RQGhlfCGZ8RHbN1O75WFg
 xnf5BDPDaBEdkp9UveQIoy+h8sVhJqVmSyy/eP1OwBG82hYlpux2EfbDEiHr1CKWFGNakkPeoP8+Up
 KDVq8SSLlOoOTuc00XRYoqSl/YvfXCY28d4UnrjW3XGc0PXWXSR4uMeTeX4tWSM3Z/p9HXonaUtwjp
 ODK0qnhikQAR5NAi3p0kHACWmSsWR1WiVejkB+xeu0S7JKRFcV86K4uxmsS8EnvkjOcPyRShiCxBhY
 insZJ+Cmlz0bXlKusK6IlB5cPPdILN7Y+/7Cb1sBJ+KLH8lCIneVu1xRmbTA09uLFNEID9icvM/f73
 nTfBioPrlm+odpUSHgyND+orsAabhnyUMI3mOTIgPN4Td1wwzIiOlI8yywWVTDTWK0nEk4UxBbUjLr
 6ps+Wm1OirLZnL0vzFmkHgqftxlhcoWRcOVW0U0ZbMZ+11CVRv7uywxSsLL9Q+ZiEjziJZZ09CxRmc
 6Ej7wdkPCR52ogMxnFWVsJXWu3dflGdk91vxvkXXu2bLP7+mg2OUCZOoS5zNAteLaGWpyrohZ3lTdx
 3EiT85mjjVfJjb6r3qSQkFbhT1NNn0IXaCEyPaa2kHF/SEbid593oR732FLQ==
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

This iass Add Support for the Host Controller driver for UFS HC
present on Qualcomm Snapdragon SoCs.

It adds 2 ops to allow more control on the UFS device.
        
It has been successfully tested on SDM845, SM8250, SM8550 ant SM8650 SoCs.

It builds-depends on the following serie:
https://lore.kernel.org/all/20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org/

And at runtime it depends on:
https://lore.kernel.org/all/20240910-topic-ufs-qcom-phy-v1-0-21ff4b87b962@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Bhupesh Sharma (1):
      ufs: Add Support for Qualcomm UFS HC driver

Neil Armstrong (3):
      ufs: add device_reset callback
      ufs: add get_max_pwr_mode callback
      ufs: allow UFSHCI version 4.0

 drivers/ufs/Kconfig    |   7 +
 drivers/ufs/Makefile   |   1 +
 drivers/ufs/ufs-qcom.c | 670 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs-qcom.h | 147 +++++++++++
 drivers/ufs/ufs.c      |  13 +-
 drivers/ufs/ufs.h      |  21 ++
 drivers/ufs/unipro.h   |   6 +
 7 files changed, 863 insertions(+), 2 deletions(-)
---
base-commit: 7725e4eb07c03ca0842b0a7ed425af28e1b8ed37
change-id: 20240910-topic-ufs-qcom-controller-4b2905610963

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

