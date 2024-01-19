Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C274AC47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 17:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C2CD87D7A;
	Fri, 19 Jan 2024 18:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GhUH8sj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1629887D7A; Fri, 19 Jan 2024 18:51:09 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F86487CB7
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 18:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40JHowGA061024;
 Fri, 19 Jan 2024 11:50:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705686658;
 bh=cRe1HORfL3Tw29ly02DHaep0Tq4JLI6gq1eMOWjKxWQ=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=GhUH8sj0VrVgk35PGcAQ/ydq/uasqIR48kBXDcVE3GhzPmXQRh9TISOTMnurQgSpU
 KSjsIf1DpPAEjQi887qG4POx4hrdZE7fO6JvXEcwtiAC92nAzbugLnIFYQX68RyFJS
 PaMLPYireKJphIi955lJ6RmXQnBiKhQwxSAOgwuw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40JHoww0099386
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Jan 2024 11:50:58 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Jan 2024 11:50:57 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Jan 2024 11:50:57 -0600
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40JHoiDN054787; 
 Fri, 19 Jan 2024 11:50:51 -0600
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
Subject: [PATCH v8 01/16] arm: mach-k3: Kconfig: Sort SOC_K3 config entries
Date: Fri, 19 Jan 2024 23:20:28 +0530
Message-ID: <20240119175043.3904751-2-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119175043.3904751-1-a-nandan@ti.com>
References: <20240119175043.3904751-1-a-nandan@ti.com>
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

Sort SOC_K3 config entries in alphabetical order
for clean up.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm/mach-k3/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 03898424c9..f0ed5c6128 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -4,6 +4,15 @@ choice
 	prompt "Texas Instruments' K3 based SoC select"
 	optional
 
+config SOC_K3_AM625
+	bool "TI's K3 based AM625 SoC Family Support"
+
+config SOC_K3_AM62A7
+	bool "TI's K3 based AM62A7 SoC Family Support"
+
+config SOC_K3_AM642
+	bool "TI's K3 based AM642 SoC Family Support"
+
 config SOC_K3_AM654
 	bool "TI's K3 based AM654 SoC Family Support"
 
@@ -13,15 +22,6 @@ config SOC_K3_J721E
 config SOC_K3_J721S2
 	bool "TI's K3 based J721S2 SoC Family Support"
 
-config SOC_K3_AM642
-	bool "TI's K3 based AM642 SoC Family Support"
-
-config SOC_K3_AM625
-	bool "TI's K3 based AM625 SoC Family Support"
-
-config SOC_K3_AM62A7
-	bool "TI's K3 based AM62A7 SoC Family Support"
-
 endchoice
 
 if SOC_K3_J721E
-- 
2.34.1

