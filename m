Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB50C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 07:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B378088662;
	Wed,  8 May 2024 09:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IGuVr2/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE533885C8; Wed,  8 May 2024 09:26:38 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A29478844B
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 09:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4487QYaI052324;
 Wed, 8 May 2024 02:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715153194;
 bh=FZ8U2jq/Y+oeWQdKe9G52yKeYd6xgRs5Z5ZibmLSMEc=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=IGuVr2/DXKxPpFVjyGnNofNo358g+6MSx94H8ciD52y02DWjfzjrLdrQbdpPB8WkU
 WFRWduk0/+0p00UazOF1xNFiASy3UOMJ6kOZkgKk/CCbMEHXGI3jKJZVzjN7f0m9wj
 DH1SKfH0Z2eKZLUsGxaIUHryKCyrhqtdFkfT47Dw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4487QYg8044178
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 8 May 2024 02:26:34 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 May 2024 02:26:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 May 2024 02:26:34 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4487QRJt015339;
 Wed, 8 May 2024 02:26:31 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 8 May 2024 12:56:25 +0530
Subject: [PATCH 1/6] board: ti: j721s2: j721s2.env: Add explicit boot_targets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240508-b4-upstream-j721s2-of-upstream-v1-1-ed0933172410@ti.com>
References: <20240508-b4-upstream-j721s2-of-upstream-v1-0-ed0933172410@ti.com>
In-Reply-To: <20240508-b4-upstream-j721s2-of-upstream-v1-0-ed0933172410@ti.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715153187; l=680;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=iUoIaGFgzDN+KiVHG83UNr6x3GKtvQVD2wwlc7cvMJw=;
 b=Tkc042MRvtK/7fuqcBhHLRyacvQ09Ybgs9hvw62ZC2JHP8vNwxCtvt2MrXqAfmJVcJQIEHMN1
 W2J4qclr3RLA3909IV7Z75Ij/LqaUzDd+1RGaGxThFVUiaABE6NTRwp
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

