Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE07C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 19:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C259687EBD;
	Wed, 19 Jun 2024 21:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mdgTYiTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC49B87F19; Wed, 19 Jun 2024 21:12:41 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9948680E9A
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 21:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45JJCbQp049197;
 Wed, 19 Jun 2024 14:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718824357;
 bh=YCyvfYNuftzT2O/k+PEu+BRjWu6MMwRqzG7y65On24Q=;
 h=From:Date:Subject:To:CC;
 b=mdgTYiThTfbc82LPyjSHFHq85+T5tHMhKgfGUa951WvdEZyQwTVUMIUztfdoZ8oRW
 easkxcusTcEdAsitngMvhtqBb09CLiFcM1O10eYsDZt44AYmyn0x/nVjqm8sYzgiVN
 Ok69laX4/AvavOVIs6yPnrMhcqFtUw1RIfkIPaZc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45JJCb87124278
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Jun 2024 14:12:37 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Jun 2024 14:12:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jun 2024 14:12:36 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45JJCadG067750;
 Wed, 19 Jun 2024 14:12:36 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 19 Jun 2024 14:12:30 -0500
Subject: [PATCH] board: beagle: beagleplay: enable OF_SYSTEM_SETUP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240619-play-fdt-fixup-v1-1-18e2a728ca45@ti.com>
X-B4-Tracking: v=1; b=H4sIAJ0tc2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0NL3YKcxErdtJQS3bTMitIC3URLo1TDxCQLc6O0ZCWgpoKiVKAE2MD
 o2NpaAG7ZhTFgAAAA
To: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>, Dhruva Gole
 <d-gole@ti.com>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=bb@ti.com;
 h=from:subject:message-id; bh=DExY1AxGN57tt4k0Y/YRDb0agUs1XgiW3O+PsX8tvek=;
 b=owNCWmg5MUFZJlNZ2yozcgAAaH//////uqnnvz7J3v4vOSna9/Pv71//n9+3Wt//lhx2v/8wA
 RsxoygAYQNDQAAD1AANAA0BoAAAANANBoAGgDQDRoaPQg09Rp5RsSbUeKIDIADQHqD1AYgDQZGQ
 0PU0NMCGgAAAYmh6g0DI/VNAGTTIYINNGmg0DQAAxBBpoHqNGRpoDRoaDR6JoyaAbUAAABpo0DQ
 Mh6E0DRoAAAAAANAaek09TTEya8q0oa1yuF7T3cy3K8jF5MZBmHSgYaKXQCRwRouBOi+IGmbIii
 HCJyJMdnanb9zmbaFwsep/QAbm57OD/B5j3NNkq18JGNZOxFJJRMxyFqGwFD39iz6gNMQp7jdd6
 u7WAtxqLYcb7NN3pEA1x6oMYmDKJukGUqsgRJQc2XOjMASGC4uD68zeivAUGj8cuYKhlj1ygedw
 mEKOpE11Zm3n+P4g3pw6ZXOrMWNM2KP4BI5iq5vbvuYr3CU+q0vsa1J2yyJNkUIRjriUi0NW8SV
 O4oB9RiL0AIcxEQ5I+7jlWbyDRFoCyQcAUd/+V5G5WjEqNYcQYq9iwXZO3oSpoHZVa9oagk7H9Z
 BDYz7L3ho2fBgQ1iiA75EEZPJc4QMhpf46wTba/zPe3J8C8O6Khiw/JVm2BwKjOCHH5CzEobCeP
 GHv8XckU4UJDbKjNyA=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

Unfortunately when enabling FDT fixups for the AM62x family of SoCs and
moving TF-A to the bottom of RAM we missed the BeaglePlay. This is
causing Linux's memory allocator to clobber TF-A and break its boot.

Enable OF_SYSTEM_SETUP to fixup the kernel's FDT to inform it of the
actual location of the firmware

CC: Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>
CC: Robert Nelson <robertcnelson@gmail.com>
Reported-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Hello everyone,

Fair warning, this may turn into a philosophical discussion about the 
role of device-tree with SystemReady and U-Boot's role in enabling true 
distribution to be completely agnostic of the board it's running on.

However substantively this is simply fixing a boot regression Dhruva 
found while testing out the beagleplay.

Happy reviewing
~Bryan
---
 board/beagle/beagleplay/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/beagle/beagleplay/Kconfig b/board/beagle/beagleplay/Kconfig
index 7dbd833acb4cc..896a1c1be3010 100644
--- a/board/beagle/beagleplay/Kconfig
+++ b/board/beagle/beagleplay/Kconfig
@@ -12,6 +12,7 @@ config TARGET_AM625_A53_BEAGLEPLAY
 	bool "BeagleBoard.org AM625 BeaglePlay running on A53"
 	select ARM64
 	select BINMAN
+	select OF_SYSTEM_SETUP
 
 config TARGET_AM625_R5_BEAGLEPLAY
 	bool "BeagleBoard.org AM625 BeaglePlay running on R5"

---
base-commit: fe2ce09a0753634543c32cafe85eb87a625f76ca
change-id: 20240619-play-fdt-fixup-a92e1ab872fc

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

