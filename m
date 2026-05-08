Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB489CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F75E84C9E;
	Fri,  8 May 2026 14:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xUCDSFSe";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qq1liG4n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13B1F84C9A; Fri,  8 May 2026 14:22:58 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4119D84C60
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gBpDJ0K7Vz9tqy;
 Fri,  8 May 2026 14:22:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ZJPDWaZ8MYmk7PBMVK2pGxfeYpwAE73chGJ6MGBokc=;
 b=xUCDSFSel1jwqscskxL0w+vv+aYiOovYgudNl3oyVTfp5c3V9L2eLVBv0QvuXn2byL+Tzl
 ydZ42dnmqocN2UknVKDW4EL3HKhy6Ft3pa/xBdxPsJi+dqd+a7MF3SHYs8gsEIeAsdHxL0
 tEi5PSm07cwuChhVHR9OaBKfQxXQigeAIX5g5q9T4x/0JShhN3hdKc6xj7NaDzXb90UR7U
 kkYB084w+u2GG00i9GTyqoSmyK4XhBRj9An2Zmw0lV/4BwG1U+g6eFLWqViJPy7J1TDZKS
 Gy+0jQJakkhSxSfcxiJh46Ik2NVV/v+grzu31HLKBGyll+gtyWQK5XZtHgSgUA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=qq1liG4n;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ZJPDWaZ8MYmk7PBMVK2pGxfeYpwAE73chGJ6MGBokc=;
 b=qq1liG4nqbH3EjIpKzzkcpYMB1hXffecK7HLQjpO8MvPevG+mhs5XGHg10yKLp7/AlZk9n
 AISRqJAShmOroEaMzGt7SHj/EptmdEqwpWUC9Uk/7KPWMezpfJJyut+YKBZmQulO9XBZ7o
 j4jmX3m3D4Zwl9GcjHOtUkNfVS58ElCT8QTcTF84zjxXPU+UkjJox9FMn2jKRDjlJ91En1
 m4V8iS9m0wOH79FPhVrRt+lrW0GxTagum7rF2Xvyc1qfVkqdMvWqz2/dVrxPIPaBFMJfoD
 pqhPD6zMr9onBTSg2IFWSOWvFor1lnAAKsUj/RTDz041zrfApby42cco2V7IYw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/14] power: domain: bcm6328: Staticize and constify driver
 ops
Date: Fri,  8 May 2026 14:22:02 +0200
Message-ID: <20260508122247.512862-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9a64030723ffe9fd196
X-MBO-RS-META: zoiaw86owdrpni131qgut81dr7jdaxpf
X-Rspamd-Queue-Id: 4gBpDJ0K7Vz9tqy
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
 drivers/power/domain/bcm6328-power-domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/domain/bcm6328-power-domain.c b/drivers/power/domain/bcm6328-power-domain.c
index 36b5a933748..5b449f4c29d 100644
--- a/drivers/power/domain/bcm6328-power-domain.c
+++ b/drivers/power/domain/bcm6328-power-domain.c
@@ -57,7 +57,7 @@ static const struct udevice_id bcm6328_power_domain_ids[] = {
 	{ /* sentinel */ }
 };
 
-struct power_domain_ops bcm6328_power_domain_ops = {
+static const struct power_domain_ops bcm6328_power_domain_ops = {
 	.off = bcm6328_power_domain_off,
 	.on = bcm6328_power_domain_on,
 	.request = bcm6328_power_domain_request,
-- 
2.53.0

