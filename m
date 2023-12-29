Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A04C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64B3687BAC;
	Fri, 29 Dec 2023 18:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Zt8f7d5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C6D487BC8; Fri, 29 Dec 2023 18:47:14 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D05C687BB4
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl2tL088979;
 Fri, 29 Dec 2023 11:47:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872022;
 bh=TZvx6Cy1ABtrL/J6vxhmpAytdr2cmliFvIm6R9hNOX8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Zt8f7d5UN1lzy3rc6ErFFybfEotb8RAha+g5CngTE5eVLC0g8g3j7aCeuzBEsKCab
 t9CWRpqtv1KcbWmcq9/KIHUQBnYjSsqNWSlyZ31/2618/orcGZExFMxdXUHWrA3Idm
 Th7a0vQDdjPRI5Y8kMPmScad9phc8TkSt6szOoMw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl2mb115383
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:02 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1OZ122726;
 Fri, 29 Dec 2023 11:47:01 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 23/26] arm: dts: k3-am654: remove un-needed aliases
Date: Fri, 29 Dec 2023 11:47:20 -0600
Message-ID: <20231229174656.634065-51-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=605; i=bb@ti.com;
 h=from:subject; bh=LW2ZNtISRnvuD4k0ITt/xFTXgLAkQz42vo/M2JMysA8=;
 b=owNCWmg5MUFZJlNZEzBsiAAAbP///n/P1/f0nt76t1+7/hf7/dPv+O/Q7/5D38vp6P/Wm9YwA
 RsYGKAAPUA0ABoANHogGQAaAAAMmnqAABo0aDRoHpAaABkPSPUaeUGaMmogAGjIADID1BoANqep
 keoAABo0yNAHqaA9QMENA8oDT0nqA9QeoHqA9QyBoGgchiMIZAwjQyaANGmJpgQGmQAGIBphGmI
 YJhMEA0AaZANGQAAyAACBbwW1ChDizmCSMeTFCydGvAEo6N4/IOU7hckAprRnJgdRok36/4SpSR
 ibFAbZNCosP3ZKiiOMhBs2OlL9t0EhDYGFThwy072iK7JLmxV7MLxcNXGotRn1wcSsaCNm6Hy1R
 LuIrCJ3ZAlWlNGEBzBgAXR4N3ARUf7kv3kO9h2SdiOg4riEcWvKAvAOa3y1U6+PXKUqM6mNMv1D
 Btieu29MWSEYgUrPTyXCGWX0qOwY85eg57+51cauPixLBqQsjAOpOfleIslMWM5rA0K1tYr2RHI
 reSXGRGQlVhKcIHyqtjxLIQGMKGF+a4RiOqA92S48IcaVrMUI7TgDnficx816UxZKToUYJj6zj4
 QMHIVLzMxGCUlU+A5X42bFwDRaECVS+aS2TMcoPeNanBTDZY11SoIclGMJ9AnjYFRRW+J/i7kin
 ChICZg2RAA=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

These aliases are not needed in U-Boot. Remove them

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index c039300c3cbb3..9926981c661a0 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -12,7 +12,6 @@
 
 / {
 	aliases {
-		ethernet0 = &cpsw_port1;
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
 	};
-- 
2.43.0

