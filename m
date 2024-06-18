Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CC0C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 04:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 456928844D;
	Tue, 18 Jun 2024 06:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J65Bz+mg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 459598832D; Tue, 18 Jun 2024 06:50:35 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E1538844D
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 06:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45I4oVZ2123524;
 Mon, 17 Jun 2024 23:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718686231;
 bh=hMZfXkLVzQAdHJC2sKroojbi4dNba1cVgMbfIKd8qpY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=J65Bz+mga5DQfqgEPYQ3VmjrC1LwsQ2XOlMSnyTS89N3YYnC62pzZFKDbO0C7i4hi
 sPdaX0q1xkucNUb/7VTvbdVfhENxDNqmNzY4txLNmmIW3mwm1uO/hJl+OCahB6pNa+
 MzkbUNLNZt5DzC4zXApokKfXF7npmQ7Ufjn+QMWk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45I4oUcR007029
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Jun 2024 23:50:31 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Jun 2024 23:50:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Jun 2024 23:50:30 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45I4oAjK078292;
 Mon, 17 Jun 2024 23:50:28 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishant
 Menon <nm@ti.com>, <c-shilwant@ti.com>, <m-chawdhry@ti.com>,
 <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Dhruva Gole
 <d-gole@ti.com>
Subject: [PATCH v4 2/2] doc: beagle: am62x_beagleplay: Rename the boot bins
Date: Tue, 18 Jun 2024 10:19:46 +0530
Message-ID: <20240618044946.270299-3-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618044946.270299-1-d-gole@ti.com>
References: <20240618044946.270299-1-d-gole@ti.com>
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

Rename the boot bins as the _unsigned postfixes are not longer
required. We have symlinks in place for having generic names for all the
boot bins now.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 doc/board/beagle/am62x_beagleplay.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am62x_beagleplay.rst
index 7784e62b0b71..f5a85dd1fb82 100644
--- a/doc/board/beagle/am62x_beagleplay.rst
+++ b/doc/board/beagle/am62x_beagleplay.rst
@@ -71,11 +71,10 @@ Set the variables corresponding to this platform:
 
 Target Images
 -------------
-Copy the below images to an SD card and boot:
+Copy these images to an SD card and boot:
 
-* tiboot3-am62x-gp-evm.bin from R5 build as tiboot3.bin
-* tispl.bin_unsigned from Cortex-A build as tispl.bin
-* u-boot.img_unsigned from Cortex-A build as u-boot.img
+* tiboot3.bin from Cortex-R5 build.
+* tispl.bin and u-boot.img from Cortex-A build
 
 Image formats
 -------------
-- 
2.34.1

