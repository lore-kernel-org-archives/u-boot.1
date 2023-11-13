Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7B7C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 10:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B418715B;
	Mon, 13 Nov 2023 11:19:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VJ8aOEnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0531D87148; Mon, 13 Nov 2023 11:19:39 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B278C8710C
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 11:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADAJXZY092160;
 Mon, 13 Nov 2023 04:19:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699870773;
 bh=mc06iPBFyY2SjAmVMChZ2ID+r2FhycdIVdl4NGkzUYg=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=VJ8aOEnZRax7xfqk0BSKmVXdFPdICEVbGYce6K0fada2Mqpuh262DNpzJ7Y4X/z7z
 YNPXvl7Ih81RaAJqfM5aoeyUSkP0epid16Lsnbspjgb/Cyw5JT/HUr/ZLsG+YUHzWG
 k5jk/4k4tCUyrNMdOS7gCMDVj4PQn1FVpeiyS+Ww=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADAJXEB119419
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 04:19:33 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 04:19:32 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 04:19:32 -0600
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADAJ06E051156;
 Mon, 13 Nov 2023 04:19:29 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 13 Nov 2023 15:49:07 +0530
Subject: [PATCH v5 8/8] docs: k3: Add secure booting documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231113-binman-firewalling-v5-8-b3ba6f839606@ti.com>
References: <20231113-binman-firewalling-v5-0-b3ba6f839606@ti.com>
In-Reply-To: <20231113-binman-firewalling-v5-0-b3ba6f839606@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699870741; l=2639;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=BIpZIL8Hu+CyoNDvMcx3CWb4sF2WDRjURGw9a5fRzoE=;
 b=HDS8fQMNCJi7J0ErUg0GlIbHan1fa9H/l/U5mWqZh2qzC5svVny6wFg+ll2LP3sQz2L82aTlG
 zBdeiLgicH7BoHXiKf4Gp4Ad/e85qduv4OkGVT0JnEodsDkqFYz+rgV
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

This commit adds a general flow to explain the usage of firewalls and
the chain of trust in K3 devices.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 doc/board/ti/k3.rst | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 3c4dbe1af545..5471f715d948 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -102,6 +102,51 @@ firmware can be loaded on the now free core in the wakeup domain.
 For more information on the bootup process of your SoC, consult the
 device specific boot flow documentation.
 
+Secure Boot
+^^^^^^^^^^^
+
+K3 HS-SE devices are used for authenticated boot flow with secure boot.
+HS-FS devices have optional authentication in the flow and doesn't "require"
+authentication unless converted to HS-SE devices.
+
+Chain of trust
+""""""""""""""
+
+1) SMS starts up and loads the authenticated ROM code in Wakeup Domain
+2) ROM code starts up and loads the authenticated tiboot3.bin in Wakeup
+   Domain
+3) Wakeup SPL (tiboot3.bin) would authenticate the next set of binaries
+   (ATF,OP-TEE,DM,SPL,etc.)
+4) After ATF and OP-TEE load, ARMV8 U-boot authenticates the next set of
+   binaries (Linux and DTBs) if using FIT Image authentication and having a
+   signature node in U-boot.
+
+Steps 1-3 are all authenticated by either the ROM code or TIFS as the
+authenticating entity and step 4 uses U-boot standard mechanism for
+authenticating.
+
+All the authentication that are done for ROM/TIFS are done through x509
+certificates that are signed.
+
+Firewalls
+"""""""""
+
+1) ROM comes up and sets up firewalls that are needed by itself
+2) TIFS (in multicertificate will setup it's own firewalls)
+3) R5 SPL comes along and opens up other firewalls ( that are not owned by
+   anyone - essentially firewalls that were setup by ROM but are not needed
+   anymore)
+4) Each stage beyond this: such as tispl.bin containing TFA/OPTEE uses OIDs to
+   set up firewalls to protect themselves (enforced by TIFS)
+5) TFA/OP-TEE can configure other firewalls at runtime if required as they
+   are already authenticated and firewalled off from illegal access.
+6) A53 SPL and U-boot itself startups but has no ability to change the
+   protection firewalls enforced by x509 OIDs or any other firewalls
+   configured by ROM/TIFS in the beginning.
+
+Futhur, firewalls have a lockdown bit in hardware that enforces the setting
+(and cannot be over-ridden) till the full system is resetted.
+
 Software Sources
 ----------------
 

-- 
2.41.0

