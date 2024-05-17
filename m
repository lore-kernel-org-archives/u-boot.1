Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B39C25B79
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 16:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A3F28848B;
	Fri, 17 May 2024 18:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="EG0DJPdi";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQGptF80";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C2C5883BD; Fri, 17 May 2024 18:33:04 +0200 (CEST)
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com
 [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F3B3881C5
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 18:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.nyi.internal (Postfix) with ESMTP id 6245D138151F;
 Fri, 17 May 2024 12:33:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Fri, 17 May 2024 12:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715963581;
 x=1716049981; bh=6+LX3BdKeTPxLigfZQrvLRZOlT8olOhZUFCILqJq27A=; b=
 EG0DJPdiHXtgxsxAGw0CFvq7nLulmQUNL2qT8037EFQ7UAcTwwHoyeoZpzjl/iCQ
 unb0UIMNjj86mphY6jIttRJ9I68sxQ7qyf1rjjRJlasIJohMer2NlGHKWGLcFWec
 3j8/nU/q93BTA0HgzGdfBLwhXiIwNHopCeNHUMzGEIAFQyJHGJTQsJzYK5zn259v
 BKh2uAuszcAfb82HAb+8LF/8WlKEbaxZuGd8jqKVX7G8cquZcK35oRAKQ8OFtLya
 Dwbtbtf8d8698g4RQeWL9vs88TWkQpQjEK+pdlGR/SeWi98Cs31KIRTitT01NFC5
 YrCevUH5b7Ow/VmeAYIG9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715963581; x=
 1716049981; bh=6+LX3BdKeTPxLigfZQrvLRZOlT8olOhZUFCILqJq27A=; b=W
 QGptF802hkVc72qmLbgcES7sQDKOvILiIlYQ9Sg+oqPaPrOZEbbUxYks/bJ4xibM
 uLRa6DHyIxIsEpYsnEwTyhAkgnWauT1BWMhPw96G3XR1/HYyirddtHfMKpZt7fTX
 PTZmw1GkhI07OmGWYg+XtWs0C5YjJDPnfe54SVZm+aLaUZHZt8p2uKXdU2fJMgiN
 gQMmNhcaS03AJyn01FATn8n524X7/ygUt5s8dOg7bAorLyctyD779Nuzof4UK/VJ
 unWSDKkMKmYDROoQ8d0y30T2cS/NWMPRVL4eUnPpYZnM3ysrgGhhFH3NAVYDkRu8
 w05UisZQX3JsEIGbF3RCg==
X-ME-Sender: <xms:vYZHZgYVZxKbtU-sIB8AJJKPUj6LAnT7HQwEtIK3TvxEkbzf6Zyb5A>
 <xme:vYZHZrZzRVDeLc83buAcOAuWsHvioJpjQndqFy9kV4_tOpPk4nbh_ufC1ke-Nv-nm
 3_jyGaj07blrdafAIE>
X-ME-Received: <xmr:vYZHZq8gsArRcnIncVh_0ldGIKc-_mMyaLo5EJF67Zf4wBi3V3LvW6s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgtdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:vYZHZqqQkvJYT7dgWCG_2nEq5q49s1GFTYcn9N54S4r0D7fBqMPBxw>
 <xmx:vYZHZroYXPtFCryGthZe8JeA5GoPT-2_7hnJIsU5hdZ4sgzaMF7oFQ>
 <xmx:vYZHZoQ_zFxVqONh6Dw5FeSdmWNvCJ0J1bR7z9qPLGguPJCssz5O7A>
 <xmx:vYZHZro0VXzhtH1AKn_5iEjJllyvKpaatsS0b3FqnXU7U635dQemLw>
 <xmx:vYZHZsfHe-yvOksgs6u8zo3WZxPg51vGZqYFSGqy4jraIlok2h6IGk_g>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 12:33:00 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 17:32:54 +0100
Subject: [PATCH 3/7] Makefile.lib: Preserve .rodata section for EFI file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-mips-efi-v1-3-79096e3ca3b3@flygoat.com>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
In-Reply-To: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=747;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=5HzhRj+Ut6MF+E06jhkxsOUHC0B687xXtjCBHF2RE74=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3th2ea3yO8G/gWZH8acm1UHt+l4UWU1uue+ZxtZ+eq
 m6fXnu8o5SFQYyDQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACbi9Ibhv4+Oa5Pzy2nVaUsC
 DnAJWqfuvJKzvV8h206gmz1qp1uZCyPDU4enuz7Wewnt3Z6rbbXFwOf8Qv8VFnH5u35pP3eW+De
 TEQA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

This is required in performing objcopy to MIPS EFI files.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 62f87517c09c..52aed7a65d47 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -469,7 +469,7 @@ $(obj)/%_efi.S: $(obj)/%.efi
 
 quiet_cmd_efi_objcopy = OBJCOPY $@
 cmd_efi_objcopy = $(OBJCOPY) -j .header -j .text -j .sdata -j .data -j \
-		.dynamic -j .dynsym  -j .rel* -j .rela* -j .reloc \
+		.dynamic -j .dynsym  -j .rel* -j .rela* -j .reloc -j .rodata \
 		$(if $(EFI_TARGET),$(EFI_TARGET),-O binary) $^ $@
 
 $(obj)/%.efi: $(obj)/%_efi.so

-- 
2.34.1

