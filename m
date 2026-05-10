Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDC3CD37B9
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:17:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FCE184706;
	Sun, 10 May 2026 19:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="u0qWjscc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nsEzza7X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3355846D0; Sun, 10 May 2026 19:17:35 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A147846DD
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gD8gK6sSwz9tqk;
 Sun, 10 May 2026 19:17:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jl0cLR513AJ6reSSwthw+hD4Nkc6hiacIo/hGE2cDiU=;
 b=u0qWjsccNEpGa275p6RCrTOuCbJOTebnMHp9xqH4lHbpWeEmsG3fghM4AZveoMkOYfauqZ
 B5Z52ZJYhGhcuXZ0WYVFTBu0n6KXW1VADDzw1zpD7ComtdEB1OY9TNQPGB/JExYQUU8dWX
 Au7VdFohubYJgYWlftnvxzfxciz3Ea4nF4Omupe5m+y+TUMUaDluwH9Q2qDKU0vOpCPYaY
 rfKPapaUFZjsaKp0ctoFciUnW2mgjvzQcuvVceR9FY/7rIdKuRSSSnVkPm4DAhG+ZC1sFr
 /XAR5ZRORzp9PqLRQuSg83yunMpitVZygj2WoYKq30U9NR99nSTJMA+T6IqZ2Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jl0cLR513AJ6reSSwthw+hD4Nkc6hiacIo/hGE2cDiU=;
 b=nsEzza7XuNR492BS/jQasvIQqh259zL+lOJDV6x3YCzlkz1tfPn37L1aPJRpDhemREr5Jt
 hpx70MihprqbBBAq1B5ldLtwhbU//LTrU/ABexu5gYBEFN5L5BrZ4x2p7u9QJ/6gUCQOt6
 YV8wMfd4XcD49tBqIslYkuH7xwuxzYCsM2WugRT71djLpYkmJX8ZSeIWfvYuTse+7x/Bm+
 hzRXNJlMZSaIaVwZ78n2S7Hz+IYPehk2GzXKO56w1eK5phMe8GiEaY3OmbJEdLW7OeKCYl
 uPSDXAEbaRRo2c5DtRRVDwx19+rAXf+6dJNq1+edPXbGqp5CqVCQuR46c82pRA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/11] video: bridge: ps862x: Staticize and constify driver ops
Date: Sun, 10 May 2026 19:16:57 +0200
Message-ID: <20260510171723.56866-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b3eaafe92ccdbff1ff2
X-MBO-RS-META: cuun3ig6gb6bagunbk4oupzyeqea47c3
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
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/video/bridge/ps862x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/bridge/ps862x.c b/drivers/video/bridge/ps862x.c
index efd03752281..a08227f8355 100644
--- a/drivers/video/bridge/ps862x.c
+++ b/drivers/video/bridge/ps862x.c
@@ -116,7 +116,7 @@ static int ps8622_probe(struct udevice *dev)
 	return 0;
 }
 
-struct video_bridge_ops ps8622_ops = {
+static const struct video_bridge_ops ps8622_ops = {
 	.attach = ps8622_attach,
 	.set_backlight = ps8622_set_backlight,
 };
-- 
2.53.0

