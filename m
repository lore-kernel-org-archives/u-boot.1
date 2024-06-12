Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F271C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 17:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F05E8886D;
	Wed, 12 Jun 2024 19:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="B1vZbtCn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3338488845; Wed, 12 Jun 2024 18:17:03 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A76E8883F
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718209017; x=1720801017;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rE8mP/I/8549pTmvP+nwvEPYWrUTkvqCY+CwtXjRVUc=;
 b=B1vZbtCnM0MEAZ71xBJwFZRRQ9solL7LZYJZhwC3qJrUED1Tg5E+Dx2GtXDaVy28
 dJ9xUE5qoJoFhkZmqwfWE7uxivcIp1A6Hd3/W/rzm9wj3H0yOa9hWWtct/XcUuJs
 yB9it/a7dnavmVkuSVfiiG22UFPMvqz8NrwucuAL9YM=;
X-AuditID: ac14000a-03e52700000021bc-38-6669c9f9ea53
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E6.3C.08636.9F9C9666;
 Wed, 12 Jun 2024 18:16:57 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 12 Jun
 2024 18:16:55 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <w.egorov@phytec.de>,
 <upstream@lists.phytec.de>
CC: Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 2/3] doc: board: phytec: phycore-am64x: Fix Link to
 Documentation
Date: Wed, 12 Jun 2024 09:16:38 -0700
Message-ID: <20240612161639.2660205-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240612161639.2660205-1-d.schultz@phytec.de>
References: <20240612161639.2660205-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWyRpKBR/fnycw0g/f/JCymTtrMbvF2bye7
 Rfc7dQdmj1cHVrF7nL2zg9Gjv7uFNYA5issmJTUnsyy1SN8ugSuj61k7Y8Frtop/T1exNzD+
 ZO1i5OSQEDCRmH1yAnMXIxeHkMASJoldf2YygSSEBO4zSuzZ5gFiswloSdzZMpcZxBYRSJG4
 9PgEUDMHB7OAhkT7M7ByYYFAiUVtj8FKWARUJRZuPsAGYvMKWElc2f+PGWKXvMTMS9/ZQWxO
 AWuJJ2+vQa2ykrh0dTELRL2gxMmZT8BsZqD65q2zmSFsCYmDL14wQ9QrSMzeNpkRZua0c6+h
 5odKHNm0mmkCo9AsJKNmIRk1C8moBYzMqxiFcjOTs1OLMrP1CjIqS1KT9VJSNzGCAlqEgWsH
 Y98cj0OMTByMhxglOJiVRHjPxKSnCfGmJFZWpRblxxeV5qQWH2KU5mBREudd3RGcKiSQnliS
 mp2aWpBaBJNl4uCUamCcE8OitX2r+bEknljl7tQdD+X7pxVGGO6YtO6kTthrgd8++nXTlMtZ
 5r+7LH1lEuOX7Sn+LC+eyfxaU5388/rPKa0rXaq07dg5tgoHXEoTP/7zSXAsB5/CpXCflptt
 fQsmnzISOc5QPq/oltrZd61MKfGPPd2vrlkmbjnt9WO+o3m7bz5h40pQYinOSDTUYi4qTgQA
 DDxvclYCAAA=
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
 doc/board/phytec/phycore-am64x.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/phytec/phycore-am64x.rst b/doc/board/phytec/phycore-am64x.rst
index a27ad01027b..c99d8f6dd58 100644
--- a/doc/board/phytec/phycore-am64x.rst
+++ b/doc/board/phytec/phycore-am64x.rst
@@ -156,4 +156,4 @@ Further Information
 -------------------
 
 Please see :doc:`../ti/am64x_evm` chapter for further AM64 SoC related documentation
-and https://docs.phytec.com/phycore-am64x for vendor documentation.
+and https://docs.phytec.com/projects/yocto-phycore-am64x/en/latest/ for vendor documentation.
-- 
2.25.1

