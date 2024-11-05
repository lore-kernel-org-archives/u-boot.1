Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F4ED1CA15
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 02:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0898688ECC;
	Tue,  5 Nov 2024 03:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vNoVYQmS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0D2C88F0C; Tue,  5 Nov 2024 03:17:50 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC1188E96
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 03:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A822E4027C; 
 Tue,  5 Nov 2024 02:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730773067;
 bh=22aB6xofktZ07lYvKpKI0VkE2Jbg130q3RYBg+uUd+E=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=vNoVYQmSAb3N3imu+oVgzkrgxsOd12SjoxP7kytojGjP4zc9j0p7D0SKfxrrcTSlA
 9hATuHy6IJAnN1UzPJnJuQcdCnBR80P4vI6u6hQDzK5Ihk3cEL0Tip49aHQaXd2+Fc
 zIDRkvhWks2aKoVd5kHXDJtBvdLqdZwrzcnWiwOaIexTWV5J+Qw8fR7xNee7DIsTpl
 E05vioqtMbQ2i/H5ybYyxX4Cnk41sm1ObrjudS0rbjljoBdQU8jYdvxZ7beAHpne+C
 q2U54S8/W2ZV9WdH+QaRDCm05MVB4Hxo3SHcdkMOldI40fM9Pc9SctJIbSUJmjHnfP
 RlGVJcLF58eGw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: conf.py: correct title and author of generated pdf
Date: Tue,  5 Nov 2024 03:17:41 +0100
Message-ID: <20241105021741.15615-1-heinrich.schuchardt@canonical.com>
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

Adjust the PDF output options for rst2pdf:

* Set start document to 'index'.
* Set title to 'Das U-Boot'.
* Set author to 'The U-Boot development community'.

Correct documentation link.

Remove obsolete FIXME.

Link: https://rst2pdf.org/static/manual.html
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/conf.py | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index ced3a6723fc..c50daf874a5 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -560,13 +560,9 @@ epub_exclude_files = ['search.html']
 # Grouping the document tree into PDF files. List of tuples
 # (source start file, target name, title, author, options).
 #
-# See the Sphinx chapter of https://ralsina.me/static/manual.pdf
-#
-# FIXME: Do not add the index file here; the result will be too big. Adding
-# multiple PDF files here actually tries to get the cross-referencing right
-# *between* PDF files.
+# See https://rst2pdf.org/static/manual.html#sphinx
 pdf_documents = [
-    ('uboot-documentation', u'U-Boot', u'U-Boot', u'J. Random Bozo'),
+    ('index', u'U-Boot', u'Das U-Boot', u'The U-Boot development community'),
 ]
 
 # kernel-doc extension configuration for running Sphinx directly (e.g. by Read
-- 
2.45.2

