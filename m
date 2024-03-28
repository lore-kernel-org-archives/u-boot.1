Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4D5CD11DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 20:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A0F988152;
	Thu, 28 Mar 2024 21:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TADOaofm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D222881AD; Thu, 28 Mar 2024 21:16:52 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B27C87C62
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 21:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 540983F2AE; 
 Thu, 28 Mar 2024 20:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711657009;
 bh=9FbRYcGRWLu2+pJLjXrybIKK8dBWFO8WXtpfRqw2BAE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=TADOaofmQxYgcNbGxwfET0S2dzFvT+FxXbB2QPyqZcuuEnvvkhsUMvHgxdVfsbUDu
 GPRiPmhR3x5V/C/mtpaOOpeKRfJY84hfRCqH/WBZYsIVknj2zjrj0Xm+gbgqu51uQ6
 VLr3hoQNEmhV6RHPgvyjDERofiHF9nS+whqC/JOcBEDXRPbOGj8mYaVSN8XfOcio/j
 hs3p4CM551Ovzw3crP9w7y9CSnIWLrxfrunvmu/iY+MXLGNfOjF/+QWm0+yjgVZgUF
 xke76LhlodiNNx5S2lcH/JeO0KQnefQiK3AC00Uex+JPzzf6HA93/KgRxqPmlxdvBX
 A247SPK6n5J8g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: missing :: in doc/usage/cmd/itest.rst
Date: Thu, 28 Mar 2024 21:16:54 +0100
Message-ID: <20240328201654.15148-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

Add :: for correct formatting of example.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/usage/cmd/itest.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/usage/cmd/itest.rst b/doc/usage/cmd/itest.rst
index ab933db760d..9c307fb4bf4 100644
--- a/doc/usage/cmd/itest.rst
+++ b/doc/usage/cmd/itest.rst
@@ -86,6 +86,8 @@ Numbers will be truncated according to the postfix before comparing:
 Postfix .s causes a string compare. The string '0xa1234' is alphabetically
 smaller than '0xb'.
 
+::
+
     => if itest.s 0xa1234 < 0xb; then echo true; else echo false; fi
     true
 
-- 
2.43.0

