Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C62DF8A146
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E25B84255;
	Thu, 16 Apr 2026 11:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="aBHHqn0c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 983DC8424E; Thu, 16 Apr 2026 11:40:14 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C56A0841F2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c796163fac5so810380a12.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776332410; x=1776937210; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ABruZ3ZbqOSnUcOYAdObjBhiLcgjSWJFzQuTH+BSauk=;
 b=aBHHqn0cRhbyV/7LZOfz77r2YbO6YXVwX9fhwMorEgXuYA8Xcvlxmi2S9kOKoKgLAS
 NEBz/RkNbu/BSWIu4zw5AOEw+bMBt3Cbu7t/V4u2iMZGDwe/5g4Lm/OywYkVJe3pEZRk
 Uh8+anVIn9v3kpDqM5Mhwc8M1bETrLmVTYQ88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776332410; x=1776937210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ABruZ3ZbqOSnUcOYAdObjBhiLcgjSWJFzQuTH+BSauk=;
 b=ox4e6QOYVwHw+TFVdQ2BxGPGJdlwgk/qdYd1PTFN8+2J6Yb6N3EbSk/manpczbm1AA
 FYdGhWG2kZAhIdM1PfSKJocIyfC94569NQZV6byPvFb71WTqJQGyhIZ6ImuY2OlL4MlJ
 Dznwtf2OKkBD+xd0BqIdEENUm/PcJ/NyB7q2KU3lGY3NU7ZvnPeIsgrCHNoh8jnSNyEv
 icsO1nR1ydtP7NG3AhsYwTksy8xWdcrPrdg4Aktdi3D0xeUfAN3cNvkMvixJCpBR6MKb
 M4b50foQ0hmtNS9hWVKey5QrLEpeckBue1cpylIbTnoEopXozpBFJRrhX91u9rhq7XQ/
 iQAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jwuvGkjn/5WC8t+w5K7UgZt2pux8td5z8FJVXWrgFaLGG8BnqU69cHpI26w7KbItVZosZD/A=@lists.denx.de
X-Gm-Message-State: AOJu0YyLGYlW09Tl1s5SJGdxmxV2swEbZrRl/RVeOOVU+qEKt3+Le7lh
 QJ/OliMY9kwn1H8FBReFAglYqBvgdRxujhbD8xGo053+AcWTNLz9AJqnr9KtkmKZxno=
X-Gm-Gg: AeBDiest3Ngu1QoQIishQM2UJYEBqrNvnw1JYLsuS+LqCy2aXUiJygzrvxQWBKeNN40
 95o04WIwHpO8UeZZ97rXc7QZmhCubLWL8Y0H0e58GIlWRqubrC7RPDaHJ8veXrni/6DVquxGOGz
 f96aGOXg2WxQoJVSbtIKVHr0jQh295ikigjSXCvileGrSGoDbdGzbtp2446hSmXxQ1uI8jBEmhI
 B0wJUT+BZwE6eJjOL092Vjhf3Wpungw2i8CqfylNX/uOz4waeG7UETQqKpLlFzq98OBp7qeuWi9
 EqXQlmY7hzWA4MQIa2ukbuuMwsgFA9dcM35VCOAzM46u9oepT38q4ogq2MRxPcWMV88rminTSvZ
 YrTSK8n+m8/LNHh75SIjalxedgl37cP1+elJud0HpyZf7++cgk108XApInd4RjmHd5pw8IiGCSC
 Rc7TxUjIAx8H2+JkUNujebN9qPgXuGgfRvbh6waFUBOjHmIWmm0VYbiUpU37CVpWNNlYpgzaxyk
 b25w527xskj5w==
X-Received: by 2002:a05:6a20:3d11:b0:39f:8aaa:face with SMTP id
 adf61e73a8af0-39fe3c797dcmr27827055637.1.1776332410273; 
 Thu, 16 Apr 2026 02:40:10 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1329195-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [114.145.5.195])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c79581a2fc2sm4423568a12.21.2026.04.16.02.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:40:09 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 6/8] virtio: cmd: Depend on VIRTIO_BLK
Date: Thu, 16 Apr 2026 18:39:25 +0900
Message-ID: <20260416093927.602613-7-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260416093927.602613-1-daniel@thingy.jp>
References: <20260416093927.602613-1-daniel@thingy.jp>
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

The virtio command is calling virtio blk functions but currently
depends on CONFIG_VIRTIO only. This means disabling CONFIG_VIRTIO_BLK
causes the final link to fail.

Since CONFIG_VIRTIO_BLK depends on CONFIG_VIRTIO switch to depending
on just CONFIG_VIRTIO_BLK

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Angelo Dureghello <angelo@kernel-space.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 cmd/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 9b8a13c34469..1395247b0d65 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1863,8 +1863,8 @@ config CMD_PVBLOCK
 
 config CMD_VIRTIO
 	bool "virtio"
-	depends on VIRTIO
-	default y if VIRTIO
+	depends on VIRTIO_BLK
+	default y if VIRTIO_BLK
 	help
 	  VirtIO block device support
 
-- 
2.51.0

