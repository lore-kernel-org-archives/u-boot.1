Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69376C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B12A3882FA;
	Wed, 17 Jul 2024 16:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="aYPz4jxL";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="RmL4n4Wc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92B8A88A44; Wed, 17 Jul 2024 16:29:36 +0200 (CEST)
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com
 [103.168.172.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C34B88214
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.nyi.internal (Postfix) with ESMTP id 7F904138014B;
 Wed, 17 Jul 2024 10:29:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 17 Jul 2024 10:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226573;
 x=1721312973; bh=MdJp58kcSgabVH0pcnioxjfkrFOAXa9QzSCQ45+lP8o=; b=
 aYPz4jxLPEej+MAb8NYWukPwfsou6Nqx3e9SLfYh5lyMAZnpJQ9+Bhsju2ISJdG/
 eiO1nQxAcNVebjt0/px1MmIVMnRZzwZanerQtYEE3UodIm17QbQlTjmRwp+tS6V8
 K0lkDS+3Et1h4PNrLR4vfMTqYuypxNXBno07upde2ntaFaJorJ7peklUVfv7nqY5
 TxfbIiu/FuYR91Lbjy/PE7S7Q0gl/iw5aQNI7IJhFlxoK19jnybO8qsLsNyKlB8R
 uXzFVQdxJE50RhIUIIRpxY/AuQvwQZHfpdxWMTqJMtziZSIS/3YLvgZ/k65wu+J9
 F2FKFOzss/GZznMAfqYd6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226573; x=
 1721312973; bh=MdJp58kcSgabVH0pcnioxjfkrFOAXa9QzSCQ45+lP8o=; b=R
 mL4n4Wc/rYyu5kJrEkX6w21XJ7Hx1BrxVI/3A9KlV7OKm2LZu5WbovpO3HBz8bpb
 PAVrDPjDJl88XLVKoPJ5YEcdWxS1b5ud1iZIDkEJTpFURegcwqoKz7zEWyUDNPeZ
 uEz9DYQ1dVlT2B6zSrjwsrbpMOvPeo4ug0nU33R/9AR6eQUxeVwdspBP3L1i4KB4
 pWnTmrPjmBrFkqPodJ0a6IGYHyLme0v8pgCSOgFL62P2ciDQKiYzb6l7q3LTLJ1s
 UsdGYG2H73xAJb+VFKfq+uI4gcphRTAvdSD52iOBiKYbYIxLrcqOMFGq2Mgmak7E
 A0kUEqmTCDDqWaotGWQIQ==
X-ME-Sender: <xms:TNWXZpQbVsVtJ0EtJsygZwQOy-v6rm9ACrE5FhjuhxMnefpy__hMvg>
 <xme:TNWXZizS1m7jhL8_E9Ory18znq6sjbp4YDzDdfgStpXyqxBbOno7ypwgCBf8Xeikg
 SUPYdrtRT4-bVLMSac>
X-ME-Received: <xmr:TNWXZu1cOxJr9keZv5UrmIsfKnm5xo8Qu9V_6kSisGoYPR9T3ABLklpBuXTFrFRb3JjC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpedvvefhtedvieetveduvedtudekkeetfeeiueehveeikeeludeh
 heevkeeuvefgueenucffohhmrghinheprhgvshhouhhrtggvshdrlhhinhhkpdhphihthh
 honhdrohhrghdpvghnughsfihithhhrdhphienucevlhhushhtvghrufhiiigvpedtnecu
 rfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrd
 gtohhm
X-ME-Proxy: <xmx:TNWXZhDrIo7AI6I10jixq4N0z9y4GiBNYZakPcxpdqNKb4ADw2VcMw>
 <xmx:TNWXZig6ErOZaK2bW28Dj0rHkEh83OFf22PzMoFC4dcwHfVMnaCLlg>
 <xmx:TNWXZlpPyWyLQSVWltKH_VRtInV_AJnMfIp4RWOepMRbj_9HeUrSBQ>
 <xmx:TNWXZtg2l9SIUDSyg5wFZlwYXFYrp8K50oRal6Zj02UAQMl4M9_a-w>
 <xmx:TdWXZmg_iYCNFvWRbDM7QgSPYHqRhvbrhYzmFoZdwUngbmkBvOmyQuoH>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:29:29 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:12 +0800
Subject: [PATCH 01/18] binman: Replace pkg_resources with importlib.resources
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-1-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2378;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=xU+ADKBclCMEX9qhp22Dfrx/2xVFQsKkARoJRqWdIZ4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV10SZoQkTQnjONbn1rmN46rjoxvBTJbt6VPmJz8xU
 /EpKNbrKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIlkaDH8M4o0+Pgp4Ktbkuyj
 r8rP9yeuPOn2YbXc79rdHfIm894c3sXIsPxGkCSbr4iHfUSFRqT8I1vdFXMurzrMc2i3fpYqt+w
 +RgA=
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

pkg_resources is deprecated long ago and being removed in python 3.12.

Reimplement functions with importlib.resources.

Link: https://docs.python.org/3/library/importlib.resources.html
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 tools/binman/control.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index 2f00279232b8..5549b0ad2185 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -8,12 +8,11 @@
 from collections import OrderedDict
 import glob
 try:
-    import importlib.resources
-except ImportError:  # pragma: no cover
+    from importlib import resources
+except ImportError:
     # for Python 3.6
-    import importlib_resources
+    import importlib_resources as resources
 import os
-import pkg_resources
 import re
 
 import sys
@@ -96,12 +95,12 @@ def _ReadMissingBlobHelp():
             msg = ''
         return tag, msg
 
-    my_data = pkg_resources.resource_string(__name__, 'missing-blob-help')
+    my_data = resources.files(__package__).joinpath('missing-blob-help').read_text()
     re_tag = re.compile('^([-a-z0-9]+):$')
     result = {}
     tag = None
     msg = ''
-    for line in my_data.decode('utf-8').splitlines():
+    for line in my_data.splitlines():
         if not line.startswith('#'):
             m_tag = re_tag.match(line)
             if m_tag:
@@ -151,8 +150,9 @@ def GetEntryModules(include_testing=True):
     Returns:
         Set of paths to entry class filenames
     """
-    glob_list = pkg_resources.resource_listdir(__name__, 'etype')
-    glob_list = [fname for fname in glob_list if fname.endswith('.py')]
+    directory = resources.files("binman.etype")
+    glob_list = [entry.name for entry in directory.iterdir()
+                 if entry.name.endswith('.py')]
     return set([os.path.splitext(os.path.basename(item))[0]
                 for item in glob_list
                 if include_testing or '_testing' not in item])
@@ -735,7 +735,7 @@ def Binman(args):
     global state
 
     if args.full_help:
-        with importlib.resources.path('binman', 'README.rst') as readme:
+        with resources.path('binman', 'README.rst') as readme:
             tools.print_full_help(str(readme))
         return 0
 

-- 
2.45.2

