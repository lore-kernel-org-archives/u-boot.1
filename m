Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153C8CCD1AA
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 20:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE9F6832BC;
	Tue, 21 Oct 2025 22:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mI7avxR4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00F968362A; Tue, 21 Oct 2025 22:28:34 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD458357F
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 22:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c280b71af9so1539775a34.2
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761078510; x=1761683310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdsVxrIOSP2RcBpdBWP2qs+a2LwmalB9QqgjR6sImg0=;
 b=mI7avxR4q4u6H5uoARkwER+lW3WzuoKCGe/Yw8XFyHhKBS4WAdcDaGELSkFBqUEVkR
 6FGLBDk62XDP1yI804C0K1M9MntsVw/6w18Be61XhnLaFlX913ouICTXDsk1Y+F07+vq
 tX5IE+zrAVgL4w+01fMVYXN+4Bn1in5zA0Mb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761078510; x=1761683310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdsVxrIOSP2RcBpdBWP2qs+a2LwmalB9QqgjR6sImg0=;
 b=OVunXxtRmqukMLZu46fgSw7fLt2S768xYmKA+qmS7Gyu6CRhnwexgGrcD6RMvqaVLO
 oCswrNgSz53a5izLjWdLaE/ptQhlVZJpF4laUNQbtuFmOCYfScvww0/rhwu4A92qkXho
 nUn2DqxbaffGWH8W80E3cAkqEPms8wgeHCxPaPeVnMBk1swahRCgwOZNOBmSil5qltZt
 tJWR9i9xgYH8V2zolU6k1WS1XBS/zY6FOH8BZEPMkIu6gh9911PayY5MaEKuqxrfEs7G
 YELxumh5hfJH1oQwfluqFlvdoe5cMGk4W1ppWhUOzFLcZA7rDgUkZelK/bqqOWvOymeq
 880g==
X-Gm-Message-State: AOJu0Yz0EpAX9zMuK0quEYSgLJiMKH+FlZyKHJpwD6h8kdIxVDdv/ONM
 /BLPx9iN22UX4PMkzUU3XHyKgEYD11XvvT2W0/mGEC0Y9Bh7EPfLC5m16LRrmNQtvkRjACSU9rq
 sb6dEH0THvA==
X-Gm-Gg: ASbGnculrC1fARpBkEKm8BSlkFloQU5ScJdaYe4cUCalMi9GpSekjM49Ks3q1AkLxBN
 difd93qR3+hqdfa/Wnbi/FFKeTe2lPOLYnr9YjIMtrS5G1aiT26zXniaf1/rGYaXBsTjvdbJufu
 d7xGDO5nx3ZyWqj/OzGlaL3ANCiNbnC4HZBOsjILYJfJvqsVRuyiqRkgEArSspMsuzNeWmqlVs+
 C8t4jXEmv44LMZ4OlAtml/LHb/K6FfjIC/IV31wi5oFo68OQqC4gu7qL/k6ru+8Cs4uKoWxHrPQ
 LWSfcMgWc1SWXn0804qaLQ0IuESv3ufMm9Hx5mLQIjTChdee7yEhCECFc9KxHpDZjZE/brjp2pT
 bFCsPR2Q4wijqk9oM9+eMxLPmfafre0/bO6gbEukZ+qtEHYOJ3wH8Ic2rbuZExonD8q+WlguiEB
 sUShytnj5AuqM+QJAiVY71vsq/m8867q35vsIKn4yErULpgIrRkusx
X-Google-Smtp-Source: AGHT+IEktSLDaKGnwyjWMfQVbUcQWlSrsjXTcRRB8y/niP5MpB+fA1zAMfoLCHAu+bkDlkb4kkhHjA==
X-Received: by 2002:a05:6830:3509:b0:7bd:1ae6:3283 with SMTP id
 46e09a7af769-7c27cac74e7mr11478284a34.14.1761078509797; 
 Tue, 21 Oct 2025 13:28:29 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c2888ef0besm3930194a34.20.2025.10.21.13.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 13:28:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 3/3] doc: seama: Reword return value section
Date: Tue, 21 Oct 2025 14:25:34 -0600
Message-ID: <20251021202820.1272414-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021202820.1272414-1-trini@konsulko.com>
References: <20251021202820.1272414-1-trini@konsulko.com>
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

With the addition of general text about how the return value is handled,
reference that while retaining the additional information about setting
$seama_image_size

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/usage/cmd/seama.rst | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/doc/usage/cmd/seama.rst b/doc/usage/cmd/seama.rst
index 17fd559f4856..a6b00f32902e 100644
--- a/doc/usage/cmd/seama.rst
+++ b/doc/usage/cmd/seama.rst
@@ -56,8 +56,5 @@ The command is available if CONFIG_CMD_SEAMA=y.
 Return value
 ------------
 
-The return value $? is set 0 (true) if the loading is succefull, and
-is set to 1 (false) in case of error.
-
-The environment variable $seama_image_size is set to the size of the
-loaded SEAMA image.
+Along with the general rules for setting $?, the environment variable
+$seama_image_size is set to the size of the loaded SEAMA image.
-- 
2.43.0

