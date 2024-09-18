Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CFBCDD55C
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 21:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAD7788FDA;
	Wed, 18 Sep 2024 23:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="K6yedjSn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3173088FDC; Wed, 18 Sep 2024 23:49:45 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3118688FC7
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 23:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-110-162.46.114.pool.telefonica.de
 [46.114.110.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8582A3F298; 
 Wed, 18 Sep 2024 21:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726696182;
 bh=FnCAvIFXDo2lKVAIIAfG+Mn40uZZe1fkxtshy+0eoBU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=K6yedjSnAx6ql5f9o/8P9nibq15kTr8YfCXOXvRU+15g2pvTwcP0ECzJMakruXi+m
 7zgmlTcrvAfbrJ6CvRIBOiFXaE/CtJ/oM5S4SQiAjYlu4mZu44hoGG9C2SuFMfDWlH
 7PPpv9yvM+HWNTeS6OajLi7igt68asQI/t1kqYvRWRNAljQepNL/NGfHtnkrMJZ6q+
 inN/2gAvAPGtIV6j+k019B2kNNZiiajAac8uJUCAf3T7oxoi+bTw1J+bmlQiDronAD
 QqUQFiIK6jAH4Z27wc0rqH6m5z4aYa4OshK3SPbIV5vcQ/Ehv+gVDU654YyGS2QRKA
 FazuE90tJY0Mw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: include/getopt.h: remove comments confusing Sphinx
Date: Wed, 18 Sep 2024 23:49:40 +0200
Message-ID: <20240918214940.20854-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

The Sphinx documentation build process cannot handle the interspersed
'private:' and 'public:' comments. Remove them.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/getopt.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/getopt.h b/include/getopt.h
index 8645082da2a..0cf7ee84d6f 100644
--- a/include/getopt.h
+++ b/include/getopt.h
@@ -20,11 +20,9 @@ struct getopt_state {
 	 * parsed all of @argv, then @index will equal @argc.
 	 */
 	int index;
-	/* private: */
 	/** @arg_index: Index within the current argument */
 	int arg_index;
 	union {
-		/* public: */
 		/**
 		 * @opt: Option being parsed when an error occurs. @opt is only
 		 * valid when getopt() returns ``?`` or ``:``.
@@ -35,7 +33,6 @@ struct getopt_state {
 		 * is only valid when getopt() returns an option character.
 		 */
 		char *arg;
-	/* private: */
 	};
 };
 
-- 
2.45.2

