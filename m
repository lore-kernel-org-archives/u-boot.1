Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0766FC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA2FD88C26;
	Fri, 19 Jul 2024 12:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cAtMwfsX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cPni60Bs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13A1488C0B; Fri, 19 Jul 2024 12:50:45 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 251E888BE7
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WQRKZ67jhz9smm;
 Fri, 19 Jul 2024 12:50:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8qfX4uCVatOPjQ7S996mR6GffxD+IMEI77v71d4OmJg=;
 b=cAtMwfsXFbGr7y2tGPucjUh0wACw8ISP50+53KKLxPH7Go5gnL4TvhrSb4aDLLUm2qXqyK
 KWMYdcBKgcwlN6mxBTZKCmLW6XEGAPh+SEkRog+n8LGSwEv+Y8pwJRBJsIxVvQZ7Sr5JiU
 aBkDBXpQF3SFUwlqAp2jXW1y9HxQpnfTz9id7U7r1dySqBHXDoO62rxi51AdrjVZbRTv2v
 xwUSIFlOZuHEva4ecRaTTqyZbvXekeea6yhf6sKqNcE5+jvzrHJyknMlGBpElwVP+zZGRg
 jKfinn7PyaT6x6xbydZXUvXj16goqMGsGC1TUduvqokoVTvFeVjnp3I/wwJE+Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8qfX4uCVatOPjQ7S996mR6GffxD+IMEI77v71d4OmJg=;
 b=cPni60BslpDbQr2jzIL62cw/ENReoFcLlrVQX+dD42HHXehhvOvoSzVvqxrmRbHuSZPR0r
 jduOM+s20LEAZeVTMj25dkzTp+hPfuW3c4Jkz7RQUjNu69f/ujPGZke5T4nrqJ8kzsP+Gt
 1hNGJX/77MBVKbFDP32vurpA8AezIB6R7BmfqmMLpdRph8cqBJNpto69rd5inpsUGCONZc
 iKevfKmfTUc6OdRVq+CQ32JT4KnOhv0w0Mnv+sPHSZyrHrpkaVDpm2cNYXuxfVOYOFRn+2
 11b5AcQJGfmk0yyhx48aqE9N+T4aCld9p/YQFOFQi7R5reCz+ybR4q1UAHfI5Q==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 25/37] board: qualcomm: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:49:02 +0200
Message-ID: <20240719104948.323791-25-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4yp8id6zwtbno91y9gagzt53yq45qqd5
X-MBO-RS-ID: 2f027c8a2c5bdb08135
X-Rspamd-Queue-Id: 4WQRKZ67jhz9smm
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 board/qualcomm/dragonboard410c/dragonboard410c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index bd2e213b3bc..fcbf2c3fe60 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -115,7 +115,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	do_fixup_by_compat(blob, "qcom,wcnss-wlan",
 			   "local-mac-address", mac, ARP_HLEN, 1);
 
-
 	if (!eth_env_get_enetaddr("btaddr", mac)) {
 		msm_generate_mac_addr(mac);
 
-- 
2.43.0

