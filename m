Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6599DC54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 161C88136E;
	Tue, 28 Jul 2026 12:59:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8jTXgBcxJbBj; Tue, 28 Jul 2026 12:59:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F2401812BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243588;
	bh=LsogNogadp+8TjhpaeKXnuwRBzsVx04rehLhUTIBuws=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gKZ08FhPnrGk4ybMre7Xo+DeS/HrlSsaG/0PpyRB14vFXmJhvABEQFK+Bl0WpHFy+
	 LDWu55VxENsKT6jmakA2sAnUe6FPjt6Ea/LSH9/R7b2sxYpUhBwpgjtsKGsN/w+i1X
	 eq3NTqyBmLCO7LxVHi1+LseVjdQdBgH+P8U7PdWiYy/MXLGs2ipWBAvVnsGPMHiG3M
	 CzlgWSuur/sp8ZXgVY67d3op2Xo/1Uzt8Fo/0uulZES7jeR5Pz/mN16DdoUNy7axZK
	 rPu54OLz9enpYNYXoAja9IrJsDlowX2BlvwimhF6JbdSbYSn8xj5SpFwu74dT1kSF8
	 Ej9WWD9cP5Iyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2401812BA;
	Tue, 28 Jul 2026 12:59:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F6253B0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E2B14085F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:03:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4xqqn_iAPbjK for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:03:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=qijian.guo@nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 80CD240862
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80CD240862
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 80CD240862
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:03:54 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0EED84873; Tue, 28 Jul 2026 08:03:52 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A57982991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 08:03:51 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A8504200162;
 Tue, 28 Jul 2026 08:03:50 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6F46A20015B;
 Tue, 28 Jul 2026 08:03:50 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 90EA518000B1;
 Tue, 28 Jul 2026 14:03:48 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marex@nabladev.com>, Fedor Ross <fedor.ross@ifm.com>,
 u-boot@lists.denx.de (open list)
Cc: Joseph Guo <qijian.guo@nxp.com>
Subject: [PATCH] imx: scmi: suppress invalid origin/errid in reset reason print
Date: Tue, 28 Jul 2026 15:03:14 +0900
Message-Id: <20260728060314.3560643-1-qijian.guo@nxp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=nxp.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=nxp.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none)
 header.from=nxp.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=qijian.guo@nxp.com
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Only print origin and errid fields when the corresponding valid bits
(MISC_BOOT_FLAG_ORG_VLD and MISC_BOOT_FLAG_ERR_VLD) are set. For a
normal power-on reset, these fields are not valid, and printing -1
is just noise.

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 52 ++++++++++++++-----------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 18d00355999f..ade7a99f0584 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -692,22 +692,20 @@ int get_reset_reason(bool sys, bool lm)
 		}
 
 		if (out.bootflags & MISC_BOOT_FLAG_VLD) {
-			printf("SYS Boot reason: %s, origin: %ld, errid: %ld\n",
-			       rst[out.bootflags & MISC_BOOT_FLAG_REASON],
-			       out.bootflags & MISC_BOOT_FLAG_ORG_VLD ?
-			       FIELD_GET(MISC_BOOT_FLAG_ORIGIN, out.bootflags) : -1,
-			       out.bootflags & MISC_BOOT_FLAG_ERR_VLD ?
-			       FIELD_GET(MISC_BOOT_FLAG_ERR_ID, out.bootflags) : -1
-			       );
+			printf("SYS Boot reason: %s", rst[out.bootflags & MISC_BOOT_FLAG_REASON]);
+			if (out.bootflags & MISC_BOOT_FLAG_ORG_VLD)
+				printf(", origin: %ld", FIELD_GET(MISC_BOOT_FLAG_ORIGIN, out.bootflags));
+			if (out.bootflags & MISC_BOOT_FLAG_ERR_VLD)
+				printf(", errid: %ld", FIELD_GET(MISC_BOOT_FLAG_ERR_ID, out.bootflags));
+			puts("\n");
 		}
 		if (out.shutdownflags & MISC_SHUTDOWN_FLAG_VLD) {
-			printf("SYS shutdown reason: %s, origin: %ld, errid: %ld\n",
-			       rst[out.shutdownflags & MISC_SHUTDOWN_FLAG_REASON],
-			       out.shutdownflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
-			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.shutdownflags) : -1,
-			       out.shutdownflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?
-			       FIELD_GET(MISC_SHUTDOWN_FLAG_ERR_ID, out.shutdownflags) : -1
-			       );
+			printf("SYS shutdown reason: %s", rst[out.shutdownflags & MISC_SHUTDOWN_FLAG_REASON]);
+			if (out.shutdownflags & MISC_SHUTDOWN_FLAG_ORG_VLD)
+				printf(", origin: %ld", FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.shutdownflags));
+			if (out.shutdownflags & MISC_SHUTDOWN_FLAG_ERR_VLD)
+				printf(", errid: %ld", FIELD_GET(MISC_SHUTDOWN_FLAG_ERR_ID, out.shutdownflags));
+			puts("\n");
 		}
 	}
 
@@ -722,23 +720,21 @@ int get_reset_reason(bool sys, bool lm)
 		}
 
 		if (out.bootflags & MISC_BOOT_FLAG_VLD) {
-			printf("LM Boot reason: %s, origin: %ld, errid: %ld\n",
-			       rst[out.bootflags & MISC_BOOT_FLAG_REASON],
-			       out.bootflags & MISC_BOOT_FLAG_ORG_VLD ?
-			       FIELD_GET(MISC_BOOT_FLAG_ORIGIN, out.bootflags) : -1,
-			       out.bootflags & MISC_BOOT_FLAG_ERR_VLD ?
-			       FIELD_GET(MISC_BOOT_FLAG_ERR_ID, out.bootflags) : -1
-			       );
+			printf("LM Boot reason: %s", rst[out.bootflags & MISC_BOOT_FLAG_REASON]);
+			if (out.bootflags & MISC_BOOT_FLAG_ORG_VLD)
+				printf(", origin: %ld", FIELD_GET(MISC_BOOT_FLAG_ORIGIN, out.bootflags));
+			if (out.bootflags & MISC_BOOT_FLAG_ERR_VLD)
+				printf(", errid: %ld", FIELD_GET(MISC_BOOT_FLAG_ERR_ID, out.bootflags));
+			puts("\n");
 		}
 
 		if (out.shutdownflags & MISC_SHUTDOWN_FLAG_VLD) {
-			printf("LM shutdown reason: %s, origin: %ld, errid: %ld\n",
-			       rst[out.shutdownflags & MISC_SHUTDOWN_FLAG_REASON],
-			       out.shutdownflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
-			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.shutdownflags) : -1,
-			       out.shutdownflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?
-			       FIELD_GET(MISC_SHUTDOWN_FLAG_ERR_ID, out.shutdownflags) : -1
-			       );
+			printf("LM shutdown reason: %s", rst[out.shutdownflags & MISC_SHUTDOWN_FLAG_REASON]);
+			if (out.shutdownflags & MISC_SHUTDOWN_FLAG_ORG_VLD)
+				printf(", origin: %ld", FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.shutdownflags));
+			if (out.shutdownflags & MISC_SHUTDOWN_FLAG_ERR_VLD)
+				printf(", errid: %ld", FIELD_GET(MISC_SHUTDOWN_FLAG_ERR_ID, out.shutdownflags));
+			puts("\n");
 		}
 	}
 
-- 
2.34.1

