Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502A4CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D57A84CAF;
	Fri,  8 May 2026 14:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fGcx2MA7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FrXX6B2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F13988488B; Fri,  8 May 2026 14:23:05 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2633A84CAD
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gBpDR5gjxz9tsN;
 Fri,  8 May 2026 14:23:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+CkayfkSq7Gsn2kG/7DPbSZMqj8jyqpyJMij9VJ/oY=;
 b=fGcx2MA7uLBipqAVtzbUT8/8Gy0ZU+tl7dAVm541PIV1Gmcrt5QzGqnzn4aAS8N4sNSifG
 PJJajiIDLALVOH/DSx99HJ7WdpPbASEleve76mIg24x4jIMMTDmrRHN8jDczrmJB0SlCKu
 QD9YmQ27a/F2Zkh7LLVfhpsRvxFHpCvbV6s2ebMD9cuenPoYe+SYwTUC3wwZnTGToy8DuZ
 n2WIjepn4uziD57hSVURbILutpW64BXQjwj/s+6SH4UZ5XXfPH4z+hFw750ba5bIIAmEz2
 GbsivyWHjWjd/gV/GQsfGoYwmpAF1/5Vjd6ShsSqp7S6d+TbDe9Yb3cBLfq8PA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=FrXX6B2P;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+CkayfkSq7Gsn2kG/7DPbSZMqj8jyqpyJMij9VJ/oY=;
 b=FrXX6B2PRivyTVzSw/KwjiI73QGQJxz4FvU+3I2aINX5dLNM6dBu7O+UIAXHrCpPCJNytP
 LNDp1+jSJbRw/vqadol7czRSXdvOiHtvLy+DczNueN24maZrPyVYWZn86ILTbYC7zKDQh8
 qIDA5x9zNUhoQ95UKamxNOJpmFvfJY1FkdFcYujiK8mrc/Ld3Oq0kiWFgU3f3bZBDTjyNl
 e6a7imQb+51NiVeeZMD/Qvyn72MY5WU4YQtRP1Qe4O8dOq52Ai4RbSwER7vWvwfSacoAdf
 1DTRgcEWVCxkaom8FawUJc/QrS7wHnWlImbu8Ca5e4/EA/WhPumZnmw+8f1ULQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH 05/14] power: domain: imx8m: Staticize and constify driver ops
Date: Fri,  8 May 2026 14:22:05 +0200
Message-ID: <20260508122247.512862-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 322dce98fc75415d99c
X-MBO-RS-META: sbex8dbyexox35zzqdp1gxx7b47p38qq
X-Rspamd-Queue-Id: 4gBpDR5gjxz9tsN
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
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.denx.de
---
 drivers/power/domain/imx8m-power-domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index 1c731b897cc..5fdb95fb6a7 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -558,7 +558,7 @@ static const struct udevice_id imx8m_power_domain_ids[] = {
 	{ }
 };
 
-struct power_domain_ops imx8m_power_domain_ops = {
+static const struct power_domain_ops imx8m_power_domain_ops = {
 	.on = imx8m_power_domain_on,
 	.off = imx8m_power_domain_off,
 	.of_xlate = imx8m_power_domain_of_xlate,
-- 
2.53.0

