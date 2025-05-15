Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2594EC3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 087F282B95;
	Fri, 16 May 2025 01:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GlSC/59F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43B7E82B7E; Fri, 16 May 2025 01:42:25 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1778082B0F
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c7332128eso1084327a34.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352542; x=1747957342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfquPeOvMbxdRLMNyYx9ZNnYZsyjzDAYlLU1mhS+gxg=;
 b=GlSC/59F772Z0gjlpiXQesVY4LQJbi/3j0zvwVeLtX88GMRCY2cQ99rnVrtQTarMmX
 g5nVwyBextXwug9tEBytDrYRNKq9q8qbXbHD25y38DW4BUQAUSA7NYJkVjrQW447Q7Gy
 vFVAIrZsqDvJemFyOfQefWQ2fkTy2gtiYaM1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352542; x=1747957342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gfquPeOvMbxdRLMNyYx9ZNnYZsyjzDAYlLU1mhS+gxg=;
 b=bzJnTDsvgcYkxdDalhp0GNga5+KvlWVwaTqYYfrN3uXhaAnMEDHwpdIaIRzgoRu8ZN
 HdYdzcQqpWjgn0cJ6+ntPvRchP/XP8kwh+p8lh8AiIuzX2uUfz1Cgt6mgU7HjYl+iB7T
 nbuQG4c/b9Wh8trkrHToVspHNjXM982aqboFhzJhPU4V7pluFt0RALw2S1NXQs7RRX5i
 Dw5l0+2VY50Y2uvraPmLKqTbKDizw3RkRUdw+MBvsHgIWjjnl7y0wVJvikpWJ5NE0N7n
 jLFiofxcMSUuC7aq8IY9eE6WlfikHgl6I3/HdDeWAb5kmQCAqlmDFyH0y+k1zYYt+Mqw
 Bjeg==
X-Gm-Message-State: AOJu0YwnlvDsAs7agFdaMJj0f+2Nm/GR4jg5GXkjpL0CWOyYqMwhasj9
 Ge0G5JR+3Exkuoh3bYZKWUugyrUk/KDXrkuNyQfZ/fN1h2nMzTw1j8h9PFAzT6EIuG8HlgDX5EL
 JKEsmBIQ=
X-Gm-Gg: ASbGnctX3vx2pS7zKl4qi15OzonC9J7qjgRfVLToVI85VXPfB69+k7bV0h40ghWP72n
 dw+y6lu2K7LHgVJQvhgWsf9QaZhlnM9RAa/uHgYwTZ5NDzEVQ6Mtzs8ieZtdGTI8kC14115QMqm
 9cNlwDv2Td9o+HwWekFjhOwME6l7+oFIoFD8DYLqL6wwVwWmpXrrlbnoocokflRh0cEFxkIQq2c
 4BlztfY28PTxp/v+x/3JJJZION+uNCLzE4QStLeA4s+dEQHw5tsyBP6FSb3eO3upg8W5mmijwjq
 VTsdDh93Lpy66H1btjWZ/mQPzj08k7QldS/949xLXajPUxVIcmauk1gTg9//CBSPto6YiAiGdix
 x0iTyA5x2i1thxO0=
X-Google-Smtp-Source: AGHT+IEyeC/sOlahZahN7hb+iO/JYEWMzdvdypFDvGWp/xhNl28TqFP7LmszUs8hSsDf9ULmhT0pEA==
X-Received: by 2002:a05:6830:658d:b0:731:cac7:362f with SMTP id
 46e09a7af769-734f6ab3929mr1059991a34.6.1747352541893; 
 Thu, 15 May 2025 16:42:21 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 20/22] net: dc2114x: Include env.h to permit reading the
 environment
Date: Thu, 15 May 2025 17:31:49 -0600
Message-ID: <20250515234154.1859366-21-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

This file uses the environment but does not include the header file.
Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- None
---
 drivers/net/dc2114x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dc2114x.c b/drivers/net/dc2114x.c
index 7c0665faa8e1..8fa549280aac 100644
--- a/drivers/net/dc2114x.c
+++ b/drivers/net/dc2114x.c
@@ -3,6 +3,7 @@
 #include <asm/io.h>
 #include <cpu_func.h>
 #include <dm.h>
+#include <env.h>
 #include <malloc.h>
 #include <net.h>
 #include <netdev.h>
-- 
2.43.0

