Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838C5C47077
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 13:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3F5187852;
	Sun, 14 Jan 2024 14:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="l+Wm0HDa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D9E08795D; Sun, 14 Jan 2024 14:55:43 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8385D87849
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 14:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CCFC6416D2; 
 Sun, 14 Jan 2024 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705240541;
 bh=o8O61cdQZeS7BXHBXi5cYKSVWEKDtIpaurz7QuxXqFc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=l+Wm0HDavaLbal71qlw3WSA8HiVISZTonwlONS9YKcsjFV4fKc2s6zXv+ibU+1myU
 JLObh6wamS1xXuMe4P6TlpC3X2AxwSiqLfQz1m1HQhSLQ5sErGVfhWlVShZ/V1bSAn
 sbr4ARUnYT3gBi2HeuEg7D05tPrwluzjp48VoEC/GnacaZgYymR2PoQULbIQDeey4s
 CF5BbKDplEaW2ACBm0XJJQfItF3CL7Cz+aZ/Jx05k3bn6ZOI7CBH7OEwn/3jihyQoT
 IfYG3VfNQ/7xpXB7cpO4NDXxcuGSwubKDiGCi7KNK6yBEGHCPqhO1VGWMApn/W7RHU
 GDy65DBrL2WWQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] doc: add generated index to table of contents
Date: Sun, 14 Jan 2024 14:55:39 +0100
Message-ID: <20240114135539.72195-1-heinrich.schuchardt@canonical.com>
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

Show the index in the navigation sidebar.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/index.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/index.rst b/doc/index.rst
index 57b42c68e4..43398627d8 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -99,4 +99,7 @@ Chromium OS-specific doc
 Indices and tables
 ==================
 
-* :ref:`genindex`
+.. toctree::
+   :maxdepth: 1
+
+   genindex
-- 
2.43.0

