Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5729C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 07:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B70987F10;
	Mon, 12 Feb 2024 08:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7688287F10; Mon, 12 Feb 2024 08:48:36 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8416587EF9
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 930D0FEC;
 Sun, 11 Feb 2024 23:49:15 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C68843F762;
 Sun, 11 Feb 2024 23:48:30 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 16/21] fwu: remove the config symbols for number of banks
 and images
Date: Mon, 12 Feb 2024 13:17:07 +0530
Message-Id: <20240212074712.3657076-17-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
References: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
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

With the migration to the FWU metadata version 2 structure, the values
of number of banks and number of images per bank are now obtained from
the metadata at runtime. Remove the now superfluous config symbols.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Changes since V1: None

 arch/sandbox/Kconfig                     |  6 ------
 board/armltd/corstone1000/corstone1000.c |  2 +-
 lib/fwu_updates/Kconfig                  | 11 -----------
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
index 0ce77de2fc..29013a5673 100644
--- a/arch/sandbox/Kconfig
+++ b/arch/sandbox/Kconfig
@@ -79,9 +79,3 @@ config SYS_FDT_LOAD_ADDR
 	  See `doc/arch/sandbox.rst` for more information.
 
 endmenu
-
-config FWU_NUM_BANKS
-	default 2
-
-config FWU_NUM_IMAGES_PER_BANK
-	default 2
diff --git a/board/armltd/corstone1000/corstone1000.c b/board/armltd/corstone1000/corstone1000.c
index 01c80aaf9d..15de738154 100644
--- a/board/armltd/corstone1000/corstone1000.c
+++ b/board/armltd/corstone1000/corstone1000.c
@@ -109,7 +109,7 @@ void fwu_plat_get_bootidx(uint *boot_idx)
 	 */
 	ret = fwu_get_active_index(boot_idx);
 	if (ret < 0) {
-		*boot_idx = CONFIG_FWU_NUM_BANKS;
+		*boot_idx = 0;
 		log_err("corstone1000: failed to read active index\n");
 	}
 }
diff --git a/lib/fwu_updates/Kconfig b/lib/fwu_updates/Kconfig
index d35247d0e5..6bb94f88d3 100644
--- a/lib/fwu_updates/Kconfig
+++ b/lib/fwu_updates/Kconfig
@@ -12,17 +12,6 @@ menuconfig FWU_MULTI_BANK_UPDATE
 
 if FWU_MULTI_BANK_UPDATE
 
-config FWU_NUM_BANKS
-	int "Number of Banks defined by the platform"
-	help
-	  Define the number of banks of firmware images on a platform
-
-config FWU_NUM_IMAGES_PER_BANK
-	int "Number of firmware images per bank"
-	help
-	  Define the number of firmware images per bank. This value
-	  should be the same for all the banks.
-
 config FWU_TRIAL_STATE_CNT
 	int "Number of times system boots in Trial State"
 	default 3
-- 
2.34.1

