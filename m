Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709CCCA0EE8
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 04:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AB22832DA;
	Wed, 17 Sep 2025 06:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wXox9BrD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0AED832F9; Wed, 17 Sep 2025 06:17:37 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D1B4800B6
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 06:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58H4HXgB1521760;
 Tue, 16 Sep 2025 23:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758082653;
 bh=J+elVy/y5W82W/69RvIFkIaPNLmMDFtZMK04BelNYKg=;
 h=From:To:CC:Subject:Date;
 b=wXox9BrDd/btWWtpnPdaJhyRxcmCFteqlDKlZ8jcOxaa7G1cgKPaOH0DAeVH81o/j
 HNIf7dSq6t7KvgyUoAwhP/fOrZrC3CllL2WQdnBzdmMO/EI9pfx0glMXE844N38VFZ
 nquokkQcCEC9v0fO0RNQkcIORidXIsRUzZeT+3yA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58H4HXrG479619
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 16 Sep 2025 23:17:33 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 23:17:33 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 23:17:33 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.237])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58H4HU7v2688480;
 Tue, 16 Sep 2025 23:17:31 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>
CC: <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>,
 <a-dutta@ti.com>
Subject: [PATCH v2] board: ti: am57xx: Remove "ti/omap/" from name_fit_config
Date: Wed, 17 Sep 2025 09:47:29 +0530
Message-ID: <20250917041729.3460570-1-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Commit 649f4a7d3ca7 ("board: ti: am57xx: Set fdtfile from C code
instead of findfdt script") prepends "ti/omap/" to the actual name
of the fdtfile whereas fit image boot needs exact dtb name. So, remove
"ti/omap" from name_fit_config by substituting it with an empty string.

Fixes: 649f4a7d3ca7 ("board: ti: am57xx: Set fdtfile from C code instead of findfdt script")
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---

logs : https://gist.github.com/anuragdutta731/d7ba9314fa6d7a71bc348911b515615e

Changelog: v2:
1. Removed semicolon from the end of cmd.

Link to v1:
https://lore.kernel.org/all/20250916080800.3357438-1-a-dutta@ti.com/

 board/ti/am57xx/am57xx.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/ti/am57xx/am57xx.env b/board/ti/am57xx/am57xx.env
index 7d029a3e859..a7cbbced099 100644
--- a/board/ti/am57xx/am57xx.env
+++ b/board/ti/am57xx/am57xx.env
@@ -10,7 +10,7 @@ get_name_kern=
 	else
 		setenv bootfile zImage;
 	fi
-get_fit_config=setenv name_fit_config ${fdtfile}
+get_fit_config=setexpr name_fit_config gsub "ti/omap/" "" ${fdtfile}
 console=ttyS2,115200n8
 fdtfile=undefined
 finduuid=part uuid mmc 0:2 uuid
-- 
2.34.1

