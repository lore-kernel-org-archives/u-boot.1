Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2ABDC44532
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 00:52:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 055FE40A1F;
	Thu, 23 Jul 2026 00:52:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LjVWAancfXCV; Thu, 23 Jul 2026 00:52:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1AA2240A21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784767949;
	bh=wvMfzqwKbwS/K4JvSl7DMkrZTDcyt/3eaNvY7UYQob8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wC+xBR/pVoPxAz2eHsFtVn7oGALZRjz4YExoQeDC6csUlSXFOTrIqLYCiHPTF6/41
	 rwP7YW2ArAAgIz7R8/zjNhbuQM8uhi9qOjWh2YH51v1Ws5tl7rXqJCf0jWgPOp1ELK
	 dvgjo1Xwz9AC3Wv8G1KujK+t8Iey55+ITespve7KMl+fwd4KngOGm4hK0BHx4OIcMI
	 dGICSINOYdK6dqPEwl8n4JAQyzGzPb1RnC3llJxPYy92X40d30RzZkt/MT+qLmE5l8
	 WjIpyDxbK05RSmFDpyhoJKItDei47y9wKd2Egih/NvRoq0fbgIbPInlYkcGdE0ZZ83
	 yFNXF3Vp0glAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AA2240A21;
	Thu, 23 Jul 2026 00:52:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9698742A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 887D7400B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vSYT6slRAuih for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:43:19 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=prvs=656eedf95=jamie.gibbons@microchip.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4016640100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4016640100
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4016640100
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9192D848BA; Wed, 22 Jul 2026 17:43:16 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EB008494B
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:43:12 +0200 (CEST)
X-CSE-ConnectionGUID: I1opQNTTROKo4hlOrSXntA==
X-CSE-MsgGUID: TA4L6OgxSESHpWlK/ZV4Ug==
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="60147590"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 08:43:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Wed, 22 Jul 2026 08:43:10 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 22 Jul 2026 08:43:08 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 "Leo Yu-Chi Liang" <ycliang@andestech.com>, Sughosh Ganu
 <sughosh.ganu@arm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin
 Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>,
 <jamie.gibbons@microchip.com>
Subject: [PATCH v2 4/6] configs: microchip_mpfs_generic: enable MPFS RNG
 support
Date: Wed, 22 Jul 2026 16:45:47 +0100
Message-ID: <20260722154602.3373184-5-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722154602.3373184-1-jamie.gibbons@microchip.com>
References: <20260722154602.3373184-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 00:52:16 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1784734992; x=1816270992;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Je/hT5UF9dagvddsZK+WJJnPglHDxvmVQIApil3Inmg=;
 b=SA4Y9x2UFYrbcmlvjndzRsNgwpOVG2ueXQn7qbplbKuFUaIiu9eTKXmc
 YbbT+0u43NQndJ6jOPddaHmL7b/FuHcQfX+B1dw6ui4rW1HDtLRAUt5me
 kCAo51NBWUjve0kRLDy6oxMsFQeK2xOgma+nOQBpjv8XE8St1Gzfw6sXE
 XOhE0h6xrBTaZ3u4xokugV04TtgEEJpYkcpCJ1S2Kf0AchU7mc6XYFH8U
 ZnWPzNTl0s56ATqaLhMqn46c28ADmkm+6GYz67JroY4j2Ynjq+0AroL+J
 /4k3aGvkdTgVu69l5HCI5SAsFCnve2ArJ48wV0p49GvfTAbJJAJ/Ft1tY
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=microchip.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=SA4Y9x2U
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=microchip.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=656eedf95=Jamie.Gibbons@microchip.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.b="SA4Y9x2U"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable the MPFS hardware RNG and associated infrastructure in
the Microchip PolarFire SoC generic defconfig.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 configs/microchip_mpfs_generic_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/microchip_mpfs_generic_defconfig b/configs/microchip_mpfs_generic_defconfig
index 973ed09fa87..e3d794f08b9 100644
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
@@ -29,4 +30,6 @@ CONFIG_ENV_OVERWRITE_ETHADDR_ONCE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_DM_MTD=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_MPFS=y
 CONFIG_SYSRESET=y
-- 
2.43.0

