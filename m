Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EE1C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 19:58:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C7A488742;
	Tue, 30 Apr 2024 21:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="asZdPJXO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB4C881DE; Tue, 30 Apr 2024 21:57:59 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 890BB88742
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 21:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43UJvspv027200;
 Tue, 30 Apr 2024 14:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714507074;
 bh=vSqcspdUpvvPrI6xcFQ3fj4pM1VQQg/2+fvJy/Ql75M=;
 h=From:Subject:Date:To:CC;
 b=asZdPJXOIVGrf0cPknTmOvKxgEKCNbgi+Bu14GaEh57Txmf8Y/MkRvncbIKgqOylJ
 Z+xNkGqYTBBnBQMrtg3Ttf/2tycjfFyglKeqOc7eTcdlQH/VHP1Y9+bdt1m8VmEmHa
 A6pAm3xZ+/WqdRm0vU97nKEuZRKPS6brypkWK6aA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43UJvs8r013987
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Apr 2024 14:57:54 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 14:57:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 14:57:54 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43UJvsRA045582;
 Tue, 30 Apr 2024 14:57:54 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/2] introduce basic support for TI's am625-lp-sk
Date: Tue, 30 Apr 2024 14:57:44 -0500
Message-ID: <20240429-am62q-wip-v1-0-927fd2e0a53b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADhNMWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEyNL3cRcM6NC3fLMAt00YxNT45RUA2OLtCQloPqCotS0zAqwWdGxtbU
 AJUeGAVsAAAA=
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nitin Yadav <n-yadav@ti.com>, Bryan Brattlof
 <bb@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=bb@ti.com;
 h=from:subject:message-id; bh=nnwyNuN7irp0YBStbfMhnrjE+KTxnwHznLJ1RiMdxhI=;
 b=owNCWmg5MUFZJlNZv2c7vAAAZn/////vP3/+PxLe8+3fv+t/WtJ+/a+7jX6b9+7unxfov8+wA
 RswIeoAYTQAADQNGjQ0AAADIDQGgNGQD1DTIAaAaAaDIaekaGTCaaGhmmIQyTRkDEDRoZDQB6TQ
 AaMmg0Bo0GjR6jQNGgaGEbQjQNDQDCNNADTQ0aYgBoAIekepkaGgZNDTQNANANDEZAA0AZDEGTQ
 MgNAxAGmTTTEDQAaGhtQyMQaMhpgQSX5A2gf+xgYVHBYoslJh4g9/sqPYq5zphIoW9HiAQCR9Rk
 GTTT2UnoAFWp8IIvHkflc3hwXjwCMalks04EG+vev+uOrd4rtEU3JgMA43lm2/V9FsoOtjd5PL2
 aQC3WXLLSdAugoyK7NDyg9rMQpgH1hhuCA1DwnMpnyEDvddZKDx90yDvpXCpUGTQKQrrkKGpgUV
 GWhjKLrd7xct3bJYcgBS4OkyXBmAiMg7UhNCkvxvNgkYsRKd84hr0JOVHZ7ZcCmWMlWPvD1933D
 6GmymsPqKCJDWPo75zOjo6RbgURwFp6LS5VW/K05LbQshtw0VVVX3YH4yDRNfZguD+VMEbMnmff
 N1pIQYVem8rOVEaZagBKychTYDTjxqUMSSDZzgAgQR0TwS5J5xnGG/qhdVYsSsKaFi+9jwzLAQJ
 BA2GhIpsC4cf4u5IpwoSF+znd4A
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

Hello Everyone!

The am625-lp-sk is a variant of the am625-sk showcasing the low-power 
features of the am625 SoC Family. Because it's essentially a board and 
package spin of the am625-sk I've inherited the am625 configuration and 
overridden what was needed.

This is a new spin of Nitin's original work which has been updated 
significantly since October 2023

  https://lore.kernel.org/u-boot/20231030110138.1347603-1-n-yadav@ti.com/

Unfortunately a few patches have broken the am62x boot currently and 
need to be added and reverted for this series to work:

One to increase the size of MALLOC space to make room for the DM stubs

  https://lore.kernel.org/u-boot/20240429214936.15187-1-jm@ti.com

And this patch (in active debug) will need to be reverted for MMC boot.

   https://lore.kernel.org/u-boot/20240422190035.25852-1-greg.malysa@timesys.com/

For those of us interested here is proof of life using buildroot:

   https://paste.sr.ht/~bryanb/40f7787f7760bee383aa8fbc342a29e8544dbdab

Thank you for reviewing
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Bryan Brattlof (1):
      configs: add defconfigs for the am625-lp-sk

Nitin Yadav (1):
      arm: dts: add U-Boot dtbs for the am625-lp-sk

 arch/arm/dts/k3-am62-lp-sk-binman.dtsi   |   21 +
 arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi   |   17 +
 arch/arm/dts/k3-am62-lp4-50-800-800.dtsi | 2190 ++++++++++++++++++++++++++++++
 arch/arm/dts/k3-am62-r5-lp-sk.dts        |   82 ++
 configs/am62x_lp_sk_a53_defconfig        |    3 +
 configs/am62x_lp_sk_r5_defconfig         |    2 +
 6 files changed, 2315 insertions(+)
---
base-commit: b43a0c7ed600fc608262b9a274a1cad4c7465b6a
change-id: 20240429-am62q-wip-f3453de038fb

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

