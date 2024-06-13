Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD1AC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 20:28:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23949888BF;
	Thu, 13 Jun 2024 22:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WQUmaQqK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D34118895D; Thu, 13 Jun 2024 22:28:22 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD9B387F8C
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 22:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45DKS7Zg018918;
 Thu, 13 Jun 2024 15:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718310487;
 bh=5cZ7NaZMMyOVleQ6HkFP7MJ2RGJCRzv/K3Cq5gbc2ks=;
 h=From:To:CC:Subject:Date;
 b=WQUmaQqKGCQc6J9YtB5QzVew+2OS+b42uSm3Mgpua0IoH693IasPIu7IVGcohpgTQ
 1u+nbr4rDlMnJ5sf0TM2O7T4Wfn3ZIwfKiTd06I7mAkPuQVc2M3Mu4QK5F1JhHthpm
 xa8o77z+SMjia0/jmH5sXh3nzbbOE8QW0zKE+j84=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45DKS7oB075260
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Jun 2024 15:28:07 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 15:28:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 15:28:06 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45DKS78G090008;
 Thu, 13 Jun 2024 15:28:07 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Sumit Garg <sumit.garg@linaro.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Wei Ming Chen <jj251510319013@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Joshua Watt <jpewhacker@gmail.com>, Caleb
 Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Jonathan Humphreys <j-humphreys@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, Mario Six <mario.six@gdsys.cc>, Simon Glass
 <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 0/2] scripts/Makefile.lib: EFI: Use capsule CRT instead of
 ESL
Date: Thu, 13 Jun 2024 15:27:51 -0500
Message-ID: <20240613202753.2528889-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Use the capsule's public key certificate rather than a prebuilt ESL
generated from the certificate. The ESL is now generated as part of the
build.

Changes from v1:
- Converted the single patch to a series to include a bug fix found during
  development.
- Created an explicit rule for creating the ESL file for proper makefile
  dependency tracking.  v1 had combined creating the ESL file and
  generating the .dtsi include in a single command.

Jonathan Humphreys (2):
  scripts/Makefile.lib: fixes: Embed capsule public key in platform's
    dtb
  scripts/Makefile.lib: EFI: Use capsule CRT instead of ESL file

 board/sandbox/capsule_pub_esl_good.esl | Bin 831 -> 0 bytes
 configs/sandbox_defconfig              |   2 +-
 configs/sandbox_flattree_defconfig     |   2 +-
 doc/develop/uefi/uefi.rst              |   8 ++++----
 lib/efi_loader/Kconfig                 |  12 +++++++-----
 scripts/Makefile.lib                   |  24 +++++++++++++++---------
 6 files changed, 28 insertions(+), 20 deletions(-)
 delete mode 100644 board/sandbox/capsule_pub_esl_good.esl

-- 
2.34.1

