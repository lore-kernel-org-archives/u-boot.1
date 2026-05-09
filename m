Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A3DCD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB71984D80;
	Sat,  9 May 2026 17:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dVvBmV5q";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bPZ6RmSb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D72DE84D78; Sat,  9 May 2026 17:13:25 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 085C984CC7
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gCTyW3p3Rz9v5y;
 Sat,  9 May 2026 17:13:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPCNT571Knc9H3DqmbeJ0UadBlH5wptlI7oMUiQgL7w=;
 b=dVvBmV5qD1s3EPK1iyn/lWssozLiKKqG4VphPrZXq6XeqX4VjrSn0LPGydWTd+aDhJnGbe
 y6HjyjTTIxc574h2wmenmENdJO9C5uAOyEPr5RMHDvqKuh2ukBR5LBQViWGopk70Ja46mE
 tPDfK58wwXbtjb0h3+D6igg79z+znbVWb5RmAKde1LMmsB8gTnycoQ+S7b2NmT+NJI2/wK
 X8+gwZmeSnr24+sf3pCRyO5onxUSMmCKXszLTOOJcf9aGIt5TRV9Sk0PXXe9u2t0VQO+St
 QT571CPaAgva+yOdo5A8xdfYmfYHDJ51Zx6y+ikY+P0QwicXS6AdgNCVHHEUiQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPCNT571Knc9H3DqmbeJ0UadBlH5wptlI7oMUiQgL7w=;
 b=bPZ6RmSbSbgQVdhW9mKjvZDVu6nBu4MrTo4v8Rfbuwt1hiTYFWnwANZwGwT4H6N5iOXSf0
 dMZBz4hG8TYXqVZbMN3YrQfb5gBoBCalmjLZxQvy82qNNio9N5A5zq2jh62hAw+OgjNLnb
 i2WqE0bnRz4P9+M1mfMc81WtfiwvFeD7hMiMaIHYSJxUQlFxoVxDQeLfXlLrwQiqJZqR/g
 zLIIXA9puUVC/n/XqldNgpsD7c3Y11uewejUvWiAIz/b//0g08IGbSwlSOtYX6cEWRHch2
 YQnIyGqyv94dVyuFGXQH7YFTCv0GAcJA/XqGE/kNXi5miBrUEffmfHPfM5+5ug==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 06/14] reset: mediatek: Staticize and constify driver ops
Date: Sat,  9 May 2026 17:12:29 +0200
Message-ID: <20260509151308.23067-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
References: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a0351ec9acb52ac37de
X-MBO-RS-META: o3mtanbrrspmhba9zz677mez7e6s8z6d
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
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de
---
 drivers/reset/reset-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-mediatek.c b/drivers/reset/reset-mediatek.c
index 4b3afab92ea..66bcf7c29b6 100644
--- a/drivers/reset/reset-mediatek.c
+++ b/drivers/reset/reset-mediatek.c
@@ -47,7 +47,7 @@ static int mediatek_reset_deassert(struct reset_ctl *reset_ctl)
 		priv->regofs + ((id / 32) << 2), BIT(id % 32), 0);
 }
 
-struct reset_ops mediatek_reset_ops = {
+static const struct reset_ops mediatek_reset_ops = {
 	.rst_assert = mediatek_reset_assert,
 	.rst_deassert = mediatek_reset_deassert,
 };
-- 
2.53.0

