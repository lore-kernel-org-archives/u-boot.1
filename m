Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285E9C369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 17:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 323FE8395F;
	Wed,  9 Apr 2025 19:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vskM+CVW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D37B83957; Wed,  9 Apr 2025 19:26:41 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3DB58394A
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 19:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 539HQaQ31594207
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Apr 2025 12:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744219596;
 bh=XyB3Uil+KumyQjjc6Ly3nN/bal8wKfjX0AaOU1UuM64=;
 h=From:Date:Subject:To:CC;
 b=vskM+CVWKYyTZQ6n+UyXWrKupdUGFKdzWUbcVCWIimMkOtdUuhbc2mkodjS5kNQsS
 91SRWQKO5fyVkm0hTWJbtnZqEIilKShi+P2hNFpSkCnVkjsUlKnaK8LaLjVRdWaLwp
 QG8YEAwouIDxHj9JUgMgZpPSV+J8T3p3eYj/TWOk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 539HQZQK001192
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 9 Apr 2025 12:26:35 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Apr 2025 12:26:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Apr 2025 12:26:35 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 539HQZP6020983;
 Wed, 9 Apr 2025 12:26:35 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 9 Apr 2025 12:26:20 -0500
Subject: [PATCH] mips: octeon: remove unused middle expression
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250409-octeon-middle-expressions-v1-1-fd6248e6975d@ti.com>
X-B4-Tracking: v=1; b=H4sIALut9mcC/x2MQQqEMBAEvyJzdiCKQdevLB7UtDrgJktGRBD/b
 vRYFFUnKaJAqc1OithFJfgERZ7RuPR+BotLTKUpranMh8O4IXj+iXMrGMc/Qp9I2Q2VGTBZWzc
 9pT6ZSY73/e2u6wbPCki5awAAAA==
To: Aaron Williams <awilliams@marvell.com>, Daniel Schwierzeck
 <daniel.schwierzeck@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

!A || (A && B) is equivalent to !A || B

Drop the unused middle expression to simplify the statement.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/mips/mach-octeon/cvmx-helper-board.c | 3 +--
 arch/mips/mach-octeon/cvmx-helper.c       | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mach-octeon/cvmx-helper-board.c b/arch/mips/mach-octeon/cvmx-helper-board.c
index 6dcc4e557e12f..8d9388983b79c 100644
--- a/arch/mips/mach-octeon/cvmx-helper-board.c
+++ b/arch/mips/mach-octeon/cvmx-helper-board.c
@@ -386,8 +386,7 @@ cvmx_helper_link_info_t __cvmx_helper_board_link_get_from_dt(int ipd_port)
 		/* If the link is down or the link is up but we still register
 		 * the module as being absent, re-check mod_abs.
 		 */
-		if (!result.s.link_up ||
-		    (result.s.link_up && sfp_info->last_mod_abs))
+		if (!result.s.link_up || sfp_info->last_mod_abs)
 			__cvmx_helper_update_sfp(ipd_port, sfp_info, result);
 		sfp_info = sfp_info->next_iface_sfp;
 	}
diff --git a/arch/mips/mach-octeon/cvmx-helper.c b/arch/mips/mach-octeon/cvmx-helper.c
index ccec57edf844d..7dcaa1ac8d990 100644
--- a/arch/mips/mach-octeon/cvmx-helper.c
+++ b/arch/mips/mach-octeon/cvmx-helper.c
@@ -1729,7 +1729,7 @@ cvmx_helper_link_info_t cvmx_helper_link_get(int xipd_port)
 		sfp_info = cvmx_helper_cfg_get_sfp_info(xiface, index);
 
 		while (sfp_info) {
-			if ((!result.s.link_up || (result.s.link_up && sfp_info->last_mod_abs)))
+			if (!result.s.link_up || sfp_info->last_mod_abs)
 				cvmx_sfp_check_mod_abs(sfp_info, sfp_info->mod_abs_data);
 			sfp_info = sfp_info->next_iface_sfp;
 		}

---
base-commit: 9d9fbdab0e9664bff147109cc89ad2786f6ecd83
change-id: 20250409-octeon-middle-expressions-db40bef5578a

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

