Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DE6C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 21:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6EF087600;
	Fri,  1 Dec 2023 22:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="euVrGzgT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A35F87186; Fri,  1 Dec 2023 22:33:29 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BE9087103
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 22:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B1LXNkO018411;
 Fri, 1 Dec 2023 15:33:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701466403;
 bh=wzqsgxGvmod8MrC6Q0s9UiXDACxhiflE9M2IAw8fBP4=;
 h=From:To:CC:Subject:Date;
 b=euVrGzgTCaaNzUNHD/9rXt1IWMnPAp6WdVgIU8tfGwfviYPjIkZsexNS0HQDDHhlX
 n+3OYDQP37j2XKKhfbpC4zNpMvvg7rDaNBf34AOSIb9jcGOJmyWoRG//9kX7O/NW2f
 zYKRJNd6LVLjw3LW+nEzlz2S6xHSOFCT0G2Jns1k=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B1LXNut122476
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Dec 2023 15:33:23 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 15:33:23 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 15:33:23 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B1LXNux005119;
 Fri, 1 Dec 2023 15:33:23 -0600
From: Reid Tonking <reidt@ti.com>
To: <trini@konsulko.com>
CC: <nm@ti.com>, <u-boot@lists.denx.de>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>, <bb@ti.com>, <a-nandan@ti.com>, <vishalm@ti.com>, Reid
 Tonking <reidt@ti.com>
Subject: [PATCH 0/2] Fix J7200 kernel boot when using upstream u-boot
Date: Fri, 1 Dec 2023 15:33:18 -0600
Message-ID: <20231201213320.1876892-1-reidt@ti.com>
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

Since the 09.01.00.002 release of ti-linux-firmware [0] upstream uboot
has led to the kernel hanging during boot [1] for the TI J7200 S0C. The
issue was found to be a few patches that had be added to ti-u-boot, but not
yet upstreamed. This series adds the missing two patches to allow upstream
u-boot to boot the kernel properly [2].

[0] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/commit/?h=ti-linux-firmware-next&id=952fd03e36a50ec070e73560dc1060102d637ce0

Boot logs:
[1] https://gist.github.com/reidt1/5f4e85a0db258bcf20d7168bd0caebd0
[2] https://gist.github.com/reidt1/159604ae43c31ec4181f3a8df70375c4

Links to patches on ti-u-boot:
https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2023.04-next&id=d878fbef4d4460e87608d8d2dfe5311499de49c5
https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2023.04-next&id=543e735fe495be233a8a75b19b3d7f8ed44251e0

Reid Tonking (2):
  arm: mach-k3: j72xx: add new 'virtual' mux
  arm: dts: k3-j7200-r5-common-proc-board: Set parent clock for clock ID
    323

 arch/arm/dts/k3-j7200-r5-common-proc-board.dts |  3 ++-
 arch/arm/mach-k3/j7200/clk-data.c              | 13 +++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.34.1

