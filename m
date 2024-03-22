Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B759DC54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 12:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E722E88013;
	Fri, 22 Mar 2024 13:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CyC15M/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE4078812B; Fri, 22 Mar 2024 13:55:53 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 670F987CB7
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 13:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1711112150; x=1713704150;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7vMTB2+0Symb5KDMmlgk5Lj0rEuW9xf1B6G4tNSYefg=;
 b=CyC15M/6BaZ4L3H4TXj1/mXwhNAbthlWH3hIDqyk+zk0G4CcgPgmXLgbkc7+9LE4
 NKsmN7m6iklDkJrxYXhn1Pd/lmsVNDA6YVKAGSFl7M4rBxY1pILtPQwJZaJ3/8GU
 thR/ouzQyNgJU4ic8CA1ESaa9bOhFd4AuGbhgP/dzHU=;
X-AuditID: ac14000a-fadff7000000290d-e8-65fd7fd6b7c5
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 64.05.10509.6DF7DF56;
 Fri, 22 Mar 2024 13:55:50 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 22 Mar
 2024 13:55:50 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Fri, 22 Mar 2024 13:55:28 +0100
Subject: [PATCH] board: phytec: phycore_imx8mp.env fix netboot issues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240322-phycore_mx8mp_netboot_fixes-v1-1-33d992343fc0@phytec.de>
X-B4-Tracking: v=1; b=H4sIAL9//WUC/x3MQQqDMBBG4avIrBtIE0HxKqUEM/7qLExCIsUi3
 t3g8uPBO6kgCwoNzUkZPykSQ8X71RCvY1igZKomo02rrTEqrX+OGW47+i25gN3HuLtZDhRlbcf
 wrR81M9VDynhCHXy+13UDnCnqYG0AAAA=
To: Teresa Remmet <t.remmet@phytec.de>, Fabio Estevam <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWyRpKBR/da/d9Ug54JWhYPr/pbvN3byW7R
 /U7dgdlj56y77B5n7+xg9OjvbmENYI7isklJzcksSy3St0vgylh0dCd7wQmeijM7WpgaGE9w
 dTFyckgImEgsn/GXsYuRi0NIYDGTxOMN79ggnIeMErtW7mUCqWITUJF4/OIeK4jNIqAq8f3d
 crC4sICrxLXNb8FsXgFBiZMzn7B0MXJwMAtoSqzfpQ8SZhaQl9j+dg4zRImfxO4305khFu9h
 lHh5XQGkXETAS+Lifx6I8giJazeXsEOUCEu0L7oFNl1IQFbixfleqLi8xLRzr6HGhEps/bKd
 aQKj4CwkR8xCOGIWkiMWMDKvYhTKzUzOTi3KzNYryKgsSU3WS0ndxAgKWhEGrh2MfXM8DjEy
 cTAeYpTgYFYS4d3x/0+qEG9KYmVValF+fFFpTmrxIUZpDhYlcd7VHcGpQgLpiSWp2ampBalF
 MFkmDk6pBsaEJ99FPXiF2mXf77gxacfXif96F1Rsfyxuk/FPXZaJ6elZrj1v1+an1u/R+/B8
 2QNvX8cvLgFu83t3i+tN1vlu1s6/tXf7N8mvjnsYo9iarfpWZVpfXl6QYm2VvGwPD9BDhwtC
 4qcvNZ7Na+a1xGTbbFuZ+TNz751psi9RrDOOtfvlquDfpcRSnJFoqMVcVJwIAMp9mhdIAgAA
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

The "run netargs" command should come later in the "netboot" command
order when using dhcp since it sets the server and client ip addresses.
The previous order led to misconfigured kernel boot params and thus
kernel panic when serverip was not manually set.
Further, following Linux FHS 3.0, change the nfsroot default directory
to /srv/nfs.

Fixes: 60f64bec414e ("board: phytec: phycore_imx8mp: Add fec support")
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
Depends on [1] which is on next already.
[1] https://lore.kernel.org/u-boot/20240312085957.902398-1-l.anderweit@phytec.de/
---
 board/phytec/phycore_imx8mp/phycore_imx8mp.env | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index fae3e992654..7f6c5fd2c76 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -46,17 +46,17 @@ netargs=
 	nfsroot=${serverip}:${nfsroot},v3,tcp
 netboot=
 	echo Booting from net ...;
-	run netargs;
 	if test ${ip_dyn} = yes; then
 		setenv get_cmd dhcp;
 	else
 		setenv get_cmd tftp;
 	fi;
 	${get_cmd} ${loadaddr} ${image};
+	run netargs;
 	if ${get_cmd} ${fdt_addr} ${fdt_file}; then
 		booti ${loadaddr} - ${fdt_addr};
 	else
 		echo WARN: Cannot load the DT;
 	fi;
-nfsroot=/nfs
+nfsroot=/srv/nfs
 sd_dev=1

---
base-commit: 86b79cf131b64eadae023a127921893d30503093
change-id: 20240322-phycore_mx8mp_netboot_fixes-337ceb4ba0cc

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

