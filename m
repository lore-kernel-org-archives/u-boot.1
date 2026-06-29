Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19112C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 23:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C3F284A0E;
	Tue, 30 Jun 2026 01:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pK8XP+0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4217884AAE; Tue, 30 Jun 2026 01:35:25 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E8A849FB
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 01:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 603303F5D9
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 23:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782776122;
 bh=IcCqxsAMkZZaXmYbKvmjDF+/7uJ/GlN/dw9w3eCCsOw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=pK8XP+0oZEaMXmDd+cm83D0b/ByEZzI4BM4ia/3TKMCf7ABDBpsBwpplSCJHtBl0F
 9LyqCboz9oXfpU7Bc6DebLoZA7DAE6mmw1ZQrtoAHWBLl8jMnz0wRbVplOuJAFymhG
 zERt1NS2NUwGXOOYAg5xxfiCO/P3vM8dRqwVP0MBOl07htgDWn4v/rHC7J39OVTXlQ
 aKa71/ITIP6PWobsZfP9x0MWcQ10ttaITW7D6ZCDVpsoUj6d8yUo86AKZdfz5D5qG9
 RF8g2SQB1XAURKCe2lqGLjoLfi/zS/wq3w1toYG3S7/JsGrwPsp/fbNeMuY2djHvwC
 U4+gfmABDXlmrEgjyoFro1c+qsjKyDFyVvRhFZzZiE6cdCZrZQZXFvj2mBdA03lwKQ
 ocpPvlTf6eFpAuqwkzT2ElYKj4NirF5sA6jyqZTf11bhjtxZficg8hbxTkFv8vcQxb
 zX2RExrpZJjyOXEdF+0FTHZATkW//yPA7GMUGe9uhaMtFzI7tph47ON+O3IIO21J8Y
 rXK/rkbh10LLQDPA1RaJvDzSDuibhJwvnpwGkqx8sJUZi5Uv7c8zDEKVTmmM0AJ5y1
 FVkedVprgr2k5xoFDaUXOBfLpkroZVbOh/JXeZLCKpowl2JjmHuXTtBLCGfa8m10FL
 iwWMuZlHsLV3XyM4wzzTA1Qk=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49243626f15so40385665e9.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 16:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782776122; x=1783380922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IcCqxsAMkZZaXmYbKvmjDF+/7uJ/GlN/dw9w3eCCsOw=;
 b=F0GttVNQc1KBdyrvGfQsm8mk6SiO14MlrrEd9WeblAAM75/rU6hhp7lsTq3Sgdjg9/
 c0B81pKrovPz4+U/01qsev64qF8A7FjvLmO13v4ZyDmDOHcH88kd7Sa0Zs9ejAZcerHM
 JWmrT8rCZArYS3krZjeu4BhYOqOknVCWBBHF+2y7cJgakejKJky19VyeJv6BusCMoaCh
 CSmk1dAyi97jFMc2iEjLOXvesti3SE80Hp6FCuBJPqH+Qfe5YO5CxK2YXHckENr3Ovy6
 XZsNqynZcHGhG3XIJ95WhAdBs4hyRwLwxLVzrMWJjX2oJPbr3WUuLCbpfpxQS+kEbpAk
 LMEg==
X-Gm-Message-State: AOJu0YyhW9C1rAoyZR+y/BNFa+pGIOXWXg8JSF5JXIn1aOT0cfWXcYQA
 /Hmvh9MOVEF5JpoeAggC4EQZy9Ub+1mzPM2q4cgNx8AvUJO/Vy/xcXyZrG31Okm1774M5V81qQa
 ePpakUbDUqI9mEIZA4a6Ns2YMS4zzRIZ1u5Tv49jkEzT1BvDMatVBUi6p1ZbWoEN8cwlYArMhZX
 4j9rc=
X-Gm-Gg: AfdE7cm+MZUVlQZpS0qLt0BtLKaQqHZraThheY33VPqOQfknIc905vpxwJ8Np44jp1n
 hKapnI8kDT6u40xv+zLlqNCnttkJpD9PsVit7bktneZJnmdsPQgZ74k50FO09swgO+ea7l/o+UQ
 Udrg7WMcCVzHU1tqM8xSQ+CpmrVISG2cZ60Y+WBW7VaQ9ghaJXKo1WUJrN/Xjnk33WzZN1jI4tS
 rBsuipcXREioLyKRKkLAXpH1QnJPqTDVz0M9CMwBVGKXa3jCIFAthni8TEOJk1xU3FBf8KvKjeg
 zOp+nzt+VoL2+ALcrPDYNVrKqz5Wctvyh4x5mNd547viX0ZTjrAReZ1XGPRb01ITVU3KqaCN6pC
 +Axgll0A+9sXdR0l5LG4JoqYAECxqgY8GYtDMsIh9M17kMVhkZJcSzRIuniUpXThrDQ==
X-Received: by 2002:a05:600c:c3c1:20b0:492:6447:7a7f with SMTP id
 5b1f17b1804b1-493b827fd66mr17431505e9.6.1782776121772; 
 Mon, 29 Jun 2026 16:35:21 -0700 (PDT)
X-Received: by 2002:a05:600c:c3c1:20b0:492:6447:7a7f with SMTP id
 5b1f17b1804b1-493b827fd66mr17431345e9.6.1782776121441; 
 Mon, 29 Jun 2026 16:35:21 -0700 (PDT)
Received: from workstation5 ([2a02:3035:626:ba8f:5998:4d02:a4c4:fa47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47566fe448dsm1968537f8f.27.2026.06.29.16.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 16:35:20 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/2] efi_loader: fix efi_sigstore_parse_siglist
Date: Tue, 30 Jun 2026 01:35:12 +0200
Message-ID: <20260629233514.211746-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

In efi_sigstore_parse_siglist() sigdata is allocated. But instead of an
allocation matching the size of sigdata, tainted external data was used
to calculate the allocation size. This may lead to buffer overflows.

Correct the allocation.

When malloc() fails for sig_data->data, sig_data is leaked.

Free sig_data before jumping to the error path.

v2:
	fix typo in patch 2 subject

Heinrich Schuchardt (2):
  efi_loader: fix buffer overrun in efi_sigstore_parse_siglist
  efi_loader: fix memory leak in efi_sigstore_parse_siglist

 lib/efi_loader/efi_signature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.53.0

