Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F0DC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 23:21:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A0D8767E;
	Wed,  8 Nov 2023 00:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F/0I4b08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0121C876AE; Wed,  8 Nov 2023 00:21:49 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FC2287446
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 00:21:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A7NLguC087119;
 Tue, 7 Nov 2023 17:21:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699399302;
 bh=JUP/UdCF/GiKr/OdUUPGSxvROIRJlfX/PdFOmejIr1Q=;
 h=From:To:CC:Subject:Date;
 b=F/0I4b08CFoS42FAFFoD3hk5AjHigCGwxPpUe6QKGdJroeQZfHXNDgWHJwvCrOjdk
 8EVR36HLihbKpZUR0IR0Gxzvvph3lMZZe9saAgf5w01S1bpAMTVziKp4puAedubjwd
 GAGyGqkMhbcmhaCIATsdkWtswWG7847maPFz3C+k=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A7NLgrK117777
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Nov 2023 17:21:42 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Nov 2023 17:21:42 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Nov 2023 17:21:41 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A7NLfhc038031;
 Tue, 7 Nov 2023 17:21:41 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Andrew Davis <afd@ti.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/3] board: ti: common: setup mux and debounce for 32k RTC
 crystal
Date: Tue, 7 Nov 2023 17:21:40 -0600
Message-ID: <20231107232139.2839534-5-bb@ti.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=bb@ti.com;
 h=from:subject; bh=YXRkJMFy8BQjwxXv7lACeMPMIXbSYfwyOyH2LFkLTE0=;
 b=owNCWmg5MUFZJlNZm3qRpwAAZn///vdpu+9+nZX5XtX98/p/o9/39nY53HP9296f29ny88ewA
 RsYIeUABp6hoAAGgAAGgyAAeoGhoaAADQBoAAA0aD1A9RmUND1PU2kaeNKGUNGhoAMgAaAGQAAB
 6gA9R6QxMgAyaD1AGj1PU00B6mg0PU2oBoafqTQNqD1AIZHqekekyaDE0xAAGE00MBAGjTQAZNN
 MEZGmIYE0YgAAYjRk0AAAAAABQBWMAFc4i4+OGFClzMgm+q+C5NAaMiLUANkKG5PWTdYaihHW+/
 mfwSgGQYQLERvMpbpdK6yrp0KQ33YjGts9QX88NSdRnSpNYKzCxAMNQK2JMyt8MfOQVoznDJ2RA
 4VChcimXKNX8Yz2BYL3lHsNDDxOk4mkHNlngWtoTHI75eqEbrZso4DVnB7/bD81Ms0JS9HUIvFV
 /SBtRnmFBYAySA1YvdsFmSOLINIrwXGA6y1pbX5GqCvBjtLSVhB1UT1ohC1KA5AyOuJ1A2ggT8u
 V3+ivNYHog4H1Kx1XxWdBCFuwTI7hMydA32hF3Z0PD9I8B1iy/krUzy05g1l5iAM97xCSMZqxgo
 OCHXqgmigtYRTpU81+ro0EofmihPi3kHhAfJI7ZSATpNkW0N0KkoaHwWKQI7bylMcegBD/F3JFO
 FCQm3qRpw==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

Hello everyone!

The starter kit boards for Texas Instruments' am62xxx extended SoC
family all have the same discrete 32k crystal to provide a more accurate
clock source if needed.

Up until now this has not been needed, however as more features are
starting to rely on the accuracy of the internal RTC we should switch to
using this crystal.

This little series adds a board_rtc_init() function in the
board/ti/common directory to setup this crystal for the am62x and am62ax
starter kits.

Thanks for reviewing!
~Bryan

Bryan Brattlof (3):
  board: ti: common: add rtc setup to common folder
  configs: am62ax: setup the 32k RTC crystal
  configs: am62x: move 32K RTC crystal to common

 board/ti/am62ax/evm.c            |  5 ++++
 board/ti/am62x/evm.c             |  5 ++++
 board/ti/common/Kconfig          |  8 ++++++
 board/ti/common/rtc.c            | 47 ++++++++++++++++++++++++++++++++
 configs/am62ax_evm_a53_defconfig |  1 +
 configs/am62x_evm_a53_defconfig  |  1 +
 6 files changed, 67 insertions(+)
 create mode 100644 board/ti/common/rtc.c


base-commit: e17d174773e9ba9447596708e702b7382e47a6cf
-- 
2.42.0

