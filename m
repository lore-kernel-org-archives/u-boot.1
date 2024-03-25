Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E52C54E58
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 11:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EA1A87842;
	Mon, 25 Mar 2024 12:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YDj28YPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0288587D07; Mon, 25 Mar 2024 12:47:15 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFBCA870AB
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 12:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51381021af1so6528948e87.0
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 04:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711367231; x=1711972031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RoO29KxGYL3uFdyVGcFgnGDAmzBX8/76X7l5Rkmeuws=;
 b=YDj28YPeeHY9ASSa0uwETXnR28/H61CRMJJD6JHaJ/KBWo08J4u2IpUw5XqW3Xj8Lt
 oik2S4XWXZAmtFMcJ0PFT+QW7EGfAojKZ/9L3K7J5W5a7whm807iwaOdoVwoZtCI6xQx
 ON4OD9bizqk5EMwP+dFchh8KEMuWXevhkiHib4tsmUOyDS77HOVJFVRVtZIdik9UfCAr
 UTnjMivEmeet66VMViWprNtL/300NHw7h7/VIS2hfXAK2f/A7Xgec6QMJOjH28FpsAZP
 2cmvBSN6KIyip0dnqZEpm75blsEsRHBqexUtOkmjU5NaTDjkCGeFoMrfLbdUnW/UBP5F
 MKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711367231; x=1711972031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RoO29KxGYL3uFdyVGcFgnGDAmzBX8/76X7l5Rkmeuws=;
 b=MkSqXbdrcvS2K7I3ZEn8GHol1It/elxQK0k77b3cduHNzunSqMsVYU8ZnFxEfMu/s+
 7sTCfnQXA1lyNnmW0n1mbh4X2R+FdJGWvt0KXG9dmc+CkWXY9BPBgtl6fdn6cb6w55OG
 KAKL4h6dQn9xY6ciG0hfMUXKW/NWCJUfmsvWw97gePvew+urb4tgVLHNQg2FYi791Ep7
 tfyJFUslbRE9UYZUd2ofBK1BVfoINvoQV+u7ttb9P5+3q4tOimdYKd6XX4d7EiHoejII
 iMc7TlGt8C400StA/2zEcuTjpcUWYpRKsoiWzlCkv/+86SkZGp6d3AfYUQttC3coDbQB
 casA==
X-Gm-Message-State: AOJu0YwP2LV6+QrQqtXp0Ci3UgeL89oeAR5+9i+mH6SYVq40FHB6EgGO
 NlenWjgZiHXfopYxaI+f/qBfjG/O4d0hA9e6OwPoNgUiExyTqAcWt5UiShyxxyk=
X-Google-Smtp-Source: AGHT+IFRaAVMMR8fUo5fgMchEsWIAc/oneYD3jzEmGVxESBTop+pxOHDhatYbl60SYMGI6ARV7lCuA==
X-Received: by 2002:ac2:551b:0:b0:513:bf8a:bd2e with SMTP id
 j27-20020ac2551b000000b00513bf8abd2emr5580095lfk.17.1711367230909; 
 Mon, 25 Mar 2024 04:47:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:da6e:975d:104b:c525])
 by smtp.gmail.com with ESMTPSA id
 jy10-20020a170907762a00b00a461e10094asm2988864ejc.95.2024.03.25.04.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 04:47:10 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Gaurav Jain <gaurav.jain@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Breno Matheus Lima <breno.lima@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Subject: [PATCH v1 0/3] crypto/fsl: allow accessing Job Ring from non-TrustZone
Date: Mon, 25 Mar 2024 12:46:39 +0100
Message-Id: <20240325114642.3664840-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

This series allows using Freescale CAAM Job Ring from Linux without having OP-TEE,
this is needed for example on Toradex Colibri iMX7 where we just have U-Boot + Linux kernel.

To achieve this add a new config option to allow the non-secure world to access job rings.

The functionality has been broken since U-Boot v2019.07, with commit 51f1357f3428
("Revert "drivers/crypto/fsl: assign job-rings to non-TrustZone"")

Link: https://lore.kernel.org/all/4b64a9de-a840-4065-a530-f81155b4b9f2@toradex.com/

Regards,
Emanuele Ghidoli

Emanuele Ghidoli (3):
  crypto/fsl: allow accessing Job Ring from non-TrustZone
  configs: colibri-imx7: set non-secure boot mode as default
  configs: colibri-imx7: allow accessing job-rings from non-TrustZone

 configs/colibri_imx7_defconfig      |  1 +
 configs/colibri_imx7_emmc_defconfig |  2 +-
 drivers/crypto/fsl/Kconfig          |  7 +++++++
 drivers/crypto/fsl/jr.c             | 19 +++++++++++++++++++
 drivers/crypto/fsl/jr.h             |  2 ++
 5 files changed, 30 insertions(+), 1 deletion(-)

-- 
2.34.1

