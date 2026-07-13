Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC470C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 10:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D9AE84AA6;
	Mon, 13 Jul 2026 12:03:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="gHbwyGCQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89D7084AA6; Mon, 13 Jul 2026 12:03:06 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2535184AAE
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 12:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47defd0c1c5so1894168f8f.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783936982; x=1784541782; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XCy71K4sViKdnL2/xTWH0ss4KfJAuGPu4EIM8Z3gQ0s=;
 b=gHbwyGCQVXueuNf3vJdnVpv9M6+YSRyeHHbFgxtyoVr6vq3AZrKtxlTwvx+q1zu1CO
 IwRFDqX7QT2QQVlppvfmjz9Dy6IZ1w/X103OYUU6qcAuncdgtpvkHxrYVgIaqHX/0xzj
 Ir9fn6LYn9zSbqoLjyNjwU2cBU611AZbB/IS3OmO6uzlmmusyIaAxpC3QPq9Nvv5gGGI
 VkUJQS0QMiHPJZru2uc2qZfe0NcQ0bm8Xaip6ZIaRL0EpemR2M37XzoRJX/O74jqlRpW
 e6ujNL2qACQN/FeQrd6Oq+R3SSUwJYSzaPmvz5RsiNarMiUXDpT4pAXQP+9AgiTV4GSi
 buUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783936982; x=1784541782;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XCy71K4sViKdnL2/xTWH0ss4KfJAuGPu4EIM8Z3gQ0s=;
 b=D9b6bIiacr0HCdH88TCAYptmNnCSBDuQX3+QfKyrtMMP+8tQN+z2hBagnbUSHCwzXg
 /4yH8xgV1XElUMVUpyhzeJtEa6CmfhZtoO/Qv1JFUU75tNktU6S71zqoqZtKzG6EuLMD
 Q4/mUz1hGzOnTMIvDtHC2Ud7igJ+Nj+/FDbNLFbJuNYgBh3W09QGtY/RBTCkeny9IgHS
 UXNUPEItEdExQYQzuQ75HnzE8q2igQ8hNcKf7uO6DsRiA3EdZNslqf0GnelFX0Ai4w0E
 Fo7uMq/7edsQJK/yDlo502l6PWUgib0khKjkej9gwQIhTlFHkxVNvhreyGjKaaEXIkNz
 Np4Q==
X-Gm-Message-State: AOJu0YxHRe3SlzY9Q0C+aQUmIVa0Mw6u346PXVzCqfeZqcvXVCfEeoTB
 EQwlqVPfGztDldhhm1IBLnuP7qbDLVZsUhmvu3lRna2t4E+f8Qk54gpJyW0h0yIIcCY=
X-Gm-Gg: AfdE7cnCvGPfvSEZEPoEbEeWmEdPBCfD2P5nb3aWeZOQwLGEX9O19y335XtHsMXVN8m
 QNrKsePWpLtp1aMHFp6Q4H3TNVc+/WE8VOnAajYLYXgPm+G0HPngyaWNzJqCOiYPgehJt4qeFiU
 yXijOaA5N+Nu3Zz4naGHp0fZdk8WNfugNDqyma+WncdcCs5zWNP8nUY3O+wyRSHT0hgG7Be6nqL
 W+fJ9CGbopl1FczEf2F/besfnL4JNS0sHXQG3mv75BByySGS1PKREKMvGek9+zig3IFaboGmUs8
 Fd8o2QXuyGsWFFGwZCMID/D8U/fET5GxAxtcugZ2Tv4+2jOnDG65jfp10fyINbUVPux9Zpv4FCr
 QPcS9dNLKNqvItODh5M4H2kq5BqA3NX2je4KaD0IS1tjEn3faYxmU8/tgq6J6caNQRf4hghi32d
 7dhAZQDZzHmW0qD7cL5CauylPHzZd7kXHD9xi9Mlxaw+jGtpklejoc6HBL8IvG7ex9
X-Received: by 2002:a05:6000:2681:b0:475:d10d:b576 with SMTP id
 ffacd0b85a97d-47f2dce2de7mr9995337f8f.44.1783936982525; 
 Mon, 13 Jul 2026 03:03:02 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f25b23b7esm29135772f8f.18.2026.07.13.03.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 03:03:02 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 13 Jul 2026 14:02:47 +0400
Subject: [PATCH 6/7] rockchip: mkimage: Add option for image load address
 and flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-rk3576-boost-v1-6-9d23aa08f674@flipper.net>
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
In-Reply-To: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613; i=alchark@flipper.net;
 h=from:subject:message-id; bh=AGjSymcn9yHYfWAUOiVNYxuIjzKj3SON6E2+oTdHVNw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSFbD++54eYabuvK8czj4WZr47Nzptal1tzOz7v5tdKt
 qduHzzDOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjql+8ZfjHN0vi49aoL62Pb82cuFU9LkJslOiP9/pILr79d+Lzz8tUnDP8Uzsx
 yWS76h43d/c6HDKHMOXpP3rR0ejY/VVUs+mXfvoIJAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

From: Jonas Karlman <jonas@kwiboo.se>

The v2 image format supports defining a load address and flag for each
embedded image.

Add initial support for writing the image load address and flag to the
v2 image format header.

This may later be used for RK3576 to embed a minimal initial image that
if required to fix booting from SD-card due to a BootROM issue.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 tools/rkcommon.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index a52d1f36d772..81361cde4823 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -169,12 +169,16 @@ static struct spl_info spl_infos[] = {
  *
  * @file:	image file path
  * @size:	aligned size of image in bytes
+ * @address:	image load address
+ * @flag:	no use
  */
 
 struct spl_params {
 	struct {
 		char *file;
 		uint32_t size;
+		uint32_t address;
+		uint32_t flag;
 	} images[4];
 };
 
@@ -385,7 +389,8 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
 		image_sector_count = spl_params.images[i].size / RK_BLK_SIZE;
 		hdr->images[i].offset = cpu_to_le16(sector_offset);
 		hdr->images[i].size = cpu_to_le16(image_sector_count);
-		hdr->images[i].address = 0xFFFFFFFF;
+		hdr->images[i].address = spl_params.images[i].address ?: 0xFFFFFFFF;
+		hdr->images[i].flag = spl_params.images[i].flag;
 		hdr->images[i].counter = cpu_to_le32(i + 1);
 		image_ptr = buf + sector_offset * RK_BLK_SIZE;
 		do_sha256_hash(image_ptr, spl_params.images[i].size,

-- 
2.53.0

