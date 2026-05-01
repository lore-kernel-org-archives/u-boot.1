Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4DBFF886F
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 01:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CC5F84198;
	Fri,  1 May 2026 03:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="FZMnbQpb";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="OXaYgj3D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A684480086; Fri,  1 May 2026 03:36:23 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B04AD84198
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 03:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E4472140015A;
 Thu, 30 Apr 2026 21:36:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 30 Apr 2026 21:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1777599380; x=1777685780; bh=2ioZaJA3zv+ynopAwPUG14OpbOuQ2ggJ
 XOkxleEZvTg=; b=FZMnbQpb/SAkFvobl/lNcn1kIxFOGOmornjTa8tkwzq9c+1m
 UD17EgpByGkm7hZ9qkkhBL084vHtwXqa6ixwpN5ji+ltIBmW2NII9kxYX2kF0xkF
 GZyz9DS0fqVa9zIRl1xqbZtAnBqMS0IM3IJYW8xbEKrZAnqE/9RiVdZcyYH2usmK
 XumRY7P8hWu3H2upk4jr9UyTNZYtLNvH1p+wMM8ytQ4Ib2+jhyClbMYTS/N3rFKA
 0AbNMJlEeS7xLY0Ps6ARterOGMKByjy2iTYbyMG+2Y3P10w5vyUr8+zywAeVyZWP
 5cNb4/5jnfZpoj369hz6aOskEUdvw5Cva6Y/wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777599380; x=
 1777685780; bh=2ioZaJA3zv+ynopAwPUG14OpbOuQ2ggJXOkxleEZvTg=; b=O
 XaYgj3Dic3dgAqoQqy+h7L9UdwQWETMwcMrV6mh0aDB1cktH1CqYgwVfqkMsZ/Q/
 TpNqkwj+DSO6Eza5pfFbKkFOscyKzoBKe5xqUHr07oW7Zb1kg/adl9zlcVDSvpSy
 1DFfAIc7eBgdmRZi8nPyMHU3M1VQndv5UrjXKgY50KmLhgwudnv7tzpzh5FuDvKr
 A5oySWZGa/WwKwWti5o6fDQoeQYHGic3EztKnnn5fyEaOrLDn4fpCAVm8sLU21XB
 FNmWiOc52/H4YnOpoBI7al+g4N5G2Qk3SAywBXep+XM8pmcjxkDdwZazCu7zAc7H
 P63iHywcmV/ywehtXSIeA==
X-ME-Sender: <xms:lAP0abr7PFSNVt34HWEnjAmPwCo9UjIQrBZXOLWMe256VO1Gp_W4Fg>
 <xme:lAP0aYtLDTQSyIcorvAxN_5DBGDsrq-FVox6gX5GLta6eDcRyYI-6LXs96Ui2PcIg
 uHlIkD4nTDv8ITSdNVJNLGee7qV3-yQtsxtw5sSemHja2Z2AdiJnPk>
X-ME-Received: <xmr:lAP0aS3kyaV6IjP8x4pyXbXHlryWURvNlol4UpoVypI1QMbEY0f0fbnrAn9pqN4BqOmIEA9AfskIDV-Ny4VrPQBqwswoAdoOHWB5dFXQ_257q82jplLKgy2F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeeltdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhvgif
 ucfotgeurhhiuggvuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenucggtf
 frrghtthgvrhhnpeffvddthfeklefffffgjeekfeetueehhfeigfffgfekudeujeehffet
 ffeltefgheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohepuddt
 pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghtthesthhrrghvvghrshgvrd
 gtohhmrdgruhdprhgtphhtthhopehluhhkrghsiidrtgiivggthhhofihskhhisehthhgr
 uhhmrghtvggtrdgtohhmpdhrtghpthhtohepshhjghestghhrhhomhhiuhhmrdhorhhgpd
 hrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohep
 mhhitghhrghlrdhsihhmvghksegrmhgurdgtohhmpdhrtghpthhtohepmhgrrhgvkhdrvh
 grshhuthesmhgrihhlsghogidrohhrghdprhgtphhtthhopehprggumhgrrhgrohdrsggv
 ghgrrhhisegrmhgurdgtohhmpdhrtghpthhtohepphgvnhhgrdhfrghnsehngihprdgtoh
 hmpdhrtghpthhtohepqhhuvghnthhinhdrshgthhhulhiisegthhgvrhhrhidruggv
X-ME-Proxy: <xmx:lAP0abEMdTIRqOQD9dADgDwunhgyAn6_hXD6i5VRCWMrfQ0_hicBtw>
 <xmx:lAP0aVvWKWqC40Loc2HLNjMl-KDHe5E3UtAPaUPdRRhrSl73YVIYbg>
 <xmx:lAP0aWoXvBJ9wUvnQI2JqNeav-cOrb_L0idSB9W_Bc7orZEkdt1umw>
 <xmx:lAP0aUX2UQK689_a_5Bf0UElJvd1a86k1m46CVRYcUXIJhkIrh8nCA>
 <xmx:lAP0aR80Bgfn6yF8d5QU8qIfxKqAJ5YZehstV-edBnyDetAEC1EThDgQ>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 21:36:17 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Fri, 01 May 2026 11:36:04 +1000
Subject: [PATCH v3 3/8] board: ten64: remove USB hub references from
 internal FDT when needed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-ten64-add-usb5744-v3-3-234c5b2f8c6f@traverse.com.au>
References: <20260501-ten64-add-usb5744-v3-0-234c5b2f8c6f@traverse.com.au>
In-Reply-To: <20260501-ten64-add-usb5744-v3-0-234c5b2f8c6f@traverse.com.au>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777599366; l=1179;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=UI5LjfW9RB8m1S2IykrmSox57NMnD4vjVJA2afJ9AK8=;
 b=DvsY0SmL/SCGOFCLKfkNd0sTIOJT6Ut6ik8dI6mbD740Rq0pa/PRbKP9FtkM9B8aCy6gmvp1k
 GK/OkPWo862C/seDc1tZ0mPnVEACvfHIpGyTiB57EmSJXMyd+kTML6B
X-Developer-Key: i=matt@traverse.com.au; a=ed25519;
 pk=SM+aGm9Y2fPJ2prfH/b5lab73fTBrKL5UsJwdzv7Pbg=
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

More recent revisions of the Ten64 board do not have a USB Hub
(USB5744). The references to the USB5744 need to be removed in U-Boot's
internal FDT to avoid the USB5744 setup being invoked on these boards.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 board/traverse/ten64/ten64.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/board/traverse/ten64/ten64.c b/board/traverse/ten64/ten64.c
index c5fbf4b4a04..5941ed11a60 100644
--- a/board/traverse/ten64/ten64.c
+++ b/board/traverse/ten64/ten64.c
@@ -311,6 +311,19 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	return 0;
 }
 
+/* board_fix_fdt: fixup function for internal (U-Boot) FDT */
+int board_fix_fdt(void *fdt)
+{
+	u32 board_rev = ten64_get_board_rev();
+
+	/* Delete USB Hub references in U-Boot's FDT on
+	 * boards without one.
+	 */
+	if (board_rev == TEN64_BOARD_REV_D)
+		fdt_fixup_usb_hub(fdt);
+	return 0;
+}
+
 #define MACADDRBITS(a, b) (u8)(((a) >> (b)) & 0xFF)
 
 /** Probe and return a udevice for the Ten64 board microcontroller.

-- 
2.52.0

