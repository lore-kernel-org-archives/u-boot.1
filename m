Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352A8C10F16
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 16:44:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D6F3882D7;
	Fri,  3 May 2024 18:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wEG8vAaD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D1AD8829C; Fri,  3 May 2024 18:44:40 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E256882A5
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 18:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 443GiZlv018123;
 Fri, 3 May 2024 11:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714754675;
 bh=g5xONcJP7tYw3wVaxkMBG5bhxS4asNV3QlsMLpMtJzo=;
 h=From:Subject:Date:To:CC;
 b=wEG8vAaDdm0OH7sAl+8wl9P3QOS7DysSZVXUgOD3U0O3HNuSYRgE86R8LuozVfXg3
 LamSvqfXqKnR0v4WshxJpYKbqtHfs+Wf6M7j+0nkDot+EjIOKUhYfRfWW2caAepV6p
 mCEt817A0s4R4IQolPobNZkakj0ch5y44ts1XnH4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 443GiZ9h051025
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 3 May 2024 11:44:35 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 May 2024 11:44:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 May 2024 11:44:35 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 443GiYd2104171;
 Fri, 3 May 2024 11:44:34 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH v3 0/2] introduce basic support for TI's am625-lp-sk
Date: Fri, 3 May 2024 11:44:27 -0500
Message-ID: <20240429-am62q-wip-v3-0-17dcfdb1075a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGsUNWYC/3WMOQ7CMBBFrxJNjZEztrNQcQ9EkWVMpshmRwYU5
 e44KaigfF//vRU8OSYPl2QFR4E9j0MEdUqg6arhQYLbyIAStdRYiqrPcBZPnoRV2qiWpCpsDfE
 /ObL8Olq3e+SO/TK695EO6b7+qoRUSFFiblskWRlVXxc+N2MPeyLgXw2jRnlhZZnmmjLz1bZt+
 wC4Zmji1gAAAA==
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nitin Yadav <n-yadav@ti.com>, Bryan Brattlof
 <bb@ti.com>, Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1767; i=bb@ti.com;
 h=from:subject:message-id; bh=N+ONEE3Xeq/G0uQE5WS6pOz2SvMzLehYYxT0eWyyWt4=;
 b=owNCWmg5MUFZJlNZpADjawAAbH/////9u2f5r+/b2xdPVfXbq/7r7ZfieVtr737f9NL1j9+wA
 RrbKOQ9TQGj1APUAANAABkPUaAPUAABo9RpoDJoAAAAA9QD1Mmho8oNqaaPU09qRBpkaNNAaMjJ
 oaA0BoaDRoGjEYmgADJiGmRpkNBkxqaGgPUMTATTINDQBkBoO9UPUaaekaAD1ADI0NBoPUGRoBi
 DIAABoDNQAyA09QADQ00AG1AAB6g/SgQSqFo2+IvBHU8d1C+p5ZSDHYQi3bhmU3bOmnZeM9mkrE
 oDBEnNjUiDZK+O8CukPMDEkYEOHiHc4ON+khsVdQGkeaM0RfadxMpKk7yAO6bcK7Vqo8rKPM8Pm
 QlZ8EFWAjRPI5bSSldx5qNNyJi4LL560QQ4y8/zuf9QD/43AXnO3QqiHvjQAAr+lOrDBDIPVV4j
 wMYpktyvfc1kS1bDZecKSQQeHnuvd0U1d3KeZQfSHGbd6J92qWchHLrpjZ4bhaLQCqAGUqX6ZC+
 4hZrVXpl2lXZp3oxLyRBs5Uf2FngDgomBah88hWNSiKZqQ0+jaj6z36qZoIcYr8tgYJE5Yonc4y
 8/WQUIlej9kYSWSUhB51n2w/fmpOhjQhamAMt0Vl/TjQQyRIrehpQH0xxbBpMlLCgHio9xmkAEm
 zOrV7T/F3JFOFCQpADjaw==
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
Changes in v3:
- actually update the copyright year
- Link to v2: https://lore.kernel.org/r/20240429-am62q-wip-v2-0-e78f09174e65@ti.com

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

