Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28075C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 04:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA2F87535;
	Tue, 31 Oct 2023 05:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="JOyliYpQ";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="DpOVB7EG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCD3B87537; Tue, 31 Oct 2023 05:57:48 +0100 (CET)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C71528751F
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 05:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 140463200976;
 Tue, 31 Oct 2023 00:57:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Tue, 31 Oct 2023 00:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1698728264; x=1698814664; bh=9uTvfhsjIp
 b/+Et5Ei+uuVF4sEwycnBABwvXkOVxmBU=; b=JOyliYpQ2x0WsTb4WXidge+Tpe
 +V1cg4sOO0vRnDNUVdcVfNcpFahZ1dO/jraWQLJK+f0lEsQ0puUrjAZ0AFeIrEcz
 TofAi22FbrM5ptSaxccrbQxnbvgk3l7SK2aIFIoy0VNfxr/jXcNBIR8xGnqhc6Yj
 UnlKLbYHhuQqgdztjgQ1RU8kB96yzCuaNTpVSa0O8BN4jf0iqImWmBE4G0E+MtGW
 2i5dQBL5CkLPT29N6zzP7SIijB/EMvxKWtoJpGFoE/ecBW3GSBxmklc3FbX7/qIC
 9JorGw/zLZhZ3Ss9iEY21lRFBmSAeLfowTogV4O3rJEdofu1CXestdyTaA1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1698728264; x=1698814664; bh=9uTvfhsjIpb/+
 Et5Ei+uuVF4sEwycnBABwvXkOVxmBU=; b=DpOVB7EGfL9s2N/adJyil06N9Qziy
 cPKfGIsxal0I11hv1kwwiac5BZVuuvd8/NG3qhAyr00o34faIn8rvrAoULsdxxUO
 pwWqV6K9+SEiVzaGrA///qpvfhNYlFE4rgJ4IlGRXmqWjV8Nt691Cr6u6vAaKFO1
 rlnYVK/0jVpVQ0mlU4SoWrFXQrbEBTTEGhNYdLYqM6kkO2X280eeTbnT0jQRcIaf
 pQPvdXgA+PsermttcFcvClQZMIqWiiK9SOMrCOmCGa15MOD5imtXaBjuLXYTEhLC
 c4vA73NplIl5hxG153BsoxiIk09iJaEtyeWf9tFg5e6khug9FDV6KHxYA==
X-ME-Sender: <xms:SIlAZaqFUOHq7cC09Js9NYTHGOVS8zk-GiywKOeuDkzw8WNrKxcR5Q>
 <xme:SIlAZYrBDTTbA4ZDQvwKaPP5f2J3fyEaA92ekSHl5lr19NhkEGI2RniJmfHZO5WGl
 ZJShr2r5WGcQS4Liw>
X-ME-Received: <xmr:SIlAZfO7VZSvOJbfkE_bSH4ue3P1psfn1E8c9ILAHliOwTRNzbVG-wqd2cLe9enOr5fJRbR9AFZe_ztQWG-D462RrfMY9ZzhyU1pdxNbegsNy9X114eQ5LC5yKB1246csV-sqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgjeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
 hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:SIlAZZ7ERHKE3O7y0yCiUTsMVS0FCAdHr4mslLFWSYIA28QumzDQ8w>
 <xmx:SIlAZZ5v2fE4lTNEAkLk0Woo43DPxzXBKWZwlMTcNEdKT7KpCpfx_Q>
 <xmx:SIlAZZgWa77YsVpDBKufMk_KRy3P4j7NcMHa7LZ5fNT_SuK6mfCwJg>
 <xmx:SIlAZZGS-zm-NTM5CJPndw3P_QnhQu2IQhcl0sgRgYvpBbDqd_rpmw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 00:57:44 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Samuel Holland <samuel@sholland.org>
Subject: [PATCH] pinctrl: sunxi: Avoid using .bss for SPL
Date: Mon, 30 Oct 2023 23:57:40 -0500
Message-ID: <20231031045743.53647-1-samuel@sholland.org>
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

sunxi platforms put .bss in DRAM, so .bss is not available in SPL before
DRAM controller initialization. Therefore, this buffer must be placed in
the .data section.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index bdf6360f176..37ea93715d1 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -50,7 +50,7 @@ static const char *sunxi_pinctrl_get_pin_name(struct udevice *dev,
 					      uint pin_selector)
 {
 	const struct sunxi_pinctrl_desc *desc = dev_get_priv(dev);
-	static char pin_name[sizeof("PN31")];
+	static char pin_name[sizeof("PN31")] __section(".data");
 
 	snprintf(pin_name, sizeof(pin_name), "P%c%d",
 		 pin_selector / SUNXI_GPIOS_PER_BANK + desc->first_bank + 'A',
-- 
2.41.0

