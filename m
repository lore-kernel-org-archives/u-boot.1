Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FB9C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2720688A52;
	Wed, 17 Jul 2024 16:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="Tn17NPxy";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="S0DGibZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 973BD88214; Wed, 17 Jul 2024 16:29:40 +0200 (CEST)
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com
 [103.168.172.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B14288A48
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id 8AF6D1380130;
 Wed, 17 Jul 2024 10:29:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 17 Jul 2024 10:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226577;
 x=1721312977; bh=hYta6hQC9jHyF8DVXaPhg0WZPqLZ3tlgFuTX9MK7Ih0=; b=
 Tn17NPxyd2TQ1u2QawFFvMyH3Q3ryrn0ra9OnAauP/4/3UZJYzjcpNA2+DIboVJH
 MZO0e36PX2rCEtImoAsgdNm+3tQZ0REmaHwYU+jthofDJ6FZME7OAA2BNJA9DiLv
 VoNMcf+uzKXJh6EeVevoCZwYzI6mHKvSuJkgZSHuPuUIVCFbV49RKkSfZTf3c5++
 h6j6JiMUo5wAXdQmd2PYF4d7dfo5QW3X4w3pQd3j8Wc+z+avqx0/Y5FNzRGW9rTR
 kPbZh3bntYmtF0z5UlCc76FryI0F1cQgeNPaNPWxEbjmUSELN5Bgft1CnzbgIdIf
 exco3ADbpwDJQoQ+6XBhxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226577; x=
 1721312977; bh=hYta6hQC9jHyF8DVXaPhg0WZPqLZ3tlgFuTX9MK7Ih0=; b=S
 0DGibZM2yew1iB9yARC779G0kjfqDPZP0bPvu3RiGzZbxYvOCgFOE+nibX8hWUib
 K2X5BXIOFFpVYu7cwzjp0rPf4cpyRmH42XGgx0X7B337Fvhv/NfeJA2VYpt+i2UX
 Kx3V2Axu8Mfc/yGtuYW/f6UL0yqh4ctscLlbXUNtKsGqVpGvV3A6MXugzA3qd/6i
 m2DUjPtc+Boo4LGdrGM9sdNz9K0iQzdZj4hr0lZ+oDYoa4D2H5Ho3V0yepdSoX1B
 u+fCfhr04W3lotDi5XebUDmN+LuS+uKnHm17pvKaMcQaJfw5ZqWOg7e1JnubjNZ5
 7gvz8d0TLPIVQAwH+q6Pg==
X-ME-Sender: <xms:UNWXZu91NBehspefCDQgg-JLBh4V80dzTXHMk2qTZwPLXbqw_h00CQ>
 <xme:UNWXZusMlUVJ1csVAWmQMqw5mdJ216bOmQqdCkDIBr8B0m13hxgoAX6Q-PgZbC461
 6E6FCQVAU3y_m1Ya3g>
X-ME-Received: <xmr:UNWXZkD6FTTggPcQa_tWlHSoBXATA3Y4W1j3VbSRiErAhSKLq6L9jLioUJ4PamhWsjaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
 geffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:UNWXZmd5FGRqYGQyNKudtgVwfKRk34Exo1PYxsEzW-h3zSs5f0YSog>
 <xmx:UNWXZjP_AXuYwGKwUa3EYBHleHYxPvkuMl7MPt2Whf5hDmiQUU2oNg>
 <xmx:UNWXZgkXDCkZ-g05CeiLme7HMYcgd9HUQRTwH7oD6b7kPhMRo0rCZQ>
 <xmx:UNWXZlt2wdORgROjPmEJDbbf92nJlv3GdBggg8QNbK4Ptm22TaTNdw>
 <xmx:UdWXZuen18GkL1QmcsiUUSL375WluiD9OlpDQFOfonMJfi6GKU7ou6Lc>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:29:33 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:13 +0800
Subject: [PATCH 02/18] py: Replace distutils.core with setuptools
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-2-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=yf5v5bj4MFaBdFKZskSIooFLH5wefSZA8mYYx0OixgM=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV11sZn578WhnUZVwp5NNSOIhN6Up1gxnYlerMxzsX
 tIr80Goo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACYiWMDIMPf56ynHW9I/MdaE
 2K8rybzFGB21Pmiv/5Q/jO5qCsYv+xn+51eIMD0MSuVkCOjKP/Bwxe+fGn7Xl4bXveJ5N42nq8m
 VBQA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

distutils is deprecated long ago and being removed in python 3.12.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 tools/binman/setup.py           | 2 +-
 tools/buildman/requirements.txt | 1 +
 tools/dtoc/setup.py             | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/binman/setup.py b/tools/binman/setup.py
index 9a9206eb044a..bec078a3d9b1 100644
--- a/tools/binman/setup.py
+++ b/tools/binman/setup.py
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-from distutils.core import setup
+from setuptools import setup
 setup(name='binman',
       version='1.0',
       license='GPL-2.0+',
diff --git a/tools/buildman/requirements.txt b/tools/buildman/requirements.txt
index 052d0ed5c6f7..0dadbf3fa2c5 100644
--- a/tools/buildman/requirements.txt
+++ b/tools/buildman/requirements.txt
@@ -3,3 +3,4 @@ jsonschema==4.17.3
 pycryptodome==3.20
 pyyaml==6.0
 yamllint==1.26.3
+setuptools==65.5.1
diff --git a/tools/dtoc/setup.py b/tools/dtoc/setup.py
index 5e092fe0872a..ae9ad043b013 100644
--- a/tools/dtoc/setup.py
+++ b/tools/dtoc/setup.py
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-from distutils.core import setup
+from setuptools import setup
 setup(name='dtoc',
       version='1.0',
       license='GPL-2.0+',

-- 
2.45.2

