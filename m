Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550C5CF34C0
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90DC683EF9;
	Wed, 19 Nov 2025 15:50:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gk9Yhrdj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C97183EF9; Wed, 19 Nov 2025 15:50:30 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EDB483968
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3ec4d494383so1798190fac.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763563827; x=1764168627; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TRdKySP2+JXz4aiRxtj1378gse8uGUhHfcJ3pbC3NmQ=;
 b=gk9YhrdjM1cK/Nj6IUqyJLuv5QMI6NMwptbl9c21F5HjtQCRLPclfli1Xm1xOYTs9+
 C5zD3BDsyqigrkxg2ATjCJ2WmG+agiVlZjQACWkNt4Wwrt9n3NZG8rSuH5L6Uzt3YMCy
 U1Qtd/TTMhZHAEMyNGbG95WhOgHI8PdaRsUkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763563827; x=1764168627;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRdKySP2+JXz4aiRxtj1378gse8uGUhHfcJ3pbC3NmQ=;
 b=IrkiqidOwvyRlUNN1WVWCnFc7YAkhXiTZGz7otY7JKo+t9iytWk4Jl6sZE05svYSma
 V7sQuEJXJ4bsPHy647Hhn4GbQLE/q65pPc1WKk/m3ycVm9JjtV6D3xHCERC+BGmAJQyN
 ygLTOit80623WLMAPWrOxbTKeE19QEHi56679ZRw5nuNjU5cICm093lR69hkQJTzVyOx
 sQ/9UNn6MSxExmBuDLWM2wFZeGxgd52r0maNu8K5GcbIDhv7O2DoxoQcVHIzj2HthgDG
 lPVL/bqUG3lNy5Yok1uiYyAnB+QVMr5Ma6ysZ1v0u2zt1T5SBUQ8LFm4PrhipYXdff+Q
 VG+g==
X-Gm-Message-State: AOJu0Ywd0VJdT8jySjSZXnidvU3BcSoUGn0m68HWxwuAkr5kBQfdUvA3
 ef4vaWOB3jDKGTCjGi/hTnsaSs6wvvUekx8RUK6lr0wguqtV9d//X9jh5y5bBW3puoQWIds2MUM
 QDUlIKfHLuQ==
X-Gm-Gg: ASbGnctgFPhCBDRE5stc0JULkXSluJ/9zmKPGlA7JUUvFiFfszkzVmlFApmtlaqPCZl
 vEVtd/kDgu+1eC37e1yfslF6Lb0ZxykvBaSnEFgKjIIZWBvpfqNsc46c6R0JGZwtAjPffwvyF6e
 k/SCw+i9zpeLNo0wSd0JvT88bsNz26DIFuV3lmPlSjy6sCy0y0CjiChsDcv/6uaCvw3aa6nUSei
 5ppxw8LgPC7Re9hIzZZEZPXHHCav1CnzUBfiV99hjcZQThvfRfJrd0mgAPVPWMexsvnKMf+kGDR
 rxj9WBYms9O7fanuVNCCosEb8Ohork4JTZ+k0NfMXLmYDysXCYqgAWtssXWH2ec0qJuzYwPadua
 0EsSdBJT2nbvXW3Y3IiHt40gSxfCJ9tTrIGisBC1iTOBXT2mGP1L5T3P4cuh6Msq/Q84f4V+UyU
 +5xBHkrELS+n7wLrqcxW2SYyvg3KhFBrCs7c9yCoF0wHLq+JEHnKqllpDmtlQ4zhM=
X-Google-Smtp-Source: AGHT+IHvaS7fYURibJrGadQ7eoRCsHg99MkPH/90Z4RdI2+RFjKMMd4Mcd0rOIaN6k896uYlJ5fV5A==
X-Received: by 2002:a05:6870:1b8f:b0:3d3:ce01:175d with SMTP id
 586e51a60fabf-3e8690f41e0mr11099440fac.40.1763563826933; 
 Wed, 19 Nov 2025 06:50:26 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8522ae6e2sm8048761fac.16.2025.11.19.06.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:50:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH] capricorn: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:50:25 -0600
Message-ID: <20251119145025.842054-1-trini@konsulko.com>
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

Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Walter Schweizer <walter.schweizer@siemens.com>
---
 board/siemens/capricorn/capricorn_default.env | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/siemens/capricorn/capricorn_default.env b/board/siemens/capricorn/capricorn_default.env
index 4c26e9d43eb5..c8b5b3d7da34 100644
--- a/board/siemens/capricorn/capricorn_default.env
+++ b/board/siemens/capricorn/capricorn_default.env
@@ -11,7 +11,6 @@ console=ttyLP2
 dtb_name_default=default
 ethprime=eth1
 fdt_addr=0x83000000
-fdt_high=0xffffffffffffffff
 flash_self=run mmc_boot
 flash_self_test=setenv testargs test loglevel=3 systemd.unit=test.target; run mmc_boot
 hostname=capricorn
-- 
2.43.0

