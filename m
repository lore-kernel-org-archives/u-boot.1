Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA50C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 11:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1068A86923;
	Fri, 25 Aug 2023 13:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JlV6xidB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E589F86898; Fri, 25 Aug 2023 13:17:38 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3365386898
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 13:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37PBHYjU005059;
 Fri, 25 Aug 2023 06:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692962254;
 bh=PwWTosLw3xZ02ctavFcQZtLXxnyJsEmWIENi2hqnyF0=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=JlV6xidBev4ucNFdqwdu7KZrJoQWXsGIXDN3mtqQRRKH6+DgyeDeTn0ksBeZeh/AP
 V3Bpl66zakHOcfJSSy4c9/zej7XSyFsXTj+BNk3b9aRQvWO7MNfS4WH1l/gxscWlqq
 OBrVv8HEyqDGg83L5i4Iw6cjIGGRfdliIW2N+7x4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37PBHYBk073128
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Aug 2023 06:17:34 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 06:17:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 06:17:34 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37PBHQC6023435;
 Fri, 25 Aug 2023 06:17:31 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 25 Aug 2023 16:46:59 +0530
Subject: [PATCH v2 1/6] configs: j721s2_evm_r5_defconfig: Increase malloc
 pool size in DRAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230816-b4-upstream-j721s2-r5-pinmux-v2-1-a5f141be40bc@ti.com>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Nikhil M Jain <n-jain1@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692962247; l=887;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=yVqEZkBHO7p5XWjYgEutOj0Otprb5jaNFYw7Nf6dtnU=;
 b=4sXmJF76ieNYpApSZ80h9QHmmlYzgeVLjrF35GgHRBQCBn43HhtBXVPOwZIq9P/OF5xPfQHou
 un2AHjeKdRMAsLULRQaVY05IAEEjtx13EFbvX48Eqglv4vj/XW90G4+
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

From: Udit Kumar <u-kumar1@ti.com>

The malloc capacity in DRAM at R5 SPL is set to 1MB which isn't
sufficient to load the new tispl.bin to
enable loading of tispl.bin the size is increased by 256KB to 1.25MB.

Cc: Nikhil M Jain <n-jain1@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 configs/j721s2_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index 1e66ac23d05b..e2b83b337809 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -42,6 +42,7 @@ CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x140000
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SYS_SPL_MALLOC=y
 CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y

-- 
2.41.0

