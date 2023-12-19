Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53126C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 19:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E00E8773D;
	Tue, 19 Dec 2023 20:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OcZEn3KP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43819875FD; Tue, 19 Dec 2023 20:16:22 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E71A6875DB
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:16:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BJJGA1j060006;
 Tue, 19 Dec 2023 13:16:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703013370;
 bh=LxyhgyXywq93TkrPAC9R8p6Uz5pP8md+eQkP4AHrZbA=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=OcZEn3KPwGj6iuvdiGxZ5omc2S0bHiOICxKu9LyIo89E/BL18IIDttz1PReIh6pTP
 SBITUFp/CTbHpJdmkNRSCKtdRcFEP8rXVhKl8RG5TYAcIg64eM4zSeZ2eDFt3lWBQe
 is6cX6BzgDHzb4E0w5l1Dn9C6R4+P2axjHunm5MA=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BJJGApg092648
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 13:16:10 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 13:16:10 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 13:16:10 -0600
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.69.34] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BJJFcAD065909;
 Tue, 19 Dec 2023 13:16:04 -0600
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
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v7 04/17] arm: mach-k3: Sort SoC JTAG_ID entries
Date: Wed, 20 Dec 2023 00:45:24 +0530
Message-ID: <20231219191537.4039361-5-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191537.4039361-1-a-nandan@ti.com>
References: <20231219191537.4039361-1-a-nandan@ti.com>
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
Reviewed-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-k3/include/mach/hardware.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 0cf1e12aaa..7e143c6bdc 100644
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

