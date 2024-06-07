Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AB0C27C55
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 22:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B518D88485;
	Sat,  8 Jun 2024 00:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YFpgN63h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56DB388506; Sat,  8 Jun 2024 00:06:28 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C54CC884CA
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 00:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457M6L80063692;
 Fri, 7 Jun 2024 17:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717797981;
 bh=6bNNtmWbYKMxzR00HtwlHsvE8qceSNomigmBpPiklbU=;
 h=From:Subject:Date:To:CC;
 b=YFpgN63h4Qyb2WUHaFW7bCvHoV4GXrpq4C5je3PozZUVCV0PXg4yAYRt9pnA0JZiw
 8hkn+8wVW/+oA4n6sBuHqiM1xUaUtYwWCbdP2n3qP84qoHcpKEuyFbZYTNmYYkKeiF
 LMGs/6iOq1TL1gYY3El76n7QbMbfeg+EIipaWUww=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457M6LfV071226
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Jun 2024 17:06:21 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 17:06:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 17:06:21 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457M6LhB091374;
 Fri, 7 Jun 2024 17:06:21 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH v4 0/2] introduce basic support for TI's am625-lp-sk
Date: Fri, 7 Jun 2024 17:06:11 -0500
Message-ID: <20240607-am62q-wip-v4-0-3900cdf25721@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFOEY2YC/3WMOQ7CMBBFrxJNjZEztrNQcQ9EkWVMpshmRwYU5
 e44KaigfF//vRU8OSYPl2QFR4E9j0MEfUqg6arhQYLbyIAStdRYiqrPcBZPnoRV2qiWpCpsDfE
 /ObL8Olq3e+SO/TK695EO6b7+qoRUSFFiblskWRlVXxc+N2MPeyLgXw2jRnlhZZnmmjLz1bZt+
 wA/Upe+1gAAAA==
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>, Nitin Yadav
 <n-yadav@ti.com>, Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2372; i=bb@ti.com;
 h=from:subject:message-id; bh=Cyao9san6MkiBEWwVWUWjc2ZYbn0qu0Z9/YuxANjhLA=;
 b=owNCWmg5MUFZJlNZNKomDAAAbP////5Pfm9rm3qv/zNbfV+n7U3+/lwxfsfBe9zZ6FB/+P+wA
 RswHajE0GTRkyNABpoZANNANGgGRoADQaMgAeoBp6jQepkMgM1A00xqaHqMNpQymmBGmQAyBpkB
 iaDTIaDENDQBpoyDJpppk0yAbUwCaBoGQwBoQAA9THQwmQxDBDTIwRpghkwTBDJpo0DIZGmEABo
 YgxMEaAaNDI0aDRoDQYBArqlvlhXHC5jajFH3dONOFQjbRqJes8yU4msP/VaNAPYSCQA5qFK5HZ
 Bcj40GJkJEAy//LzJoOg+HjVqCmnb1fDvnh+Ed34mX1lgl1PJ/bvODs1isX6DAZ7DqSYVcFJSr4
 gHBX+3O/eM38Yt67aSZUAM+LUzcwPv4Y05igtHwL73ygMDBgLONuDyU5YZcosl5zTOvlW4vQtHU
 lHnW/6mYT4rpysZBwm9qUM/I2krVExDLNe9j4QfVD9M1uoiWZJWjejkjd06gYF/w+O8lDag+ymD
 AnwsKfhva01sApSXbtk9OBS+UQOtA8ljzS7bIVYicczCI35y6NPoiA4TCQFafyh80O2RvaRseQE
 EF5VJ6EChdQjkJq2HcUBIWKxGhl7mDUY+6ZN5w64lSlOKTCoU7VhADB7AkQFZk8kBTCs/dGV/i7
 kinChIGlUTBgA==
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

Hello Again Everyone!

The am625-lp-sk is a variant of the am625-sk showcasing the low-power
features of the am625 SoC Family. Because it's essentially a board and
package spin of the am625-sk I've inherited the am625 configuration and
overridden what was needed.

This is a new spin of Nitin's original work which has been updated
significantly since October 2023

  https://lore.kernel.org/u-boot/20231030110138.1347603-1-n-yadav@ti.com/

For those of us interested here is proof of life using buildroot:

   https://paste.sr.ht/~bryanb/40f7787f7760bee383aa8fbc342a29e8544dbdab

This also works around a buildman issue not following #include 
directives. To get around this I've redefined the variables it's looking 
for inside the lp-sk defconfig to keep it happy for now. I made a pull 
request on github and everything seems like it's happy

   https://dev.azure.com/u-boot/u-boot/_build/results?buildId=8634&view=results

Thank you for reviewing
~Bryan

Cc: u-boot@lists.denx.de
To: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>

Changes in v4:
- change the defconfig name to match previous older versions
- include needed CONFIG arguments for buildman
- added a MAINTAINERS entry for the board
- Link to v3: https://lore.kernel.org/r/20240429-am62q-wip-v3-0-17dcfdb1075a@ti.com

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
 board/ti/am62x/MAINTAINERS               |    4 +-
 configs/am62x_lpsk_a53_defconfig         |    8 +
 configs/am62x_lpsk_r5_defconfig          |    7 +
 7 files changed, 2328 insertions(+), 1 deletion(-)
---
base-commit: 227be29df37545f74243a98c12a4a33c4160e3cd
change-id: 20240429-am62q-wip-f3453de038fb

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

