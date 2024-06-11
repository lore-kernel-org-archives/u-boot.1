Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCC6C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1622F88783;
	Tue, 11 Jun 2024 23:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="SWBK3iIU";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="WjTRJUnr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF148839F; Tue, 11 Jun 2024 23:04:30 +0200 (CEST)
Received: from wfout2-smtp.messagingengine.com
 (wfout2-smtp.messagingengine.com [64.147.123.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D7C088739
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfout.west.internal (Postfix) with ESMTP id 94C6D1C0008D;
 Tue, 11 Jun 2024 17:04:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 11 Jun 2024 17:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139866;
 x=1718226266; bh=c6WBYGV2x2DpAxqSXqGF9JybWF9TN0LcvdnIY3KS8Ec=; b=
 SWBK3iIUjNttZaa07JjbLEos2XZayBVDboqpf1iK+Q0n7cw9V0hKxZlLl1I41hue
 RYdUL+HNsLfVr/2WlhmXuRIcD5PiMxYdnTIzIpsSndtMZLGSKvbQ4ZYAHgZBPd+3
 tNibkyNyB4s/1siRn0B7s9SnW5xvTB4qjvmNaeKwv0iYKEEwzUeeOJiCmljA94Pm
 5tQ+NO/bN0giP1a+PHPXFztQfs5ZwlyspBvO+w4b5HE0i3HsraTpQMaD76z3N9us
 /n/vqd5EE3Cxb1XKF2AcbuPGDibIyVN7eJAgOCTw1M2+8ocfdQpl/TPRScMSbtRQ
 Oib1vF6roZ59WgHjq6HR6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139866; x=
 1718226266; bh=c6WBYGV2x2DpAxqSXqGF9JybWF9TN0LcvdnIY3KS8Ec=; b=W
 jTRJUnrRbR9I0CYjifQep3yVLEmWyJjx/ZE78LNvlTRbVI64iSr/hVdG20krnJlK
 chx0GDKHHxku+zu3vviIcv4A+GtairEZHM8tPImjZiPtgOu/c+DGTwrcn8qq23Mk
 sOJNUgSWzPlj9nk+kmJNpP1tigvst70kHG8fWG6PEUNeRiNhjDzistwkzluuJCp2
 RzcY8eFOk/qVWlj1s87Jf6ISOYFfo6DhUH1u7nMsBHJSOMvx5JGqpdKteGYjtp0y
 kt+JJSxvv/sk/vXvnfO9VdPoCnIeLjY6L8dJl4psFUcMnItgAqGpOK055S93V/c/
 rqk3SdfxoI7AO3BxsQmWA==
X-ME-Sender: <xms:2rtoZlx0uj63dXGSReCUZyyE1UaZJmwcTIfWhMc_Rw8xmR8MOSEwWA>
 <xme:2rtoZlRPtI5tJFx6J_ZQW9o2vHuF-Gz7g3XGzd4FyxzkTm2k9kAxn8yte_sOKYvlw
 wfyCb7eU0RU8b9IfeI>
X-ME-Received: <xmr:2rtoZvWW27IsxTK8BIzjkLH-P1I8b-nGJvXsBOncp2prQNDSUnvMYVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:2rtoZnjQ3lVtjCJFb03qnzCmMtiSx9VQlmeB2rwOSm5ZQph0MbLarw>
 <xmx:2rtoZnBXDjrMRre-YGbgXdh9XmK9fErcoRjPn3DYM7azO9gYYde1yw>
 <xmx:2rtoZgJ30NaVJg4VeqHrucslxQ2Ojfk33JfY4upEpCzGD97GEgtj-Q>
 <xmx:2rtoZmAJJKaIY5BrSwMpYEJeV89T_-eMiD9vib-E447mAZvqA6bG0Q>
 <xmx:2rtoZr0mop8RMUBU3b1PrH4jzkTCMiFC1mk4vUJkeNdII4I2QjHgc5iV>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:24 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:04 +0100
Subject: [PATCH 05/20] doc/sphinx: Remove usage of six
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-5-51472eb70357@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=925;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=USCIZG1dPiKaNKiXpiL5cXS13xLsZrtCZRbrkG/smJY=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3Wd/rQnhvbhkzZ3NLOyxe/pXHk+X5Jk8K4+xq4jl4
 apFa+vsOkpZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAi2h2MDEucDnhv3DA9qcl1
 RoHv5/L3rlo1yhMyJYRnOKl1HJ3Tt56R4QeXgmDzLd8yl5j7vc4WP21PvQhkKDqutOVWQ94cNSd
 GHgA=
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

We don't support python2 any more so there is no point to
use six here.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 doc/sphinx/kfigure.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/doc/sphinx/kfigure.py b/doc/sphinx/kfigure.py
index dea7f91ef5ab..9467e8d52ac0 100644
--- a/doc/sphinx/kfigure.py
+++ b/doc/sphinx/kfigure.py
@@ -58,7 +58,6 @@ from docutils.parsers.rst.directives import images
 import sphinx
 
 from sphinx.util.nodes import clean_astext
-from six import iteritems
 
 import kernellog
 
@@ -540,7 +539,7 @@ def add_kernel_figure_to_std_domain(app, doctree):
     docname = app.env.docname
     labels = std.data["labels"]
 
-    for name, explicit in iteritems(doctree.nametypes):
+    for name, explicit in doctree.nametypes.items():
         if not explicit:
             continue
         labelid = doctree.nameids[name]

-- 
2.43.0

