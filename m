Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC45CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C4A684AF1;
	Fri,  8 May 2026 14:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IsVP0hm9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="X7pakgL1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E16B38488B; Fri,  8 May 2026 14:23:31 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C530684CD5
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBpDw1k9xz9tSk;
 Fri,  8 May 2026 14:23:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778243008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+N6jf26RlJuGT5Lu3i+zjFdUDy0WC/Evcbki+ivk1xM=;
 b=IsVP0hm912WhT7BU8uneCo11zOamdpxSDcjbbHjEijGhStMpnNq+FcZsr9SgOsOqUmUllM
 xuB3HvLfMgq4b8CQb2xMnTBgQjaySf2QvQu43sQ3fx0hEeeCM//QBjTDN8CDc8m4MneV3v
 MfSLhffZiN4DjRzicZOIAIhfuGRMwH/usexCV5uvWxbOvaO0sFwUMDHTIuo5cKrxN/vXlj
 19s7dZNqVSxxdHggniiEmFUuGpGt2qn19e7lszSLV+pDWept9RYlXyLbppn8pt6+tQNbOm
 eZiKC6MyCJs3QzQ/Jv1EAk+pv6Zx6+BpQuKkhQTIDv3zu47MFQpeBiqBdZGGCA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778243007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+N6jf26RlJuGT5Lu3i+zjFdUDy0WC/Evcbki+ivk1xM=;
 b=X7pakgL1de8nw/oKuVE/WmzyDRo8RU7krjooSUiU6DbIhWAlpC2TbjdZVSzM3rC5g7UUJp
 6saWYXpN3rImzwFoLV3IxTH5wVAwyQSm8n359BgbSr6tFk301cOEISoty7Sz7s2tBFo8z9
 5LJUNw7WDEIbhF3J6V/0RYjRofeTbGevXt6j378MPFw2z20YF8Hi2+w4zOQ6Jwr4ceKsKm
 yW3A+Fl9VShgJ/izd/xty9fr+mdi7OpULMs25UUHdrZ/GLyEtmyw1Eh648CZ3LNYFYa2Cx
 pIKMRvNohAAxcHlEMxo1F73Lxrj/kjTUryDB6ZQkF94xLjJyCD9t+1HMHncp2w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Michal Simek <michal.simek@amd.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Peng Fan <peng.fan@nxp.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 14/14] power: domain: zynqmp: Staticize and constify driver ops
Date: Fri,  8 May 2026 14:22:14 +0200
Message-ID: <20260508122247.512862-14-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 58mpmj4yfq5r51onj7qsm9i5t6ag4bqa
X-MBO-RS-ID: d1f349503b6da7c9fe5
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Naman Trivedi <naman.trivedimanojbhai@amd.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de
---
 drivers/power/domain/zynqmp-power-domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/domain/zynqmp-power-domain.c b/drivers/power/domain/zynqmp-power-domain.c
index a54de5c1439..0acfc54e787 100644
--- a/drivers/power/domain/zynqmp-power-domain.c
+++ b/drivers/power/domain/zynqmp-power-domain.c
@@ -57,7 +57,7 @@ static int zynqmp_power_domain_off(struct power_domain *power_domain)
 	return 0;
 }
 
-struct power_domain_ops zynqmp_power_domain_ops = {
+static const struct power_domain_ops zynqmp_power_domain_ops = {
 	.request = zynqmp_power_domain_request,
 	.rfree = zynqmp_power_domain_free,
 	.on = zynqmp_power_domain_on,
-- 
2.53.0

