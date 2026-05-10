Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE729CD37B2
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CA53846FD;
	Sun, 10 May 2026 19:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="u8TJeYAR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AJXgAm6q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E846C8484D; Sun, 10 May 2026 19:17:52 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E72E3846D0
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gD8gf2t4mz9tKq;
 Sun, 10 May 2026 19:17:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X9pNCDR8l82M5tXbaSZbniOVLZ8C7X9RPplFn8vL58k=;
 b=u8TJeYARHTDTJROygV/9MTk8ojWuqXlm5UPrHplGTjNNd6sxYb/nA2PNAVYm8XSdIQhzTb
 IZ0dBTtTHxT4lQ/jOGRgEvwBIk7qt7gQeWCVLJE6koz+IhBzEWZSw3zxZAClwQwPUDGS5I
 Cx5N2RG6cmfplURV1YFyWaEFM3CXDKQBN1YIYQCkdubpsId+EQVAy/5Kb1XA3VVRT/zHOS
 p3Ez66wh8XXdjtceJQ1dYtHUA8IyjGfRD9TdtZc1VmseLbox+aB8ttUs0ZNAJ5GV0B2kHy
 ZruPMbQZX3zeVVvo5HHOMkEdNbm1bYydVZqGOklcxIpwUPvosa01GBHaFCfD2Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=AJXgAm6q;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X9pNCDR8l82M5tXbaSZbniOVLZ8C7X9RPplFn8vL58k=;
 b=AJXgAm6qlJ/xAQjJm2/zF4GdVvdh3uqqpBeUptQZ/yxeBQfT1/tUBho9qcOIeRbEB2lPz3
 v3dlmYXRGJiX6n3cF8bfZV79WfaczaJEanarJNnw6zAlitw41zxcyZlbGPOMJ5KplI5Xk+
 r2Y6p5myfjHK3b7JCFcxQmZnSK5VvaFofvqjEdWdjCAyYf5G/wrV1kRxwZle5ug7SKG4Xu
 ZNERC2tfsWhAY8auGIwS8KIIcY5TXSrBDviW02OSsgczg1LKjFasPhXYzfCk+5HRUiE6+k
 9HCVS52RHeebinEh3uITC9L6LNNAivUhQRko53p1BmBX+gpwBzMWFobFNpbuRw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/11] video: tegra: Staticize and constify driver ops
Date: Sun, 10 May 2026 19:17:06 +0200
Message-ID: <20260510171723.56866-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: m4pgpyd5tn4cxf9ogxfghnkfaiqyz5is
X-MBO-RS-ID: c960db6d31bff9dab1f
X-Rspamd-Queue-Id: 4gD8gf2t4mz9tKq
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
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/video/tegra/dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/tegra/dsi.c b/drivers/video/tegra/dsi.c
index bc308869f4e..f53fabf6fd6 100644
--- a/drivers/video/tegra/dsi.c
+++ b/drivers/video/tegra/dsi.c
@@ -337,7 +337,7 @@ static ssize_t tegra_dsi_host_transfer(struct mipi_dsi_host *host,
 	return count;
 }
 
-struct mipi_dsi_host_ops tegra_dsi_bridge_host_ops = {
+static const struct mipi_dsi_host_ops tegra_dsi_bridge_host_ops = {
 	.transfer	= tegra_dsi_host_transfer,
 };
 
-- 
2.53.0

