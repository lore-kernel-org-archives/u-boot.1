Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7181C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 11:21:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 976C780EF8;
	Fri, 14 Aug 2026 11:21:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JhsyoxsD_XEk; Fri, 14 Aug 2026 11:21:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B0E708108B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786706491;
	bh=NMA9DGAtiemSO6PyiJYWB3qTg9JU0rGOBRAZ2G6lHCc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lvEu1QC/8dLEzW7k/KVYTsEKaWy96MXSbHmuxiwiz9BNf0VTuW7UoP5R38FEuip8U
	 i+HI8WZ0tWGoRNFlIUGH4bQj4yxh5Tj2yqmikVAdHOxH07pI0A0SLbNBboEYgzyH3K
	 J6FxpxFMVJ7nC3RrfMD/356PJQAFHj7NAU61RyOH3XXVUwDsjvpYizY49NIrnWSexZ
	 Zx9tNf/LhMYuEWLZN8Sfayou0H1c8SPr5+gZXRcNEdY/wOWHC6qxuKRUDJP6+2UmY7
	 LcY6JW1EO4kgoW2pzyXYLP1aRfCa1xhGQJlgm8BASL9Do1O31oaNX4zuSUUp7KMJuG
	 KtS494V6zJzvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0E708108B;
	Fri, 14 Aug 2026 11:21:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5233F33B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 449E36062C
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fDwPZpln3zSR for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 11:21:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=fra.schnyder@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7D5036060A
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D5036060A
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kZhVOYag
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D5036060A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:25 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49987fb18c0so3416805e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 04:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786706483; x=1787311283;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NMA9DGAtiemSO6PyiJYWB3qTg9JU0rGOBRAZ2G6lHCc=;
 b=kZhVOYagnYSp/f85jD28m78kpgRh5iX7eHhJRQSVKp0R2MfNiEZ4OWbRfac8izyN3f
 FqFKSiU1vVanU/zDMfUEcdw8x781XwFfRCzB1UNf57/qtdQlsh810IDF18CTxkhabvnC
 39fktlGtWpFWj95EYinU0DcJm/b0yASCGB0jeCG5cSuvqrQXdmqguPjPWNZSdXd3FeR3
 4aaq7GfnHfAmoWSPs0kliHkWcYzeDTB0CvjOvEZ/x3HktoF6gNi5fk+GabUgjums5D5B
 WSZ2SLUz2bRMWyLUrPUnU32Bi3ARDPKdab1FVC0AWZDT9mh+M8zLFjH8rv0Oe0uNiJGj
 C8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786706483; x=1787311283;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NMA9DGAtiemSO6PyiJYWB3qTg9JU0rGOBRAZ2G6lHCc=;
 b=ep80FNvlihOjDKgbnrPcNFaY1oYmQJW7EAf7O8VBIzpkOqbLQ6CVkUZPpxzP9mL3v+
 HjKvJkhTtKiSWfimKWQ6WqI5lXoEzmOTC241REi91mLnMOy3Yfl3ScophQvuJlCcnwkO
 E6aiMVvvitX0n/bCjABgy8e9+3KA3B5qJuQy/aYXmRHEszOPCe4W67txIVRrkuusMRbG
 7SPUq+CCepXyVX+NNDDUVh2N545dRmqQb0OExtN3MABQSKlbab9+aHOtaBhuYpLB5rtu
 jqKTEZtLqjnsRuOg/hXSzanZ7i456NF2dyPBtEXWdm8LtxrbwSBATGBEbkhdPDXAt6gj
 3epg==
X-Gm-Message-State: AOJu0Yw4eVPHOniZqcwTiZZyLpsDrnLRAGfH7YgbVu8pt/6msLUmXGc9
 rZwqyp0vBw859gYV3EO88jeAFUYKulXeE2n3Qpiu93IdDcviT5spQlAi
X-Gm-Gg: AR+sD11xbOJVPKK4VUSB+RSBDbkVTmsTlsShUepgu70tHqWLOX4Q3OBoaEGzQOdFVd7
 gqt4dQ5L3rHJ6G4QuGomlhaGO2Ivor6YbmjUHb0gz1atWfZArOGhpr13trcm7gjaeE9BnuqXZPJ
 cPM3/u6qqI5lFPwPG+1UKqobe017l8sUakCt10Od28EwqEj9F4LVzyeZKs3WttaErES+jDOZGTa
 zXyw5gNd8cQpMN8e/Kfr9r5texyjowR5+l5EvxwFAFucQ1YG30kRb9BD6gxnHO0ezwcqoRc3mcS
 UN0aQroG3IzE1HLqC/5mBnqGhXKlc8MDFE0odC4HDREeY1Bh8W6OVyvOZsl1KEl3y3IbkL67cRf
 5gs0U+WyfqkTJSyfNW9h+vackc9Ela4VdsMw+wIRPYdD8RoroaJ3S+TwBMGb0GQgFMHztY3cedt
 YBNETH/Pq1xgo8VZm7YQF5AvSRL1A+MnJ7KWDqC311EbAvAU39v+1CCrSYvmBk+d9aBstpI+Nlg
 fbYdami0IsPdTgWrEtWd1pGEYFo9KOOrZlgczHRJgY3lacp2rZ5X+h+3aEWKHzHX61fzFMD+TAO
 7B7cSeo5OnW5wLZrRReKWeFKzUGRKY36HosTkg==
X-Received: by 2002:a05:600c:3651:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-4998797d3f9mr56445295e9.12.1786706483401; 
 Fri, 14 Aug 2026 04:21:23 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b2a509sm41692355e9.14.2026.08.14.04.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:21:23 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Date: Fri, 14 Aug 2026 13:21:18 +0200
Subject: [PATCH 3/8] toradex: verdin-imx95: Set WiFi DTB as default for new
 PIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-get-rid-pid4-table-v1-3-b8605ac094d0@toradex.com>
References: <20260814-get-rid-pid4-table-v1-0-b8605ac094d0@toradex.com>
In-Reply-To: <20260814-get-rid-pid4-table-v1-0-b8605ac094d0@toradex.com>
To: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Franz Schnyder <franz.schnyder@toradex.com>

Currently, the Verdin iMX95 uses the Toradex product ID table
to determine whether the module is a WiFi or a non-WiFi one and sets the
DTB accordingly.

In the progress of decoupling from the Toradex product PID table, use
the WiFi DTB as the default for new PIDs.
This change is safe, as on non-WiFi modules this leaves the WiFi and BT
devices unprobed. Further, the SDIO/UART signals are exposed to the edge
connector on non-WiFi modules and can be used on the carrier. However,
no Toradex carrier board makes use of these interfaces on the carrier
and it can only be achieved with a customized board. For customized
boards, it's expected to override the default selection by setting the
'fdtfile' env variable.

Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 board/toradex/verdin-imx95/verdin-imx95.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/toradex/verdin-imx95/verdin-imx95.c b/board/toradex/verdin-imx95/verdin-imx95.c
index 7c0804c1d1c..2651d3dd871 100644
--- a/board/toradex/verdin-imx95/verdin-imx95.c
+++ b/board/toradex/verdin-imx95/verdin-imx95.c
@@ -19,7 +19,7 @@ static void select_dt_from_module_version(void)
 {
 	char variant[32];
 	char *env_variant = env_get("variant");
-	bool is_wifi = false;
+	bool is_wifi = true;
 
 	if (IS_ENABLED(CONFIG_TDX_CFG_BLOCK)) {
 		/*
@@ -27,8 +27,8 @@ static void select_dt_from_module_version(void)
 		 * module with Wi-Fi/Bluetooth make sure we use the -wifi
 		 * device tree.
 		 */
-		is_wifi = (tdx_hw_tag.prodid == VERDIN_IMX95H_8G_WIFI_BT_IT) ||
-			  (tdx_hw_tag.prodid == VERDIN_IMX95H_4G_WB_IT);
+		is_wifi = !((tdx_hw_tag.prodid == VERDIN_IMX95H_4G_ET) ||
+			    (tdx_hw_tag.prodid == VERDIN_IMX95H_16G_IT));
 	}
 
 	if (is_wifi)

-- 
2.43.0

