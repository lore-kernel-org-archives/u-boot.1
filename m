Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526B9C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 23:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1C4887ABA;
	Thu, 26 Oct 2023 01:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jIk0VJjq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5561C87AE7; Thu, 26 Oct 2023 01:05:08 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CC3B87ABA
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 01:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7789aed0e46so21868885a.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 16:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698275102; x=1698879902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ImYBP4/Ayel812g8M37RPAtrPL1Zd/m74kcJ1dewS+M=;
 b=jIk0VJjqZDxriqKS185yIdJ3V1jwti+iyHXSTAK0ZNZYz7nrDPc1QJJinGTDsolpG7
 NXU2HY1rrgVfPgeNC8JpQD/3U4ErOqJ/FAwwb+dvFDkUrWE8jukqfpwZPBf9eEd9pzZ8
 6APoY7EcTUDwerWNGb9U1U7Jee1F7hVwbodWi8AwIIXKOQp9DyFDg8yLyNKEYkrqHZUm
 Oa5KIwi38cKIHHxSugJLfKuyOB9JvgY/Ufo89UloGKrxPHgCH+j6IxG25Wo+d4+A7rae
 F51atYaTtShuBn+I4jIRcxfsb2lnTb6RjXeJg4atxyHhtn8iEXZRkFYv4f4XzqpxG2pv
 ++yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698275102; x=1698879902;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ImYBP4/Ayel812g8M37RPAtrPL1Zd/m74kcJ1dewS+M=;
 b=JVH519PemiEKISUsYwqGCGIK7VKcEk6ynmpraZfxd8zsOn0aRRn06qvFOItcgZQx+a
 K/oOQDrmuei7O1JCaTLX4PQC9KEv+oFSJwOyFW2t8W6kv8kHeKJumudBBS+mBtOnuf1f
 0FHA0dWE7pDGLh5Iv1ez0tHDKvBN5lk22XE2R1hfGsRWj9MzugAdweUfiYDy4pmLQCIZ
 mVHkGZU/Y+xx0FXcqJQ9Uw5GanlJU/jubeMv9QG7fUf4muIW3yGuv4FqRX+3KvLNarDF
 GdPdATjUabyCD6szHkLgO03ulY1MJVQMrJiNbhEWkbC1Jkektqb4j+/cWf0OfAJafFUW
 LTkQ==
X-Gm-Message-State: AOJu0Yz9gNs38UEhi7fltf4f0ZIqvTUkMb2HTOKwbrwjddzYzwK1aRdk
 J5fIjXGxZ2/Bt2rel8njCZHXgG/DcdA=
X-Google-Smtp-Source: AGHT+IEnmKgqEHMVUb2RbfI7Hqd9RZC2KtlAVA30uZ9VnWAWMpwVzSafSICySATfTPqFNCXvntXJpg==
X-Received: by 2002:a05:620a:4155:b0:76e:f3a3:4ac6 with SMTP id
 k21-20020a05620a415500b0076ef3a34ac6mr19339141qko.35.1698275101981; 
 Wed, 25 Oct 2023 16:05:01 -0700 (PDT)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:449a:a220:d0aa:3d6a])
 by smtp.gmail.com with ESMTPSA id
 a24-20020a05620a103800b00767da10efb6sm4559567qkk.97.2023.10.25.16.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:05:01 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: sbabic@denx.de, aford@beaconembedded.com, Adam Ford <aford173@gmail.com>
Subject: [PATCH 1/5] configs: imx8mp_beacon: Do not set SYS_CONSOLE_IS_IN_ENV
Date: Wed, 25 Oct 2023 18:04:52 -0500
Message-Id: <20231025230456.7924-1-aford173@gmail.com>
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

The hardware only supports a specific console port, so  remove the
option to change the console location in the environment.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 configs/imx8mp_beacon_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index b686af8d18..c758ff371d 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -42,6 +42,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else booti ${loadaddr} - ${fdt_addr}; fi"
 CONFIG_DEFAULT_FDT_FILE="imx8mp-beacon-kit.dtb"
+# CONFIG_SYS_CONSOLE_IS_IN_ENV is not set
 # CONFIG_SYS_DEVICE_NULLDEV is not set
 CONFIG_SPL_MAX_SIZE=0x26000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-- 
2.40.1

