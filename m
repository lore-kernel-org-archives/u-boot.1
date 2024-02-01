Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75956C47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF9B687C96;
	Thu,  1 Feb 2024 04:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pFh3gYgp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5A7D87C88; Thu,  1 Feb 2024 04:06:48 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C0A387CD5
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41136bZ0082255;
 Wed, 31 Jan 2024 21:06:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706756797;
 bh=kmEXLSerg+i39HiQkEErMupBmDWOraAaU1O2uFT7sDk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=pFh3gYgpNrOWTAkahDMtI8QYxYbx5cq/WmhqR/kHm9FtBptP/RNRfj/S+FtNriw6D
 zQdVVh51JNcsCdvetXeb5ebDWm453nEVkN8GcN8wN1dOueq5LG8Fza3zmXdnH4rbnZ
 +y9DKLhRxTHMTbXySQo9+wxkaPfBnr0zSik1+eR0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41136bT7124157
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jan 2024 21:06:37 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 21:06:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 21:06:37 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41136b62098197;
 Wed, 31 Jan 2024 21:06:37 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 04/13] ram: k3-ddrss: enable the am62ax's DDR controller
 for am62px
Date: Wed, 31 Jan 2024 21:06:40 -0600
Message-ID: <20240201030634.1120963-21-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201030634.1120963-16-bb@ti.com>
References: <20240201030634.1120963-16-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=772; i=bb@ti.com;
 h=from:subject; bh=+C8ctkD1/35kKYeKUng3EVpup6HahWcf3tJk27SgRLY=;
 b=owNCWmg5MUFZJlNZwjZougAAbX/////9/7vv3n3+73q/+6kP/8T//Z/YuHP//W/osf/7/uSwA
 RmZpD1BpoDQ0AAAAAaDQA0AAABoGgNADEaGEBiMQNAB6g9QaDRoyZA9J6GUQeoaANGgGmjQ00AA
 aMIaANADQDRoAGho0yekDCDJ6h+qA0aaA0DTQaBkANBoAxQ0aaPUGgAyABoaAHqDQA9Ro9QAADR
 oAaDQA0aeoAANAGgaAeoPUA00DanqZCxaStgmeiOVRgVEXambBVtvkG+l3BLqhhKW8yBWDg4hzk
 X1J+BHGfPshGP5goYtVGfJmk7iTod2bEm3NKaQLBVBUqfE30Z3nIVp0QCgZNKe1d38d0R47iZO5
 QGqaPichJz0VPPbCP9rfhbRqHN1EFT+QYzz3tSZM8Gv9xoS4JWxKKUW6/RxlkAM3iCNCifOq/b3
 qk2b4qAwcXx/V7sKY5M4wADo9QAWZmNzfg19XYfLdSu53LGUkMfLB9++qBbNaqVkTZUjkmLftUA
 t92CFDPzwntUwb20qfoJYIf9+wOE8ssd0jAC8FNufegoUqmUsEyCsKUqb8WP8hYuXVsciIgnYO2
 qIsWkGu5uhP2dvS7dngLEAI/MSTYlC2t9AaIQNn+CL1NMfpigNFbCqCNgdeX/O8etPLQHoaI2T3
 RqXKHEATCjbYo3+LuSKcKEhhGzRdA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The am62px family of SoCs uses the same DDR controller as found on the
am62ax family. Enable this option when building for the am62px family

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/ram/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index 5b07e92030142..56391058567bb 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -65,7 +65,7 @@ choice
 	default K3_J721E_DDRSS if SOC_K3_J721E || SOC_K3_J721S2
 	default K3_AM64_DDRSS if SOC_K3_AM642
 	default K3_AM64_DDRSS if SOC_K3_AM625
-	default K3_AM62A_DDRSS if SOC_K3_AM62A7
+	default K3_AM62A_DDRSS if SOC_K3_AM62A7 || SOC_K3_AM62P5
 
 config K3_J721E_DDRSS
 	bool "Enable J721E DDRSS support"
-- 
2.43.0

