Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B638CF34C1
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A680983F72;
	Wed, 19 Nov 2025 15:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ag2h9xNr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2839483FBF; Wed, 19 Nov 2025 15:55:35 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1587983FC8
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-657534478a0so1503854eaf.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564132; x=1764168932; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NsuhDE2lCBX0C+v7XFYeUSjsuQe+gfuikfjn1Rn3dZw=;
 b=ag2h9xNrYRui0Q7G6HFCXRlBdrszg6yZw+d6q/qSJ5ts5lm9ZbFY9BGA5A29cFnVj1
 xlFPTIE5UNcTVlrtuK4xU69k95AgQ3fvsYvg7F/aoSiAHiY26c3C8UEwRwuqRE5rlvjd
 6j5wG7XrVhILm70qWB/bp7Wfk/chkPsxpzM8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564132; x=1764168932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NsuhDE2lCBX0C+v7XFYeUSjsuQe+gfuikfjn1Rn3dZw=;
 b=UYL1Gw2yEec8JjNUaF1Ghzh9V9rtX0hqZ9n2oTuU5rXqUHxIDeROvwkNaSOzc+vX+o
 YIOB31Epbh5qS7Z6Xud8/VsF7CrCU/rl+myw27xNKFI597ujeRpZEkgddIoyb9bbtNDl
 gDgAbz7NMn9Bk6z8UepzPsaPQzApiJv+W25PejgbaZv3VkUk6kAVOmKNJY38hYZkniTw
 TUEW+VrkMqN5W5nFdoT7A9gkgI7S3kq2fU+kSub8KIcF+hD1aHSRcU6zZ7k1BxdoVF+7
 ET13k3GRrkNOnLeFwWVAVytTQXoFAtVjBX9rvmER6K85PIme0s+WsR7JyhFinwQy5j0L
 C9RQ==
X-Gm-Message-State: AOJu0YyqJ1rS8sqiFEm4Ne/zD/r23TiQKrQEFqat5WZPu0LGbjbRJEui
 K4ERbOypaZD/pp5PMBSBK53dhguVo6TLQv06EBsXecQmbkGbQnEu+WXTCdYPY0QdEl41vp8Y9B0
 N2JuA/YTJyA==
X-Gm-Gg: ASbGncvLYG7pV1DrL/n2qMFNKrUjTMIS5yDla6NG6XzuBvWklfXX2IklIlKE+TwwUmT
 u72KCKIu18EYeloW5Db7+5/XjzEIozxx4aJGgngprYnXWDVoCgB2fDG9aDARGcq83kxAO5Tvb+p
 013KgNPxJBmZOEowbk9xn7U0X12OzFNe8VxrVNzpJ5EEWR0R1x3vYKYWIpxKodtWPCS45eQE1r5
 a75pkbukt60ElNgqEfzl9Roe87Y8tqzPYK/sO4GIHoyOS/w9Jf2ggHyKb7xOfijGVmvBf/jRSns
 hPfan8/JpaI1vGDjPPTbPLmdVyHA8fx4A/Syd/nSmKZ94mksT28bgS8DYijIVAvzk0PJCM5ZA48
 QX/kI6dzSX2ZC+dh9lp7sfCDnfXEEKXewBqpb/SSWzTyCYzGoxYUYwny1TGR5MKTCJxsy4HwT1v
 vALzzg5CZedeNgsDkovQCXVrT2kGkqPtJ8C6p0WFub06H52XnRU8cOLGBZEXLoy4k=
X-Google-Smtp-Source: AGHT+IGbjqfJpo6kaaL6JwrI+f5rz4xehtditoRoEmG9EZxI/P8AMokzTHM4VCZkId+zhnXZhbg+Ug==
X-Received: by 2002:a05:6820:60d:b0:657:5202:4655 with SMTP id
 006d021491bc7-65752024cb0mr5033582eaf.8.1763564131809; 
 Wed, 19 Nov 2025 06:55:31 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65724cb873dsm6366340eaf.4.2025.11.19.06.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mingkai Hu <mingkai.hu@nxp.com>
Subject: [PATCH] ls1043a: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:55:30 -0600
Message-ID: <20251119145530.843331-1-trini@konsulko.com>
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Mingkai Hu <mingkai.hu@nxp.com>
---
 include/configs/ls1043a_common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/ls1043a_common.h b/include/configs/ls1043a_common.h
index a02c752bbcf9..4c695388d2f7 100644
--- a/include/configs/ls1043a_common.h
+++ b/include/configs/ls1043a_common.h
@@ -90,7 +90,6 @@
 /* Initial environment variables */
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"hwconfig=fsl_ddr:bank_intlv=auto\0"	\
-	"fdt_high=0xffffffffffffffff\0"		\
 	"initrd_high=0xffffffffffffffff\0"	\
 	"kernel_addr=0x61000000\0"		\
 	"scriptaddr=0x80000000\0"		\
-- 
2.43.0

