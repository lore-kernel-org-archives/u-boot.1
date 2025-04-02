Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F8BC36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 21:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0050B81F0B;
	Wed,  2 Apr 2025 23:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="pN3UOFix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B7281F6B; Wed,  2 Apr 2025 23:50:41 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11DB181E6C
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 23:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=h1ygX2N4SIv0dvudp2t9ExI+VD03sabrAPUkqeTvDvs=; b=pN3UOFixXGbOt2iNPm5W9XXNUp
 /eozekXZNS8hDf/SbIM1M/oAtUUTuvXoMahczk90Hr9UH64ruJOg/j75a+kvU1PqO8fsz9lth18oN
 j9vt0/mEd1WfOJxo+9E0DEUJIfUv1/adPx5qkv0lm9fh+sSASVMYEQs+alqOlZoHHhvJ1Ke9hPB7j
 Etciii5KWfx3Bt2P+YJmO7lJRizLj+59R5FPmHBOBlw1J4sCEz7Sx/oHGGPltuRb54ckpKDYBl/c9
 TcGYzdgjweow/CZ2D3aRoBdW25VY0J6Qey9XuPhJamRvlohZ3oHdTH4Vy0Ajy3x6fBKSO4BfOwaSh
 Yytgtq0Q==;
Received: from i53875bf8.versanet.de ([83.135.91.248]
 helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1u05yl-0002x1-Ft; Wed, 02 Apr 2025 23:50:35 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: trini@konsulko.com
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, xypron.glpk@gmx.de,
 sjg@chromium.org, u-boot@lists.denx.de, quentin.schulz@cherry.de,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] boot: call dhcp_run in pxe bootmethod
Date: Wed,  2 Apr 2025 23:50:25 +0200
Message-ID: <20250402215025.2655384-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
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

A recent change tried to speed up EFI booting by not calling dhcp_run
from eth_bootdev_hunt() every time. PXE so far relied on that dhcp_run
call to get an IP address.

Fix that by adding a dhcp_run call to the pxe bootflow, with autoload
disabled to only get the ip address and nothing else.

Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Fixes: 1f68057e0320 ("net: eth_bootdev_hunt() should not run DHCP")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
This also seems to work, to fix the dhcp problem.

So this is the counter-idea to the revert submitted in 
https://lore.kernel.org/u-boot/20250401083830.2320479-1-heiko@sntech.de/

Only this one or the revert patch should be applied.

 boot/bootmeth_pxe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index b91e61bcbc4..6e5e0f99ea4 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -73,6 +73,10 @@ static int extlinux_pxe_read_bootflow(struct udevice *dev,
 		return log_msg_ret("pxeb", -EPERM);
 	addr = simple_strtoul(addr_str, NULL, 16);
 
+	ret = dhcp_run(addr, NULL, false);
+	if (ret)
+		return log_msg_ret("dhc", ret);
+
 	log_debug("calling pxe_get()\n");
 	ret = pxe_get(addr, &bootdir, &size, false);
 	log_debug("pxe_get() returned %d\n", ret);
-- 
2.47.2

