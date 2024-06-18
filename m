Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7742C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 04:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F6448839F;
	Tue, 18 Jun 2024 06:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vwZMzm0M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4304A883C2; Tue, 18 Jun 2024 06:53:47 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3E5D8832D
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 06:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45I4rgW6093318;
 Mon, 17 Jun 2024 23:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718686422;
 bh=DHLWsZu5zQY7HVKAG2kovijBULE5/wwn/TaEvdDvXT4=;
 h=From:To:CC:Subject:Date;
 b=vwZMzm0MYSKGKLnh8YKNrqioQgyZNpIHod+l3rJq+SRbLkLTiizPLsYjgRSv3aPxE
 o1xh98VHvCAOut76IxYuFyi72DktPnY+4HI0pQOIFyvbvS2gohOgMh5QvEJieQpt22
 m9cp4dxAgnKNthX5OwOkCXD08H3sEM7YNnPo3euo=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45I4rgun008519
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Jun 2024 23:53:42 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Jun 2024 23:53:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Jun 2024 23:53:42 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45I4rdgE082242;
 Mon, 17 Jun 2024 23:53:39 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishant
 Menon <nm@ti.com>, <c-shilwant@ti.com>, <m-chawdhry@ti.com>,
 <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Dhruva Gole
 <d-gole@ti.com>
Subject: [PATCH v2] board: beagleplay: Fix the bootpart to pick from root
 partition
Date: Tue, 18 Jun 2024 10:23:18 +0530
Message-ID: <20240618045318.271133-1-d-gole@ti.com>
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

The Kernel Image and DTB files are supposed to be picked from the rootfs
of the SD Card, this fails in legacy boot flow because bootpart is set
to 1:1. Fix it.

Fixes: a200f428b5b21 ("board: ti: am62x: Add am62x_beagleplay_* defconfigs and env file")
Reviewed-by: Nishanth Menon <nm@ti.com>
Acked-by: Chirag Shilwant <c-shilwant@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

No changes, just picked the r-by's and acks.

Link to v1:
https://lore.kernel.org/u-boot/20240613080604.3828083-1-d-gole@ti.com/


 board/beagle/beagleplay/beagleplay.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/beagle/beagleplay/beagleplay.env b/board/beagle/beagleplay/beagleplay.env
index bbf6b925d02c..190181c8ad0c 100644
--- a/board/beagle/beagleplay/beagleplay.env
+++ b/board/beagle/beagleplay/beagleplay.env
@@ -11,7 +11,7 @@ set_led_state_start_load=led led-0 on; led led-1 off;
 	led led-2 on; led led-3 off; led led-4 on
 boot=mmc
 mmcdev=1
-bootpart=1:1
+bootpart=1:2
 bootdir=/boot
 boot_targets=mmc1 mmc0
 bootmeths=script extlinux efi pxe

base-commit: 16324b43db3f2b4fbbc3b701893fcfc4104f33fb
-- 
2.34.1

