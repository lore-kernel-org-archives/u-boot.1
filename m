Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EDCC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 18:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B0278779C;
	Mon, 11 Dec 2023 19:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gqXqWDA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 432EF87799; Mon, 11 Dec 2023 19:41:53 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F00CE876E9
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 19:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c3984f0cdso31468915e9.1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702320110; x=1702924910; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bOYZBagc/dRnDfKBL4LicV70lSPsyQCZw1VjpGDlq6M=;
 b=gqXqWDA1smuCqvDxqq1jadizOYEdIrCoUz5YtxKmhM1+iLPk0qh7yuvXLTvek0ZzjD
 3cjcNOW1FCen41K1yoCOkHYmE74aXowRYkKHqKLIXm18J2E37GmeVq7O6y8LM1incB3V
 vRZH8CPU3HPX04j8Di6ZEPy8w6++yxBDkEdQe4EHO+wLuKpBBxxLiI3oRGgLQgVjtqT5
 J2hHe//MQOcqJTfE9YtQnHUcXEPhEY1L5l5BfwKcm1+wKr0eCZP+njy5IfH2YM0hYono
 T8Xul5yCbLe1Zqn/ZirtKNxPj7EJBoXkeDeVGsthF0O8tlC46hmYfylvORbAIWiLgMtJ
 88Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702320110; x=1702924910;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bOYZBagc/dRnDfKBL4LicV70lSPsyQCZw1VjpGDlq6M=;
 b=fC61NkDiWBuT2b14twRSRB1CwMR6sIwGAHyn8TJcq7F3wHubxpyxpwxb6gEjBiv3jp
 kbeC7piNasfge36wWrHKHEbrXTYZh7qJtzZS8bFppzp4eNbNNJarO9cZXKhfxozjVXuT
 IjwtlAjxv3vdO7aFgGRLzEO0Zdn/uLU6bMMOqQwMWiot0MikI+pGEbs/uyjb9DzoHG85
 OyrYQO8AJswPAi2RKQbXGPjb4mHfFbCz6wQZBxlZB6BJA4sYzddolJmkBkS4SabBCymk
 0Fnt8e1yPL1TcltHyY+Vk8MtneUz2xdHtkdH9szIrop1lpJOEzwDBx/O5hmqhTsXe1uu
 Kvxw==
X-Gm-Message-State: AOJu0YypvvOTgqsgCaF4ybVOMAruB2CYxQh2EbaBBo+Y0wlL9L/XvsAx
 6nEc3tHqn0pdbbYodxmpNNRc4g==
X-Google-Smtp-Source: AGHT+IELpCXnDUezjwQ8XekXa28h9AIvnI+KC7HkqgECaqLxrdFGQf1s0XEIDlaBwbmzMFl/R3E+sw==
X-Received: by 2002:a05:600c:4750:b0:40c:3db8:18b0 with SMTP id
 w16-20020a05600c475000b0040c3db818b0mr2489449wmo.172.1702320110273; 
 Mon, 11 Dec 2023 10:41:50 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a05600c4e0100b00405959469afsm13910422wmq.3.2023.12.11.10.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 10:41:49 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/3] Qualcomm quirky SMMU support
Date: Mon, 11 Dec 2023 18:41:39 +0000
Message-Id: <20231211-b4-dwc3-qcom-v1-0-46275113b4f2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAONXd2UC/x3MMQ6AIAxA0auYzjaBwqJXMQ4KVTuIComaEO4uc
 XzD/xkSR+EEfZMh8i1JjlCh2wbcNoWVUXw1kCKjSWucLfrHGbzcsaO11CmayRjloSZn5EXefze
 MpXwGLQxPXgAAAA==
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=hV4KSuR54vcLIDKo1tgzcUPwZq5DW9DgihTQrPl0h5k=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTy8LclJ+4fN2lW2nnKqa/+m2C40SFTPZNNRvf4VNc9i
 LIP8YjqKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABM5tJaRYYW8vZLjN7ZT9c23
 p5xLzJjQ0PYvwfCpAfuvsFTOuJwrfgz/HYzP602fVN/E4qccdrvpra5Afl/NjMp9zQUhG67Kr1a
 fCwA=
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

Qualcomm platforms are heavily locked down, in many cases offering no
way for users to gain EL2 or EL3 code execution and including many
additional security features. Among these are modifications made to
the SMMU behaviour (done by having the hypervisor intercept register
accesses). On many platforms it is not possible to disable the SMMU,
and not possible to configure streams in BYPASS.

To enable support for peripherals like USB which depend on DMA, we must
allocate a context bank on the SMMU and configure an IDENTITY mapping.

This patch series fixes support for building IOMMU without CONFIG_PCI.

Then, it introduces first introduces support for a .connect() op in
IOMMU drivers, this is called before the peripheral drivers .probe()
function and allows for IOMMU devices to perform one-time setup.

Lastly, introduce a new driver which supports the SMMU as found on
Qualcomm platforms, when a DMA capable peripherals is probed, this
driver will first see if the previous stage bootloader configured a
context bank for the given stream ID already, and if not then it
allocates and configures one so that DMA accesses will work.

There are no in-tree users for this driver yet, however it is required
for upcoming USB support on SDM845 and future Qualcomm platforms.

---
Caleb Connolly (3):
      iommu: fix compilation when CONFIG_PCI disabled
      iommu: add a connect op
      iommu: add qcom-hyp-smmu

 drivers/iommu/Kconfig         |  16 ++
 drivers/iommu/Makefile        |   1 +
 drivers/iommu/iommu-uclass.c  |  16 +-
 drivers/iommu/qcom-hyp-smmu.c | 396 ++++++++++++++++++++++++++++++++++++++++++
 include/iommu.h               |   9 +
 5 files changed, 436 insertions(+), 2 deletions(-)
---
base-commit: 8806443ed784dad5b5daf351b0175acb3343e729

// Caleb (they/them)

