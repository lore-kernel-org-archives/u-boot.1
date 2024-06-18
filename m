Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB068C2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 22:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FA36883DE;
	Wed, 19 Jun 2024 00:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="botFW0u6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bozcl4p8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6710B883B3; Wed, 19 Jun 2024 00:55:35 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE627883CD
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 00:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W3htD3bysz9stf
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 00:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718751332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ojwlJ5l7u/0o5haBXfW/DErpFtdPyj1szb7yCuoIjc=;
 b=botFW0u6HagwyvqJS/cYwRZRrR0o07Nz1Q0UUlcruKl2XL28ftvCzF+z7bJuXTvhCXMugx
 flb6l7jAaS/7LTHXN1FkbAP7ygR25MEivLkv37yhR75TReTjIYbffniohrj3e0s3YlGoD2
 nMYyM1iiDDbT1SMPfVYtTHg6mlPf49FeYAksn5jXMFgdoMwCRQIr6b5+ttPDh0B6WzPKKN
 qDXgfZWZooKLoNs19GJCJomBfQQPadLomCkspiWf0Rlqck6UpApmuIhiGA+iMFw0dGYz43
 EJ1hR0daMuDw2LwcntZJLRQtF8Zp22zuWd98FIRDODunRyVN/P889EfHdFwTQg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718751330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ojwlJ5l7u/0o5haBXfW/DErpFtdPyj1szb7yCuoIjc=;
 b=bozcl4p8XUhXyKIsZOCXeFyXBdndIw5pimkKumm+nLyq49FFxEQGOwE8s+vp7W/MiefCm6
 f244eJQaNzXOcRddqx6XD7TGEK5oQW1Uy0DVjx6b2/2/L8n6B5nRF82strPByw0Y0r5TF2
 lDkwoQLm5VXPt+uVwAtbDHvofMX1LafjNpu1Tsos9m8SXavE39x6BNzMnn0kvOkzW7a69q
 VOcDQl07YcCAAHP8comlAjaNAwQ3XUfMyuFs1/50Cu/W75l0u2s2RUZMfXQvAXW9vf70I9
 4IwI7lHnKzfD2L14stVaWHsoSOOt2wppb62ViejMznx8lKuNxRDdhXWMcJLWwg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 3/6] clk: renesas: Synchronize R-Car R8A779F0 S4 clock tables
 with Linux 6.9.3
Date: Wed, 19 Jun 2024 00:54:17 +0200
Message-ID: <20240618225505.154437-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240618225505.154437-1-marek.vasut+renesas@mailbox.org>
References: <20240618225505.154437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1712a1e3254b013df08
X-MBO-RS-META: c86eucgz88okraptb11g5e195yd3kobe
X-Rspamd-Queue-Id: 4W3htD3bysz9stf
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

Synchronize R-Car R8A779F0 S4 clock tables with Linux 6.9.3,
commit 1b4861e32e461b6fae14dc49ed0f1c7f20af5146 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a779f0-cpg-mssr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r8a779f0-cpg-mssr.c b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
index 108655f145d..ea98bc6e50c 100644
--- a/drivers/clk/renesas/r8a779f0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
@@ -156,7 +156,7 @@ static const struct mssr_mod_clk r8a779f0_mod_clks[] __initconst = {
 	DEF_MOD("cmt1",		911,	R8A779F0_CLK_R),
 	DEF_MOD("cmt2",		912,	R8A779F0_CLK_R),
 	DEF_MOD("cmt3",		913,	R8A779F0_CLK_R),
-	DEF_MOD("pfc0",		915,	R8A779F0_CLK_CL16M),
+	DEF_MOD("pfc0",		915,	R8A779F0_CLK_CPEX),
 	DEF_MOD("tsc",		919,	R8A779F0_CLK_CL16M),
 	DEF_MOD("rswitch2",	1505,	R8A779F0_CLK_RSW2),
 	DEF_MOD("ether-serdes",	1506,	R8A779F0_CLK_S0D2_HSC),
-- 
2.43.0

