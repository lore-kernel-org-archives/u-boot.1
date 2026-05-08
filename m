Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4465CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB78A84CD9;
	Fri,  8 May 2026 14:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XvKqcD9L";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Q46CgbYx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE7D84CD5; Fri,  8 May 2026 14:23:27 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 497CE8488B
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gBpDs0ZwVz9tG4;
 Fri,  8 May 2026 14:23:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778243005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YF9Wlpw75HnswNs+MdCOBkDbNXi0iPj13Ip0vv/xVS0=;
 b=XvKqcD9Lu1Prjj4bdxxRk95aS3uhfp8Yefb+qfM5+IBRMxzQXSds/HDdOfWrBSKW8vE5rr
 WiEB/2vjRKa4nkxOUKqf4VZr/NEno3FhEAGGVZ3hHHKOsla9S2RcFcHHM2cuWKIUC7p28d
 Jx0OlIXwrQcLXRbu9HrvgiTxrZnxsaesnFTCQ9n2cehGHrgvAoZtIz4DzyN+0rBUS7UemG
 iS0yVYTvamSxy5TMMaJmo1yODRq4OCzaj8oI1tiwNFCw8IOaKqGH30j3L4Qqs2QTXysPB0
 n5QqaemSNTmuU6PhbrByzQBCTrIJkJlvJZkUlQmYv9ngO5NL9fvSdcVRAa2UCw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Q46CgbYx;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778243003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YF9Wlpw75HnswNs+MdCOBkDbNXi0iPj13Ip0vv/xVS0=;
 b=Q46CgbYxQQ0N6giN8AbE506CcRqgtBupr8P4k10jJi56AmhY5Kv+CXvyjwp4+lwkDrLnZM
 IDDfulcWAwq9xqGAodoRk5GWrEqvKpkpD6DK/A9Pmixj1JqOVuzUpmv0L281xwSNJE900u
 yuvnJjMRbYrkMhQTnzfUrb5vP9EStimlM12jxhIbLPke5S93QmvnoXIq39eRzu5kFX4UwK
 ab3wjW7BHziiIHUr1rgZHtrqMKcVK/kaRPV8U7N1y14l0BIM4GupXRM8bv2IDE7THN19gx
 TqtQOM+sgdHXraEDiSptpthvMTWBL//dR/Uqq5C1xWaitrOZcbGqZ8Hpyw3RUA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/14] power: domain: tegra186: Staticize and constify driver
 ops
Date: Fri,  8 May 2026 14:22:13 +0200
Message-ID: <20260508122247.512862-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 226c54cfa6a4b2e6c8f
X-MBO-RS-META: we4dwk3tytpqbm5n14omkmqbhy33ogjx
X-Rspamd-Queue-Id: 4gBpDs0ZwVz9tG4
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
 drivers/power/domain/tegra186-power-domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/domain/tegra186-power-domain.c b/drivers/power/domain/tegra186-power-domain.c
index 334c460c805..3865cd4cf47 100644
--- a/drivers/power/domain/tegra186-power-domain.c
+++ b/drivers/power/domain/tegra186-power-domain.c
@@ -55,7 +55,7 @@ static int tegra186_power_domain_off(struct power_domain *power_domain)
 	return tegra186_power_domain_common(power_domain, false);
 }
 
-struct power_domain_ops tegra186_power_domain_ops = {
+static const struct power_domain_ops tegra186_power_domain_ops = {
 	.on = tegra186_power_domain_on,
 	.off = tegra186_power_domain_off,
 };
-- 
2.53.0

