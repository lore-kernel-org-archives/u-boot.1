Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A07C61DC7
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 491996085C;
	Thu, 27 Aug 2026 19:54:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VFdAscDrTEqN; Thu, 27 Aug 2026 19:54:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860458;
	bh=K1Fz9kDwNuO19y7RMmXwlw3Zd660N344UQoE4h3mAV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fc4qUC+2Jlc7aVCXla9/3ctozpo0HaNp4j56kRvEOnOAr6BfsXWAFrtwiyQNy7i7U
	 F5FXMY1HSZQpVWnISTX9NI5f+6bOI9yi5O6x7XdaBr7nBe8uB2edllZ4qG3Goc84IC
	 Ez9Qa74loHPDR87uxsHGuDLVRwbcYb8hygYaY1xDDCPNFdhwNJZ/KqnUKqhUEB8LUL
	 vOLXOop0Q2xVjhKbaDasWMXcYka2EYqQuyKbWvpuzTMEnMfZTo4EA2NVRWzpIXAltB
	 fbCXocUXAK+zAd07frTvuRQjw96pc6IC8jlrcyPR996gA259ZHRKzT2MsLZY7iQzIz
	 HLZb6EuUXMOCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E2D160854;
	Thu, 27 Aug 2026 19:54:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4281D105
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 34D1440827
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O5iwcB9BkgQQ for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:54:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.11;
 helo=smtp-bc0b.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=OAO4SXAv
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [45.157.188.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 295BC40841
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:05 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzb6DRVzvyq;
 Thu, 27 Aug 2026 21:54:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860443;
 bh=K1Fz9kDwNuO19y7RMmXwlw3Zd660N344UQoE4h3mAV4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OAO4SXAviTOkEObrlx6YVkMH5ldab3d9PGQ5D8q2FD2A7EzRsCeMlTslhMNaXbmzu
 kBDxY2Oq7XhIdjoyWANm5a9xLa8ynR9l4s2Cr/5VjyV9mDdJEwmAM6q24ZNns6HIxL
 zJnKPy9alaMvKW4b/mzoaivwdv0c7STjTl5Ft53dxCVh/ktXYGuLyNZn1stDbLZqEG
 7/wmBKGfyxAWz716Qs8n48L6sd0btt+wtbiXtntA6CT/oVGd9PsFkPHewqm4kMe85O
 FBzIxPKbr3841+EOoDOYk9LUKnttz3r9lU9MR22Ou75KZeYJC4Fr7U0oWxXYCdh8/s
 LGgLfo9SCHJ+A==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzZ17mgzRht; Thu, 27 Aug 2026 21:54:02 +0200 (CEST)
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
Subject: [PATCH 37/45] doc: fix broken links to mailing lists
Date: Thu, 27 Aug 2026 21:53:05 +0200
Message-ID: <20260827195313.129994-16-foss+uboot@0leil.net>
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

The new domain needs /mailman added after the domain to be able to reach
the mailman information page about the mailing list, so add it.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/CONTRIBUTE.rst              | 2 +-
 doc/develop/sending_patches.rst | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
index c7e5d9656c9a..e03945157029 100644
--- a/doc/CONTRIBUTE.rst
+++ b/doc/CONTRIBUTE.rst
@@ -28,7 +28,7 @@ Contributions
 
 Contributions to the project are welcome. The U-Boot project uses a fairly
 traditional Linux style development work-flow using git and `a mailing list
-<https://lists.u-boot-project.org/listinfo/u-boot>`_.
+<https://lists.u-boot-project.org/mailman/listinfo/u-boot>`_.
 
 Patches should be sent to the mailing list using ``git send-email`` or the
 equivalent commands using ``b4`` or ``patman`` with appropriate sign-off and
diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index 92c34c0669d0..a1e80eaff14c 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -5,7 +5,7 @@ Sending patches
 
 *Before you begin* to implement any new ideas or concepts it is always a good
 idea to present your plans on the `U-Boot mailing list
-<https://lists.u-boot-project.org/listinfo/u-boot>`_. U-Boot supports a huge amount of
+<https://lists.u-boot-project.org/mailman/listinfo/u-boot>`_. U-Boot supports a huge amount of
 very different systems, and it is often impossible for the individual developer
 to oversee the consequences of a specific change to all architectures.
 Discussing concepts early can help you to avoid spending effort on code which,
@@ -87,7 +87,7 @@ General Patch Submission Rules
 ------------------------------
 
 * All patches must be sent to the `u-boot@lists.u-boot-project.org
-  <https://lists.u-boot-project.org/listinfo/u-boot>`_ mailing list.
+  <https://lists.u-boot-project.org/mailman/listinfo/u-boot>`_ mailing list.
 
 * If your patch affects the code maintained by one of the :ref:`custodians`, CC
   them when emailing your patch. The easiest way to make sure you don't forget
