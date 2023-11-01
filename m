Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437C8C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 14:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4547687595;
	Wed,  1 Nov 2023 15:50:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UUe6S/id";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2E4787596; Wed,  1 Nov 2023 15:50:39 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62C79874D1
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 15:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A1EoQkY013439;
 Wed, 1 Nov 2023 09:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698850226;
 bh=X5VzGpcKueuLEKqMI/+W/xVVOp1dIdvC6IQgH1dLV+A=;
 h=From:To:CC:Subject:Date;
 b=UUe6S/idc/diJpApdHcNJSRDEaD9vmrjfLy86dd58yQfSgURtf/ZBaooYQib1UWMy
 68OJDy7GMUtgjVkzeXBhnKjWzkhKw3i2gXOxSI4hTxQSdpdEv68UYU37pKrSsIkO8t
 dt7KYyxDItv/8Fe1IHAGQVfdQhcJCR5+WkB4mRe0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A1EoQeZ115596
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 1 Nov 2023 09:50:26 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 1
 Nov 2023 09:50:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 1 Nov 2023 09:50:26 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A1EoQgn007584;
 Wed, 1 Nov 2023 09:50:26 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Reid Tonking
 <reidt@ti.com>, Udit Kumar <u-kumar1@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] doc: ti: j7200_evm: Fix OPTEE platform name
Date: Wed, 1 Nov 2023 09:50:25 -0500
Message-ID: <20231101145025.1069790-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
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

k3-j7200 does not exist in upstream OPTEE. Use j721e as the platform
name. Using k3-j7200 as OPTEE name results in broken boot due to wrong
configuration being picked.

Fixes: c727b81d6530 ("doc: board: ti: k3: Reuse build instructions")
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Cc: Reid Tonking <reidt@ti.com>
Cc: Udit Kumar <u-kumar1@ti.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc:  Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Logs: https://gist.github.com/nmenon/0b05a556ce8ff91ec070c7c0c0fb62f3
(before and after)

 doc/board/ti/j7200_evm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/ti/j7200_evm.rst b/doc/board/ti/j7200_evm.rst
index bcf8dc1c5f0d..35b554166e45 100644
--- a/doc/board/ti/j7200_evm.rst
+++ b/doc/board/ti/j7200_evm.rst
@@ -71,7 +71,7 @@ Set the variables corresponding to this platform:
  $ export TFA_BOARD=generic
  $ # we dont use any extra TFA parameters
  $ unset TFA_EXTRA_ARGS
- $ export OPTEE_PLATFORM=k3-j7200
+ $ export OPTEE_PLATFORM=k3-j721e
  $ # we dont use any extra OP-TEE parameters
  $ unset OPTEE_EXTRA_ARGS
 
-- 
2.40.0

