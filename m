Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2357FC27C75
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 17:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F5BD88864;
	Wed, 12 Jun 2024 19:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="hirrRlvz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B29898884B; Wed, 12 Jun 2024 18:17:02 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D8F588845
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718209020; x=1720801020;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HFu3GqAvxc4LuNa6r6ehMhxXekfovhhzBT7BUVIOkgw=;
 b=hirrRlvzmXWFK9OQHWT8XfkIFeCfQl1u1zXCS4rVAPXK9YUsxd5FsBZVkwOsPeNE
 P4gDt6XFHfLf16NxSePHcykNykgYnTqA9vVlmlrLe6X0y5cr/nusfmrbgVhtcMA8
 o9GuleV5BpwPyDAaCdLpjLHoLt6pH6qy3UWDBM3cK+Y=;
X-AuditID: ac14000a-03e52700000021bc-3c-6669c9fc20ce
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 78.3C.08636.CF9C9666;
 Wed, 12 Jun 2024 18:17:00 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 12 Jun
 2024 18:16:58 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <w.egorov@phytec.de>,
 <upstream@lists.phytec.de>
CC: Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 3/3] doc: board: phytec: phycore-am64: Fix phyBOARD Name
Date: Wed, 12 Jun 2024 09:16:39 -0700
Message-ID: <20240612161639.2660205-3-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240612161639.2660205-1-d.schultz@phytec.de>
References: <20240612161639.2660205-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWyRpKBR/fPycw0g8/d4hZTJ21mt3i7t5Pd
 ovudugOzx6sDq9g9zt7ZwejR393CGsAcxWWTkpqTWZZapG+XwJXxc80UpoIL7BXv325jaWA8
 yNbFyMkhIWAicfbqWcYuRi4OIYElTBKbX91nh3DuM0pMbdzICFLFJqAlcWfLXGYQW0QgReLS
 4xOsXYwcHMwCGhLtz5hAwsICHhKvFy5jBwmzCKhKrO8wAQnzClhJfLvVzwSxS15i5qXv7CA2
 p4C1xJO318DiQkA1l64uZoGoF5Q4OfMJmM0MVN+8dTYzhC0hcfDFC2aIegWJ2dsmM8LMnHbu
 NTOEHSpxZNNqpgmMQrOQjJqFZNQsJKMWMDKvYhTKzUzOTi3KzNYryKgsSU3WS0ndxAgKaBEG
 rh2MfXM8DjEycTAeYpTgYFYS4T0Tk54mxJuSWFmVWpQfX1Sak1p8iFGag0VJnHd1R3CqkEB6
 YklqdmpqQWoRTJaJg1OqgdFV7MSSPWUhKy2NrgQv/ahg/HNXiuksz5e2D/ZvrVK5a7pN+0q9
 VAzLXZ27/72Y9+w5eSbKd22A5dObqWHNS+6bnnKSL52w5GP9LrP3PA9OGs5f+sgk9tNKqUS3
 P7aTLB6/uj5tTtHqnnXHXz7P23U53rba9wZnd9TzzQdexTw91s+ud9W0UW6KEktxRqKhFnNR
 cSIA7YLeflYCAAA=
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

The Carrier-Board for the pyhCORE-AM64x is called phyBOARD-Electra.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 doc/board/phytec/phycore-am64x.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/phytec/phycore-am64x.rst b/doc/board/phytec/phycore-am64x.rst
index c99d8f6dd58..ad9f47d9dfd 100644
--- a/doc/board/phytec/phycore-am64x.rst
+++ b/doc/board/phytec/phycore-am64x.rst
@@ -9,7 +9,7 @@ SoM (System on Module) featuring TI's AM64x SoC. It can be used in combination
 with different carrier boards. This module can come with different sizes and
 models for DDR, eMMC, SPI NOR Flash and various SoCs from the AM64x family.
 
-A development Kit, called `phyBOARD-Lyra <https://www.phytec.com/product/phyboard-am64x>`_
+A development Kit, called `phyBOARD-Electra <https://www.phytec.com/product/phyboard-am64x>`_
 is used as a carrier board reference design around the AM64x SoM.
 
 Quickstart
-- 
2.25.1

