Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA92C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50C4588781;
	Tue, 11 Jun 2024 23:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="guhhIU95";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="m/Q4IvnR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2707887C3; Tue, 11 Jun 2024 23:04:25 +0200 (CEST)
Received: from wfout2-smtp.messagingengine.com
 (wfout2-smtp.messagingengine.com [64.147.123.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F605887A8
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.west.internal (Postfix) with ESMTP id 7AE831C0007C;
 Tue, 11 Jun 2024 17:04:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 11 Jun 2024 17:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139861;
 x=1718226261; bh=08p0/+7kU9g75J/UHtgIwfneZWRiYgBRa1beVDM8fcs=; b=
 guhhIU95IORmixwI7odSn/5U+OP7WVPCpeBn7XEom4Yd9ay8uz915SFu2J04Fhgi
 iuqazZDU9zgs0YzbdtoOEkg7zX+0VVzXZ0mJSsIU41WRdlGFoGZAcI+6jFR5xVNo
 veRg58TNoIHPnb0RIt6OEhpj0Dfjtk38YXQ1sdLbKDBgZfO+O4RqZUWO+ceCXFlA
 K3Ze3vQfymuLf42NLNbXkLHGne+kdQDGqsOQnB4DCAi9cJn6WVJIECaLL7Lis86M
 lArz8+fwOCktyA/bg0a6jdOYoRY1V3+Xu+r1PETBNRvs2llVrUwt8M+TF7R2A/g/
 rXSSLaEdS5a0NjGoIwAPeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139861; x=
 1718226261; bh=08p0/+7kU9g75J/UHtgIwfneZWRiYgBRa1beVDM8fcs=; b=m
 /Q4IvnR1X4A+gS/Uz/Avn3OJ9+Rw169tfxGl08MS1ZHRHAOO+b93KQUczHWWpTdt
 f+xKRbxHjcHPSz9nKfYyHTA2srHUNpp5JKviwBWZE1XQX/YgueRrEwJTcvZl11RR
 z53emmIVtR3XRrloi9RGykblc4waNygAYQ/6dEtMKd4owdOd8WQM/r6bCcoqu0QT
 uNRNXhQIDYuuERgux3fpt7cK9tUwNpSxbjIs1+a2407XxdY8+YbWF9wbR1CxyBm4
 9ofWxnBTNFoChzN6+IAuUKffOKhq1OaakddYZF0O78/tI7sWSPLtfBIt0892Gu3+
 umzqD7lIegkJdlRZ4mjOw==
X-ME-Sender: <xms:1LtoZrPVFP3ktzVNnXlkBCzbio6hVzn6_2pdWv_TXTPGQXKpraL83A>
 <xme:1LtoZl_r1_z3CCfNKWGeC3f_Xb_cNmllSOFDItvvwm9MKQErzeWj8lbk3KtTttBwM
 4xbFxVIvfO886fWUUc>
X-ME-Received: <xmr:1LtoZqTpWvoZqqKEBbQNtJU8WbUhuwHXPYJC1GbXEfCeeV6E2FOj8_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:1LtoZvs-siahcdAtB2v19827uGIiADXsfoad-VShoOtQ3xciXeFJBQ>
 <xmx:1LtoZjcXIpTzzfde2qHjuaWfrqEfQMQYgjkU_IK4shUU8ikXmqZ-wg>
 <xmx:1LtoZr3o-Ux5MwjtyVpEMOtFoqe9nAsim7oQdMmhNocSjiMt1c_bBQ>
 <xmx:1LtoZv93WzSnvgDSbtLkn1UjhIGuWyzcfUBKOqQPMJHHQP1ETFIN1g>
 <xmx:1btoZiyD59zIWmNlKtXcQfrx8REohoYBL7ky5kekuB6mZUaBxyW3gThR>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:19 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:02 +0100
Subject: [PATCH 03/20] py: Replace distutils.core with setuptools
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-3-51472eb70357@flygoat.com>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
In-Reply-To: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aaron Williams <awilliams@marvell.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1314;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=noUNPPjbYOlGgrp6xwyqF6eKiELRLGjDK/0QfXadKsY=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3WeXh1i057rvrLxSERNrz6zgu6k9RnDrGc3Xe+15/
 JRC5Es6SlkYxLgYZMUUWUIElPo2NF5ccP1B1h+YOaxMIEMYuDgFYCI3zjIyLHDcUOWQl3Jx95zp
 C4qWPZug6N3u1Km/vDrB8uG2kHUfpRn+e85I5z6S/GanTuarBz8F3254Wn923/OkLXe+lGceffR
 8JQ8A
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
index 4a31e69e4cb5..350da42c0ebf 100644
--- a/tools/buildman/requirements.txt
+++ b/tools/buildman/requirements.txt
@@ -1,3 +1,4 @@
 jsonschema==4.17.3
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
2.43.0

