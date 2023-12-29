Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15440C46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 10:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CDE087B50;
	Fri, 29 Dec 2023 11:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vbUlaSWg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E493876B2; Fri, 29 Dec 2023 11:47:13 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F051087B1B
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 11:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAl718085110;
 Fri, 29 Dec 2023 04:47:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703846827;
 bh=SWN1FuuOUyMnstz2f5b3wty7/i3dwxvkjE4AF+a/sNE=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=vbUlaSWg2rTYOCSB/uIjSYOPitbgeVpSMbbbobXL6p8Y7yrES65ptZKzyQ6BKb6Tc
 wCbN7Q/gc1lmWhlV2cooXg1pRrKMiYhipSgRQqEbjQJi/rqT8z23K7KO/dk8HU5aAS
 JNfb2t7V5D6pdnkq0ReGM8083YvJbRa1ovDXo/aY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTAl7lT019666
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 04:47:07 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 04:47:06 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 04:47:06 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.69.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkT7n072641;
 Fri, 29 Dec 2023 04:47:03 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 29 Dec 2023 16:16:33 +0530
Subject: [PATCH v7 9/9] docs: board: ti: k3: Add secure booting documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231229-binman-firewalling-v7-9-47ed4af303fe@ti.com>
References: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
In-Reply-To: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703846789; l=2552;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=KZzWxZn70yPhF0SJ6on+3dTT35qwx8m9xcwmgpYBEgw=;
 b=luWZE4SmmD2ZhFpsJlUgat8v04eXACetJbcMGzb7QTtUKHEbDI5bvsmMcOgNU80cTRNUFt6Ul
 aS3Ij1gSpQeAlA1rrUVOfG9F7rhUHGSfevgMPvmk9Fsl5Ee2ri9NSxs
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
 doc/board/ti/k3.rst | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 1064c21b5a1d..7dfe39c5fa57 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -104,6 +104,49 @@ firmware can be loaded on the now free core in the wakeup domain.
 For more information on the bootup process of your SoC, consult the
 device specific boot flow documentation.
 
+Secure Boot
+-----------
+
+K3 HS-SE (High Security - Security Enforced) devices enforce an
+authenticated boot flow for secure boot. HS-FS (High Security - Field
+Securable) is the state of a K3 device before it has been eFused with
+customer security keys.  In the HS-FS state the authentication still can
+function as in HS-SE but as there are no customer keys to verify the
+signatures against the authentication will pass for certificates signed
+with any key.
+
+Chain of trust
+^^^^^^^^^^^^^^
+
+1) Public ROM loads the tiboot3.bin (R5 SPL, TIFS)
+2) R5 SPL loads tispl.bin (ATF, OP-TEE, DM, SPL)
+3) SPL loads u-boot.img (U-Boot)
+4) U-Boot loads fitImage (Linux and DTBs)
+
+Steps 1-3 are all authenticated by either the Secure ROM or TIFS as the
+authenticating entity and step 4 uses U-boot standard mechanism for
+authenticating.
+
+All the authentication that are done for ROM/TIFS are done through x509
+certificates that are signed.
+
+Firewalls
+^^^^^^^^^
+
+1) Secure ROM comes up and sets up firewalls that are needed by itself
+2) TIFS will setup it's own firewalls to protect core system resources
+3) R5 SPL will remove any firewalls that are leftover from the Secure ROM stage
+   that are no longer required.
+4) Each stage beyond this: such as tispl.bin containing TFA/OPTEE uses OIDs to
+   set up firewalls to protect themselves (enforced by TIFS)
+5) TFA/OP-TEE can configure other firewalls at runtime if required as they
+   are already authenticated and firewalled off from illegal access.
+6) All later stages can setup or remove firewalls that have not been already
+   configured by previous stages, such as those created by TIFS, TFA, and OP-TEE.
+
+Futhur, firewalls have a lockdown bit in hardware that enforces the setting
+(and cannot be over-ridden) until the full system is reset.
+
 Software Sources
 ----------------
 

-- 
2.43.0

