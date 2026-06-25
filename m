Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0566CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 13:01:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE9B849CE;
	Thu, 25 Jun 2026 14:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="Chqn3Whn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2597684949; Thu, 25 Jun 2026 14:20:14 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC6DD8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=629d8e15b=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782390012; x=1813926012;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cuVs65vlktKAL3lXOYO5AYOYZ17PPG7bK1X91raxtnQ=;
 b=Chqn3Whnr32QbtBMBr6zbEUIvQ2JmUqtQi8qc0PSM8MyTRuxSz93t+7D
 3TV950kRsEzfqw8peMugWfViJq4hK0xJwk9bwK9sWqRNX/mkBZCQ3ifFw
 jl3oEbc/CvhQDrmCPvX0nWrE7d+/Nh3McPOkLABnUcYQDwjkjo++syCNR
 brmA02Djh8CQLURHVnwr2lFO9mMDUunrAzg/d79+RReI3J+uS2neOn59a
 R4wmoTI8Vzi4cij1OmztguhVBaMGaxY3YbZNRM+bAsyajXzAi74cCH2Xu
 qdj/lTMlz0TnxCLz6XNzu3E012sfru/lJbnCESDsjIpcslpp8wFy/D2zR w==;
X-CSE-ConnectionGUID: rgK7xrTFTaGDqeYCWTW16w==
X-CSE-MsgGUID: 2xmObo9nRb2nkq1ijYilNA==
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="59667869"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 05:20:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Thu, 25 Jun 2026 05:20:08 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 25 Jun 2026 05:20:05 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Sughosh Ganu <sughosh.ganu@arm.com>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Martin Herren <sputnik@on-the-web.ch>,
 Michal Simek <michal.simek@amd.com>, Adriana Nicolae <adriana@arista.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, <jamie.gibbons@microchip.com>
Subject: [PATCH 5/8] configs: microchip_mpfs_generic: enable MPFS RNG support
Date: Thu, 25 Jun 2026 13:23:22 +0100
Message-ID: <20260625122325.834568-6-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625122325.834568-1-jamie.gibbons@microchip.com>
References: <20260625122325.834568-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 25 Jun 2026 14:58:57 +0200
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

Enable the MPFS hardware RNG and associated infrastructure in
the Microchip PolarFire SoC generic defconfig.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 configs/microchip_mpfs_generic_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/microchip_mpfs_generic_defconfig b/configs/microchip_mpfs_generic_defconfig
index 66acaad7e9b..e3d794f08b9 100644
--- a/configs/microchip_mpfs_generic_defconfig
+++ b/configs/microchip_mpfs_generic_defconfig
@@ -21,6 +21,7 @@ CONFIG_SYS_PBSIZE=282
 CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_SYS_PROMPT="RISC-V # "
+CONFIG_CMD_RNG=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_BOARD=y
 CONFIG_OF_LIST="microchip/mpfs-icicle-kit microchip/mpfs-sev-kit"
@@ -29,5 +30,6 @@ CONFIG_ENV_OVERWRITE_ETHADDR_ONCE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_DM_MTD=y
-CONFIG_SYSRESET=y
 CONFIG_DM_RNG=y
+CONFIG_RNG_MPFS=y
+CONFIG_SYSRESET=y
-- 
2.43.0

