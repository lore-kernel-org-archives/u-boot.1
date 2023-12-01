Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA79C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 10:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A2E7876DC;
	Fri,  1 Dec 2023 11:30:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KQKnrEgc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D49ED870E7; Fri,  1 Dec 2023 11:30:27 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81D9E876DE
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 11:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B1AUN7u008495;
 Fri, 1 Dec 2023 04:30:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701426623;
 bh=J0nLKfSUCxUQi9jtFt0jq6K+SzjeL3atnJXROsapc6w=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=KQKnrEgcRacw8z21Ox7aiRr0HL5fOBa96BwKWZN/FOtjqSCtER3ayrFeaKlpZcvaG
 AwU9RupDNcSvZjmP/I5lpRhBs5TCwUNEByGSGdh3cZThhCALb5JIqIQhdpJqcV9LQE
 BDs+VKBRomY4oWebQMYK7X/udIqfh2xrkBcgZHwk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B1AUNsC058053
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Dec 2023 04:30:23 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 04:30:23 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 04:30:23 -0600
Received: from dhruva.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B1AUA7V078636;
 Fri, 1 Dec 2023 04:30:22 -0600
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Dhruva Gole
 <d-gole@ti.com>, <nm@ti.com>
Subject: [PATCH 2/2] doc: board: ti: am62x_sk: Remove SW_PRNG Flag for OPTEE
Date: Fri, 1 Dec 2023 15:59:54 +0530
Message-ID: <20231201102954.47582-3-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201102954.47582-1-d-gole@ti.com>
References: <20231201102954.47582-1-d-gole@ti.com>
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

This SoC does not require the CFG_WITH_SOFTWARE_PRNG option to be set
for base boot support, hence remove it from the U-Boot documentation.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 doc/board/ti/am62x_sk.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index b12dc85f06b5..35d759e806c0 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -84,7 +84,6 @@ Set the variables corresponding to this platform:
   # we dont use any extra TFA parameters
   unset TFA_EXTRA_ARGS
   export OPTEE_PLATFORM=k3-am62x
-  export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
 
 .. am62x_evm_rst_include_start_build_steps
 
-- 
2.34.1

