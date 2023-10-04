Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF39E7C4E7
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0DB987599;
	Wed,  4 Oct 2023 18:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bD9i/EsJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4ECC87572; Wed,  4 Oct 2023 18:56:38 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7242A87599
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 394GuUKw128947;
 Wed, 4 Oct 2023 11:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696438590;
 bh=fKzZt/yct2bXoGcpmFaYxzuAUp18QHe3lvQarApiJlo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=bD9i/EsJcYl8aXZ3qoX70JUA9l7IlTAXvkk0ZvZWFq9aIN35VN/oiNxbU7fW4g4ys
 Fv72wyr3r4WG6ZX5re6a2RLOKD+DFBefu2y62tcadmdyuf4ueazhOCarXsUkyEqGAs
 cJKX5ghkyko5lZX2Pjbbo/gmrQpKQFbOFVrb8mc8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 394GuUnV109550
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 4 Oct 2023 11:56:30 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Oct 2023 11:56:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Oct 2023 11:56:29 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 394GuTPe079573;
 Wed, 4 Oct 2023 11:56:29 -0500
From: Reid Tonking <reidt@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <u-kumar1@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <m-chawdhry@ti.com>
Subject: [PATCH v4 1/2] arm: mach-k3: j7200: Add mcu_timer0 id to the dev list
Date: Wed, 4 Oct 2023 11:56:28 -0500
Message-ID: <20231004165629.506664-2-reidt@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004165629.506664-1-reidt@ti.com>
References: <20231004165629.506664-1-reidt@ti.com>
MIME-Version: 1.0
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

mcu_timer0 is now used as the tick timer in u-boot, so this adds the
timer to the soc device list so it can be enabled via the k3 power
controller.

Reviewed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Reid Tonking <reidt@ti.com>
---
 arch/arm/mach-k3/j7200/dev-data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-k3/j7200/dev-data.c b/arch/arm/mach-k3/j7200/dev-data.c
index 4ddc34210e..8ce6796fd0 100644
--- a/arch/arm/mach-k3/j7200/dev-data.c
+++ b/arch/arm/mach-k3/j7200/dev-data.c
@@ -46,6 +46,7 @@ static struct ti_lpsc soc_lpsc_list[] = {
 
 static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(30, &soc_lpsc_list[0]),
+	PSC_DEV(35, &soc_lpsc_list[0]),
 	PSC_DEV(61, &soc_lpsc_list[1]),
 	PSC_DEV(90, &soc_lpsc_list[2]),
 	PSC_DEV(8, &soc_lpsc_list[3]),
-- 
2.34.1

