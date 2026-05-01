Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C502ECD13DE
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 01:37:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1594D8464D;
	Fri,  1 May 2026 03:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="Kb0ml6e4";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="hlcRIgKf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEC8B84656; Fri,  1 May 2026 03:36:40 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9CB8465A
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 03:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 2AEFDEC00DE;
 Thu, 30 Apr 2026 21:36:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 30 Apr 2026 21:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1777599398; x=1777685798; bh=fJEJTV1VESJpu4pWYR55pfygE5d5TX+v
 cLpNffrTK/Q=; b=Kb0ml6e4uF43qF3JldN4yeckpvCxO90RkDpp+rSSMzkRyFJR
 BJdVosTYHYuhjjizJRKDqMAVCPml6+4szo+he1cPBIhkbv75gkus2xEDBhu9zC51
 fTybDu3x8VGVlwmb9IsaadnodY4zMDKgjh3/niWk7DaJEB/O2ssOkd3z4YPpcBIp
 nLeXrDM8FrU65v2MgTUxvR/VFo29uR0HFJz/HJfug8lpy/Qg6uJIlcOh5JKr6bUu
 GzUvbv3o9IOlOOOtbgi0omvUs5kBeFNIkbpnVjshCOxYyqmL8STIz94pLbZftVZo
 eVE1LEYcvYkoGPt15zqIOCtqzBjFdJ8E39yunQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777599398; x=
 1777685798; bh=fJEJTV1VESJpu4pWYR55pfygE5d5TX+vcLpNffrTK/Q=; b=h
 lcRIgKfByDjuFZn8KqXc3K8mHcCY26Ql74Gt2O4RrF9RpUkPwUyneIWkhvdbpEIL
 z1mED0mBao6vzi7zfMqltJfc5bh0MooLbPa3Hu2+T0Z2JT1F1tk+zC0qidfiMS72
 1a2vywRL/8ayQI2+62WfPhLFeLpDxMpNsv5Vhhgu7/M8BK6pYm5ljXpFdzbT3HY9
 jYOj8zbgrtBNzE5U2BsKi2Ch/Sh1MEFmzlsUnHje6nkXjHoxJ3eUE8eWp8zY6XTb
 eP6NVNbWLXtX8jqL8Py5ogYXhQkfQddmvxgZOH/SlxbmpSyohSplbSIPZFEZx1Gm
 hBtOnIcdw83U676xAihBw==
X-ME-Sender: <xms:pgP0aSCsa2ZkxURdLZbouxy1zNUb_TqO0vxsdfGcmll33btEmi5ODQ>
 <xme:pgP0afkKcvad8JzE_Ir4kBzuBUWVnHtRCFb_qCzmjwdUUdunRA3Sn-6JgRgIYTfBV
 61CO6iwJBv3JdqBLW7OFhwjGCvR4_L7yC44q5xIhxdVdqJXkHL3-5cd>
X-ME-Received: <xmr:pgP0aQM6FMzKR5_2rXRO5XVNf2hw_dy4Ix7h0M0qXAibHK8XsG4LMEmyrRZsfKGkr4ZFiE9oIObhBrVPrwmXOt4UZW413zZUzHxQnHlA54NE5O3BQmr7QsTe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeeltdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhvgif
 ucfotgeurhhiuggvuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenucggtf
 frrghtthgvrhhnpeffvddthfeklefffffgjeekfeetueehhfeigfffgfekudeujeehffet
 ffeltefgheenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohepuddt
 pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghtthesthhrrghvvghrshgvrd
 gtohhmrdgruhdprhgtphhtthhopehluhhkrghsiidrtgiivggthhhofihskhhisehthhgr
 uhhmrghtvggtrdgtohhmpdhrtghpthhtohepshhjghestghhrhhomhhiuhhmrdhorhhgpd
 hrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohep
 mhhitghhrghlrdhsihhmvghksegrmhgurdgtohhmpdhrtghpthhtohepmhgrrhgvkhdrvh
 grshhuthesmhgrihhlsghogidrohhrghdprhgtphhtthhopehprggumhgrrhgrohdrsggv
 ghgrrhhisegrmhgurdgtohhmpdhrtghpthhtohepphgvnhhgrdhfrghnsehngihprdgtoh
 hmpdhrtghpthhtohepqhhuvghnthhinhdrshgthhhulhiisegthhgvrhhrhidruggv
X-ME-Proxy: <xmx:pgP0ac_cgf7RCYJYq4TmllBnLSZIAzekpyxfYpeCBjQvCZgDbfXLaA>
 <xmx:pgP0aSFnQa6h6OK-Q-rjtz55tYxWJmQXBZ1F4m5MRKRl0ScOlQ9e3A>
 <xmx:pgP0abifXmfH5qxT8OZSd3I224siflFGAM8tBpRSVjLZP2HURIix4w>
 <xmx:pgP0aXsT5F3010vfNu1LxHpWECLI0atjthuRDM4v2gOB2kbkFky_Jg>
 <xmx:pgP0acfQROgpD42IDj9XnC0PIVox78jajKP1hSleI7ZsGgKVmZCnaFeq>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 21:36:35 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Fri, 01 May 2026 11:36:09 +1000
Subject: [PATCH v3 8/8] configs: ten64: add USB start to preboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-ten64-add-usb5744-v3-8-234c5b2f8c6f@traverse.com.au>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777599366; l=851;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=TW8BQ06+/ch9UTnBYlGXF6bWnVpV0hsLV+JyBgSCJFc=;
 b=HcFlJkCHHJXzYhj+tptXxNgp4hgf3bt3MmjJxO0CO5oPMjnSiz4MzN8PpCuSFSyzbT8lGETJE
 AUqFdS0htpRAWdpWk92xRrVSJpm4eT9bA/lAB6gXp5e+wPgnA6aU5rd
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

There are two reasons why the USB stack needs to be
started before handing to bootflow or other boot
sequences:

1. When a USB hub is present on the board, we need to
do the required sequences to make it usable

2. To make USB storage devices 'visible' to bootflow
without further intervention

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 configs/ten64_tfa_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/ten64_tfa_defconfig b/configs/ten64_tfa_defconfig
index 26d41b3f366..7c1aaabfa4e 100644
--- a/configs/ten64_tfa_defconfig
+++ b/configs/ten64_tfa_defconfig
@@ -90,6 +90,8 @@ CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
 CONFIG_FSL_QSPI=y
 CONFIG_TPM_ATMEL_TWI=y
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="usb start"
 CONFIG_USB=y
 CONFIG_USB_ONBOARD_HUB=y
 CONFIG_USB_XHCI_HCD=y

-- 
2.52.0

