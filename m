Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32EDC47074
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 09:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D7887A08;
	Sun,  7 Jan 2024 10:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NQTx7S+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ED1D87A16; Sun,  7 Jan 2024 10:01:08 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC81186F87
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 10:01:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 65C1142839; 
 Sun,  7 Jan 2024 09:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704618065;
 bh=NOTCM9ZjHmxz4Yw/4NOsuZazNNB86fErIJQSHwfrosI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=NQTx7S+zT8kMBRNr1RpJPh5q5YCIgeWBasU8qigPWY02SupDC/nC8jmV+5sfKZ/uZ
 74rUIDMa/wYftdM7kOof300GXVqXUjob5zXW0BpnNXjX/ps48oAbmUoVouOuFI9Y2I
 4+fpMsNKcdo+VPXSuBIARxET71sznVcVOdame89mQtOHampfYoZ6DgfCwZ4Tj3PBmx
 jysi9HwLUo6/3QI9XC88Rq8t7ZVAKpxHN8Vxgxxjd6mIK2Ah/ogTSvT2W6zB0GPvGW
 EWcoPSdK0/8gCv8Lcyv7NqKjp71sKhLB8YUF9lbdzBN/4DKo4IoFTyNl0qCPy8Pj5U
 a4VgLtiLN0xzA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] boot: superfluous assignment in bootflow_menu_new()
Date: Sun,  7 Jan 2024 10:01:07 +0100
Message-ID: <20240107090107.64761-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

ret is assigned a value 0 which is never used but
is immediately overwritten in the next statement.

Addresses-Coverity-ID: 453304 ("Unused value")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/bootflow_menu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 7c1abe5772..16f9cd8f8c 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -120,7 +120,6 @@ int bootflow_menu_new(struct expo **expp)
 
 		if (ret < 0)
 			return log_msg_ret("itm", -EINVAL);
-		ret = 0;
 		priv->num_bootflows++;
 	}
 
-- 
2.43.0

