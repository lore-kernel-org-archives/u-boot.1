Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0245DE784BE
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 04:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3757839E8;
	Sun, 28 Dec 2025 05:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="d9iU9aIY";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="hgypvvKN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5D0983956; Sun, 28 Dec 2025 02:04:55 +0100 (CET)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE3418398C
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 02:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niklas.soderlund@ragnatech.se
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 0C3F7EC0108;
 Sat, 27 Dec 2025 20:04:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Sat, 27 Dec 2025 20:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1766883893;
 x=1766970293; bh=1ClscerOlh/6zwcSs/v3xq1N1EkiDV/ee1lpw9b64mM=; b=
 d9iU9aIYOfMjXOmt2bxqTzfkTKsYSeLV8rK5pWdfI7/xwbWqDAxHnLIT9+OY2CBe
 Z1doNq0QJIZhxT9amsGvCk2kXbMUPKpXdCr9dcQNSzUQVEpLcJZsLRWRzQn6cKn1
 zy5kmlGAUCFzmsgpN2xOFzUxeWDKEmfoE1t1gbMt0pYCLdY3j7yssHB4Jvo7hmaV
 TYpAhWNweb+/wfDaV3uNYQxdHfHUirD3JkJ5tk3TFvo6mY5RW1kM66xQ0IkQ+UZd
 SkTzmc5U9yqOocebmFgJyTEV8BXLDgJBBHQAS/y7npNXv0av2ww7uaem+60ZtwME
 lWIBa5qPN4Damm1/puGPUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766883893; x=
 1766970293; bh=1ClscerOlh/6zwcSs/v3xq1N1EkiDV/ee1lpw9b64mM=; b=h
 gypvvKN4/0QJUyyZqo4cm5294S68rvvcj2bv8kc/2pUitskzr5jgNOqO/xBcQO6o
 pkKnsm9oTVkXdcXZ9fdKP7ptSS3m8f8+NfkJJVwNTHgHkxhCDg2x+2E0XMZK/Aui
 UNKa2DgeHizGFSa/lN+ChvDnKeMzOWQkHH+N4/l4NDi7TLWMfcRx3yPful/yyHJF
 etmokebE4CRdJE9hetVVj+pJtSzMB16R/Nda4R2zvVcWgkpLyZUFEoVgHsNRJaZy
 y0KfcEAmInxFYo/qE/5LxdR7kvaWKyVzhASkkxNoWWXB4uuZ2pFg/rAZG2SJUCjb
 eXYigA0dKMEsTmvg1oeZA==
X-ME-Sender: <xms:NIJQaUe20h3MZinFUar1vmwzafio5-3vo8wr1mEBjPbm0utGwmr_9Q>
 <xme:NIJQaZ6nYJWdIwFoq6Z41nxd38HbQE67dHM2wqMW7pHoA0y_YAmWvoUn9QqOnX-iG
 LRJuq-6jZqJRZFmtkNZf0tEdTmTxH5mk-pmCHFqLpQH2AuEN2gEWa8>
X-ME-Received: <xmr:NIJQafWsKkPYQOD_1r5nojPqOXauBzl0flMTuB0ZqeDAY0KuBYuXz3PRKroXfMzyrSNMl131LLxX3xbN5bvUrLGJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejvdeklecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheppfhikhhlrghs
 ucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvghrlhhunhguodhrvghnvghsrg
 hssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgrthhtvghrnhepheeigfeuveeutdef
 hfehgeekvedtleeuueekveefudehhffhjeffgfegffelfeegnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhikhhlrghsrdhsohguvghrlhhu
 nhgusehrrghgnhgrthgvtghhrdhsvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmh
 htphhouhhtpdhrtghpthhtohepmhgrrhgvkhdrvhgrshhuthdorhgvnhgvshgrshesmhgr
 ihhlsghogidrohhrghdprhgtphhtthhopehifigrmhgrthhsuhesnhhighgruhhrihdroh
 hrghdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepthhrihhn
 iheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrd
 guvghngidruggvpdhrtghpthhtohepnhhikhhlrghsrdhsohguvghrlhhunhguodhrvghn
 vghsrghssehrrghgnhgrthgvtghhrdhsvg
X-ME-Proxy: <xmx:NIJQaQ4yWbyJnqG2VYBEstrLe_LSCo5EP0dQYdhyfrRpL5D_V8SnLA>
 <xmx:NIJQaSqzUARzTW7_HIa297oDlrrDCgmWBv3Y6MQ92iU4KgDED9ty8Q>
 <xmx:NIJQabkjPH3l8mrVbU2e_JxLdmNsSYKfN2P2IpSyPmAeT-EufEp_1A>
 <xmx:NIJQaWPiR8UVPqoR2GbxsJ5iBXMgydP_ZuGW5_UcCfWpUyIEB7yyOQ>
 <xmx:NYJQafrTxR5sDqb6CMkc-pC21T1yxzUcPK3QpHVZzA1itRGVhKICjdJo>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Dec 2025 20:04:52 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 1/2] clk: renesas: Do not enable MSTP4 modules on R8A77995 D3
Date: Sun, 28 Dec 2025 02:03:26 +0100
Message-ID: <20251228010327.2836161-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251228010327.2836161-1-niklas.soderlund+renesas@ragnatech.se>
References: <20251228010327.2836161-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Dec 2025 05:21:18 +0100
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

Since commit a2bd99549c61 ("clk: renesas: Tear clock controller down
last before booting OS") enabling the module gated by bit 8 in MSTP4
prevents Linux from booting. Furthermore bits 8 and 7 of MSTP4 where
only documented in early versions of the datasheet and have since been
removed, do the same in the driver to allow Linux to boot.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/clk/renesas/r8a77995-cpg-mssr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r8a77995-cpg-mssr.c b/drivers/clk/renesas/r8a77995-cpg-mssr.c
index f49faa47cb37..0a59a19cb227 100644
--- a/drivers/clk/renesas/r8a77995-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77995-cpg-mssr.c
@@ -220,7 +220,7 @@ static const struct mstp_stop_table r8a77995_mstp_table[] = {
 	{ 0x03e01000, 0x0, 0x03e01000, 0 },
 	{ 0x000e2fdc, 0x2000, 0x000e2fd8, 0 },
 	{ 0xc00014df, 0x400, 0xc00014df, 0 },
-	{ 0x80000004, 0x180, 0x80000004, 0 },
+	{ 0x80000004, 0x0, 0x80000004, 0 },
 	{ 0x40d20004, 0x0, 0x40d20004, 0 },
 	{ 0x08c0008c, 0x0, 0x08c0008c, 0 },
 	{ 0x09941c18, 0x0, 0x09941c18, 0 },
-- 
2.52.0

