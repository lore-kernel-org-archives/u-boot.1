Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7956EC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 22:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD52788263;
	Fri, 17 May 2024 00:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="woTA4Jr1";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="gjoLxzZK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6C3888486; Fri, 17 May 2024 00:16:46 +0200 (CEST)
Received: from fhigh2-smtp.messagingengine.com
 (fhigh2-smtp.messagingengine.com [103.168.172.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2802588318
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 00:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id D62941140107;
 Thu, 16 May 2024 18:16:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Thu, 16 May 2024 18:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1715897802; x=1715984202; bh=Ru
 If6TkwtxBwgwWuZQulrbbQLQ18OPU3FVOdRUpe3TI=; b=woTA4Jr1OXHleAbg/u
 mR+HnGJ0XqxPnUm9pR/SlTvAGlJAXWu9iAxpmr0wox2Tnu6fTayyeUDYtGSs+9nr
 7jGH25iGV2D3tDV9WAT7w+q7sgd/ZAhQRvVlwxNmxb2lStnD6BFNKVSd8LW8Lmre
 cF/qrHh8Ze0kzgk51UTBG5mtmobgD+ZoZYC+9pyOlq+zloaLdIEbRxl6Db+VG2X3
 rny171dHAb0MB+Z6MiJnBX5U21kB43mHqz3wJHxgeVfGI8Pde9rUTRgMe7guHIBk
 SrJwUh17mvcpJPnU4YyC9yE+uo67hIUJXscdV25d80RjogtbLRvIq6RphjLTjFS3
 ZbEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1715897802; x=1715984202; bh=RuIf6TkwtxBwg
 wWuZQulrbbQLQ18OPU3FVOdRUpe3TI=; b=gjoLxzZK17ezJ/50Ct5INhkTH5PJl
 LOiEqBnpZcwCFbyR0b5YE89I9WdT5LaLKKeDIpntQ8jA3B3oHdaQ64eUAGIUTqdJ
 v4gSJKPQUMN1o6wg5qt/Mm40A6ODZdZppUh+GnhIyIQAlWQmzUqr+CwUeVwfndFf
 /Qw7AQywcqLbx7Gw7g6z4qOxTDRdFkBqSyAjsp+pE5L6XFUoJ2tLpn517TffTTaM
 xzovtwZG8BetSWXg/N+lYq/aNFtt6zBjFnKHQVjQ2fD6xKm1cKv75MFTuS5Mc4en
 VqqbB4AqfV+BXKHnFgTff9dYdP0JRu4yScSrf+4D7kMpp+yPf3jDGzj/Q==
X-ME-Sender: <xms:yoVGZvZOuUX28E01M_-VjiU_vseKdyeQkfm7ryttuW8021mQ_CDJSg>
 <xme:yoVGZua-lZPKnzOa8SLqQi-ZmunBPXO3zZBVXW0yh-YF5c9ORlKjzkP_zZqZHeQNg
 U0YpvQWuq4m1QXK30Q>
X-ME-Received: <xmr:yoVGZh9Ercda6cZhSJnnMk7O-zb0sV11wwEYzemBWQPvjFWdEzcWLDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehvddgtdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepudffffffhfeuheevhffgleevkeeugeetfeegieeijeehfeekheek
 veduveeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:yoVGZlpHcaMOlZAR7E7eLunaxsBSIhFVh_h8g1lvvN-jbXXZ6QNeTQ>
 <xmx:yoVGZqoBkmzr_mZO3D6hHjODD8rh3T3LTTl5Oatuhv1_u5mW46VG9Q>
 <xmx:yoVGZrQNSN0xETp0_g-f_yTKoVh8aQFX-qVpFvjd9TUsvnHZvJ-NfQ>
 <xmx:yoVGZiofiyDdWyJanrugBBEpxbSYF1LrfHaQ31hNHYrFno5Yxcdanw>
 <xmx:yoVGZp3yLpQHy7tM7wdjMIB5VJG0rc97MrHHGjfX7Pq6eU4FeBPGjjjZ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 18:16:41 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/6] video: pixel format handling fixes and improvements
Date: Thu, 16 May 2024 23:16:40 +0100
Message-Id: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMiFRmYC/x3MMQqAMAxA0atIZgNVrIhXEYdgUw1iK6moIN7d4
 viG/x9IrMIJ+uIB5VOSxJBRlQVMC4WZUVw21KZujK1aVL6irniK44g+6kYHEnfkyU2NJQu53JW
 93P91GN/3AxKq/t5lAAAA
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1980;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=y+HBculpAFtWTUQzNjYcXOz+a/Et/VEGGsM/qRzGHzo=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjS31tOLd7NlFK/NEJg6lfn3k4yMvNUuYUlfPVsU1l36Y
 HVJcMaxjlIWBjEOBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjIkveMDIeObjKf3a//MjL+
 swBPCINT+eybPltPPohYtd/CSnqtoyIjw+Gf2fMPdC6933rpvOrRFmEBrRTXrx5Z08NTE1+E7b4
 RxAIA
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

Hi all,

This series fixes endian related problem I found in general
video system when testing my fresh virtio-gpu driver on big
endian target.

It also removed a lot of duplicated code on pixel handling,
and make implementation of new pixel formats easier. Further
more, it removed limitation on bpc for BMP display, now we
can display any image depth on any target display controller.

Please review.
Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (6):
      video: Move generated bmp headers to include/generated
      video: Add gitignore for u_boot_logo.S
      video: Rework pixel format handling
      video: bmp: Rework with video_rgb_to_pixel_*
      video: sandbox_sdl: Implement more pixel formats
      video: bochs: Setup framebuffer endian

 Makefile                          |   2 +-
 arch/sandbox/cpu/sdl.c            |  58 +++++++++--
 arch/sandbox/include/asm/sdl.h    |  17 ++--
 board/aristainetos/aristainetos.c |   2 +-
 board/toradex/common/tdx-common.c |   2 +-
 common/splash.c                   |   4 +-
 drivers/video/.gitignore          |   1 +
 drivers/video/bochs.c             |   8 ++
 drivers/video/console_truetype.c  |   4 +-
 drivers/video/sandbox_sdl.c       |  16 +--
 drivers/video/simplefb.c          |   2 +-
 drivers/video/video-uclass.c      |  38 ++-----
 drivers/video/video_bmp.c         | 201 +++++++++++---------------------------
 include/dm/test.h                 |   2 +
 include/video.h                   |  31 +-----
 include/video_format.h            | 161 ++++++++++++++++++++++++++++++
 lib/efi_loader/efi_gop.c          |   2 +-
 test/dm/video.c                   |  18 ++--
 tools/Makefile                    |   4 +-
 19 files changed, 332 insertions(+), 241 deletions(-)
---
base-commit: ad7dce5abd49ef3b5c93da5303e15449c8c162b4
change-id: 20240516-rework-video-format-ae8afadc45a5

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

