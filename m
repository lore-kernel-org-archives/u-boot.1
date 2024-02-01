Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56F9C47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F35D87D18;
	Thu,  1 Feb 2024 04:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gmw2d3c7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB37187D04; Thu,  1 Feb 2024 04:06:56 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A635E87CF4
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41136bCT007079;
 Wed, 31 Jan 2024 21:06:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706756797;
 bh=suzDVwouEFpPbm3oo9iBhIOcvdDwTh8vwxT21oG2YvU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gmw2d3c77TRei3LwxqGlcJggusZjiHb+ESvjOunE7hQ0Hf86rpVP2ZxNTSEDzHbJf
 6NoeJxjwfOfbbBUAZkNUwt9qa635jJ8zluY57iX6qe4LGq1oCfL66LWPb7CJ5FhRzA
 h2I5vgPNdebrbuiSmtRlkIfY5o2rsUKklFSHodew=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41136bcp008930
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jan 2024 21:06:37 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 21:06:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 21:06:37 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41136bAe043581;
 Wed, 31 Jan 2024 21:06:37 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 05/13] arm: mach-k3: invert logic for split DM firmware
 config
Date: Wed, 31 Jan 2024 21:06:41 -0600
Message-ID: <20240201030634.1120963-22-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201030634.1120963-16-bb@ti.com>
References: <20240201030634.1120963-16-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=949; i=bb@ti.com;
 h=from:subject; bh=liEV36LyF5uQcZ5b2iTAxNTDBRLjtYAcFjkK5rM5iUo=;
 b=owNCWmg5MUFZJlNZtEnCeQAAaX/////tNz//rf7sx10rF77f/rvrdX9n3+Z3b4quvRfP39WwA
 Rs22HamQaGRpkD0mRoGg0AaNMgMgADQAGgAA0yBpoAA0aGRkaAeoZDQ9Qeo/QoZIAAAAyGgPUA0
 BptIANBp6mQAaB6RoeoaNGQYhp+qNNAB6mgeoPUDRhNGgyAdDaINBkMmmmQZAZMjIyGE0GmmQGQ
 GgMhkBoGQGjQA0ZGJiBiNNAyaaaBk0AAGw1iEyAclHB8QpNBBM2G9OQ8Y+ZF7VCpQE+cdUsaJ94
 Li6UoPTnzcDJgEQr0t1m0aztJicOvEHGQkCg00EY0gAImvISlm8pfeXMpdJL/iY9Tai3x6tW8n+
 PSfN0o+dSjbyYKodS7RB5ErF39cQhDD5CbFIvv2x9vI1ALwMTLMCp/I/GWbaM5hFLimp9Vos+rX
 hkydD4r0aLQAI2bQrXDEEiF4/wNdsjYvRiuvYNPZ0Z3Q5oW78/X+EoOB9+oSi2ec87wBbvxrcU2
 Lw6dPjUTf2rXm0nJkQ6vWwwoB6FK/A7BiCrJh0jslUuaPXa4WGDeAzLeuC10P0RJ+Inmb4FaQfl
 EDt2p6fwcYZ98G+yKWZ/hDL0C9ipiy94ndKjhDdtc9MBU5MX9V6okFZgHwfyHlPjh2u5UFA4ojJ
 AwIuQqEBJGmT/i7kinChIWiThPI
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

Currently, for the K3 generation of SoCs, there are more SoCs that
utilize the split firmware approach than the combined DMSC firmware.
Invert the logic to avoid adding more and more SoCs to this list.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 03898424c9546..0574e81075e6d 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -130,7 +130,7 @@ config K3_ATF_LOAD_ADDR
 
 config K3_DM_FW
 	bool "Separate DM firmware image"
-	depends on CPU_V7R && (SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_AM625 || SOC_K3_AM62A7) && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
+	depends on CPU_V7R && ARCH_K3 && !SOC_K3_AM642 && !SOC_K3_AM654 && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
 	default y
 	help
 	  Enabling this will indicate that the system has separate DM
-- 
2.43.0

