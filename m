Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2DDC25B77
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 23:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61BEE88490;
	Fri, 17 May 2024 01:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="amR/OvVz";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="SUDQplJD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAF7A88480; Fri, 17 May 2024 01:03:31 +0200 (CEST)
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com
 [103.168.172.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CC0D88481
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 01:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.nyi.internal (Postfix) with ESMTP id 597F91380250;
 Thu, 16 May 2024 19:03:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Thu, 16 May 2024 19:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715900607;
 x=1715987007; bh=nCBzLxZrlNwulMp+yUT1aIiGxQ+A2Orz+JaurscNmw0=; b=
 amR/OvVz2yCU/eRC29QiqcGn7mhVLM/MCL7xVt8v8UURtBq4kQq6d8+1GNy/tIhO
 8Zv/ykoYjAGiJcNsELoeTvvhRGBS5+AklQ1gQvzr7qaoXgGVyLSR3DhkDuinXDxF
 bPdS/VW1IGI9u8vJcXS2Sr620PWrOnRxXYcYWHgIXtmK+oAMEiJUm17XCmELoCfK
 jmw8bCxlbF8fmGfENPCpqXndpx7QgqVm7SpjH6jMBVZy08GzVYsd71n9IGk21nO9
 HaKkpKoDj9XAwY2XsVgCzbb84W9Gxm6zgVCeAD+6F2ObhpujOGhVMgh6prjHMdgi
 LoX0oEFqJMkY5NF+HvR7HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715900607; x=
 1715987007; bh=nCBzLxZrlNwulMp+yUT1aIiGxQ+A2Orz+JaurscNmw0=; b=S
 UDQplJDjMPGwB0Qd8fSU8uaRQ+7Fa7LHh/6N5vJ4cUoihAejX8qRvNBWOGfLKQ5w
 CPTe4jZiunRdtITBQjslOK4A8FVpIyvjs0b8Z+O8Ij7TgbYfYHwaTcgQaNy8EtO9
 ZEbCSfocB/RVnPkmLjDuVvYwfjdEjze6IKRzI5UvGNlxpg7BTD+VUThsprkw36C7
 Sh9nJRSkORHxH7Cj61S3USylELKzr/rtin9jVGezYDSa86TdW6o+HvhLHRXcDDO0
 NYKqU3xrPp9dJUbqcpgvY542kX9/z4wlICB8Jp74iJj4MS5Z5ZNvyEkDMXn8kTjp
 //uUn2ZrrwloH5hU24iTg==
X-ME-Sender: <xms:v5BGZuKua0prYqGJRvPty3WaLkW4tVZAP7NGOqeMjxJIfvfKAeBnJA>
 <xme:v5BGZmKeRuvorpbrOufQqUqfgm-kAljlZbhbjRJt1jNmkdVP1vkV5tXG73xMuqo0E
 46vIm-EL84O38GzomQ>
X-ME-Received: <xmr:v5BGZuvTFZWWry_YAzOClmBMSx6rOR4tStogdVHeGG0Ov2YNrBcXrYI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehvddgudehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:v5BGZjbJN4IA95IY3lC6DWGFfwafs8OpzwXmu-LLWsMgc7bUYOl0-A>
 <xmx:v5BGZlb0kh4-qFRqlScu-i575MgToqhhaTP1_4MkPO1BRHhVxZXhOQ>
 <xmx:v5BGZvDoRWA8yDXt5eAxLk0zJPO_f5ommbzdhMkEfd8Eb6Nyl-3K0g>
 <xmx:v5BGZrZf6RziUynFnEI2D7e_Pzv40O_ifeFUoYTn7qVmHGuTt7jJqQ>
 <xmx:v5BGZqOQimbU0Z0koW-bfJMuOHLGJWYq7OmfQDtSFybF2HPig68vsbl9>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 19:03:26 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 00:03:25 +0100
Subject: [PATCH 2/2] efi: gop: Mark pixel_format as BLTONLY if we have sync
 hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-virtio_gpu-v1-2-6353b87472c7@flygoat.com>
References: <20240517-virtio_gpu-v1-0-6353b87472c7@flygoat.com>
In-Reply-To: <20240517-virtio_gpu-v1-0-6353b87472c7@flygoat.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2193;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=w8jKtvqGSl/qcBMK2MpygP9drCFB+QXiCxldh68aZu0=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjS3CXvvFSzjuBlsfOLOZ9nQfwqq11s9v83Uz50t9Ndg8
 08e0UyfjlIWBjEOBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZiIsykjwy3LXVs9o7IUC5fN
 +79j4qbgbNdlB5i/VNtbRTa7fpghuZ7hr8C6tO8H/odfEPur0RI5neHkzkXr4n58mHtiqsR1MYl
 mPQYA
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

If a video device has a video_sync hook, it means some software
intervene is required to scanout framebuffer up on change.

That means EFI application can't just use it as raw framebuffer,
it should call BLT operation to let U-Boot help with scanout.

Mark pixel format as BLTONLY as per UEFI spec to reflect this
nature.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 include/efi_api.h        | 1 +
 lib/efi_loader/efi_gop.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/efi_api.h b/include/efi_api.h
index ab40b1b5ddf6..3eaefb322878 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -1399,6 +1399,7 @@ struct efi_hii_config_access_protocol {
 #define EFI_GOT_RGBA8		0
 #define EFI_GOT_BGRA8		1
 #define EFI_GOT_BITMASK		2
+#define EFI_GOT_BLTONLY		3
 
 struct efi_gop_mode_info {
 	u32 version;
diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
index 41e12fa72460..784d43d3d39b 100644
--- a/lib/efi_loader/efi_gop.c
+++ b/lib/efi_loader/efi_gop.c
@@ -467,10 +467,12 @@ efi_status_t efi_gop_register(void)
 	struct efi_gop_obj *gopobj;
 	u32 bpix, format, col, row;
 	u64 fb_base, fb_size;
+	bool needs_sync;
 	efi_status_t ret;
 	struct udevice *vdev;
 	struct video_priv *priv;
 	struct video_uc_plat *plat;
+	struct video_ops *ops;
 
 	/* We only support a single video output device for now */
 	if (uclass_first_device_err(UCLASS_VIDEO, &vdev)) {
@@ -485,6 +487,7 @@ efi_status_t efi_gop_register(void)
 	row = video_get_ysize(vdev);
 
 	plat = dev_get_uclass_plat(vdev);
+	ops = video_get_ops(vid);
 	fb_base = IS_ENABLED(CONFIG_VIDEO_COPY) ? plat->copy_base : plat->base;
 	fb_size = plat->size;
 
@@ -529,7 +532,11 @@ efi_status_t efi_gop_register(void)
 	gopobj->info.version = 0;
 	gopobj->info.width = col;
 	gopobj->info.height = row;
-	if (bpix == VIDEO_BPP32)
+
+	if (ops && ops->video_sync) {
+		/* Applications can't really use it as framebuffer */
+		gopobj->info.pixel_format = EFI_GOT_BLTONLY;
+	} else if (bpix == VIDEO_BPP32)
 	{
 		if (format == VIDEO_X2R10G10B10) {
 			gopobj->info.pixel_format = EFI_GOT_BITMASK;

-- 
2.34.1

