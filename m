Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E21C83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 11:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DDB782B07;
	Mon, 14 Jul 2025 13:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="yrw4zcZ3";
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="NbXwAX/g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78F7182CFA; Mon, 14 Jul 2025 13:17:14 +0200 (CEST)
Received: from out-ip0051.fra.mailhop.org (out-ip0051.fra.mailhop.org
 [18.193.30.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 740EF805D7
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 13:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=holger.brunck@hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=JnELdOasS7jxGdrUDpwp3Zj5/poMbGEfT6pd1qRaon8=;
 b=yrw4zcZ3S1q98AQ7ugP8SXxWTElYqYoQJ4J5bvFMrxJMAx5+ll4AKdznJs/hWLC+g9wegvoruKJxy
 R11qxZVPJQBxzsdBR7zU2yIBCrCLdH0THa65IIEC5QL0bOfUD92tjBGuvMvgUSY71O1oDMqGwUELBw
 jKP1Qw4vDuEbcagk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=JnELdOasS7jxGdrUDpwp3Zj5/poMbGEfT6pd1qRaon8=;
 b=NbXwAX/ggpTN/EWorwolygxUwhmfaCzB+JmTuVQ6+k9S/aS3U9u1ODOXANdtDIchqHObUpIiGl7uw
 QUV5Qkk2J9SHc6Uu1lAysbJzHMolU+VVIPhLbOuBMfiUwZaIcA4wlzJLjmqvkXR1Vx2E29s+qPJ8TQ
 NXY/zYvlagATN9FpJPQXaSr81VUbeRiL/IGCOFR7rWeJotsPw7E+OZtuU32SMZLcTdPKRMYO5SdpET
 ghlI6MaWKwWwdnvFshGnnqNpyvSz8IK8Jo+qQ7rCGCN7Ue34giSKpAfNQQDbl+AJDp6qmrt/nIq+zg
 sf7bmP1yaLbdDxBg1CphpLjRR9aWIbQ==
X-Originating-IP: 20.62.140.138
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 12c9056b-60a4-11f0-be19-eb1d40c36193
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 12c9056b-60a4-11f0-be19-eb1d40c36193:5
CFBL-Address: prvs=02909799d7=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000548.corp.hitachi-powergrids.com (unknown
 [20.62.140.138]) by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 12c9056b-60a4-11f0-be19-eb1d40c36193;
 Mon, 14 Jul 2025 11:17:07 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000548.corp.hitachi-powergrids.com (Postfix) with SMTP id ACDB3173A; 
 Mon, 14 Jul 2025 11:17:04 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net
 [172.31.41.201])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id 3674760B7D47;
 Mon, 14 Jul 2025 13:17:04 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH] arm: fix lmb region reservation when PRAM is defined
Date: Mon, 14 Jul 2025 13:16:51 +0200
Message-ID: <20250714111651.2450845-1-holger.brunck@hitachienergy.com>
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

PRAM usage is not taken into account when reserving lmb for ARM
architecture, this means that predefined PRAM region is marked as
reserved by the architecture and cannot be used by other users.

Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 lib/lmb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index e5a0677e3f9..9fa303d15f1 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -538,6 +538,7 @@ static void lmb_reserve_uboot_region(void)
 	int bank;
 	ulong end, bank_end;
 	phys_addr_t rsv_start;
+	ulong pram =3D 0;
=20
 	rsv_start =3D gd->start_addr_sp - CONFIG_STACK_SIZE;
 	end =3D gd->ram_top;
@@ -548,6 +549,11 @@ static void lmb_reserve_uboot_region(void)
 	 */
 	debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
=20
+#ifdef CFG_PRAM
+	pram =3D env_get_ulong("pram", 10, CFG_PRAM);
+	pram =3D pram << 10; /* size is in kB */
+#endif
+
 	for (bank =3D 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
 		if (!gd->bd->bi_dram[bank].size ||
 		    rsv_start < gd->bd->bi_dram[bank].start)
@@ -560,7 +566,8 @@ static void lmb_reserve_uboot_region(void)
 		if (bank_end > end)
 			bank_end =3D end - 1;
=20
-		lmb_reserve(rsv_start, bank_end - rsv_start + 1, LMB_NOOVERWRITE);
+		lmb_reserve(rsv_start, bank_end - rsv_start - pram + 1,
+			    LMB_NOOVERWRITE);
=20
 		if (gd->flags & GD_FLG_SKIP_RELOC)
 			lmb_reserve((phys_addr_t)(uintptr_t)_start,
--=20
2.49.0

