Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF7CCD1288
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 18:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31C0C87EE0;
	Sat, 30 Mar 2024 19:00:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IkgMR4E4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA1FC88294; Sat, 30 Mar 2024 19:00:06 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 137E387BE0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 19:00:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d68651e253so41527561fa.0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711821604; x=1712426404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8+nzeM8P2uoPTLQtfb5ixHThJafLv8fN6cc/10CJm0U=;
 b=IkgMR4E4SgmQ+UEc9alDQFhFGPUqx0tKi2UJf65WuQsw4q1IL5o9z9Yrmo6oII27rI
 ppYlFlvpwJZu6IWUlzRcZxqfoEgUV3A2KzBJmbkku67Uv1+AtMC5T5zMuhQloXtjoLQU
 ka/Tk32kGZaBzCJ0zoVWCxLAe024sQ0wSjwkdLYYa9fFcNIWKS40VJBwzM3fKVH6uFDP
 Vf7wvkBihjPmdFFZIZ2YSz4aI0b50CFzF5UlcMHR7O6nQ4XmkIPLNPtHter8enzvr3Oc
 C2vr2u642zwQ8UnGnDw71Lv9ww02NqvgSK3+Wkx9zbanquOFuQE/04MXvlFNebXNjVCF
 JPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711821604; x=1712426404;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8+nzeM8P2uoPTLQtfb5ixHThJafLv8fN6cc/10CJm0U=;
 b=ZfDY4SURfgo2THhK5oPaUxotHtd7ay/U+9bFCD88B/BQ4SVf1BwZM7jnzEFcw/Bix0
 brXV6InSThm5eIFSYszTCbqTJASUlXV7GYDbNmexjYmlmQC7ZfhpR/OfRb881Y/gyErj
 mV4sn6de0LGGtJP4c1ejQIKcEKGa8tILTL4i7NGz9ISU+SS1cqR7LKW4Vk3gLMUp0PuJ
 k9eVoMQ+SL7D1zg/zV+N2Szk3dWEM5R5MK18aeIjpo65fAFL/5l0PD8vLIVRZEJAu1rb
 4MbrIqOtt79fYQ6tzHz49zT7oIhpZk32fT/Q0VuFBe4CC8mT17sAHitO9ubY6JXyBHy/
 GDuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB+k5L9YPKFebJEJoLH1r/7WFoGzQujCC6OJn1xKbIOHFwZPoBCntplkYMq2B7vWzpQkY4j49xn2w63+9K4bd2OJiCJg==
X-Gm-Message-State: AOJu0Yw6FrknMdYJCFD9ZxdjfebyVtkVTFuVI4HQL7b8mvG4inesyj15
 vKNemUDpMEQfpWtlQP/v6DznduQ9kOZ90bJU1WEcRFOCTqJerzZw
X-Google-Smtp-Source: AGHT+IEDOVD02eYyjPPPgqgLNpESv7RSi1AkBQnjapJ0INrb2Bj76LDAv2EzHRHlZetaK8+Y6iYduw==
X-Received: by 2002:a2e:bb95:0:b0:2d8:f3b:d026 with SMTP id
 y21-20020a2ebb95000000b002d80f3bd026mr73081lje.14.1711821604033; 
 Sat, 30 Mar 2024 11:00:04 -0700 (PDT)
Received: from user-PC.. ([37.232.111.23]) by smtp.gmail.com with ESMTPSA id
 x2-20020a2e8382000000b002d71b89f93bsm413933ljg.27.2024.03.30.11.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Mar 2024 11:00:03 -0700 (PDT)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: 
Cc: Maksim Kiselev <bigunclemax@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Stefan Roese <sr@denx.de>, Peter Geis <pgwipeout@gmail.com>,
 u-boot@lists.denx.de
Subject: [RFC PATCH v1 0/1] Add TH1520 eMMC/SD controller support
Date: Sat, 30 Mar 2024 20:59:45 +0300
Message-Id: <20240330175948.80931-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Hi list,

I want to introduce support for DesignWare SDHCI host controller
on Alibaba TH1520 SoC. The driver based on mainline Linux and Revyos
U-boot drivers. Work with eMMC and SD was tested on a LicheePi 4A board.

I would like to point out that the TH1520's SDHCI controller is very
similar to Rockchip's IPs those already have U-boot driver -
rockchip_sdhci.c
Also on Linux, T-head and Rockchip SDHCI controllers use a common driver -
sdhci-of-dwcmshc.c

At my glance we have two options:
 - leave TH1520 in a separate driver
 - stretch this driver on rockchip_sdhc

I chose the first option for now. And would be glad to hear your thoughts.

Best regards,
Maksim

Maksim Kiselev (1):
  mmc: snps_sdhci: Add sdhci driver support for TH1520 SoC

 drivers/mmc/Kconfig      |  12 +
 drivers/mmc/Makefile     |   1 +
 drivers/mmc/snps_sdhci.c | 464 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 477 insertions(+)
 create mode 100644 drivers/mmc/snps_sdhci.c

-- 
2.40.1

