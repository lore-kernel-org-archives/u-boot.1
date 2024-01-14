Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C249C47077
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 13:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD8418785F;
	Sun, 14 Jan 2024 14:18:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="osf8LP70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAC6B87941; Sun, 14 Jan 2024 14:18:42 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49DCE87873
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 14:18:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 893AF41BBB; 
 Sun, 14 Jan 2024 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705238318;
 bh=UQq88ZLLuWRRDJ18qWzG3+IKHeSNdUZ2+PVT51vOSyI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=osf8LP70ebUNet4Frr/2KYWt7JoZxQBs9uf1Mo1GRplQyPr0a8dED4+NJqFs4jhkH
 6OySIQaq8lIQYq2MNdy4zfn3js72Zrd9qztL7vRAzRLZu/CnSWZ0MuV5nf34/lNcBE
 Hf11hZIusP5pDTa7r36ml5ckC71DE1E1hY5sh1+Nv6pjYe0qeLvBXFAUERd/1HeoGt
 MvKA1z6P1cAriiXAmHldvWGy26+CHvxyDO+MKd+v3dFSrEFHQoPzgzKHcs6CuOC5iK
 FCt6SkhQ4LkEGRKxb2pbTqRXO0f1BHp25dVGfaoGoYRQsxdHZLy6BPpUdS6D68Ookj
 86dfawcjMg71Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Nishanth Menon <nm@ti.com>, Jonathan Corbet <corbet@lwn.net>,
 Oliver Faso <erer1243@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Akira Yokosawa <akiyks@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/5] docs/sphinx: Explicitly convert Sphinx paths to str
Date: Sun, 14 Jan 2024 14:18:19 +0100
Message-ID: <20240114131824.68298-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114131824.68298-1-heinrich.schuchardt@canonical.com>
References: <20240114131824.68298-1-heinrich.schuchardt@canonical.com>
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

From: Oliver Faso <erer1243@gmail.com>

Sphinx 7.2+ is switching to using pathlib.Path
instead of str to represent paths. This fixes the
current deprecation warnings and eventual breakage.
This conversion will be a no-op when using older
Sphinx versions.

Signed-off-by: Oliver Faso <erer1243@gmail.com>
Tested-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Link: https://lore.kernel.org/r/20230910040811.53046-1-erer1243@gmail.com
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/sphinx/kerneldoc.py | 2 +-
 doc/sphinx/kfigure.py   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/sphinx/kerneldoc.py b/doc/sphinx/kerneldoc.py
index 8189c33b9d..01a55429c5 100644
--- a/doc/sphinx/kerneldoc.py
+++ b/doc/sphinx/kerneldoc.py
@@ -138,7 +138,7 @@ class KernelDocDirective(Directive):
                     lineoffset = int(match.group(1)) - 1
                     # we must eat our comments since the upset the markup
                 else:
-                    doc = env.srcdir + "/" + env.docname + ":" + str(self.lineno)
+                    doc = str(env.srcdir) + "/" + env.docname + ":" + str(self.lineno)
                     result.append(line, doc + ": " + filename, lineoffset)
                     lineoffset += 1
 
diff --git a/doc/sphinx/kfigure.py b/doc/sphinx/kfigure.py
index 788704886e..dea7f91ef5 100644
--- a/doc/sphinx/kfigure.py
+++ b/doc/sphinx/kfigure.py
@@ -266,7 +266,7 @@ def convert_image(img_node, translator, src_fname=None):
     if dst_fname:
         # the builder needs not to copy one more time, so pop it if exists.
         translator.builder.images.pop(img_node['uri'], None)
-        _name = dst_fname[len(translator.builder.outdir) + 1:]
+        _name = dst_fname[len(str(translator.builder.outdir)) + 1:]
 
         if isNewer(dst_fname, src_fname):
             kernellog.verbose(app,
-- 
2.43.0

