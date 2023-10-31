Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7FDC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF22C87AC7;
	Tue, 31 Oct 2023 06:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="Bw+AhuBt";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="LBXDosB0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12AAA87AC6; Tue, 31 Oct 2023 06:06:19 +0100 (CET)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06F3B8709A
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 376913200684;
 Tue, 31 Oct 2023 01:06:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 31 Oct 2023 01:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1698728772; x=1698815172; bh=69PCn/Bjyk
 z0n7Sfa61m1huBTgmuO3Bhxgc3YiDgHtE=; b=Bw+AhuBt5qnAxg52r/7ZSvb10H
 CwzB7r4jGV+Pp9XZigUcS2CHec6+7eNt6K0agEa7/dPxHIpvxJSLeohvaYrJIA5W
 12sZDTR05BsPlNtdcRq3ItQ/ObJ+ILJM25WZJIDsVkYaoIYWXIVsrwA0olPh0Nzs
 3zyGMqxp+wMxD0Ew7+sjMKcAG/MxGb6qtFXSyT7gG6V4xDusAPCgipzL6UIOtrkE
 sdVIQgFe74e0Qz2HpBCcZ2fKo2qTp5/cCq7qsuiGxmWCCu1TBZG1Ls+t34pUyml+
 E/e07aAIm2qutYwfcwIr1XtorKbSDfrVFoQ/I7RB0OMuRc7ArF4+u/r76zFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1698728772; x=1698815172; bh=69PCn/Bjykz0n
 7Sfa61m1huBTgmuO3Bhxgc3YiDgHtE=; b=LBXDosB0H1z5Bi/izdoSNbt9LGhkO
 ZE3HL3vpIn6ieovAc+Lzjx6h/HaYGLRllMjiFnoNXEWA/q2Jb3PI/SktuR+a2Yvb
 bvCOUpX/6HxsBZ0fgmA73LF0l4NqI4k9j/+GpzZm1hHlMCk6XUqZ8URL+v8f9XQW
 2r0VXUAtML7fxGjzDfJDVSNKqRDVsAwslrSvuZw1Pya+Am4cn774bxYBOXnBwglf
 VfhZK/1XcwL5lbmikMcMDxgsF5qan+nCJyDhXWUjarrW15wdNgZ6I4ve5KttAnJX
 072hEZ/PaeCze+Swv3T9NZZ7vmWorqFtVN2nLiZ+X9CFqDwsdwDGPdzkw==
X-ME-Sender: <xms:RItAZYeBSZR_NkhXwLumMxt4sROk2m60NSHa15EjFH6JtCB1oeE2IQ>
 <xme:RItAZaOMFfBgAJkKYdqUuAZ6qAaVEKBrQ6XMh0mrJXupTBr-etexABruARgpzyvWc
 aLDNucyprbCPlHxzg>
X-ME-Received: <xmr:RItAZZirK42MSa2w75vHC9oZtVy9U9p8ZpI8aaZjK_bamvgrj0Fqe_S6O0Kxq6lS7LKEfnoTjgYuQNkanqD04gJlSgEujpIKO3Fwp1eBvq9mLeF4miRREj25Z2uKeCaRXSMZqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgjeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
 hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:RItAZd8LxpxEntC7fdLTgf9wqQOP24lbfVJ3sgjT0uoX8n_aKcOWMg>
 <xmx:RItAZUss1T52k5xn7yx_h-SemABTl8_bSjapKKvIM2tpvOBT4zVQLQ>
 <xmx:RItAZUHamaabKvEwsipxLMneBSIO2XKlT3-R0VwsYZxTi0LxO3WVsQ>
 <xmx:RItAZQLncNi2C3YTtzSaEz8anS1fF98mnSJMToTnKLU99RsStt1UDw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 01:06:12 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Tom Rini <trini@konsulko.com>
Cc: Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Samuel Holland <samuel@sholland.org>
Subject: [RESEND PATCH v3] serial: ns16550: Enable clocks during probe
Date: Tue, 31 Oct 2023 00:06:09 -0500
Message-ID: <20231031050611.55422-1-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If the UART bus or baud clock has a gate, it must be enabled before the
UART can be used.

Reviewed-by: Stefan Roese <sr@denx.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Switch back to the original patch, now that the phycore-rk3288 build
   is fixed by enabling LTO.

Changes in v2:
 - Only enable the first clock, as using the clk_get_bulk() API pushes
   a board (phycore-rk3288) over its SPL size limit.

 drivers/serial/ns16550.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 6deb1d8ddc5..a206d00919c 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -514,6 +514,7 @@ int ns16550_serial_probe(struct udevice *dev)
 	struct ns16550_plat *plat = dev_get_plat(dev);
 	struct ns16550 *const com_port = dev_get_priv(dev);
 	struct reset_ctl_bulk reset_bulk;
+	struct clk_bulk clk_bulk;
 	fdt_addr_t addr;
 	fdt_addr_t size;
 	int ret;
@@ -533,6 +534,10 @@ int ns16550_serial_probe(struct udevice *dev)
 	if (!ret)
 		reset_deassert_bulk(&reset_bulk);
 
+	ret = clk_get_bulk(dev, &clk_bulk);
+	if (!ret)
+		clk_enable_bulk(&clk_bulk);
+
 	com_port->plat = dev_get_plat(dev);
 	ns16550_init(com_port, -1);
 
-- 
2.41.0

