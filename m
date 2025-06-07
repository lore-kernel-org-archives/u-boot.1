Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44350C61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 11:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A85F80E9A;
	Sat,  7 Jun 2025 13:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LQeuAMxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B62881F0D; Sat,  7 Jun 2025 13:32:26 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34809807B1
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 13:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-175-200.46.114.pool.telefonica.de
 [46.114.175.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 791893F716; 
 Sat,  7 Jun 2025 11:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749295943;
 bh=G8LJMYdXQHp4EvftFQYzCkspIZeSlmSzlC8HoXWa39w=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=LQeuAMxCb2p/vmzNCGzHDvb5cV66IET3Jcce4m+aWFotXBIzQ1OAFO857uPXi83yo
 GUphIyrVcgWpuiv5AJhTaKXJ3BYLZ8hbnDhuYJ7EhY+LFe0KL4RWS1DbCSnLiC/o6s
 tJsuzSoLjK3h8tWTXkUm+qkEodc+k3en1ayQiwCv0okK+/+C8IKZrX/SW91LRzPoga
 fh+IV2xc+D8BBuzV2b2N80+4lid0/B8V6jDzlr25wsRjGaNiXBe+NG0+E2SMGQnN72
 vnJGZnI8wtz0avJ2SOb+GUQRR9wh5JKAR1zLBNOcIZzmsCT2RYLZGoOUy+1KcX12E7
 E1YHOK5l9X1Kg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] pylibfdt: correct license information
Date: Sat,  7 Jun 2025 13:32:17 +0200
Message-ID: <20250607113218.208923-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Setuptools 78.1.1 shows warnings:

* Pattern 'GPL' did not match any files.
* Pattern 'BSD-2-Clause' did not match any files.
* SetuptoolsDeprecationWarning: License classifiers are deprecated.

Cf. https://packaging.python.org/en/latest/guides/writing-pyproject-toml/#license

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 scripts/dtc/pylibfdt/setup.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/dtc/pylibfdt/setup.py b/scripts/dtc/pylibfdt/setup.py
index c6fe5a6a446..487e669f524 100755
--- a/scripts/dtc/pylibfdt/setup.py
+++ b/scripts/dtc/pylibfdt/setup.py
@@ -158,12 +158,10 @@ setup(
     long_description_content_type="text/plain",
     url="https://git.kernel.org/pub/scm/utils/dtc/dtc.git",
     license="BSD",
-    license_files=["GPL", "BSD-2-Clause"],
+    license_files=["Licenses/gpl-2.0.txt", "Licenses/bsd-2-clause.txt"],
 
     classifiers=[
         "Programming Language :: Python :: 3",
-        "License :: OSI Approved :: BSD License",
-        "License :: OSI Approved :: GNU General Public License v2 or later (GPLv2+)",
         "Operating System :: OS Independent",
     ],
 
-- 
2.48.1

