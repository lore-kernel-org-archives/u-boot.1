Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E225CD6A221
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76BD489584;
	Thu, 14 Nov 2024 19:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="FD9kh8in";
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="DZVC3ztg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4721489620; Thu, 14 Nov 2024 19:07:13 +0100 (CET)
Received: from out-ip0051.fra.mailhop.org (out-ip0051.fra.mailhop.org
 [18.193.30.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 249EB890FC
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=holger.brunck@hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=Jpqwo0MrsrJfUKZ03sBnk6olZKCL041R2MsxyMVsu/Y=;
 b=FD9kh8in4DeJt4T0lseNl+hvBuZR1wPkPbM+I0/ZpguU+QOE6OiBAEAshTZ+qruzGYtrSyNPme7fm
 Oe8HTtxySCilsCA9jDo9FKBTtBsgeeEnQAdZxs88zIGn9tuzMia24dy8hK2mJBTEvyBzI35qj+0YY0
 8YgHEEnAej7ckr/Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=Jpqwo0MrsrJfUKZ03sBnk6olZKCL041R2MsxyMVsu/Y=;
 b=DZVC3ztgHaolmtCA/HcMLlCt0TVVOu+kpUI6IR5/zEI8CjRh/uTkKGOOaV2x82f1BZKry3lQgnfcH
 V/Gk0hlL68ozl0pXkcTeWQRSGLsvdfJGnJnTuoxLkLeq/44UP1jTkjU9SQLAQOWW8ebFoLG/Is/X2x
 MsZIC//w9uBbo0ysoRs/w7pr9aXTv6gZM4lDtrYtY/nOebQntGRgG777zORl2wroYwoAPktPwniR0v
 JesAdesgJeUturaST15utNmx73qF7mcd3p0xeXkmP3fNdZOrBC8q9HqhvlTI0M7sWyy4jZSHghyjpv
 Iqod4lbH4YH+MhORuXkOF8vnlMVKdzA==
X-Originating-IP: 20.62.140.138
X-MHO-RoutePath: aGVkY3NtdHAwMDAx
X-MHO-User: 42bfd2ff-a2b3-11ef-b2a8-25ccbfd3c7c9
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from HPG0000000548.corp.hitachi-powergrids.com (unknown
 [20.62.140.138]) by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 42bfd2ff-a2b3-11ef-b2a8-25ccbfd3c7c9;
 Thu, 14 Nov 2024 18:07:08 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000548.corp.hitachi-powergrids.com (Postfix) with SMTP id A6ACC1605; 
 Thu, 14 Nov 2024 18:07:06 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net
 [172.31.41.201])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id 2EED261B45FA;
 Thu, 14 Nov 2024 19:07:06 +0100 (CET)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH] km: disable CMD_JFFS2 for all PPC boards
Date: Thu, 14 Nov 2024 19:06:54 +0100
Message-ID: <20241114180654.2564945-1-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
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

We don't use this feature, we can remove it therefore in the defconfigs.

Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 configs/kmcoge5ne_defconfig | 1 -
 configs/kmeter1_defconfig   | 1 -
 configs/kmopti2_defconfig   | 1 -
 configs/kmsupx5_defconfig   | 1 -
 configs/kmtepr2_defconfig   | 1 -
 configs/tuge1_defconfig     | 1 -
 configs/tuxx1_defconfig     | 1 -
 7 files changed, 7 deletions(-)

diff --git a/configs/kmcoge5ne_defconfig b/configs/kmcoge5ne_defconfig
index 211880bfcaa..6b2fc2ec6e7 100644
--- a/configs/kmcoge5ne_defconfig
+++ b/configs/kmcoge5ne_defconfig
@@ -152,7 +152,6 @@ CONFIG_BOOTP_BOOTFILESIZE=3Dy
 CONFIG_CMD_DHCP=3Dy
 CONFIG_CMD_MII=3Dy
 CONFIG_CMD_PING=3Dy
-CONFIG_CMD_JFFS2=3Dy
 CONFIG_CMD_MTDPARTS=3Dy
 CONFIG_MTDIDS_DEFAULT=3D"nor0=3Dboot,nand0=3Dapp"
 CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dboot:768k(u-boot),128k(env),128k(e=
nvred),-(ubi0);app:-(ubi1);"
diff --git a/configs/kmeter1_defconfig b/configs/kmeter1_defconfig
index b69410b4d3d..55e87b0215a 100644
--- a/configs/kmeter1_defconfig
+++ b/configs/kmeter1_defconfig
@@ -131,7 +131,6 @@ CONFIG_BOOTP_BOOTFILESIZE=3Dy
 CONFIG_CMD_DHCP=3Dy
 CONFIG_CMD_MII=3Dy
 CONFIG_CMD_PING=3Dy
-CONFIG_CMD_JFFS2=3Dy
 CONFIG_CMD_MTDPARTS=3Dy
 CONFIG_MTDIDS_DEFAULT=3D"nor0=3Dboot"
 CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dboot:768k(u-boot),128k(env),128k(e=
nvred),-(ubi0);"
diff --git a/configs/kmopti2_defconfig b/configs/kmopti2_defconfig
index 28ad18ec32f..df419b01c68 100644
--- a/configs/kmopti2_defconfig
+++ b/configs/kmopti2_defconfig
@@ -138,7 +138,6 @@ CONFIG_BOOTP_BOOTFILESIZE=3Dy
 CONFIG_CMD_DHCP=3Dy
 CONFIG_CMD_MII=3Dy
 CONFIG_CMD_PING=3Dy
-CONFIG_CMD_JFFS2=3Dy
 CONFIG_CMD_MTDPARTS=3Dy
 CONFIG_MTDIDS_DEFAULT=3D"nor0=3Dboot"
 CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dboot:768k(u-boot),128k(env),128k(e=
nvred),-(ubi0);"
diff --git a/configs/kmsupx5_defconfig b/configs/kmsupx5_defconfig
index 42ced44f5c1..1436860f1cc 100644
--- a/configs/kmsupx5_defconfig
+++ b/configs/kmsupx5_defconfig
@@ -123,7 +123,6 @@ CONFIG_BOOTP_BOOTFILESIZE=3Dy
 CONFIG_CMD_DHCP=3Dy
 CONFIG_CMD_MII=3Dy
 CONFIG_CMD_PING=3Dy
-CONFIG_CMD_JFFS2=3Dy
 CONFIG_CMD_MTDPARTS=3Dy
 CONFIG_MTDIDS_DEFAULT=3D"nor0=3Dboot"
 CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dboot:768k(u-boot),128k(env),128k(e=
nvred),-(ubi0);"
diff --git a/configs/kmtepr2_defconfig b/configs/kmtepr2_defconfig
index 3488e268e7b..cce7a044aee 100644
--- a/configs/kmtepr2_defconfig
+++ b/configs/kmtepr2_defconfig
@@ -137,7 +137,6 @@ CONFIG_BOOTP_BOOTFILESIZE=3Dy
 CONFIG_CMD_DHCP=3Dy
 CONFIG_CMD_MII=3Dy
 CONFIG_CMD_PING=3Dy
-CONFIG_CMD_JFFS2=3Dy
 CONFIG_CMD_MTDPARTS=3Dy
 CONFIG_MTDIDS_DEFAULT=3D"nor0=3Dboot"
 CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dboot:768k(u-boot),128k(env),128k(e=
nvred),-(ubi0);"
diff --git a/configs/tuge1_defconfig b/configs/tuge1_defconfig
index 10f60551ab1..d1b771993cf 100644
--- a/configs/tuge1_defconfig
+++ b/configs/tuge1_defconfig
@@ -123,7 +123,6 @@ CONFIG_BOOTP_BOOTFILESIZE=3Dy
 CONFIG_CMD_DHCP=3Dy
 CONFIG_CMD_MII=3Dy
 CONFIG_CMD_PING=3Dy
-CONFIG_CMD_JFFS2=3Dy
 CONFIG_CMD_MTDPARTS=3Dy
 CONFIG_MTDIDS_DEFAULT=3D"nor0=3Dboot"
 CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dboot:768k(u-boot),128k(env),128k(e=
nvred),-(ubi0);"
diff --git a/configs/tuxx1_defconfig b/configs/tuxx1_defconfig
index 816ac8ffac8..1dc737e4954 100644
--- a/configs/tuxx1_defconfig
+++ b/configs/tuxx1_defconfig
@@ -137,7 +137,6 @@ CONFIG_BOOTP_BOOTFILESIZE=3Dy
 CONFIG_CMD_DHCP=3Dy
 CONFIG_CMD_MII=3Dy
 CONFIG_CMD_PING=3Dy
-CONFIG_CMD_JFFS2=3Dy
 CONFIG_CMD_MTDPARTS=3Dy
 CONFIG_MTDIDS_DEFAULT=3D"nor0=3Dboot"
 CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dboot:768k(u-boot),128k(env),128k(e=
nvred),-(ubi0);"
--=20
2.43.5

