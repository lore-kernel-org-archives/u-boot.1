Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B15C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 15:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 176EF84A76;
	Mon, 29 Jun 2026 17:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="vembXmY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48541849FB; Mon, 29 Jun 2026 17:52:32 +0200 (CEST)
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com
 [IPv6:2607:f8b0:4864:20::122e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F40384A77
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 17:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-139b914bab6so4742726c88.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782748348; x=1783353148;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N7rM7tY29BFoexOmI9GVSzh2fJvGAgr2Cg8lLp5a/Jk=;
 b=vembXmY6EcObzH1auJPM3ppkmoYxQpGMP4Thn1oyRJNbGnZg2SuyStdy+wZmVMPmMQ
 OtrIVjdMBWEFne5csnzxQ2LHAZraAtIi+tbGN8rlhIdezZfdJrLebiXad4d1Ca6YXkmA
 bRUXErM/ZXCE8ii0p/mSF01pZ/5ULKECi9URt9WdCZGhSGiEd3zJPEJoVonb1Z1TqMyr
 DK4P7rOeDGnMzgGWj+4RR2IK/pyJCpsu9obAW8NV+1zZfgEBDo51+yGSmC6Wx39MH2A2
 NpNKisoMUlRgQrHBnPo4dI1TWm1gbxXqGYmz4/KAEcuxMr0ESyPcU20L5Dypw4zm6Q67
 lcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782748348; x=1783353148;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=N7rM7tY29BFoexOmI9GVSzh2fJvGAgr2Cg8lLp5a/Jk=;
 b=H0jEXzmhfGdCXitq+Ff6AUF86YKSBohSB6khXT3pxtVAX+L4iVCyuWVJ05sP19EfKZ
 agB/b28eyI1eibekZ9ORbEv9OtoKHqwB0aiy8T0augmlcrdVg+O57csH2UL8zsSXntuC
 kGUc9Ajb2ZFhW8ozP7QGprV+2EV53fK3bIXIakDv4BX9fCA5ailNee3d8xx7YwscAKAW
 EwcYe3AiMcSjWwjVMkcZnechxnQX7j3BilStFhFrgrdW+mISysVKEtPK3hziFqisrtt5
 gp4Sn98l13DUNfVgFibQ1IFniLpFx82TIP5wKBHnHcaPxrz434/zZno+9keoJJqTx2Tj
 t/Zw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Z9KmENA4QVLNEZpFOBBVnNyU927CyMrwD0/LlQqCPPac/VIFCZuGHKFZOMW86IjrojN/+DoY=@lists.denx.de
X-Gm-Message-State: AOJu0YyR6Y3Qoqr9Gm22kN/MFCbmm8Zsiozyr9/Skz1UvQsPcevD7+wh
 F0kdbj/Hxmhy+QOaRoaNueroRv2SDTwbvRS3qgWAlTOrrJzplKgs8IyFcRRos9YI9ts=
X-Gm-Gg: AfdE7clic2y8gl4WseQsee/Dd/iLB1pJnF4GbS3fbnRtJ4q7aRcxDDPakgDKYsscTCl
 CxvH0/cHRxs7TYrZarfQvYJqYBLPgBWLY6ibODVpFUNhtX0T2dkk4YjAAefyE9GStf0WXFKqLqT
 lx8PrMzaY/Wa/4djyifmbpgP21XJxi139xYt8VcUpAiz7U50EQvTuIypfqTn3HV9vaACMtiRus3
 CWd1ckDtqnh+4VXkAUl3QxgFmqiLTj6zSM0eZzR9DtYveqjGgbU/abTzpMPKrS9TXn0YT8MAr+b
 oJAYHD71Gu+FNmvY41GuQLkLMelMitdHsG70MSd8COCqZRQFP5G6r9wuZVN7F34gk2+9pUmgcVH
 AH3+NVgaTR/WziGIoKCZgq/l9UQvHMcIOYAuSU1rutvR59nKzUUyGMYEGPCsFayjO3MYp1GI6Rj
 gtxNPhauz/13WORyx8zkAMi+tNdApTHKFSgDFH5BTrLvc1Ek4vHH9+FvkieKWeskDb5vkLnXUSg
 6ZOhgry/aPLka+lX3r0wuJd/vLj/SfoedpARop0v+Ey+NLxyE3v/g==
X-Received: by 2002:a05:7022:fe04:b0:132:f16:a574 with SMTP id
 a92af1059eb24-13b2a140aa1mr22362c88.7.1782748347963; 
 Mon, 29 Jun 2026 08:52:27 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6d2e4sm46510090c88.7.2026.06.29.08.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 08:52:27 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 29 Jun 2026 23:51:21 +0800
Subject: [PATCH v2 v2 7/8] config: k1: enable ENV support for eMMC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-m4-v2-7-cbc91c6b83d8@riscstar.com>
References: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
In-Reply-To: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Enable environment variable support on the eMMC storage device for
both SPL and U-Boot stages.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 configs/spacemit_k1_defconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 886679367a9..1c92c4082a7 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -14,7 +14,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x400
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_ADDR=0xc00000
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x100000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x400000
 CONFIG_SYS_BOOTM_LEN=0xa000000
 CONFIG_SYS_LOAD_ADDR=0x200000
 CONFIG_SPL_SIZE_LIMIT=0x31000
@@ -48,6 +48,10 @@ CONFIG_CMD_TLV_EEPROM=y
 CONFIG_SPL_CMD_TLV_EEPROM=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x60000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
@@ -111,5 +115,6 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SPL_SPI_FLASH_TINY=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y

-- 
2.51.0

