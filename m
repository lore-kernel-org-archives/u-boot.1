Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80A1CEE347
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA59183CB9;
	Tue, 18 Nov 2025 19:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HnuCE95N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5349583E0E; Tue, 18 Nov 2025 19:03:51 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E28B83CDF
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c6e815310aso3332502a34.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489027; x=1764093827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R5Bz4ZCazya++hXC+DgKDsyuCi+GyHRDkHhWd0idb0A=;
 b=HnuCE95NIAFQ6XfKqVHlAIzej3QTuHL+P0t/WP2TYK4UB5IWdh3vDDYiBcIW3sfQRk
 Vr++MLt8PdCLXNEMM9dY5xAA+0q576ef0jpaZwUla9l2xARWhfswjFdlqpYX0/a2Gbey
 qHX2pzeT7+zuyB1CBGTni78SRmKP5OaPiJGUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489027; x=1764093827;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R5Bz4ZCazya++hXC+DgKDsyuCi+GyHRDkHhWd0idb0A=;
 b=cA92nq1BMn4l0dThxiTXRMAoCsOd0GoLvjT9mrWJDKxKxtsmhJeBkigHjyEaVbhva6
 WcFiPwLb9mnsW8Bt7c6ajgJg9qSsYzXH0hVR5soY61WLi5KJhVRIHbgf46q8mayZBsYO
 ZaqJR0WwE8ZZBcFEGYC8q2Pvq0K8pCABl69QY01eU/FH5hGLMowyzfo+bhiT+BeihSff
 kYlc/FN+8FlESMnh/D1xEkqPSOv1oqYXpslqyxQZs+hTZ4hoPoMVkS9NS2uatKAi3WAf
 6/3UaSTXnTkdrJ9Whuies4trgg1AydxQd1Ol7aDDIfdeD4XoKwxgQp7+nX2HWC/2jFdm
 X6bQ==
X-Gm-Message-State: AOJu0Yy0q03LQV/LjE3tsqT8+owYcPmpybp2CyPv8dGi5wSi7A1ylR6g
 T2bD/yGsQdj358bKzPNoS//IRzO/fyr5dpxJLwkKSO+LxRJhV1Ua8lTUZafn7OohWVDHG4rs8MV
 idxXJToxhYg==
X-Gm-Gg: ASbGncsLQokqyVLBqPeNby7r7d0guxdOfHppvM3Q3hUuw9O7P0sjatzRc2UNtTLdR2L
 0XKDflUWQ1e3HWDUO2Zzn2DipewXxnbfxjmxlp4VTcnld6ERNbnKbTGzqsCLrFGUXxp/N0HwYbR
 TZzQaM/BeLJXTXWeZKfIbpZ/4/0fWin/L77ROwSxwZq54r7MNFO4NZjCcPCy/P6JWuXDmoWjnBe
 GtbVdy3TUqLSOkQwtGtrIcoebP9ZrHn7XhW07AGZdSL9zLCQ0Po//pCkNq+7vdJ/kzoO16OogB2
 mhfTo1ZKJvc4OvGKSkpDkIpiOUEZrnBxg9AnOgdbpRaRP3PnyPYPAq0zzdFUmQzOoUBy2FuZGKt
 VtjKD+ITl8o4JEZcBxfegcM0Z0hXm5dkL9xmgCbjBr4h2BwhZpCk2qR6hXeEJVHS4fj+lO7qbRj
 5pf2wts4zcyaeqmLeF2ysgYVK/WqM15+bWqkg1VyQwv+6zP09aFJ+2XrLpl6yn3/c=
X-Google-Smtp-Source: AGHT+IEpCD7WT8TruLfmVa2obK1aw47x0veWUuPPEZweUbLmzBeXw6C+Z+107Mw3ajPhEQVhl2rrtw==
X-Received: by 2002:a05:6870:31a9:b0:3ec:3a39:f4f9 with SMTP id
 586e51a60fabf-3ec3a39f896mr4819493fac.45.1763489027253; 
 Tue, 18 Nov 2025 10:03:47 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8522637e2sm1234557fac.12.2025.11.18.10.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:03:46 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] gw_ventana: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:03:45 -0600
Message-ID: <20251118180345.590913-1-trini@konsulko.com>
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

Cc: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/gw_ventana/gw_ventana.env | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/gateworks/gw_ventana/gw_ventana.env b/board/gateworks/gw_ventana/gw_ventana.env
index 9a316c74f215..4322baa3d8a2 100644
--- a/board/gateworks/gw_ventana/gw_ventana.env
+++ b/board/gateworks/gw_ventana/gw_ventana.env
@@ -13,7 +13,6 @@ hwconfig=_UNKNOWN_
 disk=0
 part=1
 
-fdt_high=0xffffffff
 fdt_addr=0x18000000
 initrd_high=0xffffffff
 fixfdt=fdt addr ${fdt_addr}
-- 
2.43.0

