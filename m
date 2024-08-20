Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF209C531DC
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 18:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A189888D8B;
	Tue, 20 Aug 2024 20:45:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="AYEY+TDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5201A88A3C; Tue, 20 Aug 2024 17:47:03 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C446B88D8B
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 17:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Y.Varakala@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1724168818; x=1726760818;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3CY9SZ0ArTSn45c4ltLOU4qNQWA+cRqyKr0Ve7nQvBk=;
 b=AYEY+TDX66nDnTD2wMtxJSWHYcPBkELo+vVOQajT556f1jbD6Ifp5/gsgwC21ynC
 PxN9xBDhjXiy007+De4jKMYTWMdl/PZMEh70MX9lcXPkGhkTqcoJkmjxMdg7dwyi
 e81UuiHRA81EaJk/XlGwRoz9VvHQybt97eI6Uu7MKg8=;
X-AuditID: ac14000a-03e52700000021bc-72-66c4ba726ef4
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 6E.20.08636.27AB4C66;
 Tue, 20 Aug 2024 17:46:58 +0200 (CEST)
Received: from llp-varakala.phytec.de (172.25.0.11) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 20 Aug
 2024 17:46:58 +0200
From: Yashwanth Varakala <y.varakala@phytec.de>
To: <t.remmet@phytec.de>, <trini@konsulko.com>, <sbabic@denx.de>,
 <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <y.varakala@phytec.de>
Subject: [PATCH 1/2] board: phytec: phycore_imx8mp: Add mcore support
Date: Tue, 20 Aug 2024 17:46:29 +0200
Message-ID: <20240820154630.78976-2-y.varakala@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820154630.78976-1-y.varakala@phytec.de>
References: <20240820154630.78976-1-y.varakala@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Florix.phytec.de
 (172.25.0.13)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWyRpKBV7do15E0g4m3BCweXvW3aD/lYzF1
 0mZ2i7d7O9ktut+pO7B6zJt1gsVj56y77B6vDqxi9zh7ZwejR393C2sAaxSXTUpqTmZZapG+
 XQJXxqk1zcwFS7krrm2KbmC8w9nFyMkhIWAi8fffdKYuRi4OIYElTBLbt81mgXCeMkp8Ovaa
 BaSKTUBfYsW6RawgtohAhETHhSPsIDazgJ/E5xtz2UBsYQFXiTPTtjGB2CwCqhI/77wFq+EV
 sJRY0tfFCrFNXmL/wbPMXYwcHJwCVhL7/2qAhIWASvb8+MEEUS4ocXLmExaI8fISzVtnM0PY
 EhIHX7xghqhXlHj/sIMdZuS0c6+ZIexQic4/91kmMArNQjJqFpJRs5CMWsDIvIpRKDczOTu1
 KDNbryCjsiQ1WS8ldRMjKOhFGLh2MPbN8TjEyMTBeIhRgoNZSYS3++XBNCHelMTKqtSi/Pii
 0pzU4kOM0hwsSuK8qzuCU4UE0hNLUrNTUwtSi2CyTBycUg2MrWd8TeOT58WvU5DT1Jc43NSt
 nvTYh6V+rfaMyvf1bGZP29n9C6c8Lp+65jKT0f067TOPT7zL8pqo/fvotNnZ+R8/+cWrHPmh
 Mpnhq4/Eh3nJa66yTImOu75jx8yaH2etmNpTtDfNfK3vyePwsnvlKV/OU6wmn5y7u72/VLTp
 dElP+/mHtW6yEktxRqKhFnNRcSIAnV2V22gCAAA=
X-Mailman-Approved-At: Tue, 20 Aug 2024 20:45:13 +0200
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

Added m7 core support in uboot for imx8mp by adding
the boot variable prepare_mcore.

Based on commit 0ed32cc8568a ("LF-6555 imx8m[m/n/p/q]_evk: add
bootargs to support mcore")

Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
---
 board/phytec/phycore_imx8mp/phycore_imx8mp.env | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index f8f878e8f3a..889464e933f 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -30,7 +30,7 @@ ip_dyn=yes
 loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 mmcargs=
-	setenv bootargs console=${console}
+	setenv bootargs ${mcore_clk} console=${console}
 	root=/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw
 mmcautodetect=yes
 mmcboot=
@@ -51,7 +51,7 @@ mmcdev=CONFIG_SYS_MMC_ENV_DEV
 mmcpart=1
 mmcroot=2
 netargs=
-	setenv bootargs console=${console} root=/dev/nfs ip=dhcp
+	setenv bootargs ${mcore_clk} console=${console} root=/dev/nfs ip=dhcp
 	nfsroot=${serverip}:${nfsroot},v3,tcp
 netboot=
 	echo Booting from net ...;
@@ -74,4 +74,5 @@ netboot=
 		echo WARN: Cannot load the DT;
 	fi;
 nfsroot=/srv/nfs
+prepare_mcore=setenv mcore_clk clk-imx8mp.mcore_booted
 sd_dev=1
-- 
2.34.1

