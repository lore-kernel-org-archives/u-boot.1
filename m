Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154BBCEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A6583F7B;
	Tue, 18 Nov 2025 19:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fXzbH9WL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 576F083F75; Tue, 18 Nov 2025 19:04:18 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FA8B83F64
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4507605e19aso2862923b6e.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489055; x=1764093855; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3HATHqWy4Y6SegMonlShnB2E6oCALZDfXOm1f+Ji5w4=;
 b=fXzbH9WLPxqkHsSYvMDODJjmw7lmVWZvJvP1ig2wd4f7xV0M8e5RucymwvJYEKEL+O
 JqqXdnkrq7FfP8uu1buaSxUAMjd6xpZ6Lw6Zf604wngwPqB7a2cJlT4m6CRYwmzk3jUj
 up7C612pzvT4ev0Wgn2XZYhkHpKGerS9WhUTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489055; x=1764093855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HATHqWy4Y6SegMonlShnB2E6oCALZDfXOm1f+Ji5w4=;
 b=UNNP0fVVe1HcmCGK/UZhXNTdykdPvHbEq7/lpc56/NgbaSQhVcBRtb4YnMKhWgR/Bn
 tM8LQyDinKIAQsRZDSOz36NK8OwR/K2Do9p7+dhJDAZuOfVNo/BgTG97cWAPe0dpTlCl
 qEaM2jSFLARJFuWXU0ROnY2tYSG+FpXCgnQPKiel2YPqbr5kZvDBD8d/kymy1sFZepKO
 MvapfkH/cO8Jlf7b11KURCKXx5TmJTTTbcVur6DikhVGbv2Hkp2HVTyLpw++Ck1+RC19
 L9tGttryLXQ+fsRQ7gsG0m8Gq5feKmLF8/PpyrwDjsQFqqh4oYrn8Rdckw1KIeUMmpS5
 jCsg==
X-Gm-Message-State: AOJu0YwAqDykJ4uidMbQ90rU6sIIYtCOaRDC9ACgF/Q34TzFe3dJczTT
 Rd4nwDmtwSZntCWw4oV9/DUx8eNcB0On88LiNYzgX8x4A/uHj8oYttOD1w8WuZvpkk7ZED8ewP7
 1PptuK1efhQ==
X-Gm-Gg: ASbGnctMdD84iHJOaaQzQNdkldpoLjeewkrKIPzeKN7RufQg7YwWNykZjPfw5xta+mO
 Q1drBLMgKFcZNRCt4VFLumjCbr0//t1ZzKfiSXoedkEwgkkL9IW87yRT6INvkjTmKZ3nCH2JYFp
 kikngarZJSbLbtXRLgqQZaM3xy55IytKalIfFpicAhdbcAxyixblHdzXYVLG6W+mD0BVJ9vBbUm
 yKdLHIU23e3IQHDCwvX9NCr/obJfX6e4QA1U0rFdOfDlyEVqIRa8kA9fDmMFbT5EpTUr+CezvuR
 a7Oq6tD+mf/8Lci04txskhOqLa/R12kp0bBOaMrGWipSp6FnLtGpxveVh0pGMomJOFCkFJqdo+c
 f6rthEoKNwJCiEsSVRPheiU5Tlo9bpUpiHcaJB7b06qxhil1ND8rlYU6rAu2I4RgpcBW0P5CNzY
 u60xVjjAEmy11si6MpdFnuYswz7VnE3POlGLoH6EYu5lo2N9oybdD/kphxtsnACWQ=
X-Google-Smtp-Source: AGHT+IFvpW0ewg7t5tGJTfDIZ7LMpKLxQ7gMdAXoMbGlnARbDrxOlYXYfnTOd44TLF5fG+fj8bnG3A==
X-Received: by 2002:a05:6808:4f09:b0:450:3124:53b7 with SMTP id
 5614622812f47-4509762a5cdmr8711316b6e.67.1763489054829; 
 Tue, 18 Nov 2025 10:04:14 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450d8c0e116sm1339486b6e.2.2025.11.18.10.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mx6sxsabreauto: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:13 -0600
Message-ID: <20251118180413.591224-1-trini@konsulko.com>
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
 include/configs/mx6sxsabreauto.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/mx6sxsabreauto.h b/include/configs/mx6sxsabreauto.h
index 36d82e81d5dd..db8d483ad720 100644
--- a/include/configs/mx6sxsabreauto.h
+++ b/include/configs/mx6sxsabreauto.h
@@ -16,7 +16,6 @@
 	"script=boot.scr\0" \
 	"image=zImage\0" \
 	"console=ttymxc0\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdt_file=imx6sx-sabreauto.dtb\0" \
 	"fdt_addr=0x88000000\0" \
-- 
2.43.0

