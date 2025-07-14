Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED57C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 11:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CBEB82AC4;
	Mon, 14 Jul 2025 13:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="QzuFCCk8";
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="NwRcb8Dw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1803282B07; Mon, 14 Jul 2025 13:44:03 +0200 (CEST)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org
 [18.158.144.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 180BE805D7
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 13:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=holger.brunck@hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=Dwfjemp/YJlM9Ijqq9EFe8gbO+QRhjjqElNXX/kogUI=;
 b=QzuFCCk8nsakkqHGN3kFmgeoe7sNkKabSBWVhvgSViul+4r8C05WTQil0pxokk9fbivkvBa45W0rW
 8zPtCs3c63q12kNqSDE63hLAeY0v46Of+QPCZYpxhKsKCWWcjevS7CZmWeTI9+mI+iejIBN6tF1TPa
 oYW1QtRJfppS4aI4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=Dwfjemp/YJlM9Ijqq9EFe8gbO+QRhjjqElNXX/kogUI=;
 b=NwRcb8DwpnU1uBtwfjgETtKLhmiqs04TjDGt+xMq3LPSTq7FkgXpJcrYYfnhQRJ8ydLX8QmUynsfs
 IHHtpydAKbonKc6DORcFkQ0wrNQFYhZaX4ojTCRYbLGfh8HlmEFU44CycYSp3A80aHnopJRNnd0JNT
 o2w11RxsPkxqOIpIbNz8R8lsphT5MKrJ/BwKinbmmmzjAdMj39ExIsrLSAVwLONFaj5Bdo2hBv9Mpt
 nWbgY7qWmSOUzZN283RVrPVIH8cEQ4CXnN7K/lT80wvvgVFeYXuLQd0YsQBCs6qJvhPTfG+BwKyKw9
 h8Lg4fXC2BA0OuzpmUX6ts6cIZDL2bw==
X-Originating-IP: 20.62.140.138
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: cf38bead-60a7-11f0-be19-eb1d40c36193
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: cf38bead-60a7-11f0-be19-eb1d40c36193:5
CFBL-Address: prvs=02909799d7=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000534.corp.hitachi-powergrids.com (unknown
 [20.62.140.138]) by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id cf38bead-60a7-11f0-be19-eb1d40c36193;
 Mon, 14 Jul 2025 11:43:51 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000534.corp.hitachi-powergrids.com (Postfix) with SMTP id
 706BA402488; Mon, 14 Jul 2025 11:43:49 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net
 [172.31.41.201])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id D09D060B7D47;
 Mon, 14 Jul 2025 13:43:48 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH] armv8: ls1043a: make some erratas dependent from USB
Date: Mon, 14 Jul 2025 13:43:47 +0200
Message-ID: <20250714114347.2455172-1-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.49.0
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

These erratas are only useful if USB is enabled. If it is disabled
these erratas might cause issues.

Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 arch/arm/cpu/armv8/fsl-layerscape/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/Kconfig b/arch/arm/cpu/arm=
v8/fsl-layerscape/Kconfig
index 787c7a7c1da..20883fe6825 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/Kconfig
+++ b/arch/arm/cpu/armv8/fsl-layerscape/Kconfig
@@ -77,11 +77,11 @@ config ARCH_LS1043A
 	select SYS_FSL_DDR_BE
 	select SYS_FSL_DDR_VER_50
 	select SYS_FSL_ERRATUM_A008850 if !TFABOOT
-	select SYS_FSL_ERRATUM_A008997
-	select SYS_FSL_ERRATUM_A009008
+	select SYS_FSL_ERRATUM_A008997 if USB
+	select SYS_FSL_ERRATUM_A009008 if USB
 	select SYS_FSL_ERRATUM_A009660 if !TFABOOT
 	select SYS_FSL_ERRATUM_A009663 if !TFABOOT
-	select SYS_FSL_ERRATUM_A009798
+	select SYS_FSL_ERRATUM_A009798 if USB
 	select SYS_FSL_ERRATUM_A009942 if !TFABOOT
 	select SYS_FSL_ERRATUM_A010315 if PCIE_LAYERSCAPE
 	select SYS_FSL_ERRATUM_A010539
--=20
2.49.0

