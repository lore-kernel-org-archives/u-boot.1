Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B60C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 17:42:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9B4088859;
	Wed, 12 Jun 2024 19:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="jkUnqW7j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3CC288845; Wed, 12 Jun 2024 18:16:56 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5126D8883F
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718209013; x=1720801013;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TAgrjX0OFsKeFh/vmHw+m8Wfk9tkJQyjWtfkyooA3Wk=;
 b=jkUnqW7jGur5LC0cNfQw0vtgCoBwRDqtJ8FL8J9MgT0r3BpL73KxR9SCMtRMY82R
 ujYZQlYhU4+Mid40wGRhqyEoX+98+Yiyp9DFXHjDnuR4avP/IC3LS0HRsu5uNJCw
 sXU9CN/vMQmvZiWMaBTQjw0JstUryBNJVEJ9T6wU+Kc=;
X-AuditID: ac14000a-03251700000021bc-35-6669c9f51503
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 75.3C.08636.5F9C9666;
 Wed, 12 Jun 2024 18:16:53 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 12 Jun
 2024 18:16:52 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <w.egorov@phytec.de>,
 <upstream@lists.phytec.de>
CC: Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 1/3] doc: board: phytec: phycore-am62x: Fix Link to
 Documentation
Date: Wed, 12 Jun 2024 09:16:37 -0700
Message-ID: <20240612161639.2660205-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWyRpKBR/frycw0g9/nLCymTtrMbvF2bye7
 Rfc7dQdmj1cHVrF7nL2zg9Gjv7uFNYA5issmJTUnsyy1SN8ugSvj7fRX7AWv2CqWXN3D3sD4
 g7WLkYNDQsBE4sQ6mS5GLg4hgSVMEhMPzmfvYuQEcu4zSuxZ6gtiswloSdzZMpcZxBYRSJG4
 9PgEWC+zgIZE+zMmkLCwQKDE+Z2fWUBsFgFViQ19U8HKeQWsJM58mQM2UkJAXmLmpe/sEHFB
 iZMzn4DVMwPFm7fOZoawJSQOvnjBDHGCgsTsbZMZYXqnnXvNDGGHShzZtJppAqPALCSjZiEZ
 NQvJqAWMzKsYhXIzk7NTizKz9QoyKktSk/VSUjcxgsJThIFrB2PfHI9DjEwcjIcYJTiYlUR4
 z8SkpwnxpiRWVqUW5ccXleakFh9ilOZgURLnXd0RnCokkJ5YkpqdmlqQWgSTZeLglGpgDFuR
 e+RxMINFdq9Ka5PMhb83L21dWur40rRHWK6+f1NMSl3K7g0eizYFmMUeYV48WflwLYNwIY9V
 +UW5HWrrJs5RYe9leJCgLX3u5G/ZxoAJv/dO17GSW/Tpavma0r7Q63OnKa7Oqv2QtE7+9d0p
 Tw6J7gu6reJizph8dav9l813RQ7mnd9lqcRSnJFoqMVcVJwIAABb6sc9AgAA
X-Mailman-Approved-At: Wed, 12 Jun 2024 19:41:46 +0200
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

We moved our documentation to another hoster and therefore the URL
changed. Point to the latest documentation instead of release versions
to not link out-dated documentation.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 doc/board/phytec/phycore-am62x.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
index bc6d5246694..681ac536125 100644
--- a/doc/board/phytec/phycore-am62x.rst
+++ b/doc/board/phytec/phycore-am62x.rst
@@ -155,4 +155,4 @@ Further Information
 -------------------
 
 Please see :doc:`../ti/am62x_sk` chapter for further AM62 SoC related documentation
-and https://docs.phytec.com/phycore-am62x for vendor documentation.
+and https://docs.phytec.com/projects/yocto-phycore-am62x/en/latest/ for vendor documentation.
-- 
2.25.1

