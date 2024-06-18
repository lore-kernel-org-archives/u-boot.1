Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C90BC2BB85
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 04:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70824883C2;
	Tue, 18 Jun 2024 06:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iOHHQbvK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B563F8843A; Tue, 18 Jun 2024 06:50:18 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 645278832D
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 06:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45I4oErq090040;
 Mon, 17 Jun 2024 23:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718686214;
 bh=8AAA+wsW9dc6/a4a+Whxd1qE2eDRPVi1boRcIH/zs8s=;
 h=From:To:CC:Subject:Date;
 b=iOHHQbvKKKu6TQzYwvtxTuvcHt/dTRaTETDPGPbVITJswgCC5AxkLy4AOVJlHEeNS
 MEFNO1M34xELxmSyGibrGedVj/iOIa3/gMC2x5Sw1YumYECw9rwL8A9Qa11JpKCDBf
 o0G5RLmrN58WMOaVFNL/o0IcbAO+zJKwVJt3tEm8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45I4oDQ6023309
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Jun 2024 23:50:14 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Jun 2024 23:50:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Jun 2024 23:50:13 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45I4oAjI078292;
 Mon, 17 Jun 2024 23:50:11 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishant
 Menon <nm@ti.com>, <c-shilwant@ti.com>, <m-chawdhry@ti.com>,
 <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Dhruva Gole
 <d-gole@ti.com>
Subject: [PATCH v4 0/2] k3-am625-beagleplay: Add symlinks for tiboot3 and tispl
Date: Tue, 18 Jun 2024 10:19:44 +0530
Message-ID: <20240618044946.270299-1-d-gole@ti.com>
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

Add symlinks for both tiboot3.bin and tispl.bin because a user has to
anyway rename these files to get the platform to boot up.
Also update the documentation to reflect above change.

Changes in v4:
* Add the docs patch.

Cc: Nishant Menon <nm@ti.com>
Cc: Robert Nelson <robertcnelson@gmail.com>

Dhruva Gole (2):
  arm: dts: k3-am625-beagleplay: Add symlinks for tiboot3 and tispl
  doc: beagle: am62x_beagleplay: Rename the boot bins

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 1 +
 arch/arm/dts/k3-am625-r5-beagleplay.dts      | 1 +
 doc/board/beagle/am62x_beagleplay.rst        | 7 +++----
 3 files changed, 5 insertions(+), 4 deletions(-)


base-commit: 16324b43db3f2b4fbbc3b701893fcfc4104f33fb
-- 
2.34.1

