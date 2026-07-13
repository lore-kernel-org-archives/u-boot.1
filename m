Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C337EC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 10:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17BAC84A7A;
	Mon, 13 Jul 2026 12:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="vbBWHb2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3D0D84A90; Mon, 13 Jul 2026 12:02:51 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6216084A78
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 12:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47d6c634f45so1516814f8f.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 03:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783936969; x=1784541769; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tZi/DB95k1HqDNtQVqu2JcCqBKGd9ymJiSY6s58rM54=;
 b=vbBWHb2+p1AxKOxy4O96K6FaI5RD8UTgEPwXH4P9nbbx14TLNg/OKwYl3Vl6Ok8fqx
 2DyFP2OIRQV/DlyG7wo5ePBbyu/mNHEfrpYy25mzqVa4H33LLXT6ssHZ5pzh/nVfjn4U
 IQfwDvx2ZJmoc+su7HYjGbIfVI52WBarbhp9qsEOnM3fmJjOMItFxHHhVoowdfcRqD+m
 v3rOZPISCgVruh9Biw4MFu8R4Gmd6WZ/W5Lr8nvxH85CFwM2zFvBLh5HswOwYxHLUQgn
 Q7UnKQ5mo+iTbxLZvfl+oeEH/tA5CsgvR5YFGhlGQ8K0OMFvl4GU33twwIC2mKv5yes2
 zxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783936969; x=1784541769;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tZi/DB95k1HqDNtQVqu2JcCqBKGd9ymJiSY6s58rM54=;
 b=lld5JO/4GATRgTcdsflM+ZxfL2ptWoXRT2UkpvclBDvSdQYgowOZJQiOto6JGbqdwW
 CTpApemcVqSj2n4LnC5RDooEBbi+Vvmx6Gwzm4i4+K8r/KQoYG/q3ghLfh3iwgTL66uE
 DEpN95Hx9vLQ1KxZVYLKSwhiZpFMAd+PGMZDqsKUsH9xHuC3GaJmCpv+HvliJCYwaapO
 IbmSsNkaIronTxSDsu3uw1mWb4EeSMCrbl6HT8lR3DKQ8j9st/QJ2MM+QrTU+jadbL9A
 yJ74WCK4WmOI1iJ2l2Ngwj3UvP7u3xe3tlXI3S733QXwG22cIdSgr7yhcF+2PRPCFfU6
 zolQ==
X-Gm-Message-State: AOJu0YxmnS3Y0saNIpn2x8kqdDuBne/q9qCswgUbYdzjw0D1QGT1QDEF
 HDnAVfg8QBr0+CZ/fgXjI64i1JVoAmYJt2CMPe/4XQ4Otk/+MDst+Hb4/CwcYftbllM=
X-Gm-Gg: AfdE7cmyn0NAEpGVumBTE8z/FAU3UwktiUVCgXOcGB0K6x9kiPzRDNq/zfxG8kW5enA
 EfKimDGN5FJLwuDBhm96zQwfuIMG6E+tZZ9tglKuLWbQfBuLTjyTyX3O31jezRbbjQfq4xNWiAk
 tWaBjTvF2lDbfwxJo7dA/sRLY5jQLM/nKlzhbGVcafqmtTwFcgYVY+35QnvDQmgTNNPa9rWDeOU
 6+NVefOSHnxGRQ3OLy9fSgs1bEiqDjlwGzOeOnhTVU0ea5aj5hY+EllkBgJfS9V7rK/E7+crPwH
 lo6u5UrlIwCEoMogt4VxhrJDoanDBJ9YWXHVTNbn0K3p+hqsr1j2fjUy/gkqsmzrVdfIMCNgm82
 R1LTQgEnktwPm0qg4MweXXTeWLa9ZJbFvOhvBKpRuZ++KtTIUPCp5svOSy4IFsHD/PKLqvD9fvP
 P5AFaos4XlwlVzgOweHg6veE86oZuYp87I0IKzDr8Wat7LVPSWQmstWwSVbBIgbCKG
X-Received: by 2002:a5d:588b:0:b0:474:8aad:2e0 with SMTP id
 ffacd0b85a97d-47f2dc7d2a0mr9533644f8f.9.1783936968678; 
 Mon, 13 Jul 2026 03:02:48 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f25b23b7esm29135772f8f.18.2026.07.13.03.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 03:02:47 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 0/7] rockchip: fix boot from SDMMC on RK3576
Date: Mon, 13 Jul 2026 14:02:41 +0400
Message-Id: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDVBWxVXEQtqMCQqHUQi7q5Yv
 sX/FzB6QoYyusDjQUxuCUjjCOzYLAMK6oIhS7I8MakUfpba5KJ1jjehi0b3yqBRKCEkq8eezm9
 X1b95bye02/uA+34Axlbe0HAAAAA=
X-Change-ID: 20260713-rk3576-boost-58a5f47e74e3
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2384; i=alchark@flipper.net;
 h=from:subject:message-id; bh=PkGN+zjkMCWHCBel+hsZz5YhFK5hATRQ9Wmfm+KTIWk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSFbD9mwFbUnRk2uS1i8dFe3du7roQc/n2g8tfs0kuXu
 96K8R2r7pjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqg+8yMuzVW9GXvqREXGR5zZFsGaHv748dvitdtj1/8fNndyZ9aj3K8D+YV3n
 Kt0lzmw0eL3ny9vZlL943/mHxRwQrAi5vCS91aOUCAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

This aims to upstream Jonas Karlman's long-standing patch series fixing
the boot from SDMMC on RK3576, which requires a hotfix to the boot ROM's
global state area before any SDMMC reads are initiated to avoid clobbing
the ROM's state and breaking the boot process.

The preparatory patches for the image tools are submitted verbatim from
Jonas' version, while the "boost" code doing the actual hotfix is
converted from using a pre-built tiny binary to a from-source build using
the existing U-Boot build system.

From-source build also alleviates the problem with parallel out-of-tree
builds, which could skip the pre-built binary but which always pick up the
from-source build.

Tested on a number of RK3576 boards, including the Rockchip RK3576 EVB1,
ArmSoM Sige5, FriendlyElec NanoPi M5, Luckfox Omni3576, Radxa Rock 4D and
Flipper One, all of which fail to boot from SDMMC without this series but
boot fine with it applied.

I've also done some JTAG debugging of the boot process, and the single-
word write which the boost binary performs to the SRAM at 0x3ff803b0
appears to be relocating the base of the SDMMC IDMAC DMA descriptor buffer
to the top of SRAM, which prevents large multi-page SDMMC reads from
overrunning adjacent ROM state and thus breaking the boot process. A
comment has been added to the boost code to reflect this.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Jonas Karlman (7):
      rockchip: mkimage: Split size_and_off and size_and_nimage
      rockchip: mkimage: Print image information for all embedded images
      rockchip: mkimage: Print boot0 and boot1 parameters
      rockchip: mkimage: Add option to change image offset alignment
      rockchip: mkimage: Add support for up to 4 input files
      rockchip: mkimage: Add option for image load address and flag
      rockchip: mkimage: Add rk3576 align and sd-card workaround

 arch/arm/mach-rockchip/rk3576/Makefile       |  10 +
 arch/arm/mach-rockchip/rk3576/rk3576-boost.c |  31 +++
 tools/rkcommon.c                             | 290 +++++++++++++++++----------
 tools/rkcommon.h                             |   2 -
 4 files changed, 228 insertions(+), 105 deletions(-)
---
base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
change-id: 20260713-rk3576-boost-58a5f47e74e3

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

