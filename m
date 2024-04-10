Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5C1CD1297
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 05:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB6908772A;
	Wed, 10 Apr 2024 07:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U9WUTZUF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE8208772A; Wed, 10 Apr 2024 07:54:52 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEFCD86EB5
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 07:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-22f01274622so2215297fac.1
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 22:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712728489; x=1713333289; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8kkb4qkupCS+NNQR4Ik16AqUtkd2DyAEszjMHDOKflE=;
 b=U9WUTZUF9dOGn09Jh9MjMGHVxMceCeeIfo5Wu5DIzqsCD8FM+B9KWZzSQyWm0GFCwd
 g8MzPks7MHAKB8vaByMEy9Xo8O6/zz/LGlfQblp1ICSF9KQuwJ7b+qYwgStHXx64Vvgt
 1cc/9LOoVj7i4WR1oajkNu7Ks22fzXYxqp7MjHrjok0jEId0QRpgLrIiCwNPiSeosND/
 JEQD+HeVQy+cw10xYawsscu/LYWTu9dWKPsAG+7OVf6n91xfDWNXUU7n97wWShYt9vfQ
 mR8UtjC0nZM8zYvMQBWKDmanbZ6jjB+W6WI0RYdyjNwhqDdPmbxRJ1ilWVSWQyqWfCPc
 X0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712728489; x=1713333289;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8kkb4qkupCS+NNQR4Ik16AqUtkd2DyAEszjMHDOKflE=;
 b=MW1LUl6RLnO7tykTZyhuQEEM0vilZoV3+dPKkBbK2YHSYex5He9bB25IwwT2LUHD3R
 lqtD6rLIDxOGo37RLjMAwRy18JigCA+geysp2vBI31Km56UvFlOk2hGo6tXNOgj60hfm
 tadrLrhsuwUzKigbuD3gflLKB2xvQmNm48uagKX0habh2VQ781c0M2sOvm6hh2IOM52e
 NmoOxiysXCeM/QWRzerNw3eUjvOHMpj8cJADZI3I0FXiwTsfHNBWIThALQtDvcQcEl3B
 A/cEp7lqhCTGaFRfV2iAeCFdR0EFsKwBnnijfiUSKUJAGfhccyxyk//X4V9xKD9RzmVr
 QMLg==
X-Gm-Message-State: AOJu0YxtoPozpM/idqkzxpjXQKyQXF2UcGi8M+RUpeuA2Wg32r7hwW+4
 CTUuZBF8GeOBqvdbADSXZYoJauewPh+1J41PTYgButGHYpWtiMdnuV+F/U+g
X-Google-Smtp-Source: AGHT+IFkW/xX8R+U3Msoq4hQxRBRrEXxe+R/2J+YGA9FusOkrEUt+9Whr4viPs4tnrkoPrsaYjAQ5g==
X-Received: by 2002:a05:6870:b4a3:b0:22e:9792:97e5 with SMTP id
 y35-20020a056870b4a300b0022e979297e5mr1865422oap.30.1712728489538; 
 Tue, 09 Apr 2024 22:54:49 -0700 (PDT)
Received: from localhost.localdomain ([180.217.145.139])
 by smtp.gmail.com with ESMTPSA id
 le8-20020a056a004fc800b006ed2709ada6sm5476131pfb.65.2024.04.09.22.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 22:54:49 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 trini@konsulko.com, jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] configs: arbel: Use generic timer and npcm reset driver
Date: Wed, 10 Apr 2024 13:54:37 +0800
Message-Id: <20240410055437.3439213-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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

Modify defconfig to use generic timer and npcm reset driver

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 configs/arbel_evb_defconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/configs/arbel_evb_defconfig b/configs/arbel_evb_defconfig
index 45fafe790c..08753aebc0 100644
--- a/configs/arbel_evb_defconfig
+++ b/configs/arbel_evb_defconfig
@@ -80,7 +80,6 @@ CONFIG_PINCONF=y
 CONFIG_PINCTRL_NPCM8XX=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_NPCM8XX=y
-CONFIG_RESET_SYSCON=y
 CONFIG_RNG_NPCM=y
 CONFIG_DM_SERIAL=y
 CONFIG_NPCM_SERIAL=y
@@ -90,8 +89,6 @@ CONFIG_NPCM_FIU_SPI=y
 CONFIG_NPCM_PSPI=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_TIMER=y
-CONFIG_NPCM_TIMER=y
 CONFIG_TPM2_FTPM_TEE=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.25.1

