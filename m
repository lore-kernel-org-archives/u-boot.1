Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA9DCCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3AF383957;
	Mon, 27 Oct 2025 17:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Apfzf8dV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xpmwgk9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFB8D83957; Mon, 27 Oct 2025 17:55:16 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF319836B4
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:55:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwKPZ46zfz9srt;
 Mon, 27 Oct 2025 17:55:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFwQty2QIfGp1T1Ub/DyHNpmIL+DBUu27E5yrti4ew4=;
 b=Apfzf8dVMk3cFMQaKU9dtK9t9fthVtloGJrkF+h8ynzzcPoKsldQ+yGJaJzDH9zKjKtLwI
 oSLizpezN+KEggCacGQdfRdm0iqn5lyvfFSbDVicPeKI7+TDAgeZPwJr0bzObX/fWmGyvk
 1nQmzOHBLQRhWkoorYdZFBLrHyMiRvZw49AzF7wtGyMov1ExnlqN48cUe4VLe38C5Kb7Ik
 t7/3Nw6bSPuhocIFIcIEM01PVqvLIaXyMq88CTfwCxxnYyuzSt/5BVLBffpSfKEeCRaGL5
 BHByZTaaPR+Mjc7SC3pTeX43K9bL8R4RV28+tv18JRMcohUSHXDzyixDrH5QFA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=xpmwgk9o;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFwQty2QIfGp1T1Ub/DyHNpmIL+DBUu27E5yrti4ew4=;
 b=xpmwgk9o9kIEe6feYeA0OjVRTpzPJYilr1YoNsjiV4b2oSGp4Ukz1pJk6r6hxTkHhLCBwi
 hEblUeW9/j67tDBBdup3cTJKTLsOMvSWrsSRKwrluL83szxHnoNcwkxF09xmQsXdotiu3y
 0noXmpFmrVIun+1c1sLP4UrdCfwD81IrlNgo9fZ9ygIOTcmo+2swyEErVEGtV0nUxisdJc
 6KpepP24gj4KIzgoJ9DmHL9076hkEORAGVoZDc5nvRhjGV01BpQYhCJe/bAyssiazOrv8t
 KXALvnXY3QB3i6ekBoEhTAvLF1lIvcBiOahsi75CZzYEaglsxDByL39T/bNp2w==
To: u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Huy Bui <huy.bui.wm@renesas.com>, Khanh Le <khanh.le.xr@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Tam Nguyen <tam.nguyen.xa@renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] pinctrl: renesas: Show bit position in config write
Date: Mon, 27 Oct 2025 17:53:52 +0100
Message-ID: <20251027165505.20579-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027165505.20579-1-marek.vasut+renesas@mailbox.org>
References: <20251027165505.20579-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: eaf3ktptifgw7mrni8su1zhfu6bqq9zp
X-MBO-RS-ID: a222560b9a68901bada
X-Rspamd-Queue-Id: 4cwKPZ46zfz9srt
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

From: Hai Pham <hai.pham.ud@renesas.com>

Show bit position in config write debug log, which is helpful for cases
where the p port setting is applied at the exact p bit position.

Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # Unsplit the string
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Huy Bui <huy.bui.wm@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tam Nguyen <tam.nguyen.xa@renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/renesas/pfc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc.c b/drivers/pinctrl/renesas/pfc.c
index db6be39a528..dfbb8457bbd 100644
--- a/drivers/pinctrl/renesas/pfc.c
+++ b/drivers/pinctrl/renesas/pfc.c
@@ -188,9 +188,9 @@ static void sh_pfc_write_config_reg(struct sh_pfc *pfc,
 
 	sh_pfc_config_reg_helper(pfc, crp, field, &mapped_reg, &mask, &pos);
 
-	dev_dbg(pfc->dev, "write_reg addr = %x, value = 0x%x, field = %u, "
-		"r_width = %u, f_width = %u\n",
-		crp->reg, value, field, crp->reg_width, crp->field_width);
+	dev_dbg(pfc->dev,
+		"write_reg addr = %x, value = 0x%x, field = %u, pos = %u, r_width = %u, f_width = %u\n",
+		crp->reg, value, field, pos, crp->reg_width, crp->field_width);
 
 	mask = ~(mask << pos);
 	value = value << pos;
-- 
2.51.0

