Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7D8CEE347
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADF5D83F60;
	Tue, 18 Nov 2025 19:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L/MdY57A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFB1483F8A; Tue, 18 Nov 2025 19:04:22 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD91B83DA6
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-450c65f3510so1021678b6e.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489059; x=1764093859; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jBH8pAdNRlvIO8VhKwiUqjTMqb6Gpu2lCTWXAuaLC1w=;
 b=L/MdY57ATIvwqxp1k+oLOnJ/hfl736c6H3MKInsFiDggsRbtpAgUM213QgjodpYvgs
 Z7l3QDez4R2h0QMCN7rNNsO/ql/rNVsDM+JzxstpHQ1oXvWCJr5XYF80qY3y7G9BaKD8
 ATYooRD9HCvDGtk/4aA/MdzawkjdSodGot1LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489059; x=1764093859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBH8pAdNRlvIO8VhKwiUqjTMqb6Gpu2lCTWXAuaLC1w=;
 b=sJ1+86KzxQdrPvWvDmtxSw2vUq58fjJZsbRx3baZmxD5ETdMRzg94r16TYWGAFVayF
 Rk1gOVJNdCQgCnlMwuVTJLQIIkmsmvCQsObgG89XX4/+9YIFNkWjM+ozZ+M5FoOWoizD
 I648+cKV18akakJYMFWjxUqRDF+Pma4MuRjyt2/Rj+YRcNamcLJNtc85OD8Mt44Zk7ax
 GYKMKBABEK0+0DhdkXbvYyk28E2Yy6IGqZtrR2WI9F1qWjebnpjM7yo1AuUnVuJX628A
 Vg9/kZj5zICMxDQofiZA+2mkje5GwHMiIgWeVRmCySTyQck0vjgZRNreXwEUiG3aU96z
 xuKw==
X-Gm-Message-State: AOJu0YwP9iX/OQvmY6r8UFfOk2gpgOvONMX/4m39xAx5IUM/1mLqF5aQ
 AE42zR8JISy+kTdKmEDSkU+riscmpudSny/UVzqWlIMV3G8/giy6lYBJXavyGG+sbtIYivxHD58
 UXBoFht5l2Q==
X-Gm-Gg: ASbGncuxD8LRQBtgvp8+NguJL6bjrJS5ykE54UDwi1w01LG4ECtAYDdQGsYTbvTmU/t
 PtWje3Gnej6Q2/o+1oePOgVPwyf4MJZk6McQ1VrHf8fd0LO+7zI4uTE2jq+EdWGDxaC1LJEK7JT
 yOvZdc7SLIG0wGFXKK/aUxcNiFog8IriF4PQkasSe78bPvm2Lob5meB+65EaAycaHBdoWbJbw2o
 6SeGhUVDuqXuVyyDkXmKI0H02WiSEzODKdASZBCdw/2uc9n+UN0DCrx8bAvvuB4o9clEfE/pJf1
 tpMyhrD3zPaxohWtn4jhH7vy+n9dbtXhya1hBn44E0IE8aN8gzRRfTptLDgeUqlxFTiqUjz7M3m
 Vx+9m4JjAob07nBA6iD1NJWir7e3fQ073Q6plsUSkVKS+wXTTXePY1SjZ/iy/kErg3bGhEsKRrQ
 DLq+XboysRqS4gWCU5aDOR1FHB/aaxbctyLwLlpUiJ+Q+wK+XYp+jd
X-Google-Smtp-Source: AGHT+IG9YpfpaI3PStm6XXntghQmscAzvTYBGR86L+VU7VtYCh+zb9sckwcV2tnP5ssbY3U6RxPfOA==
X-Received: by 2002:a05:6808:10ce:b0:43f:61b6:2ab9 with SMTP id
 5614622812f47-450973fec6cmr8374988b6e.15.1763489059524; 
 Tue, 18 Nov 2025 10:04:19 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a553decsm5372979b6e.6.2025.11.18.10.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mx6ullevk: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:18 -0600
Message-ID: <20251118180418.591271-1-trini@konsulko.com>
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
 include/configs/mx6ullevk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/mx6ullevk.h b/include/configs/mx6ullevk.h
index 353267dddec8..88b535e1bd0c 100644
--- a/include/configs/mx6ullevk.h
+++ b/include/configs/mx6ullevk.h
@@ -27,7 +27,6 @@
 	"script=boot.scr\0" \
 	"image=zImage\0" \
 	"console=ttymxc0\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdt_file=undefined\0" \
 	"fdt_addr=0x83000000\0" \
-- 
2.43.0

