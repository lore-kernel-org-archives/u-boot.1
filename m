Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ED3E9A047
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 14:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C68E083D5D;
	Wed, 18 Feb 2026 15:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=armadeus.com header.i=@armadeus.com header.b="L00mYFCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A88A802C1; Wed, 18 Feb 2026 15:59:42 +0100 (CET)
Received: from 8.mo561.mail-out.ovh.net (8.mo561.mail-out.ovh.net
 [87.98.172.249])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7E8E83AC5
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 15:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director7.ghost.mail-out.ovh.net (unknown [10.109.254.71])
 by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4fGKRY3XGPz5yMZ
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 14:59:37 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-62b48 (unknown [10.110.101.145])
 by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 2ADF5C01C9;
 Wed, 18 Feb 2026 14:59:37 +0000 (UTC)
Received: from armadeus.com ([37.59.142.110])
 by ghost-submission-7d8d68f679-62b48 with ESMTPSA
 id hnYEB9jTlWnVjAAAa7HxRw:T3
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Wed, 18 Feb 2026 14:59:37 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S00444eeeb47-015e-422b-b338-c6c3197b9520,
 BCC414E58A87BDF8F3171654DA18834A20810328)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 86.243.239.229
From: =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Date: Wed, 18 Feb 2026 15:59:19 +0100
Subject: [PATCH 2/2] serial: lpuart: handle Overrun flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260218-lpuart-fix-rxfe-offset-v1-2-86a78b224f13@armadeus.com>
References: <20260218-lpuart-fix-rxfe-offset-v1-0-86a78b224f13@armadeus.com>
In-Reply-To: <20260218-lpuart-fix-rxfe-offset-v1-0-86a78b224f13@armadeus.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Julien Boibessot <julien.boibessot@armadeus.com>, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
X-Mailer: b4 0.14.3
x-ovh-tracer-id: 15265232415330326217
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGcdss9VIj/m/mQGm7b1Z6eoMkur1vDkfIGe5Y4nnkgxx0BvfE5VBX1jNQMlL7rU0Vdj70IrRf6iM1l38tVWhCJpsRRULLGaFMla95dOQFPtBf8mgT9OImbd3e9nxDTWWVRke8mu7zedMcVmgoroOkzzRhgfFz4xkiyjWkuhADrBmInZg8ByJFX8dlo7TyjdupzitPbrcrbeZeC+wlfbFFKDlKYdueZaEgZH+wS9Rp9XbOsXMIobp1zG/rybsn2hSjKXdc7C87iYXe0J5NbRKA5k9lLmE/ay54DViP6pBSycUyXfcJ/H+TUtURyDzbUuROI1QH08FdNYbPb3P4GkZTdPBD64aLphV4i+Mg8fv4E31NVHyB/3nTcqGHSCmpunnAPch211Yw/jVz3hbdt0ZoxERTwMnS+u8/wfA+EVGx1fhybXLH5sgL/SAPwqpweMU2ln6rziPC8xn67lmEXGc8+cZgtyB42i2H25e178Ivn0g10FBou5saN3ekC6UKyiZDV8f97CgdOkyll3ChSXIV5eeRHooHFaXh4APQoEfMP1UquZj+i+xq+T5OnP1JCH26Cwi2BYvJI2p7Osd3Q2xO+fpml38agKYl6egSeuW6+Hz5melax8X9j9vAY0w5XPyfwZOqfUC3qdabCeo7B0gRIjqLAXBGoZcBP/UyP0TD8pQ
DKIM-Signature: a=rsa-sha256; bh=XLBcE69QgulgZeJPg45m/GWR90yIvjwGuO3jd7zFZ44=; 
 c=relaxed/relaxed; d=armadeus.com; h=From;
 s=ovhmo103079-selector1; t=1771426777; v=1;
 b=L00mYFCq6q1fJgIVnzVQScaaTaJHCutnbgr5wFYw26iSuEYQFoEiGQldeht+uea/2e0cKhtf
 aEX1qepOavRC8IoUB8LrCdUJGXLc0L5dsk0GkVQ6pd9Enywdhsy7c+vXwoM7w9Y4cz+z+dj4Gwg
 8R8hx7fe+7QXqa98HCPZFOmPTC3KELCsNGHFK/j9G6G9Tw1pNi2T0x0Xiho48OKKAeZjV+jDawR
 If9Fnw15iJiEtbeFE/Ohgugp58K0lvP6Tlfg5SvmatS8QeTvCotjeBSRx5f5N0r1f1hQ/DN5hZp
 W0ABsl05ngWqPW0iFnzDzhTRpEvIk+imHYDMh046RXDhQ==
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

The receive FIFO may overflow if data are sent while U-Boot is still
booting. In that case, the Overrun flag (STAT[19]) is set and no
additional data is stored in the receive FIFO and the user cannot get
access to the U-Boot prompt.

Fix this by clearing the Overrun flag in _lpuart32_serial_tstc()

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 drivers/serial/serial_lpuart.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.c
index bbce59443388..0728feccd131 100644
--- a/drivers/serial/serial_lpuart.c
+++ b/drivers/serial/serial_lpuart.c
@@ -367,10 +367,13 @@ static int _lpuart32_serial_putc(struct lpuart_serial_plat *plat,
 static int _lpuart32_serial_tstc(struct lpuart_serial_plat *plat)
 {
 	struct lpuart_fsl_reg32 *base = plat->reg;
-	u32 water;
+	u32 water, stat;
 
-	lpuart_read32(plat->flags, &base->water, &water);
+	lpuart_read32(plat->flags, &base->stat, &stat);
+	if (stat & STAT_OR)
+		lpuart_write32(plat->flags, &base->stat, STAT_OR);
 
+	lpuart_read32(plat->flags, &base->water, &water);
 	if ((water >> 24) == 0)
 		return 0;
 

-- 
2.52.0

