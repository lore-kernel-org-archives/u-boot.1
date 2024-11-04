Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB32ED132C7
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6B0A88D3A;
	Mon,  4 Nov 2024 14:50:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADA3288DFB; Mon,  4 Nov 2024 14:50:36 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 210AC88D3A
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.paterson2@renesas.com
X-IronPort-AV: E=Sophos;i="6.11,257,1725289200"; d="scan'208";a="227814439"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 04 Nov 2024 22:50:32 +0900
Received: from spl2-146.example.org (unknown [10.24.1.209])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 94B3841A9AB3;
 Mon,  4 Nov 2024 22:50:23 +0900 (JST)
From: Chris Paterson <chris.paterson2@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, Tom Rini <trini@konsulko.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 u-boot@lists.denx.de, Chris Paterson <chris.paterson2@renesas.com>
Subject: [PATCH 1/2] configs: hihope_rzg2: Set correct MMC device for U-Boot
 env
Date: Mon,  4 Nov 2024 13:50:11 +0000
Message-ID: <20241104135012.45814-2-chris.paterson2@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104135012.45814-1-chris.paterson2@renesas.com>
References: <20241104135012.45814-1-chris.paterson2@renesas.com>
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

Currently we set CONFIG_SYS_MMC_ENV_DEV=1 which is wrong:
  Loading Environment from MMC... MMC: no card present
  *** Warning - No block device, using default environment

This issue was introduced when we switched to using upstream Linux device
trees for the hihope boards which named the MMC devices differently.

Correct to dev 0 so that the U-Boot environment can be loaded from the
correct storage device.

Fixes: 18fb23b13158 ("ARM: dts: renesas: Switch to using upstream DT on 64bit Renesas SoCs")

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 configs/hihope_rzg2_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
index 6266f3cbc564..f51660300c6b 100644
--- a/configs/hihope_rzg2_defconfig
+++ b/configs/hihope_rzg2_defconfig
@@ -24,7 +24,7 @@ CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_SYS_MMC_ENV_DEV=0
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_GPIO_HOG=y
 CONFIG_DM_PCA953X=y
-- 
2.43.0

