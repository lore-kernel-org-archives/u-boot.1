Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B506C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 860518766C;
	Wed,  6 Dec 2023 10:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OumD3aGN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C0528787B; Wed,  6 Dec 2023 10:52:07 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D58BF8763C
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:52:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B69q1oC053568;
 Wed, 6 Dec 2023 03:52:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701856321;
 bh=iOlb4FTrOM1NY4P1oBxa1w5NS1mOEnlJ4OSoGzdUgSs=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=OumD3aGNcW1xA20/+QK8+cA79ucXbT+GlCin8xzb4tb0kWWkOBpmqlUMCh7d+JkiK
 NphHUZyNi/UC4g2djNkFOjODeud+7VdRk7GMxkTM+A35igP18hPSDtYtTPwCU3y4wc
 eH7gSDLWglrcHaHZ8T9zjRYSpdqZZEGiAY98xx9g=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B69q1KV111782
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Dec 2023 03:52:01 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 03:52:01 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 03:52:01 -0600
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B69pQBe039003;
 Wed, 6 Dec 2023 03:51:57 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 6 Dec 2023 15:21:30 +0530
Subject: [PATCH v6 8/8] docs: k3: Add secure booting documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231206-binman-firewalling-v6-8-e7fce13a6dc1@ti.com>
References: <20231206-binman-firewalling-v6-0-e7fce13a6dc1@ti.com>
In-Reply-To: <20231206-binman-firewalling-v6-0-e7fce13a6dc1@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701856286; l=2639;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=4SIX1BkssWQBzKyhOerPJ0IB+U9824YmIQfb0V4OruA=;
 b=VKvXKiQqeZi+lqyktt6plDPUPzHRVafrG+FZVTN6zvcSiZ5MRI1p8JMe5K9v+T5OhqDJViLss
 8ddG+IwiTR4DodV2SmsRPQF4/UxRguS4qMoYD4DJ/J89rxKu2Z6dLf/
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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
index 947b86ba8292..60d04c5708be 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -104,6 +104,51 @@ firmware can be loaded on the now free core in the wakeup domain.
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

