Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579CCE6748F
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 23:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 083FC88E6B;
	Fri,  1 Nov 2024 00:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="Rhww/BVM";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ARezlkYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB3F988717; Fri,  1 Nov 2024 00:08:05 +0100 (CET)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B3A8892A2
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 00:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id B30E213801D2;
 Thu, 31 Oct 2024 19:08:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 31 Oct 2024 19:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1730416080;
 x=1730502480; bh=n2BSO4XwNtmJns4vGGISmggMGMQDMgCsyONsYTza6kE=; b=
 Rhww/BVMywQLOiebzJAdEsiGF2gx030zKWfsgio6UBH3sz9NKJsizZmIRu7V2pYs
 BVfl/vpmwWyxcVCqVM7fBC7SV4Jia6OBWonRhzaBiWLMpWLF+1zCicgBe1KkiRyc
 I3VNy5EhrLN/lRzaM+TVns9D8WOMYWVwVZCVqqBvgf0FdccuW/g70vnl/8MchcXW
 5lKud5WGCTCG2DJ5/jBmGRgAPhgr+j3Ccm3djMxGYMSvj95CKXvSTMJMP3PxRgz7
 Hpbq5I7xs8ofhbB6L0Pg7KfWtENEsnhwlnfg/KJstCVs0+09mS+MgG5zb36jJ1Z4
 Mmj79LnsgMzsqQyOMNpLng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730416080; x=
 1730502480; bh=n2BSO4XwNtmJns4vGGISmggMGMQDMgCsyONsYTza6kE=; b=A
 RezlkYfcumDvTDW2T/fwJGvBgAv4NSyU5ag6tSqVXJGwhpvXgQpCaJTfHxJ5rkoi
 589Tfy4IzddairNrtOHnOCvnISFhUHV4a7TileRXlRrvlyjvki6UDQJ3G/jLsNun
 w5hC345rps6/hvXers6cTKdJEanOl68KHxn1UtxWih9qabwEJy9hPrxhKItxkrSJ
 NP9wXnitSeaAxX7GvKXH4dRLxSeiqdwV66kLYC2vwmmdC8U0ceJLtfXpkyCD+pUk
 EYh3f3NUsZlZCQam+lmAz2BsWmjqKTtPtb0cpACnEnyen8RU4B3Ke7rzHn5/1IJI
 WWiisDTgwlr7hbyEHuS4w==
X-ME-Sender: <xms:0A0kZ0x8ibEvySlOypRzlZmbPNDwH2c6-97mKBPTA4hwPvLiWjAEtQ>
 <xme:0A0kZ4RQPOOcMnBrIZJmyyVxAGmZ1LWkVSm99jqkp4g84wM-HIsTzTM2fEU7vGTZj
 _4bKc0PUBUexC2D2_M>
X-ME-Received: <xmr:0A0kZ2U4FZpEva4SB8a5kFwkQE7VBwrZMfKwDSsTUZJMxF9xrcdthQUSXBIaqK228SbW8b2dq7Nw3o3rpB8xV0g_vIvtZDYgLKM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedgtdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
 necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
 cuggftrfgrthhtvghrnhepfeehheeileduffehteeihfdvtdelffdutdeludduiedutedv
 feffheekhefgtedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgep
 shhmthhpohhuthdprhgtphhtthhopehkvghtthgvnhhishesohhpvghnsghsugdrohhrgh
 dprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopeig
 hihprhhonhdrghhlphhksehgmhigrdguvgdprhgtphhtthhopehilhhirghsrdgrphgrlh
 houghimhgrsheslhhinhgrrhhordhorhhgpdhrtghpthhtohepuhdqsghoohhtsehlihhs
 thhsrdguvghngidruggvpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvght
X-ME-Proxy: <xmx:0A0kZygts4MzGQYLmF0INYfQnlbVV8EE6zAe421-UWyrob5w3YNLbw>
 <xmx:0A0kZ2Du_5rL7Rncy6kzyabS6CLZjhB4jPRNOL6XNMXyWYG1xS0WxA>
 <xmx:0A0kZzJbiXDDa-Wh5PV5bDSuQsGSP6_YPJPTb4EsrfDyaIjMbvCfkg>
 <xmx:0A0kZ9BRIDOJ0iwXod7YJicS4W1PPkKAwt8l77oKqzStZrNnnLio_A>
 <xmx:0A0kZ42MvqTuI--YjQNZ9oFmqGd6BWllke4C7Ptty551pB12AkrUAgbE>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Oct 2024 19:08:00 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 31 Oct 2024 23:48:02 +0100
Subject: [PATCH 2/2] efi_loader: remove non vital devices first
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iommu_apple_dart_ordering-v1-2-8a6877946d6b@jannau.net>
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
In-Reply-To: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=Zwm/jyQEkNObZN3MyLO3MwWkctZOCeEMfn3O92WtUYg=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnQVTsWP5q79dRlb9f0d0rsPxi26KziprOmE4d36dZv27
 +d6pirWUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCJ7VjEyLP2x4biKv9nVxBef
 St5Uv6yJXx1+KWpaZMfZaUv7vRpMohgZJvC93zxt7fk/IScDDONtD6dOblu/Q0r07tllv826lnl
 7cwAA
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

DM_FLAG_VITAL marks devices which are essential for the operation of
other devices. Removing these devices before their users can result in
hangs or crashes.
This potentially fixes EFI boot of Renesas rcar3 devices. Their clock
devices (and with this series the dart iommu) are the only devices
markes as vital.
The arm boot code already handles devioce removal in this way.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 lib/efi_loader/efi_boottime.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 4f52284b4c653c252b0ed6c0c87da8901448d4b4..7db3c95782970f8c06a970a8ee86b1804cd848b6 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2234,6 +2234,7 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
 		if (IS_ENABLED(CONFIG_USB_DEVICE))
 			udc_disconnect();
 		board_quiesce_devices();
+		dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL | DM_REMOVE_NON_VITAL);
 		dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);
 	}
 

-- 
2.47.0

