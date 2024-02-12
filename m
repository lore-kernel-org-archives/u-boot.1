Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC9FC48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 15:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B28E3875FA;
	Mon, 12 Feb 2024 16:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FCv8yqrh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C866E871C0; Mon, 12 Feb 2024 16:53:39 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57D74870A4
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 16:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CFrYRh037603;
 Mon, 12 Feb 2024 09:53:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707753214;
 bh=DgGU+wxpLbF/xHK/kd+7ABxsjfn3LQQ3FfGTCubwWuc=;
 h=From:To:CC:Subject:Date;
 b=FCv8yqrhEfzXrV9ALN5aHp+/2AYcg+g9RuiB1LPyTjHWpqRWUO9fmz0EqR4WfPmQF
 6rJxOZt+r0fCOgbULoJhTbR7IZPoF6wbaWuoQwLAQAYz4uZhVXQeEagkjtDdxuBqKf
 u6/bOaNSVUltI99Dx0TYJyzUZKcB4kPOhxw/ugW0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CFrY2j003756
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Feb 2024 09:53:34 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 09:53:33 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 09:53:33 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CFrX2A028858;
 Mon, 12 Feb 2024 09:53:33 -0600
From: Nishanth Menon <nm@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/4] board: beagle: Enable 32k and debounce configuration
Date: Mon, 12 Feb 2024 09:53:28 -0600
Message-ID: <20240212155332.541949-1-nm@ti.com>
X-Mailer: git-send-email 2.43.0
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

Hi,

This is a follow up from [1] - Without the 32k crystal configuration,
wlan does'nt work. Debounce is needed for HDMI hpd gpio interrupt.

At least the 32k configuration has been done for toradex and phytec
boards, follow similar model of programming.

This series is based on master commit e8f2404e093d + the findfdt
series[2].

Nishanth Menon (4):
  board: beagle: beagleplay: Enable 32k crystal
  configs: am62x_beagleplay_r5_defconfig: Enable SPL_BOARD_INIT
  arm: mach-k3: am62: Add Debounce configuration register definitions
  board: beagle: beagleplay: Configure debounce registers

 arch/arm/mach-k3/include/mach/am62_hardware.h |  3 +
 board/beagle/beagleplay/beagleplay.c          | 61 +++++++++++++++++++
 configs/am62x_beagleplay_r5_defconfig         |  1 +
 3 files changed, 65 insertions(+)

[1] https://lore.kernel.org/u-boot/20230725185253.2123433-4-nm@ti.com/
[2] https://lore.kernel.org/all/20240130130615.670783-1-nm@ti.com/
-- 
2.43.0

