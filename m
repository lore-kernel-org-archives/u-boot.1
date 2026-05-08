Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCD4CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05FF584CBC;
	Fri,  8 May 2026 14:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IxEoxVaj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MW406fmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFD3184CC2; Fri,  8 May 2026 14:23:16 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA3448488B
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gBpDf4f1Sz9tpD;
 Fri,  8 May 2026 14:23:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vARIp/y93uksRQlf38b1wBKXVDK7oaJodGNB7sL45Bw=;
 b=IxEoxVajL5zxFmfiMWaTjDKUcgt7Vx3amRw3EdNmkRuujnfj9c121xKdc3cSaTxYCAUX0w
 SSylx9XQdjPnKKZA0J9tfsTVrdmJKA9Nko22PnY3ns+TJ/rW6i8ylcwY1VxcXHHmt74a6/
 rAgodMWPLXi5lDM+90rjdG+iRCSq+8+sn9oQQlNAwIMc6Plgn8HpHrDJo1TD1Zu888h/Bh
 F51eoImiAW7NzydRWMCkfzz/VgePL1G2oPEpjffD2AqSLIP2iR734r3TQ6YwjLBgwv4E1V
 eCcNlRBNLycdbTOBHKNpwDma/Dt5bPrT9ySUuk7KMfzOD6aamFPpK2KxPFGnNg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vARIp/y93uksRQlf38b1wBKXVDK7oaJodGNB7sL45Bw=;
 b=MW406fmTlWBgwe6gkVeKOD96ZfCEQseJjMbQVPKzPkz13WuFINlVhapEcf/Rv72A/hgBwX
 eQoDjk0RnHjJ6Mpw2OEiEZpKS6xieQaO3sTtsVDtIvvyybDw9li/y2Wlt6BTTb4IjDSy9A
 Bobb1sMiMU82ePYyeGZoUc5G0CnxR95rAJUCzQjCRyHDYUAQh2tJxXAFvW3+qkvOE3xPFJ
 cUn9cTZtgQUHphRcWNQApOwHPjhtc0dbAYu07zVxIG9YlrCigAEVa0Y9Zv30FAooVMlsLA
 lJtFUm8vwgo31aZM6ugXIGmAi29JbHpTA5T645DZg/Rm57fL8ZYUBEVrG7BOaw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io
Subject: [PATCH 09/14] power: domain: meson-secure-pwrc: Staticize and
 constify driver ops
Date: Fri,  8 May 2026 14:22:09 +0200
Message-ID: <20260508122247.512862-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rqhuru8urbyecuazqs1dz1w8n47dnzfo
X-MBO-RS-ID: 71765ad92c0fcd122c1
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
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
---
 drivers/power/domain/meson-secure-pwrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/domain/meson-secure-pwrc.c b/drivers/power/domain/meson-secure-pwrc.c
index f70f8e02423..1b82b58f3e5 100644
--- a/drivers/power/domain/meson-secure-pwrc.c
+++ b/drivers/power/domain/meson-secure-pwrc.c
@@ -120,7 +120,7 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
 	SEC_PD(RSA),
 };
 
-struct power_domain_ops meson_secure_pwrc_ops = {
+static const struct power_domain_ops meson_secure_pwrc_ops = {
 	.on = meson_secure_pwrc_on,
 	.off = meson_secure_pwrc_off,
 	.of_xlate = meson_secure_pwrc_of_xlate,
-- 
2.53.0

