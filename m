Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5885CC10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 09:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDF4488485;
	Thu,  9 May 2024 11:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OvGlOaPa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E27688470; Thu,  9 May 2024 11:53:33 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 472DF88479
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 11:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4499rSMF031284;
 Thu, 9 May 2024 04:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715248408;
 bh=FZ8U2jq/Y+oeWQdKe9G52yKeYd6xgRs5Z5ZibmLSMEc=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=OvGlOaPa+NK3CtS9iMLeqX7kn41+bJMGuzpkBvTFJe/7YDQwofp5ujvTr8jXJmVth
 ESOwyEMLLJKDelWaQWbjaauDN9WitTtWgbqjfwWA85pnJTQ+H+yUH2h39L22CjEmq/
 gG1IKRJW+3t++qe+tSrUyoeN6ViB5SCaqE0bnaaE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4499rSEe012087
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 04:53:28 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 04:53:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 04:53:28 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4499rKt2075143;
 Thu, 9 May 2024 04:53:25 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 9 May 2024 15:23:15 +0530
Subject: [PATCH v2 1/6] board: ti: j721s2: j721s2.env: Add explicit
 boot_targets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240509-b4-upstream-j721s2-of-upstream-v2-1-149563cd4901@ti.com>
References: <20240509-b4-upstream-j721s2-of-upstream-v2-0-149563cd4901@ti.com>
In-Reply-To: <20240509-b4-upstream-j721s2-of-upstream-v2-0-149563cd4901@ti.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715248400; l=680;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=iUoIaGFgzDN+KiVHG83UNr6x3GKtvQVD2wwlc7cvMJw=;
 b=GTrSbRicUFcyZ+RbY4t7SkBQNZfvQy0sVqKxR6RDi7t1Y4v2WZGOgiEP6UqE9WUtluQHsq79P
 Mv7g0tgOoWbAZPqXk82GAx/6y00rUMkJKlxg1EMW2LoBx3oUKYIC1Qu
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

From: Neha Malcom Francis <n-francis@ti.com>

Add explicit boot_targets to indicate the specific boot sequence to
follow.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 board/ti/j721s2/j721s2.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/ti/j721s2/j721s2.env b/board/ti/j721s2/j721s2.env
index 9a03b9f30aee..a6b22550809e 100644
--- a/board/ti/j721s2/j721s2.env
+++ b/board/ti/j721s2/j721s2.env
@@ -13,6 +13,7 @@ args_all=setenv optargs earlycon=ns16550a,mmio32,0x02880000
 	${mtdparts}
 run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
 
+boot_targets=mmc1 mmc0 usb pxe dhcp
 boot=mmc
 mmcdev=1
 bootpart=1:2

-- 
2.43.2

