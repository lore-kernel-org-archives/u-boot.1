Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD4FC61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14B5480ED2;
	Thu, 27 Aug 2026 19:54:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YLSDTT0psbxz; Thu, 27 Aug 2026 19:54:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860452;
	bh=b0AubKa7EUtBZR5RHqifvToMrZruUZwjvsKoxfhSaDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rRQ7mJpf97XY5V9BcxOMyPnelGnAGYStLViWMLVF2Ry2V4X5u+WHkK8gcO/U7l/BN
	 +dbqADwfsWdTSdPMJnNwDO1dYDdzyzku3SPPbDwKC+Gz9jBRnDDbicCuDuylhIEofk
	 vTk7TFqU4j9jJga/7xBlbEfOiLPMxfMnQhufxVr7Bm26Dc/8NCJ73aFoVGzsPaYsKF
	 0pJPz7SgKomCS9ge8VGCfzaA3Oo+pm1s3LEkzV5/Iv96Yv328gG//2fLUpZn2DuBF5
	 sLMyYvYrMdQi4CU2DwXF+gemNI/XOfp+dCCJVvac1s0KlTjgGuFazj1ygyrQ5zvwUe
	 CFvku7asjyVgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E5D480EE2;
	Thu, 27 Aug 2026 19:54:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 99D6D75
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7FF806083A
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sOXlUe2CzUXW for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:54:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::190e; helo=smtp-190e.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=isB6YNS5
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::190e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A053C60828
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:00 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzR3tdYzWTf;
 Thu, 27 Aug 2026 21:53:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860435;
 bh=b0AubKa7EUtBZR5RHqifvToMrZruUZwjvsKoxfhSaDY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=isB6YNS5SYRqfV1gP2yHSUtWuBwJGiq+HHOxyYoD/dajURJ+PzWQJWflYtqGZtM8s
 IWYcoLiM9861AgeXnuAm6flHQwJr/eQHA/ijxWtBg+lfoqHLLEo3cbaV5byfsQMjDE
 FiVaRhdrjNbJjJePU20XWDV7bVNxXObqxmH/5zBmHg3Hjw9RM63Ej4Iy2hxjWfj1k0
 q9L+zkC6ynKA6SEyr5lFFmXF8bfYcutFV+usj4oJcnNa8GtUratn8ksvFgGzjBAxmp
 L3JJDI+qipihfuy6NV20Lv/F0GGPW7SpOjyiw0zx7BbuERIJGCfFLAXQlIjgLVRl2d
 kbx8yCJVHjH6g==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzP4sDDzRYr; Thu, 27 Aug 2026 21:53:53 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
To: u-boot@lists.u-boot-project.org,
	u-boot-amlogic@groups.io
Cc: uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org,
 neil.armstrong@linaro.org, marek.vasut+renesas@mailbox.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adeep@lexina.in,
 sbabic@nabladev.com, festevam@gmail.com, smoch@web.de,
 alpernebiyasak@gmail.com, le.jin@siemens.com, jan.kiszka@siemens.com,
 iwamatsu@nigauri.org, pbrobinson@gmail.com, seanga2@gmail.com,
 bmeng.cn@gmail.com, lukma@denx.de, mkorpershoek@kernel.org,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 31/45] doc: learn/talks: remove dead links to slides
Date: Thu, 27 Aug 2026 21:52:59 +0200
Message-ID: <20260827195313.129994-10-foss+uboot@0leil.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Quentin Schulz <quentin.schulz@cherry.de>

I couldn't find a link to replace it with.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/learn/talks.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/doc/learn/talks.rst b/doc/learn/talks.rst
index d65e3b92be1a..0eca2daf8034 100644
--- a/doc/learn/talks.rst
+++ b/doc/learn/talks.rst
@@ -8,8 +8,7 @@ learn a bit about U-Boot:
 
 * `Tutorial: Introduction to the Embedded Boot Loader U-boot - Behan Webster,
   Converse in Code <https://www.youtube.com/watch?v=INWghYZH3hI>`__
-  from Embedded Linux Conference 2020
-  (`slides <https://cm.e-ale.org/2020/ELC2020/intro-to-u-boot/intro-to-u-boot-2020.pdf>`__).
+  from Embedded Linux Conference 2020.
 
 * `Recent Advances in U-Boot - Simon Glass, Google Inc.
   <https://www.youtube.com/watch?v=YlJBsVZJkDI>`__
