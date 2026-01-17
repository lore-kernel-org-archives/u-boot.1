Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE871C9830D
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 00:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 266E683956;
	Sat, 17 Jan 2026 01:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fhAUNy2R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DD03836AC; Sat, 17 Jan 2026 01:25:11 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1DC98389A
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 01:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f646=7W=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1768609507; bh=CrIRxKcgCvWzl+Pkf2AaLTMOEIwNzZk1Rn91WwZGv34=;
 b=fhAUNy2RZgQyZEGwnUWQlczshKgK1plCuIL7UzV3ODdtlyJV4ji+TFma1m52OJd8jffSNwk8C
 8lnm2fLkPXmXLOcc6rOmaISIdFJpIl1cIM28PDZoBFkSRfBUsvQRaeYNke7hTGCnXij21ofMk+l
 u696frZcGY3TL2K7agbFl+FqnX5VCZHGsYiyYoq1kVCxVt/r9n4V1kNCK631BXK8+4QHjeqc9tG
 ptTLU9TN25COIBw7K6GLM2CeB/Y+eHcMMIL8vBupSIBcKfIIzPY1GbMAsoKkZ5vSY5+v8zqripg
 wvNpIJRp3V5BRUjVwsBMijl8i75i69rOA5mIHsDqXp7Q==
X-Forward-Email-ID: 696ad6e275104fdab5e8c348
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.2.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/6] net: lwip: nfs: Print device name based on current udevice
Date: Sat, 17 Jan 2026 00:24:38 +0000
Message-ID: <20260117002452.1026310-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117002452.1026310-1-jonas@kwiboo.se>
References: <20260117002452.1026310-1-jonas@kwiboo.se>
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

Use udevice name, similar to other lwip commands, instead of using the
legacy eth_get_name() when printing out the device being used.

Fixes: 230cf3bc2776 ("net: lwip: nfs: Port the NFS code to work with lwIP")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 net/lwip/nfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
index 27579af8f1fe..5fc2d3bd8736 100644
--- a/net/lwip/nfs.c
+++ b/net/lwip/nfs.c
@@ -3,6 +3,7 @@
 
 #include <console.h>
 #include <display_options.h>
+#include <dm/device.h>
 #include <env.h>
 #include <image.h>
 #include <linux/kconfig.h>
@@ -116,7 +117,7 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
 	nfs_filename = nfs_basename(fname);
 	nfs_path     = nfs_dirname(fname);
 
-	printf("Using %s device\n", eth_get_name());
+	printf("Using %s device\n", udev->name);
 
 	printf("File transfer via NFS from server %s; our IP address is %s\n",
 	       ip4addr_ntoa(&srvip), env_get("ipaddr"));
-- 
2.52.0

