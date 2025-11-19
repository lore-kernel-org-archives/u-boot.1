Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76C3CF34C1
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6578983F8E;
	Wed, 19 Nov 2025 15:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hDtYD1qs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822E983FB2; Wed, 19 Nov 2025 15:55:27 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27D3183FA3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3ec4d494383so1801339fac.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564124; x=1764168924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zFeJKrHaehjcw+V+NNKUcqeddvP4HoW1NvgDo3TanpM=;
 b=hDtYD1qsPdJA5/5AMG375keyx+Tl9tEnu3zoPq3oDm1OLoj/hXKlch9ZMresQpHXsP
 pOAnEG0CSi6Gyq1Nk6enDXHywK8KhUOsbLyDmS+fVBUdqDf0U+3udM7UuFxZ0Ww1xa/b
 y615AV1yacpAAD/ZonYeB7k+CZXXlW9ENkfE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564124; x=1764168924;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFeJKrHaehjcw+V+NNKUcqeddvP4HoW1NvgDo3TanpM=;
 b=KVyK3a8Gv5Ty5ieY0k+ktiDjPNM3tKOk9l0WBDpwNpKzvmQen7LkVyw6MDvqImBZRM
 jLlWn4AitgoF5SyyL1s/oW1VDQyqcqWt3c5AKzIBSyY7VTx+TXv9DuQ+5IoLcf8F6tSt
 2ApV9jus6rfA4WTvll5sqgygsonLF4dmp9jBNrwgCSp9HFWIE/6Uw9theXtQdMEGyJVy
 tZPpbmGTWpSwYW+4oJUfvmgguXx1GlQlf3ee8IUEKeA4mZXkh7gRcOwKzg1k4+6/P8D+
 CG99q7X+2Ihu7hyXgAQ7L4XRzVoDf5LO0jebr4pFPwO1HEaFLzI3p3jwJKroHdKRh9jY
 ZIng==
X-Gm-Message-State: AOJu0YywmzrG3FlVg/LSlKYmmSN2f9THowAwY6xiuD55228C17jxgcQc
 KlB7ABjELZ9QwIXJ8/jx08ar61aOwrFFXVuA0Gg7o1ULNl7D12MuUeO6dlIt5RveEtgzM3Ex6X6
 /GS06Qx9seA==
X-Gm-Gg: ASbGncs5N3dxtviYM9QEnAEZexFxzY1TIY2l5w12zyoKA4Or91Sez5xE5adr2KL4lAy
 STNsGs+9/SKEvCmZPXC/B2jpDjdmXv8djuHukFqzBfNcRRpjGl/gFQnWL2GHzlEuOf+jZWCf/Yi
 w4ewdbZ2xXPZOjjED2g97uhw+c9FYNTILAK+kj548B49qz2ckKIOljFWv+Jf0ezBPsaUn/ZJyVU
 VOt4p3CoeHzuYSL8PcB2HCCirvjqGFVxq8wCNN4TNdEZ0dgCsQjet20tvN9XZjPYmGVmK8jBzvk
 k50NRGND9xSuGjo2VNU1oYLYLNvozl5GKBl2diKAOcykCH5GlO4fUjf3rE9P9ZuEfsmw8SI844a
 Ait+kuw959WOmTOBClou6YlzvVzCODmqhYvW4i8Xw5lyXJ8VIiq05YXfhM0NehW02vgGgd8Wc6f
 QMh8rK4Bv6d3aCsV4fPX/nUHHfObrVIT/JJpBADTkUR+qDnZqHD/hX
X-Google-Smtp-Source: AGHT+IGUAQagCArsCqvFTolnhp6MJcfnzIkq3Q5z4bC8cLHgZqXlpcSUStZYlHm2gUVfuZ5NFaU4Tg==
X-Received: by 2002:a05:6870:a706:b0:3e8:9096:a0fc with SMTP id
 586e51a60fabf-3e89096e8b5mr7806248fac.34.1763564123737; 
 Wed, 19 Nov 2025 06:55:23 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e851ffcdd8sm8344406fac.3.2025.11.19.06.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Thomas Fitzsimmons <fitzsim@fitzsim.org>
Subject: [PATCH] bcmstb: Make use of bootm_size rather than fdt_high
Date: Wed, 19 Nov 2025 08:55:22 -0600
Message-ID: <20251119145522.843213-1-trini@konsulko.com>
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
failure modes in the OS. However, this platform also has a large comment
block that explains that given previous stage loaders and other parts of
the memory map (that may not be in the device tree we see?), adjust this
to use bootm_size to restrict relocation to be below the CMA area and
update the comment to match.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
I've thought about this a bit, and if you really want to keep
fdt_high=0xffffffff here instead, the address passed along is 8-byte
aligned and I could see this being a legitimate user of the
functionality (we're in a restricted functionality area with a complex
map and incomplete information in our provided device trees). Thanks!

Cc: Thomas Fitzsimmons <fitzsim@fitzsim.org>
---
 include/configs/bcmstb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/configs/bcmstb.h b/include/configs/bcmstb.h
index c9280927b3cd..ca59c364cd74 100644
--- a/include/configs/bcmstb.h
+++ b/include/configs/bcmstb.h
@@ -71,8 +71,8 @@ extern phys_addr_t prior_stage_fdt_address;
  *
  * We want to keep the ramdisk and FDT in the FIT image in-place, to
  * accommodate stblinux's bmem and CMA regions.  To accomplish this,
- * we set initrd_high and fdt_high to 0xffffffff, and the load and
- * entry addresses of the FIT ramdisk entry to 0x0.
+ * we set initrd_high to 0xffffffff, bootm_size to 0x7000000 and the
+ * load and entry addresses of the FIT ramdisk entry to 0x0.
  *
  * Overwriting the prior stage bootloader causes memory instability,
  * so the compressed initramfs needs to fit between the load address
@@ -121,7 +121,7 @@ extern phys_addr_t prior_stage_fdt_address;
 #define CFG_EXTRA_ENV_SETTINGS					\
 	"fdtsaveaddr=" __stringify(CONFIG_SYS_FDT_SAVE_ADDRESS) "\0"	\
 	"initrd_high=0xffffffff\0"					\
-	"fdt_high=0xffffffff\0"
+	"bootm_size=0x7000000\0"
 
 /*
  * Set fdtaddr to prior stage-provided DTB in board_late_init, when
-- 
2.43.0

