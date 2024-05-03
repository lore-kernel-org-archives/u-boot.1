Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B46C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 16:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DFB988348;
	Fri,  3 May 2024 18:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QX3qMhGw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F8DC882F6; Fri,  3 May 2024 18:10:50 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC32188348
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 18:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 443GAkY6071648;
 Fri, 3 May 2024 11:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714752646;
 bh=yJfmsXyyy7A9npHrczeENdnQDiqnvqMCOjV3MgYCosk=;
 h=From:Subject:Date:To:CC;
 b=QX3qMhGwF0djmuGlRMBle5Bw0WmGogI2dYro8GzQYSl7T9GT8RFpPPkh26BKOGF3N
 jrdlpp+8jXnlEGj4RKyPY02OsAb6Lq9ngsScD8O9KfUxk2zc6+OVobdzHu8TDfuISL
 IkJF6h+IQ0QNcQrsEFTg9D5U67NN9ks8Ke1i9ScM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 443GAknO101533
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 3 May 2024 11:10:46 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 May 2024 11:10:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 May 2024 11:10:45 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 443GAjNK049366;
 Fri, 3 May 2024 11:10:45 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 0/2] introduce basic support for TI's am625-lp-sk
Date: Fri, 3 May 2024 11:10:33 -0500
Message-ID: <20240429-am62q-wip-v2-0-e78f09174e65@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHkMNWYC/23MQQ6CMBCF4auQWVtTpkXFlfcwLAqdyiyg2JKqI
 b27lbXL/+Xl2yBSYIpwrTYIlDiyn0vgoYJhNPODBNvSgBK11NgKM53wKV68CKd0oyxJdXE9lP8
 SyPF7t+5d6ZHj6sNnp1P9W/8pqRZStHh2FkmaRvW3lY+Dn6DLOX8B5CNRfJ8AAAA=
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nitin Yadav <n-yadav@ti.com>, Bryan Brattlof
 <bb@ti.com>, Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1626; i=bb@ti.com;
 h=from:subject:message-id; bh=66u2i+MajZhq1C6zKiN+sXJ924InIHNsJAuhob/CP60=;
 b=owNCWmg5MUFZJlNZEbhLVgAAaf////bv7rv+ztn3T+/u+b2r/atrf7V73Msnz5/Zrvb+u++wA
 RjYkPUAAAAD1NDQ0NAGjQABo0AAAeoAAAaAAZAA9QAeoNB6Q9TTTT1Hp6p7SRABkAMmmhpoaaGI
 aNGjEaAwTQGjEyaaAxGgaBiMjI0BoxNNDQAaAZBkAZNPUMobUZMQNA00NPUA0GT0mmmmhpoyBkP
 SDQAMCBoGjQZAGjRoBk0aMjRoANAA0AEFQOEHPl4C/+I9vBFkccL71wkriigigxEir73lloWLIg
 aJ9y5AszoD1jdMoyb9bxVy9oYEnQyjgwpmyKSykVm0VpalBDmqhDahsmbiTdLq70ukIZWYolQHl
 z82YL1ruaFMfhHpmmjXfymsBbhEydttltDZYtlqh3EUfgfZhfQ3BbftbrhOhv4dhgXxofeopUAZ
 rfh9UFurZd9xTFlGcLVGttv/YTr3Da4Ku8pqz47BM4+XXmA0TQDJNjjtM9aIFQTqqPiF7w3fKXy
 L7GbrW+bmLXIYb8QkFlKuNNTIPEdWTarJKwE9LJyC4k6EtSGridRZhdphQwPfZXJz3sWPHUbL33
 2QQAX+bbmH4on7CiPGmDKBFJShaJ+nzAigvOEB0WQaNQZolCa/LwJ62vC727ClV5KKXSaR85SkR
 5YiPeRAL8mPrSyn/F3JFOFCQEbhLVg=
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

Unfortunately a patch is need on top of this series to boot:

  https://lore.kernel.org/u-boot/20240429214936.15187-1-jm@ti.com

For those of us interested here is proof of life using buildroot:

   https://paste.sr.ht/~bryanb/40f7787f7760bee383aa8fbc342a29e8544dbdab

Thank you for reviewing
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v2:
- updated copyright year
- Link to v1: https://lore.kernel.org/r/20240429-am62q-wip-v1-0-927fd2e0a53b@ti.com

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
base-commit: 714d31ca73fe1dd7a8217afc4a9f6a35ef7a9c01
change-id: 20240429-am62q-wip-f3453de038fb

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

