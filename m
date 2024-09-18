Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7882DCCD1A0
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 13:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1DB088D5D;
	Wed, 18 Sep 2024 15:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bg7Qjc/A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCBC9888EB; Wed, 18 Sep 2024 15:49:32 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 017F988C4C
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 15:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 4137EA4045F;
 Wed, 18 Sep 2024 13:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285A6C4CECE;
 Wed, 18 Sep 2024 13:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726667369;
 bh=8UdZSJQ9wIVod72oiATL4IxyuqRYU3al/MK+SQY4bhY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=bg7Qjc/AMbrDcZIUEK/1c7zzSvPZmFtutwWDy7e/eekT7ab+GDsgxUwUg7aaHUiib
 3kDXkrI3BM0wX9XGRBICdnLnUsJ6EXcSDvmfhBsWcy47/dooZRbNkYVvPG9pHe2VwE
 a1Fgbks6mlb2c3XotMpfglejMLpDLw11qMTqBW2uJoHk8+Cpex9suJxhJENQz0Qi62
 glrTcCKBnwb+JEWfk+/C4OBmQn6/gjjx0DZTKU4SXecNTjmVP6BoepZQAyEJ0EnalX
 jwORtv2spiMkECT7S3aUebRrgeypUxGj0Cirsygm6VzrRWXfl/VUaJzm5VkkRFCcDT
 MP8d+EO54XkpA==
From: Roger Quadros <rogerq@kernel.org>
Date: Wed, 18 Sep 2024 16:49:22 +0300
Subject: [PATCH 2/2] phy: cadence: sierra: Don't spam console
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-j721e-ums-v1-2-62f295dce6aa@kernel.org>
References: <20240918-j721e-ums-v1-0-62f295dce6aa@kernel.org>
In-Reply-To: <20240918-j721e-ums-v1-0-62f295dce6aa@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: "Andrew F. Davis" <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, u-boot@lists.denx.de, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=800; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=8UdZSJQ9wIVod72oiATL4IxyuqRYU3al/MK+SQY4bhY=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBm6tpjbKasxJ/J5bDTDfSYGiC0Gmc+B1qW+jEaf
 izX6l7w25+JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZuraYwAKCRDSWmvTvnYw
 k3m2EADMcV+/zXEOyHq8kWKX+24GEr/b66s6CHP4PSI3mAK2PN4jA675+AxFInBbzMdEkSlx422
 Gi5xjEdIhe/IWwZnDs4QdEcjO4U4ZxdFS4lWOOKbsWQ4bkd6bAdNWx64Nr1REkQs0/hve6zoRcz
 KEUor0n1rvvcLurjl7siJ9PgbwAq5aYtw+7jjOa80qAMExwn6Blk8dWtKOB6LWqpsEnKMJGA3at
 30yD2yQgTKnIXJvsX9u1x9DJHSHKp3i2jqN+esx5CPAbNh2dvTCQz0Ju9coPvJTFijPM7KJ4Kch
 gh5uaNORiUz0K/0usvKaL6YzgGrjls2IV0soa/eXnZ0yiRHqhz1W2WQcxQYjA4d/cMh/fVJvhVQ
 hz9tZiuMbxNuLRjDmZS/iigbVz1ssGxbOdAVDsLP4K21i/N/4vTQdwoFC5MTQb+/1AA+A8INyas
 9iuOExh0Qjmr9o61wersNZcTx9FwuneuGofE7YmWNjnD9y8uUpFZeGvMa4NT5/jMXy2WCs49BtA
 G1wkrD3R37dZTmLfEyZ70g47jZmvWCBVPcbAYHf4uliXljjWJkZdJywKk9x/3w7z7BvfzHZYl7s
 +AjMI4mSq2g+k95+mM/rl1aOP5dbo0UX3L9gtAG0x0VvdNOlRlM6UKGMYODhtABdZOZ4KAEW3vf
 kwyBWYOYi+tBZWg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093
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

use dev_dbg() instead of dev_info() for debug related
prints.

Get's rid of below print from console.

"cdns,sierra serdes@5030000: sierra probed"

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index f5e23f36c56..2c9d5a12127 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -1126,7 +1126,7 @@ static int cdns_sierra_phy_probe(struct udevice *dev)
 
 	sp->autoconf = dev_read_bool(dev, "cdns,autoconf");
 
-	dev_info(dev, "sierra probed\n");
+	dev_dbg(dev, "sierra probed\n");
 	return 0;
 
 clk_disable:

-- 
2.34.1

