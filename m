Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C0EE748F3
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 16:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D66F0870C5;
	Sun,  1 Oct 2023 18:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="n3BOc64W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13A5D870B9; Sun,  1 Oct 2023 18:56:34 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0666986D96
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 18:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 391GuFXW020087;
 Sun, 1 Oct 2023 11:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696179375;
 bh=2DJgLx/vhLf9TTJF+PlrNltDPXUxTN8Ga44+2/FS4qw=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=n3BOc64WhKzGIi+zDi1U+p8AyrslfiH+x+Hgsy8JS+zhoTFR37NmZGgv29br9eiBZ
 SST3ojtMiyiO0l1EKwHXbeDTQUy4E2qNTTh0wcZuSSf3k+3Ls3YjgUhy7Z28OkePRI
 W3wl+jCIZlDPCqP42uMAspFcl1BRtXn8QquCjEeE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 391GuF8v025622
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 1 Oct 2023 11:56:15 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Oct 2023 11:56:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Oct 2023 11:56:15 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 391GtkAQ002403;
 Sun, 1 Oct 2023 11:56:08 -0500
From: Apurva Nandan <a-nandan@ti.com>
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v4 03/16] arm: mach-k3: Sort SoC JTAG_ID entries
Date: Sun, 1 Oct 2023 22:25:32 +0530
Message-ID: <20231001165545.494212-4-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001165545.494212-1-a-nandan@ti.com>
References: <20231001165545.494212-1-a-nandan@ti.com>
MIME-Version: 1.0
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

Sort JTAG_IDs for K3 SoCs in hardware.h in alphabetical order.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm/mach-k3/include/mach/hardware.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 03b18f6bad..e8283c066f 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -43,13 +43,13 @@
 #define JTAG_ID_VARIANT_MASK	(0xf << 28)
 #define JTAG_ID_PARTNO_SHIFT	12
 #define JTAG_ID_PARTNO_MASK	(0xffff << 12)
+#define JTAG_ID_PARTNO_AM62AX   0xbb8d
+#define JTAG_ID_PARTNO_AM62X	0xbb7e
+#define JTAG_ID_PARTNO_AM64X	0xbb38
 #define JTAG_ID_PARTNO_AM65X	0xbb5a
-#define JTAG_ID_PARTNO_J721E	0xbb64
 #define JTAG_ID_PARTNO_J7200	0xbb6d
-#define JTAG_ID_PARTNO_AM64X	0xbb38
+#define JTAG_ID_PARTNO_J721E	0xbb64
 #define JTAG_ID_PARTNO_J721S2	0xbb75
-#define JTAG_ID_PARTNO_AM62X	0xbb7e
-#define JTAG_ID_PARTNO_AM62AX   0xbb8d
 
 #define K3_SOC_ID(id, ID) \
 static inline bool soc_is_##id(void) \
-- 
2.34.1

