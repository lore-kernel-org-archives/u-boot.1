Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CEA606A32E
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bb1jNntL;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P410aGpg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 848B481A92;
	Sat, 14 Nov 2026 09:11:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nn-b7SwMda_k; Sat, 14 Nov 2026 09:11:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9713781BF4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794647506;
	b=H9U8NhJJN3lMWqIyRpdmJf/c/Qt/UJi08IBQ0s/qxtSMj8z4ynLadD+WD3nHATA0GKfo
	 CV8+YzWDG1hR+ibjqXKw8FiHHno+5WwaBhYlZbb4Du/PGlCBJb4gPa8xPIlQp2oWzdDY5
	 et9NVJUocq5qVzdzTCapeHO0C81o1sqU0ICdIh2NHkdl6ZsydzSxc6zeP8GyhGqcumr77
	 PxBBqoA+o7DfXT+etI4PnXH1PVkwyr5MT0vFPAqVtYWVr2hFGe4L9e6MunXUq63TWVOno
	 EO+07P9J+uVvNGEc7raNJmdGV6LGGMMxrfSKNhqsdXbfNsoHzXrWiVlpHB5GEAZpuhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794647506;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Miq/IkvYmXkvne2NuMiFFUIFykAqiEu+4K6J7WM4MCg=;
	b=ZUnz8rHLpOM7917J61qkgMhCF1PmHPxreDEHfUMabt0EhbAQF/TFHb/eW+IKHD3wJ2ny
	 bVMECtqEiAf7e8bcJp0jm3JS0ekhPCzUY7ZROjSm+CRtmxVAj/lVMO5SDIi9XxmyTzunc
	 81Jn1LEd1CaiyCTUo2a4nJMDnpvoOrV13pAVWLQyNfW8BEbR+O9XGDjUH2C9P5UUSBUml
	 9XcYFvkj8Dlzxit9D889WYuO4IzUwpYfAZSRoAjlgV8q2KQ0pzKbQEJgcKI1Yr7R99AmA
	 MvPtTfVCC2IihdrEO5CH2EtF5XVxtz8zvaRuPBntbY7V8cObgWWU3+IkPg2m9ImYW4Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794647506;
	bh=Miq/IkvYmXkvne2NuMiFFUIFykAqiEu+4K6J7WM4MCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bb1jNntLnjwbZiyKV7AdnK6gW4kpijXG+bWas6rNCanmoOvwWroGGtMXEUmm/JwOS
	 sFxfAlE2nQJsVHoSLfMB1XTLTUfhOkiO2mV60svCRZ1Dug/hHihjmp9U9ZYKSpCBYE
	 r9ij/inEDsR0POn909qdeKdSe54glCZyH3puanXEjSMpU1OM1WAt62D4XhUqn8l8QC
	 Pov2Uxzf1aAWMqLusTbJ83sK8TAne2+rNUujMnGc+TGCHFc5BvCxzzyY6K/8S7w1KK
	 i5jRrrNOz3BN/Fe/ThRO+v6os+OO6oX3qNF+EDF9k1rCwcFZAUnCzj2YvanynCj8qL
	 jVq21qGy3vQ6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9713781BF4;
	Sat, 14 Nov 2026 09:11:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CAA0260
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:11:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6EDBA40DF6
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:11:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zWd0vp7_8hME for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 09:11:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4B1774089C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::229; helo=mail-lj1-x229.google.com;
 envelope-from=csharper2005@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=P410aGpg
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B1774089C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:11:41 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3ae3b5b1027so698271fa.2
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 01:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794647500; x=1795252300;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Miq/IkvYmXkvne2NuMiFFUIFykAqiEu+4K6J7WM4MCg=;
 b=P410aGpghPLXX2wxNVEohtrx2JIFNXv4NOOX1+vK2r2f8OBOFtygRZCCjDDyKzWWNy
 G1bDzjbb9ELwCqtlwuxIdZiedht+lgsn5yRMXfr9Q8bRV9mPL4D6mAVfa2RUuXuOgUo7
 hAdXJFpTsZsLdUHTAgjThSHVGcUEA35gjk8bpEqcPppq4t08UWdMl6+DAfpJUNCxbzOB
 U6LP26/pc74hQXY4GZ6fZuObl/4mLaPqwplp682A/UjIz0EfRpSRD+MIGTci7V8AoKSq
 QW6sPUyxzs8U7OLEHCKsDNZFT0TMObRyHtaZc7fqMcKq3KBPTyxg1CvncPz9FdEKb8lz
 UFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794647500; x=1795252300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Miq/IkvYmXkvne2NuMiFFUIFykAqiEu+4K6J7WM4MCg=;
 b=2r1WkNpVW7Bi+YB4hRgxN7u2OXnmdWKfX9fVni3ZFBN3KuNRF+OphHOhtt0Rp9HgX3
 EcuYZfeHpNWNyJOwAk1LRCUUlvo1zUilAIFmy8ajNodGTyPkd8yW62Q6SxwrrVw0Sz4A
 FUNR6wJ9KlGKyojr2zSmpYrXd/xVze/2e7pHOgA/l0pPPBs6tGCu3dP9Fqh35nUCBKVi
 DBP4fockmn1DBvbgXkeabip6FH8A4lYDiSXr+glwU0gbXQAsUwqguVRFuKLf+S6qFcWc
 dtyVG8GaPXceQJ35PeQTWL3j47bzTQID0N6NI6oKVpCShBtQ1MIiqIe5pknMINgzTuE3
 PMJQ==
X-Gm-Message-State: APuU4Z9PUBYvIztIIEDXSMqthrZYFquQPIP8vM7enrcDLW3n3gZyxIIo
 uxRLG4ws21l4g7wWnuzKhwXPVHl8OBGNQDXQNIOu2F3y4eSs72bWKZzOq+Tqe1AK3vgnRQ==
X-Gm-Gg: AYBFou2ekTGlr6rek3r6U0HczW/Rrps9Zh8DxJ1HVhqluQv6DIX6l7eU5cwejIr3u2/
 LGazrXuRuQukiIZc/eLAhVltbsrDhuJgG813sUryjJB4fLdyzM70W+YPmrkbhr6LfYsUnLWygqk
 3KcORDWAIsTIGC0uIFwhK7Nj2utnYQCHT7sOL51MrG4phXswu6g2ZP38D58NyH1RFVzLcBTARdk
 F7+kprpyO6JhEC9DGxuuo7vQIf8BmGar8rgOWbCl6N0hOeCTO21gIv5JVEHOLacheaTJLELxJnD
 aY1BLSIMPC08UqT3jKqPSMliC2D1OpXeDwAKeumGVwQomXx9dGUw2ugSKQ75nBQwQqMI9KJ9Ztm
 pDsjNuiq+rfUBAMyy5hjWN1bDwbxD7Aqfqzix7R2CBhhA3+XCl0apZRnfQ+g25CbFZQMGJj/tr3
 h+OMgnpS2HnSUBV46BwngXXVoSHe/TPIP9pu5obSjvL25q9A7mO9dXbolfN14cQBekEHZX7gSph
 kEcVSKIwGftIqrrybXYDYCoCBF51PRZoAmusQtozCaWngJYB88vmhlna9/f2kwcPDt+TvH681rK
 pvaamczJW9cJr3f3u01WM0t8OPkKwRNJq4DIsIE=
X-Received: by 2002:a2e:7815:0:b0:3ac:dec0:158e with SMTP id
 38308e7fff4ca-3ae2b4c91bfmr12234481fa.2.1794647499601; 
 Sat, 14 Nov 2026 01:11:39 -0800 (PST)
Received: from OpenwrtBuild.lan ([178.207.14.215])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae2b7aebd1sm17097191fa.29.2026.11.14.01.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 01:11:39 -0800 (PST)
From: Mikhail Zhilkin <csharper2005@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, igor.belwon@mentallysanemainliners.org,
 jstephan@baylibre.com, GSS_MTK_Uboot_upstream@mediatek.com,
 trini@konsulko.com, dlechner@baylibre.com,
 Mikhail Zhilkin <csharper2005@gmail.com>
Subject: [PATCH v2 2/3] net: mtk_eth: an8855: sync link error recovery config
 with Linux
Date: Sat, 14 Nov 2026 12:10:48 +0300
Message-ID: <20261114091049.2418574-3-csharper2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114091049.2418574-1-csharper2005@gmail.com>
References: <20261114091049.2418574-1-csharper2005@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sync the Link Error Recovery configuration with the proposed Linux
driver [1].

Currently, the U-Boot driver explicitly clears the
AN8855_RG_LINK_ERRO_EN bit (bit 23) in the AN8855_RX_CTRL_26 register
during SGMII initialization. Setting bit 23, while explicitly clearing
bit 24, matches the Linux driver behavior. This allows the MAC/PCS to
gracefully recover from momentary link errors on marginal hardware
rather than dropping packets or the entire link.

[1] https://lore.kernel.org/all/20261009161102.38961-11-ansuelsmth@gmail.com/

Fixes: cedafee9ff39 ("net: mediatek: add support for Airoha AN8855 ethernet switch")
Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
---
Changes in v2:
- Also cleared BIT(24) to exactly match the proposed Linux driver based
  on review feedback.
- Changed "upstream" to "proposed" and added lore link.
- Added Fixes tag.
---
 drivers/net/mtk_eth/an8855.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mtk_eth/an8855.c b/drivers/net/mtk_eth/an8855.c
index 663cc5d935e..d06493018f0 100644
--- a/drivers/net/mtk_eth/an8855.c
+++ b/drivers/net/mtk_eth/an8855.c
@@ -599,7 +599,8 @@ static int an8855_port_sgmii_init(struct an8855_switch_priv *priv, u32 port)
 	an8855_reg_write(priv, AN8855_PLL_CTRL_0, val);
 
 	an8855_reg_read(priv, AN8855_RX_CTRL_26, &val);
-	val &= ~BIT(23);
+	val |= BIT(23);
+	val &= ~BIT(24);
 	val |= BIT(26);
 	an8855_reg_write(priv, AN8855_RX_CTRL_26, val);
 
-- 
2.53.0

