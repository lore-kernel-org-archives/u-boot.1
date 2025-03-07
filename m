Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9474C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 13:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 739A1800B6;
	Fri,  7 Mar 2025 14:14:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="j0YhtFHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8CE7810F5; Fri,  7 Mar 2025 14:14:42 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C37EE81298
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 14:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 9095320DC9;
 Fri,  7 Mar 2025 14:14:40 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iw9nHLPzPle9; Fri,  7 Mar 2025 14:14:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1741353269; bh=IWFdv9My+/+VId7lN+l3RL/mM9L0ANWtJUZZhGK69D8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=j0YhtFHeQAUL1omf9dOIA2kHwnyv3E6kUp5wPEmnZYkBdiHHTC7KrO8zS3h1mHKuu
 tIP2gwhnLTUfUSxMwijSsRc7YWf25X1EJUUpwm1PoY6Ulx4sxapeTWojhzW67KyPbi
 f08yeKR+R7h4k8MinV35zFuv4Xe1efELTdd2eVBOMFcAPagvpAVeUZX3r7riXRnyqx
 UjDyb5B1Mrv0y8GA1b/GQjC25h+iM2bQ0avDc7Q+FUhCo77eEpv9c8j0Rm2HL1h8rL
 BcNjhQYzxt1EaRA0aLQmmCnUte8NxqXh6xTMRM/oG1shgxOTv7243uKMqHHr6tziN6
 ec4NLfJbdUy6Q==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Green Wan <green.wan@sifive.com>,
 Minda Chen <minda.chen@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 3/4] board: starfive: Remove duplicated board_fdt_blob_setup
Date: Fri,  7 Mar 2025 13:13:43 +0000
Message-ID: <20250307131344.43762-4-ziyao@disroot.org>
In-Reply-To: <20250307131344.43762-1-ziyao@disroot.org>
References: <20250307131344.43762-1-ziyao@disroot.org>
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

The default version should work for Starfive VisionFive 2.

Signed-off-by: Yao Zi <ziyao@disroot.org>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 board/starfive/visionfive2/starfive_visionfive2.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 3940d45b13f..96fb8dfe934 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -115,16 +115,6 @@ int board_late_init(void)
 	return 0;
 }
 
-int board_fdt_blob_setup(void **fdtp)
-{
-	if (gd->arch.firmware_fdt_addr) {
-		*fdtp = (ulong *)(uintptr_t)gd->arch.firmware_fdt_addr;
-		return 0;
-	}
-
-	return -EEXIST;
-}
-
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	return fdt_fixup_memory(blob, 0x40000000, gd->ram_size);
-- 
2.48.1

