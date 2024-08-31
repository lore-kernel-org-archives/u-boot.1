Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53EFC5474C
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 03:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5DD888D3F;
	Sat, 31 Aug 2024 05:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="Es+5UCjb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F4A088D40; Sat, 31 Aug 2024 05:17:33 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A67F188BBC
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 05:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20219a0fe4dso22175325ad.2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 20:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1725074248; x=1725679048; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z64fZ6YeDLuMDZrUxCtq4n5IuPkHiE0NpFTBhbsS4Jw=;
 b=Es+5UCjbLg7QvL7iywqiccu82WaWcb5RCX0rVel50nFWxxFWjRsAnRYH3+bm1fCkqd
 qhgx5J5vig1e90DXiiAk9flUCe1T7jWlY0AVNZNAPGt9HKZ2nnG/6hXMVohIBH/bA74H
 wSQ+tnyP5RLfjYSWNKxxBW3O6bB/zg77imICI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725074248; x=1725679048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z64fZ6YeDLuMDZrUxCtq4n5IuPkHiE0NpFTBhbsS4Jw=;
 b=YoBCE7QHsPhpOMwJGUCIuFBEdsjJ9x70a9Egh+st8y6462NHGCPwsGsRbhDrUBUUpC
 xGDBRnpNeG+SmMPsWHzeOSUyNI+h+WBr0q7a2WqKrvvi8pGRwf+jUFSU5IX8wUCC9yvV
 YBrToTX+DeiTH0BDjdYmhhtJfotmPNuke7yLb2XuSTYNq/AkP4vXVmapltquM8FcJ9FC
 PMVh+qQCCDeMfTj/UeRlGx+AVUeKnRM9sWtzwM4cIyVSNtm4RtmhJmt2ycThz0wmf6fn
 RIjxwzBKuo6Lwj4PW9qxw1cCOsx2vlVfgfbsjPqpQxZt2mazkRebMyq9PrjLGewqOQz9
 sktw==
X-Gm-Message-State: AOJu0Yx1/fkS/8nroSfRcMNELV+17c1/LIJO48PLNwuNXQ/ze/+a5Sxs
 i9aIaXRkZIkOC7wEFMeEXPBZ2e20dnx5L9CJB9U4SALXypIFhFqM1rqJb7Jc1KgZrzmW3C7v3qN
 IpC4=
X-Google-Smtp-Source: AGHT+IF7VkH/Y77Tkjo9+uKOwH0UjRH/ZEYncZ+EGxZoia6FMLDO1uU8uLlocg1A7AHwLgEO1J0LAA==
X-Received: by 2002:a17:903:2285:b0:205:4e4a:72c6 with SMTP id
 d9443c01a7336-2054e4a79bdmr2571365ad.5.1725074247723; 
 Fri, 30 Aug 2024 20:17:27 -0700 (PDT)
Received: from shiro.work.home.arpa
 (p1980092-ipxg00g01sizuokaden.shizuoka.ocn.ne.jp. [153.201.32.92])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2052e67fbf0sm16168845ad.137.2024.08.30.20.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 20:17:27 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	sjg@chromium.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] spl: spl_load: fix comparison between negative error code and
 unsigned size
Date: Sat, 31 Aug 2024 12:17:06 +0900
Message-ID: <20240831031706.2654697-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

read could be a negative error value but size in spl_image is unsigned
so when they are compared read is used as if it's a unsigned value
and if it's negative it'll most likely be bigger than size and the
result will be true and _spl_load() will return 0 to the caller.

This results in the caller to _spl_load() not seeing that an error happened
as it should and continuing as if the load was completed when it might
not have been.

Check if read is negative and return it's value if it is before comparing
against size in spl_image.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 include/spl_load.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/spl_load.h b/include/spl_load.h
index 1c2b296c0a2c..7de834f402b8 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -83,6 +83,10 @@ static inline int _spl_load(struct spl_image_info *spl_image,
 
 	read = info->read(info, offset + image_offset, size,
 			  map_sysmem(spl_image->load_addr - overhead, size));
+
+	if (read < 0)
+		return read;
+
 	return read < spl_image->size ? -EIO : 0;
 }
 
-- 
2.43.0

