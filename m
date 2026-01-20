Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1DECA5FA6
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 16:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21CCE83B49;
	Tue, 20 Jan 2026 17:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="2HrFhtOJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B087183A9F; Tue, 20 Jan 2026 16:29:09 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43EC583A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=47332a659=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1768922946; x=1800458946;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=k5wy+zKET4KLQQU3QYGTXDTm/L+Hfi8PkcyTMoT++ks=;
 b=2HrFhtOJYS1NXfcijmguYnULpoT4SL7lGKElXEYp8+qtwVtbQzMaJ61g
 LiHxuW/+hHMin/lDQcl25N8ZMD/A/Hr5qR5AF2AM37rOBxjkrpB5Jiomi
 tNxy8oZ2d6IHVQIwn3bHWETblDDTuM0uu9jrH7ruehVI2ifRtES1EXPAL
 b8X2uN57ycYuYtyS21R10otHj3fHsNa5K8jGjkoASvkFC35JQ6/TCKaOD
 eiQqdvvcTDlXaZrmleJGgW94qEX0mUO1lcFx6WvSkxU0oDyPNotODwBmK
 1bm051jy54DwX5Y71ZBy8de59ZmMjw4eNiPPR8+R+zdXKxiKMTfHuU0Jq Q==;
X-CSE-ConnectionGUID: aoX0kG6qQZyw2MNImWKp+w==
X-CSE-MsgGUID: ZSKHngjPTB63IYjHMRqVyw==
X-IronPort-AV: E=Sophos;i="6.21,240,1763449200"; d="scan'208";a="283531037"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 08:29:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 20 Jan 2026 08:28:25 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 20 Jan 2026 08:28:23 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Leo <ycliang@andestech.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Cyril Jean <cyril.jean@microchip.com>,
 <jamie.gibbons@microchip.com>
Subject: [PATCH 0/2] Fixes for boot failures
Date: Tue, 20 Jan 2026 15:33:11 +0000
Message-ID: <20260120153314.95091-1-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 20 Jan 2026 17:15:29 +0100
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

The following series includes two fixes for master causing boot failures on
Microchip's PolarFire SoC Icicle kit. The first fix is for "failed on
fdt_open_into for DTO" on dtbo application. This is an issue with overlay
alignment that is fixed with a oneline change in the fit-image.c. The second
fix is for a boot failure introduced at commit 217cf656e24
("dm: core: Default to using DEVRES outside of xPL"). The value of
CONFIG_SYS_MALLOC_F_LEN needed to be increased. Please see the individual
commits for a more comprehensive breakdown of the issues.

Thanks,
Jamie.

Jamie Gibbons (2):
  boot: Fix dtbo application by ensuring overlay alignment
  configs: microchip_mpfs_generic: fix boot failure

 boot/image-fit.c                         | 2 +-
 configs/microchip_mpfs_generic_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0

