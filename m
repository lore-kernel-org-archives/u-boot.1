Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74563F5A8CA
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 00:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4D8B84310;
	Tue, 21 Apr 2026 02:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="oV1LpVxv";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="nwYsVcQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4076E84314; Tue, 21 Apr 2026 02:05:11 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BCBF84310
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 02:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 2CFC71D0014E;
 Mon, 20 Apr 2026 20:05:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 20 Apr 2026 20:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1776729906; x=1776816306; bh=vtHuGpJOj3tsAurUfI44FY0LbdoEytxZ
 I2l2FH2VNqw=; b=oV1LpVxvoEuvmmWLg+j+a5B2p+TWx8I2l6maMJlTQ17zItSN
 w99JsOaITOrt0s92wdU/fwV4ll+RM/TMY0ckCCiZRUq3HsVcIICAgv2C0OzdKoIf
 h9AjSPJKlGXKeRVRrMvXg3yvJhZVqztRe26fzvTtghFzBw2IIRkKQL1qZzO5+R7J
 5/BBh8OsGhgjm7SFzbs6ilAVFhTZfymz1z3C0Et3Gsq3Grgeg0p9Iuxoyd1emVU1
 qLc0PUumY+Yi710H4xn8fl9a9KqrfgDof8U4bOfeao/xgNoCxwCwU2kLaYISlM4Q
 jxVS3wO9pOfGLT+ipEjxElUMA4XkWlaWkSIqoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776729906; x=
 1776816306; bh=vtHuGpJOj3tsAurUfI44FY0LbdoEytxZI2l2FH2VNqw=; b=n
 wYsVcQauJ7dKm1+0bYhCPIEVAT7NZGQzI+exZvOBft/FL1qBG3JoXb0wWyuxn7Xg
 cpgoGMHtbwSmsBwEDjSV2dGtBw3mXhgbqXLb/9KEOA/cLhhtfr2F1ZjYePVCTRX9
 +gealCZKHzEvZrYsYlO4IZrUV56/U/NoHirJ/C293goJtzagT0xmh8BpdDtTD5XT
 bysL912NeBKPO4v2naGewBNoBilrwu+c+FfafuA7YumubykLGdz3SU7RnLrdXuAf
 m8T9n+CBJ88YIJvYwBX/iAavl7nzdW6w8BSC4xEvQGkNVPFPZRBOvJqnwNk9yous
 KDe8kMBJY04ZAciygVveg==
X-ME-Sender: <xms:Mb_maUsWWdL3Q7UAMt3xczV6E9P6D7Qe70HT5jGjf7J5G27p0_n_GQ>
 <xme:Mb_maWaVpj4xn0seZr1OuqxXsiPzeIeBSJQOkiLxEKwzeHFMaR_LhQbh0IsPmqXiq
 uFpx_hPxRU3KdEcTpXX1JL-JGEA-RBwN2KkXpC20IRlEMd_T8JQtBck>
X-ME-Received: <xmr:Mb_maUBwrwZxDydzKKXSXj4kv4OEJMgPD_rirJV1hv6yY56Bjy_spa7gOk7DS5wFiG6L7NaD0jXhOB007gqznFjJYmqRh5aQ4V_RqnEUGS5wvIgDgQ1ZqQDm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehleeludcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhvgif
 ucfotgeurhhiuggvuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenucggtf
 frrghtthgvrhhnpeffvddthfeklefffffgjeekfeetueehhfeigfffgfekudeujeehffet
 ffeltefgheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohepledp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrughmrghrrghordgsvghgrghrih
 esrghmugdrtghomhdprhgtphhtthhopehquhgvnhhtihhnrdhstghhuhhliiestghhvghr
 rhihrdguvgdprhgtphhtthhopehmihgthhgrlhdrshhimhgvkhesrghmugdrtghomhdprh
 gtphhtthhopehmrghrvghkrdhvrghsuhhtsehmrghilhgsohigrdhorhhgpdhrtghpthht
 ohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepphgvnhhgrd
 hfrghnsehngihprdgtohhmpdhrtghpthhtoheplhhukhgrshiirdgtiigvtghhohifshhk
 ihesthhhrghumhgrthgvtgdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulh
 hkohdrtghomhdprhgtphhtthhopehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruh
X-ME-Proxy: <xmx:Mb_maW8BLoT7LJyGYhVdfIEOsYsMWCVC0w1xiCXsvmsWFoXgj0ROkA>
 <xmx:Mb_maYRSO_pYyn8EsFJ7f4Fo0P2kgm2EwbPxk3MR0xX5acUVN5YDsA>
 <xmx:Mb_maSWh4NjqLQXlH36e27M8pCfejBmsAf1APs54R9wDMm564fyXuA>
 <xmx:Mb_maaQTLkAm2pTuuR3BMmOM6jQBW6fYg8RpgansZnz52WVe2bJpRQ>
 <xmx:Mr_maVBKC1JvZtSHBRtZpP1mB4YJ--1ZfteIRny5T1T7sLTyG1LOnJmF>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 20:05:00 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Tue, 21 Apr 2026 10:04:38 +1000
Subject: [PATCH v2 5/8] configs: ten64: enable USB_ONBOARD_HUB (USB5744) option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-ten64-add-usb5744-v2-5-eaa81288e393@traverse.com.au>
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
In-Reply-To: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776729881; l=826;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=dIT6L6JQzZSF2t/qwO/bOo4SxjiyPaot5tlFhXNL/Ow=;
 b=5A5KjU5fOfPBhfla8r2ZxYzr8mfbsShBY7jT6c5mOFVDT/61BA/SD5hh370ZxFR+i73BDnogy
 ZFJClz2+tAwAbAYYzlKY9nhoEVPA07+ou4eBD2U7yznzvdlNseDIwOZ
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

Ten64 board revs A through C have a Microchip USB5744
hub on the board, which must be configured over I2C
at boot time to become usable.

This function has not been part of the mainline
U-Boot for this board until now, as a mainline driver
and device-tree binding is now available for the USB5744.

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 configs/ten64_tfa_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/ten64_tfa_defconfig b/configs/ten64_tfa_defconfig
index 0254aa6b4a5..65363d013a0 100644
--- a/configs/ten64_tfa_defconfig
+++ b/configs/ten64_tfa_defconfig
@@ -90,6 +90,7 @@ CONFIG_FSL_DSPI=y
 CONFIG_FSL_QSPI=y
 CONFIG_TPM_ATMEL_TWI=y
 CONFIG_USB=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y

-- 
2.52.0

