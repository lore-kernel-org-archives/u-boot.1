Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B01CCA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 12:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E580583314;
	Tue,  2 Sep 2025 14:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="I+q2lFXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF1C283A6A; Tue,  2 Sep 2025 12:07:32 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69CAA83A91
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 12:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=333b0acd5=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1756807650; x=1788343650;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5X8+FY8+JOOGV+S0f5pH638WWf9rzIGdVgcOHpevhFg=;
 b=I+q2lFXi0704KtutnSzmf5KPo+WjbEoIZVLEJeotz2ITNkpC83hzhAKu
 ygH0huRZBgA2vnjLxKPiy1k6VrON/OIIteuAbr2y3DTq5ao8D18vF50wR
 3XLXVaeGT6zpa/uTTWDzpM9fjgIjsGvIplp8e3jAiwkqBj9L/XYbOSeBt
 euM2Xcuwod+Eear8d4pHJeawo8BYOXn68gq8q3uuy2hRGCGFvHRHksdcq
 OOzRmGbpxfSKoAXzJRBvAd9o+3mg75RqjiQkHABJWE04nW/XSBUf4ragb
 c32NnFV6bj7TSRm8KQlIIPvoLTpRuhGeWY6EVPXF8r8L4Uo4iEas74iRm Q==;
X-CSE-ConnectionGUID: U8DGPTI1SzmpoHU1gTA8dA==
X-CSE-MsgGUID: uaOB8ux1QJWqfn3tme0mTg==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="46493800"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Sep 2025 03:07:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 2 Sep 2025 03:07:21 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 2 Sep 2025 03:07:19 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Cyril Jean
 <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 2/6] configs/microchip_mpfs_generic_defconfig: add board
Date: Tue, 2 Sep 2025 11:10:59 +0100
Message-ID: <20250902101105.3218793-3-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902101105.3218793-1-jamie.gibbons@microchip.com>
References: <20250902101105.3218793-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 02 Sep 2025 14:59:00 +0200
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

Add board support for MPFS video kit.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 configs/microchip_mpfs_generic_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/microchip_mpfs_generic_defconfig b/configs/microchip_mpfs_generic_defconfig
index 0ed0cae93eb..22f67414a7c 100644
--- a/configs/microchip_mpfs_generic_defconfig
+++ b/configs/microchip_mpfs_generic_defconfig
@@ -22,6 +22,9 @@ CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_OF_UPSTREAM=y
+CONFIG_OF_BOARD=y
+CONFIG_OF_LIST="microchip/mpfs-icicle-kit microchip/mpfs-sev-kit"
+CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE_ETHADDR_ONCE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOOTP_SEND_HOSTNAME=y
-- 
2.43.0

