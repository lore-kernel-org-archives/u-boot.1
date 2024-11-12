Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D571DD32D84
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 10:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DE25893B3;
	Tue, 12 Nov 2024 11:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="deU/xSgT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9660B893AD; Tue, 12 Nov 2024 11:24:25 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9591E88E3F
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 11:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EE74040C4C
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 10:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731407062;
 bh=Xc4J1v1u7nhW8tXys/mzRcQkpVuzpotkRcAgO9OVUEw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=deU/xSgTYccT19pRENNBtvBaXU7GwavaEZOKR1UbR23+No3Tj/oOKOGudKXglMSxH
 uVHbKQIq9dGgaLMRRbI3NrcxXJ0NFE7Kl1edgF/bbheaKMV+gkbXcgSeSVt25ENeMK
 tMbgSPjLhcsGJQIt4/nf13sC+BH2aAF7hVE7oYeKJeBBenWFhyt+KxNIfVpgppZP0I
 l/pdSDqGhBqMQrnhvXzXh/HCvCsh4u1bK0i4UmXIUnyfVbwlCGDgc5pnImj3jf9hAd
 vPF/rNmgG7DoJxT8HIElmogxHlX4DZBzhnBBZvQHORJVBx2WkFk3DnKNKeGr5UJODa
 V3kET663euTVw==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d662dd3c8so3339257f8f.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 02:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731407062; x=1732011862;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xc4J1v1u7nhW8tXys/mzRcQkpVuzpotkRcAgO9OVUEw=;
 b=BU7wUvGejFbMsJer3uaIlrfBogCoZXUV2HsU4LR2tuVzTisX1Iykn2lrh66tM7td9A
 bcjP66P0WizGErLM50qGQlsWWZg0M11IYaKb/bfTEaRGQLmpC5UDaby+B+E3l8P/uIjg
 YSgkCNYHznu/5BOIFwYNvjNEvQDg6wgHCMpUCSfZgX7SLOQAcOXidUvejRW+gISUOlOJ
 gRrY+SuNgDGTpE5l+AKaNi5oAe/lI4cgQSDigH5asWoqLhzqZ0JfMOPfbyMXS1R0bg5M
 exya3vqUqOpx/mu5EweGToY5qVTCI9MIjFUBuMjzIowByoAiae1gxrlAd3S88crGAZ0d
 ea0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAIbVzkpCYDeVGo3M2g/1qquEUSQM3fITTsRKm0Pd15K94rQmjPzWz3GNS1aUM/m3bnwa5ZJc=@lists.denx.de
X-Gm-Message-State: AOJu0YxBJ5EzKj4nvceoPTwZFs7aXCi0M960KLeFo+LrZV3EotV2a7eX
 eQpc9JA/v3AEMqjlZj448xE4921o3kQl31GxicJRb7bkpIgl3n82Y4i65x/x3VC+ch+0XJ/ylwN
 iEYNCNXB9x8ViX6Tbn/mCiNPP+ckETUeZDtLlXsvYKD4cTS/mB81Q5qv3YBKI3NU97+k=
X-Received: by 2002:a05:6000:691:b0:37d:36f2:e2cb with SMTP id
 ffacd0b85a97d-382080817d9mr1764628f8f.0.1731407062171; 
 Tue, 12 Nov 2024 02:24:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHRTHjlIiaGe+GA+dNDGYVN3HB/YWwSW9GUsts4S/+rQf9x/Huz+KSWMjDB1dYGwzS0G1FVA==
X-Received: by 2002:a05:6000:691:b0:37d:36f2:e2cb with SMTP id
 ffacd0b85a97d-382080817d9mr1764606f8f.0.1731407061746; 
 Tue, 12 Nov 2024 02:24:21 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97e206sm14860732f8f.25.2024.11.12.02.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 02:24:21 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>
Cc: Yong-Xuan Wang <yongxuan.wang@sifive.com>, u-boot@lists.denx.de,
 Yuri Zaporozhets <yuriz@vodafonemail.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] configs: add 'nvme scan' to preboot
Date: Tue, 12 Nov 2024 11:24:15 +0100
Message-ID: <20241112102415.37335-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Without 'nvme scan' the ESP on the NVMe drive is not found early.
EFI variables cannot be persisted.

    Hit any key to stop autoboot:  0
    Cannot persist EFI variables without system partition
    ** Booting bootflow '<NULL>' with efi_mgr
    Loading Boot0000 'mmc 0' failed
    EFI boot manager: Cannot load any image
    Boot failed (err=-14)
    scanning bus for devices...
    ** Booting bootflow 'nvme#1.blk#1.bootdev.part_1' with efi
    Booting /\EFI\BOOT\BOOTRISCV64.EFI
    error: no suitable video mode found.
    GNU GRUB  version 2.12

With 'nmve scan' booting works as expected.

    Hit any key to stop autoboot:  0
    ** Booting bootflow '<NULL>' with efi_mgr
    Loading Boot0000 'mmc 0' failed
    Loading Boot0001 'nvme 0' failed
    Booting: nvme 1
    error: no suitable video mode found.
    GNU GRUB  version 2.12

Reported by Yuri Zaporozhets <yuriz@vodafonemail.de>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/sifive_unmatched_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/sifive_unmatched_defconfig b/configs/sifive_unmatched_defconfig
index 058e5fab683..1ea744ffa80 100644
--- a/configs/sifive_unmatched_defconfig
+++ b/configs/sifive_unmatched_defconfig
@@ -27,7 +27,7 @@ CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x84000000
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="setenv fdt_addr ${fdtcontroladdr};fdt addr ${fdtcontroladdr};"
+CONFIG_PREBOOT="setenv fdt_addr ${fdtcontroladdr};fdt addr ${fdtcontroladdr};nvme scan"
 CONFIG_DEFAULT_FDT_FILE="sifive/hifive-unmatched-a00.dtb"
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
-- 
2.45.2

