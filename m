Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B6CCD4F49
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCE8D846AC;
	Mon, 18 May 2026 16:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="X9vYSSN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BA4283FEE; Mon, 18 May 2026 16:13:18 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3820803C6
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 16:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=59164dd44=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1779113596; x=1810649596;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hKzDKUODlAFHZjPCyyBJuEu21Tx8wkro0wPQQG8u7/8=;
 b=X9vYSSN5DENBN5qfIBINnIsvuSH2fTSrlPA5ENbeJzWVhvXisMjz/ZSQ
 /ZhExWgO6MFr/eDnxPWcdXjda0XnCoqtDzGNPeQGg2j8KmSTFKJuZh+k2
 fTkNrPd2D7f7gzTjeEeptlcitTPmLxhtPMDJrkXe1eO5GX7TtO0ehumNj
 mLYHxHAp1mENDQVn7qV0+nMb99Jr287yTOD4RS1LG88JditDGn0stVXsV
 2zI+DdSlY9EC+heBc3UqJLUGUXuV45IkX8SNnes1Zs1OuVTNrW8hbFvrh
 6gggzLN4YNg8s4Sdw8pLxJR3dgWQdrGWJ0yawEBN46yQfqX94JB3j719E A==;
X-CSE-ConnectionGUID: H+ld0a+mTh+4dP8O7cEjyg==
X-CSE-MsgGUID: Q2OzNEfTQHWzlz1NCiuNEA==
X-IronPort-AV: E=Sophos;i="6.23,242,1770620400"; d="scan'208";a="57668009"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 May 2026 07:13:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 18 May 2026 07:13:13 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 18 May 2026 07:13:11 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Michael Trimarchi <michael@amarulasolutions.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 0/4] mailbox: mpfs-mbox: fixes and syscon support
Date: Mon, 18 May 2026 15:17:08 +0100
Message-ID: <20260518141712.3597880-1-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 May 2026 16:52:36 +0200
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

Hi all,

This series updates the Microchip PolarFire SoC (MPFS) mailbox driver in
U-Boot.

The first three patches contain a set of bug fixes and cleanups to the
existing driver, fixing MMIO size calculations, and removing invalid
mailbox channel and private-data handling. These changes are independent
of any devicetree updates and fix issues present in the legacy driver.

The final patch adds support for the corrected, syscon-based devicetree
bindings for the MPFS mailbox. Linux has moved to this binding to more
accurately model the hardware, and U-Boot already supports the same
approach for the MPFS clock controller. This patch updates the mailbox
driver accordingly, while retaining support for the legacy binding for
backwards compatibility.

The final patch is required ASAP as boot is currently broken on master
for MPFS generic boards.

Tested on a PolarFire SoC Icicle Kit ES.

Thanks,
Jamie

Jamie Gibbons (4):
  mailbox: mpfs-mbox: fix MMIO mapping calculation
  mailbox: mpfs-mbox: fix Driver Model private data handling
  mailbox: mpfs-mbox: fix driver bug and cleanup
  mailbox: mpfs-mbox: support new syscon based devicetree configuration

 drivers/mailbox/Kconfig     |   2 +
 drivers/mailbox/mpfs-mbox.c | 106 ++++++++++++++++++++++++------------
 2 files changed, 74 insertions(+), 34 deletions(-)

-- 
2.43.0

