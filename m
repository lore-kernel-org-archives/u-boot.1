Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4581C021A1
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 08:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5DD7803CC;
	Tue, 11 Feb 2025 09:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nu5IE9Tn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C21CB80079; Tue, 11 Feb 2025 09:29:07 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F2B980079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 09:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51B8Sggg3661943
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Feb 2025 02:28:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739262522;
 bh=1VlYJ4PkpfuP+V4c1zO06/XJfXZWsHJ5kvoIbaT18fA=;
 h=From:To:CC:Subject:Date;
 b=nu5IE9TnCUuxNBEjZSPkdgTycketDwuJZqdR//21/Lhu7Qn1JqyEcUdwz3PFXXngx
 +UL4wYsKhZRgbd0EpuBAbhopVa0VZ6HmNncUHp2qt2qm+JkPVKE8bXj4O/c0IOQdak
 vjrAIukRJ9whEhjI9XNTkXeMBJqiGSpd3Qyuj128=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51B8SgVm086516
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Feb 2025 02:28:42 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Feb 2025 02:28:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Feb 2025 02:28:41 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51B8Sc9Y109021;
 Tue, 11 Feb 2025 02:28:39 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>
CC: <mkorpershoek@baylibre.com>, <ddrokosov@salutedevices.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <a-chavda@ti.com>,
 <a-dutta@ti.com>
Subject: [uU PATCH 0/3] FIT Image Boot Fixes for am57xx_hs_evm 
Date: Tue, 11 Feb 2025 13:58:35 +0530
Message-ID: <20250211082838.18766-1-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The u-boot is unable to load the FIT image due to incorrect
boot arguments in case of am57_hs evm as can be seen in [1].
This series introduces multiple changes pertaining to several
environment variables and overlays that are responsible for
successful [2] loading of kernel image.

Test links:
[1] https://gist.github.com/anuragdutta731/7bbf0df73dd1e3327765f1807d337445
[2] https://gist.github.com/anuragdutta731/5244174c9b9556fd89132c8d72ae2d8b

Sinthu Raja (3):
  include: configs: Override get_fit_config to get FIT config for AM57x
  configs: omap5: Enable custom mmc boot to distroboot for AM57x
  include: configs: omap5: Add support for FDT overlay

 include/configs/ti_omap5_common.h | 27 +++++++++++++++++++++++++++
 include/env/ti/mmc.h              |  1 +
 2 files changed, 28 insertions(+)

-- 
2.34.1

