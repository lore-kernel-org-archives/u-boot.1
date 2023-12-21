Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7690FC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 971FF878F1;
	Thu, 21 Dec 2023 18:44:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X2dpZwPk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8854C87907; Thu, 21 Dec 2023 18:44:27 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB1D878C8
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiFLo118533;
 Thu, 21 Dec 2023 11:44:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180655;
 bh=mVKfme1FFq29KczIj/St+SA9299leNXm9PiUGOjIvxI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=X2dpZwPkCTootrWT3FPnAz/adn6lXm/GMity5Di5imXKYk9zwMfMFWFIJMlmPZrWx
 ZBIE1A2iEPUTgC9yc3P2E/zFEgTxJ8DV8mDXVD9GSbTZHtdRg0dDextdAgagU5jF3Y
 xPefXXmmFunZekVKk7Bf4CPxtqTzLp87yfzV5dyo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiFtb025805
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:15 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:15 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEGL080260;
 Thu, 21 Dec 2023 11:44:14 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 23/26] arm: dts: k3-am654: remove un-needed aliases
Date: Thu, 21 Dec 2023 11:44:09 -0600
Message-ID: <20231221174412.210807-24-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=563; i=bb@ti.com;
 h=from:subject; bh=Jt/dzB5S2CfZTFZ+JggWMoZeHhgBpsNDyK5lHJyv+D8=;
 b=owNCWmg5MUFZJlNZcGVDbQAAZ3/////9fzGtnU+SbW8+/tdv9fdm97Z3fHtV77pP1B/x+3+wA
 RswGKaMgGgADQNABiaekDRpkAGmgADQMmgDTQA9QANGmTQPU0yHqaaehqNNM1PKHI00BkAD0EaB
 o0NNGjEYQeUAM1GIeo0GTRo0aDR6IMg00AAAep6gAGmQ2oB0GmnpDIyaBpoGmEGQGJkNNNDE0aY
 E0GBNBoAAwQGQaBiGg00GQAyNDADBwpc61/B4C9uvAFEpqdrCMpTaPAYQeBXSVzNCKBAbaTvBMJ
 G21P+0R3VV0M2/cTcKFlTHAxOQ5IZ5OqZ6CwV9YVwgoIxG+SSYk5tOjjIT04kDOZuQ+X97Basv4
 hNTmuImY5wqxpIooIDWIA3NQf+0cbkai47xVxjMZdz+SQOn5jhzfbFhjOrpOh7VaVPsKVi5efM1
 uGM4Z0NOEgIbKjDQSqZAJWumxWnhHKnZZMG0aAHaI/4dxvq51QQJL7zEZ3XDi0i4+1z6k0j90zA
 1Eo48vBDY6iwFXzyKEclnRsrG6T68I4hB+EzwdIRli6XpDCTcisAVCBebq4LXNeKOO/hLTjdLZF
 /yrO8jiHo1JF7wvTCAEJj9vRwXfsGGeoMlECzJdNHbwvfvnEUdePwz2DuzZJOoJuAZHkCeMFJCD
 JLckr/F3JFOFCQcGVDbQA==
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

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 4d543d430a4b0..b84fdb5d86482 100644
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

