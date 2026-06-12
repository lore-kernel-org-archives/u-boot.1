Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C6CCD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32CAA84895;
	Fri, 12 Jun 2026 14:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WeTt4mlJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2061B846B0; Fri, 12 Jun 2026 10:59:23 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29A248005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 10:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fra.schnyder@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45eee266c6cso618260f8f.1
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 01:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781254760; x=1781859560; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BsAMTDdEKHOwED0j84bE8GZktV5JdZv3bgUFf1beabU=;
 b=WeTt4mlJ++hcy579LzO45KoAEN3Sppn+omztILMpQ4+xOzIPVXJRb5qkSFEpoQYcmq
 eGzl9FKiPM0sV2kiXTUsjQqHPPMfYDfeD03j1fgqeDHXdSLvs42z2vOqIG/AdjQzB+mQ
 sUTMOkKfAGG499dNEh3/YwwzTFPCPGhgU/dNbWNAVAQpjlCHMbKDI12cwSRd1BrBlM06
 ezA7Wwm87YSHlECz2HyrcAjEU0IPxbmib0quIC1zIdeWQmMpspXoh9iLT8IywE9HeXY8
 WUIkNyXYojKEtTfSF3734iThdHQ1YOs78wrEwbNcUMZFa4wtgNFaiWJlDX3ZljRVR4mu
 G88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781254760; x=1781859560;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BsAMTDdEKHOwED0j84bE8GZktV5JdZv3bgUFf1beabU=;
 b=ENm4bSxzygnNpFbmqfQdcPhyH71h/ZoGf+yn7tS6gEf+VdI2++7wSu9GmiwI9e7xnH
 z9s4PhfQEsbFFyPFJSUhJmwOHH+NJHxfsUUdtMABCHBJ9RrhO/DAmqCqvv4uqpr6Eqf2
 k0hdvqy1pONl0S/FMuWEhnK9EUQvzsEFNx6XCJQPzNLqOp6s+y455NbsB+33gGcjFyer
 SDKXyQxxZ+pJdypCcOjHXN0+1bH9Vnqj69ps/p9HrgpjkOvtiyF3ru0wEgizujHxYC2l
 0gmqPHvGmSAYn0CjhB4X8nyPL2dknc40IufFTmm+c39s+1v8gVALzkXEAM1bp5F1IOqU
 09Zg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qaNGX50pNtFzkGPqlqEGB8mJvjEb6MEuuutlbcMKUZ4bNPibHCHauhhNnWvarnlJ9BrecRSM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx35XLze06OEUgxz43pCSrWwM24FVY1Sau6JCHKsS3sMDdAI7Nd
 0+iv/XIbt4NTr8fltLSkyvY/Wzvr8Mrv7haI0/koTPxUwQDtNlzom71j
X-Gm-Gg: Acq92OGBm5qlV9jP4pMxbQ/N3tZqPD7DAcZp29pEMcRpmkzNhaFLKahb6/Js5dGTYa5
 djEQuapuN0E0tTQccLrnUB5gpG0Mx7HuKlvmPfLAKjDcIUmg8yUS1WXHgYwG05edjHtvQ3IIo0d
 A5v9/zpN+NKKYhw902jSVH4rRqxQmc9XKrjoT1Lz0cBLTPeRnKRUFJBqLkBKOnhEhYOmagNJxqS
 AlgH6Gn0S0x2eXmoETnjD3SSWFCJb363UoyPGLJdRDSmk/fGTEXbTpJJGvEEUu7bB5ufmxbKrhf
 JRZKWpcSkkufefavCfBc6mcfTvLzLSiJWkxplvaJQb3jyLExVC7alE0fL7/JYlIGRSL76XIyeVA
 znmK/nkf76v4vBEyFX6OQIkbgDECkhiJrjfbWR3Qw0faDW2ZfLAzvK0SCwUxDgcEBhFNmEm+qNp
 sHtQj060l/Lsd+0PaNcXyPZ6+VebdSXjb574scXIXpsUZHfIzTp2Jq9ua36IN10FuIxRQVmAa82
 dt+Mgkuq0tSLxJ9XGXiO95TJF15qzVaLbLcCXbKS9bMVWBPIFzXBGchg7ivIZu+7OhtmlJ9eLf3
 J9yEe8t3baar
X-Received: by 2002:a5d:59aa:0:b0:43d:dd:8ca4 with SMTP id
 ffacd0b85a97d-4606da6965emr3043079f8f.14.1781254760317; 
 Fri, 12 Jun 2026 01:59:20 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f1cdsm3976896f8f.11.2026.06.12.01.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 01:59:20 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Subject: [PATCH 0/2] configs: imx95: enable PCI_INIT_R for Toradex modules
Date: Fri, 12 Jun 2026 10:58:59 +0200
Message-Id: <20260612-fix-smarc-verdin-imx95-eth-v1-0-851197b36dcc@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFPKK2oC/yXMQQrCQAxG4auUrA10BkzRq4iLOvPXRugoSS2F0
 rs76vKDx9vIYQqnc7ORYVHXZ6kIh4bS2Jc7WHM1xTZKKyHwoCv71FviBZa1sE7r6ciYR+4k5Jg
 6yTKA6uBlqPVvfrn+7e/bA2n+HmnfP6PPxGV+AAAA
X-Change-ID: 20260611-fix-smarc-verdin-imx95-eth-761d2c76d6fe
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 12 Jun 2026 14:35:35 +0200
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

Currently, on the Toradex SMARC iMX95 and the Verdin iMX95 the ENETC 
device is not enumerated before network initialization because 
pci_init() is not called. As a result, no Ethernet device is registered.

Enable CONFIG_PCI_INIT_R so the PCI buses are enumerated early enough
for the Ethernet Controller to be detected and used.

Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
Franz Schnyder (2):
      configs: toradex-smarc-imx95: enable PCI_INIT_R
      configs: verdin-imx95: enable PCI_INIT_R

 configs/toradex-smarc-imx95_defconfig | 1 +
 configs/verdin-imx95_defconfig        | 1 +
 2 files changed, 2 insertions(+)
---
base-commit: a566d32693600bbbe405ca5a7f4ab07f71f45e86
change-id: 20260611-fix-smarc-verdin-imx95-eth-761d2c76d6fe

Best regards,
--  
Franz Schnyder <franz.schnyder@toradex.com>

