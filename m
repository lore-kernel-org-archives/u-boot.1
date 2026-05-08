Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F69CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 986CD84C92;
	Fri,  8 May 2026 14:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="boxYhDcA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fZRGSOeL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3DFC84CA8; Fri,  8 May 2026 14:23:00 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92F9B84C92
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gBpDL26PMz9tsV;
 Fri,  8 May 2026 14:22:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83ISw/awlpsucjcRodQ8gdTe3DhQyKmYBKP3bbd7Sro=;
 b=boxYhDcAkvtft9SsadKhKs7BRkw+S1LcduaeaelKbFp/UIWPqS1hl1MFrbSOqlkPaFzo7r
 ap77wxo0KBtIhTFlKnvmqVWcVf9F64bU1xr03AOuSJtLiOG5oXB1sJOeGEMTT2bd/swlv5
 V8QzMHOh0ksYH0+vofZfRN56H+rAD5R1gOYlAakXTgPCQsIUSN0jJXFNFWpchi58hy/Mgf
 lgvbsqeKl53j/K3owg/DFJT7tE32KYrBavLCNjapMIyxo3WH6aq4E5usiLm82WdZEGYXq+
 94O34I7+J1/CQ6xFwodA8w4nlxdZGE6yF/SS2C4i9k1sBamqxNkqxVw+rnxiTQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=fZRGSOeL;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83ISw/awlpsucjcRodQ8gdTe3DhQyKmYBKP3bbd7Sro=;
 b=fZRGSOeLceHehKHAi4ETidMIIzMFiVGfEk6s6Juy6vRgP/1LFIciGLi7uZReZu3M6lLtZY
 8yVGi1m9UNC+C78IaCAS0H9warfQxkSWfsYFaSKoTz3PAWcjZedkLGbs+7WhWb8Ns2EiK6
 kWfaNhEoWs5Y9d02g3PgLQ1eVOskT5/aHVV/3tVZnV+uH0wpL8F0+bcppwM09bX8IZkp0M
 B0MwIKSVZ3/02w6AsYQTO2PSxha3zogI341shEY34EsPePl/KPT67Q6iNz5kosSZAxrMij
 gG3F1Mu7/yYpMf7P5CqFSdd7Ma+SgjhTggxlB7XXA0/J7KiRhHf+qLtDp5cV5A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/14] power: domain: imx8-legacy: Staticize and constify
 driver ops
Date: Fri,  8 May 2026 14:22:03 +0200
Message-ID: <20260508122247.512862-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 11hiq9pdht5cmtse88a73zh7zib8og59
X-MBO-RS-ID: f657e2de2f63462efa7
X-Rspamd-Queue-Id: 4gBpDL26PMz9tsV
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
 drivers/power/domain/imx8-power-domain-legacy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/domain/imx8-power-domain-legacy.c b/drivers/power/domain/imx8-power-domain-legacy.c
index 713a51d7807..a646f667039 100644
--- a/drivers/power/domain/imx8-power-domain-legacy.c
+++ b/drivers/power/domain/imx8-power-domain-legacy.c
@@ -347,7 +347,7 @@ static const struct udevice_id imx8_power_domain_ids[] = {
 	{ }
 };
 
-struct power_domain_ops imx8_power_domain_ops = {
+static const struct power_domain_ops imx8_power_domain_ops = {
 	.on = imx8_power_domain_on,
 	.off = imx8_power_domain_off,
 	.of_xlate = imx8_power_domain_of_xlate,
-- 
2.53.0

