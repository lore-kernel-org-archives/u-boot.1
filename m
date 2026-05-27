Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD47DCD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 09:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91AE7847C4;
	Wed, 27 May 2026 11:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="c2MtjQdi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74BC383FF5; Wed, 27 May 2026 11:52:31 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A03846AC
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 11:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=oOk5ArZ+wDSA0qTR1UIcIH8Tj/tJwt8fnkEzbR6y+hU=; b=c2MtjQdi++fNa27Z3FyFo5Aj/t
 t1ZYZBNjH9B6di/zC3e8repaSI6+gMIywqBFOfKEFMg9j9sedcGYMb/DfyzG9j7Fu8fd0r8Cdh+Eq
 twkAooOQuvCM7UT2stE2Uj3PSwwABVsm71O3qWY+635I3BuYm/UTfmLqG2qDoV497CINAxjgLhm+H
 SM1sJrYAlNxS+lTQGbX+fWCJ5gw0an3imDuM9Um3E/jza6fm/iZvXiDbp+Z0v5N/433OfJBRIl1fK
 ebzJJxlndG+m543rD413J1Ohr8cFVJys+J7H/bRsZhxumcAk8jwqf1/nq2eENgDuoSGMF1btk4Yxn
 ErvhjPBw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wSAw6-0002TX-2W; Wed, 27 May 2026 11:52:26 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wSAw5-000JXI-2q; Wed, 27 May 2026 11:52:26 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3 7/7] boards: tqma7: call tq-sysinfo setup
Date: Wed, 27 May 2026 11:51:23 +0200
Message-Id: <20260527095123.50797-8-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
References: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Probe TQ sysinfo drivers to print device info from eeprom during boot.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 board/tq/tqma7/tqma7.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/tq/tqma7/tqma7.c b/board/tq/tqma7/tqma7.c
index 30bd155713d..a584d01dcf7 100644
--- a/board/tq/tqma7/tqma7.c
+++ b/board/tq/tqma7/tqma7.c
@@ -17,6 +17,7 @@
 
 #include "../common/tq_bb.h"
 #include "../common/tq_som.h"
+#include "../common/tq_sysinfo.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -65,6 +66,8 @@ int board_late_init(void)
 
 	env_set_runtime("board_name", bname);
 
+	tq_common_sysinfo_setup();
+
 	return tq_bb_board_late_init();
 }
 
-- 
2.34.1

