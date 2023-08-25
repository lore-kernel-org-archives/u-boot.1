Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B36DC3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 11:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6769486A15;
	Fri, 25 Aug 2023 13:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="L1xPdPRS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F9508622D; Fri, 25 Aug 2023 13:17:42 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1B8686898
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 13:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37PBHbuC009509;
 Fri, 25 Aug 2023 06:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692962257;
 bh=1gheVAjEK5Z1EnyZChceUQFjwlpCePtXaiiHQ9Tn4a8=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=L1xPdPRSWGM2k9f65m3Ixqp8FrGU01pwjf3pl34Z3k09+NVHD4C6lyR3C6ABxd3Mg
 OppRRkbpGQH+YsXv1aiVpS+35dYPpO3P3lxbsgjNkliSK3mQAZS+C0BVsxDT+2xq43
 qC4HkfFMlDjtoxKB/XD5hbjPO+XpGiE18fT1tXig=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37PBHbH6095159
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Aug 2023 06:17:37 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 06:17:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 06:17:37 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37PBHQC7023435;
 Fri, 25 Aug 2023 06:17:34 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 25 Aug 2023 16:47:00 +0530
Subject: [PATCH v2 2/6] arm: mach-k3: j721s2: Add mcu_timer0 id to the dev list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230816-b4-upstream-j721s2-r5-pinmux-v2-2-a5f141be40bc@ti.com>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692962247; l=748;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=LbeEpgl8iezI3J4iu7NfWP0yC/5xWjvKcHGDTlxeE4A=;
 b=io+aodYLuDFCPlNz48E4xMihGkr8BrNlcvmdAUELz/rxbQKtV6lXI5ltTSNQ/px80LeDVJXXY
 Ljp7VjzGje3A3TEvaSwfjfhpJZHFupwW4017t5EKdDkRs+4sHjTIoCf
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
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

mcu_timer0 is used by u-boot as the tick-timer. Add it to the soc
devices lsit so it an be enabled via the k3 power controller.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/mach-k3/j721s2/dev-data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-k3/j721s2/dev-data.c b/arch/arm/mach-k3/j721s2/dev-data.c
index 8c999a3c5a8b..df70c5e5d7c0 100644
--- a/arch/arm/mach-k3/j721s2/dev-data.c
+++ b/arch/arm/mach-k3/j721s2/dev-data.c
@@ -47,6 +47,7 @@ static struct ti_lpsc soc_lpsc_list[] = {
 };
 
 static struct ti_dev soc_dev_list[] = {
+	PSC_DEV(35, &soc_lpsc_list[0]),
 	PSC_DEV(108, &soc_lpsc_list[0]),
 	PSC_DEV(109, &soc_lpsc_list[0]),
 	PSC_DEV(110, &soc_lpsc_list[0]),

-- 
2.41.0

