Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4168CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 412A784CC9;
	Fri,  8 May 2026 14:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iyfpxQhT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hY8oSgY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FCC284CC3; Fri,  8 May 2026 14:23:23 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCB5E84CC5
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBpDl4grpz9tSk;
 Fri,  8 May 2026 14:23:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WAQNDwQt8mfpXnWxIR2g0NSPVC13XDXqPC9VZgstZ0=;
 b=iyfpxQhTfBWu7BeUionS6wTKbdmuePmNFAaDjApcI935LXs/crp2DsVL4kXGDDyPCMtPUq
 4hKu6mKzDKCZUJrqrQGoFX7QfnLw93Ffao1pWnoQKhUmKx/lXm81ByOPkBlWftReZfuQaS
 ob4puSbCpUnI2Oo8qTpZ16NKiI8VtmvPwkXCKAPIy5r8n7KaCVTfOygHeQE1PmQjGWJ3wz
 5H3dVIUd4fjKzP8WwIvSdjkXrHMaUwI6cv11JMu4MRl9qY4be7UTyTDCfssl89zTr/pnrC
 WZFcV3Qs91jjOyUxX4vV6qF8WyLnNNIL9kR3l61mf+shKPDzEf1/j8ut1o8ifw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=hY8oSgY6;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WAQNDwQt8mfpXnWxIR2g0NSPVC13XDXqPC9VZgstZ0=;
 b=hY8oSgY6n2PUzQmO85jPzs58z/tFyMpwJ5l6cVVs53JPXDDMOhQE87sA8N+zOEVdGeuLBq
 ZKrDrgkRc7xuFG43LEeOEMUjyttjX7aPvRFAEyKHo7jF0K/LjVDQb4ZioEn/di5i64R3p/
 c+asD0Yqh7eJ4sz+K3hywPjLdVbmdVtun3bHH15aRq2TKTjPOy/Z8rPAQQxZhJlGJZuzwh
 9MH+MOk8VMtwumIcVLSPI9ySFghb1FOCysNsYR80KeYpcgb6piBtTHkvF0ZIlWgPtrQk05
 WantdruoWaTThTuUAdcCNIC0Bn634LsnqfDovq0RhAs9hy0+A/HmQRy/t4CZYA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Julien Stephan <jstephan@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 10/14] power: domain: mtk: Staticize and constify driver ops
Date: Fri,  8 May 2026 14:22:10 +0200
Message-ID: <20260508122247.512862-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7t63g59n1t7z33n3nbtjqnzdnx3ipqgb
X-MBO-RS-ID: 05952c9b56feb39a460
X-Rspamd-Queue-Id: 4gBpDl4grpz9tSk
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
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de
---
 drivers/power/domain/mtk-power-domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index 2d1ba1855a5..24dd540897d 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -392,7 +392,7 @@ static const struct udevice_id mtk_power_domain_ids[] = {
 	{ /* sentinel */ }
 };
 
-struct power_domain_ops mtk_power_domain_ops = {
+static const struct power_domain_ops mtk_power_domain_ops = {
 	.off = scpsys_power_off,
 	.on = scpsys_power_on,
 	.request = scpsys_power_request,
-- 
2.53.0

