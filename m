Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FFFC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 21:23:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D333088BC4;
	Fri, 19 Jul 2024 23:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="a4z5XaWQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7695588BC4; Fri, 19 Jul 2024 23:23:38 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11BE388BAE
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 23:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-093-080.um16.pools.vodafone-ip.de
 [62.143.93.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id AB49A3F325; 
 Fri, 19 Jul 2024 21:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1721424213;
 bh=pR/F3GKqP2weBbCn8QQxuP3jdN253VppKXtHcswvFgA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=a4z5XaWQ+TnlFdlsD7RsBjeT0+FhSxL8Tm7g+3F5N2+VvwI+owCH48nLjcdBT4i0R
 NYLoIcafHXVcGAF6xxQzYWUndrfSQhMOTYPA9ZkXZPPi9Q7l1s32Kk22/N3A0tzqLC
 AQ4KZJhVzPdTQX7QiwctZQtjw30rL8E32T+lLqwmjgL1Wmj+vs49ZRIUhJLHHhwEBU
 Ti1lB/+4HNrkGOQWeEyBK642hdKO4KoSiRxNzDBKQcV38k4N7xJQqhgl237Ap2dw17
 tICNTvnl/KeWaer7YTTbrrdQ+ppOsAUdT31CLxdG00PzPOX1X42vw5MEhQz5EtG3Sp
 Ajbd75VIfgksQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: define html_context in conf.py
Date: Fri, 19 Jul 2024 23:23:26 +0200
Message-ID: <20240719212326.42901-1-heinrich.schuchardt@canonical.com>
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

The dictionary html_context is not passed into conf.py but must be created
there. See
https://dev.readthedocs.io/en/latest/design/theme-context.html#customizing-the-context

Fixes: df86796028df ("doc: enable ReadTheDocs addon management")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/conf.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/conf.py b/doc/conf.py
index e79134cc3d7..ced3a6723fc 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -26,7 +26,9 @@ html_baseurl = os.environ.get("READTHEDOCS_CANONICAL_URL", "")
 
 # Tell Jinja2 templates the build is running on Read the Docs
 if os.environ.get("READTHEDOCS", "") == "True":
-    html_context["READTHEDOCS"] = True
+    html_context = {
+        'READTHEDOCS' : True,
+    }
 
 # If extensions (or modules to document with autodoc) are in another directory,
 # add these directories to sys.path here. If the directory is relative to the
-- 
2.45.2

