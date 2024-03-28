Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF5FC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4093D88153;
	Thu, 28 Mar 2024 11:18:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YoPVx/CS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DC4C88146; Thu, 28 Mar 2024 11:18:34 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D2B78813C
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d28051376eso12428951fa.0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 03:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711621111; x=1712225911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Srk879vJB1l262COEZKMsPmOCyeprl52cjgjscZ8IzM=;
 b=YoPVx/CSZToebUcua4uGW9MXRAjTpeI7MjBHma/FiRoorswwaC+kUyEM3jNUpn1j2a
 6e+XMSDFHZN9ADBTLAZJ56k1RQgyJjkFH0tDWxsIsh5APk90PwMYtW/qaO4gopqg8gx4
 O8qrU2nvgQvBMkiORGYRicW99rjtpZiBX/9jY999JgG6/0mOt29SzpbwL7Z/VXHvb1jN
 KRj+6UuLeeCFvixUEYL08aCvdt+CusoDuXeK4vY7v/tBQ5Fw4q8mjoY5wPd8pm2gT3cE
 wC9+TJiuBVX0lwv0HF7fN+Q4n4Rm5j10OSk5w0FRTmxAvjvfxPuL8ZZdW52CqPnnmqqo
 Bs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711621111; x=1712225911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Srk879vJB1l262COEZKMsPmOCyeprl52cjgjscZ8IzM=;
 b=m6YJP/VloQ9GEsBwnbSgpIBMzZq0BtJguTgZJijDW5ccQ4eq4ePMqpWx2x1BvlJ3Nn
 cAiUkmYypumKzttOBdU7/Q/yf1yUvxo2BG4JLub+ZWFoK4jkVFZqD0BUqU8z00KfYswf
 LfvR1prwR5ttwq0qnNP1D9M034xDNRsn6dm++a0Mk/jcVtc+0iJE0Mgdxi4Yge9e7RuP
 B4ju7wryoGcGC4e4ZeUkOg4rSCJgkVjyMgJCpKjywMjv99jjPn9xWMGOak4mAK71S97s
 scq+dayUhusMvyeRhHcw91yW3WjF1MnZi+I2/pV311tjSbJ5JkJkLqbA0fMk8yvvotvy
 SbOw==
X-Gm-Message-State: AOJu0YyGkzh2J4gnncwRE0vf5kPuA/KPeoYSq0tkun+TZbt8fDXwOH0W
 D5CJNs/MGWmK2xXeX5QrPV2Aspiau2qfCCEGK9EATI6gzGFLx8VPJUBVnfRVkLE=
X-Google-Smtp-Source: AGHT+IGjCraEbic6XdDgbdia3OgeFwWAt/QezQpgX3bmVou7ZyO1ZqBVH09QfT1n+bvq12C/vN3yXw==
X-Received: by 2002:a19:ca5c:0:b0:513:cfaa:e618 with SMTP id
 h28-20020a19ca5c000000b00513cfaae618mr1848863lfj.0.1711621110379; 
 Thu, 28 Mar 2024 03:18:30 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:baf6:ec90:82d5:a261])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a170906240b00b00a46be5169f1sm573504eja.181.2024.03.28.03.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 03:18:29 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Gaurav Jain <gaurav.jain@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Breno Matheus Lima <breno.lima@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Subject: [PATCH v2 0/3] crypto/fsl: allow accessing Job Ring from non-TrustZone
Date: Thu, 28 Mar 2024 11:17:21 +0100
Message-Id: <20240328101724.127371-1-ghidoliemanuele@gmail.com>
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

---
v2:
 * Kconfig: spelt "CAAM" instead of caam
 * Kconfig: removed "default=n"
v1: https://lore.kernel.org/all/20240325114642.3664840-1-ghidoliemanuele@gmail.com/

Emanuele Ghidoli (3):
  crypto/fsl: allow accessing Job Ring from non-TrustZone
  configs: colibri-imx7: set non-secure boot mode as default
  configs: colibri-imx7: allow accessing job-rings from non-TrustZone

 configs/colibri_imx7_defconfig      |  1 +
 configs/colibri_imx7_emmc_defconfig |  2 +-
 drivers/crypto/fsl/Kconfig          |  6 ++++++
 drivers/crypto/fsl/jr.c             | 19 +++++++++++++++++++
 drivers/crypto/fsl/jr.h             |  2 ++
 5 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.34.1

