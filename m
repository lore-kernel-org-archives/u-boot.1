Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73350C71141
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 18:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C468382C2F;
	Wed, 11 Jun 2025 20:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uNTP84pY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC16E82C30; Wed, 11 Jun 2025 20:17:43 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5489782B20
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 20:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55BIHcJi2689845;
 Wed, 11 Jun 2025 13:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749665858;
 bh=4nh0nwc1k/vfWCFP6OhVEZDR9IdnXb0ru5NMQd9UacE=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=uNTP84pYip0FKI8KKcB3r0sBaQEaZzThjzX60g353Lr2AaGogzyeSs803dXSAU2+L
 ehntOHl6N9RR8eGVImQ5jNX8n6lUqkjHC7yeR8l6ip9eedIc6Z50mW0oZdWWvu2Sgv
 OpWmiLJc1vOTf1oq7Obn9lYvc3qS0LO0kmIxOIVA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55BIHcWX1323479
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 11 Jun 2025 13:17:38 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 11
 Jun 2025 13:17:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 11 Jun 2025 13:17:38 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55BIHcue901678;
 Wed, 11 Jun 2025 13:17:38 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 11 Jun 2025 13:17:36 -0500
Subject: [PATCH -next 5/5] binmain: include ti-fs-enc.bin into
 missing-blob-help
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250611-missing-blob-help-entries-v1-5-c6de1844117f@ti.com>
References: <20250611-missing-blob-help-entries-v1-0-c6de1844117f@ti.com>
In-Reply-To: <20250611-missing-blob-help-entries-v1-0-c6de1844117f@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
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

Now that the TIFS firmware is marked as a mandatory component to a
successful build, provide some helpful descriptions to what it is and
links to more information about how to get this needed firmware.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 tools/binman/missing-blob-help | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-help
index fcc989ed757e0d0a8d5bc8238c3d013da98aa390..d6f2de23735f987f9f5e2529b33df111440cc01b 100644
--- a/tools/binman/missing-blob-help
+++ b/tools/binman/missing-blob-help
@@ -61,6 +61,17 @@ the DM firmware binary and how to include it in the build.
 
     https://docs.u-boot.org/en/latest/board/ti/k3.html
 
+ti-fs-enc.bin:
+You are missing TI's Foundational Security (TIFS) firmware which is
+critical to provide foundational security services like authenticated boot,
+and firewall management for the SoC. Your board will not boot without
+this firmware.
+
+Have a look at your board's documentation to find the latest version of the
+TIFS firmware binary and how to include them in the build.
+
+    https://docs.u-boot.org/en/latest/board/ti/k3.html
+
 sysfw-inner-cert:
 You are missing the inner certificate for TI's Foundational Security (TIFS)
 firmware which is critical to authenticating the TIFS firmware during boot.

-- 
2.49.0

