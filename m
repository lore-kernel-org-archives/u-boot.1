Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD61D2069A
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2280A88DF4;
	Wed, 16 Oct 2024 08:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="SkObIeJX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB4DC88F6C; Wed, 16 Oct 2024 08:13:44 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D786388F3D
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9a0f198d38so475255066b.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729059222; x=1729664022; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
 b=SkObIeJXxFoBY2oVBGYwUUwyxh11Lxl2iPFxA5HJLU9NpClkhpEvIyt3qI9GzV7Lsf
 RlIDQOWwWaKWaAtXhUQZdN2Q6XDNzDnF+bjBSrG9Z1ZdjZSwQhwaqRNsmUC8h/z1lKuY
 FwBispxexxsKqDJuJM5xTbrZzUXcyWcMwryWP6c1Xam+xfzaQsh0hqg1GsXeZVLN4aw+
 8HklP2GHtBd8c8aNELV/B6A5eTJWYkd8p4FurzaUYR1uN+G+yMlE3zsf5LUWOQScnnWb
 MSETXenlC9s0lLssTeiLrUOnGXtbyb8vWYoGtTCO38PgmaSkj4excVUkmwikrcb9aXZE
 eDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729059222; x=1729664022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
 b=vaD/AH4uNqQDySZNdu/8mZ+av7Tpa1aBYfjg9dEOEF5uDd0DAFpKaw3vVfy4dXCCxm
 gA0Gt3BSu7GSbrro9ZjDEcMKi9yf+BMhb8kfe/K1M5QKDgvqL2HwAPXFIpqou8LhwQ49
 NdFHl49QCbnLvTtvchl0Gk8izH4cdpogYb0p+t6+73hV7Uonl47D7MubyFmUeqIz2R1K
 nGqU5IUNbZMRlIqa0paqpJ0ps6Fv1/ur76ZiChXd06wt7SGiEdMgMmbZVwDRLSkuDhvl
 ltVB47/cQOWGD1+A6CJsSWEpd0hlHG9e46Na626/IJizlUUbfrpC/cWTA5+KOga3dy+S
 lGLw==
X-Gm-Message-State: AOJu0YyKdpFUeEqhdppEWQiKXvgtDO+9edoQbOUZnFftKRA3zCdzuU7t
 6DW5tZmRWkhwAbewXcj1uJexJkr8OYMUfIzbzklfPQH3BzvnAB8rZ1oJI2noBnK+N8guiHmtuLE
 i
X-Google-Smtp-Source: AGHT+IHgOyv9Fue2XHIrLmyQiCMmzbnRByx6LLM1OmvFY96miMvecbdf6FZuLlE6xeqz5Ti+WqJ5TQ==
X-Received: by 2002:a17:907:c087:b0:a9a:1c19:4303 with SMTP id
 a640c23a62f3a-a9a1c195d08mr551706166b.63.1729059222342; 
 Tue, 15 Oct 2024 23:13:42 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 23:13:42 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 35/37] bloblist: Fix use of uninitialized variable
Date: Wed, 16 Oct 2024 08:04:21 +0200
Message-ID: <20241016060523.888804-36-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
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

Initialize addr to zero which allows to build on the CI
which is more strict.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/bloblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 2008ab4d25..cf1a3b8b62 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -499,7 +499,7 @@ int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
 	int ret = -ENOENT;
-	ulong addr, size;
+	ulong addr = 0, size;
 	/*
 	 * If U-Boot is not in the first phase, an existing bloblist must be
 	 * at a fixed address.
-- 
2.46.2

