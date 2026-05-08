Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8555CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1E4B84CD0;
	Fri,  8 May 2026 14:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cqgWaWHB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ND+bLJUb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D52784CD0; Fri,  8 May 2026 14:23:25 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1EEE84CC3
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gBpDq3CfJz9thq;
 Fri,  8 May 2026 14:23:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778243003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BhXO8U7hEgQ0+szVEy4bYnDuw5ozWBL0xmw5kV4iRqI=;
 b=cqgWaWHBG64Atawa00VmYkQZa4EmHuTZzPJ2oFyXQoib3hgoFAiWyzFGGzCRULy60flwNN
 wVWEMc7sfApf0YBVIhsKAXNVKFt1LVzpWD2JmC/5NzesWiA9uKbKEsiIB/Smqhu6NP0VSB
 2DjT2P/3x2eR5W3xFYDzojJmHQ4WzOGR+tTbTDHKUtpt3YtFp83MZihjYXg/Xd+spyrdAt
 fnD5aPnfqXC+YH7kjHzf2D8eCXelTxmHQlXjPDHion9CiMrxBRNu+o1vgjpAc6akATVs0s
 ev5N1+26RmT5WVBBkNjPipMy6xkRME0FY0OEzQoIx3/f8E2+iopKTPC7sEmcdg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ND+bLJUb;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778243001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BhXO8U7hEgQ0+szVEy4bYnDuw5ozWBL0xmw5kV4iRqI=;
 b=ND+bLJUbzLO3SF7Rq6DRp60nKK2oLz+HsNcfC86gAlKsZiosGVgbBXFRZ0//zkDRSZeiAW
 QCh7D+kH0FZ//OvfbUcAoCAdtqKCSv9pXVXDjvLNaE2sucuoBAFnGXQe6kBGrGoVFhOhmj
 N4GUbLn5VL7KZp/GLqznVo3P9x1oFfrp6EoYX721pOtgXmFTSdNuo77qLZMw7aevyMUpjW
 5BqkUh0b+exJbAIBhBaZjS4nuWhZdPAyBe0nGSr8pP4lKNBnGQC5y3lD4V9iugwO5pRFIm
 DnZjqW/belalxsSstJeoy7Lu7TyBARxKKrP2oIR4oY2zyY/p6INy7vZToLPaKQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/14] power: domain: scmi: Staticize and constify driver ops
Date: Fri,  8 May 2026 14:22:12 +0200
Message-ID: <20260508122247.512862-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: g1efpctj97674zhpgb1fxxshac8qitzh
X-MBO-RS-ID: 60d94bca8696eec0bc9
X-Rspamd-Queue-Id: 4gBpDq3CfJz9thq
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
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/power/domain/scmi-power-domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/domain/scmi-power-domain.c b/drivers/power/domain/scmi-power-domain.c
index e8c0ba8878e..6dcc259ad8f 100644
--- a/drivers/power/domain/scmi-power-domain.c
+++ b/drivers/power/domain/scmi-power-domain.c
@@ -179,7 +179,7 @@ static int scmi_power_domain_probe(struct udevice *dev)
 	return 0;
 }
 
-struct power_domain_ops scmi_power_domain_ops = {
+static const struct power_domain_ops scmi_power_domain_ops = {
 	.on = scmi_power_domain_on,
 	.off = scmi_power_domain_off,
 };
-- 
2.53.0

