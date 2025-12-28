Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DA3D3B7E5
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 01:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F2C983D7D;
	Mon, 29 Dec 2025 02:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="DuF2lxQZ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="R4RhCDmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4939383B82; Sun, 28 Dec 2025 23:07:55 +0100 (CET)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D5F683B63
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 23:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niklas.soderlund@ragnatech.se
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 37FE17A0385;
 Sun, 28 Dec 2025 17:07:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sun, 28 Dec 2025 17:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1766959672;
 x=1767046072; bh=+YJzZdb6Bk3lGrpf5X+HLGQjwUK5IjO7uN6TSGqGGls=; b=
 DuF2lxQZA3wt5lWg0k9kVy5jIYpCs7jKnGkIXSm1lZS7l2Nk9x4NmVA4Ndxapfc2
 h3Dh1CDPdrh4ESZpDjcxr46XzzybIO0EguPmUU27FvAAEBS1PaBBU8ImLiwIpHfc
 OPuAF40qdtz4mTcIq8Ap9QWfMx6Mvm+rfi9sYZ8f8hprCh718yluda4mCZFTQy+I
 Xror1EMF+NpEH83zhDpSUPEHShF/R2+6cCObA5Dd+KN7k0C3NH+2HqeoRuEUo3OC
 KT2BzeMLus21K7qXqSdTVHgBdnGbLdr2crZKgKaL0ftprHvNiV8T6uezNQtEAw40
 AuqwsuM84wxYOf7p80y2iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1766959672; x=
 1767046072; bh=+YJzZdb6Bk3lGrpf5X+HLGQjwUK5IjO7uN6TSGqGGls=; b=R
 4RhCDmTr8mhOJx6YGQkKbyXfSBkCJFYC+UeQb1BthWG201c3JWIOq7gfDU6f2uVN
 0qjHjdYyvrEBe/gxCC6t384HCljIAf+VCaFp7sLO/0A9J3QgKrEBpQWfTYovyLAq
 R+JchSCn9s49EkhzxAmuFX8uPDHBYPmwBYDlF+MjR3Lnr4q5/YGZFHeXFFBkvrzn
 dG/k8jn5x0rVAUTLfUKSGaYE6HYCdbzWlvHUq6kU5kYC0LGawmGnmmRQ3f3vQZUZ
 QA8Jheemr7nMDXCY0xqqt+XnmLNNkn/I+MU+/H9v2oaJgNcc8+A0F0PGjWuVEK91
 Xln/RNvUNP2e5LqF2BPZA==
X-ME-Sender: <xms:N6pRaQ1GkL9AoOKbWqBIt9RaJsg4yiyQEBjOHai2jTNzIR0p5QJ8JA>
 <xme:N6pRaezCygACAMRP8ZrZW48j0IIoCNH6T-g0_who71M_MY0uBcnve1q2yAgTyv5ye
 lSCCB_VeRVvj_bp1x-fif3Y_wUhPI3Yhsb2E92D23tOQHz9-eYHic4>
X-ME-Received: <xmr:N6pRaSthyCPQ_kl1vVQO9Neoy0Xa0yubMFxHYF3lDxfWumdBt0dfZ10zUME3YSynYg7NKwbJvNlnLDzQlAYrNdL7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejheegvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:N6pRaQxxLwUl0EkNZz1OOKk2G9cUqN3hrmsEHaDz2bivJUJSIY097w>
 <xmx:N6pRaVC5SdoCZJMgv3k9Z80hAjo4B6ae7TFFeVMb_MFIzwuwSDYcPA>
 <xmx:N6pRaefl0fL7vqeFgjYS_2d-cvtX-D8NoEvuHEncDQoSFUve1hSl8w>
 <xmx:N6pRafnj6EhzdKkUPsWiAdhyY1hHXPytsJcHsPpHm6IiFzWEFTHJuQ>
 <xmx:OKpRaYa0-i5MIrw87BWmR_GRdF4gXavqowPvE3Ji3TnOJXcAXDEuZ9uG>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Dec 2025 17:07:51 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 1/2] clk: renesas: Do not enable MSTP4 extra modules on
 R8A77995 D3
Date: Sun, 28 Dec 2025 23:07:16 +0100
Message-ID: <20251228220717.3630713-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251228220717.3630713-1-niklas.soderlund+renesas@ragnatech.se>
References: <20251228220717.3630713-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Dec 2025 02:49:04 +0100
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
prevents Linux from booting. The bits 8 and 7 of MSTP4 where only
documented in early versions of the datasheet and have since been
removed.

To allow Linux to boot update the MSTP4 enable value to reflect the
hardware default, 0x80.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
* Changes since v1
- Keep the hardware default value instead of writing zero to the
  register.
---
 drivers/clk/renesas/r8a77995-cpg-mssr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r8a77995-cpg-mssr.c b/drivers/clk/renesas/r8a77995-cpg-mssr.c
index f49faa47cb37..309b0aec8e2a 100644
--- a/drivers/clk/renesas/r8a77995-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77995-cpg-mssr.c
@@ -220,7 +220,7 @@ static const struct mstp_stop_table r8a77995_mstp_table[] = {
 	{ 0x03e01000, 0x0, 0x03e01000, 0 },
 	{ 0x000e2fdc, 0x2000, 0x000e2fd8, 0 },
 	{ 0xc00014df, 0x400, 0xc00014df, 0 },
-	{ 0x80000004, 0x180, 0x80000004, 0 },
+	{ 0x80000004, 0x80, 0x80000004, 0 },
 	{ 0x40d20004, 0x0, 0x40d20004, 0 },
 	{ 0x08c0008c, 0x0, 0x08c0008c, 0 },
 	{ 0x09941c18, 0x0, 0x09941c18, 0 },
-- 
2.52.0

