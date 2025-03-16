Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EC5C35FF1
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 13:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B227581101;
	Sun, 16 Mar 2025 14:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="spcfIMR3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eaM5UaXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CDD9817D8; Sun, 16 Mar 2025 14:54:49 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F2FA81100
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 14:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZG03B62vKz9slq;
 Sun, 16 Mar 2025 14:54:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qe/fnArpHcajIEulqkC9MAfgkZEMTiFMgp4RiP4h5bQ=;
 b=spcfIMR3e8Z23hnZ4FsCj8+HP5ODXQWtrXQCBvsaRmMBiMrLXwrw+h+bvq3FEXx+Og7q5l
 i9svdHDstiZe8zrutBa/5oRAD6MtWbyZP4eiy1lzcYPh4+Q8UXkfEt+AGJ4u//42+7eITg
 hUyMy/ovfGcRAS7ale//LcIWolPMxLSO3SuocfSAJnSOWWAf5dQKN/IPitd10Kd4sTNWe6
 dKljhZWN8e1K+dA8u4vMlvAeGrwEqc/aB2xp2OXhaLXzkIWIsUnp2cwj8RO2HAMXFpmpo/
 cpxwUYX6r8x2YkTtdtt78gfSP97kTeGYsL/PvtfQN5n88eFGHzJDacaVvsa17A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qe/fnArpHcajIEulqkC9MAfgkZEMTiFMgp4RiP4h5bQ=;
 b=eaM5UaXzT73VK9pzxrwPrAkblj5W9olP6uQfRFhIwSpDiQEeH6AuJhVl7/8fof7XoWJw9S
 2SPOxPBFd3RyBtZwfL4giRgdd4eein4ZTZTjF3A34pg4NwEh1mvYmOwgHkZDVOzpnD+4b0
 cIeWm1oC4+KTUgCQv44ywgOOlsU4qV4/QfDApkV1lV9BCmUNPNm7dJ97WmfEqIBhFup3xr
 Xie8KE4ALPYDmGg/B5+lTBrVedDComOTt+NqNTKbrA6yMnUY7yn7ME05orfeEMO844/ms5
 Mx6FTrOY+KKZIHF0DOOoyhgrrMxLTyQbjcfz4grIKBuop35vHT191UVaNLjdIQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/7] ram: renesas: dbsc5: Fix JS1 index calculation
Date: Sun, 16 Mar 2025 14:51:40 +0100
Message-ID: <20250316135417.7909-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250316135417.7909-1-marek.vasut+renesas@mailbox.org>
References: <20250316135417.7909-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: p8kqrxko95tdt6j9zq3yes13ds63cfrx
X-MBO-RS-ID: 1006d07bd4c844fa39e
X-Rspamd-Queue-Id: 4ZG03B62vKz9slq
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

The JS1 index is calculated correctly, but the limiter cannot
be the max() function because the index should be lower than
JS1_USABLEC_SPEC_HI and the max() function would unconditionally
override the JS1 index to JS1_USABLEC_SPEC_HI. Use clamp() to
limit the JS1 index instead.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/ram/renesas/dbsc5/dram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ram/renesas/dbsc5/dram.c b/drivers/ram/renesas/dbsc5/dram.c
index 939775d4d16..289d1224673 100644
--- a/drivers/ram/renesas/dbsc5/dram.c
+++ b/drivers/ram/renesas/dbsc5/dram.c
@@ -2192,7 +2192,7 @@ static void dbsc5_ddrtbl_calc(struct renesas_dbsc5_dram_priv *priv)
 		if (js1[i].fx3 * 2 * priv->ddr_mbpsdiv >= priv->ddr_mbps * 3)
 			break;
 
-	priv->js1_ind = max(i, JS1_USABLEC_SPEC_HI);
+	priv->js1_ind = clamp(i, 0, JS1_USABLEC_SPEC_HI);
 
 	priv->RL = js1[priv->js1_ind].RLset1;
 	priv->WL = js1[priv->js1_ind].WLsetA;
-- 
2.47.2

