Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B470CA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 04:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E2AF8329F;
	Thu, 11 Sep 2025 06:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=230ruedubac.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=230ruedubac.fr header.i=@230ruedubac.fr header.b="KxQbztjY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C4B68323A; Wed, 10 Sep 2025 23:19:01 +0200 (CEST)
Received: from aven.230ruedubac.fr (unknown [IPv6:2001:bc8:2e57:145::87])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 415F38319C
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 23:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=230ruedubac.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=davidb@230ruedubac.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=230ruedubac.fr;
 s=mail; t=1757539138;
 bh=riwSyzPIkwxBCEzTVo0J2lMVCVpMnyGZMJfT5eEy87M=;
 h=From:To:Cc:Subject:Date:From;
 b=KxQbztjYUQvoTA0AgluQ9+0IOZrYGB+zRuV1Z22zKRGu2bsjKsnuiRnFjyCdhNyoX
 dryhvsHdLcCHZdHqzX71x5DjopMSVVpbLdSHFlmQoORHxgVh15erVxdznWIKbUVwOP
 NV4O+p92JUxDoYuNOSM+QccDki6d3mvy8WYjGzAk=
Received: from aven.230ruedubac.fr (localhost [127.0.0.1])
 by aven.230ruedubac.fr (230ruedubac.fr domain) with ESMTP id 5A5415602F9;
 Wed, 10 Sep 2025 21:18:58 +0000 (UTC)
Authentication-Results: aven.230ruedubac.fr; dmarc=fail (p=none dis=none)
 header.from=230ruedubac.fr
Received: from alden.230ruedubac.fr (knet.230ruedubac.fr [45.83.230.42])
 by aven.230ruedubac.fr (230ruedubac.fr domain) with ESMTPS id 36FB05600F1;
 Wed, 10 Sep 2025 21:18:58 +0000 (UTC)
Received: from nb043690.eth.internal (_gateway [192.168.2.254])
 by alden.230ruedubac.fr (230ruedubac.fr domain) with ESMTPSA id 079863258CF;
 Wed, 10 Sep 2025 21:18:57 +0000 (UTC)
From: David Barbion <davidb@230ruedubac.fr>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 David Barbion <davidb@230ruedubac.fr>
Subject: [PATCH] board: rockchip: Fix RG353M model renaming
Date: Wed, 10 Sep 2025 23:18:55 +0200
Message-ID: <20250910211855.739181-1-davidb@230ruedubac.fr>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Sep 2025 06:57:44 +0200
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

Anbernic RG353M is hardware compatible with RG353P. Only the form-factor
differs. So only one DTS is created for both machines with
"Anbernic RG353P" as default model. If a RG353M is detected, the model
should be overwritten with the correct name.
Actually, it's overwritten with "Anbernic" only making the process of
machine detection a little harder.
However, to determine the size of the string "Anbernic RG353M", it is
sizeof() which is used resulting in obtaining the size of the pointer
(which is 8 bytes on ARM64) not the size of the pointed string.
strlen() should be used instead.
---
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
index c1d1826fd14..d402374e90e 100644
--- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
+++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
@@ -695,7 +695,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	if (gd->board_type == RG353M)
 		fdt_setprop(blob, 0, "model",
 			    rg3xx_model_details[RG353M].board_name,
-			    sizeof(rg3xx_model_details[RG353M].board_name));
+			    strlen(rg3xx_model_details[RG353M].board_name));
 
 	if (rg3xx_model_details[gd->board_type].detect_panel) {
 		ret = rgxx3_panel_fixup(blob);
-- 
2.51.0
