Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D708C36002
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 23:22:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B88DB81CAF;
	Sat, 22 Mar 2025 00:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="D+3GDE2o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42EA1806FC; Sat, 22 Mar 2025 00:21:46 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10B4C81CFD
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 00:21:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7DBF83F71D
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 23:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1742599301;
 bh=f9a7Sy5kWdN1fXy3uxWWcYsSDQ5H3IHh1DhwaiSJnK0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=D+3GDE2oI1ZlA5TPPZ92E0MMcX4z5pQU4KGmYZJnJ6UJjwmsfKkuGFydTa1tMnfoe
 EqhzssXN8ZeZlmtv5RAMage8FXDR/wClGIuVt/Wqlq0yLmr/TLxuxlzxlrhNNHfPnL
 8BNmZujnSOklfMiVGivkE25pYVqVU45NyahZwqdVAHHK2Kv+qDEnJw4lHZtDYNoIw8
 +Hc4GWRu6tn5HMgmd91gcoGxUEbs4O6+9eaF6s86IqzShlraV9XTx3fUdrSyyNEDWz
 XSqp5Ap00k3zj4BXsunJaT6Zco4+2b1QfQqWNAdcvZZVVMrZnQMTKE+b1NXAJHI4t3
 Rw6KdzZPsdipg==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac2aa3513ccso211414266b.0
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 16:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742599299; x=1743204099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f9a7Sy5kWdN1fXy3uxWWcYsSDQ5H3IHh1DhwaiSJnK0=;
 b=A6UncSGdjs4JHz0oVeENRc1w4YLcREj9uDH10nFlevCIfYcYQTvpZL/dPYib7FXbK0
 OTs5/ajlJsfZwmnCzvqIE5LaJ/DgKvUB/gttPbIn02hFGJtYplSjLNzj489PUUtRt08u
 Zy6TmDzc2IJJ9IkQ7yEeLWLEVbVxu6axNH9Ow+vH1+CAVcI8LL/dVFg5PvV7tw3MsI4H
 eoAqvwFRaiBFdFc+2Tsno60XvzXfKQzb2+Wr6uIO1mFikKCx49bkN+4VFOVUhE/WFyjm
 rjiqVDfprsmne8xJKYJdAJb+/RF69MAtaXJ3DbxmuHU6c/pBCUL1WxkYvLprsHYssRsK
 q05A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd1racZO/IhF/cGvLmlioxqJaAPDE+gw+HwlGP5X9MNhIz5ZslAl1SdHuY/bDDHbvK/HjtzRY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+0DELFSJFlbcKduItnFj+0p1Gg/Zyrxb5kg9sA2Iuq6CmEivE
 OBYaV5OO0hdGMCfqzwNjfPNeBs5N71rHMlHuYU2jY5oveNeeoAiI8vUh8KGTN+BzGkuBXeFbhZy
 sgzSBMoEYq91xBRQ/L/Sr+ho4aV6N7w5XgHlZJP17b9yoFFxFO2AKLC4ktg7FoeDIDVs=
X-Gm-Gg: ASbGncv9G/kxXachI0SJzjLMjaLB/E5VJkqzKsuHCFpKoTkl5VF3jsnC9YkZ2zUImdY
 4pDhiKZjClfszm+1R/K3KhaEGXFi0vn2DFYfegupu4Cpm6kwMQaVjBwWSouj1/2zDTYTST6bhjL
 5jBd4Wm0haPIyX4UPYXjRXiTNpGrf0HdE/HWdUm6Tg+VV/cHTeP1FQ7rNNyRn2h6l3bgXgMvdK0
 QTSoTZnt9S+YTz7PV3TbjBTRUTv8jbNvwNckzeNKBXPc87+omBcKwe4RpptbfoRof+AXmQE4Exb
 WgvUYiNR+kL1uJ0mr8TUxtf6TV/IRvd1+xM7o+THshxPiM+Q3rZgNnz4etJ9Msxq6c4UJtzNKQU
 ViITpypc52Of4avj/fQ==
X-Received: by 2002:a17:906:fe05:b0:ac2:55f2:f939 with SMTP id
 a640c23a62f3a-ac3f20d2534mr517285866b.6.1742599299590; 
 Fri, 21 Mar 2025 16:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9JgjL86OtGKFw3uhfnCYYyH+auRIEifqnCSuPp6z49+kPjh9hvr5Ph8XXcDqwrgrtF/TpHA==
X-Received: by 2002:a17:906:fe05:b0:ac2:55f2:f939 with SMTP id
 a640c23a62f3a-ac3f20d2534mr517284766b.6.1742599299199; 
 Fri, 21 Mar 2025 16:21:39 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efd3aa21sm231673866b.158.2025.03.21.16.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 16:21:38 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Fiona Klute <fiona.klute@gmx.de>, Martin Stolpe <martinstolpe@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/5] qemu-sbsa: simplify updating ACPI table header checksum
Date: Sat, 22 Mar 2025 00:21:19 +0100
Message-ID: <20250321232121.251800-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321232121.251800-1-heinrich.schuchardt@canonical.com>
References: <20250321232121.251800-1-heinrich.schuchardt@canonical.com>
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

Use acpi_update_checksum() to update table header.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/emulation/qemu-sbsa/acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/emulation/qemu-sbsa/acpi.c b/board/emulation/qemu-sbsa/acpi.c
index ba85e08fc7d..7e4c55cc818 100644
--- a/board/emulation/qemu-sbsa/acpi.c
+++ b/board/emulation/qemu-sbsa/acpi.c
@@ -133,7 +133,7 @@ static int sbsa_write_gtdt(struct acpi_ctx *ctx, const struct acpi_writer *entry
 	gtdt->cnt_read_base = 0xffffffffffffffff;
 
 	// FIXME: VirtualPL2Timer
-	header->checksum = table_compute_checksum(header, header->length);
+	acpi_update_checksum(header);
 
 	acpi_add_table(ctx, gtdt);
 
@@ -181,7 +181,7 @@ static int acpi_write_pptt(struct acpi_ctx *ctx, const struct acpi_writer *entry
 	}
 
 	header->length = ctx->current - ctx->tab_start;
-	header->checksum = table_compute_checksum(header, header->length);
+	acpi_update_checksum(header);
 
 	acpi_inc(ctx, header->length);
 	acpi_add_table(ctx, header);
-- 
2.48.1

