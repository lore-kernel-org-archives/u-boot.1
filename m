Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7C1C5AE59
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 05:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52BCC83440;
	Thu, 29 May 2025 07:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UeY5uLo4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF8F8334D; Thu, 29 May 2025 07:10:42 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BBB6834E1
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 07:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ad883afdf0cso85137966b.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 22:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748495439; x=1749100239;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYhMbj1+fZ01f+uZlfBq4NpnPga0rE7deIF6dDtULmU=;
 b=UeY5uLo4pZFh+vqZN6bwvbjWMKNkZSkPZHp7it5Ftquvnh/iJ7DGw/sALN/2WisTVr
 HBlR/TZSHG8+VlRuKDceb4m3M4YV5w/9nlQejLtG4qFm0RF32uqVF24b+0q7+KTuj0Df
 9Oi1CijgLAXI0ITPGvhn8yBqfSrOb5DZeoesU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748495439; x=1749100239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sYhMbj1+fZ01f+uZlfBq4NpnPga0rE7deIF6dDtULmU=;
 b=jmoTVu+JYaCtpIPtX6WVHpGW+H0yhh8XIRTObQwyqjtaQVQUi3ikRxGtvXH/lqepaS
 fC4BfdNaylEsZRk+9x6Zi/eLogqyibz7D3rKWy0ZOR83hKKGVtUPtjHaNsxAD9yzWJky
 p2jZpYSuqXX2nKPBai2qLkCiSDc9EKfpVGkW2V/IZ0B7FPqw2lYhxROBefmWFhsyRc2T
 iO4pbIurSs75yZ8xxA6Lx3fNrMMVA48pnfhu2A5xkJn0K9dm3AqowV0i4HkURm4e7iow
 loyG6yZkjIJrw/OnNu5Sc86IYCwdX7PdW7AlCgFybl+8GcBt/BKk/g/2I87KqVYWbK2i
 S+5w==
X-Gm-Message-State: AOJu0YxNmhIYtWNOAKufiOjnzFwwD3jTGLOBq5YDk75ChhbKDEXdnVBf
 iAcHKIHF+LprVG47O+UsFEYBWX4VvZUvF1/dJwsD1zWje/JsulzvUfOeb1JAr0oaUq2xxeXvjj0
 iWvG+xhrjhQ==
X-Gm-Gg: ASbGnctwGqPKaXZVZxW706XFVd8wbXZ8O2psmIfVQ1pn/9dflwbKp/MuLSM/wfzSpsK
 /pwvsb0HrI66QdgNunP38opPM6ig+s1/YeaPA84goc0Nj2QapTOPmglLjS4V4TdxxhFez3eJ4He
 ZBITOGjZAmXfwKsyqqiDOg9xMoKvKHLptj5FPj1pqGrw9ZSWKIxIhLELC/bEkg1njGnKq4agxap
 PXwz/t3gJ1oRpAWv8qh3lLEPn4yzsNC/CBTUWNry+kP5g2U1GE6yh1Y/uAmYRKKjOnm57LkkpTV
 Qz+f/WOUu226+cRYcxUDuKzw4Gwl4IKxRnWrIRHddAcrp7529jdG+rMu8rct8aPm0lhz9LJ7f9s
 Quv85Cf5ug6MDquM=
X-Google-Smtp-Source: AGHT+IGimMeqjsMcOsyCEvpcqSObaXBVWYqXd8j46bnjIXpto+1gpNVdZgPCiLdIvm8wqDXN/C2i+w==
X-Received: by 2002:a17:907:9488:b0:ad8:a935:b8f6 with SMTP id
 a640c23a62f3a-ad8a935c964mr268716166b.0.1748495438786; 
 Wed, 28 May 2025 22:10:38 -0700 (PDT)
Received: from panicking.amarulasolutions.com
 ([2001:b07:6467:4426:71fa:236b:ca2b:119e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82becbsm70776566b.39.2025.05.28.22.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 22:10:38 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com, cniedermaier@dh-electronics.com,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/4] configs/imx6ulz_smm_m2_defconfig: Enable clock
 framework
Date: Thu, 29 May 2025 07:10:18 +0200
Message-ID: <20250529051024.42340-4-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250529051024.42340-1-michael@amarulasolutions.com>
References: <20250529051024.42340-1-michael@amarulasolutions.com>
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

Enable the clock framework on the m2 platform.
This helps to increase the NAND controller performance.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

---

Changes in v3:
- None

Changes in v2:
- Ajust commit message
- drop CONFIG_DM_MTD selected already by MXS_NAND_DT

 configs/imx6ulz_smm_m2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/imx6ulz_smm_m2_defconfig b/configs/imx6ulz_smm_m2_defconfig
index 436bfb78cc2..6e425d6e52d 100644
--- a/configs/imx6ulz_smm_m2_defconfig
+++ b/configs/imx6ulz_smm_m2_defconfig
@@ -43,6 +43,8 @@ CONFIG_ENV_IS_IN_NAND=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
+CONFIG_CLK_COMPOSITE_CCF=y
+CONFIG_CLK_IMX6UL=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x82000000
 CONFIG_FASTBOOT_FLASH=y
-- 
2.43.0

base-commit: df2ed552f0b05591090369a7fe7ddc92439dea5c
