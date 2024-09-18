Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D106CDD55C
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 21:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE31B8900A;
	Wed, 18 Sep 2024 23:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TkK5ArI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FBFB89011; Wed, 18 Sep 2024 23:58:08 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CD7288FEC
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 23:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-110-162.46.114.pool.telefonica.de
 [46.114.110.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BBF4B3F1C6; 
 Wed, 18 Sep 2024 21:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726696686;
 bh=vq8Q/sktndzzLORMCLtXQPROCcq/uP1VE+dh1wKOMFo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=TkK5ArI5nHuMYe3kDp1blkle5NDCMEMDqqxAVJPMM/ba7Bhyzbh3xho5s17Apyxuy
 wqCAMhLx4vWAF1j7dN0TB6wzX+qWDPr9bdKUU0ALNR1/lWXl4sUuct4jeJby7GwXq4
 o+Zvjn4oHh0n86SO+9uzL7dfXm0aosh987rANK+c8mOSOHDOuJ3QZAjvdn7V2b6HSx
 4ZyWzEG5t4NO5l3VuYCq+J1VhSCu4TiExc/KRPwDsWd2I2JvJ4ueayQ2koxIr6NaNB
 QORidwBGcS4VKxecaIfSVhxuu2dA/2iWSopUgUCFtsBdmJccM+Pr8UDFgipqvJRgor
 +8QEk6OpNFZQA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] boot: correct struct expo_action description
Date: Wed, 18 Sep 2024 23:58:03 +0200
Message-ID: <20240918215804.21809-1-heinrich.schuchardt@canonical.com>
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

Correct the description of the select.id member to fix a kernel-doc
warning.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/expo.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/expo.h b/include/expo.h
index 264745f7f01..c235fa2709d 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -42,7 +42,7 @@ enum expoact_type {
  *
  * @type: Action type (EXPOACT_NONE if there is no action)
  * @select: Used for EXPOACT_POINT_ITEM and EXPOACT_SELECT
- * @id: ID number of the object affected.
+ * @select.id: ID number of the object affected.
  */
 struct expo_action {
 	enum expoact_type type;
-- 
2.45.2

