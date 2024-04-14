Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F9BC4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 18:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E9E9880FE;
	Sun, 14 Apr 2024 20:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713119985;
	bh=xHcwBke5o81i7d/5uWGbsKVfDhnHff8uM162FWullPM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KwK4AI83JzUVWI2+RpnvGq3kD76fMciMmYTI5fDRiEmJ69xXVLxaqsq6mybcMM8Ex
	 FrIzsbVTgvCGJlEGyOnl2+8UKSw59Vku2rsgExyEtctSYDh1cImo4orQkn9J25KPiH
	 Wmp0ueUzS9aT2du2+Me79H6qxL5D7uczPWS6kkyauwsDgufMgfPjPXCzs0qotOHNFI
	 4AvRKKcWh4JCDhoN7wr+ZnGtoRfXxDygjgMV+O1vAqzH2GRDwWbN3a8jQ3TKEpDD78
	 bu7//U1qlzI2FhIWHPo6XWVAsmVPLZrKrANPUhw64eL6nV76llGnVyNn1OtT9e2bfY
	 VUGR45cP/aSag==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E1CE888134;
 Sun, 14 Apr 2024 20:39:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713119984;
 bh=xHcwBke5o81i7d/5uWGbsKVfDhnHff8uM162FWullPM=;
 h=From:To:Cc:Subject:Date:From;
 b=aWDGHt5OCsVP9jGz7Rl5nrfOmeFOFSUrle8Vb0CQARbg6Dls/8N2JwbxiTA/cYpox
 WXhgSZBE6pIdb3/uVnuJwz1HYJdy5Zu9MJTNbgOisEM20hQJZifqDhrnWN3SVkfue8
 QZADM1x7aiqvPTROQTTeCqiVUsskOyNFN8lPkY6/ial7M7OPO5ggDu54s7vp/83Sas
 FTdnPRyt5R3SSd8IYGDSeWYMRtcGuT8GPqyUyFkPFTu5e8c9uLoCX1LCJgcQ+nXKcg
 45x9kDShGF5R6X0jcW+A4ENw/ZUJnJyDyRdIvXnXG32OKWUidcVCth2lFk/sz/dT2N
 TXy/gWryaaMQw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Igor Opaniuk <igor.opaniuk@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Report OTP-CLOSED instead of rev.? on closed
 STM32MP15xx
Date: Sun, 14 Apr 2024 20:39:29 +0200
Message-ID: <20240414183932.147045-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

SoC revision is only accessible via DBUMCU IDC register,
which requires BSEC.DENABLE DBGSWENABLE bit to be set to
make the register accessible, otherwise an access to the
register triggers bus fault. As BSEC.DBGSWENABLE is zero
in case of an OTP-CLOSED system, do NOT set DBGSWENABLE
bit as this might open a brief window for timing attacks.
Instead, report that this system is OTP-CLOSED and do not
report any SoC revision to avoid confusing users. Use an
SEC/C abbreviation to avoid growing SOC_NAME_SIZE .

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
index afc56b02eea..dd99150fbc2 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
@@ -322,8 +322,23 @@ void get_soc_name(char name[SOC_NAME_SIZE])
 
 	get_cpu_string_offsets(&type, &pkg, &rev);
 
-	snprintf(name, SOC_NAME_SIZE, "STM32MP%s%s Rev.%s",
-		 soc_type[type], soc_pkg[pkg], soc_rev[rev]);
+	if (bsec_dbgswenable()) {
+		snprintf(name, SOC_NAME_SIZE, "STM32MP%s%s Rev.%s",
+			 soc_type[type], soc_pkg[pkg], soc_rev[rev]);
+	} else {
+		/*
+		 * SoC revision is only accessible via DBUMCU IDC register,
+		 * which requires BSEC.DENABLE DBGSWENABLE bit to be set to
+		 * make the register accessible, otherwise an access to the
+		 * register triggers bus fault. As BSEC.DBGSWENABLE is zero
+		 * in case of an OTP-CLOSED system, do NOT set DBGSWENABLE
+		 * bit as this might open a brief window for timing attacks.
+		 * Instead, report that this system is OTP-CLOSED and do not
+		 * report any SoC revision to avoid confusing users.
+		 */
+		snprintf(name, SOC_NAME_SIZE, "STM32MP%s%s SEC/C",
+			 soc_type[type], soc_pkg[pkg]);
+	}
 }
 
 static void setup_soc_type_pkg_rev(void)
-- 
2.43.0

