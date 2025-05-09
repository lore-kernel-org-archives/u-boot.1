Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89788C3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 06:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8E2A8211F;
	Fri,  9 May 2025 08:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Oe+IRwt2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A610B8212F; Fri,  9 May 2025 08:39:15 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1A928210D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 08:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [213.157.19.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7CF8B3FB95; 
 Fri,  9 May 2025 06:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746772753;
 bh=CDo6w/3D4kjn+mWOrlAeEThVR4BMUSW/fPT2moOHwSA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Oe+IRwt29HaQaruxBsTPxVrBqYLToZ78/fnyoBMJ7fQ2X4RtzLPmprZo+/fYNSz0v
 5a+uY3aYfoDjCvMuOxrtz5e/sOSccT1G470JvnwHcQT7QuT3eIWkL41kPJrYEdEa8q
 zYDDoXpgovNCyiyA/ph7idyJBN6p0jSuXHJl3FqH45EoT1aDvpITGiT90TMaLMHOJ+
 QaDFRLVD41m8DiNd5AXb1gX3Vbcpjqx7/iBN+s4DBXc03EpR3o6WUNFT9F/3w6YSH+
 gDfVjvgnHEKitRmmw+AQQiJGrRkx18JjoGlqceGrzI9AagU/qO5cqJ7CcTKb9eU/P3
 3O2CjhDdL4Y7Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: correct link to QEMU
Date: Fri,  9 May 2025 08:39:04 +0200
Message-ID: <20250509063904.28923-1-heinrich.schuchardt@canonical.com>
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

%s/hhttps:/https:/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/develop/bootstd/qfw.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/bootstd/qfw.rst b/doc/develop/bootstd/qfw.rst
index 70086ad1817..fdc3ff71619 100644
--- a/doc/develop/bootstd/qfw.rst
+++ b/doc/develop/bootstd/qfw.rst
@@ -3,7 +3,7 @@
 QFW Bootmeth
 ============
 
-`QEMU <hhttps://www.qemu.org/>`_ is a system emulator which is able to boot
+`QEMU <https://www.qemu.org/>`_ is a system emulator which is able to boot
 Operating Systems. QEMU provides specific support for booting an OS image
 provided on the QEMU command line.
 
-- 
2.48.1

