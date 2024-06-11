Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E7DC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6CFF887B4;
	Tue, 11 Jun 2024 23:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="dre19TZY";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="QJutOvtq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA72188783; Tue, 11 Jun 2024 23:04:23 +0200 (CEST)
Received: from wfhigh4-smtp.messagingengine.com
 (wfhigh4-smtp.messagingengine.com [64.147.123.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 087E38878D
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.west.internal (Postfix) with ESMTP id 01D0A1800146;
 Tue, 11 Jun 2024 17:04:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 11 Jun 2024 17:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139858;
 x=1718226258; bh=0mpfvnxjRh3xcBdu+SBSwiKUOdt5jcUI85gUXgaXBWs=; b=
 dre19TZYfSGRnFrWigtI3efGrgbEzGl3A2dpamR9gKi7r4qYw5Vt1PZA7WfJl7fH
 Kpfs2H0igy+rXI2F74O440FFpZl8Es8TwvrRCaeFh4gIB65fT2+GFC2zGt/+PpQk
 ItjlOI31T1dUaqXeVx9cPc8hJnGCwog1rmjd4e6wMIk5qY9Pqe/9qa3TM0qByGJa
 fCZwExaE209QRg3sAmV/o1+zeQOlq1SlV3hp2sGLw1NThR0MgR9yJRk6JMBnFgW2
 SmzSEIcJu3lWO4BiBk25MakryYucUmQPJANb/ghQ1byEfQFXO/XCWaoTrY1305MH
 X6jEbI3oVXqytlqVcsvt+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139858; x=
 1718226258; bh=0mpfvnxjRh3xcBdu+SBSwiKUOdt5jcUI85gUXgaXBWs=; b=Q
 JutOvtqlQv5OyM5fe/fv9O+lNq6Tz+cjrEf0RzdspFtfX7ET9+GbnWqKthKirKMc
 Nrs+s8pGOxs4CUdv54MMYXfWeLcSK47z2b9tlw38lREE6vjD2a3oOPI1toti/wAu
 iUrfl0zFsDd42tqblIJRkR72AGa+kOx5MBg6wgL5kDywCc0he8NAXJTXbJTr5JdZ
 sb9fy91FUd3Z6hoQnHZQLac4TP8PE7wfG9KHaWHMcSEKbQrxgf/lGBRc6KqvzZva
 31pBcfyVvDN6jwKxfFI83zRMIoLfiaVCNNoWbsb9xVDYmnxOQLK1cY4BM6LNdhQe
 G4Pa4zu0xNfaG4wN3iJcw==
X-ME-Sender: <xms:0rtoZqkyWZtLVO45w2PiblSX_Fd64dh5Ktt0mFuf9Az-M7w2u_DTZg>
 <xme:0rtoZh2EQNI5dhJRZfqppNVGZfxTyE6yEItIIhYUpukiyHOJ0EUy2QL8bXkR_fWed
 an4ihjQDJsn7iC12nk>
X-ME-Received: <xmr:0rtoZoqmRmT_1evVn8p3y-r_TNvmecJNnY3p40anSpNSX9GxrdqGW0M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvvefhtedvieetveduvedtudekkeetfeeiueehveeikeel
 udehheevkeeuvefgueenucffohhmrghinheprhgvshhouhhrtggvshdrlhhinhhkpdhphi
 hthhhonhdrohhrghdpvghnughsfihithhhrdhphienucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorg
 htrdgtohhm
X-ME-Proxy: <xmx:0rtoZulQ0KO6Fn1S_FA0y4y1wd2lug0OptGaRXwNBWtCkKk5CDZH7A>
 <xmx:0rtoZo2Nc8m4bIWxYRz3VSVgv95xOU_hZ07gXCS-iu9a8tMdSRu5fw>
 <xmx:0rtoZluPQtxeUQT7MAXk_EOqoe2m5r5YJUHyKyokJBqI4qDgxEHETw>
 <xmx:0rtoZkVdpBlxENzxVRPZC--iDjIsbZdrF5zTu6goYSJQbDPQYP-wuw>
 <xmx:0rtoZpJFdHEzB6X2s9hFWvm-86zrUuPFr0QoC8LE_2S5cweNfOtcLhUW>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:17 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:01 +0100
Subject: [PATCH 02/20] binman: Replace pkg_resources with importlib.resources
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-2-51472eb70357@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2378;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=F5I/KiJSft1EkDmGGgS+GaYoO06q6hZPU2blN9ZZ6/M=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3WedQ9T0VmVbHNAPXrdoHcMq63CpM/NkWaZOW5Idt
 NHp+bYFHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRUx8Y/jsqbpx0xTp1YfjP
 J0ccfifd/LPhp//CpW+Lk3jbT4u+9F/NyPD4s4Pucr+rz/5bXWK1dBM+e/ETA+M68aj7TwtDRLk
 51vECAA==
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
2.43.0

