Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB3FCD37B2
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF74B84715;
	Sun, 10 May 2026 19:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Rrzu62XY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hPHxOJGB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B30A84715; Sun, 10 May 2026 19:17:47 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2842284836
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gD8gS3rtvz9trC;
 Sun, 10 May 2026 19:17:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lI+NjxISaKNaViKhncNnVJe0IZmGpHc3cahhF6Hf82A=;
 b=Rrzu62XY7Fy71lO8ZuX/qNnEUGlZEYQPgkFta/Z1OWdmo5VYfl+yXzrCsnbkrFJ7nPWNOH
 2Sgi0cG0szLrrTzstJMBPpOaGVYHNRp4YAU3kHM7m0l/J8wJAWVyK3C1+ejWIkjoBcwomc
 XwL+AMI/feMJfWWG7tMDQWv6ZhCjmagzUqJFeVeBj5LPDV4oPO5E4pBis6MPsJih2mN9lO
 IZKOyiCkvwL9yJzZJhTLiUSv324FrTuL9Ijex3gZ+krkd0qSwL6jn9qwz2bmbtvrQIIsQ8
 j3YXgaVUYc9EnWLuTKmGKtyU2O4w6qX7YuVYpFDaadkYVghKfVJ3hbE8lWtYgQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=hPHxOJGB;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lI+NjxISaKNaViKhncNnVJe0IZmGpHc3cahhF6Hf82A=;
 b=hPHxOJGB5O9WdtCKALVFRxvT4KD+qxWXEbO5W1Zhj+ZRF0Y//7KwaALQsTa3QmBEqXbST6
 yARC5/0JlHEvuitCWpb2eDUmjh5hMihBrfHl4gYA/ZCJ81NCsxCbtOZLQZRyhnOakV0cvy
 N87uugDGJnhJrPPSooPn9MsC8w5BF5PPjnUV0eJrQtFM+sd8h4ksc311D4Xoo/TX8M7ZQH
 ZB2HYc+1PUg0yzJPkZtz1j72PbHEOCuDDtAZg9yGslSIxq+B60znkcEx5ejiRX0EG2mSTz
 h5kaAngdpsWcFf3HE+vV2qfmJZU0kivoddpKO5QYEJn5noJb5bVdB4ZheuKy6Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/11] video: dw_mipi_dsi: Staticize and constify driver ops
Date: Sun, 10 May 2026 19:17:02 +0200
Message-ID: <20260510171723.56866-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: q6i7awiidnxbbowmkgtm718ai39y37ad
X-MBO-RS-ID: 47385f71d6015c68bf7
X-Rspamd-Queue-Id: 4gD8gS3rtvz9trC
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
 drivers/video/dw_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/dw_mipi_dsi.c b/drivers/video/dw_mipi_dsi.c
index c74fe678d12..ec5d4c81812 100644
--- a/drivers/video/dw_mipi_dsi.c
+++ b/drivers/video/dw_mipi_dsi.c
@@ -837,7 +837,7 @@ static int dw_mipi_dsi_enable(struct udevice *dev)
 	return 0;
 }
 
-struct dsi_host_ops dw_mipi_dsi_ops = {
+static const struct dsi_host_ops dw_mipi_dsi_ops = {
 	.init = dw_mipi_dsi_init,
 	.enable = dw_mipi_dsi_enable,
 };
-- 
2.53.0

