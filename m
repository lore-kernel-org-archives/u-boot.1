Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C27DD26D7A
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 17:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E26AF84206;
	Fri,  9 Jan 2026 18:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="j1hxaGBj";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="zL9IbEjU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BE1084248; Fri,  9 Jan 2026 18:20:39 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3C7683C72
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 18:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 6C7771400153;
 Fri,  9 Jan 2026 12:20:34 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Fri, 09 Jan 2026 12:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1767979234; x=1768065634; bh=AV
 ugb64ELLFxDJEs3KstbvdNXX80JkrQFafAxUlJSCU=; b=j1hxaGBjnxSdBQAVxY
 K9izHnpCdmXDimi1wKczod4UdTc/wGAHO9DkHfHImWApiYyOpkvLqexBcUqsFHsx
 +PIBiKfXcBxP/zSw+CvmZW8atcgSKheOFPVeby/RSFdPJuB5jsV6aFHAqABgcrUR
 hD3gKs40eWAbd9rmj+sh7ELrV6r6UM5ub8CZYzf7839cKNAHfv3w5IIfk7/gf1E9
 6oVMSoIzn+tW5kyCrPkUu1UqYYsFm4nLjFunaMywWzWVFeshFEmE3gl+nGrj95Ms
 s0z1i4rvh3hf+t+SXhBV8yPaieqlNQhkmbfV2nHsUlARN3/RLHWR7DpF6psRQ0bC
 1HgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1767979234; x=1768065634; bh=AVugb64ELLFxDJEs3KstbvdNXX80
 JkrQFafAxUlJSCU=; b=zL9IbEjUMml7vmXQY4qSlRkWIl2nrQy0sAF3SLhS20kl
 TfWfF/F1Qc/OGTCsP1Hn831VVxA8SZfWSkInepOuRJncm1Ltv2auHqsJUQ/W5aqQ
 TuZSO3PaXZGkMAWDrY6iF4prtrDoJEn3uz6WE9o080jsqMDnI5CxdkhGv928+5PK
 fAAg5oo1b5hYGxHb7Ml4SHZ6QYJIplrlDB0yrJW2F6W2D4/X9QYKrQY0L9nJic8W
 tXSkY8hpzVFA7Y6oWz6/OpnBMalkeQQaWqyPZfyn9byF0mvs+//kLD4Ww+pmdm0M
 FcvY68T/5dqD6ziDpUU+YW5+ZU8JaVMzEaGObKjnTQ==
X-ME-Sender: <xms:4jhhaT81b2LomLrRCvuqbWbBzcxjL7ToDA8EycURqeSOmiGxz5utDw>
 <xme:4jhhaRNw5RBAKGT8KwLNXo8a5Dbjlc1VNJ2NMhMyofM2FK10sx2B3H42vvYnCKLER
 4tu9GQoeuxb6Ihb7YN2N5ov4eic60wLGWNE7yo5ZEN52VomDFRUw5U>
X-ME-Received: <xmr:4jhhaRGH-1TxzVbXMdRxSOMGJlQBdZwO8x_S-fBQLGPyl5JzkQA1PC8bzqSRFKxRuQ_hmPFxQQurs8NaK9e1Mewejnj3QicCb8hsKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdelfeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgvucfi
 rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfeehle
 dtheefteejfedvheetuedttdetleegudeuteejveetieefuedvfeffvdeinecuffhomhgr
 ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohephedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgvthhtvghnihhssehophgvnhgssh
 gurdhorhhgpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvhdp
 rhgtphhtthhopehjsehjrghnnhgruhdrnhgvthdprhgtphhtthhopehuqdgsohhotheslh
 hishhtshdruggvnhigrdguvgdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdr
 tghomh
X-ME-Proxy: <xmx:4jhhafQhGnC90qaqBjWf59QbvlSiaKSdH0dMFYrLEu7BCPtJ7cRZ5A>
 <xmx:4jhhaev0ynC6ZW2BmB7I8wuENOeXXUCLfvQhWQchvfsP2d2SIh5EBg>
 <xmx:4jhhaXKriuiLCZdjTF1ZcL5i7UVA1pG0EZOL-Sslu8oy8iQsYlqY8A>
 <xmx:4jhhaTnG7soseUV9GS3SesGaHWlW3TLUsGdvH-sYCawmSF98rBLknA>
 <xmx:4jhhaQeINhU5DSgF_bSDKLSgHO20wnDiuN5JF5XWDdtN2g5LxVoJOShj>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 12:20:33 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Fri, 09 Jan 2026 18:20:30 +0100
Subject: [PATCH] configs: apple: Enable SMBIOS / sysinfo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-apple-defconfig-smbios-v1-1-16477009c034@jannau.net>
X-B4-Tracking: v=1; b=H4sIAN04YWkC/x2MQQqDMBAAvyJ7diFJbat+RXqIycYuaBKyIAXJ3
 w09DszMBUKFSWDuLih0snCKDXTfgfvauBGybwxGmZfSakKb807oKbgUA28ox8pJ0D7eo2qSHp4
 GWpwLBf79x8un1hthFoz+aAAAAA==
X-Change-ID: 20260109-apple-defconfig-smbios-a37802021452
To: u-boot@lists.denx.de
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 asahi@lists.linux.dev, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1771; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=kxn2hk+EJhSnbBbMmTcTBtKEj6KmDfgiSItOfKs1D0I=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsxEiwffZE/l73cweyH3akbR7Z2pVw5dWfm51PdjoljxF
 pGlK9t1OkpZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAExkWykjw5PjK1pb2qolhNVY
 GieVaT5TW+WVv/RVlGfM/ZpHchr8ixn+Z6TkGj9q9F5vF560yre8JNZvlnzk0efqtk94S3yu75z
 ADQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

Enable verbose SMBIOS table generation so that user space applications
can use the SMBIOS table to provide details about the system. The
desired information is chassis-type to determine whether the system is
laptop.
Adding the chassis-type property is proposed for the upstream device
trees in the Linux kernel in [1].

Link: https://lore.kernel.org/asahi/20260109-apple-dt-usb-c-atc-dwc3-v1-0-ce0e92c1a016@jannau.net/ [1]
Signed-off-by: Janne Grunau <j@jannau.net>
---
I do not plan to update u-boot's in-tree device trees. The Linux device
trees have almost reached feature parity. The main missing features are
the USB Type-C ports (on track for next merge window) and the laptop
keyboards. I think it makes more sense to close the feature gap and
switch to upstream device trees instead of adding to the in-tree device
trees.
---
 configs/apple_m1_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
index 2d685da8c9eee2084b0144050e12c03c77e5184e..52672f59566dc0ebbb1c829cff6c7d8f798e7c50 100644
--- a/configs/apple_m1_defconfig
+++ b/configs/apple_m1_defconfig
@@ -16,6 +16,8 @@ CONFIG_SYS_64BIT_LBA=y
 CONFIG_APPLE_SPI_KEYB=y
 # CONFIG_MMC is not set
 CONFIG_NVME_APPLE=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_XHCI_PCI=y
@@ -25,4 +27,4 @@ CONFIG_VIDEO_FONT_16X32=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_NO_FB_CLEAR=y
 CONFIG_VIDEO_SIMPLE=y
-# CONFIG_SMBIOS is not set
+CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=y

---
base-commit: 127a42c7257a6ffbbd1575ed1cbaa8f5408a44b3
change-id: 20260109-apple-defconfig-smbios-a37802021452

Best regards,
-- 
Janne Grunau <j@jannau.net>

