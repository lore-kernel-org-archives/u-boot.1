Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F00FC54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 12:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E57A87D9D;
	Wed,  6 Mar 2024 13:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Aq3ZgAOb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3A0387FA5; Wed,  6 Mar 2024 07:38:01 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36E9C87CBA
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 07:37:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4266buq4007281
 for <u-boot@lists.denx.de>; Wed, 6 Mar 2024 00:37:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709707076;
 bh=kxUCZq+7NV4r53rFEY80SBpY3lw0qzka6SR+E6xDasA=;
 h=From:To:CC:Subject:Date;
 b=Aq3ZgAOby/ZvI599W4FKcJNlKsbMAYsjfPYB4uJrJ425N7Mqny6waCCaflVWboHcc
 SJ3seoh80U+D2136OjcNfsqMjtOFxzD1qajuL6p0TVY48eVcFJSW9el8RhKWcME9ti
 cPQJ824PGykHcksbJXGFpryXcLD/ncUnf8XtbZyY=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4266buH1008449
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Wed, 6 Mar 2024 00:37:56 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 00:37:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 00:37:56 -0600
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.68.244])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4266bsdk012351;
 Wed, 6 Mar 2024 00:37:54 -0600
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>
CC: <u-kumar1@ti.com>, <vaishnav.a@ti.com>, <a-nandan@ti.com>, Aniket Limaye
 <a-limaye@ti.com>
Subject: [PATCH 0/4] Fix OSPI bootmode for j7200-evm
Date: Wed, 6 Mar 2024 12:07:45 +0530
Message-ID: <20240306063749.1411176-1-a-limaye@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 06 Mar 2024 13:09:02 +0100
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

Support for OSPI probe and also read/write is broken and/or missing in current master branch.
- sf probe failure from u-boot prompt & OSPI boot failure [0]

This series adds necessary configs, as well as fixes some bugs in the existing u-boot devicetree,
to add OSPI boot support for the j7200-evm device.
- sf probe and update in u-boot prompt & successful OSPI boot logs [1]

[0]: https://gist.github.com/aniket-l/f487472baa47e819defc82e5f57b7860
[1]: https://gist.github.com/aniket-l/e5353c4511009d2ebf5f1743ebaab61a


Aniket Limaye (4):
  configs: j7200_evm_*_defconfig: Enable OSPI configs
  arm: dts: k3-j7200: Fix support for OSPI flash
  arm: dts: k3-j7200-r5-common: fix the mcu_timer0 clock frequency
  arm: dts: k3-j7200-r5-common: Add missing overrides for ringacc and
    udmap

 .../dts/k3-j7200-common-proc-board-u-boot.dtsi    |  4 ++++
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts    | 15 ++++++++++++++-
 configs/j7200_evm_a72_defconfig                   | 10 ++++++++--
 configs/j7200_evm_r5_defconfig                    |  9 +++++++--
 4 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.34.1

