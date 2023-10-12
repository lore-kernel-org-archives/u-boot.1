Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFFBCDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 23:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4401E86EE4;
	Fri, 13 Oct 2023 01:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="e9AMddj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B852586D17; Fri, 13 Oct 2023 01:08:53 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C91BE86E8F
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39CN6JQF008152;
 Thu, 12 Oct 2023 18:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697151979;
 bh=C6xBLAv0F03A9z8B2jdwOYMbQbY1RTn0A38fwpDdIBI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=e9AMddj26AYoDSyLAqmEQlJDdmIeFm7unxkQJnX3JANouhdZQAPzyopUelN7kaIPH
 zUsRPRHnasjXq8ZbkYyJiM11qMHI/KYTZmGN+P+bJhGzW1ku62oj24AKTf9wJwJqqe
 EkjXTAuNOvbXit8iW300lPYircC/C54FyFpx4mg4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39CN6JAd020821
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Oct 2023 18:06:19 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 18:06:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 18:06:18 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39CN6JtB032227;
 Thu, 12 Oct 2023 18:06:19 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 07/11] firmware: ti_sci_static_data: add static DMA channel
 data
Date: Thu, 12 Oct 2023 18:06:24 -0500
Message-ID: <20231012230616.2101992-20-bb@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012230616.2101992-13-bb@ti.com>
References: <20231012230616.2101992-13-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=bb@ti.com;
 h=from:subject; bh=qjbIUbAVrQweVDtADKmXho5J4c5aj1lj9yMsr8bDN5Q=;
 b=owNCWmg5MUFZJlNZD1fIjgAAZn///7brR23zrHHeIXl+d1z79/W7f7d73lvTz3y/zp7rz/+wA
 RswHaRoBiA0ZNqAD1AaAADQABpoBoaANBk0ZAbUDTQPRMQANGNQaGAn6TUQAMmmmjTQaZDIA0yY
 jRoyZDTIAekGnqMQzSBpggxND1NAyADIZAyAGBMgHJpp6ENDIBpoNGTTQAYmT1NDJk0YjAEBhAA
 AAAaBo000xDEYmQ0GQZNMDh20nbjwDeGABLyugMqJKxoxCa0PgiGc2MMyALtyFQ5Gr4cJuCR3kC
 O1ehb5aa6OImmnQJWXThXX6cdN8jT65IG4tBVhGcNVrK04pBvQwwQN++lqvURB8jwsjVIvXYzjD
 KtnvqbSZqxnFkwumPEHWMcRIB/yNQJwXIAXtog9uZNMVKRc7+1jNXgJli4UMxFMvZcNuJ0/SYck
 5WntqWAeMqFKYL2DNVNWwGkSI7kSqJpevY9w/g48YRB/HWvu5roEadfI3BZqlA3FAObT+rtmZBa
 tC6s2VQjrXWsiCOrW0/hALyg6milolob+HrwDa2Yno1IZP/I+ImObAbT6K4qLRbti3DnFzzo5yi
 0BRJ+9AQjzmEfRgU4ygDh5CzHpQBOYIZQRJE5aDahnqKxINI77jIJEVkhfhOkBUISp3q1W7PyCz
 /F3JFOFCQD1fIjg
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

From: Hari Nagalla <hnagalla@ti.com>

Include the static DMA channel data for ti_sci

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/firmware/ti_sci_static_data.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/ti_sci_static_data.h b/drivers/firmware/ti_sci_static_data.h
index 1a461fab6199b..a9d77315b713b 100644
--- a/drivers/firmware/ti_sci_static_data.h
+++ b/drivers/firmware/ti_sci_static_data.h
@@ -84,7 +84,8 @@ static struct ti_sci_resource_static_data rm_static_data[] = {
 };
 #endif /* CONFIG_SOC_K3_J721S2 */
 
-#if IS_ENABLED(CONFIG_SOC_K3_AM625) || IS_ENABLED(CONFIG_SOC_K3_AM62A7)
+#if IS_ENABLED(CONFIG_SOC_K3_AM625) || IS_ENABLED(CONFIG_SOC_K3_AM62A7) || \
+	IS_ENABLED(CONFIG_SOC_K3_AM62P5)
 static struct ti_sci_resource_static_data rm_static_data[] = {
 	/* BC channels */
 	{
@@ -95,7 +96,7 @@ static struct ti_sci_resource_static_data rm_static_data[] = {
 	},
 	{ },
 };
-#endif /* CONFIG_SOC_K3_AM625 || CONFIG_SOC_K3_AM62A7 */
+#endif /* CONFIG_SOC_K3_AM625 || CONFIG_SOC_K3_AM62A7 || CONFIG_SOC_K3_AM62P5 */
 
 #else
 static struct ti_sci_resource_static_data rm_static_data[] = {
-- 
2.42.0

