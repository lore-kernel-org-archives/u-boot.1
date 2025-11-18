Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644CECEE347
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B25A383F69;
	Tue, 18 Nov 2025 19:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K1kGXd2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6FC183F6A; Tue, 18 Nov 2025 19:04:16 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 900CC83F01
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c75a5cb752so1770798a34.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489053; x=1764093853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IGtd8ZqoLmuN6wh5zBXQ4deIjEnGrAkFPGjmA3Q43qQ=;
 b=K1kGXd2czG2uAjpWz4nh52VlZmTOtx7cnuyJHGQMbF3qFxcg59Q0TnpoUANYYDoGKg
 U53dWY73F8dvlEr3RoyfyYEPZq7+dx3HBWytQBq5dWf9sFVQHjEFgku87K955i+ZRGW8
 KzGwUvnGifyIPQwyzKmz3gP3gv9+Ny/RttSW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489053; x=1764093853;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGtd8ZqoLmuN6wh5zBXQ4deIjEnGrAkFPGjmA3Q43qQ=;
 b=eClMt/F8I3uKxcr7doADlOX73nj2SAbOZsG2wWQ1sORWxWssOMQNXx0eBQg45fdCEd
 jUjWO19q8O/Xuasce/hs0HyBDr0FEIl1Jr7urPUjkBVT4AI5QS1hK08j8ylnjP1SplqW
 oqNrpit4+ORqqzT/mqRjFhDkelqGeiIlXT4PfRLJzVsntc0LixXs/HZ5UjeL5rg4XJNv
 O4en7bpU3g8Rcg6uoq2jZPGB7xb3vxPQAFVl2LibBpcOa4EEhYJWC7uyF097g/YNdzcb
 Z9nA9y8TKV7gXu2b8RTAViSTvsuCcijG1uvnIdFLfjo0wWBAoWRg0s9H5lebxWvFXGHP
 1VGw==
X-Gm-Message-State: AOJu0YxrMTrodfRgWmE7zKEqQ8ffK69r7xE8WBzaHqct6GcHlAIyKJr3
 dcIyUivmMn9QDBZK3/P2Q2E3QdyTcdrMg9qSWNcDUGaf+eJNaG96TFhUB43uMdyWv1pmJp6sX01
 26ZizQ7/Bfg==
X-Gm-Gg: ASbGnctJLp3WtBMO0J/sEt9iOHFp6BtZ53XKt7kci7XlskGOD0KH84O8XB02YqNBV0h
 5J7aKz1ntK2TQbz2Pfqbg63H7+wM/4dAALwWeoR9efWHlekhbwmrvnxNCZrQIQJJfBXI1ORV3iS
 snK8i8//h/gAgdCP7Dcq3vwuP/6kp/RjRyDFFb4O4+1/iC5qnNY0IgawLF0DznGdtCu+qUuueyE
 Ol5WmbATaGnzuB2x+mag4/kQ+kQzd/mAhXS5yO3owp1FkOB34N6ExkQlsXAmo2HrXZlvovHStWh
 v2FnVIgZbM7wdXhup2FhENvH8XijWMKlRajj0xunLsilMhBiyq0MhA2I4SvoFaU5d2+6hxpXn9o
 NBBOwghfTBSGXpISdj4HPKQu1Qk12aYoPjomyktQbFujZwh6kkbZON1Ia9enxgbYJxCmIT86pit
 /S3CSzkmJCsXLTGqnzuZTuQ6qsbIFxNHwmoeQKrWMKvfkxJ/IQZ2VUseAIVe8gbcY=
X-Google-Smtp-Source: AGHT+IFjdRtU0x5Ki+qrn/Z+oN9QFjQGDeZXMTowaSxgCENk7SbPdkYqr8XI3QDru5blHh2+fnO/1g==
X-Received: by 2002:a05:6830:3116:b0:7c7:dff:2ac1 with SMTP id
 46e09a7af769-7c7442ae922mr10853497a34.3.1763489053307; 
 Tue, 18 Nov 2025 10:04:13 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a283a44sm6869202a34.2.2025.11.18.10.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mx6sllevk: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:12 -0600
Message-ID: <20251118180412.591209-1-trini@konsulko.com>
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

Cc: Peng Fan <peng.fan@nxp.com>
---
 include/configs/mx6sllevk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/mx6sllevk.h b/include/configs/mx6sllevk.h
index 1ffad5931c4d..38a7dd6061e2 100644
--- a/include/configs/mx6sllevk.h
+++ b/include/configs/mx6sllevk.h
@@ -17,7 +17,6 @@
 	"script=boot.scr\0" \
 	"image=zImage\0" \
 	"console=ttymxc0\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdt_file=imx6sll-evk.dtb\0" \
 	"fdt_addr=0x83000000\0" \
-- 
2.43.0

