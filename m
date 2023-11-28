Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE62FC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 19:40:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D744487771;
	Tue, 28 Nov 2023 20:40:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="k8eIx/9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DCCE8778C; Tue, 28 Nov 2023 20:40:30 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07D6E87561
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 20:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ASJePG7040270
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 13:40:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701200425;
 bh=LqNvwWeepQpQ1EsDlTVYRWV1Zl6fBZ+dHXvrUoXJh6A=;
 h=From:To:Subject:Date;
 b=k8eIx/9qNTGZ4fCq6VRYNtVtyl+1SIqtA1O+quj7iI6VIL61V+MqVdrYoMwAMpKfU
 gkBeWyp6jr+FfFulRZGZSgMyPrmgc9Hi0ApQy93/LI5meFy34amWHzg53l7/8Ql/6A
 mrLZeFYiXRXiARQ0FuWljBox8WVq8nhk70j08nps=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ASJePnV092195
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 13:40:25 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 13:40:25 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 13:40:25 -0600
Received: from uda0271468c (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ASJePUV087722;
 Tue, 28 Nov 2023 13:40:25 -0600
Received: from vishallocal by uda0271468c with local (Exim 4.90_1)
 (envelope-from <vishalm@ti.com>)
 id 1r83wW-0005Pu-VD; Tue, 28 Nov 2023 13:40:25 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan
 Brattlof <bb@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
Subject: [PATCH 0/4] board: ti: Update to latest board configuration
Date: Tue, 28 Nov 2023 13:40:20 -0600
Message-ID: <20231128194024.20809-1-vishalm@ti.com>
X-Mailer: git-send-email 2.36.1
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

This patch series brings in the latest board configurations for
am62 and am62a device.

Patch "board: ti: am62x/am62ax: Update virtual interrupt allocations
in board config" is needed for booting with the latest TIFS and DM
firmware [1].

[1] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/log/?h=ti-linux-firmware
SHA: e891ddc65c55bfa7111e4f45834b7c26444dff72


U-boot boot log - https://gist.github.com/vishalmti/6b38fb80d557478131d5aaed5aeb3596


Vishal Mahaveer (4):
  board: ti: am62x/am62ax: Formatting updates to board config files
  board: ti: am62ax: Add C7x resource allocation entries to board config
  board: ti: am62x/am62ax: Update MCU GPIO interrupt allocation in board
    config
  board: ti: am62x/am62ax: Update virtual interrupt allocations in board
    config

 board/ti/am62ax/rm-cfg.yaml | 522 +++++++++++++++---------------------
 board/ti/am62x/rm-cfg.yaml  | 481 +++++++++++++--------------------
 2 files changed, 396 insertions(+), 607 deletions(-)

-- 
2.36.1

