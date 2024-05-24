Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93825C25B7A
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 13:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42A538867C;
	Fri, 24 May 2024 15:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="diEMDR7P";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="EJXjYIkc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65F788866B; Fri, 24 May 2024 15:02:48 +0200 (CEST)
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com
 [103.168.172.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5294088545
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 15:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfout.nyi.internal (Postfix) with ESMTP id 3119413800A5;
 Fri, 24 May 2024 09:02:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 24 May 2024 09:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716555765;
 x=1716642165; bh=ZTaZUK7/86g1HklojfwukLlDKKBScmkHO/S+A4oHDAQ=; b=
 diEMDR7PZhVhlyQ9Cso52R77GHsaxQjjgnxH9nAZ9CQyRgDBRvUYBogx0rSKCaNA
 2oHUxjJDzYoOCfyXqG/qyp42HkSd8kEfGYCJfSQ0grTQMVdRcphW99s02V0uWjFE
 QbWee1DjvfmbpnCX6fX9HpBwKe1Z8fW52WH+rLHOCqhJYQkvcxMBCfaSAf0jDILz
 Z52JzbxPkbr+HwWsiJ36vjmTHmjXZjhPasoSHPmDshiI/Vta2P31mbX4LvMH5U3c
 pUYNRUdDdnmkNvqVlqAxhIUJV1X17/wytklp9y6VjdbdiydlTDWVDXsL5MeWyo6J
 dX6S3XMXNcKBwmFtq/TWzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716555765; x=
 1716642165; bh=ZTaZUK7/86g1HklojfwukLlDKKBScmkHO/S+A4oHDAQ=; b=E
 JXjYIkcbDGvy0VTZTOTU3g9Z7xG5YFMHAV50ZduZT6xNPE/ni669GjweyffB/7nm
 NLibwQoI6f6wzmkYy2bo4t/gErkrFyX/2oY3XhVvXkLaeWzWOzCU9bG2LyLwqb4q
 fVPd9Mj9hblZaDf7K/nGMlS/nXmR488ywha5wuS9jU8Jcx3923EkhUHf+pCGcDCB
 bz+LBaClDEr4E+RUNV0GwJIfJLYVKnzowcgaSo0HFvKjtVhpw7nR9WT9ILEi2sVl
 /M5aRD6ym0rEVPKpqQB9HQTdZF4ZkzkIPdmIKJjJMXx80W+RnSIT4Oi9FsktsLAF
 efmXJlTFJg82sBzVWr1iw==
X-ME-Sender: <xms:9I9QZkHSu2gylK1QkIFDZ85H-1g68yM27tBvT46Kq-yZXftR3PmQMw>
 <xme:9I9QZtUHwdBwiRIGJioUNfjDmmpp1iRoYwxj7Dmnj0xqHDqcpxu83ML8tMI4fS7DT
 vezswedhVqs8O1zpCU>
X-ME-Received: <xmr:9I9QZuIL9jRV3LLuaaqsCcV9x3QQKMrKkIUbtFMCYagaT0LeuqutFcU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:9I9QZmGHq9Bf8BgqIWTJEqO_clXAPdGus9LCaW7bcmo-EntwrF4swQ>
 <xmx:9I9QZqWOWRybWVCdzQzcI4-DYb0REKH3_IBkI7IVobgn47SpYjyn2Q>
 <xmx:9I9QZpOWTJ9bqzihC91arGtWYPqE7BWSSw-cTo5-5BT6y-gieI8yBQ>
 <xmx:9I9QZh3ABV8deVKEAn-3fN4GZA3lLJHhkkG8vCbyb1hheKD9Jv-97Q>
 <xmx:9Y9QZsJJNmDpMEtT_dzLPpIYeRYNkSBLEeQaqA_QxgShEbidLzB3Z8MQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 09:02:43 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 24 May 2024 14:02:40 +0100
Subject: [PATCH v2 2/2] efi: gop: Mark pixel_format as BLTONLY if we have
 sync hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-virtio_gpu-v2-2-b198c35b1fd2@flygoat.com>
References: <20240524-virtio_gpu-v2-0-b198c35b1fd2@flygoat.com>
In-Reply-To: <20240524-virtio_gpu-v2-0-b198c35b1fd2@flygoat.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2103;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=n0PfKlj9sdcRHBiKej668zfdWxMZBo3eyaEs3iHrcTc=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSA/g/PU73f7fJfybA/OFl3ls/ZCSYCyx2KTr24axCpd
 /RA0mrxjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZiIow4jQ9PJbTk3nr+e5Omx
 Qe29xL7wRz7W++PTnj5/epb51Tsj/YmMDLfsPGOPHQ6aI6a/SI6Tv2SBH3M1+/aE3H0SGYLVIim
 MXAA=
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
v2:
	- Remove an unused variable
---
 include/efi_api.h        | 1 +
 lib/efi_loader/efi_gop.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

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
index 41e12fa72460..c9244376c09a 100644
--- a/lib/efi_loader/efi_gop.c
+++ b/lib/efi_loader/efi_gop.c
@@ -471,6 +471,7 @@ efi_status_t efi_gop_register(void)
 	struct udevice *vdev;
 	struct video_priv *priv;
 	struct video_uc_plat *plat;
+	struct video_ops *ops;
 
 	/* We only support a single video output device for now */
 	if (uclass_first_device_err(UCLASS_VIDEO, &vdev)) {
@@ -485,6 +486,7 @@ efi_status_t efi_gop_register(void)
 	row = video_get_ysize(vdev);
 
 	plat = dev_get_uclass_plat(vdev);
+	ops = video_get_ops(vdev);
 	fb_base = IS_ENABLED(CONFIG_VIDEO_COPY) ? plat->copy_base : plat->base;
 	fb_size = plat->size;
 
@@ -529,7 +531,11 @@ efi_status_t efi_gop_register(void)
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
2.43.0

