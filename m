Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B269DCD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D63D884CA8;
	Fri,  8 May 2026 14:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kTE/2WcI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="A8WJqW/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 438588488B; Fri,  8 May 2026 14:23:02 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6BA584CA4
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gBpDM4GQXz9vCl;
 Fri,  8 May 2026 14:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=THjzWDjfD0bz6hutpvQ+U08hlzGRL6xw8FNhGFKm3j8=;
 b=kTE/2WcI/xOfsRxNth3rmncv7kdDKfqTDH9TBSIUK/Odb55ju7GZONhG7DkZFbuHxdneQ0
 Vq8iOaqO6C406JLfagnu+E0Ga6EzEq5wDBALVWtAKmAYYBfCDDeUN/FpjW+viaw1Kie2pp
 bb7WBOzC4k7GL5DIXFpzntq0OQp/CG1dIjeqT8iTnQwG77O2lu64lU21IDUTFiZvfC0C98
 btQBdfrtGkmXn6VCgKWIep5k6GrzJknYg5w49s23GB8Mo1S1kJbAJIR6Tc+2mdj7vQXfF9
 nNIM3WZxrHkcuK57x7Upw8U+7gxRyOIpvKlnOm9Y692I87Ff0zwmhFruzbbdhA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="A8WJqW/M";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=THjzWDjfD0bz6hutpvQ+U08hlzGRL6xw8FNhGFKm3j8=;
 b=A8WJqW/MDpxeNzAXyaTenWvAa9kpKQPzJb8RbvnkKbHoEhIfrZzfoim/QnAlANEzCIVPmK
 e9r8CMETPLvoTshlyifZGwQNKcKGtnpImUcPinz1SyT9bHqhNXpRzIyGrQK0NENz4JAGGM
 aAhSt4DgG8xiv2PShYzM+LP75Pk42k+BBUNMvyTSOorde9D8qYAMREw0v/f2GtUjQDF0aN
 H5VItl4H44C5504HO8npPPSiVwJQOjug0qQL90XePpiztopgjZGfVqD+2aSx8xPYuq2nHB
 Fer/r6Hxw7Mnf7+2X9na308F5fTAf+j510gvuJDIXWlqi7qvo05EqevnarTnmw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/14] power: domain: imx8: Staticize and constify driver ops
Date: Fri,  8 May 2026 14:22:04 +0200
Message-ID: <20260508122247.512862-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yeqjr6jy5z5chro3917km1uw8ss46fi1
X-MBO-RS-ID: fd5afe77f3748c48762
X-Rspamd-Queue-Id: 4gBpDM4GQXz9vCl
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
 drivers/power/domain/imx8-power-domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/domain/imx8-power-domain.c b/drivers/power/domain/imx8-power-domain.c
index e8dcc057fee..5740cd686db 100644
--- a/drivers/power/domain/imx8-power-domain.c
+++ b/drivers/power/domain/imx8-power-domain.c
@@ -51,7 +51,7 @@ static const struct udevice_id imx8_power_domain_ids[] = {
 	{ }
 };
 
-struct power_domain_ops imx8_power_domain_ops_v2 = {
+static const struct power_domain_ops imx8_power_domain_ops_v2 = {
 	.on = imx8_power_domain_on,
 	.off = imx8_power_domain_off,
 };
-- 
2.53.0

