Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377F9C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 18:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 056C48802B;
	Tue, 20 Feb 2024 19:40:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rty4u3WW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B233D87FEE; Tue, 20 Feb 2024 19:40:13 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D25F48800D
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 19:39:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KIdrqx124929;
 Tue, 20 Feb 2024 12:39:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708454393;
 bh=d/vOp1URLkal2W4Qsc9sxr9KXrTo5kWL2SNC/pePWD8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=rty4u3WWlZHUGVjeoagjtxjNOf9XYNEUgo2E54/t46X91fegzR13+YLImPC3LWaGc
 tiQvdpk0A5rglew382eG/jNvJCPzF3b4fdx5F+Esx0LmukPAR/xkqWjAOonn+07k5N
 JDRqrpbHkg7gPQy90Pw3VsEQkLHvqhVpim/2GCvo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KIdr7J040206
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 20 Feb 2024 12:39:53 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 12:39:53 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 12:39:53 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KIdr88128007;
 Tue, 20 Feb 2024 12:39:53 -0600
From: Nishanth Menon <nm@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH V2 5/5] board: beagle: beagleplay: env: Drop usb and pxe as
 boot targets
Date: Tue, 20 Feb 2024 12:39:52 -0600
Message-ID: <20240220183952.3614252-6-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220183952.3614252-1-nm@ti.com>
References: <20240220183952.3614252-1-nm@ti.com>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
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

We had enabled USB and network pxe boot with the hope to get it all
merged on time. However, it has not panned out. Drop usb and pxe boot
else bootflow scan -l throws in:
a) Unknown uclass 'usb' in label
b) Crashes when attempting pxe - cpsw/mdio driver apparently has missing
   error handling of what ever form. This is the one that Jan noticed in
   his log.

We can enable these on a later date once things are working.

Cc: Roger Quadros <rogerq@kernel.org>

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Closes: https://lore.kernel.org/all/782ea2c0-eef5-478d-a122-cc6e2d066762@siemens.com/
Signed-off-by: Nishanth Menon <nm@ti.com>
---
- New patch in V2 of the series.

 board/beagle/beagleplay/beagleplay.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/beagle/beagleplay/beagleplay.env b/board/beagle/beagleplay/beagleplay.env
index 4f0a94a8113e..db737e069b58 100644
--- a/board/beagle/beagleplay/beagleplay.env
+++ b/board/beagle/beagleplay/beagleplay.env
@@ -14,6 +14,6 @@ boot=mmc
 mmcdev=1
 bootpart=1:1
 bootdir=/boot
-boot_targets=mmc1 mmc0 usb pxe
+boot_targets=mmc1 mmc0
 bootmeths=script extlinux efi pxe
 rd_spec=-
-- 
2.43.0

