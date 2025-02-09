Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80739C0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:18:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C368280F42;
	Sun,  9 Feb 2025 22:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DZVutRPf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04CE980F10; Sun,  9 Feb 2025 22:16:30 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D94D880C96
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d149f4c64aso5890015ab.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135786; x=1739740586; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbFn3MU4jVMjGC7YHzPt3OZfzVewvOMWKo7OVkCpKfw=;
 b=DZVutRPfFwgTNiYwcqqiq1RD0bdhtiOLO3PBrq6ZkSUnACK5EXhhfPnTnmsLTBgcLa
 teOE2J9Io+NoGCG+u+1TP7gR8275KYYfyegRahdeDF3a7inPZbS3+z8TsZDcP04P2EG5
 vYGwQG4VRQKB/TTPhXt04GJKv7aI1ZKYaI7tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135786; x=1739740586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nbFn3MU4jVMjGC7YHzPt3OZfzVewvOMWKo7OVkCpKfw=;
 b=XP+QoSzJ2ATSMBcPqDdb7SOzEr6UkCy7hrHyIv3gYP7YeTafbD7mvesLYHvTZ6rd6U
 zxoUqsnIbO4loXx9vNlaENbET8E8Y33nV76wn3pIQbehqfg33/9W0xH5+IWj2abzWPBi
 2JWyaHceuVA9XkYDEZRZZAWMCkbr5ZKtQGAfdXbd2y+cxBRdYRpcS6104TvTemZOAqCq
 /lgkHWtRdAnIQkg0yuIVSa8VQlDGBgK+aOZliv8HlAH4iz4FVwADMQlPK6LnBp49FAhS
 Xuro39j0GiLC7YM/OCYfdyFNbNlZwHGK9aBck6GmnD80+8SLcA+/VCyG+Lyh7FPTjPM1
 Eclg==
X-Gm-Message-State: AOJu0Yw4LoRbr3KMRYy4cq4WVrc2e6NwlLVnNxoL9PtTq29qhdufambX
 MJ1qLh1llwL8siWD2oRAZau6dVnrqtjJ5mcMxdRsRPz/Opg5ajYw4hPr5Nis1bNNwJfvj9yhLlc
 =
X-Gm-Gg: ASbGncvKlcgl6QCTBTR5rAj+nsGjoRspNak0mssHSekPZ1M+3yuLenP65uKax+hyTtt
 8LQrXnhziJUggcdo87Xefjy1xfrBkJpEs7jtBgEAV3eyk5S8rsNkMl4POomHwTUy9MXNyD87rk8
 cEJZhAUpMp7xGzw5AFeoKxph+OpGRX477jXhk9W0D8mpLBGWNfathNJU5OfkGh2297/FSz/p5Gd
 nq3Rhi4JYMmT8BFdTCZqLXKze76qouee6Loq8JulyM3L4YSsyMV6RxPqboGPs8s3UZLcgpQvkwD
 Em3hmPrMctZymXshmcjm3sTaG99WNJ4dIKeBEbiGYjBW0n+HXZKJ
X-Google-Smtp-Source: AGHT+IFzTfTbQP2cNAyEvtaBLMQ4yLp3O4gW6NcCfBvgzjAaZZkNnLSQLq9fb4iM6fpUbxH8tfBysg==
X-Received: by 2002:a05:6e02:1b0e:b0:3cf:cac9:b02d with SMTP id
 e9e14a558f8ab-3d13dd609b2mr86101615ab.8.1739135785816; 
 Sun, 09 Feb 2025 13:16:25 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:16:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 25/35] rockchip: rk3399: Adjust initial TPL-stack to match
 SPL
Date: Sun,  9 Feb 2025 14:14:46 -0700
Message-ID: <20250209211502.2299245-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

There doesn't seem to be a good reason to use a different value for TPL
than SPL. Change the TPL value, since it allows a 256-byte bloblist to
be safely located above the stack in all phases.

Note that for most boards, SDRAM init happens in TPL so the SPL stack
ends up in DRAM, at address CONFIG_SPL_STACK_R_ADDR.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Reword commit to mention comments from Jonas

 arch/arm/mach-rockchip/rk3399/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
index fc55b498111..8064b6286fc 100644
--- a/arch/arm/mach-rockchip/rk3399/Kconfig
+++ b/arch/arm/mach-rockchip/rk3399/Kconfig
@@ -159,7 +159,7 @@ config TPL_LDSCRIPT
 	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
 
 config TPL_STACK
-        default 0xff8effff
+        default 0xff8eff00
 
 config TPL_TEXT_BASE
         default 0xff8c2000
-- 
2.43.0

