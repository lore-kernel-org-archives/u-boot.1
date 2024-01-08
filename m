Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13208C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 08:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E398B87A30;
	Mon,  8 Jan 2024 09:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vrEmjITG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 500418773E; Mon,  8 Jan 2024 09:19:01 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1762877DE
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 09:18:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4088IrqE012037;
 Mon, 8 Jan 2024 02:18:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704701933;
 bh=4e8ZZGLE6d/A6JbLExinfIf/9oQev52g+wLx2tAU8hI=;
 h=From:Subject:Date:To:CC;
 b=vrEmjITGPXf/NU+ub5l3R1SlptkSrfu6ertWnSziRgBs7oQd1SWqALfeES4qwLXbE
 vI66l9Hlw25pyeFBKt41kEhdKCoxzSUbpbdIRm+1b5vkcV4eOIbmyAbNC8JO41i7d9
 ZqcK88EyVYxxGnDuexg7brPL8ApTiE8UWRHimp5g=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4088IrmO001326
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jan 2024 02:18:53 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 02:18:53 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 02:18:53 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4088IpIf030312;
 Mon, 8 Jan 2024 02:18:52 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH 0/2] Boot fixup
Date: Mon, 8 Jan 2024 13:48:47 +0530
Message-ID: <20240108-b4-upstream-fix-semicolon-v1-0-9437b3dc90ea@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOevm2UC/x2MQQqDMBAAvxL27EISTKt+RTwkum0XTCJZWwTx7
 4YeB2bmBKHCJDCoEwr9WDinCqZRMH98ehPyUhmstq022mFo8bvJXshHfPGBQpHnvOaE4fG0i/E
 uuL6D2m+FqvB/j9N13cKvoZ5rAAAA
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704701931; l=712;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=nChPH8KKs/gBhJ0pAwqtuN4Q7SXjAzPoLAmL8LODMEA=;
 b=CpZJhTD27gBYwNZeARGgKLlcJRGoJ7XwUOeF8nyCsUuU7lM6XJznBWIcHRTDeyGNm68R3KA6B
 GBC5BDw3Vf4Dui6lgQ1meR7iA3WS7zKu250jK2KGZguoAi6rlK+C+j6
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

This series addresses some regression caused by commit 0d72b0f2f83b and
additionally fixes the commit as well to do what it was intented to do.

Boot logs: https://gist.github.com/manorit2001/dfb8d92bb737d774c4296cefa765ba10

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Manorit Chawdhry (2):
      include: env: ti: ti_common: Fix a missing semicolon
      include: env: ti: add default for do_main_cpsw0_qsgmii_phyinit

 include/env/ti/ti_common.env | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 2b28c3b871cd5d55b19f0a86cef970139f8ab952
change-id: 20240105-b4-upstream-fix-semicolon-b672d1a5b598

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

