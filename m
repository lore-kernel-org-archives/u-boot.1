Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20065CD1283
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 05:47:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCB3E882F7;
	Mon,  1 Apr 2024 07:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xD8vqTzo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75444882F4; Mon,  1 Apr 2024 07:47:05 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C8FE882E5
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 07:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4315l0HK093152;
 Mon, 1 Apr 2024 00:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711950421;
 bh=KOGIB4DCuxJ7xxbOOAyBtZmMw6GJa/ebbDw+XBbv6zs=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=xD8vqTzoR6E5KuUatMP+ze8yRBiT2Wh9pRm70vIMvDpyi3sJzSGIElpw4kpxGI5Hn
 7Fn3Hu67osQrNfRs2iGxEkkXYWCJmxWbw7GPcw4k3ttGIHv/qOQ+aXPm858+FE6Gax
 3ZduqXeBYzPfrxb09xhjv8XfrcwkLxiXYnupmwSc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4315l0Qs108765
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Apr 2024 00:47:00 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Apr 2024 00:47:00 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Apr 2024 00:47:00 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4315koAF131070;
 Mon, 1 Apr 2024 00:46:57 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 1 Apr 2024 11:16:47 +0530
Subject: [PATCH 2/4] arch: arm: dts: k3-j721s2-r5: Override ospi and fss
 for 32-bit mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240401-b4-upstream-j721s2-ospi-support-v1-2-20e4a0024db9@ti.com>
References: <20240401-b4-upstream-j721s2-ospi-support-v1-0-20e4a0024db9@ti.com>
In-Reply-To: <20240401-b4-upstream-j721s2-ospi-support-v1-0-20e4a0024db9@ti.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Prasanth Mantena
 <p-mantena@ti.com>, Apurva Nandan <a-nandan@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711950410; l=1128;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=CdG5C1yeJsFZdGIpy0S+no2FpkDGABtZFQrCIYIEDEU=;
 b=VRVgk4OegRvPqilZLa/6lfDI4zCwvbkDQ6cbwLWoOl0Mvpgu94qfkzYq6juSdkee3+Tdiej70
 Dw+EunUvz/dDuAJ9S4o5SiQKb8KtQaXQY132unCU9f0PWQXjtTm/vpI
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

R5 being a 32-bit processor can't understand the 64-bit mapping being
done in ospi node. Override the ospi node for 32-bit register ranges and
the fss node ( the parent node of ospi ) to map the ranges for the
updated child node correctly.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
index 03bd680f4421..5c4b34915ccf 100644
--- a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
@@ -86,3 +86,16 @@
 &mcu_udmap {
 	ti,sci = <&dm_tifs>;
 };
+
+&ospi0 {
+		reg = <0x0 0x47040000 0x0 0x100>,
+			  <0x0 0x50000000 0x0 0x8000000>;
+};
+
+&fss {
+	/* fss node has 64 bit address regions mapped to it and since the ospi
+	 * nodes is being override, override the fss node ranges as well
+	 */
+	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
+			 <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
+};

-- 
2.43.2

