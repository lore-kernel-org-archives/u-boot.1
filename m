Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B1DEFD23A
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 09:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED9A58366F;
	Wed, 25 Feb 2026 10:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Y0sBmOg+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24E9383DCB; Wed, 25 Feb 2026 10:54:34 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B52E82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 10:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B1BF33FB96
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772013271;
 bh=sOpsaiwUvhAZ3O6ImPAEvGkq9xRM4fqvf0PBRLuz2TI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Y0sBmOg+ajP/qEYV0FYv0AiVMd9cbqO6Jb/KtQ+QCCd+ILjP5b8sOGd/F8KvPfEhn
 5lOGobCcAT4Hoac0Mbrk0h1A7PJ0T3qLNPNB1w+y0KzHD+aHTETzLj4sVSrfbGcGo+
 6Ig8nj0lHO2A1x5ALcUdL2XNSDC3hnK2IMM6P0CAL0QdwjOde5cE7US0PFMGnBBmgn
 rcyrWj0KDYEBqT4wpwuRdI+iaHZHjlrU7PE5WgQMx2+XH1NDvC7GdZBik9DfaZOZfx
 HhkyIrj0r3ChTZfFrvlp2Brpc9+usfHKEfCVRP99pGWWhCb3jjt/2MiBvqjjCXtMrg
 ALIdZ9vuTO6WsXNQEEDbfhyqssxm+hdvzYjIJ65iMJsQ+68Lo4nnaViohFiY3y1PVZ
 OblqbwRtXMkMmW8Lfk19+2f6NidqEPFfzS7dRnhmEDGI8sBz4QZZ2TtQA7VzvUvno5
 hS3NGAkKdKUdMOsAAyGrGYEYsH5f7qdbzI2oVNp1m+0tjEXv2AGHmNfta1Fcx6Miog
 JtHfO92OcSzZwCPTpCsVNtHnrGAy353QsynR01Q2ogYSaFJ/Quv8c0N59Sh7irnlH5
 t00IRRYJOgVhtISr78n/nQX7M+8oJThqb5C6eTQ0cy95g1moXpy2BVVHf4L5YdRt/Q
 3hk9JTdWpd5laFNHlX1pz5OE=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4358f90fe8dso865557f8f.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 01:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772013271; x=1772618071;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sOpsaiwUvhAZ3O6ImPAEvGkq9xRM4fqvf0PBRLuz2TI=;
 b=Md12RFOApASu45QwrYfhqgVYlYDm8Fz5GdNN97bdS+ps5hEDjbMVPQKt/499AL28Hq
 IjSUbTbk0ngVZloA94gvf8po4LAJd27ydyn7Ji4CAE3/QzrH81h1BWqQdV1c0BiLOcAY
 RjYF1/eBvOC/q+3jSAPZyCPTZiSP85TWgjnhRVZZ/gZYA+iIaCy+PvnLsrsXeMBcbco0
 tACLE6PlE56oLLIck4fsWTK9JJd/CTylxf3GHcroOKpZpEwR0enF5OhE9WjBCRLAyp2J
 vDspJO1h9vK3JO+lKH5tP6mqQwmdnTCzKmVn2gk7UBCMv+fLstKQOR7KGfwzem2EkHgc
 xrrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6Yof820lvrwPtwXRsNXAAX524QZbuVakKAHiYemqMjcXCcR9XnMYCg8ZMAzbp//AZUpCVjgc=@lists.denx.de
X-Gm-Message-State: AOJu0YzZwBn4Ltx9GgSOdbgrqQ1WbFBk48Ly+MGEGdJJY6kpCXwmt32Z
 vmeUKWeZGIAwq74RJ/lenmXQtlvvcXNvqi5KRCY+Qb8cURp7QpE1XI5vJR+/uOv23jAQYGE6wHA
 KFgt+E/4RjxkOGV+zwU8V63/89Ig3bVE2Smpw299R551a8kb2i0+vy4VFsgogvU7V07XG9v0=
X-Gm-Gg: ATEYQzwH/ysl8CgTF28+xu11dLxj2nlYallhaJQ3GGuKLAZyPUlZneHHgIDosfgqTYR
 B02WziB1u76LKSZ7awtOg4b1HLD9DulhYtNrpkEEKIrkhXCe8koQwDIYPf19Y8862Qgwd75RoPa
 ffpHUOdTxkqMD9OiUl29ceYtecj/HtJyeDy4oi5SlWQVFgCGHf7EvybxxDRnqFzNmuqRezRAKVK
 wgB/fl1zJ+6xc6lM/QW6FLFcaLA/asymRB9sPhFsOg437SoFe2nmxW3kXn3di/1VrDvp3MdhFV2
 Zf+Z/q4aGjiqvskZmWJ+vu3T/YRcy2i4xoJWOeSaycutRkyKgAbdUm06ssZm1oQ//jsiKgUsupj
 bcmHS+rjNLdTpyzF0ura3U52JmoJXBB5jdC3LUsovFVIykFOV4ccxgKCb5perXxoJMpEi8HUO2F
 3oCAVyLNThfI/puC92fTJCiN0skXe5I4SYWFG/xLOuK3UE
X-Received: by 2002:a05:6000:607:b0:437:6906:822e with SMTP id
 ffacd0b85a97d-4398d95c440mr5288254f8f.28.1772013271168; 
 Wed, 25 Feb 2026 01:54:31 -0800 (PST)
X-Received: by 2002:a05:6000:607:b0:437:6906:822e with SMTP id
 ffacd0b85a97d-4398d95c440mr5288205f8f.28.1772013270708; 
 Wed, 25 Feb 2026 01:54:30 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4bf89sm31218729f8f.29.2026.02.25.01.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 01:54:30 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>,
	Rick Chen <rick@andestech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Green Wan <green.wan@sifive.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, E Shattow <e@freeshell.de>,
 Bin Meng <bmeng.cn@gmail.com>, Lukas Auer <lukas.auer@aisec.fraunhofer.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: don't imply non-existent CONFIG_IP_DYN.
Date: Wed, 25 Feb 2026 10:54:14 +0100
Message-ID: <20260225095414.45365-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

The symbol CONFIG_IP_DYN does not exist, but multiple contributors
copied an imply statement.

Remove the imply IP_DYN statements.

Fixes: 3fda0262c33f ("riscv: Add SiFive FU540 board support")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/microchip/mpfs_generic/Kconfig | 1 -
 board/sifive/unleashed/Kconfig       | 1 -
 board/sifive/unmatched/Kconfig       | 1 -
 board/starfive/visionfive2/Kconfig   | 1 -
 4 files changed, 4 deletions(-)

diff --git a/board/microchip/mpfs_generic/Kconfig b/board/microchip/mpfs_generic/Kconfig
index d38e56c742d..3640cf69f3a 100644
--- a/board/microchip/mpfs_generic/Kconfig
+++ b/board/microchip/mpfs_generic/Kconfig
@@ -32,7 +32,6 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply CMD_MMC
 	imply DOS_PARTITION
 	imply EFI_PARTITION
-	imply IP_DYN
 	imply ISO_PARTITION
 	imply PHY_LIB
 	imply PHY_VITESSE
diff --git a/board/sifive/unleashed/Kconfig b/board/sifive/unleashed/Kconfig
index bf4a00d6f7f..2fcc788ba53 100644
--- a/board/sifive/unleashed/Kconfig
+++ b/board/sifive/unleashed/Kconfig
@@ -41,7 +41,6 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply CMD_SF
 	imply DOS_PARTITION
 	imply EFI_PARTITION
-	imply IP_DYN
 	imply ISO_PARTITION
 	imply PHY_LIB
 	imply PHY_MSCC
diff --git a/board/sifive/unmatched/Kconfig b/board/sifive/unmatched/Kconfig
index 991dd23f1d4..5071af129c6 100644
--- a/board/sifive/unmatched/Kconfig
+++ b/board/sifive/unmatched/Kconfig
@@ -42,7 +42,6 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply CMD_SF
 	imply DOS_PARTITION
 	imply EFI_PARTITION
-	imply IP_DYN
 	imply ISO_PARTITION
 	imply PHY_LIB
 	imply PHY_MSCC
diff --git a/board/starfive/visionfive2/Kconfig b/board/starfive/visionfive2/Kconfig
index 2186a939646..185f94190b5 100644
--- a/board/starfive/visionfive2/Kconfig
+++ b/board/starfive/visionfive2/Kconfig
@@ -44,7 +44,6 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply DOS_PARTITION
 	imply EFI_PARTITION
 	imply MII
-	imply IP_DYN
 	imply ISO_PARTITION
 	imply PARTITION_TYPE_GUID
 	imply PHY_LIB
-- 
2.51.0

