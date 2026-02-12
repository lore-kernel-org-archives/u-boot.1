Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4683AEEA865
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 22:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4DA783CBD;
	Thu, 12 Feb 2026 23:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nwl.cc header.i=@nwl.cc header.b="KUWptprd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F215C802C1; Thu, 12 Feb 2026 23:36:10 +0100 (CET)
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 557B983A47
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 23:36:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=phil@nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
 s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/+5IHJ/R/9Q7SHYhRBGYk5GXJtQ4vO0eQdIfedJnufA=; b=KUWptprd/sAwSloMPjB9m4lBmf
 lFU8NhsKUZfJkKyGhKPL4Ch2D9I2hMCxPTSILARzVBbzoMs3FwSWbKYJq4+goVLMW475nxeJVWM6R
 9WbOvVgRTedrIETznfJHdoNGy0bF9vjYTkNAvIF1fS/eo0/eIxjT8HZb71/TwbhWK0rk8p84NkpXu
 Nk0mmcJVxhvzOlnkSK7e0Wa3FUnObW9TBidjPVYvEc03qb7dgSMgdT03TRIQ8vbCY2/whCeUf4GYH
 sjj4knICnIloaedX5esLm8D7R7uys983EaCu/ySXqRZOQ/1LwuSOMUeqrndFe14w2rCftDmsGblHA
 jeX6Lq/g==;
Authentication-Results: mail.nwl.cc; iprev=pass (localhost) smtp.remote-ip=::1
Received: from localhost ([::1] helo=base)
 by orbyte.nwl.cc with esmtp (Exim 4.98.2)
 (envelope-from <phil@nwl.cc>) id 1vqfI6-000000006kR-3tmn;
 Thu, 12 Feb 2026 23:36:07 +0100
From: Phil Sutter <phil@nwl.cc>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/2] board: Synology: legacy.c: Include asm/io.h
Date: Thu, 12 Feb 2026 23:31:09 +0100
Message-ID: <20260212223110.20267-2-phil@nwl.cc>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212223110.20267-1-phil@nwl.cc>
References: <20260212223110.20267-1-phil@nwl.cc>
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

Some boards building this source define CFG_SYS_TCLK as a term involving
readl() which is undefined otherwise.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 board/Synology/common/legacy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/Synology/common/legacy.c b/board/Synology/common/legacy.c
index 2e3aa660eaace..5b7d07bc2eef7 100644
--- a/board/Synology/common/legacy.c
+++ b/board/Synology/common/legacy.c
@@ -10,6 +10,7 @@
 #include <vsprintf.h>
 #include <env.h>
 #include <net.h>
+#include <asm/io.h>
 #include <asm/setup.h>
 
 #include "legacy.h"
-- 
2.52.0

