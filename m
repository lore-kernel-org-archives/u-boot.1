Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A8FE6748F
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 23:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77FA288DEA;
	Fri,  1 Nov 2024 00:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="oBHfkhiT";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="m3KQWZFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2835A88E0F; Fri,  1 Nov 2024 00:07:56 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E27088DEA
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 00:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3F47C1140128;
 Thu, 31 Oct 2024 19:07:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 31 Oct 2024 19:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1730416071; x=1730502471; bh=Ms
 fYyqNyNn6wcfxl+6IM/K56OGGrWNoakg0hEqPm4mM=; b=oBHfkhiTZqSN937tFH
 CSs3x3InaTz1e4gEcjIzvshxk8lu72vyhslM20fNTw0tcAJS7CF+3rbie0GHjxKe
 zX9qw07As89NfxAm1ViGenYUQFY5w7M+qM/E2fIfOlrWdC8vl/c4lxxvQAEsmhZW
 1E+2fhtbtY4+pXSZvJLqe6Hscgg0JLfmuh9wpOp50CEMgqpB1VKADqlYO+ABOSTB
 4SMrhba4DU4imUEepJAuO/6m7cmnF9l13iOLN9FG563tmVxswF9vhT3ZM2Oy90lk
 gYN166MiDx9KCagjoTtqbag93/zDxfMXXacg/xuCSLzgz8Cds0NMWOXZ6HMRNM2y
 Q/TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1730416071; x=1730502471; bh=MsfYyqNyNn6wcfxl+6IM/K56OGGr
 WNoakg0hEqPm4mM=; b=m3KQWZFX91PiC2mMENjF+qkndxiW2XsJRJkxp+gQ3NhH
 EBIa6m34+JGoSAXC2ijBWFngLdkhwGPu5OYM2Z27P09A3djz6q4ey+alrEllp1Gq
 8i705crTGiWnvrIU0SVWblpT7NfOLGdL2HVeAW4Tb/+5osUiI37vgSJkdv7Gl91G
 hr8jTAPvmEokG9pAEETz6sPOkI72CajToTO5HuhihMjuZt2t0qoFK+t+Fow6uUWW
 oo9mJCV2IfQ+zE08nrqK/4iGqsuocUm0VcbEdAFw/lCqpA6nOIjVu6zzXi4skr1n
 ZI5Fw6lZCyS8MMEO1kYfhnSWvhWySzUVeOol1GfyFQ==
X-ME-Sender: <xms:xw0kZxaM5GiGrpxOuq8ZOFf06XZW_YeKcUtlFkw2l34peMQ-SEmxZw>
 <xme:xw0kZ4aFaX-pUzwj-_9vgS8MIdG00q0EcaWQ3lFR8m9srBBFuYxTtY3qfm3y-m9uc
 KcGwN-kVw0XC9NSv9A>
X-ME-Received: <xmr:xw0kZz-WzFDBuvoFwMZAKlhAVVX5NnAJknOy08AMZ2jSM1iG57fZVPVI8_CLMoCecUsUZcBrrZ9K6gI9z14pmNIriYDoltJI-hc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedgtdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecu
 hfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecugg
 ftrfgrthhtvghrnhephfdtueduleejffduvdehkeeutdefhfdtvdeiieegheffleefvedv
 hfeggeegffefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopehkvghtthgvnhhishesohhpvghnsghsugdrohhrghdprh
 gtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopeighihp
 rhhonhdrghhlphhksehgmhigrdguvgdprhgtphhtthhopehilhhirghsrdgrphgrlhhoug
 himhgrsheslhhinhgrrhhordhorhhgpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhs
 rdguvghngidruggvpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvght
X-ME-Proxy: <xmx:xw0kZ_r-D5_KTS05iBjOehC_f_Ae79zxas4Zzkb9d4duy4D85pjSXw>
 <xmx:xw0kZ8rwny-QEHGXNNzY9srICLemyeIMFKReeTiv9wq2jtVLiT2XTw>
 <xmx:xw0kZ1SejaA1tslYKvpJuitGxiluYKnBAAaZo7gnsCXyjFbm-j7y9w>
 <xmx:xw0kZ0pzmdj58RF0B2ENU3SXV0JKG0Z_WnAINbAV7zerWOzaojkezw>
 <xmx:xw0kZ9cihdAKMNxfWsk-pp6KhA2xF5e9IfsAi9igBycP0f_rna95R59e>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Oct 2024 19:07:50 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH 0/2] Fix device removal order for Apple dart iommu
Date: Thu, 31 Oct 2024 23:48:00 +0100
Message-Id: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACAJJGcC/x3MQQqDMBBA0avIrBtworHiVUoJwYw6UJMwqSKId
 ze4fIv/T8gkTBmG6gShnTPHUICvCsbFhZkU+2LQtW6xblBxXNfNupR+ZL2Tv43iyyLMypieOt2
 90aCG0iehiY/n/fle1w2f1ruaawAAAA==
X-Change-ID: 20241031-iommu_apple_dart_ordering-558e62671512
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; i=j@jannau.net; s=yk2024; 
 h=from:subject:message-id;
 bh=LiXKjFyturHNnI1p+Cn4BwXjEsJNBiXFLU+Hx4crCgs=; 
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnQVTgUFS5Xdx+ZbLe35/tjv2Me1fGseG599EDn/NZPAh
 Pme187zdpSwMIhxMciKKbIkab/sYFhdoxhT+yAMZg4rE8gQBi5OAZhIgTfDd5/U7Mm5Uqzpk9wW
 SV2f2BOWPyHVqDTQo+TVhlWmVzRVGP4XRDsVtVbU3tkZwG0z79ieDdaxjSfqtS88ydwwdZZK/Hk
 +AA==
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

Starting with v2024.10 dev_iommu_dma_unmap calls during device removal
trigger a NULL pointer dereference since the the iommu device is removed
before its user. The sparsely used DM_FLAG_VITAL flag is intended for
this dependency.
This series adds it to the Apple dart iommu driver and implements the
two phased device removal to the EFI loader.

Signed-off-by: Janne Grunau <j@jannau.net>
---
Janne Grunau (2):
      iommu: apple: Mark device with DM_FLAG_VITAL
      efi_loader: remove non vital devices first

 drivers/iommu/apple_dart.c    | 2 +-
 lib/efi_loader/efi_boottime.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 1d147b74f437fb0e85821e8271fe52bc5fd30194
change-id: 20241031-iommu_apple_dart_ordering-558e62671512

Best regards,
-- 
Janne Grunau <j@jannau.net>

