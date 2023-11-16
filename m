Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7137C54FB9
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 13:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3873874B9;
	Thu, 16 Nov 2023 14:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="B23xvoQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26EEB874B1; Thu, 16 Nov 2023 14:17:11 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46B2E803AC
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 14:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9f26ee4a6e5so115173166b.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1700140622; x=1700745422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ss7ID90HzVFvrEtt3DxhozthxdOM8Gd+gH1LJTa6vCk=;
 b=B23xvoQQVNVPrMxNAteajwLuT8yHOucSyLBHTk901naa/7PsPUq6G4+SPxenesizgE
 wzkJmR466ZV36qCSIVULAZVdW+r45xVmVhc+65hz55K9iCvqAaf1HVCNBlAfP/Kz+I+Q
 Yk07dixg8TNo91wVQwuxhmXbyf1iLgsgmlHoJz2evABHvlRY6XwodXKPqnZxYGe8yVLI
 jchtrZWFatxcIn2J2shP7bexbaDijFiLqxlkOASs/7aYLk5RJ2UfEkNfQYsMcUR+ls2k
 PTSnXcBD8S0nzN+LT7srvSRbtkwzet6x5e7m604fh/C87NgLr3CSZz5vBUXfQeqLg0no
 4fIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700140622; x=1700745422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ss7ID90HzVFvrEtt3DxhozthxdOM8Gd+gH1LJTa6vCk=;
 b=n0dm7McgfayeaBr4uHTzRBNYuQ025f9kaKbW+iwFxJQi8tA/5cIuML+7r8FrYjJj3m
 TwkV3wi+5SaEqKp9wvLLkGyEf7DZ9gGfHMSSzKjVs+8sZd0/lr+zI7LlWvlNgM20fhSY
 R8S6C39689d0wCoPn2/kEMzY+1ZgYLqPBj7UdgcrNb+vspGUnDjh/Rv3blWy2uSUrOcS
 97VG9NwzOl+3WlrxcELUisPv8Nzv5pg1z8A/TlbgkjeWtsNX80UN/YSu4JhlZBxVafNG
 zWMiLGOwveu7YR4fOdaGPDusjhN6JG+Pug3M4J/78oY8gcEKqlG4+736TumNItzuBZ/E
 bQqQ==
X-Gm-Message-State: AOJu0YxKZ9kI31ewBGECDJ5O42AnZuFKvR7cFcIHE4vna23Qs9MyVFvZ
 Mb2xZf/ZGQ72RMZCRiD3CQtmYA==
X-Google-Smtp-Source: AGHT+IFdfKj9n/m9cNp8IxRCp6nVbXdalpXCfoVU2cRHVjog+QQLh/EJyggyjRQ3BymFYUdMYQpO5w==
X-Received: by 2002:a17:907:7da1:b0:9d5:9ff5:c2 with SMTP id
 oz33-20020a1709077da100b009d59ff500c2mr14593914ejc.24.1700140621324; 
 Thu, 16 Nov 2023 05:17:01 -0800 (PST)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 h17-20020a1709063b5100b009e6e82939f9sm8347885ejf.26.2023.11.16.05.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 05:17:00 -0800 (PST)
From: Artur Rojek <artur@conclusive.pl>
To: Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH 0/2] Conclusive WHLE-LS1046A support
Date: Thu, 16 Nov 2023 14:16:28 +0100
Message-ID: <20231116131630.407502-1-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.1
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

Hi all,

this series adds support for Conclusive WHLE-LS1046A, a QorIQ LS1046A
SoC based Single Board Computer by Conclusive Engineering.

Patch [1/2] adds support for storing U-Boot environment on an ext4
partition of MMC. This is required for whle_ls1046a_emmc_defconfig.

Patch [2/2] introduces support for Conclusive WHLE-LS1046A, including
board init and Device Tree files. This board offers two boot methods,
over QSPI and eMMC, with their respective defconfigs being provided.

Artur Rojek (1):
  board: Add support for Conclusive WHLE-LS1046A

Jakub Klama (1):
  armv8: layerscape: Enable ext4 environment storage

 arch/arm/Kconfig                             |  19 ++
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c      |   5 +
 arch/arm/dts/Makefile                        |   1 +
 arch/arm/dts/fsl-ls1046a-whle.dts            | 208 ++++++++++++++++++
 board/conclusive/whle-ls1046a/Kconfig        |  15 ++
 board/conclusive/whle-ls1046a/MAINTAINERS    |   9 +
 board/conclusive/whle-ls1046a/Makefile       |   7 +
 board/conclusive/whle-ls1046a/ddr.c          |  21 ++
 board/conclusive/whle-ls1046a/eth.c          |  64 ++++++
 board/conclusive/whle-ls1046a/whle-ls1046a.c | 218 +++++++++++++++++++
 configs/whle_ls1046a_emmc_defconfig          |  82 +++++++
 configs/whle_ls1046a_qspi_defconfig          |  83 +++++++
 include/configs/whle_ls1046a.h               |  90 ++++++++
 13 files changed, 822 insertions(+)
 create mode 100644 arch/arm/dts/fsl-ls1046a-whle.dts
 create mode 100644 board/conclusive/whle-ls1046a/Kconfig
 create mode 100644 board/conclusive/whle-ls1046a/MAINTAINERS
 create mode 100644 board/conclusive/whle-ls1046a/Makefile
 create mode 100644 board/conclusive/whle-ls1046a/ddr.c
 create mode 100644 board/conclusive/whle-ls1046a/eth.c
 create mode 100644 board/conclusive/whle-ls1046a/whle-ls1046a.c
 create mode 100644 configs/whle_ls1046a_emmc_defconfig
 create mode 100644 configs/whle_ls1046a_qspi_defconfig
 create mode 100644 include/configs/whle_ls1046a.h

-- 
2.42.1

