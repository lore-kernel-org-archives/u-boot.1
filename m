Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B0FC54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 16:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB39581FEE;
	Mon,  2 Jun 2025 18:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YJLw52hF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3EF681FFC; Mon,  2 Jun 2025 18:56:34 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 113B381D6A
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 18:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 552GuTdP3281815;
 Mon, 2 Jun 2025 11:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748883389;
 bh=N4mSY6giGokzjCiAgKcPfq5MJrrOZmEVcTfdxjSp6vw=;
 h=From:Subject:Date:To:CC;
 b=YJLw52hF/F2Dxib9aadsEhG2SwAxSfB1fKvnerRa/9e/YiMYtUt418TE+45JaxR2S
 KOwjwyb9AMkMJHeqFOi+72tOZkwu3FO7UKOGUfYpk5respvaZXSMtsRziVtgo+RrJk
 RfNMvY/G0Qh/ZJ3VCMzlVe24HaSMEiDMwuDSTEZ8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 552GuTjr3104079
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 2 Jun 2025 11:56:29 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Jun 2025 11:56:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Jun 2025 11:56:28 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 552GuTSr3252355;
 Mon, 2 Jun 2025 11:56:29 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH tiU2025.01 0/2] binman: openssl: x509 entry cleanups
Date: Mon, 2 Jun 2025 11:56:25 -0500
Message-ID: <20250602-am62xsip-v1-0-ae8aa62b4b6e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALnXPWgC/x2MQQqAIBAAvyJ7ztAFo/pHp+hgttUeMtGIIPp71
 nFgZm5IFJkStOKGSCcn3n0GXQhwq/ULSZ4yAyo0SmMt7VbhlThIdGQaUhXqcYash0gzX/+qh4O
 7ryiVhuF5XrB2Qd5mAAAA
X-Change-ID: 20250128-am62xsip-2ce59e0621bf
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>, Bryan Brattlof
 <bb@ti.com>
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

Hello everyone,

While digging through binman a little I noticed a few x509 extensions 
that should probably need a little adjusting before the release.

Happy Hacking
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Bryan Brattlof (2):
      binman: openssl: remove unused encryption extension
      binman: openssl: disable JTAG access by default

 tools/binman/btool/openssl.py       | 23 ++++++++++++-----------
 tools/binman/etype/ti_secure.py     |  1 +
 tools/binman/etype/ti_secure_rom.py |  1 +
 tools/binman/etype/x509_cert.py     |  7 +++++--
 4 files changed, 19 insertions(+), 13 deletions(-)
---
base-commit: b22a276f039f818d5564bec6637071cfc8a7e432
change-id: 20250128-am62xsip-2ce59e0621bf

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

