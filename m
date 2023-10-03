Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABB3E784A8
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 04:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FC3886E15;
	Tue,  3 Oct 2023 06:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2331286E1F; Tue,  3 Oct 2023 06:17:48 +0200 (CEST)
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
 by phobos.denx.de (Postfix) with ESMTP id E1B3686DCA
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 06:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kuanlim.lee@starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
 by ex01.ufhost.com (Postfix) with ESMTP id 4A16624E1CE
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 12:17:42 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 3 Oct
 2023 12:17:42 +0800
Received: from localhost.localdomain (115.135.197.53) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42;
 Tue, 3 Oct 2023 12:17:38 +0800
From: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
To: <u-boot@lists.denx.de>
CC: <cheehong.ang@starfivetech.com>, <weiliang.lim@starfivetech.com>, "Kuan
 Lim Lee" <kuanlim.lee@starfivetech.com>
Subject: [PATCH] spl: mmc: Resolve emmc not load image after switched hw
 partition
Date: Tue, 3 Oct 2023 12:16:49 +0800
Message-ID: <20231003041720.893-1-kuanlim.lee@starfivetech.com>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [115.135.197.53]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable
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

When selecting MMCSD_MODE_EMMCBOOT as boot_mode, emmc do not load U-boot=20
proper image after switched hardware partition.

Signed-off-by: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
Reviewed-by: Chee Hong Ang <cheehong.ang@starfivetech.com>
Reviewed-by: Wei Liang Lim <weiliang.lim@starfivetech.com>
---
 common/spl/spl_mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 20f687e138..dc8a45222b 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -447,6 +447,9 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 #endif
 			return err;
 		}
+		err =3D mmc_load_image_raw_sector(spl_image, bootdev, mmc, 0);
+		if (!err)
+			return err;
 		/* Fall through */
 	case MMCSD_MODE_RAW:
 		debug("spl: mmc boot mode: raw\n");
--=20
2.34.1

