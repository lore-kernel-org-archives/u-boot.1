Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E08CA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 12:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C12C083AE9;
	Tue,  2 Sep 2025 14:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="BSFxgj91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 875A283AC5; Tue,  2 Sep 2025 12:08:16 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BB5983AAF
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 12:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=333b0acd5=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1756807692; x=1788343692;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8CqirUOxdpOvVTCKm0FJ8i/lukZnnC+wvrEiGPYCx+E=;
 b=BSFxgj91sZYb8mdBt9ZPxFVBF/kdfd3Z2b4qBBVDfpCOWsBzy85Y+0f1
 rfAqzYshs9a2ZKJyWVPFwkLPdEQaNItth0Z9JC7iZTEdRh2CDlWQUd675
 duRiyd7h4ivUlxR8xeNBbh9s1pC6bVY3GAiOFuJv481uL2LFNBSHc/7s5
 0FwJR955llqgJdnnUnNRU+/y6Pt+/alNx8VLhr+D3cHTa+aYsosix/K1p
 hNMPO2XEKna3DWZIqpE+PXRmcnA7r8ZESMk2JBAIi1Km020LSde4sRVOl
 XOkBuFFfrUDn0wmpnbEG9FE2oiXovRyS/mIcn7AeklteoTdBdVZHxvBmF Q==;
X-CSE-ConnectionGUID: JT66SDXQQWy8/gAC9Q5PjA==
X-CSE-MsgGUID: zUKLrqr+TNij/uDhJkvT8g==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="46493827"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Sep 2025 03:08:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 2 Sep 2025 03:07:45 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 2 Sep 2025 03:07:44 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Cyril Jean
 <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 6/6] board: microchip: mpfs_generic: include processing of
 dtbos
Date: Tue, 2 Sep 2025 11:11:03 +0100
Message-ID: <20250902101105.3218793-7-jamie.gibbons@microchip.com>
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

Include the use of the process dtbo functionality added in the MPFS
system controller driver.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 board/microchip/mpfs_generic/mpfs_generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/microchip/mpfs_generic/mpfs_generic.c b/board/microchip/mpfs_generic/mpfs_generic.c
index 739a9b6cd76..fac4b6aecba 100644
--- a/board/microchip/mpfs_generic/mpfs_generic.c
+++ b/board/microchip/mpfs_generic/mpfs_generic.c
@@ -172,6 +172,8 @@ int board_late_init(void)
 		}
 	}
 
+	mpfs_syscontroller_process_dtbo(sys_serv_priv);
+
 	return 0;
 }
 
-- 
2.43.0

