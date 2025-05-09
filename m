Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C063C3ABBE
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 02:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A17DB8212F;
	Fri,  9 May 2025 04:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bm+APs3+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 491D482153; Fri,  9 May 2025 04:59:07 +0200 (CEST)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AEC98211F
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 04:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-52446b21cfdso571648e0c.1
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 19:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746759544; x=1747364344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BLktwpCabOY4+3urhgj4eAkv+QmF2V8KwuaxLqiky2w=;
 b=Bm+APs3+LpwMcW0onZBaCnStq3xRM9MXScq/GT69REQ39wOtt8GJ91gSNXBWI1vKNH
 x1W7Ky9B/6UymNFkWO5rxPpzvnci24xFShlOf6JargTAh6P8jeHwQhuQeI5bg8dDc5r1
 rzIChysIzLalyRWM/8a3qRQsu55TMBuclAxBAP9l76V2sQgb8hYST7kXy87TAw4cb1RM
 9eNZg3CSy5scnY1sDMuh3KlLZGNoO6v3qfrJ3XQh8uAepjF+IrFPhWk2WKdOzmjQKeI3
 oXGc/W8C9wKfmybxC0SmYLT6Vtu6MNsP4d6BI0yoz0kaql2wZn0hJUQN5uABvnpx4GPi
 RIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746759544; x=1747364344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BLktwpCabOY4+3urhgj4eAkv+QmF2V8KwuaxLqiky2w=;
 b=ZzA+HqCiZd51qqHzBiaBcrWcMjlDM4fZfO1ufb99R9JVHDNvP/0wOXCbsbeA97HaLH
 OlkC3a/nIxbUZ8DmEglv04H7GOSALpDd3FZmd1oyjreXC+IVdvBUIVVr3PHNA4qFYLct
 IeYL/J7K4jgWBkTf4L0NbGvgh9MHqFSdHO1ULmtip/alnor4Mafr3H4S7uHQSvfN9WoK
 Zip3LBm7XEx795l7usb4hNOaCn+65H1yEs9DCmm3jjJnTK6tght63athXyllqip77NUL
 QkwZCSYwgI53R7fQkHb8Gqar7Zv384bQ7lcNeSdaorzDxysBk46Yv18slGJdAHHbMS++
 /8oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpP5d/CbUr1y9dW1wmoquWZgqGwzKo8gayQ0SuRS6meGN9ijCJ+R1H2KS3VuId7dBcjXct/eU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2bTTy9ChR22OpmB9xa6EdMzH9m8J3IkWu80rNA1taBlMWyQQt
 vH04Vlv16UupxUvp9RihmmS3M4DNGOkOwpDyhZ5vItV+iaguCyTe
X-Gm-Gg: ASbGnctKhtIMm6ix94gcJA6WYgPmjfWgy6CJzwDw1LlXGT9hEUSdmk5+PyhLx+EWyuj
 inT3RxrfWle2+K41tcVW+dw8koeXbNANAMyHDDOwFniOyks8/folO9W3d7h2Q3UwqpXsjTzkDpU
 js7D5RnqN6zMDtfgi/MgzaDWUJHPCADZOU0Z7JT2XVG4KOI04Kjf1GXWC0sdAiy/BzpbxiZ9rZA
 uP4HV4f+yna5vSTVL7PzSSxaCx0A6TZei2cCBx15UaV3jX84badv3YbauouIRIj0dY+s+5kcRrM
 fzF9N2B9C2S+RNObz2ADDU+oGbyLTHyloOr0EbN6hCvJ0hgs//Z5008qj8IwuuioYA==
X-Google-Smtp-Source: AGHT+IHorGjpdOd3AXIgt5TWl6Kq/P3Az0ELY5/rQ6JrLqe96klbbKvzMgcanqjUAu1N6jFQPC+M7w==
X-Received: by 2002:a05:6122:1da4:b0:529:373:fcb7 with SMTP id
 71dfb90a1353d-52c53cebf52mr1529295e0c.10.1746759543963; 
 Thu, 08 May 2025 19:59:03 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:1f75:2e76:9013:ed39])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-52c5375a3f9sm494401e0c.22.2025.05.08.19.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 19:59:03 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: alice.guo@nxp.com
Cc: trini@konsulko.com, u-boot@lists.denx.de, tharvey@gateworks.com,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] imx95_evk: enable PCI early
Date: Thu,  8 May 2025 23:58:56 -0300
Message-Id: <20250509025856.2368055-1-festevam@gmail.com>
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

From: Tim Harvey <tharvey@gateworks.com>

Enable PCI early as the NETC device is an PCI ECAM device.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Resending because the original patch does not appear in patchwork or lore.

 configs/imx95_19x19_evk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx95_19x19_evk_defconfig b/configs/imx95_19x19_evk_defconfig
index fe968d5a2390..f78c416ae570 100644
--- a/configs/imx95_19x19_evk_defconfig
+++ b/configs/imx95_19x19_evk_defconfig
@@ -42,6 +42,7 @@ CONFIG_SYS_PBSIZE=2074
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_LOAD_IMX_CONTAINER=y
-- 
2.34.1

