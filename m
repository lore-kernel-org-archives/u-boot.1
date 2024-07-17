Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C68EC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 885FB88A4D;
	Wed, 17 Jul 2024 16:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="DtLW5vCr";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="U5OwWrB6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6307F88A5D; Wed, 17 Jul 2024 16:29:45 +0200 (CEST)
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com
 [103.168.172.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7160B88214
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 8290213800EA;
 Wed, 17 Jul 2024 10:29:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Wed, 17 Jul 2024 10:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226582;
 x=1721312982; bh=slE+MZxZCc8tdebvkREDo1CqIMsZp2osne5GmFToM/g=; b=
 DtLW5vCrG8dRtIdOyJg79Jh77DDmKCzpcxBE9R9VM8pgZDUvmEy0kTqAsdvxa6sE
 hOvHoJeJIbx43cqJi24ju69KnQQu6veiVYp+nwJKFYGUVNoZfA0M2hJ982dVG4Ac
 NlNgHPvqEH4NiD/OLLG7QIxPom+yqoBSrpOb/FqISLzj6qShGk9KTSpR0C/wlj9Y
 dWa86zufxmYFLV4MWHyJAH4jY60iN8Et4KYbu/HW4/Pfr8fY5KAA79eUx3QDCz3u
 Xo0Dog7xBr1IMYmcH79OQSbM2/leE7Viy/0Sx5G/g0NttbVKV2b9puWXFNvbN0bO
 ISEuxdUL72uf7lpODzO4JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226582; x=
 1721312982; bh=slE+MZxZCc8tdebvkREDo1CqIMsZp2osne5GmFToM/g=; b=U
 5OwWrB6CT9CThg23PWdwkF7cCm2Z8JfKwc46ojoOvmpR+qjp+IXrgTQ6UFuLZflM
 Kik+kDvNfg71Nda7WnKSU2lFkO9ERQiROXupDKgJdfK+sJetXs7T1rgJ3iZGR4jj
 DrFgVtB3f8jGkuG36rxi42ILqDDCGXX5ArJQtIxAG7bMmaKFS7PMJdNAdAYjoGHU
 Nnx859lX1pke05d6tcWXkJk1sCkptx4oa0ej9i66cJuPQ6xV+CXbRPjJxdz88IUV
 qAWMi9xl5CosRiEo3PbuHBnu6p+dr0zhrac1E4Ve8eLQv3MutgZ2+2DA1xVMAFX5
 +cGzCl7UNUlPQ6YWH6Yfw==
X-ME-Sender: <xms:VdWXZu6TI16vCOFq1cxMdj0lTUmDzG9jSWW0F_QGOr0WCCxIs0kTXQ>
 <xme:VdWXZn7saxcM2tyR4HAaSU94Oi1eNMvKCzR7AEeCTCs7jpBUj0Bbe_AO9s89fOv6_
 oLK3VnocYJbuI_aGlA>
X-ME-Received: <xmr:VdWXZtc99S4uQGm6VwozkyRC-ZssBreZ9rlMldjLxLUFjBytBXNPVwWITSCOY4J7CU2h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
 geffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:VdWXZrLqEQ31P7r9_xgZ4Nrl23IG7224R2veK6tc5WFsMQ7tEtVsuA>
 <xmx:VdWXZiKe2J1I0rziCONv7SrI3VYWTN5GMPqtt2mgg69_1r7YTIbx6g>
 <xmx:VdWXZsx8jJfg9HGsVak63KqvGITNNWg724vsLnx0FNs_7I_shPz_Ag>
 <xmx:VdWXZmL8nSUeW2BKRCwvpl9sUkp-8Ivt24FAx3OBZcPhMOiINs4Obg>
 <xmx:VtWXZjqSwSUMzWQ7OFUyyRgHKMc3Kjp02naqS4ETE53dKucex0fIxvZ6>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:29:37 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:14 +0800
Subject: [PATCH 03/18] doc/sphinx: Remove usage of six
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-3-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=925;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=P9mfK62UxHoLxWgMieWXNSw1LzRd23RTfUaZ7REe1zk=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV120ZT1DAnpdw085t7mY/hM7JOV6fqKYaPZlqQscr
 MIfZuV1lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwET+LGf4H25gFFghZu80Q0Le
 U2OiLt/RoPzvJ54rVZmVxYbEZ3wzYfgfZsx0cPXSlA0qK5YJ+BwOcFvGJX5V51LK5e31auETZI8
 yAQA=
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
2.45.2

