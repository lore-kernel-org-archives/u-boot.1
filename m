Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47F7CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2B2684C21;
	Fri,  8 May 2026 00:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ll//GiT1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="n8BBF9vZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 182E384BE5; Fri,  8 May 2026 00:07:01 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43FC684C17
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gBRDf5jngz9tfD;
 Fri,  8 May 2026 00:06:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROql8ku+AS5YB+T5bteFuJdgw1PTfaSENX2SPXXEEBg=;
 b=Ll//GiT1p8aX0P/Sih03OSwS+S3O3V9iji85nBkD6prXzZwpf40pTWcYtQ75x1SCNCdKJN
 tBL+1j9NBctrZNmF990I74BavAgNLbRyfMChckjix+OuzcFXuW77tz3HeXHHS5XJX1ddrh
 A7xNWXHC5Gmct0/hy8f6w3pIDzlHai7/SIQMery1y6qhmB9ZRp5573g7yjfwvpQeuQTv6a
 KxgQ4SJhVa8K/uI7EhMI4QYDnkNX2QDvykGat5tUj4u3iOZcOROJ65g9XaKd1Lti7W40Ir
 wyTtUPojGJPOa70iAwkpAAE+tlxSxb/MSWADUM7bZtZ2O61V1wfVXgIcPVvXbA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=n8BBF9vZ;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROql8ku+AS5YB+T5bteFuJdgw1PTfaSENX2SPXXEEBg=;
 b=n8BBF9vZ/r/Zts2oKROMu1oZFkz0vNSlKLflvcJwRlIUb5TFwHDe+dYRrsYPdayy6og0VT
 HF1RnHJ27O3TcR/CpIpa7Yo4CjZyexkVw3SFQS6ZTbSqxEa3UCfV7le6XZg5ztpPQOdb4q
 WIhV8TlINX8tAz+xE8+JwpnxeGaeBDdz6GLVvuhLBS4ZfAchGf9mxw9aJxQ6EpvFYs/NAj
 hYmrIUIKlCtFXPc6jMKky5kfl2/AGqE5LVWs3yYTNP5hFpSYxcRFqF1yvSGylNXUobZhjo
 1fI8JwnfFPgbsZX0ErbFo2AUPa9C0yRnHfXCZVBZws8qi0j+qrVt0y+KLlDMgA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH 2/6] mailbox: imx: Staticize and constify driver ops
Date: Fri,  8 May 2026 00:06:29 +0200
Message-ID: <20260507220651.209168-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507220651.209168-1-marek.vasut+renesas@mailbox.org>
References: <20260507220651.209168-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5e1c35d40f23efc962c
X-MBO-RS-META: 194nhfat7i9gjxerqskfppweamyczc1i
X-Rspamd-Queue-Id: 4gBRDf5jngz9tfD
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
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.denx.de
---
 drivers/mailbox/imx-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index c7eaa3de96f..fd0fce21d78 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -387,7 +387,7 @@ int imx_mu_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
 	return plat->dcfg->of_xlate(chan, args);
 }
 
-struct mbox_ops imx_mu_ops = {
+static const struct mbox_ops imx_mu_ops = {
 	.of_xlate = imx_mu_of_xlate,
 	.request  = imx_mu_chan_request,
 	.rfree    = imx_mu_chan_free,
-- 
2.53.0

