Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1024FCAC592
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 21:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C18B82C84;
	Mon, 15 Sep 2025 23:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rJfMUf8K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DF778344E; Mon, 15 Sep 2025 23:01:16 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7444881E13
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 23:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-30ccea8a199so3649596fac.2
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757970071; x=1758574871; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AOr0K3ri0ZKDc4o5Cxtg75UEWClBFegpakc5BymJ3H8=;
 b=rJfMUf8KuETMzRE5UInaigMG3MbOhsYE88suP+seJxG3l5rbVXO6f5LD/xOiMaoyhX
 e8rFSebExrWdreotv4kRGgwxIPSeMybCmuxkLA58f6ouS7t7pqxP9WiVokbn+8X3lH6s
 efYlYq13sSX6S+GCMu+j/A9IiJpeQZPITn5mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757970071; x=1758574871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AOr0K3ri0ZKDc4o5Cxtg75UEWClBFegpakc5BymJ3H8=;
 b=QkgYPlCDkGjupA62JtdVHczjDuRoEOxfhG1GPWk/xyraUHgJAA30FQ6Gibvl6T2/g2
 +Km+Ap5M74GFTossFqm4yQmlvIgzn+sfW7pnWt9XUo0+695IC0hD75nW1UBGdv0d6A8N
 CBpwvR4wqju9n6tQofWDmZZ/zaTCXeESS6QRzK9BeFM+m5EDwHpI4f16tpHuyMA3Nz9U
 VwKfbdVRuRdI1rsK4dWwPsJEYbQu31M0AF2lNb4SaVtxqQ+mH7N2vJ+HUPd4t8HMTZ8F
 y+dA2eVEEhm6OMzzX+ylMf4Q0bSb4h4b3poalM0T1/Q4zCEHGSKogDICsbPdmFuori33
 OJiw==
X-Gm-Message-State: AOJu0YxupVoFe1E+ip6ZeU6P03UhuF9wXe+bb1kpxUJsVSJ9Qzvbsz/J
 3ZHA5RVByM3Jmcw9NLKf/EgcRrCrWVnsrHFDHQ0SaDclkdsizio5hrtyFn/QykUH9rcOs+8u16L
 MBX4is0o=
X-Gm-Gg: ASbGncsESY03QPz/6udZ9pd5J88aNc4FtwC+VLucSgRPAf12GOiby45bgNn4Bm4phXd
 9PTMa74H11coxDVuMWQlO2zVWQhWKeTkhyZ8KhtXE57AdyjB58uK+bNqpkDi7zJEE6q8c9ScEEV
 A7CHOYLDw82HleDRlZz63hxdVXZUy7r7RMGsoGomvzIrLcf0FnYKCLwrAvXkpMZ18EtNt9ta8uU
 xrT9+F2jh9AEnibWwFQSQ8SCnlWkRXyplEaPFwlAxWkjy/aBUNS9viTsAGdi+i3fRktxzYyCEQs
 hAFm+vTOnjB3vYekG5I7+AHZ5XU5noZZSdoca5vOkdThVQJbc2grbjxrfP8OZ3OVCazZNngp90i
 PMNxWkQcCfbzwP14gEUX6hxhPzVfwM12ko23sHAMYrSE6zeo+IQshXGYLjVs=
X-Google-Smtp-Source: AGHT+IGfloDPlqfJgoXzmB7clbKfcSClx1PlPbIb79lF3bQI5o2gCdBaTRZfz8VirjsfRNfBOZIbxg==
X-Received: by 2002:a05:6870:d892:b0:31d:6e38:e138 with SMTP id
 586e51a60fabf-32e54d87e4amr6700854fac.7.1757970071118; 
 Mon, 15 Sep 2025 14:01:11 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7524be79747sm3173178a34.30.2025.09.15.14.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 14:01:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH] MAINTAINERS: Update Luka Perkov's roles
Date: Mon, 15 Sep 2025 15:01:09 -0600
Message-ID: <20250915210109.459864-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Per a private email, drop Luka Perkov from MAINTAINERS entries.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Thanks for all your work in the past!

Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 MAINTAINERS                                | 1 -
 board/Marvell/mvebu_armada-8k/MAINTAINERS  | 1 -
 board/iomega/iconnect/MAINTAINERS          | 1 -
 board/mikrotik/crs3xx-98dx3236/MAINTAINERS | 4 ----
 board/zyxel/nsa310s/MAINTAINERS            | 1 -
 5 files changed, 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3fb163aa1db1..1b41f57a58bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -346,7 +346,6 @@ F:	drivers/spi/gxp_spi.c
 
 ARM IPQ40XX
 M:	Robert Marko <robert.marko@sartura.hr>
-M:	Luka Perkov <luka.perkov@sartura.hr>
 S:	Maintained
 F:	arch/arm/mach-ipq40xx/
 F:	include/dt-bindings/clock/qcom,gcc-ipq4019.h
diff --git a/board/Marvell/mvebu_armada-8k/MAINTAINERS b/board/Marvell/mvebu_armada-8k/MAINTAINERS
index 55e485faa962..15660cd17d4f 100644
--- a/board/Marvell/mvebu_armada-8k/MAINTAINERS
+++ b/board/Marvell/mvebu_armada-8k/MAINTAINERS
@@ -13,7 +13,6 @@ F:	configs/mvebu_mcbin-88f8040_defconfig
 
 Puzzle-M801 BOARD
 M:	Luka Kovacic <luka.kovacic@sartura.hr>
-M:	Luka Perkov <luka.perkov@sartura.hr>
 S:	Maintained
 F:	configs/mvebu_puzzle-m801-88f8040_defconfig
 F:	arch/arm/dts/armada-8040-puzzle-m801.dts
diff --git a/board/iomega/iconnect/MAINTAINERS b/board/iomega/iconnect/MAINTAINERS
index a1b018e8169f..d9093b28ef08 100644
--- a/board/iomega/iconnect/MAINTAINERS
+++ b/board/iomega/iconnect/MAINTAINERS
@@ -1,6 +1,5 @@
 ICONNECT BOARD
 M:      Tony Dinh <mibodhi@gmail.com>
-M:	Luka Perkov <luka@openwrt.org>
 S:	Maintained
 F:	board/iomega/iconnect/
 F:	include/configs/iconnect.h
diff --git a/board/mikrotik/crs3xx-98dx3236/MAINTAINERS b/board/mikrotik/crs3xx-98dx3236/MAINTAINERS
index 906ff98970bd..04423556924a 100644
--- a/board/mikrotik/crs3xx-98dx3236/MAINTAINERS
+++ b/board/mikrotik/crs3xx-98dx3236/MAINTAINERS
@@ -1,13 +1,11 @@
 CRS3XX-98DX3236 BOARD
 M:	Luka Kovacic <luka.kovacic@sartura.hr>
-M:	Luka Perkov <luka.perkov@sartura.hr>
 S:	Maintained
 F:	board/mikrotik/crs3xx-98dx3236/
 F:	include/configs/crs3xx-98dx3236.h
 
 CRS305-1G-4S BOARD
 M:	Luka Kovacic <luka.kovacic@sartura.hr>
-M:	Luka Perkov <luka.perkov@sartura.hr>
 S:	Maintained
 F:	configs/crs305-1g-4s_defconfig
 F:	configs/crs305-1g-4s-bit_defconfig
@@ -16,7 +14,6 @@ F:	arch/arm/dts/armada-xp-crs305-1g-4s-bit.dts
 
 CRS326-24G-2S BOARD
 M:	Luka Kovacic <luka.kovacic@sartura.hr>
-M:	Luka Perkov <luka.perkov@sartura.hr>
 S:	Maintained
 F:	configs/crs326-24g-2s_defconfig
 F:	configs/crs326-24g-2s-bit_defconfig
@@ -25,7 +22,6 @@ F:	arch/arm/dts/armada-xp-crs326-24g-2s-bit.dts
 
 CRS328-4C-20S-4S BOARD
 M:	Luka Kovacic <luka.kovacic@sartura.hr>
-M:	Luka Perkov <luka.perkov@sartura.hr>
 S:	Maintained
 F:	configs/crs328-4c-20s-4s_defconfig
 F:	configs/crs328-4c-20s-4s-bit_defconfig
diff --git a/board/zyxel/nsa310s/MAINTAINERS b/board/zyxel/nsa310s/MAINTAINERS
index 11106acf3e94..865c98f7724d 100644
--- a/board/zyxel/nsa310s/MAINTAINERS
+++ b/board/zyxel/nsa310s/MAINTAINERS
@@ -1,6 +1,5 @@
 NSA310S BOARD
 M:	Tony Dinh <mibodhi@gmail.com>
-M:	Luka Perkov <luka.perkov@sartura.hr>
 S:	Maintained
 F:	board/zyxel/nsa310s/
 F:	include/configs/nsa310s.h
-- 
2.43.0

