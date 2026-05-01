Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91C9FF886F
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 01:37:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B8658460B;
	Fri,  1 May 2026 03:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="oY48vxwT";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="GoyppwzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FC1684605; Fri,  1 May 2026 03:36:32 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B07408460D
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 03:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E34CF14000B2;
 Thu, 30 Apr 2026 21:36:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Thu, 30 Apr 2026 21:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1777599387; x=1777685787; bh=3yWT3mHdIw3gKTRNun7SAR9PbuAM8wiZ
 9L5Ac6p160c=; b=oY48vxwTSqr0xh0uPsPBRD7WalCkjAPnLAwIptUjNjc3tq0R
 G9KrSm4v91BYDlwuUTdm36IeR80cdOkHdESlxMbtCzFS282xTne0s3Qmzjqn/oU/
 ar7/v8YlQic0gVG7kMrhxmZ3tAwmsiEND5nrv3Yf6dscx2kVoh1MIHojlWHI3vHY
 s5o6ChiSjLR7m3qJIecsSzuXbhv6R3DWI44543m8sys2tVs1PBU0Qx8E5EtP+mGZ
 MsGWAtW0mJtOtmF3mTfSW8+OAgLiMuLCWymPi3UP42/VZjbfVNrL5YbzXtKbKx8G
 SLt9PCAFkzkJOddQRgoNtJVm93u4UngXshBy7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777599387; x=
 1777685787; bh=3yWT3mHdIw3gKTRNun7SAR9PbuAM8wiZ9L5Ac6p160c=; b=G
 oyppwzNMqRlPkJXGzRGjMhy3pK4c2seQngPaUKH22ZdhMkLFkfpdM75Pl7E6s8Rz
 CWvSSwkpx4Lrt4e4SUZi3IxCSqjL/HmLmzj13C0qo5OjH1eVb9rEu9Ein7dj/fQ7
 LEsmtxpVrOXD/cLOmjM67e+MrGy9NgisFGAczWnlNOqHbd0B0Nm7UWZU/IYeizEM
 mZlm0xNxzcJO8wMSfCUgpmBiV2jvqQYv3vx9b4Lp543r1UoTNjFx1bv5Z8hDJdrh
 Nk+gLpKhi2aghsCtP0esoC9PAyaza4Y3IWx6HB2cqC+keUTQRfxKgDqy1YhB7WcW
 A9QnrvFAsyIl+KktMZX1A==
X-ME-Sender: <xms:mwP0af01-mnLr43rXitA3J6mlQZS_qoCChx-oi_W_T3-mf6o98Msdw>
 <xme:mwP0aRJMu0dVPIq_C4yjJEzSwjjwVhhfMOCtRD2w8iaU0JUpqW51j2ZvKrSwTIVIV
 skS27i-ENSxnnMmDLorPdJDslU2OrgeW5p5Jm_eCuJuvPLGy2SpBF8>
X-ME-Received: <xmr:mwP0aahnzelGsQFMLcoqY0dkC1TXZb0k1TnOyKAo2IifxViZtff50oQ5AjcgyADrp2wMsAB_aGPhYWwmxwCq8GBmZo8jrarninwNPjBp33N_W-oPA0NmSjGJ>
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
X-ME-Proxy: <xmx:mwP0aRCKeC-Pjw2hM8FyADBrz-CGTnw4VaPtjAqmWFwu0vqwQOUX5w>
 <xmx:mwP0ac6R3TyQJ0Gagl1TarCRUh9hagCZgbdGsSoZ36Hh2v0jzHe6RA>
 <xmx:mwP0aWE5sMs9TY4_jd8gfLce7kgxhReX6WLFO50DJyRm8jSTD7cC4g>
 <xmx:mwP0aXBWfJqTXW9XZzxrvNm_eDDdwKQyByOuaurKtZKs0d1mcYWqxg>
 <xmx:mwP0aZymml14HvpYuDt-hvU4n3Em8AGTbWmOQk723rUtodpq1PRNvD_6>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 21:36:24 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Fri, 01 May 2026 11:36:06 +1000
Subject: [PATCH v3 5/8] configs: ten64: enable USB_ONBOARD_HUB (USB5744) option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-ten64-add-usb5744-v3-5-234c5b2f8c6f@traverse.com.au>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777599366; l=871;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=XjJozh0p6T1mnGH6xk2iVd3Ya8gbDn1eFzeeVbvB4/Y=;
 b=AH78CLz4mbt84JBvsFBpkDefoe4xZsZPw08Wrs3fZIIrir7GnrsP3wNYG/ICauPgFw+7Ma0Yc
 6HjUomiJFFeAc9A/u0LNdwx5RmFmor2WCY0imeHpR3SwyDWLg+ULzvp
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

Reviewed-by: Simon Glass <sjg@chromium.org>
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

