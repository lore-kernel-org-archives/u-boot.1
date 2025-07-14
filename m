Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118B8C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 15:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B85182F49;
	Mon, 14 Jul 2025 17:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="c7wG1h35";
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="Wp1B7nQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC9ED82FC7; Mon, 14 Jul 2025 17:22:12 +0200 (CEST)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org
 [18.158.144.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D37A82E37
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 17:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=holger.brunck@hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=5/t8erYYGcCb7JoPcIGjayH9olJKw6gx0BzB9uZGmkE=;
 b=c7wG1h35SOsVKSE0NTcoT6YIkAUucGWk2LR1XvlHfeVoVPw0BCGHNV+qjQa/RSTFr08uEdcHzRwCX
 xOK2oZmqmjPjKv+ZzeYFiwYFuadhsbcm2jIZgBDYXpvrbnX9jb9MnuNmdbCr5zaeSUIxsJlkdPhwId
 bonKt3oTJrYEPpiA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=5/t8erYYGcCb7JoPcIGjayH9olJKw6gx0BzB9uZGmkE=;
 b=Wp1B7nQaKXp6Y8BlhyCLE/dVji/EXDK5uxWUnkzKb00iu4k0z52673nIAu4BquNx3YWlIf/oyO8Zy
 mWYLATqT2QIam3m6jrTxqm2H0Kfge3Mq5VXf7wQ7x3KVw5UfinWwBek89t8jmfXdMJV8sZ1ek/3Rke
 VqasPpIJdZi7OFgK8qXgUC/RMnRI68jNIOqoLHSxg6iZ6G3dFMiSaol8qMFH7X0AV+1oaQtgdv2NKh
 YTbtpYONRO7gAMdCxLe+pps7a1s4ftwEUmpEkLaCWKWnDWvPMiSYVul3/ReN5sAdCDTdcFWCB7EV/I
 7lb/0r0Ug/p1boUa0FiOSH4SPvAQfzA==
X-Originating-IP: 20.62.140.138
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 4d0a59a0-60c6-11f0-be23-eb1d40c36193
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 4d0a59a0-60c6-11f0-be23-eb1d40c36193:7
CFBL-Address: prvs=02909799d7=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000548.corp.hitachi-powergrids.com (unknown
 [20.62.140.138]) by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 4d0a59a0-60c6-11f0-be23-eb1d40c36193;
 Mon, 14 Jul 2025 15:22:07 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000548.corp.hitachi-powergrids.com (Postfix) with SMTP id 374921606; 
 Mon, 14 Jul 2025 15:22:05 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net
 [172.31.41.201])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id A174660B7D47;
 Mon, 14 Jul 2025 17:22:04 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH v2 2/6] km: drop KM_RESERVED_PRAM
Date: Mon, 14 Jul 2025 17:22:02 +0200
Message-ID: <20250714152202.2504860-1-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250714132221.2471558-2-holger.brunck@hitachienergy.com>
References: <20250714132221.2471558-2-holger.brunck@hitachienergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

This variable is unused since we dropped the support for the Kirkwood
boards.

Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 board/keymile/Kconfig                | 8 --------
 board/keymile/common/common.c        | 8 +++-----
 include/configs/km/pg-wcom-ls102xa.h | 3 +--
 include/configs/kmcent2.h            | 3 +--
 4 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/board/keymile/Kconfig b/board/keymile/Kconfig
index 41458813858..b68c10f85e4 100644
--- a/board/keymile/Kconfig
+++ b/board/keymile/Kconfig
@@ -29,14 +29,6 @@ config KM_PHRAM
 	help
 	  Start address of the physical RAM, which is the mounted /var folder.
=20
-config KM_RESERVED_PRAM
-	hex "Reserved RAM"
-	default 0x0 if MPC83xx
-	default 0x1000 if MPC85xx || ARCH_LS1021A
-	depends on !ARCH_SOCFPGA
-	help
-	  Reserved physical RAM area at the end of memory for special purposes.
-
 config KM_CRAMFS_ADDR
 	hex "CRAMFS Address"
 	default 0x83000000 if ARCH_LS1021A
diff --git a/board/keymile/common/common.c b/board/keymile/common/common.=
c
index 25897af2d8a..4bdaf90deff 100644
--- a/board/keymile/common/common.c
+++ b/board/keymile/common/common.c
@@ -53,7 +53,7 @@ int set_km_env(void)
 	char *p;
=20
 	pnvramaddr =3D CFG_SYS_SDRAM_BASE + gd->ram_size -
-		CONFIG_KM_RESERVED_PRAM - CONFIG_KM_PHRAM - CONFIG_KM_PNVRAM;
+		CONFIG_KM_PHRAM - CONFIG_KM_PNVRAM;
 	sprintf(envval, "0x%x", pnvramaddr);
 	env_set("pnvramaddr", envval);
=20
@@ -61,12 +61,10 @@ int set_km_env(void)
 	p =3D env_get("rootfssize");
 	if (p)
 		strict_strtoul(p, 16, &rootfssize);
-	pram =3D (rootfssize + CONFIG_KM_RESERVED_PRAM + CONFIG_KM_PHRAM +
-		CONFIG_KM_PNVRAM) / 0x400;
+	pram =3D (rootfssize + CONFIG_KM_PHRAM + CONFIG_KM_PNVRAM) / 0x400;
 	env_set_ulong("pram", pram);
=20
-	varaddr =3D CFG_SYS_SDRAM_BASE + gd->ram_size -
-		CONFIG_KM_RESERVED_PRAM - CONFIG_KM_PHRAM;
+	varaddr =3D CFG_SYS_SDRAM_BASE + gd->ram_size - CONFIG_KM_PHRAM;
 	env_set_hex("varaddr", varaddr);
 	sprintf(envval, "0x%x", varaddr);
 	env_set("varaddr", envval);
diff --git a/include/configs/km/pg-wcom-ls102xa.h b/include/configs/km/pg=
-wcom-ls102xa.h
index 3a243d789c0..b6e6958599c 100644
--- a/include/configs/km/pg-wcom-ls102xa.h
+++ b/include/configs/km/pg-wcom-ls102xa.h
@@ -10,8 +10,7 @@
 #define CFG_SYS_INIT_RAM_SIZE	OCRAM_SIZE
=20
 #define CFG_PRAM			((CONFIG_KM_PNVRAM + \
-					  CONFIG_KM_PHRAM + \
-					  CONFIG_KM_RESERVED_PRAM) >> 10)
+					  CONFIG_KM_PHRAM) >> 10)
=20
 #define PHYS_SDRAM			0x80000000
 #define PHYS_SDRAM_SIZE			(1u * 1024 * 1024 * 1024)
diff --git a/include/configs/kmcent2.h b/include/configs/kmcent2.h
index e7ae18ec5f9..de41b998ea4 100644
--- a/include/configs/kmcent2.h
+++ b/include/configs/kmcent2.h
@@ -158,11 +158,10 @@
 /***********************************************************************=
*******
  * (PRAM usage)
  * ... -------------------------------------------------------
- * ... |ROOTFSSIZE | PNVRAM |PHRAM |RESERVED_PRAM | END_OF_RAM
+ * ... |ROOTFSSIZE | PNVRAM |PHRAM | END_OF_RAM              |
  * ... |<------------------- pram -------------------------->|
  * ... -------------------------------------------------------
  * @END_OF_RAM:
- * @CONFIG_KM_RESERVED_PRAM: reserved pram for special purpose
  * @CONFIG_KM_PHRAM: address for /var
  * @CONFIG_KM_PNVRAM: address for PNVRAM (for the application)
  */
--=20
2.49.0

