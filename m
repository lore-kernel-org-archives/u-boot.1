Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1670C71141
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 18:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA7E882C7D;
	Wed, 11 Jun 2025 20:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hHr6a0tf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E498A82B0F; Wed, 11 Jun 2025 20:17:45 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BE5382B7C
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 20:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55BIHc7m1451923;
 Wed, 11 Jun 2025 13:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749665859;
 bh=slIPK92CgqGh9KCRnnQrubeQUG0CIq4H6i8iSZkl4YI=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=hHr6a0tf46XBvH1N092kxyjiiyjiy8ZLRn+NsEPVfrF4NLsNQmqSKHLfD34lmWdrJ
 B8KhjYXMJKRoSrfgmlA4DUPGKtvCLGkiwO/zRufAPKQw5IQ6ZKMkTgns6947qu9bxK
 WtDOvdV9QcRb9F2pUz3eeOYCVpxOOKPxbh635Yj4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55BIHcoA1931618
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 11 Jun 2025 13:17:38 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Jun 2025 13:17:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Jun 2025 13:17:38 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55BIHc2G731488;
 Wed, 11 Jun 2025 13:17:38 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 11 Jun 2025 13:17:33 -0500
Subject: [PATCH -next 2/5] binman: add ti-dm entry to missing-blob-help
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250611-missing-blob-help-entries-v1-2-c6de1844117f@ti.com>
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

Now that ti-dm is marked as a mandatory component for a successful
build, adding some helping text about how to resolve a failed build will
be needed. Add some text around what ti-dm is and links to more
documentation on how to obtain the firmware binaries

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 tools/binman/missing-blob-help | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-help
index b73b16f18491c2b45300ee4734d0f57eebb5635b..e28eaa2015443f256a469df4ead87793e23ba219 100644
--- a/tools/binman/missing-blob-help
+++ b/tools/binman/missing-blob-help
@@ -50,3 +50,13 @@ Please read the section on SCP firmware in board/sunxi/README.sunxi64
 tee-os:
 See the documentation for your board. You may need to build Open Portable
 Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
+
+ti-dm:
+You are missing TI's Device Management (DM) firmware which is critical to
+provide resource and power management services for your board. Your board
+will not boot without this firmware.
+
+Have a look at your board's documentation to find the latest version of
+the DM firmware binary and how to include it in the build.
+
+    https://docs.u-boot.org/en/latest/board/ti/k3.html

-- 
2.49.0

