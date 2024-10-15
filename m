Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E9CD18159
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 00:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A80A891AA;
	Tue, 15 Oct 2024 02:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="qUl3NGoB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF78B8880F; Tue, 15 Oct 2024 02:26:46 +0200 (CEST)
Received: from smtp-out.freemail.hu (fmfe37.freemail.hu [46.107.16.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E575891AA
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 02:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
Received: from localhost.localdomain
 (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.freemail.hu (Postfix) with ESMTPSA id 4XSFJx1HlxzVgP;
 Tue, 15 Oct 2024 02:26:41 +0200 (CEST)
From: egyszeregy@freemail.hu
To: u-boot@lists.denx.de
Cc: sbabic@denx.de, festevam@gmail.com, otavio@ossystems.com.br,
 Ray Chang <ray.chang@technexion.com>
Subject: [PATCH] pico-imx7d: increase ODT resistor value from 60 to 120 ohm to
 improve DRAM stability
Date: Tue, 15 Oct 2024 02:25:05 +0200
Message-ID: <20241015002505.1243-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1728952002; 
 s=20181004; d=freemail.hu;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 l=737; bh=MStZupqqDynwf7OzuAwOuZyk40BFxvMLFEZU2P39BHg=;
 b=qUl3NGoB5YhsEhPo6WPapKFKeTOrEceM+q4fQ3KF2hfGtLEl0keHUOw4Dd3Ag8Sm
 Xcy25270cb5anT3Tzf0JhI+31zsqp8cbCFXDr557cqv53oBhHxmR4luQrl6U6T4uHyq
 MaRjKTH+zRBa7BOZrP4g5toRXv2b4HiclPj3bsVu9R346uvGQw3UZIjQCEMggsbCKPc
 7Pmg6whqFv0oZWv2G2c0g+xcLdBX0/itrh5nSrUyVvvnzcnYR+vXBRUKtEAmdBEMrBT
 1cTsZd5xxB55aAvoqcFv61bRPiaHO0kYbWH851e6PZ9NHjaFmjfZEfUrYVVkyHauuQC
 VlFrayuX+w==
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

From: Ray Chang <ray.chang@technexion.com>

Signed-off-by: Ray Chang <ray.chang@technexion.com>
---
 board/technexion/pico-imx7d/spl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/board/technexion/pico-imx7d/spl.c b/board/technexion/pico-imx7d/spl.c
index cb60d3be42..fc97c58ae1 100644
--- a/board/technexion/pico-imx7d/spl.c
+++ b/board/technexion/pico-imx7d/spl.c
@@ -89,11 +89,11 @@ static struct ddr_phy ddr_phy_regs_val = {
 static struct mx7_calibration calib_param = {
 	.num_val	= 5,
 	.values		= {
-		0x0E407304,
-		0x0E447304,
-		0x0E447306,
-		0x0E447304,
-		0x0E447304,
+		0x0E207304,
+		0x0E247304,
+		0x0E247306,
+		0x0E247304,
+		0x0E207304,
 	},
 };
 
-- 
2.47.0.windows.1

