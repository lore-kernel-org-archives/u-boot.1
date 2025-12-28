Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF897D3B7E5
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 04:21:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2455383A26;
	Sun, 28 Dec 2025 05:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="ATabZsc9";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="kkfFLtaG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B38A839DD; Sun, 28 Dec 2025 02:04:58 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DAE183956
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 02:04:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niklas.soderlund@ragnatech.se
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 63A0914000C1;
 Sat, 27 Dec 2025 20:04:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Sat, 27 Dec 2025 20:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1766883895;
 x=1766970295; bh=r9zwZMklGOUkxaDZMoUxxMJ4rBigkg7WcmnU7TogFbw=; b=
 ATabZsc9V1Si1iaYXF9VI8ZxCpUFTBR3jvwQUZEE9ffJIssYn2s9q5woQdLannhz
 EaC+hOrZQQlBfu3hysVt+GSdzovBuWp1ettHOQKbWjRzjALnPY8Z409M9aEmPMRu
 N8OW5KXt+JTAOj5uTEVgOaAkDI42GiaoNeOcxRCM1/leVZwr7QDWqFZ/u3wtevcL
 8eT2tzd8pFVJOCQQ4oxYAprB+z928qvJPatUqJdQ+ZfJ4YJdVkbSwOk2Hj45dBtg
 EV6CYQnXiUFAem7MylG1AFrMPhiOTSLFbJIn3bFgavXgzwENYHVgSyZn/VwB40qX
 DtIT+8pDt1rQjllTZsdtNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766883895; x=
 1766970295; bh=r9zwZMklGOUkxaDZMoUxxMJ4rBigkg7WcmnU7TogFbw=; b=k
 kfFLtaGIPdbyqQuousyAJqGnq98c4xPodf7YmlyGzsx23mW88PO4xmwD/CTpf/Aw
 kbg6NC7tRWSmHZtSZs0uFBBXvNY6SmnXJ+JcUhplRweKiFBltCwfzMueIRD+WMwC
 pu4G/oOYgkKu0TF3+S0AlkViD3zl3RmtGLANA06LkKsm4GUaCLhuTdsd1gf3IsGW
 IswubK2m/OhfPpR1MztNoHVeZWAf2LPzXunw9IXrR6/MC0UpJq5BlYmYsMz/2yQl
 HHYwwX4uuLIssNnociSKviHGjxWGoOMCEz+wx7qOIJ0aiawuZpOv/tXeGopohNLs
 gkxQkSNku3dO6bsWNifOQ==
X-ME-Sender: <xms:N4JQaV0qf-bAtwQU_r5Lhm7Kk0r-Uh0DrP7Mm5jV9twqSem32DYhVw>
 <xme:N4JQafzYYQ-PZb2hOC0S-SxeBNWHN2V85gp2KyLb0B3vCZXkmY7y8uY6WxQDaAObh
 -iWMUZDFa0FvPTeLSogcn60MDne3Nneq7aByF9R1R-_WfFR51p8SddZ>
X-ME-Received: <xmr:N4JQafslr06USlfN1MfSU8PpT2CZ_RG9bzsz7xd5OndBR26CAv_wkyBwIZpLZLfthmD40kt9An0ykpit1UXqKsSe>
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
X-ME-Proxy: <xmx:N4JQaZwdBG4Aouo09ydqB74pFmNskkgPMeR6rm7-Xmu-d-GnQeS13A>
 <xmx:N4JQaaCSoISz312qXhORAgXLcwF4Xbl_keMo49yQPJnJfxNzUrq-xg>
 <xmx:N4JQafdMyjYM2Hp7B_srpIRrOFM4rTJ97aO2XoM_ihmOa2Crf5wTBw>
 <xmx:N4JQacklBUk5NUsQn_A7LlBF9yiZjN9bpyyHEbCDhZTSnHHg4SqkLw>
 <xmx:N4JQaSB_JIjMX9BbbkM5SGWmG7AKlPsrZWEiITJaPblk1K11LP2x__DA>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Dec 2025 20:04:54 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 2/2] clk: renesas: Do not disable realtime modules on R8A77995
 D3
Date: Sun, 28 Dec 2025 02:03:27 +0100
Message-ID: <20251228010327.2836161-3-niklas.soderlund+renesas@ragnatech.se>
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

Later versions of the datasheet makes it clear D3 do not have any
realtime module stop control registers (RMSTPCRx). Remove the
manipulation of them from the module clock table to match this.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/clk/renesas/r8a77995-cpg-mssr.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/renesas/r8a77995-cpg-mssr.c b/drivers/clk/renesas/r8a77995-cpg-mssr.c
index 0a59a19cb227..736812e04d0b 100644
--- a/drivers/clk/renesas/r8a77995-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77995-cpg-mssr.c
@@ -216,18 +216,18 @@ static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[2] __initconst = {
 };
 
 static const struct mstp_stop_table r8a77995_mstp_table[] = {
-	{ 0x00210000, 0x0, 0x00210000, 0 },
-	{ 0x03e01000, 0x0, 0x03e01000, 0 },
-	{ 0x000e2fdc, 0x2000, 0x000e2fd8, 0 },
-	{ 0xc00014df, 0x400, 0xc00014df, 0 },
-	{ 0x80000004, 0x0, 0x80000004, 0 },
-	{ 0x40d20004, 0x0, 0x40d20004, 0 },
-	{ 0x08c0008c, 0x0, 0x08c0008c, 0 },
-	{ 0x09941c18, 0x0, 0x09941c18, 0 },
-	{ 0x00801087, 0x0, 0x00801087, 0 },
-	{ 0xf143dfc0, 0x0, 0xf143dfc0, 0 },
-	{ 0x063e1820, 0x0, 0x063e1820, 0 },
-	{ 0x00000000, 0x0, 0x00000000, 0 },
+	{ 0x00210000, 0x0, 0, 0 },
+	{ 0x03e01000, 0x0, 0, 0 },
+	{ 0x000e2fdc, 0x2000, 0, 0 },
+	{ 0xc00014df, 0x400, 0, 0 },
+	{ 0x80000004, 0x0, 0, 0 },
+	{ 0x40d20004, 0x0, 0, 0 },
+	{ 0x08c0008c, 0x0, 0, 0 },
+	{ 0x09941c18, 0x0, 0, 0 },
+	{ 0x00801087, 0x0, 0, 0 },
+	{ 0xf143dfc0, 0x0, 0, 0 },
+	{ 0x063e1820, 0x0, 0, 0 },
+	{ 0x00000000, 0x0, 0, 0 },
 };
 
 static const void *r8a77995_get_pll_config(const u32 cpg_mode)
-- 
2.52.0

